Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWDGOcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWDGOcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWDGOcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:25 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31196 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932292AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/17] uml: fix some double export warnings
Date: Fri, 07 Apr 2006 16:31:03 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143102.19201.91032.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Some functions are exported twice in current code - remove the excess export.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/ksyms.c       |    5 +----
 arch/um/os-Linux/user_syms.c |    9 +++++++--
 arch/um/sys-i386/ksyms.c     |    4 ----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 7713e7a..432cf0b 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -39,7 +39,6 @@ EXPORT_SYMBOL(um_virt_to_phys);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
-EXPORT_SYMBOL(end_iomem);
 
 #ifdef CONFIG_MODE_TT
 EXPORT_SYMBOL(strncpy_from_user_tt);
@@ -89,12 +88,10 @@ EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
 
-/* This is here because UML expands open to sys_open, not to a system
+/* This is here because UML expands lseek to sys_lseek, not to a system
  * call instruction.
  */
-EXPORT_SYMBOL(sys_open);
 EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(sys_read);
 EXPORT_SYMBOL(sys_wait4);
 
 #ifdef CONFIG_SMP
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 8da6ab3..2598158 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -18,14 +18,19 @@ extern void *memmove(void *, const void 
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
 
+/* If they're not defined, the export is included in lib/string.c.*/
+#ifdef __HAVE_ARCH_STRLEN
 EXPORT_SYMBOL(strlen);
+#endif
+#ifdef __HAVE_ARCH_STRSTR
+EXPORT_SYMBOL(strstr);
+#endif
+
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(printf);
 
-EXPORT_SYMBOL(strstr);
-
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
  * However, the modules will use the CRC defined *here*, no matter if it is
  * good; so the versions of these symbols will always match
diff --git a/arch/um/sys-i386/ksyms.c b/arch/um/sys-i386/ksyms.c
index db524ab..2a1eac1 100644
--- a/arch/um/sys-i386/ksyms.c
+++ b/arch/um/sys-i386/ksyms.c
@@ -15,7 +15,3 @@ EXPORT_SYMBOL(__up_wakeup);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial);
-
-/* delay core functions */
-EXPORT_SYMBOL(__const_udelay);
-EXPORT_SYMBOL(__udelay);
