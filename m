Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319148AbSIDL62>; Wed, 4 Sep 2002 07:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319149AbSIDL62>; Wed, 4 Sep 2002 07:58:28 -0400
Received: from dp.samba.org ([66.70.73.150]:55695 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319148AbSIDL61>;
	Wed, 4 Sep 2002 07:58:27 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15733.62920.624689.922248@argo.ozlabs.ibm.com>
Date: Wed, 4 Sep 2002 22:00:08 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix create_elf_tables on PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

As you know, create_elf_tables in fs/binfmt_elf.c now sets up the list
of aux table entries in a buffer on the kernel stack before copying it
to the user stack.  Unfortunately, while the buffer is big enough for
most architectures, it isn't big enough on PPC, which uses 5 extra aux
table entries (put on with ARCH_DLINFO).  The following patch
increases the buffer to be big enough for PPC.  (Note that each aux
table entry uses two elements of the elf_info array.)

Please apply this to your tree.

Thanks,
Paul.

diff -urN linux-2.5/fs/binfmt_elf.c pmac-2.5/fs/binfmt_elf.c
--- linux-2.5/fs/binfmt_elf.c	Fri Aug 30 09:26:19 2002
+++ pmac-2.5/fs/binfmt_elf.c	Tue Sep  3 16:54:13 2002
@@ -132,7 +132,7 @@
 	elf_addr_t *sp, *u_platform;
 	const char *k_platform = ELF_PLATFORM;
 	int items;
-	elf_addr_t elf_info[30];
+	elf_addr_t elf_info[40];
 	int ei_index = 0;
 
 	/*
