Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154345-13684>; Wed, 6 Jan 1999 21:11:45 -0500
Received: by vger.rutgers.edu id <154347-13684>; Wed, 6 Jan 1999 08:55:14 -0500
Received: from lilly.ping.de ([195.37.120.2]:25851 "HELO lilly.ping.de" ident: "qmailr") by vger.rutgers.edu with SMTP id <154769-13684>; Wed, 6 Jan 1999 02:26:22 -0500
Message-ID: <19990106104118.B27572@kg1.ping.de>
Date: Wed, 6 Jan 1999 10:41:18 +0100
From: Kurt Garloff <K.Garloff@ping.de>
To: scherrey@proteus-tech.com
Cc: Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
Mail-Followup-To: scherrey@proteus-tech.com, Linux kernel list <linux-kernel@vger.rutgers.edu>
References: <19990105094830.A17862@kg1.ping.de> <3692DF1C.C03DD162@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.90.4i
In-Reply-To: <3692DF1C.C03DD162@gte.net>; from Benjamin Scherrey on Tue, Jan 05, 1999 at 10:57:16PM -0500
X-Operating-System: Linux 2.1.132 i686
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Jan 05, 1999 at 10:57:16PM -0500, Benjamin Scherrey wrote:
> Kurt -
> 
>     Thanx for the insightful information about the impact of changing the HZ
> values. Questions: a) how platform specific is this setting (i86, ALPHA, et al),
> and b) Does increasing the HZ value increases context switches or increases
> duration of each context?

a)
The HZ value differs between the different architectures. The alpha has e.g.
HZ set to 1024. That's why the kernel core has to independent of it.
The way I coded it, it will break compilation on other archs, as I was to
lazy to put the constant HZ_TO_STD into the header files of other archs.
Of course, we could use something like #ifndef HZ_TO_STD #define HZ_TO_STD 1
#endif in kernel/sys.c

b)
The timer interrupt and therefore the scheduler will be called more often.
If more than one process competes for CPU (R state), than the number of
switches between these processes will occur more often, about 4 times as
often.
If I understood correctly, also the bottom half data processing of the
kernel is tied to the timer interrupt and will thus happen more often.

It speeded up some of my numerical computations on my SMP machine, BTW. I
have rc5des runnning (idle priority, Rik's patch), and some threads sleeping
and waiting for some job to be submitted to them. However, after they were
signalled, they will only start after the next scheduler tick. So the HZ
value influences scheduling latency. Unfortunately my program is not very
well parallelized, so the jobs to be done by the threads are very short and
take about the same time as the scheduler latency. Now, with 400 Hz it was
much better ...

>     This sounds like an excellent developer's config option to me.... Any
> chance of this happening soon?

This is not up to me. 
I can however create a cleaned up patch and put it on my website, if enough
people want it. It will take some days, though, as I'm very busy.

Regards,
-- 
Kurt Garloff <kurt@garloff.de>                           [Dortmund, FRG]  
Plasma physics, high perf. computing              [Linux-ix86,-axp, DUX]
PGP key on http://www.garloff.de/kurt/        [Linux SCSI driver: DC390]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
