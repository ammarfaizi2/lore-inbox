Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWGYR>; Thu, 23 Nov 2000 01:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132568AbQKWGYH>; Thu, 23 Nov 2000 01:24:07 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15721 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S129514AbQKWGXt>; Thu, 23 Nov 2000 01:23:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test11 Elf64_Word incorrectly defined
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 16:53:40 +1100
Message-ID: <4720.974958820@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch needs to be reviewed before it goes to Linus.

The ELF 64 bit spec defines

Name		Size	Alignment	Purpose
Elf64_Addr	  8	  8		Unsigned program address
Elf64_Off	  8	  8		Unsigned file offset
Elf64_Half	  2	  2		Unsigned medium integer
Elf64_Word	  4	  4		Unsigned integer
Elf64_Sword	  4	  4		Signed integer
Elf64_Xword	  8	  8		Unsigned long integer
Elf64_Sxword	  8	  8		Signed long integer
unsigned char	  1	  1		Unsigned small integer

Note that Elf64_Word and Elf64_Sword are 4 bytes, even on 64 bit
machines.  elf.h from glibc 2.1.92 correctly defines these types.  The
kernel incorrectly defines them as 8 bytes.  There is code in
linux/kernel/elf.h that defines a mixture of Elf32 and Elf64 types in
the same structure because the kernel types are wrong, there is even
code that uses __s32 instead of Elf64_Word.

The type mismatch between kernel and userspace causes field
misalignments if you copy a user space definition into the kernel or
vice versa.  One fix is to use different type names for structure
definitions in userspace and kernel to get the same mapping, but that
is a major kludge.  Instead this patch corrects Elf64_[S]Word to 4
bytes bits and adds the correct Elf64_[S]Xword where it really needs 8
bytes.  It also replaces __s32 with Elf64_Word and fixes a few other
incorrect types.

Unless I made an error, the existing structure mappings have not been
affected.  The patch just corrects the mismatched or incorrect types so
the kernel, userspace and the ELF spec agree, it will make it easier
and safer to copy definitions between kernel and user space.

Index: 0-test11.1/include/linux/elf.h
--- 0-test11.1/include/linux/elf.h Tue, 31 Oct 2000 08:28:16 +1100 kaos (linux-2.4/Y/0_elf.h 1.4 644)
+++ 0-test11.1(w)/include/linux/elf.h Thu, 23 Nov 2000 16:05:20 +1100 kaos (linux-2.4/Y/0_elf.h 1.4 644)
@@ -16,8 +16,10 @@ typedef __u64	Elf64_Addr;
 typedef __u16	Elf64_Half;
 typedef __s16	Elf64_SHalf;
 typedef __u64	Elf64_Off;
-typedef __s64	Elf64_Sword;
+typedef __s32	Elf64_Sword;
-typedef __u64	Elf64_Word;
+typedef __u32	Elf64_Word;
+typedef __u64	Elf64_Xword;
+typedef __s64	Elf64_Sxword;
 
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0
@@ -176,10 +178,10 @@ typedef struct dynamic{
 } Elf32_Dyn;
 
 typedef struct {
-  Elf64_Word d_tag;		/* entry tag value */
+  Elf64_Sxword d_tag;		/* entry tag value */
   union {
-    Elf64_Word d_val;
+    Elf64_Xword d_val;
-    Elf64_Word d_ptr;
+    Elf64_Addr d_ptr;
   } d_un;
 } Elf64_Dyn;
 
