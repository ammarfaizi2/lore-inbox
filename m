Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUBQR0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUBQR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:26:48 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35031
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266337AbUBQR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:26:46 -0500
Date: Tue, 17 Feb 2004 18:26:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: module unload deadlock
Message-ID: <20040217172646.GT4478@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got bugreports for a deadlock due semaphore recursion in the module
unload code of 2.6.

You considered the recursion issue for the ->init but not for the
->exit.

sys_delete_module calls ->exit with the mutex held, cleanup_module calls
request_module(), modprobe reads /proc/modules and it deadlocks on the
mutex. This results in rmmod deadlocking and all the module subsystem
hung.

the actual module doing request_modules in the cleanup handler is
parport_pc, calling parport_enumerate (it calls it for another reason,
and parport enumerate is told to load up a lowlevel driver if none was
present, that's worthless for the unload routine but it's useful for all
other calls of parport_enumerate). It's uncertain if other drivers
triggers this deadlock.

This untested two liner will fix it, it's not obviously safe, but it
looks like safe thanks to the MODULE_STATE_GOING read inside the
critical sections protected by the mutex (like in
strong_try_module_get), and if this is not safe the module loading
probably wouldn't be safe either in presence of ->init failures. If it's
not completely safe still it can be made safe using MODULE_STATE_GOING.

It would be possible to fix this problem also by passing a parameter to
parport_enumerate, to avoid calling request_module if invoked within the
cleanup_module routine, but the below looks more generic and it looks
like the module code is already robust enough to handle such lock-drop,
so I guess it's preferable.

Comments?

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
