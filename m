Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVC1Nq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVC1Nq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVC1NqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:46:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12265 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261764AbVC1N0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:22 -0500
Subject: [RFC/PATCH 4/17][kexec-tools-1.101] Fill virtual addresses for
	linearly mapped region
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-VNl19qfHrISIQ+vvKvYI"
Date: Mon, 28 Mar 2005 18:56:19 +0530
Message-Id: <1112016380.4001.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VNl19qfHrISIQ+vvKvYI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-VNl19qfHrISIQ+vvKvYI
Content-Disposition: attachment; filename=kexec-tools-linearly-mapped-region-x86.patch
Content-Type: text/x-patch; name=kexec-tools-linearly-mapped-region-x86.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


o For i386, Physical memory upto 896MB is linearly mapped. Hence virtual
  addresses for linearly mapped region are known.
o This patch sets the appropriate virtual addresses in core headers for
  linearly mapped region.
o Enables gdb to debug linearly mapped region without any special user space
  utility. Otherwise, capture tools first need to analyze the core image (Read
  page tables and/or vm areas) and determine virtual addresses for memory 
  chunks and then regenerate the elf headers suitable for debugging with gdb.
o Some cases like 4G/4G split deviate from 896MB linearly mapped region and
  might have different value for PAGE_OFFSET. Probably its a good idea to 
  export the linear region from kernel and use that instead of hard coding it.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.c |   26 +++++++++++++++--
 kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.h |    3 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff -puN kexec/arch/i386/crashdump-x86.c~kexec-tools-linearly-mapped-region-x86 kexec/arch/i386/crashdump-x86.c
--- kexec-tools-1.101/kexec/arch/i386/crashdump-x86.c~kexec-tools-linearly-mapped-region-x86	2005-03-21 18:55:18.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.c	2005-03-21 18:59:07.000000000 +0530
@@ -106,10 +106,22 @@ int get_crash_memory_ranges(struct memor
 		/* First 640K already registered */
 		if (start >= 0x00000000 && end <= 0x0009ffff)
 			continue;
+
 		crash_memory_range[memory_ranges].start = start;
 		crash_memory_range[memory_ranges].end = end;
 		crash_memory_range[memory_ranges].type = type;
 		memory_ranges++;
+
+		/* Segregate linearly mapped region. */
+		if ((MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
+			crash_memory_range[memory_ranges-1].end = MAXMEM -1;
+
+			/* Add segregated region. */
+			crash_memory_range[memory_ranges].start = MAXMEM;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = type;
+			memory_ranges++;
+		}
 	}
 	fclose(fp);
 	if (exclude_crash_reserve_region(&memory_ranges) < 0)
@@ -521,7 +533,12 @@ int prepare_crash_memory_elf64_headers(s
 			phdr->p_offset	= info->backup_start;
 		else
 			phdr->p_offset	= mstart;
-		phdr->p_vaddr = phdr->p_paddr = mstart;
+		/* Handle linearly mapped region.*/
+		if (mend <= (MAXMEM - 1))
+			phdr->p_vaddr = mstart + PAGE_OFFSET;
+		else
+			phdr->p_vaddr = -1ULL;
+		phdr->p_paddr = mstart;
 		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
 		/* Do we need any alignment of segments? */
 		phdr->p_align	= 0;
@@ -612,7 +629,12 @@ int prepare_crash_memory_elf32_headers(s
 			phdr->p_offset	= info->backup_start;
 		else
 			phdr->p_offset	= mstart;
-		phdr->p_vaddr = phdr->p_paddr = mstart;
+		/* Handle linearly mapped region.*/
+		if (mend <= (MAXMEM - 1))
+			phdr->p_vaddr = mstart + PAGE_OFFSET;
+		else
+			phdr->p_vaddr = ULONG_MAX;
+		phdr->p_paddr = mstart;
 		phdr->p_filesz	= phdr->p_memsz	= mend - mstart + 1;
 		/* Do we need any alignment of segments? */
 		phdr->p_align	= 0;
diff -puN kexec/arch/i386/crashdump-x86.h~kexec-tools-linearly-mapped-region-x86 kexec/arch/i386/crashdump-x86.h
--- kexec-tools-1.101/kexec/arch/i386/crashdump-x86.h~kexec-tools-linearly-mapped-region-x86	2005-03-21 18:55:18.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/crashdump-x86.h	2005-03-21 18:55:18.000000000 +0530
@@ -18,6 +18,9 @@ extern struct memory_range crash_reserve
 #define PAGE_OFFSET	0xc0000000
 #define __pa(x)		((unsigned long)(x)-PAGE_OFFSET)
 
+#define __VMALLOC_RESERVE       (128 << 20)
+#define MAXMEM                  (-PAGE_OFFSET-__VMALLOC_RESERVE)
+
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
 
_

--=-VNl19qfHrISIQ+vvKvYI--

