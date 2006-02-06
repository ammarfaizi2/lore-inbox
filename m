Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWBFVhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWBFVhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBFVhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:37:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:35801 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932188AbWBFVhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:37:50 -0500
Date: Mon, 6 Feb 2006 22:36:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent spinlock debug from timing out too early
Message-ID: <20060206213618.GA28566@elte.hu>
References: <200602062216.28943.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602062216.28943.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Index: linux-2.6.15/lib/spinlock_debug.c
> ===================================================================
> --- linux-2.6.15.orig/lib/spinlock_debug.c
> +++ linux-2.6.15/lib/spinlock_debug.c
> @@ -68,13 +68,13 @@ static inline void debug_spin_unlock(spi
>  static void __spin_lock_debug(spinlock_t *lock)
>  {
>  	int print_once = 1;
> -	u64 i;
>  
>  	for (;;) {
> -		for (i = 0; i < loops_per_jiffy * HZ; i++) {
> -			cpu_relax();
> +		unsigned long timeout = jiffies + HZ;
> +		while (time_before(jiffies, timeout)) {
>  			if (__raw_spin_trylock(&lock->raw_lock))
>  				return;
> +			cpu_relax();

The reason i added a loop counter was to solve the case where we are 
spinning with interrupts disabled - jiffies wont increase there!  But i 
agree that loops_per_jiffy is the wrong metric to use.

a better solution would be to call __delay(1) after the first failed 
attempt, that would make the delay at least 1 second long. It seems 
__delay() is de-facto exported by every architecture, so we can rely on 
it in the global spinlock code.

So how about the patch below instead?

[detail: i moved the __delay() after the second attempted trylock, this 
way we'll have 2 trylocks without a delay - for ultra-short critical 
sections.]

	Ingo

----
fix spinlock debugging delays to not time out too early.
Bug found by Andi Kleen.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/lib/spinlock_debug.c.orig
+++ linux/lib/spinlock_debug.c
@@ -72,9 +72,9 @@ static void __spin_lock_debug(spinlock_t
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -144,9 +144,9 @@ static void __read_lock_debug(rwlock_t *
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -217,9 +217,9 @@ static void __write_lock_debug(rwlock_t 
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
