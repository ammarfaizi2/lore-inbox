Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRIIVoZ>; Sun, 9 Sep 2001 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273066AbRIIVoP>; Sun, 9 Sep 2001 17:44:15 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:41254 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273065AbRIIVoG>; Sun, 9 Sep 2001 17:44:06 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: grue@lakesweb.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010909185727.586B1597C5@g-box.vf.shawcable.net>
In-Reply-To: <20010909185727.586B1597C5@g-box.vf.shawcable.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 09 Sep 2001 17:44:22 -0400
Message-Id: <1000071864.16804.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 14:57, grue@lakesweb.com wrote:
> Just finished running some benchmarks on my workstation.
> Dual P3-550, 256MB ram, no swap, both kernels with CONFIG_SMP=y, 440BX,
> 2-20GB 5400rpm drives.
> 
> All benchmarks running in an Eterm on E on XF86-4.1.0-DRI with xmms running to
> listen for latency probs. Benchmarks run as root, everything else as regular
> user.

The XMMS bit is a neat idea -- good thinking :)

> linux-2.4.10-pre6 with rml-netdev-random patch and rml-preempt patch (pre5 patches
> applied to pre6), with CONFIG_PREEMPT=y
> 
> dbench 16
> Throughput 23.4608 MB/sec (NB=29.326 MB/sec  234.608 MBit/sec)
> Throughput 22.6915 MB/sec (NB=28.3644 MB/sec  226.915 MBit/sec) - .5sec hiccup in xmms
> Throughput 20.4314 MB/sec (NB=25.5392 MB/sec  204.314 MBit/sec) - .5sec hiccup in xmms
> Throughput 27.2849 MB/sec (NB=34.1061 MB/sec  272.849 MBit/sec) - .5sec hiccup in xmms
> Throughput 20.5148 MB/sec (NB=25.6435 MB/sec  205.148 MBit/sec) - 2sec and .5sec in xmms
> loadavg around 14
> 
> Bonnie
>               -------Sequential Output-------- ---Sequential Input-- --Random--
>               -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
> Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
>          1024  9002 98.0 15893 15.1  6519 10.8  6101 78.6 23330 24.4 104.3  2.2
> 
> linux-2.4.10-pre6
> 
> dbench 16
> Throughput 18.1821 MB/sec (NB=22.7276 MB/sec  181.821 MBit/sec)
> Throughput 22.4247 MB/sec (NB=28.0309 MB/sec  224.247 MBit/sec) - .5sec hiccup in xmms
> Throughput 20.2662 MB/sec (NB=25.3328 MB/sec  202.662 MBit/sec) - 2sec hiccup in xmms
> Throughput 28.4072 MB/sec (NB=35.5089 MB/sec  284.072 MBit/sec) - 3sec hiccup in xmms
> Throughput 24.0549 MB/sec (NB=30.0686 MB/sec  240.549 MBit/sec)
> loadavg around 14
> 
> Bonnie
>               -------Sequential Output-------- ---Sequential Input-- --Random--
>               -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
> Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
>          1024  9173 99.4 16104 14.5  6488 10.2  6139 78.9 23260 22.1 105.1  2.3
> 

I didn't average it out, but the dbench results seem to be slightly
better with preemption enabled, as they should be.  We have seen results
with significantly better results under preemption than not, but oh
well.  Your system is already SMP, so the benefit would not be as
noticable.

Bonnie should not be much different if it is not threading the I/O
across multiple processes, since there is nothing else to be preempted. 
If anything, the throughput should drop slightly with preemption
enabled.

> The biggest difference is in the usability of the system under the load.
> With 2.4.10-pre6 vanilla, dbench seriously affects the interactivity of
> X, as well as causes some long interuptions in xmms. With preempt
> enabled, this is much improved. Still some interuptions in xmms, but the
> system is still usable, although a little sluggish. On the vanilla
> kernel, even bonnie caused a couple of hiccups in xmms, with preempt
> enabled, bonnie didn't affect xmms at all. all programs were run without
> altering nice values at all.

This is exactly what I want to hear.  I am glad you did the
XMMS/how-it-feels test and that preemption came out ahead.

We can work on cutting the latency even further.  There are still some
long held locks in the kernel, and we can not preempt around them.

> For a workstation, I like the difference, my system is still usable even
> with the load upwards of 14, without preempt, it's like looking at a
> couple of screenshots. This is not something that I would recommend for
> a server, but for a workstation, it works great.

Great.

> Out of morbid curiousity, I ran a make -j bzImage to see how well this
> would handle being driven into the ground. No oopsen, the OOM killer
> worked great, killed everything that wasn't being used. The only prob is
> that it hosed my console and killed my ssh daemon. oops ;) Sending a
> sysrq-SAK and then a 3-finger-salute rebooted the system perfectly, no
> fsck or anything.
> 
> I couldn't build that latency test for my system, so no results from it.
> I haven't had a chance to look at it's source, so I'm not sure if I can
> make it work here or not.

Someone else reported to me privately it did not compile.  I don't think
they looked into it.

I would assume the latency is going to drop in the same manner it does
for a UP system (_very_ much).

> I'll keep up with your patches and keep you posted.

Great, thanks for the feedback.  While it is great to hear "preemption
seems to be an improvement under SMP", I am most exciting it works
without faults.

You can always find the newest diffs at http://tech9.net/rml/linux

Thanks again,

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

