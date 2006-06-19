Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWFSHHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWFSHHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFSHHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:07:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54450 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751139AbWFSHH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:07:29 -0400
Date: Mon, 19 Jun 2006 09:02:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Charles C. Bennett, Jr." <ccb@acm.org>, linux-kernel@vger.kernel.org
Subject: [patch] increase spinlock-debug looping timeouts from 1 sec to 1 min
Message-ID: <20060619070229.GA8293@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com> <20060617100710.ec05131f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060617100710.ec05131f.akpm@osdl.org>
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

> Well.  Obviously __write_lock_debug():print_once was meant to have 
> static scope (__read_mostly, too).  But that's a cosmetic thing.

no - this is an infinite loop we must not break out of, and we only want 
to print the warning once per infinite loop. But we dont want to shut up 
these messages globally. (so that we get a backtrace on all CPUs that 
are looping, etc.)

> I'm suspecting that the debug code has simply gone wrong here - that 
> there's such a lot of read_lock() traffic happening with this workload 
> that the debug version of write_lock() simply isn't able to take the 
> lock.

i'd go for the patch below - the current 1 second timeout might be both 
inadequate for really high loads, and it might also be unrobust when 
there's some miscalibration of loops_per_jiffies - turning a 1 sec 
timeout into half-a-sec timeout or so. Builds/boots here on 32-bit and 
64-bit.

	Ingo

-----------
Subject: increase spinlock-debug looping timeouts from 1 sec to 1 min
From: Ingo Molnar <mingo@elte.hu>

increase the loop timeouts from 1 second to 60 seconds. This should also
handle the occasional case of loops_per_jiffy miscalibration, and it
should handle false positives due to high workloads.

(also make sure the right hand side of the comparison does not overflow 
on 32-bits, and make the messages indicate that we dont know for a fact 
whether this is due to a lockup or due to some extreme load.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 lib/spinlock_debug.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -104,7 +104,7 @@ static void __spin_lock_debug(spinlock_t
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * 60 * HZ; i++) {
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -112,7 +112,7 @@ static void __spin_lock_debug(spinlock_t
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: spinlock lockup on CPU#%d, "
+			printk(KERN_EMERG "BUG: possible spinlock lockup on CPU#%d, "
 					"%s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
 				current->pid, lock);
@@ -169,7 +169,7 @@ static void __read_lock_debug(rwlock_t *
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * 60 * HZ; i++) {
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -177,7 +177,7 @@ static void __read_lock_debug(rwlock_t *
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: read-lock lockup on CPU#%d, "
+			printk(KERN_EMERG "BUG: possible read-lock lockup on CPU#%d, "
 					"%s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
 				current->pid, lock);
@@ -242,7 +242,7 @@ static void __write_lock_debug(rwlock_t 
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (i = 0; i < (u64)loops_per_jiffy * 60 * HZ; i++) {
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
 			__delay(1);
@@ -250,7 +250,7 @@ static void __write_lock_debug(rwlock_t 
 		/* lockup suspected: */
 		if (print_once) {
 			print_once = 0;
-			printk(KERN_EMERG "BUG: write-lock lockup on CPU#%d, "
+			printk(KERN_EMERG "BUG: possible write-lock lockup on CPU#%d, "
 					"%s/%d, %p\n",
 				raw_smp_processor_id(), current->comm,
 				current->pid, lock);
