Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCaRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCaRJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCaRJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:09:33 -0500
Received: from ida.rowland.org ([192.131.102.52]:15364 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261571AbVCaRJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:09:16 -0500
Date: Thu, 31 Mar 2005 12:09:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory
 stick
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231D0@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0503311150200.1510-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, kus Kusche Klaus wrote:

> > Latency is the subject of a separate email.  Does this 
> > increase in latency 
> > occur only when you see the errors, or whenever you do a large data 
> > transfer?  In fact, I would suspect the errors to _decrease_ 
> > the latency 
> > with respect to a normal transfer.
> 
> I observe from <1 to 2 ms on successful transfers, and around 15 ms
> latency when things go wrong.

I hate to ask this question; it sounds an awful lot like "Monty Python and
the Holy Grail", but...  Is that IRQ latency or application latency?

I can't think of any reason why IRQ latency should change during the error 
handling.  Application latency might change because the SCSI error handler 
could start using up a lot of CPU time.  I don't know what priority it 
runs at; you can check with ps.

> I do not know what the kernel does internally, but I tried block
> sizes from 512b to 8192kb with dd, and it did not make any
> difference, neither w.r.t. timing nor w.r.t. errors.

dd's block size makes almost no difference to anything within the kernel.


> > This indicates that the problem lies in the computer, or its USB 
> > connectors and their electromagnetic environment.
> 
> Hmmm, hard to believe. It happens on all USB ports, on two
> different controllers. The box is an industrial-grade
> embedded control system, in a robust steel case. There is
> no external USB cable involved, the stick is plugged directly
> into the box. 
> 
> The USB ports of these boxes work fine in vxWorks
> (don't know about Windows).

It's hard to know what to say.  The error code shown in your log comes 
directly from reading a data value that is set by the USB host controller.  
The only way to interpret it is that something is wrong at the hardware 
level.

Maybe vxWorks and Windows don't stress the USB controller or device as 
heavily as Linux does.

> > Timing or interrupt trouble wouldn't cause the problems you see.  Bus
> > utilization can cause problems, but they would be reported 
> > differently.  
> > I think your problem is due either to faulty hardware or to bad signal
> > propagation.
> 
> If it's not caused by bus utilization or shared or lost irqs,
> I think it is some kind of software problem, maybe in the driver,
> maybe elsewhere: 
> The dd command *always* runs fine for some time, up to now
> the transfer never had any problems for the first 30 MB or so,
> sometimes even for 500 MB on my 1 GB stick.

That doesn't mean anything necessarily.

> Is there any possibility for integer overflow?

No.

> Is there any data which may accumulate over time?

No.


> > > Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
> > > usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 30 entries
> > > Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: 
> > Status code -75;
> > > transferred 19840/122880
> > > Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- babble
> > 
> > This is not a "short read"; as the log says, it's a "babble". 
> >  That means
> > the computer's USB controller believed the device continued 
> > transmitting
> > past the time when it was supposed to stop.  Assuming the device is
> > functioning correctly, either the USB controller is bad or 
> > the signal was
> > degraded.
> 
> But doesn't it say 19840 of 122880 transferred?
> In all cases of trouble, the first number is smaller than the second.

Yes.  That's how far the transfer had gotten before the "babble" error 
occurred.  A genuine short read would have a status code of -121 and 
would be reported as a "short read transfer".

Alan Stern

