Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUIBSDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUIBSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIBSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:03:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56803 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268065AbUIBSBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:01:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>
In-Reply-To: <20040902133743.GA9096@elte.hu>
References: <OF4A93C101.C3FFA1E6-ON86256F03.004851E5@raytheon.com>
	 <20040902133743.GA9096@elte.hu>
Content-Type: text/plain
Message-Id: <1094148061.11364.63.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 14:01:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 09:37, Ingo Molnar wrote:
>  - the NMIs also sample what happens on the other CPU. In your above 
>    trace this gives:
> 
>    > 00010001 0.478ms (+0.478ms): do_nmi (sched_clock)
>    > 00010001 0.478ms (+0.000ms): do_nmi (<08049b21>)
> 
>    the other CPU was executing userspace code during the last NMI tick - 
>    i.e. nothing that could be suspect. 'suspect' code would be some sort 
>    kernel code that could in theory interact with this CPU's scheduler 
>    code.
> 
>    this too is statistical sampling so we'll need as much of these 
>    traces as possible.
> 
> some wacky guess based on the above single sampling point: it seems the
> delays are real wall-clock delays, and the only thing matching the
> theory so far is that DMA traffic on the memory bus somehow stalls this
> CPU's memory traffic for up to 500 usecs. How could userspace running on
> CPU#0 impact the kernel's scheduler code on CPU#1?
> 

This is not wacky at all.  For example the 2D acceleration driver for my
Via Unichrome chipset will completely stall the PCI bus and processor if
the 2D engine is overloaded and the command FIFO is written to without
checking whether it is full.  This can be triggered easily, all you have
to do is enable 'display window contents while dragging' and drag a busy
window around slowly.

Many vendor-supplied drivers (including the open source via_accel.c)
don't bother to check whether this FIFO is full before writing to it,
because it increases benchmark scores slighly, at the expense of ruining
audio performance.  You can thank Matrox for this "innovation", though
to be fair, every other vendor seems to have followed suit until they
were busted.  Only setting 'Options "NoAccel"' in my X config fixes it. 
This is not even a kernel driver, it's part of XFree86!

This paper describes the problem in more detail:

http://research.microsoft.com/~mbj/papers/tr-98-29.html

Since they don't provide a deep link and the interesting content is
buried, here is the excerpt:

Misbehaving video card drivers are another source of significant delays
in scheduling user code. A number of video cards manufacturers recently
began employing a hack to save a PCI bus transaction for each display
operation in order to gain a few percentage points on their WinBench
[Ziff-Davis 98] Graphics WinMark performance.

The video cards have a command FIFO that is written to via the PCI bus.
They also have a status register, read via the PCI bus, which says
whether the command FIFO is full or not. The hack is to not check
whether the command FIFO is full before attempting to write to it, thus
saving a PCI bus read.

The problem with this is that the result of attempting to write to the
FIFO when it is full is to stall the CPU waiting on the PCI bus write
until a command has been completed and space becomes available to accept
the new command. In fact, this not only causes the CPU to stall waiting
on the PCI bus, but since the PCI controller chip also controls the ISA
bus and mediates interrupts, ISA traffic and interrupt requests are
stalled as well. Even the clock interrupts stop.

These video cards will stall the machine, for instance, when the user
drags a window. For windows occupying most of a 1024x768 screen on a
333MHz Pentium II with an AccelStar II AGP video board (which is based
on the 3D Labs Permedia 2 chip set) this will stall the machine for
25-30ms at a time!

This may marginally improve the graphics performance under some
circumstances, but it wrecks havoc on any other devices expecting timely
response from the machine. For instance, this causes severe problems
with USB and IEEE 1394 video and audio streams, as well as standard
sound cards.

Some manufacturers, such as 3D Labs, do provide a registry key that can
be set to disable this anti-social behavior. For instance, [Hanssen 98]
describes this behavior and lists the registry keys to fix several
common graphics cards, including some by Matrox, Tseng Labs, Hercules,
and S3. However as of this writing, there were still drivers, including
some from Number 9 and ATI, for which this behavior could not be
disabled.

This hack, and the problems it causes, has recently started to receive
attention in the trade press [PC Magazine 98]. We hope that pressures
can soon be brought to bear on the vendors to cease this antisocial
behavior. At the very least, should they persist in writing drivers that
can stall the machine, this behavior should no longer be the default.

Lee


