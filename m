Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbSJLFr7>; Sat, 12 Oct 2002 01:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSJLFr6>; Sat, 12 Oct 2002 01:47:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4810 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262811AbSJLFr5>; Sat, 12 Oct 2002 01:47:57 -0400
Date: Sat, 12 Oct 2002 07:53:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, John Stultz <johnstul@us.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210120746530.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.41 to v2.5.42
> ============================================
>...
> John Stultz <johnstul@us.ibm.com>:
>...
>   o linux-2.5.41_timer-changes_A4 (2/3 - bulk move)
>...


This patch moved cpufreq stuff from time.c to timers/timer_tsc.c but not
the corresponding #include <linux/cpufreq.h> causing the following compile
error:

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/kernel/timers/.timer_tsc.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=timer_tsc   -c -o
arch/i386/kernel/timers/timer_tsc.o arch/i386/kernel/timers/timer_tsc.c
arch/i386/kernel/timers/timer_tsc.c: In function `time_cpufreq_notifier':
arch/i386/kernel/timers/timer_tsc.c:181: `CPUFREQ_PRECHANGE' undeclared
...
arch/i386/kernel/timers/timer_tsc.c:183: `CPUFREQ_ALL_CPUS' undeclared
...
arch/i386/kernel/timers/timer_tsc.c:192: `CPUFREQ_POSTCHANGE' undeclared
...
arch/i386/kernel/timers/timer_tsc.c:265: `CPUFREQ_TRANSITION_NOTIFIER' undeclared
...
make[2]: *** [arch/i386/kernel/timers/timer_tsc.o] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.5.42-full/arch/i386/kernel/time.c.old	2002-10-12 07:43:55.000000000 +0200
+++ linux-2.5.42-full/arch/i386/kernel/time.c	2002-10-12 07:44:05.000000000 +0200
@@ -43,7 +43,6 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/cpufreq.h>

 #include <asm/io.h>
 #include <asm/smp.h>
--- linux-2.5.42-full/arch/i386/kernel/timers/timer_tsc.c.old	2002-10-12 07:40:26.000000000 +0200
+++ linux-2.5.42-full/arch/i386/kernel/timers/timer_tsc.c	2002-10-12 07:44:25.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>
+#include <linux/cpufreq.h>

 #include <asm/timer.h>
 #include <asm/io.h>


cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


