Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFTCjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTFTCjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:39:11 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16884 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262171AbTFTCjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:39:10 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780E040A14@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'george anzinger'" <george@mvista.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>,
       "'Robert Love'" <rml@mvista.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	 sks
Date: Thu, 19 Jun 2003 19:53:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: george anzinger [mailto:george@mvista.com]
> Perez-Gonzalez, Inaky wrote:
> > ...
> > My point here is: I am trying to trace where this program
> > is making use of workqueues inside of the kernel, and I
> > can find none. ...<snip>...
> 
> Hm!  I wonder.  Robert is working on a fix for schedsetschedule()
> where it fails to actually tell the scheduler to switch to a process
> that it just made higher priority or away from one it just lowered.
> 
> The net result is that the caller keeps running (FIFO for all in this
> case) when, in fact it should have been switched out.  Next time
> schedule() actually switches, it is all sorted out again.  Could the
> elavation of the events/0 thread cause this needed switch?

Maybe it was that, as with Robert's patch, the hang goes
away ... gee, weirdo. Doing a brute-force grep of who is doing
anything that could wake up the event daemon (by calling
{queue,schedule}_[delayed_]work() or flush_{workqueue,delayed_work})
shows that arch/i386/kernel/cpu/mcheck:mce_timerfunc() is 
scheduling work every MCE_RATE seconds, so that could wake up
the event daemon and cause the thing to be sorted out. However,
that's each 15 seconds ... too slow?

The VT code does too (as a callback mechanism for setting the
console, and seems like scrolling), but none seems to be
periodic so that they'd fix it. Others are at too unclear too.

Oh well ... it works, so it goes to the bin :]

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
