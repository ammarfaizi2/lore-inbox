Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVBXPg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVBXPg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVBXPgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:36:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64913 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262376AbVBXP00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:26:26 -0500
Subject: [RFC][PATCH 2/3] Kdump: Elf core Header generation
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-NtvmNFPw5Fu6IAwtr7uS"
Organization: 
Message-Id: <1109261854.5148.817.camel@terminator.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Feb 2005 21:47:34 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NtvmNFPw5Fu6IAwtr7uS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-NtvmNFPw5Fu6IAwtr7uS
Content-Disposition: attachment; filename=kexec-tools-crashdump-elf-headers-x86.patch
Content-Type: text/plain; name=kexec-tools-crashdump-elf-headers-x86.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch does following.
* Creates a segment for storing elf headers.
* Creates Elf headers for dump capture.
* Functionality to modify command line internally. (Appending elfcorehdr= and
  user defined memory map, memap=exactmap). 
---

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN kexec/arch/i386/Makefile~kexec-tools-crashdump-elf-headers-x86 kexec/arch/i386/Makefile
--- kexec-tools-1.101/kexec/arch/i386/Makefile~kexec-tools-crashdump-elf-headers-x86	2005-02-24 18:55:53.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/Makefile	2005-02-24 18:55:53.000000000 +0530
@@ -9,3 +9,4 @@ KEXEC_C_SRCS+= kexec/arch/i386/kexec-mul
 KEXEC_C_SRCS+= kexec/arch/i386/kexec-beoboot-x86.c
 KEXEC_C_SRCS+= kexec/arch/i386/kexec-nbi.c
 KEXEC_C_SRCS+= kexec/arch/i386/x86-linux-setup.c
