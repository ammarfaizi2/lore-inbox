Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUASLcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbUASLbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:31:46 -0500
Received: from dp.samba.org ([66.70.73.150]:36570 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264565AbUASLbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:31:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: tmolina@cablespeed.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 
In-reply-to: Your message of "Sat, 17 Jan 2004 10:52:39 -0800."
             <20040117105239.0b94f2b3.akpm@osdl.org> 
Date: Mon, 19 Jan 2004 22:29:41 +1100
Message-Id: <20040119113132.CB82E2C2A1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040117105239.0b94f2b3.akpm@osdl.org> you write:
> Yes.  ksoftirqd and the migration threads can now be killed off
> with `kill -9'.

Fix below.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Block Signals For Early Kthreads
Author: Rusty Russell
Status: Booted on 2.6.1-bk4
Depends: Hotcpu-New-Kthread/use-kthread-simple.patch.gz

D: Kthreads created at boot before "keventd" are spawned directly.
D: However, this means that they don't have all signals blocked, and
D: hence can be killed.  The simplest solution is to always explicitly
D: block all signals in the kthread.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29870-linux-2.6.1-mm4/kernel/kthread.c .29870-linux-2.6.1-mm4.updated/kernel/kthread.c
--- .29870-linux-2.6.1-mm4/kernel/kthread.c	2004-01-19 18:12:53.000000000 +1100
+++ .29870-linux-2.6.1-mm4.updated/kernel/kthread.c	2004-01-19 21:45:53.000000000 +1100
@@ -32,12 +32,18 @@ static int kthread(void *_create)
 	struct kthread_create_info *create = _create;
 	int (*threadfn)(void *data);
 	void *data;
+	sigset_t blocked;
 	int ret = -EINTR;
 
 	/* Copy data: it's on keventd's stack */
 	threadfn = create->threadfn;
 	data = create->data;
 
+	/* Block and flush all signals (in case we're not from keventd). */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
