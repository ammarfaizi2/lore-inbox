Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUKXFDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUKXFDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 00:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUKXFDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 00:03:16 -0500
Received: from ozlabs.org ([203.10.76.45]:10418 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261774AbUKXFCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 00:02:35 -0500
Subject: Re: modprobe + request_module() deadlock
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@suse.de>
Cc: Johannes Stezenbach <js@convergence.de>,
       Johannes Stezenbach <js@linuxtv.org>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122165201.GA2060@bytesex>
References: <20041122102502.GF29305@bytesex>
	 <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex>
	 <20041122153637.GA10673@convergence.de>  <20041122165201.GA2060@bytesex>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 16:02:31 +1100
Message-Id: <1101272551.6186.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 17:52 +0100, Gerd Knorr wrote:
> > > I can fix that in the driver, by delaying the request_module() somehow
> > > until the saa7134 module initialization is finished.  I don't think that
> > > this is a good idea through as it looks like I'm not the only one with
> > > that problem ...
> > 
> > Delaying request_module() sounds ugly. Anyway, if you can
> > get it to work reliably...
> 
> I think I can, havn't tried yet through.

I still don't really like it as a solution, but this patch (pending
anyway) should help.

Rusty.

Name: More Module Notifiers
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Status: Trivial

Put in the rest of the module notifiers, esp. one when a module is
being removed.

Index: linux-2.6.10-rc2-bk8-Module/kernel/module.c
===================================================================
--- linux-2.6.10-rc2-bk8-Module.orig/kernel/module.c	2004-11-16 15:30:10.000000000 +1100
+++ linux-2.6.10-rc2-bk8-Module/kernel/module.c	2004-11-24 15:28:10.745436776 +1100
@@ -82,6 +82,13 @@
 }
 EXPORT_SYMBOL(unregister_module_notifier);
 
+static void module_notify(struct module *mod, enum module_state state)
+{
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, state, mod);
+	up(&notify_mutex);
+}
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -579,6 +586,8 @@
 	if (ret != 0)
 		goto out;
 
+	module_notify(mod, MODULE_STATE_GOING);
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -589,6 +598,7 @@
 		mod->exit();
 		down(&module_mutex);
 	}
+	module_notify(mod, MODULE_STATE_GONE);
 	free_module(mod);
 
  out:
@@ -1792,9 +1802,7 @@
 	/* Drop lock so they can recurse */
 	up(&module_mutex);
 
-	down(&notify_mutex);
-	notifier_call_chain(&module_notify_list, MODULE_STATE_COMING, mod);
-	up(&notify_mutex);
+	module_notify(mod, MODULE_STATE_COMING);
 
 	/* Start the module */
 	if (mod->init != NULL)
@@ -1803,12 +1811,14 @@
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
+		module_notify(mod, MODULE_STATE_GOING);
 		synchronize_kernel();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
 		else {
 			module_put(mod);
+			module_notify(mod, MODULE_STATE_GONE);
 			down(&module_mutex);
 			free_module(mod);
 			up(&module_mutex);
@@ -1826,6 +1836,7 @@
 	mod->init_size = 0;
 	mod->init_text_size = 0;
 	up(&module_mutex);
+	module_notify(mod, MODULE_STATE_LIVE);
 
 	return 0;
 }
Index: linux-2.6.10-rc2-bk8-Module/include/linux/module.h
===================================================================
--- linux-2.6.10-rc2-bk8-Module.orig/include/linux/module.h	2004-11-16 15:30:07.000000000 +1100
+++ linux-2.6.10-rc2-bk8-Module/include/linux/module.h	2004-11-24 15:28:10.767433432 +1100
@@ -220,6 +220,7 @@
 	MODULE_STATE_LIVE,
 	MODULE_STATE_COMING,
 	MODULE_STATE_GOING,
+	MODULE_STATE_GONE, /* Only for notifier: module about to be freed */
 };
 
 /* Similar stuff for section attributes. */

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

