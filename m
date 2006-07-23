Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWGWAko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWGWAko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWGWAko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:40:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750995AbWGWAkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:40:43 -0400
Date: Sat, 22 Jul 2006 17:36:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-Id: <20060722173649.952f909f.akpm@osdl.org>
In-Reply-To: <20060722233638.GC27566@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 01:36:38 +0200
Matthias Urlichs <smurf@smurf.noris.de> wrote:

> Hi,
> 
> the change 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa
>     [PATCH] Time: i386 Clocksource Drivers
> 
>     Implement the time sources for i386 (acpi_pm, cyclone, hpet, pit, and tsc).
>     With this patch, the conversion of the i386 arch to the generic timekeeping
>     code should be complete.
> 
>     The patch should be fairly straight forward, only adding the new clocksources.
> 
> causes the clocks of the two CPUs in my dual-Xeon server to lose
> (or, maybe, never gain) sync.
> 
> Before this change, they're in sync; afterwards, they're not.
> 
> This is a problem because, as soon as the system decides to switch CPUs
> while a program is sleeping (which happens quite early during boot-up),
> that sleep takes a *long* time. :-/
> 
> Checked by simply running "date" repeatedly. Thanks to Linux' superb
> scheduler, this command reliably runs on alternate CPUs, thereby
> demonstrating the problem, and I didn't have to resort to "taskset".
> 
> 
> Boot log:
> 
> Linux version 2.6.17-test-1.29 (root@kiste) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Sun Jul 23 01:05:35 CEST 2006

What is 2.6.17-test-1.29?

How do you know that 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa caused this?

> checking TSC synchronization across 4 CPUs: 

That code's a bit sick.  But nothing much has changed in there.

> Time: tsc clocksource has been installed.

OK.

Are you able to test the below?  It should fix up the reporting.

Are you able to compare the present bootlog with the 2.6.17 bootlog?

AFAICT the "fixed it up" claim is simply untrue.  Odd.


--- a/arch/i386/kernel/smpboot.c~synchronize_tsc-fixes
+++ a/arch/i386/kernel/smpboot.c
@@ -215,7 +215,7 @@ valid_k7:
 static atomic_t tsc_start_flag = ATOMIC_INIT(0);
 static atomic_t tsc_count_start = ATOMIC_INIT(0);
 static atomic_t tsc_count_stop = ATOMIC_INIT(0);
-static unsigned long long tsc_values[NR_CPUS];
+static unsigned long long __initdata tsc_values[NR_CPUS];
 
 #define NR_LOOPS 5
 
@@ -286,7 +286,6 @@ static void __init synchronize_tsc_bp (v
 	avg = sum;
 	do_div(avg, num_booting_cpus());
 
-	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_isset(i, cpu_callout_map))
 			continue;
@@ -297,7 +296,8 @@ static void __init synchronize_tsc_bp (v
 		 * We report bigger than 2 microseconds clock differences.
 		 */
 		if (delta > 2*one_usec) {
-			long realdelta;
+			long long realdelta;
+
 			if (!buggy) {
 				buggy = 1;
 				printk("\n");
@@ -307,12 +307,10 @@ static void __init synchronize_tsc_bp (v
 			if (tsc_values[i] < avg)
 				realdelta = -realdelta;
 
-			if (realdelta > 0)
-				printk(KERN_INFO "CPU#%d had %ld usecs TSC "
+			if (realdelta)
+				printk(KERN_INFO "CPU#%d had %Ld usecs TSC "
 					"skew, fixed it up.\n", i, realdelta);
 		}
-
-		sum += delta;
 	}
 	if (!buggy)
 		printk("passed.\n");
_

