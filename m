Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWHALFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWHALFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWHALFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50652 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932571AbWHALFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:20 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 6/33] Make linux/elf.h safe to be included in assembly files
Date: Tue,  1 Aug 2006 05:03:21 -0600
Message-Id: <11544302321872-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation for this is that currently we have 512 bytes
at the begining of a bzImage that are unused now that we don't
have a bootsector there.  I plan on putting an ELF header
there, and generating it by hand with assebmly data directives
to be minimally disrutptive to the current build process.

To do that I need the elf magic constants available to my
assembly code.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/elf.h |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/include/linux/elf.h b/include/linux/elf.h
index b70d1d2..c5bf043 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -1,9 +1,11 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
+#include <linux/elf-em.h>
+
+#ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/auxvec.h>
-#include <linux/elf-em.h>
 #include <asm/elf.h>
 
 #ifndef elf_read_implies_exec
@@ -30,6 +32,8 @@ typedef __u32	Elf64_Word;
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
 
+#endif /* __ASSEMBLY__ */
+
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0
 #define PT_LOAD    1
@@ -97,6 +101,8 @@ #define STT_FILE    4
 #define STT_COMMON  5
 #define STT_TLS     6
 
+#ifndef __ASSEMBLY__
+
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		(((unsigned int) x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
@@ -204,12 +210,16 @@ typedef struct elf64_hdr {
   Elf64_Half e_shstrndx;
 } Elf64_Ehdr;
 
+#endif /* __ASSEMBLY__ */
+
 /* These constants define the permissions on sections in the program
    header, p_flags. */
 #define PF_R		0x4
 #define PF_W		0x2
 #define PF_X		0x1
 
+#ifndef __ASSEMBLY__
+
 typedef struct elf32_phdr{
   Elf32_Word	p_type;
   Elf32_Off	p_offset;
@@ -232,6 +242,8 @@ typedef struct elf64_phdr {
   Elf64_Xword p_align;		/* Segment alignment, file & memory */
 } Elf64_Phdr;
 
+#endif /* __ASSEMBLY__ */
+
 /* sh_type */
 #define SHT_NULL	0
 #define SHT_PROGBITS	1
@@ -265,6 +277,8 @@ #define SHN_HIPROC	0xff1f
 #define SHN_ABS		0xfff1
 #define SHN_COMMON	0xfff2
 #define SHN_HIRESERVE	0xffff
+
+#ifndef __ASSEMBLY__
  
 typedef struct {
   Elf32_Word	sh_name;
@@ -292,6 +306,8 @@ typedef struct elf64_shdr {
   Elf64_Xword sh_entsize;	/* Entry size if section holds table */
 } Elf64_Shdr;
 
+#endif /* __ASSEMBLY__ */
+
 #define	EI_MAG0		0		/* e_ident[] indexes */
 #define	EI_MAG1		1
 #define	EI_MAG2		2
@@ -338,6 +354,8 @@ #define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 
 
+#ifndef __ASSEMBLY__
+
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */
@@ -368,5 +386,7 @@ #define elf_note	elf64_note
 
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 
 #endif /* _LINUX_ELF_H */
-- 
1.4.2.rc2.g5209e

