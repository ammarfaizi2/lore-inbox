Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVBAHSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVBAHSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVBAHSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:18:15 -0500
Received: from [218.94.84.61] ([218.94.84.61]:27141 "EHLO
	mail.mobilesoft.com.cn") by vger.kernel.org with ESMTP
	id S261632AbVBAHSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:18:11 -0500
Subject: [PATCH] 2.6.11-rc2-mm2 can't insmod modules correctly!
From: Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:14:23 +0800
Message-Id: <1107242063.1881.0.camel@milo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I update to the 2.6.11-rc2-mm2, I couldn't insmod any module
successfully.

And I traced the module insert procedure. I got the stop_machine_run()
is defined as do-nothing function when CONFIG_STOP_MACHINE is undefined.
So __link_module can't be called at all.


My little patch is below:


--- kernel/module.c.original    2005-01-31 16:44:37.000000000 +0800
+++ kernel/module.c     2005-02-01 15:01:49.000000000 +0800
@@ -1761,7 +1761,7 @@ static struct module *load_module(void _
  * link the module with the whole machine is stopped with interrupts
off
  * - this defends against kallsyms not taking locks
  */
-static int __link_module(void *_mod)
+static inline int __link_module(void *_mod)
{
        struct module *mod = _mod;
        list_add(&mod->list, &modules);
@@ -1802,7 +1802,9 @@ sys_init_module(void __user *umod,

        /* Now sew it into the lists.  They won't access us, since
            strong_try_module_get() will fail. */
-       stop_machine_run(__link_module, mod, NR_CPUS);
+       spin_lock_irq(&modlist_lock);
+       __link_module(mod);
+       spin_unlock_irq(&modlist_lock);

-- 
Zhonglin Zhang <zhonglinzh@mobilesoft.com.cn>

