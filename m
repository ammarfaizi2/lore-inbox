Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEHQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTEHQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:28:46 -0400
Received: from verein.lst.de ([212.34.181.86]:62734 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261807AbTEHQ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:28:45 -0400
Date: Thu, 8 May 2003 18:41:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] module_arch_cleanup()
Message-ID: <20030508184117.A26726@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64 needs to be able to hook into module unloading to get rid of
the unwind tables for modules.  (The actual implementation already
is in arch/ia64/kernel/module.c, David just seems to be to shy to
submit core changes :))


--- 1.11/include/asm-ia64/module.h	Wed Mar 26 04:08:03 2003
+++ edited/include/asm-ia64/module.h	Thu May  8 10:12:36 2003
@@ -31,4 +31,7 @@
 
 #define ARCH_SHF_SMALL	SHF_IA_64_SHORT
 
+void module_arch_cleanup(struct module *mod);
+#define __HAVE_ARCH_MODULE_CLEANUP	1
+
 #endif /* _ASM_IA64_MODULE_H */
--- 1.80/kernel/module.c	Wed Apr 30 10:17:38 2003
+++ edited/kernel/module.c	Thu May  8 10:13:28 2003
@@ -47,6 +47,11 @@
 #define ARCH_SHF_SMALL 0
 #endif
 
+/* Some architectures (like ia64) need to hook into module unloading */
+#ifndef __HAVE_ARCH_MODULE_CLEANUP
+#define module_arch_cleanup(mod)	do { } while (0)
+#endif
+
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
@@ -909,6 +914,9 @@
 	spin_lock_irq(&modlist_lock);
 	list_del(&mod->list);
 	spin_unlock_irq(&modlist_lock);
+
+	/* Arch-specific cleanup. */
+	module_arch_cleanup(mod);
 
 	/* Module unload stuff */
 	module_unload_free(mod);
