Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbTDPIkO (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTDPIkO 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:40:14 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:64195 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261246AbTDPIkN (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 04:40:13 -0400
Date: Tue, 15 Apr 2003 22:32:05 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: george anzinger <george@mvista.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
Message-ID: <20030415223205.P659@nightmaster.csn.tu-chemnitz.de>
References: <24294.1050043625@kao2.melbourne.sgi.com> <3E966BAA.804@mvista.com> <20030411112728.M626@nightmaster.csn.tu-chemnitz.de> <3E9731E2.9090606@mvista.com> <20030412105546.H659@nightmaster.csn.tu-chemnitz.de> <3E9B2CF3.70103@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E9B2CF3.70103@mvista.com>; from george@mvista.com on Mon, Apr 14, 2003 at 02:49:39PM -0700
X-Spam-Score: -32.9 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *195ieC-0007Nh-00*HwfZYD.FOVw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,
hi Keith,
hi lkml,

On Mon, Apr 14, 2003 at 02:49:39PM -0700, george anzinger wrote:
> Ingo Oeser wrote:
> > On Fri, Apr 11, 2003 at 02:21:38PM -0700, george anzinger wrote:
> > 
> >>Ingo Oeser wrote:
> Yes, I believe this is what RTLinux and RTIA do.  The sti macro then 
> needs to check for pending interrupt work, much as the bh_unlock does.
 
Ok, NOW we are talking ;-)

> > Not suitable for drivers. They must read the registers, set some
> > other registers and ACK the IRQ in the ISR. There is no way
> > around that. 
> 
> The lock has two sides, the reader and the writer.  The writer still 
> takes the irq/ spinlock, only the reader gets the speed up.

But the read can read garbage and may need a retry. This is not
acceptable for me, since one of my cards will do destructive
reads. They implement a hardware FIFO (of one element depth),
where the register I read from is removing the element while
reading. This is a common design you'll find in PCI-bridge chips
(I used the S5933 from AMCC for this).

So this scheme still doesn't help me and is not the proper
drop-in replacement, we are looking for.

BTW: Please note, that you can assume I know the semantics of all
   the locking functions currently in Linus' tree. So you can
   stop explaining me the details of them and continue with
   defining a proper cli/sti replacement. Thanks!

> > So if there would be a schedule_work_deadline() then this would
> > be nice. The routine called later in process context called will
> > be noticed, if the deadline is missed or not and can act
> > correctly.
[...]
> > We currently have timers, but they are not suitable for doing the
> > work only for triggering it and that's a source of complexity in
> > driver design.
> 
> Something of this sort is present in the workqueues design.  There is 
> a schedule work for later call.

Yes, but it doesn't solve the problem, that I've illustrated. You'll not
know, WHEN this scheduled work will trigger (kernel tells us: ASAP)
and you need another kernel thingie again. And you must check,
whether the deadline is over yourself.

This isn't that nice design. I just don't feel that experienced,
that I can change the scheduler.

But maybe we can talk about that now, that we both know that we
know the current kernel API well enough ;-)

Regards

Ingo Oeser
