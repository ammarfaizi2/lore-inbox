Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVC1NcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVC1NcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVC1NcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:32:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58081 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261799AbVC1N1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:41 -0500
Subject: [RFC/PATCH 15/17][Kdump] Parse elf32 headers and export through
	/proc/vmcore
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-cYN1uDOI0vKxmvOPzHnq"
Date: Mon, 28 Mar 2005 18:57:31 +0530
Message-Id: <1112016451.4001.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cYN1uDOI0vKxmvOPzHnq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-cYN1uDOI0vKxmvOPzHnq
Content-Disposition: attachment; filename=crashdump-parse-core-elf32-headers.patch
Content-Type: message/rfc822; name=crashdump-parse-core-elf32-headers.patch

From: 
Date: Mon, 28 Mar 2005 17:54:47 +0530
Subject: No Subject
Message-Id: <1112012687.4001.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o Adds support for parsing core ELF32 headers.
o I am expecting ELF32 support to go away down the line. This patch has been
  introduced for testing purposes as gdb can not parse ELF64 headers for
  i386. When a decent user space solution is available, ELF32 support
  can go away.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-16M-root/fs/proc/vmcore.c |  218 +++++++++++++++++++++++++
 1 files changed, 218 insertions(+)

diff -puN fs/proc/vmcore.c~crashdump-parse-core-elf32-headers fs/proc/vmcore.c
--- linux-2.6.12-rc1-mm1-16M/fs/proc/vmcore.c~crashdump-parse-core-elf32-headers	2005-03-22 18:13:40.000000000 +0530
+++ linux-2.6.12-rc1-mm1-16M-root/fs/proc/vmcore.c	2005-03-22 18:14:20.000000000 +0530
@@ -202,6 +202,23 @@ static u64 __init get_vmcore_size_elf64(
 	return size;
 }
 
+static u64 __init get_vmcore_size_elf32(char *elfptr)
+{
+	int i;
+	u64 size;
+	Elf32_Ehdr *ehdr_ptr;
+	Elf32_Phdr *phdr_ptr;
+
+	ehdr_ptr = (Elf32_Ehdr *)elfptr;
+	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
+	size = sizeof(Elf32_Ehdr) + ((ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr));
+	for (i = 0; i < ehdr_ptr->e_phnum; i++) {
+		size += phdr_ptr->p_memsz;
+		phdr_ptr++;
+	}
+	return size;
+}
+
 /* Merges all the PT_NOTE headers into one. */
 static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 						struct list_head *vc_list)
@@ -283,6 +300,87 @@ static int __init merge_note_headers_elf
 	return 0;
 }
 
+/* Merges all the PT_NOTE headers into one. */
+static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
+						struct list_head *vc_list)
+{
+	int i, nr_ptnote=0, rc=0;
+	char *tmp;
+	Elf32_Ehdr *ehdr_ptr;
+	Elf32_Phdr phdr, *phdr_ptr;
+	Elf32_Nhdr *nhdr_ptr;
+	u64 phdr_sz = 0, note_off;
+
+	ehdr_ptr = (Elf32_Ehdr *)elfptr;
+	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr));
+	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
+		int j;
+		void *notes_section;
+		struct vmcore *new;
+		u64 offset, max_sz, sz, real_sz = 0;
+		if (phdr_ptr->p_type != PT_NOTE)
+			continue;
+		nr_ptnote++;
+		max_sz = phdr_ptr->p_memsz;
+		offset = phdr_ptr->p_offset;
+		notes_section = kmalloc(max_sz, GFP_KERNEL);
+		if (!notes_section)
+			return -ENOMEM;
+		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		if (rc < 0) {
+			kfree(notes_section);
+			return rc;
+		}
+		nhdr_ptr = notes_section;
+		for (j = 0; j < max_sz; j += sz) {
+			if (nhdr_ptr->n_namesz == 0)
+				break;
+			sz = sizeof(Elf32_Nhdr) +
+				((nhdr_ptr->n_namesz + 3) & ~3) +
+				((nhdr_ptr->n_descsz + 3) & ~3);
+			real_sz += sz;
+			nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
+		}
+
+		/* Add this contiguous chunk of notes section to vmcore list.*/
+		new = get_new_element();
+		if (!new) {
+			kfree(notes_section);
+			return -ENOMEM;
+		}
+		new->paddr = phdr_ptr->p_offset;
+		new->size = real_sz;
+		list_add_tail(&new->list, vc_list);
+		phdr_sz += real_sz;
+		kfree(notes_section);
+	}
+
+	/* Prepare merged PT_NOTE program header. */
+	phdr.p_type    = PT_NOTE;
+	phdr.p_flags   = 0;
+	note_off = sizeof(Elf32_Ehdr) +
+			(ehdr_ptr->e_phnum - nr_ptnote +1) * sizeof(Elf32_Phdr);
+	phdr.p_offset  = note_off;
+	phdr.p_vaddr   = phdr.p_paddr = 0;
+	phdr.p_filesz  = phdr.p_memsz = phdr_sz;
+	phdr.p_align   = 0;
+
+	/* Add merged PT_NOTE program header*/
+	tmp = elfptr + sizeof(Elf32_Ehdr);
+	memcpy(tmp, &phdr, sizeof(phdr));
+	tmp += sizeof(phdr);
+
+	/* Remove unwanted PT_NOTE program headers. */
+	i = (nr_ptnote - 1) * sizeof(Elf32_Phdr);
+	*elfsz = *elfsz - i;
+	memmove(tmp, tmp+i, ((*elfsz)-sizeof(Elf32_Ehdr)-sizeof(Elf32_Phdr)));
+
+	/* Modify e_phnum to reflect merged headers. */
+	ehdr_ptr->e_phnum = ehdr_ptr->e_phnum - nr_ptnote + 1;
+
+	return 0;
+}
+
 /* Add memory chunks represented by program headers to vmcore list. Also update
  * the new offset fields of exported program headers. */
 static int __init process_ptload_program_headers_elf64(char *elfptr,
@@ -322,6 +420,43 @@ static int __init process_ptload_program
 	return 0;
 }
 
