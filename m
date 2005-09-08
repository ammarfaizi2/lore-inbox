Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVIHPdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVIHPdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVIHPdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:33:17 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:8586 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932532AbVIHPdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:33:16 -0400
Date: Thu, 8 Sep 2005 08:33:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-ID: <20050908153314.GM3966@smtp.west.cox.net>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:

> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Debugging and maintenance support code occasionally needs to know not
> only of module insertions, but also modulke removals. This adds a
> notifier
> chain for this purpose.

It's possible to do this a bit differently, if I'm guessing right at
what NLKD does.  The following is from the KGDB patches (trimmed of some
other, unrelated to the notify part code):

diff -puN include/linux/module.h~module include/linux/module.h
--- linux-2.6.13/include/linux/module.h~module	2005-09-01 12:00:49.000000000 -0700
+++ linux-2.6.13-trini/include/linux/module.h	2005-09-01 12:00:49.000000000 -0700
@@ -210,6 +210,7 @@ enum module_state
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+ 	MODULE_STATE_GONE,
 };
 
 /* Similar stuff for section attributes. */
diff -puN kernel/module.c~module kernel/module.c
--- linux-2.6.13/kernel/module.c~module	2005-09-01 12:00:49.000000000 -0700
+++ linux-2.6.13-trini/kernel/module.c	2005-09-01 12:00:49.000000000 -0700
@@ -623,6 +623,12 @@ sys_delete_module(const char __user *nam
 	if (ret != 0)
 		goto out;
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+        			mod);
+	up(&notify_mutex);
+
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -635,6 +641,11 @@ sys_delete_module(const char __user *nam
 	}
 	free_module(mod);
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GONE,
+			NULL);
+	up(&notify_mutex);
+
  out:
 	up(&module_mutex);
 	return ret;
@@ -1909,6 +1961,10 @@ sys_init_module(void __user *umod,
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
+		down(&notify_mutex);
+		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+				mod);
+		up(&notify_mutex);
 		synchronize_sched();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
_
-- 
Tom Rini
http://gate.crashing.org/~trini/
