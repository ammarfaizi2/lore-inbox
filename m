Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279170AbRJWFCq>; Tue, 23 Oct 2001 01:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279239AbRJWFCf>; Tue, 23 Oct 2001 01:02:35 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:14852 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S279170AbRJWFCY>; Tue, 23 Oct 2001 01:02:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: time tells all about kernel VM's
Date: Tue, 23 Oct 2001 01:02:52 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011023030353Z279218-17408+3723@vger.kernel.org>
In-Reply-To: <20011023030353Z279218-17408+3723@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011023050227Z279170-17408+3746@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 23:04, safemode wrote:
> We've all seen benchmarks and "load tests" and "real world runthroughs" on
> the rik and aa kernel VM's.  But time does tell all.  I've had
> 2.4.12-ac3-hogstop up and running for over 5 days.   The first hiccup i
> found was a day or so ago when trying out defragging an ext2 fs on a hdd
> just for the hell of it.  I have 770MB of ram and 128MB of swap (since my
> other 128MB of swap was on the drive i was defragging and i had swapoff'd
> it).   First the kernel created about 600MB of buffer in addition to the
> application specified 128MB of buffer i had it using (e2defrag -p 16384).  
> This brought the system to a crawl.  So in some twisted reality that may be
> considered normal kernel behavior, so i let it pass.  Then i created an
> insanely large ps and tried loading it in ghostview, magnified it a couple
> times in kghostview and what happens?  I wish i could tell you but i cant
> because the system immediately went unresponsive and started swapping at a
> turtles pace. I can tell what didn't happen though.
>
> A.  OOM did not kick in and kill kghostview.  Why you may ask?  Read on to
> B. B.  The VM has this need to redistribute cache and buffer so that an OOM
> situation doesn't take place until all the ram is basically being used. 
> The problem is that currently the VM will swap out stuff it isn't using and
> without buffer it must read from the drive (which is being used to swap)
> which takes more cpu which isn't there because the app is locking the
> kernel up trying to allocate memory (see why dbench causes mp3 skips).  So
> what happens is that the kernel cant swap because the hdd io is being
> strangled by the process that's going out of control (kghostview) which
> means that the VM is stuck doing this redistribution at a snails pace and
> the OOM situation never occurs (or occurs many days later when you've died
> of starvation). Leaving you deadlocked on a kernel with a VM that is
> supposed to conquer this situation and make it a thing of the past.
>
> So what happens after a few days of uptime is that we see where the VM has
> slight weaknesses that magnify over time and aren't aparent on the normal
> run of tests done on each new release to decide if it's good or not.
> Perhaps if i had not had any swap loaded at all this situation would have
> been avoided.
> I see this as a pretty serious bug

I've reproduced this quite a number of times (unfortunately) by running 
graphviz and creating huge (9500x11500) postscript files that fill the hdd 
(perhaps due to a bug) and basically leave no room for anything, this wreaks 
havoc on the VM which has to keep everything in buffer because it cant write 
to disk.  no error was displayed about running out of disk space. This seems 
to be a serious problem for rik's vm (at least his) and i would think would 
keep it from being chosen as the standard 2.4vm.   This seems to be able to 
show a bug in which running out of disk space is never reported, and the vm 
deadlocks the kernel by trying to make room for the process which 
consequently makes the OOM handler useless. 