+KEXEC_C_SRCS+= kexec/arch/i386/crashdump-x86.c
diff -puN /dev/null kexec/arch/i386/crashdump-x86.c
--- /dev/null	2004-06-16 19:10:55.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.c	2005-02-24 19:47:16.000000000 +0530
@@ -0,0 +1,469 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Vivek Goyal (vgoyal@in.ibm.com)
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "kexec-x86.h"
+#include "crashdump-x86.h"
+#include <x86/x86-linux.h>
+
+#define MAX_LINE	160
+
+/* Stores a sorted list of RAM memory ranges for which to create elf headers.
+ * A separate program header is created for backup region */
+static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
+
+/* Memory region reserved for storing panic kernel and other data. */
+struct memory_range crash_reserved_mem;
+
+/* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
+ * create Elf headers. Keeping it separate from get_memory_ranges() as
+ * requirements are different in the case of normal kexec and crashdumps.
+ *
+ * Normal kexec needs to look at all of available physical memory irrespective
+ * of the fact how much of it is being used by currently running kernel.
+ * Crashdumps need to have access to memory regions actually being used by
+ * running  kernel. Expecting a different file/data structure than /proc/iomem
+ * to look into down the line. May be something like /proc/kernelmem or may
+ * be zone data structures exported from kernel.
+ */
+int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+{
+	const char iomem[]= "/proc/iomem";
+	int memory_ranges = 0;
+	char line[MAX_LINE];
+	FILE *fp;
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			iomem, strerror(errno));
+		return -1;
+	}
+	/* First entry is for first 640K region. Different bios report first
+	 * 640K in different manner hence hardcoding it */
+	crash_memory_range[0].start = 0x00000000;
+	crash_memory_range[0].end = 0x0009ffff;
+	crash_memory_range[0].type = RANGE_RAM;
+	memory_ranges++;
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		unsigned long long start, end;
+		char *str;
+		int type, consumed, count;
+		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
+			break;
+		count = sscanf(line, "%Lx-%Lx : %n",
+			&start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+#if 0
+		printf("%016Lx-%016Lx : %s",
+			start, end, str);
+#endif
+		/* Only Dumping memory of type System RAM. */
+		if (memcmp(str, "System RAM\n", 11) == 0) {
+			type = RANGE_RAM;
+		} else if (memcmp(str, "Crash kernel\n", 13) == 0) {
+				/* Reserved memory region. New kernel can
+				 * use this region to boot into. */
+				crash_reserved_mem.start = start;
+				crash_reserved_mem.end = end;
+				crash_reserved_mem.type = RANGE_RAM;
+				continue;
+		} else {
+			continue;
+		}
+		/* First 640K already registered */
+		if (start >= 0x00000000 && end <= 0x0009ffff)
+			continue;
+		crash_memory_range[memory_ranges].start = start;
+		crash_memory_range[memory_ranges].end = end;
+		crash_memory_range[memory_ranges].type = type;
+#if 0
+		printf("%016Lx-%016Lx : %s\n",
+			start, end, str);
+#endif
+		memory_ranges++;
+	}
+	fclose(fp);
+	*range = crash_memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+/* Adds a segment from list of memory regions which new kernel can use to
+ * boot. Segment start and end should be aligned to 1K boundary. */
+int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
+								size_t size)
+{
+	int i, j, nr_entries = 0, tidx = 0;
+	unsigned long long mstart, mend;
+
+	/* Do alignment check. */
+	if ((addr%1024) || (size%1024))
+		return -1;
+
+	/* Make sure at least one entry in list is free. */
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (!mstart  && !mend)
+			break;
+		else
+			nr_entries++;
+	}
+	if (nr_entries == CRASH_MAX_MEMMAP_NR) {
+		/* List if full */
+		return -1;
+	}
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (mstart == 0 && mend == 0) {
+			break;
+		}
+		if (mstart <= (addr+size-1) && mend >=addr) {
+			/* Overlapping region. */
+			return -1;
+		} else if (addr > mend) {
+			tidx = i+1;
+		}
+	}
+		/* Insert the memory region. */
+		for (j = nr_entries-1; j >= tidx; j--) {
+			memmap_p[j+1] = memmap_p[j];
+		}
+		memmap_p[tidx].start = addr;
+		memmap_p[tidx].end = addr + size - 1;
+#if 0
+	printf("Memmap after adding segment\n");
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (mstart == 0 && mend == 0) {
+			break;
+		}
+		printf("%016llx - %016llx\n",
+			mstart, mend);
+	}
+#endif
+	return 0;
+}
+
+/* Removes a segment from list of memory regions which new kernel can use to
+ * boot. Segment start and end should be aligned to 1K boundary. */
+int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
+								size_t size)
+{
+	int i, j, nr_entries = 0, tidx = -1, operation = 0;
+	unsigned long long mstart, mend;
+	struct memory_range temp_region;
+
+	/* Do alignment check. */
+	if ((addr%1024) || (size%1024))
+		return -1;
+	/* Make sure at least one entry in list is free. */
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (!mstart  && !mend)
+			break;
+		else
+			nr_entries++;
+	}
+	if (nr_entries == CRASH_MAX_MEMMAP_NR) {
+		/* List if full */
+		return -1;
+	}
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (mstart == 0 && mend == 0) {
+			/* Did not find the segment in the list. */
+			return -1;
+		}
+		if (mstart <= addr && mend >= (addr + size - 1)) {
+			if (mstart == addr && mend == (addr+size-1)) {
+				/* Exact match. Delete region */
+				operation = -1;
+				tidx = i;
+				break;
+			}
+			if (mstart != addr && mend != (addr+size-1)) {
+				/* Split in two */
+				memmap_p[i].end = addr - 1;
+				temp_region.start = addr + size;
+				temp_region.end = mend;
+				operation = 1;
+				tidx = i;
+				break;
+			}
+			/* No addition/deletion required. Adjust the existing.*/
+			if (mstart != addr) {
+				memmap_p[i].end = addr - 1;
+				break;
+			} else {
+				memmap_p[i].start = addr + size;
+				break;
+			}
+		}
+	}
+	if ((operation == 1) && tidx >=0) {
+		/* Insert the split memory region. */
+		for (j = nr_entries-1; j > tidx; j--) {
+			memmap_p[j+1] = memmap_p[j];
+		}
+		memmap_p[tidx+1] = temp_region;
+	}
+	if ((operation == -1) && tidx >=0) {
+		/* Delete the exact match memory region. */
+		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++) {
+			memmap_p[j-1] = memmap_p[j];
+		}
+		memmap_p[j-1].start = memmap_p[j-1].end = 0;
+	}
+#if 0
+	printf("Memmap after deleting segment\n");
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		mstart = memmap_p[i].start;
+		mend = memmap_p[i].end;
+		if (mstart == 0 && mend == 0) {
+			break;
+		}
+		printf("%016llx - %016llx\n",
+			mstart, mend);
+	}
+#endif
+	return 0;
+}
+
+/* Converts unsigned long to ascii string. */
+static void ultoa(unsigned long i, char *str)
+{
+	int j = 0, k;
+	char tmp;
+
+	do {
+		str[j++] = i % 10 + '0';
+	} while ((i /=10) > 0);
+	str[j] = '\0';
+
+	/* Reverse the string. */
+	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+		tmp = str[k];
+		str[k] = str[j];
+		str[j] = tmp;
+	}
+}
+
+/* Adds the appropriate memmap= options to command line, indicating the
+ * memory regions the new kernel can use to boot into. */
+int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
+{
+	int i, cmdlen, len, min_sizek = 100;
+	char str_mmap[256], str_tmp[20];
+
+	/* Exact map */
+	strcpy(str_mmap, " memmap=exactmap");
+	len = strlen(str_mmap);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str_mmap);
+
+	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
+		unsigned long startk, endk;
+		startk = (memmap_p[i].start/1024);
+		endk = ((memmap_p[i].end + 1)/1024);
+		if (!startk && !endk) {
+			/* All regions traversed. */
+			break;
+		}
+		/* A region is not worth adding if region size < 100K. It eats
+		 * up precious command line length. */
+		if ((endk - startk) < min_sizek)
+			continue;
+		strcpy (str_mmap, " memmap=");
+		ultoa((endk-startk), str_tmp);
+		strcat (str_mmap, str_tmp);
+		strcat (str_mmap, "K@");
+		ultoa(startk, str_tmp);
+		strcat (str_mmap, str_tmp);
+		strcat (str_mmap, "K");
+		len = strlen(str_mmap);
+		cmdlen = strlen(cmdline) + len;
+		if (cmdlen > (COMMAND_LINE_SIZE - 1))
+			die("Command line overflow\n");
+		strcat(cmdline, str_mmap);
+	}
+
+#if 0
+		printf("Command line after adding memmap\n");
+		printf("%s\n", cmdline);
+#endif
+	return 0;
+}
+
+/* Adds the elfcorehdr= command line parameter to command line. */
+int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
+{
+	int cmdlen, len;
+	char str[30], *ptr;
+
+	/* Passing in elfcorehdr=xxxK format. Saves space required in cmdline.
+	 * Ensure 1K alignment*/
+	if (addr%1024)
+		return -1;
+	addr = addr/1024;
+	ptr = str;
+	strcpy(str, " elfcorehdr=");
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+#if 0
+		printf("Command line after adding elfcorehdr\n");
+		printf("%s\n", cmdline);
+#endif
+	return 0;
+}
+
+/* Returns the virtual address of start of crash notes section. */
+static int get_crash_notes_section_addr(unsigned long *addr)
+{
+	const char crash_notes[]= "/sys/kernel/crash_notes";
+	char line[MAX_LINE];
+	FILE *fp;
+
+	fp = fopen(crash_notes, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			crash_notes, strerror(errno));
+		fprintf(stderr, "Try mounting sysfs\n");
+		return -1;
+	}
+
+	if (fgets(line, sizeof(line), fp) != 0) {
+		int count;
+		count = sscanf(line, "%lx", addr);
+		if (count != 1) {
+			*addr = 0;
+			return -1;
+		}
+#if 0
+		printf("crash_notes addr = %lx\n", *addr);
+#endif
+	}
+	return 0;
+}
+
+/* Prepares the crash memory elf headers and stores in supplied buffer. */
+int prepare_crash_memory_elf_headers(struct kexec_info *info, void *buf,
+					unsigned long size)
+{
+	Elf64_Ehdr *elf;
+	Elf64_Phdr *phdr;
+	int i;
+	char *bufp;
+	long int nr_cpus = 0;
+	unsigned long notes_addr, notes_offset;
+
+	bufp = (char*) buf;
+	/* Setup ELF Header*/
+	elf = (Elf64_Ehdr *) bufp;
+	bufp += sizeof(Elf64_Ehdr);
+	memcpy(elf->e_ident, ELFMAG, SELFMAG);
+	elf->e_ident[EI_CLASS]  = ELFCLASS64;
+	elf->e_ident[EI_DATA]   = ELFDATA2LSB;
+	elf->e_ident[EI_VERSION]= EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELFOSABI_NONE;
+	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
+	elf->e_type	= ET_CORE;
+	elf->e_machine	= EM_386;
+	elf->e_version	= EV_CURRENT;
+	elf->e_entry	= 0;
+	elf->e_phoff	= sizeof(Elf64_Ehdr);
+	elf->e_shoff	= 0;
+	elf->e_flags	= 0;
+	elf->e_ehsize   = sizeof(Elf64_Ehdr);
+	elf->e_phentsize= sizeof(Elf64_Phdr);
+	elf->e_phnum    = 0;
+	elf->e_shentsize= 0;
+	elf->e_shnum    = 0;
+	elf->e_shstrndx = 0;
+
+	/* PT_NOTE program headers. One per cpu*/
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	if (nr_cpus < 0) {
+		return -1;
+	}
+	/* Need to find a better way to determine per cpu notes section size. */
+#define MAX_NOTE_BYTES	1024
+	if (get_crash_notes_section_addr (&notes_addr) < 0) {
+		return -1;
+	}
+	notes_offset = __pa(notes_addr);
+	for (i = 0; i < nr_cpus; i++) {
+		phdr = (Elf64_Phdr *) bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type	= PT_NOTE;
+		phdr->p_flags	= 0;
+		phdr->p_offset	= notes_offset;
+		phdr->p_vaddr	= phdr->p_paddr	= notes_offset;
+		phdr->p_filesz	= phdr->p_memsz	= MAX_NOTE_BYTES;
+		/* Do we need any alignment of segments? */
+		phdr->p_align	= 0;
+		notes_offset 	+= MAX_NOTE_BYTES;
+	}
+
+	/* Setup PT_LOAD type program header for every system RAM chunk.
+	 * A seprate program header for Backup Region*/
+	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
+		unsigned long long mstart, mend;
+		mstart = crash_memory_range[i].start;
+		mend = crash_memory_range[i].end;
+		if (!mstart && !mend)
+			break;
+		phdr = (Elf64_Phdr *) bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type	= PT_LOAD;
+		phdr->p_flags	= PF_R|PF_W|PF_X;
+		if (mstart == BACKUP_START && mend == BACKUP_END)
+			phdr->p_offset	= info->backup_start;
+		else
+			phdr->p_offset	= mstart;
+		phdr->p_vaddr = phdr->p_paddr = mstart;
+		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
+		/* Do we need any alignment of segments? */
+		phdr->p_align	= 0;
+	}
+	return 0;
+}
diff -puN kexec/arch/i386/crashdump-x86.h~kexec-tools-crashdump-elf-headers-x86 kexec/arch/i386/crashdump-x86.h
--- kexec-tools-1.101/kexec/arch/i386/crashdump-x86.h~kexec-tools-crashdump-elf-headers-x86	2005-02-24 18:55:53.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.h	2005-02-24 18:55:53.000000000 +0530
@@ -1,6 +1,24 @@
 #ifndef CRASHDUMP_X86_H
 #define CRASHDUMP_X86_H
 
