Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRCRXta>; Sun, 18 Mar 2001 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRCRXtU>; Sun, 18 Mar 2001 18:49:20 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:6157 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131300AbRCRXtH>; Sun, 18 Mar 2001 18:49:07 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Q: "kapm-idled" and CPU usage
Date: 18 Mar 2001 23:47:40 -0000
Organization: Alfie's Internet Node
Message-ID: <993hes$2pb$1@alfie.demon.co.uk>
In-Reply-To: <3AB50177.47489C00@mandrakesoft.com>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@mandrakesoft.com (Jeff Garzik) writes:
> Is there some way to hack the scheduler statistics so that idle
> processes are special cases, which do not accumulate CPU time nor
> contribute to the load average?

I wondered about getting kapm-idled to take the CPU time allocated to
itself, and reallocate to the idle task.  Something like the following
at a strategic point inside the apm loop.

    unsigned long user, system;
    user = current->times.tms_utime;
    system = current->times.tms_stime;
    current->times.tms_utime = current->times.tms_stime = 0;
    idle->times.tms_utime += user;
    idle->times.tms_stime += system;

I haven't looked to see what point would be a good idea, and investigated
what locks need to be held.  I've also just peeked at the 2.4 code,
and seen "current->per_cpu_utime[cpu]" -- does this need handling?
Is it visible to user space?

If you looked closely, you might see the CPU time falling for kapm-idled,
but generally you would see it allocated to the idle task, and not
kapm-idled.

> I agree that it's not pretty to special case idle function process(es),
> but those idle functions in turn are causing an incorrect picture of the
> system state to be presented to userland.

At least with this scheme, the special casing is inside the kapm specific
code, and not within the general timer handling.

Of course, this is no more than an idea.  I haven't got as far as
running 2.4 on my only APM machine (486 Thinkpad), let alone trying out
this scheme.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
