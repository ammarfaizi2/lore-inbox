Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVA1IaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVA1IaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVA1IaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:30:23 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26011
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261194AbVA1IaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:30:15 -0500
Subject: Re: High resolution timers and BH processing on -RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
In-Reply-To: <20050128082439.GA3984@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
	 <20050128044301.GD29751@elte.hu>
	 <1106900411.21196.181.camel@tglx.tec.linutronix.de>
	 <20050128082439.GA3984@elte.hu>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 09:30:13 +0100
Message-Id: <1106901013.21196.194.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 09:24 +0100, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > is this due to algorithmic/PIT-programming overhead, or due to the noise
> > > introduced by other, non-hard-RT timers? I'd guess the later from the
> > > looks of it, but did your test introduce such noise (via networking and
> > > application workloads?).
> > 
> > Right, it's due to noise by non-RT timers, which I enforced by adding
> > networking and applications.
> > 
> > This adds random timer expires and admittedly the PIT reprogramming
> > overhead is adding portions of that noise.
> 
> i havent seen your latest code - what is the basic data-structure? The
> stock kernel has arrays of timers with increasing granularity and a
> cascade mechanism to move timers down the arrays as they slowly expire -
> but with a high-resolution API (1 usec accuracy?) how does the basic
> data structure look like?

The current testing code just moves the HRT timers to a seperate list.
It's a linked list at them moment, which must be optimized when the
general dust settles.

> Is the "noise" due to timers expiring "at once" - but isnt it unlikely
> for 'normal' timers to expire in exactly the same usec as the real
> high-resolution one?
> 
> or is it that we have a 'group' of normal timers expiring, which, if
> they happen to occur _just_ prior a HRT event will generate a larger
> delay?
> 

Yep. The timers expire at random times. So it's likely to have short
sequences of timer interrupts going off. This needs reprogramming of the
PIT and processing of the expired timers.

tglx


