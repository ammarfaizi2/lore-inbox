Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUBEGFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 01:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUBEGFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 01:05:32 -0500
Received: from dp.samba.org ([66.70.73.150]:40105 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264428AbUBEGF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 01:05:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: rc3-mm1: oops in keventd_stop_kthread 
In-reply-to: Your message of "Wed, 04 Feb 2004 23:04:10 +0300."
             <20040204200410.GA3802@localhost.localdomain> 
Date: Thu, 05 Feb 2004 16:09:29 +1100
Message-Id: <20040205060543.09B542C270@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040204200410.GA3802@localhost.localdomain> you write:
> On Wed, Feb 04, 2004 at 02:00:06PM +1100, Rusty Russell wrote:
> > Um, why is ALSA using kthread?
> > 
> > Is there a modprobe -r in your script somewhere?
> 
> yes. not sure why it is called though.

Reproduced using your config, and fixed.  Classic use-after-free bug:
another victory for DEBUG_PAGEALLOC.

Thanks Andrey!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Kthread waitpid Race II
Author: Rusty Russell
Status: Tested on 2.6.2-rc3
Depends: Hotcpu/kthread-wait-race.patch.gz

We can't compare waitpid() result with stop->k->tgid, since the thread
will be gone by then (thanks to Andrey Borzenkov and
CONFIG_DEBUG_PAGEALLOC!

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.2-rc3-mm1/kernel/kthread.c tmp/kernel/kthread.c
--- linux-2.6.2-rc3-mm1/kernel/kthread.c	2004-02-04 12:29:18.000000000 +1100
+++ tmp/kernel/kthread.c	2004-02-05 15:56:07.000000000 +1100
@@ -107,7 +112,7 @@ static void adopt_kthread(struct task_st
 static void keventd_stop_kthread(void *_stop)
 {
 	struct kthread_stop_info *stop = _stop;
-	int status;
+	int status, pid;
 	sigset_t blocked;
 	struct k_sigaction sa;
 
@@ -119,11 +124,14 @@ static void keventd_stop_kthread(void *_
 	allow_signal(SIGCHLD);
 
 	adopt_kthread(stop->k);
+	/* Grab pid now: after waitpid(), stop->k is invalid. */
+	pid = stop->k->tgid;
+
 	/* All signals are blocked, hence the force. */
 	force_sig(SIGTERM, stop->k);
 	/* Other threads might exit: if we ask for one pid that
 	 * returns -ERESTARTSYS. */
-	while (waitpid(-1, &status, __WALL) != stop->k->tgid)
+	while (waitpid(-1, &status, __WALL) != pid)
 		flush_signals(current);
 	stop->result = -((status >> 8) & 0xFF);
 	complete(&stop->done);