@@ -370,7 +372,7 @@ typedef struct elf32_rel {
 
 typedef struct elf64_rel {
   Elf64_Addr r_offset;	/* Location at which to apply the action */
-  Elf64_Word r_info;	/* index and type of relocation */
+  Elf64_Xword r_info;	/* index and type of relocation */
 } Elf64_Rel;
 
 typedef struct elf32_rela{
@@ -381,8 +383,8 @@ typedef struct elf32_rela{
 
 typedef struct elf64_rela {
   Elf64_Addr r_offset;	/* Location at which to apply the action */
-  Elf64_Word r_info;	/* index and type of relocation */
+  Elf64_Xword r_info;	/* index and type of relocation */
-  Elf64_Word r_addend;	/* Constant addend used to compute value */
+  Elf64_Sxword r_addend;	/* Constant addend used to compute value */
 } Elf64_Rela;
 
 typedef struct elf32_sym{
@@ -395,12 +397,12 @@ typedef struct elf32_sym{
 } Elf32_Sym;
 
 typedef struct elf64_sym {
-  Elf32_Word st_name;		/* Symbol name, index in string tbl (yes, Elf32) */
+  Elf64_Word st_name;		/* Symbol name, index in string tbl */
   unsigned char	st_info;	/* Type and binding attributes */
   unsigned char	st_other;	/* No defined meaning, 0 */
   Elf64_Half st_shndx;		/* Associated section index */
   Elf64_Addr st_value;		/* Value of the symbol */
-  Elf64_Word st_size;		/* Associated symbol size */
+  Elf64_Xword st_size;		/* Associated symbol size */
 } Elf64_Sym;
 
 
@@ -425,19 +427,19 @@ typedef struct elf32_hdr{
 
 typedef struct elf64_hdr {
   unsigned char	e_ident[16];		/* ELF "magic number" */
-  Elf64_SHalf e_type;
+  Elf64_Half e_type;
   Elf64_Half e_machine;
-  __s32 e_version;
+  Elf64_Word e_version;
   Elf64_Addr e_entry;		/* Entry point virtual address */
   Elf64_Off e_phoff;		/* Program header table file offset */
   Elf64_Off e_shoff;		/* Section header table file offset */
-  __s32 e_flags;
+  Elf64_Word e_flags;
-  Elf64_SHalf e_ehsize;
+  Elf64_Half e_ehsize;
-  Elf64_SHalf e_phentsize;
+  Elf64_Half e_phentsize;
-  Elf64_SHalf e_phnum;
+  Elf64_Half e_phnum;
-  Elf64_SHalf e_shentsize;
+  Elf64_Half e_shentsize;
-  Elf64_SHalf e_shnum;
+  Elf64_Half e_shnum;
-  Elf64_SHalf e_shstrndx;
+  Elf64_Half e_shstrndx;
 } Elf64_Ehdr;
 
 /* These constants define the permissions on sections in the program
@@ -458,14 +460,14 @@ typedef struct elf32_phdr{
 } Elf32_Phdr;
 
 typedef struct elf64_phdr {
-  __s32 p_type;
+  Elf64_Word p_type;
-  __s32 p_flags;
+  Elf64_Word p_flags;
   Elf64_Off p_offset;		/* Segment file offset */
   Elf64_Addr p_vaddr;		/* Segment virtual address */
   Elf64_Addr p_paddr;		/* Segment physical address */
-  Elf64_Word p_filesz;		/* Segment size in file */
+  Elf64_Xword p_filesz;		/* Segment size in file */
-  Elf64_Word p_memsz;		/* Segment size in memory */
+  Elf64_Xword p_memsz;		/* Segment size in memory */
-  Elf64_Word p_align;		/* Segment alignment, file & memory */
+  Elf64_Xword p_align;		/* Segment alignment, file & memory */
 } Elf64_Phdr;
 
 /* sh_type */
@@ -522,16 +524,16 @@ typedef struct {
 } Elf32_Shdr;
 
 typedef struct elf64_shdr {
-  Elf32_Word sh_name;		/* Section name, index in string tbl (yes Elf32) */
+  Elf64_Word sh_name;		/* Section name, index in string tbl */
-  Elf32_Word sh_type;		/* Type of section (yes Elf32) */
+  Elf64_Word sh_type;		/* Type of section */
-  Elf64_Word sh_flags;		/* Miscellaneous section attributes */
+  Elf64_Xword sh_flags;		/* Miscellaneous section attributes */
   Elf64_Addr sh_addr;		/* Section virtual addr at execution */
   Elf64_Off sh_offset;		/* Section file offset */
-  Elf64_Word sh_size;		/* Size of section in bytes */
+  Elf64_Xword sh_size;		/* Size of section in bytes */
-  Elf32_Word sh_link;		/* Index of another section (yes Elf32) */
+  Elf64_Word sh_link;		/* Index of another section */
-  Elf32_Word sh_info;		/* Additional section information (yes Elf32) */
+  Elf64_Word sh_info;		/* Additional section information */
-  Elf64_Word sh_addralign;	/* Section alignment */
+  Elf64_Xword sh_addralign;	/* Section alignment */
-  Elf64_Word sh_entsize;	/* Entry size if section holds table */
+  Elf64_Xword sh_entsize;	/* Entry size if section holds table */
 } Elf64_Shdr;
 
 #define	EI_MAG0		0		/* e_ident[] indexes */
@@ -578,15 +580,10 @@ typedef struct elf32_note {
 } Elf32_Nhdr;
 
 /* Note header in a PT_NOTE section */
-/*
- * For now we use the 32 bit version of the structure until we figure
- * out whether we need anything better.  Note - on the Alpha, "unsigned int"
- * is only 32 bits.
- */
 typedef struct elf64_note {
-  Elf32_Word n_namesz;	/* Name size */
+  Elf64_Word n_namesz;	/* Name size */
-  Elf32_Word n_descsz;	/* Content size */
+  Elf64_Word n_descsz;	/* Content size */
-  Elf32_Word n_type;	/* Content type */
+  Elf64_Word n_type;	/* Content type */
 } Elf64_Nhdr;
 
 #if ELF_CLASS == ELFCLASS32

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
