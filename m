Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWFTIpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWFTIpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWFTIpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:45:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52163 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965062AbWFTIpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:45:07 -0400
Date: Tue, 20 Jun 2006 10:40:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: [patch] fix spinlock-debug looping
Message-ID: <20060620084001.GC7899@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org> <20060619083518.GA14265@elte.hu> <20060619021314.a6ce43f5.akpm@osdl.org> <20060619113943.GA18321@elte.hu> <20060619125531.4c72b8cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619125531.4c72b8cc.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > > > The write_trylock + __delay in the loop is not a problem or a bug, as 
> > > > the trylock will at most _increase_ the delay - and our goal is to not 
> > > > have a false positive, not to be absolutely accurate about the 
> > > > measurement here.
> > > 
> > > Precisely.  We have delays of over a second (but we don't know how 
> > > much more than a second).  Let's say two seconds.  The NMI watchdog 
> > > timeout is, what?  Five seconds?
> > 
> > i dont see the problem.
> 
> It's taking over a second to acquire a write_lock.  A lock which is 
> unlikely to be held for more than a microsecond anywhere.  That's 
> really bad, isn't it?  Being on the edge of an NMI watchdog induced 
> system crash is bad, too.

i obviously agree that any such crash is a serious problem, but is it 
caused by the spinlock-debugging code? I doubt it is, unless __delay() 
is seriously buggered.

in any case, to move this problem forward i'd suggest we go with the 
patch below in -mm and wait for feedback. It fixes a potential overflow 
in the comparison (if HZ*lpj overflows 32-bits) That needs a really fast 
box to run the 32-bit kernel though, so i doubt this is the cause of the 
problems. In any case, this change makes it easier to increase the 
looping timeout from 1 second to 10 seconds later on or so - at which 
point the overflow can happen for real and must be handled .

	Ingo

------------
Subject: fix spinlock-debug looping
From: Ingo Molnar <mingo@elte.hu>

make sure the right hand side of the comparison does not overflow
on 32-bits. Also print out more info when detecting a lockup, so
that we see how many times the code tried (and failed) to get the
lock.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 lib/spinlock_debug.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -104,7 +104,7 @@ static void __spin_lock_debug(spinlock_t
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * HZ; i++) {
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -112,10 +112,10 @@ static void __spin_lock_debug(spinlock_t
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: spinlock lockup on CPU#%d, "
-					"%s/%d, %p\n",
+			printk(KERN_EMERG "BUG: possible spinlock lockup on CPU#%d, "
+					"%s/%d, %p [%Ld/%ld]\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				current->pid, lock, i, loops_per_jiffy);
 			dump_stack();
 		}
 	}
@@ -169,7 +169,7 @@ static void __read_lock_debug(rwlock_t *
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * HZ; i++) {
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -177,10 +177,10 @@ static void __read_lock_debug(rwlock_t *
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: read-lock lockup on CPU#%d, "
-					"%s/%d, %p\n",
+			printk(KERN_EMERG "BUG: possible read-lock lockup on CPU#%d, "
+					"%s/%d, %p [%Ld/%ld]\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				current->pid, lock, i, loops_per_jiffy);
 			dump_stack();
 		}
 	}
@@ -242,7 +242,7 @@ static void __write_lock_debug(rwlock_t 
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * HZ; i++) {
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -250,10 +250,10 @@ static void __write_lock_debug(rwlock_t 
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: write-lock lockup on CPU#%d, "
-					"%s/%d, %p\n",
+			printk(KERN_EMERG "BUG: possible write-lock lockup on CPU#%d, "
+					"%s/%d, %p [%Ld/%ld]\n",
 				raw_smp_processor_id(), current->comm,
-				current->pid, lock);
+				current->pid, lock, i, loops_per_jiffy);
 			dump_stack();
 		}
 	}
