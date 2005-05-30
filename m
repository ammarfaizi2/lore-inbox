Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVE3W1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVE3W1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVE3W1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:27:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25482 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261718AbVE3W1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:27:24 -0400
Date: Tue, 31 May 2005 00:27:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] flush icache in correct context
Message-ID: <Pine.LNX.4.61.0505302313580.3728@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

flush_icache_range() is used in two different situation - in binfmt_elf.c 
& co for user space mappings and module.c for kernel modules. On m68k 
flush_icache_range() doesn't know which data to flush, as it has separate 
address spaces and the pointer argument can be valid in either address 
space.
First I considered splitting flush_icache_range(), but this patch is 
simpler. Setting the correct context gives flush_icache_range() enough 
information to flush the correct data.

bye, Roman

---

 kernel/module.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: linux-2.6-mm/kernel/module.c
===================================================================
--- linux-2.6-mm.orig/kernel/module.c	2005-05-30 22:17:40.890503434 +0200
+++ linux-2.6-mm/kernel/module.c	2005-05-30 22:18:59.804961363 +0200
@@ -1758,6 +1758,7 @@ sys_init_module(void __user *umod,
 		const char __user *uargs)
 {
 	struct module *mod;
+	mm_segment_t old_fs = get_fs();
 	int ret = 0;
 
 	/* Must have permission */
@@ -1775,6 +1776,9 @@ sys_init_module(void __user *umod,
 		return PTR_ERR(mod);
 	}
 
+	/* flush the icache in correct context */
+	set_fs(KERNEL_DS);
+
 	/* Flush the instruction cache, since we've played with text */
 	if (mod->module_init)
 		flush_icache_range((unsigned long)mod->module_init,
@@ -1783,6 +1787,8 @@ sys_init_module(void __user *umod,
 	flush_icache_range((unsigned long)mod->module_core,
 			   (unsigned long)mod->module_core + mod->core_size);
 
+	set_fs(old_fs);
+
 	/* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
 	stop_machine_run(__link_module, mod, NR_CPUS);
