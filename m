Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVBVNtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVBVNtC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVBVNtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:49:02 -0500
Received: from alog0385.analogic.com ([208.224.222.161]:58496 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262313AbVBVNs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:48:57 -0500
Date: Tue, 22 Feb 2005 08:47:57 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Anthony DiSante <theant@nodivisions.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
In-Reply-To: <421B14A8.3000501@nodivisions.com>
Message-ID: <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com>
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
 <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no>
 <421B14A8.3000501@nodivisions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Anthony DiSante wrote:

> Helge Hafting wrote:
>> The infrastructure for that does not exist, so instead, the "killed" 
>> process remains. Not all of it, but at least the memory pinned down by the 
>> io request.  This overhead is typically small, and the overehad of adding 
>> forced io abort to every driver might
>> be larger than a handful of stuck processes.  It looks ugly, but perhaps a 
>> ps flag that hides the ugly processes is enough.
>
> I don't care about any overhead associated with stuck processes, nor do I 
> care that they look ugly in the ps output.  What I care about is the fact 
> that at least once a week on multiple systems with different hardware, some 
> HW-related driver/process gets stuck, then immediately cascades its stuckness 
> up to udevd or hald, and then I can't use any of my hardware anymore until I 
> reboot.
>
> -Anthony DiSante
> http://nodivisions.com/
> -

You don't seem to understand. A process that's stuck in 'D' state
shows a SEVERE error, usually with a hardware driver. For instance,
somebody may have coded something in a critical section that will
wait forever for some bit to be set when, in fact, that bit may
never be set because of a hardware glitch. Such problems must
be found. One can't just suck some process out of the 'D' state.

So, you need to tell what driver was doing what. If you can't
then you need to provide enough information so that developers
may guess. For instance, if you get a process stuck in the 'D'
state when you use a CD/ROM, but not otherwise when you use
IDE or SCSI or whatever.., then you have a good guess that
there is some "wait-forever" code in the CD/ROM driver.

So, lets suppose that you had a problem with your CD/ROM.
You could eject it by hand and see if the process that
was stuck is no longer stuck, or you might be able to
power it OFF then ON. If this got a process "unstuck"
it might give the CD/ROM driver developer a hint as
to where to look in his code. No code is ever supposed
to wait forever for some hardware, but there are some
possibilities (races and whatever), that can effectively
wait forever. These possibilities need to be discovered
and fixed.

The 'D' state usually stands for 'Down' where a task
was 'down()' on a semaphore. To get out of that state,
that task (and none other) needs to execute `up()`.
This means that whatever that task was waiting for
needs to happen or it won't call 'up()'. The nature
of these mutexes requires that the thread that
acquired the semaphore be the same thread that
released it, otherwise we don't have a MUTEX.
So, there is no way that "somebody else" can
"fix" the task thread waiting with the MUTEX held.

There has been some discussion that these hung
states could be "fixed", but that's absolutely
positively incorrect. If you have a MUTEX that
"times out" or is otherwise breakable, you can't
use it to provide a single execution path to
a shared resource which is what these things
are used for in the first place.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
