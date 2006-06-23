Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932928AbWFWICU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbWFWICU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbWFWICT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:02:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59604 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932928AbWFWICS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:02:18 -0400
Date: Fri, 23 Jun 2006 09:57:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Olson <olson@unixfolk.com>
Cc: Andrew Morton <akpm@osdl.org>, ccb@acm.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock and NMI)
Message-ID: <20060623075713.GA31178@elte.hu>
References: <Pine.LNX.4.61.0606212243240.32136@osa.unixfolk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606212243240.32136@osa.unixfolk.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Olson <olson@unixfolk.com> wrote:

> | >     CONFIG_DEBUG_SPINLOCK=y
> | >     CONFIG_DEBUG_SPINLOCK_SLEEP=y
> | It would be super-interesting to know whether 
> | CONFIG_DEBUG_SPINLOCK=n improves things.
> 
> It does.  No stalls, hangs, or nmi's in several hours of running the 
> test that previously failed on almost every run (with long stalls, 
> system hangs, or NMI watchdogs), on the same hardware.
> 
> I made no other changes to the kernel config than turning both of the 
> above off.

we really need to figure out what's happening here! Could you re-enable 
spinlock debugging and try the patch below - do the stalls/lockups still 
happen?

	Ingo

---
 lib/spinlock_debug.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -104,10 +104,10 @@ static void __spin_lock_debug(spinlock_t
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (;;) {
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
-			__delay(1);
+			cpu_relax();
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -169,10 +169,10 @@ static void __read_lock_debug(rwlock_t *
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (;;) {
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
-			__delay(1);
+			cpu_relax();
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -242,10 +242,10 @@ static void __write_lock_debug(rwlock_t 
 	u64 i;
 
 	for (;;) {
-		for (i = 0; i < loops_per_jiffy * HZ; i++) {
+		for (;;) {
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
-			__delay(1);
+			cpu_relax();
 		}
 		/* lockup suspected: */
 		if (print_once) {