+int get_crash_memory_ranges(struct memory_range** range, int* ranges);
+int prepare_crash_memory_elf_headers(struct kexec_info *info, void *buf,
+						unsigned long size);
+int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
+								size_t size);
+int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
+								size_t size);
+int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p);
+int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr);
+
+extern struct memory_range crash_reserved_mem;
+
+#define PAGE_OFFSET	0xc0000000
+#define __pa(x)		((unsigned long)(x)-PAGE_OFFSET)
+
+#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
+#define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
+
 /* Backup Region, First 640K of System RAM. */
 #define BACKUP_START	0x00000000
 #define BACKUP_END	0x0009ffff
diff -puN kexec/arch/i386/kexec-elf-x86.c~kexec-tools-crashdump-elf-headers-x86 kexec/arch/i386/kexec-elf-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-elf-x86.c~kexec-tools-crashdump-elf-headers-x86	2005-02-24 18:55:53.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c	2005-02-24 18:55:53.000000000 +0530
@@ -88,7 +88,9 @@ int elf_x86_load(int argc, char **argv, 
 {
 	struct mem_ehdr ehdr;
 	const char *command_line;
+	char *modified_cmdline;
 	int command_line_len;
+	int modified_cmdline_len;
 	const char *ramdisk;
 	unsigned long entry, max_addr;
 	int arg_style;
@@ -121,6 +123,8 @@ int elf_x86_load(int argc, char **argv, 
 	 */
 	arg_style = ARG_STYLE_ELF;
 	command_line = 0;
+	modified_cmdline = 0;
+	modified_cmdline_len = 0;
 	ramdisk = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
@@ -158,6 +162,21 @@ int elf_x86_load(int argc, char **argv, 
 		command_line_len = strlen(command_line) +1;
 	}
 
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 *
+	 * If loading panic kernel finds usage other than taking crash dumps
+	 * then probably another kexec option need to be added to distinguish
+	 * that case. */
+	if (kexec_flags & KEXEC_ON_CRASH) {
+		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
+		if (command_line) {
+			strncpy(modified_cmdline, command_line, COMMAND_LINE_SIZE);
+			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
+		}
+		modified_cmdline_len = strlen(modified_cmdline);
+	}
 	/* Load the ELF executable */
 	elf_exec_build_load(info, &ehdr, buf, len);
 
@@ -229,13 +248,55 @@ int elf_x86_load(int argc, char **argv, 
 			void *tmp;
 			unsigned long sz;
 			int nr_ranges, align = 1024;
-			/* Create a backup region segment to store first 638K
-			 * memory*/
+			long int nr_cpus = 0;
+			struct memory_range *mem_range;
+			unsigned long elfcorehdr;
+			struct memory_range *memmap_p;
+
+			if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0) {
+				return -1;
+			}
+			/* memory regions which panic kernel can safely use to
+			 * boot into. */
+			sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
+ 			memmap_p = xmalloc(sz);
+ 			memset(memmap_p, 0, sz);
+			add_memmap(memmap_p, BACKUP_START, BACKUP_SIZE);
+			sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
+			add_memmap(memmap_p, crash_reserved_mem.start, sz);
+ 			/* Create a backup region segment to store backup data*/
 			sz = (BACKUP_SIZE + align - 1) & ~(align - 1);
 			tmp = xmalloc(sz);
 			memset(tmp, 0, sz);
 			info->backup_start = add_buffer(info, tmp, sz, sz, 1024,
 						0, max_addr, 1);
+			if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
+				return -1;
+
+			/* Create elf header segment and store crash image data.
+ 			 */
+			nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+			if (nr_cpus < 0) {
+				fprintf(stderr,"kexec_load (elf header segment)"
+					" failed: %s\n", strerror(errno));
+				return -1;
+			}
+			sz = 	sizeof(Elf64_Ehdr) +
+				nr_cpus * sizeof(Elf64_Phdr) + /* PT_NOTE */
+				nr_ranges * sizeof(Elf64_Phdr);
+			sz = (sz + align - 1) & ~(align -1);
+			tmp = xmalloc(sz);
+			memset(tmp, 0, sz);
+			if (prepare_crash_memory_elf_headers(info, tmp, sz) < 0)
+				return -1;
+			elfcorehdr = add_buffer(info, tmp, sz, sz, 1024, 0, max_addr, 1);
+			if (delete_memmap(memmap_p, elfcorehdr, sz) < 0)
+				return -1;
+			cmdline_add_memmap(modified_cmdline, memmap_p);
+			cmdline_add_elfcorehdr(modified_cmdline, elfcorehdr);
+			/* Use new command line. */
+			command_line = modified_cmdline;
+			command_line_len = strlen(modified_cmdline) + 1;
 		}
 
 		/* Tell the kernel what is going on */
diff -puN kexec/arch/i386/kexec-x86.c~kexec-tools-crashdump-elf-headers-x86 kexec/arch/i386/kexec-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-x86.c~kexec-tools-crashdump-elf-headers-x86	2005-02-24 18:55:53.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.c	2005-02-24 18:55:53.000000000 +0530
@@ -30,9 +30,9 @@
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
 #include "kexec-x86.h"
+#include "crashdump-x86.h"
 #include <arch/options.h>
 
-#define MAX_MEMORY_RANGES 64
 #define MAX_LINE 160
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
diff -puN kexec/arch/i386/kexec-x86.h~kexec-tools-crashdump-elf-headers-x86 kexec/arch/i386/kexec-x86.h
--- kexec-tools-1.101/kexec/arch/i386/kexec-x86.h~kexec-tools-crashdump-elf-headers-x86	2005-02-24 18:55:53.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-x86.h	2005-02-24 18:55:53.000000000 +0530
@@ -1,6 +1,8 @@
 #ifndef KEXEC_X86_H
 #define KEXEC_X86_H
 
+#define MAX_MEMORY_RANGES 64
+
 extern unsigned char compat_x86_64[];
 extern uint32_t compat_x86_64_size, compat_x86_64_entry32;
 
_

--=-NtvmNFPw5Fu6IAwtr7uS--

