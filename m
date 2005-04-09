Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVDIFvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVDIFvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 01:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVDIFvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 01:51:16 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:56734 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261291AbVDIFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 01:50:59 -0400
Date: Fri, 8 Apr 2005 22:50:58 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: philip dahlquist <dahlquist@kreative.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: easy softball jiffies quest(ion)
In-Reply-To: <20050409010252.2eca2177.dahlquist@kreative.net>
Message-ID: <Pine.LNX.4.58.0504082227250.13568@shell3.speakeasy.net>
References: <20050409010252.2eca2177.dahlquist@kreative.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, philip dahlquist wrote:

> hi,

Hello,

> i'm on a quest to get access to jiffies in user space so i can write a
> simple stepper motor driver program.  i co-opted the "#includes" list
> from alessandro rubini's jit.c file from "linux device drivers" to write
> jfi.c.

Now, I might be _entirely_ off-base here, but... from what I know (which
is, admittedly, less than what many others here do) jiffies are a
kernel-land concept, implemented using a kernel-land variable. The
kernel protects itself from user-land programs, so your user-land
program will never be able to access the jiffies variable directly like
that.

As far as I know, it breaks down like this: If you want jiffies, then
your code should be a kernel module. If you want your code to run in
user-land, then you have to settle for knowing the time using alarm(),
clock_gettime(), gettimeofday(), or similar system-call-based mechanism.

> this is it:
> ------------------------------------------------------------------
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/moduleparam.h>
> #include <linux/init.h>
>
> #include <linux/time.h>
> #include <linux/timer.h>
> #include <linux/kernel.h>
> #include <linux/proc_fs.h>
> #include <linux/types.h>
> #include <linux/spinlock.h>
> #include <linux/interrupt.h>
>
> #include <asm/hardirq.h>
>
>
> int main(void)
> {
> 	unsigned long j = jiffies + (50 * HZ);
> 	printf("start jiffies = %9li\n",jiffies);
> 	while(jiffies < j)
> 		;
>
> 	printf("done jiffies = %9li\n", jiffies);
> 	return 0;
> }
>
> -----------------------------------------------------------
> all right, you can giggle, but no laughing out loud, my kernel ego is
> nacent and fragile.
>
> when i compile it with:
>
> gcc -o jfi.x jfi.c
>
> i get a handful of errors regarding various #include statements:
> -------------------------------------------------
> jfi.c:3:31: linux/moduleparam.h: No such file or directory
> In file included from jfi.c:6:
> /usr/include/linux/time.h:10: error: syntax error before "time_t"
> /usr/include/linux/time.h:12: error: syntax error before '}' token
> /usr/include/linux/time.h:18: error: syntax error before "time_t"
> /usr/include/linux/time.h:44: error: field `it_interval' has incomplete type
> /usr/include/linux/time.h:45: error: field `it_value' has incomplete type
> /usr/include/linux/time.h:49: error: field `it_interval' has incomplete type
> /usr/include/linux/time.h:50: error: field `it_value' has incomplete type
> jfi.c:7:25: linux/timer.h: No such file or directory
> In file included from /usr/include/linux/interrupt.h:9,
>                  from jfi.c:12:
> /usr/include/asm/bitops.h:327:2: warning: #warning This include file is
> not available on all architectures.
> /usr/include/asm/bitops.h:328:2: warning: #warning Using kernel headers
> in userspace: atomicity not guaranteed
> In file included from jfi.c:12:
> /usr/include/linux/interrupt.h:12:25: asm/hardirq.h: No such file or directory
> /usr/include/linux/interrupt.h:13:25: asm/softirq.h: No such file or directory
>
> jfi.c: In function `main':
> jfi.c:19: error: `jiffies' undeclared (first use in this function)
> jfi.c:19: error: (Each undeclared identifier is reported only once
> jfi.c:19: error: for each function it appears in.)
> ./jfsh: line 8: jfi.x: command not found
> ---------------------------------------------------------------------

All the above errors come from the fact that you're trying to use
kernel-land include files and definitions within a user-program.
Probably not doable.

> i kind of figured you guys would know what to do.  it's sort of a rarefied
> group.  anyway, if you can help, i'd really appreciate it, because
> alessandro's makefile was somewhat cryptic.
>
>
> you know, the operating systems class this semester at the university
> of maryland, college park, was taught based on that new, exciting os, win xp.
> and he managed to turn a 2 day class, where a day has a lecture and a lab,
> into a 4 day affair, monday lecture, tuesday lab, wednesday lecture, thursday
> lab. i took data structures instead. i am not taking any win xp os
> class. it's linux or nothing.  can you believe that, win xp?

(Keep in mind that the following is my opinion only.) I'd say that
taking a Windows class might still be educational. Operating systems are
such a thing where learning one helps you understand a great deal about
_all_ of them. If anything, it'll at least give you more educated
reasons for disliking / hating our "favorite" monopolistic company or
operating system. :-)

> one more thing, um, i'm paralyzed from the shoulders down, but i can type
> with both hands using typing aids, and i also use a kensington "expert mouse"
> trackball.  i would like to write a mouse manager where i could assign
> different actions for each button, something very similar to the kensington
> interface that's available for, um, windows.  i found some xwindow functions
> for button pressing events, but i don't know how to get into the mouse driver
> or button events in xwindows or gnome, etc.

Depends upon what functionality you want to have those buttons to have.
If it's nothing super fancy, it might very well be doable in user-space
without having to muck around inside the kernel. A combination of
xmodmap and configuration files, maybe? (Not an expert on this, I'm
afraid to say.)

> if somebody has a direction to go for that, that would be a big help.
>
> thanks, or tgfl(inux),
> philip dahlquist

Vadim Lobanov.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
