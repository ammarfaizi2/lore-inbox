Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbTIJBJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTIJBJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:09:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264295AbTIJBJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:09:34 -0400
Date: Wed, 10 Sep 2003 02:09:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ELF OSABI
Message-ID: <20030910010933.GK18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fills in the ELF EI_OSABI field.  This doesn't matter for most
architectures, but PA-RISC uses the Linux flavour of the ABI (since HPUX
uses the None flavour).  Patch courtesy of Randolph Chung.

--- include/linux/elf.h	8 Sep 2003 21:42:49 -0000	1.5
+++ include/linux/elf.h	8 Sep 2003 22:00:28 -0000	1.6
@@ -360,7 +360,8 @@ typedef struct elf64_shdr {
 #define	EI_CLASS	4
 #define	EI_DATA		5
 #define	EI_VERSION	6
-#define	EI_PAD		7
+#define	EI_OSABI	7
+#define	EI_PAD		8
 
 #define	ELFMAG0		0x7f		/* EI_MAG */
 #define	ELFMAG1		'E'
@@ -381,6 +382,13 @@ typedef struct elf64_shdr {
 #define EV_NONE		0		/* e_version, EI_VERSION */
 #define EV_CURRENT	1
 #define EV_NUM		2
+
+#define ELFOSABI_NONE	0
+#define ELFOSABI_LINUX	3
+
+#ifndef ELF_OSABI
+#define ELF_OSABI ELFOSABI_NONE
+#endif
 
 /* Notes used in ET_CORE */
 #define NT_PRSTATUS	1
--- fs/proc/kcore.c	8 Sep 2003 21:42:37 -0000	1.3
+++ fs/proc/kcore.c	8 Sep 2003 22:00:27 -0000	1.4
@@ -175,6 +175,7 @@ static void elf_kcore_store_hdr(char *bu
 	elf->e_ident[EI_CLASS]	= ELF_CLASS;
 	elf->e_ident[EI_DATA]	= ELF_DATA;
 	elf->e_ident[EI_VERSION]= EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELF_OSABI;
 	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
 	elf->e_type	= ET_CORE;
 	elf->e_machine	= ELF_ARCH;
--- fs/binfmt_elf.c	8 Sep 2003 21:42:28 -0000	1.6
+++ fs/binfmt_elf.c	8 Sep 2003 22:00:26 -0000	1.7
@@ -1023,6 +1023,7 @@ static inline void fill_elf_header(struc
 	elf->e_ident[EI_CLASS] = ELF_CLASS;
 	elf->e_ident[EI_DATA] = ELF_DATA;
 	elf->e_ident[EI_VERSION] = EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELF_OSABI;
 	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
 
 	elf->e_type = ET_CORE;
--- arch/mips/kernel/irixelf.c	8 Sep 2003 21:41:38 -0000	1.3
+++ arch/mips/kernel/irixelf.c	8 Sep 2003 22:00:20 -0000	1.4
@@ -1088,6 +1088,7 @@ static int irix_core_dump(long signr, st
 	elf.e_ident[EI_CLASS] = ELFCLASS32;
 	elf.e_ident[EI_DATA] = ELFDATA2LSB;
 	elf.e_ident[EI_VERSION] = EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELF_OSABI;
 	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
 
 	elf.e_type = ET_CORE;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