+static int __init process_ptload_program_headers_elf32(char *elfptr,
+						size_t elfsz,
+						struct list_head *vc_list)
+{
+	int i;
+	Elf32_Ehdr *ehdr_ptr;
+	Elf32_Phdr *phdr_ptr;
+	loff_t vmcore_off;
+	struct vmcore *new;
+
+	ehdr_ptr = (Elf32_Ehdr *)elfptr;
+	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
+
+	/* First program header is PT_NOTE header. */
+	vmcore_off = sizeof(Elf32_Ehdr) +
+			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr) +
+			phdr_ptr->p_memsz; /* Note sections */
+
+	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
+		if (phdr_ptr->p_type != PT_LOAD)
+			continue;
+
+		/* Add this contiguous chunk of memory to vmcore list.*/
+		new = get_new_element();
+		if (!new)
+			return -ENOMEM;
+		new->paddr = phdr_ptr->p_offset;
+		new->size = phdr_ptr->p_memsz;
+		list_add_tail(&new->list, vc_list);
+
+		/* Update the program header offset */
+		phdr_ptr->p_offset = vmcore_off;
+		vmcore_off = vmcore_off + phdr_ptr->p_memsz;
+	}
+	return 0;
+}
+
 /* Sets offset fields of vmcore elements. */
 static void __init set_vmcore_list_offsets_elf64(char *elfptr,
 						struct list_head *vc_list)
@@ -342,6 +477,26 @@ static void __init set_vmcore_list_offse
 	}
 }
 
+/* Sets offset fields of vmcore elements. */
+static void __init set_vmcore_list_offsets_elf32(char *elfptr,
+						struct list_head *vc_list)
+{
+	loff_t vmcore_off;
+	Elf32_Ehdr *ehdr_ptr;
+	struct vmcore *m;
+
+	ehdr_ptr = (Elf32_Ehdr *)elfptr;
+
+	/* Skip Elf header and program headers. */
+	vmcore_off = sizeof(Elf32_Ehdr) +
+			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr);
+
+	list_for_each_entry(m, vc_list, list) {
+		m->offset = vmcore_off;
+		vmcore_off += m->size;
+	}
+}
+
 static int __init parse_crash_elf64_headers(void)
 {
 	int rc=0;
@@ -398,6 +553,62 @@ static int __init parse_crash_elf64_head
 	return 0;
 }
 
+static int __init parse_crash_elf32_headers(void)
+{
+	int rc=0;
+	Elf32_Ehdr ehdr;
+	u64 addr;
+
+	addr = elfcorehdr_addr;
+
+	/* Read Elf header */
+	rc = read_from_oldmem((char*)&ehdr, sizeof(Elf32_Ehdr), &addr, 0);
+	if (rc < 0)
+		return rc;
+
+	/* Do some basic Verification. */
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
+		(ehdr.e_type != ET_CORE) ||
+		!elf_check_arch(&ehdr) ||
+		ehdr.e_ident[EI_CLASS] != ELFCLASS32||
+		ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
+		ehdr.e_version != EV_CURRENT ||
+		ehdr.e_ehsize != sizeof(Elf32_Ehdr) ||
+		ehdr.e_phentsize != sizeof(Elf32_Phdr) ||
+		ehdr.e_phnum == 0) {
+		printk(KERN_WARNING "Warning: Core image elf header is not"
+					"sane\n");
+		return -EINVAL;
+	}
+
+	/* Read in all elf headers. */
+	elfcorebuf_sz = sizeof(Elf32_Ehdr) + ehdr.e_phnum * sizeof(Elf32_Phdr);
+	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
+	if (!elfcorebuf)
+		return -ENOMEM;
+	addr = elfcorehdr_addr;
+	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz, &addr, 0);
+	if (rc < 0) {
+		kfree(elfcorebuf);
+		return rc;
+	}
+
+	/* Merge all PT_NOTE headers into one. */
+	rc = merge_note_headers_elf32(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
+	if (rc) {
+		kfree(elfcorebuf);
+		return rc;
+	}
+	rc = process_ptload_program_headers_elf32(elfcorebuf, elfcorebuf_sz,
+								&vmcore_list);
+	if (rc) {
+		kfree(elfcorebuf);
+		return rc;
+	}
+	set_vmcore_list_offsets_elf32(elfcorebuf, &vmcore_list);
+	return 0;
+}
+
 static int __init parse_crash_elf_headers(void)
 {
 	unsigned char e_ident[EI_NIDENT];
@@ -421,6 +632,13 @@ static int __init parse_crash_elf_header
 
 		/* Determine vmcore size. */
 		vmcore_size = get_vmcore_size_elf64(elfcorebuf);
+	} else if (e_ident[EI_CLASS] == ELFCLASS32) {
+		rc = parse_crash_elf32_headers();
+		if (rc)
+			return rc;
+
+		/* Determine vmcore size. */
+		vmcore_size = get_vmcore_size_elf32(elfcorebuf);
 	} else {
 		printk(KERN_WARNING "Warning: Core image elf header is not"
 					" sane\n");
_

--=-cYN1uDOI0vKxmvOPzHnq--

