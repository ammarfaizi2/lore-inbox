Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbSJ3Xzf>; Wed, 30 Oct 2002 18:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSJ3Xzf>; Wed, 30 Oct 2002 18:55:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:7677 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264973AbSJ3Xzb>;
	Wed, 30 Oct 2002 18:55:31 -0500
Message-ID: <3DC072DA.72F11BFF@mvista.com>
Date: Wed, 30 Oct 2002 16:01:30 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Are x86 trap gate handlers safe for preemption?
References: <15808.17731.311432.596865@kim.it.uu.se> <appnou$jof$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <15808.17731.311432.596865@kim.it.uu.se>,
> Mikael Pettersson  <mikpe@csd.uu.se> wrote:
> >Consider an exception handler like vector 7, device_not_available:
> >
> >ENTRY(device_not_available)
> >        pushl $-1                       # mark this as an int
> >        SAVE_ALL
> >        movl %cr0, %eax
> >        testl $0x4, %eax                # EM (math emulation bit)
> >        jne device_not_available_emulate
> >        preempt_stop
> >
> >Since this is invoked via a trap gate and not an interrupt gate,
> >what's preventing this code from being preempted and resumed on
> >another CPU before the read from %cr0?
> 
> Well, since %cr0 should be stable across the task switche, that
> shouldn't actually matter.

Unless the new task does the same sort of thing... i.e.
touchs cr0 in some way.  The page fault issue was ok if the
intervening tasks did not fault...

-g
> 
> >                                Another example is the
> >machine_check vector (also trap gate) whose handlers access MSRs.
> 
> This one looks like a real bug. The fix should be to make it an
> interrupt gate, I suspect. Comments?
> 
> On the whole, I think it is probably a good idea to make all exceptions
> be interrupt gates, and then on a case-by-case basis show why some don't
> need to (ie clearly the system calls should _not_ be interrupt gates,
> but we've long since made the page fault path use an interrupt gate for
> similar special register stability reasons).
> 
>                 Linus

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
