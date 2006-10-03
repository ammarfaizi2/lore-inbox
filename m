Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWJCRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWJCRcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJCRbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:31:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:27813 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030354AbWJCRbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:03 -0400
Date: Tue, 3 Oct 2006 13:17:55 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 7/12] Make linux/elf.h safe to be included in assembly files
Message-ID: <20061003171755.GG3164@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003170032.GA30036@in.ibm.com>
User-Agent: Mutt/1.5.11
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
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/linux/elf.h |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff -puN include/linux/elf.h~Make-linux-elf.h-safe-to-be-included-in-assembly-files include/linux/elf.h
--- linux-2.6.18-git17/include/linux/elf.h~Make-linux-elf.h-safe-to-be-included-in-assembly-files	2006-10-02 13:17:58.000000000 -0400
+++ linux-2.6.18-git17-root/include/linux/elf.h	2006-10-02 14:35:25.000000000 -0400
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
@@ -97,6 +101,8 @@ typedef __s64	Elf64_Sxword;
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
@@ -265,6 +277,8 @@ typedef struct elf64_phdr {
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
@@ -338,6 +354,8 @@ typedef struct elf64_shdr {
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 
 
+#ifndef __ASSEMBLY__
+
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */
@@ -368,5 +386,7 @@ extern Elf64_Dyn _DYNAMIC [];
 
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 
 #endif /* _LINUX_ELF_H */
_
