Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUKCVOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUKCVOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKCVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:12:37 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:27885 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261878AbUKCVIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:08:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 16:08:49 -0500
User-Agent: KMail/1.7
Cc: Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031448.38110.tfelker2@uiuc.edu>
In-Reply-To: <200411031448.38110.tfelker2@uiuc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031608.49543.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 15:08:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 15:48, Tom Felker wrote:
>On Wednesday 03 November 2004 06:51 am, Gene Heskett wrote:
>> Greetings;
>>
>> I thought I'd get caught up on -bkx kernels and made a -bk8 just
>> now.
>>
>> But I'd tried to run gnomeradio earlier to listen to the
>> elections, but it failed leaving to run, as did tvtime then too,
>> claiming it couldn't get a lock on /dev/video0, and gnomeradio
>> apparently left a lock on alsasound that prevented the normal
>> gracefull shutdown by locking up the shutdown on the "stopping
>> alsasound" line.  So I had to use the hardware reset.
>>
>> I'd tried to kill the zombie earlier but couldn't.
>>
>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>
>Ok, let me try to explain what probably happened.
>
>First, terminology.  When one process wants to be come two
> processes, it fork()s.  One process is the parent, and one it the
> child.  The child usually exec()s to become a different program. 
> The parent sometimes wants to know when the child ends and whether
> it succeeded.  Thus, the wait() system calls. The parent can either
> check whether a child died, or go to sleep until one does.  When
> the parent is awaken, it's told which child died and what the
> child's exit status was (usually 0 for success).  But if the child
> dies before the parent wait()s, the kernel must keep a record of
> which child died and what its exit status was, and it can't
> reassign the late child's PID yet. This record is a "zombie," and
> shows up under top or ps with the 'Z' state. Zombies do _not_ hold
> open files, memory, or resources of any kind.
>
>That's the technical definition of a zombie, which I'm telling you
> because that's probably not your situation:  I assume you used
> "zombie" as an informal term for a process that you can't kill. 
> Your problem is a process in uninterruptible sleep (the "D" state).
>
>When a process executing in userspace wants information from a
> device, like a disk or TV capture card, it calls read(), and
> context switches into kernel space.  Usually, it will take a moment
> for the data to be available from the device, so the process gets
> put on a wait queue so other processes can run. Obviously nothing
> is deallocated, because everyone expects the process will get it's
> data and proceed as normal.  When the device has the data, it
> interrupts the CPU, and the kernel figures out who wanted the data
> and puts them on the run queue.
>
>When a process is on a wait queue waiting for data from a device
> (the D state), it's impossible to kill.  This is because otherwise,
> when the interrupt did come, the structures associated with the
> process would have been freed, and the kernel would crash.  It
> would require an incredible amount of innefficient bookkeeping to
> avoid this, and it's unnecessary because normally, the data request
> will finish (successfully or not), and the process will be woken
> up, or if it was sent SIGKILL, it will be killed.
>
>Long story short, what happened was, some faulty hardware or some
> buggy driver, probably associated with the capture card, had a
> problem and left the process in D state.  Thus, it couldn't be
> killed, and since it had /dev/video open, tvtime couldn't run and
> failed gracefully, and because it held /dev/dsp open, and couldn't
> be killed as the init scripts would normally do in that situation,
> the audio drivers couldn't be unloaded and the boot process hung.
>
>So give us a bunch of information about what hardware you're using,
> output of dmesg, and steps to reproduce the driver bug (if it is
> that).

Its a dead horse Tom, lets bury it.  I've rebooted to 4 new kernels 
since that time as I march toward getting caught up with whatever 
bk(nn) is out today.  Other than that, which took place on bk7's 
watch, its all working rather well.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
