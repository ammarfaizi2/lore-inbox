Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUBRERR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBREQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:16:46 -0500
Received: from dp.samba.org ([66.70.73.150]:11693 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263537AbUBREPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:15:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: module unload deadlock 
In-reply-to: Your message of "Tue, 17 Feb 2004 18:26:46 BST."
             <20040217172646.GT4478@dualathlon.random> 
Date: Wed, 18 Feb 2004 14:29:21 +1100
Message-Id: <20040218041527.052222C510@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040217172646.GT4478@dualathlon.random> you write:
> I've got bugreports for a deadlock due semaphore recursion in the module
> unload code of 2.6.
> 
> You considered the recursion issue for the ->init but not for the
> ->exit.

I considered it, but no cleanup called request_module which I
(reluctantly, as it made the locking non-trivial) dropped the lock
around init.

> the actual module doing request_modules in the cleanup handler is
> parport_pc, calling parport_enumerate (it calls it for another reason,
> and parport enumerate is told to load up a lowlevel driver if none was
> present, that's worthless for the unload routine but it's useful for all
> other calls of parport_enumerate). It's uncertain if other drivers
> triggers this deadlock.

Well, that's pretty stupid, but I think this should be fixed in the
module code for a practical reason: the number of oopses or hangs in
rmmod functions.  Bad enough that the module is useless: stopping
other module operations is very suboptimal.

> Comments?

Patch seems OK to me.  I'd prefer it to go via the -mm tree though to
shake things out in case I've missed something.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.


Name: Drop Lock Around Module Exit
Status: Experimental
From: Andrea Arcangeli <andrea@suse.de>

Turns out parport can do request_module from its exit function.  We
should drop lock anyway, because too many module exit functions oops
or hang anyway, rendering all module ops useless.

--- SLES/kernel/module.c.~1~	2004-02-12 17:24:42.000000000 +0100
+++ SLES/kernel/module.c	2004-02-17 18:08:05.519670280 +0100
@@ -732,7 +732,9 @@ sys_delete_module(const char __user *nam
 		wait_for_zero_refcount(mod);
 
 	/* Final destruction now noone is using it. */
+	up(&module_mutex);
 	mod->exit();
+	down(&module_mutex);
 	free_module(mod);
 
  out:

