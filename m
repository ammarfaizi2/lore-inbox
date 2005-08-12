Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVHLR7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVHLR7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHLRyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:46 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:36566 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750790AbVHLRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:34 -0400
Subject: [patch 17/39] remap_file_pages protection support: safety net for lazy arches
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:32:15 +0200
Message-Id: <20050812173215.9FDDA24E7E9@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Since proper support requires that the arch at the very least handles
VM_FAULT_SIGSEGV, as in next patch (otherwise the arch may BUG), and things
are even more complex (see next patches), and it's triggerable only with
VM_NONUNIFORM vma's, simply refuse creating them if the arch doesn't declare
itself ready.

This is a very temporary hack, so I've clearly marked it as such. And, with
current rythms, I've given about 6 months for arches to get ready. Reducing
this time is perfectly ok for me.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/Documentation/feature-removal-schedule.txt |   12 ++++++++++
 linux-2.6.git-paolo/include/asm-i386/pgtable.h                 |    3 ++
 linux-2.6.git-paolo/include/asm-um/pgtable.h                   |    3 ++
 linux-2.6.git-paolo/mm/fremap.c                                |    5 ++++
 4 files changed, 23 insertions(+)

diff -puN mm/fremap.c~rfp-safety-net-for-archs mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-safety-net-for-archs	2005-08-11 13:46:49.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 13:55:02.000000000 +0200
@@ -184,6 +184,11 @@ asmlinkage long sys_remap_file_pages(uns
 	int err = -EINVAL;
 	int has_write_lock = 0;
 
+	/* Hack for not-updated archs, KILLME after 2.6.16! */
+#ifndef __ARCH_SUPPORTS_VM_NONUNIFORM
+	if (flags & MAP_NOINHERIT)
+		goto out;
+#endif
 	if (prot && !(flags & MAP_NOINHERIT))
 		goto out;
 	/*
diff -puN include/asm-i386/pgtable.h~rfp-safety-net-for-archs include/asm-i386/pgtable.h
--- linux-2.6.git/include/asm-i386/pgtable.h~rfp-safety-net-for-archs	2005-08-11 13:46:49.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable.h	2005-08-11 13:55:02.000000000 +0200
@@ -419,4 +419,7 @@ extern void noexec_setup(const char *str
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
+/* Hack for not-updated archs, KILLME after 2.6.16! */
+#define __ARCH_SUPPORTS_VM_NONUNIFORM
+
 #endif /* _I386_PGTABLE_H */
diff -puN include/asm-um/pgtable.h~rfp-safety-net-for-archs include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~rfp-safety-net-for-archs	2005-08-11 13:46:49.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-08-11 13:55:02.000000000 +0200
@@ -361,6 +361,9 @@ static inline pte_t pte_modify(pte_t pte
 
 #include <asm-generic/pgtable-nopud.h>
 
+/* Hack for not-updated archs, KILLME after 2.6.16! */
+#define __ARCH_SUPPORTS_VM_NONUNIFORM
+
 #endif
 #endif
 
diff -puN Documentation/feature-removal-schedule.txt~rfp-safety-net-for-archs Documentation/feature-removal-schedule.txt
--- linux-2.6.git/Documentation/feature-removal-schedule.txt~rfp-safety-net-for-archs	2005-08-11 14:06:00.000000000 +0200
+++ linux-2.6.git-paolo/Documentation/feature-removal-schedule.txt	2005-08-11 14:10:34.000000000 +0200
@@ -135,3 +135,15 @@ Why:	With the 16-bit PCMCIA subsystem no
 	pcmciautils package available at
 	http://kernel.org/pub/linux/utils/kernel/pcmcia/
 Who:	Dominik Brodowski <linux@brodo.de>
+
+---------------------------
+
+What:	__ARCH_SUPPORTS_VM_NONUNIFORM
+When:	December 2005
+Files:	mm/fremap.c, include/asm-*/pgtable.h
+Why:	It's just there to allow arches to update their page fault handlers to
+	support VM_FAULT_SIGSEGV, for remap_file_pages protection support.
+	Since they may BUG if this support is not added, the syscall code
+	refuses this new operation mode unless the arch declares itself as
+	"VM_FAULT_SIGSEGV-aware" with this macro.
+Who:	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
_
