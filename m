Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUJEUjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUJEUjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUJEUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:39:31 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58120 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265093AbUJEUgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:36:25 -0400
Message-ID: <4163078F.8080709@techsource.com>
Date: Tue, 05 Oct 2004 16:43:59 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>
Subject: GPU driver misbehavior  [Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9]
References: <OFACA329EE.63AC9924-ON86256F04.00556E19-86256F04.00556E29@raytheon.com> <1094256256.6575.109.camel@krustophenia.net>
In-Reply-To: <1094256256.6575.109.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lee Revell wrote:

> 
> "Misbehaving video card drivers are another source of significant delays
> in scheduling user code. A number of video cards manufacturers recently
> began employing a hack to save a PCI bus transaction for each display
> operation in order to gain a few percentage points on their WinBench
> [Ziff-Davis 98] Graphics WinMark performance.
> 
> The video cards have a command FIFO that is written to via the PCI bus.
> They also have a status register, read via the PCI bus, which says
> whether the command FIFO is full or not. The hack is to not check
> whether the command FIFO is full before attempting to write to it, thus
> saving a PCI bus read.
> 
> The problem with this is that the result of attempting to write to the
> FIFO when it is full is to stall the CPU waiting on the PCI bus write
> until a command has been completed and space becomes available to accept
> the new command. In fact, this not only causes the CPU to stall waiting
> on the PCI bus, but since the PCI controller chip also controls the ISA
> bus and mediates interrupts, ISA traffic and interrupt requests are
> stalled as well. Even the clock interrupts stop.
> 
> These video cards will stall the machine, for instance, when the user
> drags a window. For windows occupying most of a 1024x768 screen on a
> 333MHz Pentium II with an AccelStar II AGP video board (which is based
> on the 3D Labs Permedia 2 chip set) this will stall the machine for
> 25-30ms at a time!"

I would expect that I'm not the first to think of this, but I haven't 
seen it mentioned, so it makes me wonder.  Therefore, I offer my solution.

Whenever you read the status register, keep a copy of the "number of 
free fifo entries" field.  Whenever you're going to do a group of writes 
to the fifo, you first must check for enough free entries.  The macro 
that does this checks the copy of the status register to see if there 
were enough free the last time you checked.  If so, deduct the number of 
free slots you're about to use, and move on.  If not, re-read the status 
register and loop or sleep if you don't have enough free.

The copy of the status register will always be "correct" in that it will 
always report a number of free entries less than or equal to the actual 
number, and it will never report a number greater than what is available 
(barring a hardware glitch of a bug which is bad for other reasons). 
This is because you're assuming the fifo doesn't drain, when in fact, it 
does.

This results in nearly optimal performance, because usually you end up 
reading the status register mostly when the fifo is full (a time when 
extra bus reads don't hurt anything).  If you have a 256-entry fifo, 
then you end up reading the status register once for ever 256 writes, 
for a performance loss of only 0.39%, and you ONLY get this performance 
loss when the fifo drains faster than you can fill it.

One challenge to this is when you have more than one entity trying to 
access the same resource.  But in that case, you'll already have to be 
using some sort of mutex mechanism anyhow.

