Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVAaJNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVAaJNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVAaJMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 04:12:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48028
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261842AbVAaJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 04:12:30 -0500
Subject: Re: High resolution timers and BH processing on -RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
In-Reply-To: <41FA85A7.4000805@mvista.com>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
	 <20050128044301.GD29751@elte.hu>
	 <1106900411.21196.181.camel@tglx.tec.linutronix.de>
	 <20050128082439.GA3984@elte.hu>
	 <1106901013.21196.194.camel@tglx.tec.linutronix.de>
	 <20050128084725.GB5004@elte.hu>  <41FA85A7.4000805@mvista.com>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 10:12:27 +0100
Message-Id: <1107162747.21196.309.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 10:34 -0800, George Anzinger wrote:
> If you can use a machine that has a local apic we can leave the PIT out of it. 
> Really this is MUCH preferred.  If your box has a LAPIC, make sure it is not 
> disabled by your config setup.

Unfortunately its an embedded box w/o LAPIC. Embedded systems with low
computing power and restricted peripherals are often used in industrial
environments and likely to be a major client of RT/HRT implementations.

> Leaving the PIT out of it, the structure is that HRT timers are put in the 
> normal timer list and, when they expire, are moved to a HRT list which only 
> contains timers that will expire prior to the next jiffie.  This list is managed 
> by interrupt, ideally from the LAPIC, or the PIT is need be.  Aside from the PIT 
> reprograming (once per HRT timer plus once to get back to the 1/HZ period), 
> there can be delays in getting the timer out of the normal timer list.  The main 
> thing here is that the list MUST be processed as close to the jiffie edge as 
> possible as any timers due shortly after the jiffie edge will be shadowed by 
> this regardless of the HRT interrupt.  Of course, it an expired timer is 
> presented to the HRT code by the normal timer expire code, it is expired 
> immeadiatly.

This requires to run the 1/Hz timer code with high priority in order to
run as close as possible to the jiffie edge. I know that you made this
move in order to make the HRT code less intrusive, but I think this
trades code beauty with latency issues. In order to reduce the latency
for HRT timers it will be necessary to split the timer list work into
pieces.

Jiffie interrupt
- Move the HRT timers out of the next jiffie bucket, reprogram HRT
timesource.
- Run the shadowed HRT timers, which are close to the jiffie edge (too
close to reprogram the HRT timesource)
- Move expired low res timers to a work list
- schedule the low res timer work

Not sure, if this is less intrusive than the previous modifications to
add_timer/mod_timer/del_timer, which can nicely be done with simple
macros and does not touch the low res timer list including the
processing at all.

> > i dont really like the static splitup of 'normal' vs. 'HRT' timers -
> > there might in fact be separate priority requirements between HRT timers
> > too.
> 
> Yes, and high priority tasks might want low res timers...

Sure, is there any API available to select the timer type / priority ?

> A long time ago in another land, I did such a system.  The timer priority was 
> taken from the calling task.  At that time (and now, till convinced otherwise) I 
> thought it a _good thing_ to expire timers in order, regardless of their 
> priority, so all timers pending delivery were delivered at the priority of the 
> highest priority timer in the "batch".  The basic idea was that the interrupt 
> code pulled expired timers from the timer list and pushed them into the pending 
> list.  In the process it found the highest priority timer in the list.  The 
> timer delivery thread was then run at that priority.  This thread adjusted its 
> priority downward as needed, but in all cases the timers were delivered in 
> strict time order.
> 
> Since then, as now, the timer delivery usually just _notified_ a task of a 
> pending signal, the low priority timers did not really hold up things for long. 
>   Once the high priority timer was delivered and the thread either finished or 
> dropped its priority, the waiting task (having been wakened by the signal 
> delivery) could switch in.

Make sense.

tglx


