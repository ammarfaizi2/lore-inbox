Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293515AbSCSCIZ>; Mon, 18 Mar 2002 21:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293514AbSCSCIP>; Mon, 18 Mar 2002 21:08:15 -0500
Received: from pc132.utati.net ([216.143.22.132]:30606 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S293513AbSCSCIF>; Mon, 18 Mar 2002 21:08:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, joe.korty@ccur.com
Subject: Re: [PATCH] 2.4.18 scheduler bugs
Date: Mon, 18 Mar 2002 21:08:16 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16lzQW-0004j4-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020319022049.160864C4@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 04:39 pm, Alan Cox wrote:
> > - ksoftirqd() - change daemon nice(2) value from 19 to -19.
> >
> >     SoftIRQ servicing was less important than the most lowly of batch
> >     tasks.  This patch makes it more important than all but the realtime
> >     tasks.
>
> Bad idea - the right fix to this is to stop using ksoftirqd so readily
> under load. If it bales after 20 iterations life is good. As shipped life
> is bad.
>
> Once ksoftirq triggers its because we are seriously overloaded (or without
> fixing its use slightly randomly). In that case we want other stuff to
> do work before we potentially unleash the next flood.

Also, I'm not sure if this is still the case but in earlier versions of the 
O(1) scheduler, nice(19) tasks tended to get their entire timeslice in one 
big long uninterrupted gulp.  (By the time they got a slice, everything with 
a higher priority has already run.)  This was great for long cpu-intensive 
loads because it meant your cache stayed hot, so you wound up churning 
through your CPU-bound load even faster than if you got little snippets of 
time and had to keep reloading your cache.  (Great for interactive latency, 
sucks for number crunching.)

Higher priority tasks get first crack at the CPU,  but that doesn't mean they 
get to keep it for long.  High priority is for latency reasons, not for 
throughput reasons.  If your router spills over to ksoftirqd, you're already 
beyond optimizing for latency.  If ksoftirqd is doing ping-pong scheduling 
with cron, overall throughput is worse.

Rob
