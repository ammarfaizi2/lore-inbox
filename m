Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWCYSXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWCYSXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWCYSXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:23:40 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:20939 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751662AbWCYSXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:23:40 -0500
Date: Sat, 25 Mar 2006 19:23:32 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Comment on 2.6.16-rt6 PI
In-Reply-To: <1143295703.5344.120.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0603251912120.19918-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Thomas Gleixner wrote:

> On Sat, 2006-03-25 at 14:52 +0100, Esben Nielsen wrote:
>
> > In my test setup this leaves the owner->pi_waiters empty even though there
> > are waiters. I tried to move the removal of top_waiter inside the second
> > if statement but then a lot of other tests failed. I don't have time to
> > fix it.
>
> Can you please explain that more detailed how it happens ? And provide a
> test case ?
>

Sorry for the lack of details. I just thought the test-case wouldn't make
sense to you much and didn't paste it in. I was in a bit of a hurry too.
Now I have a little more time and can tell you what is going on:

top_waiter!=NULL
waiter!=NULL
waiter!=rt_mutex_top_waiter(lock)

Therefore one top_waiter is removed and but nothing is inserted.

Below is a fix.

Esben

> 	tglx
>
>
--- linux-2.6.16-rt6/kernel/rtmutex.c.orig	2006-03-25 19:14:35.000000000 +0100
+++ linux-2.6.16-rt6/kernel/rtmutex.c	2006-03-25 19:22:04.000000000 +0100
@@ -223,15 +223,22 @@ static void adjust_pi_chain(struct rt_mu
 	struct list_head *curr = lock_chain->prev;

 	for (;;) {
-		if (top_waiter)
+		if (top_waiter) {
 			plist_del(&top_waiter->pi_list_entry,
 				  &owner->pi_waiters);
-
-
-		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
+		}
+
+		if (waiter) {
 			waiter->pi_list_entry.prio = waiter->task->prio;
-			plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
 		}
+
+		if (rt_mutex_has_waiters(lock)) {
+			top_waiter = rt_mutex_top_waiter(lock);
+			plist_add(&top_waiter->pi_list_entry,
+				  &owner->pi_waiters);
+		}
+
+
 		adjust_prio(owner);

 		waiter = owner->pi_blocked_on;

