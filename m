Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRBWHUG>; Fri, 23 Feb 2001 02:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRBWHT5>; Fri, 23 Feb 2001 02:19:57 -0500
Received: from colorfullife.com ([216.156.138.34]:21772 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131520AbRBWHTo>;
	Fri, 23 Feb 2001 02:19:44 -0500
Message-ID: <3A960F1B.38D42243@colorfullife.com>
Date: Fri, 23 Feb 2001 08:19:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: John Levon <moz@compsoc.man.ac.uk>
CC: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.1-ac10] unsetting TASK_RUNNING
In-Reply-To: <Pine.LNX.4.21.0102131701010.9400-100000@mrworry.compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> 
> On Tue, 13 Feb 2001, Tigran Aivazian wrote:
> 
> > Hi Alan,
> >
> > The only case in schedule_timeout() which does not call schedule() does
> > set tsk->state = TASK_RUNNING explicitly before returning. Therefore, any
> > code which unconditionally calls schedule_timeout() (and, of course
> > schedule()) does not need to set TASK_RUNNING afterwards.
> >
> > I have seen some people setting this TASK_RUNNING incorrectly, based on a
> > mere observation that "official Linux kernel code does so" -- so the patch
> > below is not just an optimization but serves for education (i.e. to stop
> > people copying unnecessary code).
> 
> I had a similar set of patches a while ago. I had several more unnecessary
> settings.
> 
> At least Matthew Dharm as usb-storage maintainer wanted to keep his in. Of more
> concern IMHO were the drivers busy waiting by failing to reset current->state
> on each iteration - e.g. maestro2, maestro3.
>

There is one danger with unnecessary

	current->state = TASK_RUNNING;

lines.
If it's executed in an interrupt or bottom half handler it can corrupt
the runqueue.

In schedule():
* goto recalculate
* interrupts reenabled, bottom half handler might run
* interrupts disabled
* goto repeat_schedule;
* prev->state==TASK_RUNNING --> goto still_running.

And now a process that's not on the runqueue might be choosen for
execution, and the next del_from_runqueue() corrupts the runqueue.

--
	Manfred
