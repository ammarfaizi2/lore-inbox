Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSGXDCk>; Tue, 23 Jul 2002 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSGXDCj>; Tue, 23 Jul 2002 23:02:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316683AbSGXDCh>;
	Tue, 23 Jul 2002 23:02:37 -0400
Message-ID: <3D3E1B66.F17D8B9E@zip.com.au>
Date: Tue, 23 Jul 2002 20:13:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Ingo Molnar <mingo@elte.hu>, george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in2.5.27?]
References: <Pine.LNX.4.44.0207240100150.2732-100000@localhost.localdomain> <1027472897.927.247.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> Attached is the patch George mentioned, against 2.5.27.
> 

I'd agree with Robert on that.  The idea should be that,
as much as possible, preempt "just works" as long as the
programmer sticks with standard SMP programming practices.

And yet here we have a case where a spin_unlock() will
go and turn on local interrupts.  Only with CONFIG_PREEMPT,
and even then, extremely rarely.


Plus it would be nice to have an arch-independent way of
querying whether the current CPU has interrupts enabled.
I've needed that several times within debug/devel code.


Robert and George's patch doesn't seem to be optimal though - if
we're not going to preempt at spin_unlock() time, we need to
preempt at local_irq_restore() time.  It'll be untrivial to fix
all this, but this very subtle change to the locking semantics
with CONFIG_PREEMPT is quite nasty.

-
