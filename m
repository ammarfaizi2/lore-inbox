Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFDKnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFDKnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 06:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFDKnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 06:43:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14479 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261314AbVFDKnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 06:43:05 -0400
Message-ID: <1117881783.42a185b757a01@imap.linux.ibm.com>
Date: Sat,  4 Jun 2005 06:43:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.63.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> On Fri, Jun 03, 2005 at 04:55:24PM +0530, Vivek Goyal wrote:
> > Hi,
> > 
> > In kdump, sometimes, general driver initialization issues seems to be
> cropping 
> > in second kernel due to devices not being shutdown during crash and these
> 
> > devices are sending interrupts while second kernel is booting and drivers
> are 
> > not expecting any interrupts yet.
> 
> What are the errors you are seeing?

We have observed mainly two kind of problems.

1. Devices A and B are sharing the same irq line. Driver for device A is
   initializing and opens the respective irq line(request_irq()). 
   Device B raises an interrupt. Interrupt handler for device A denies its 
   not my irq and there is no interrupt handler for device B yet. Device B   
   keeps the irq line asserted and kernel sees a flood of interrupts and
   finally kernel disables the irq line. Now device A's interrupt also stop
   coming and driver initialization for device A fails.

   We have observed this especially in case of aic7xxx driver and one sample
   log is attached with the mail.

2. Second problem is that driver is not expecting an interrupt the moment it
   calls request_irq(). Otherwise initialization fails. We saw this problem in
   IPS driver initialization failure. (Bugme 4573). Though this seenms to be 
   more of a driver bug and can be fixed separately. 


> How would the drivers be able to be getting interrupts delivered to them
> if they haven't registered the irq handler yet?

True that drivers will not get interrupts until they register request_irq().
In the above mentioned aic7xxx dirver failure, this driver starts getting 
interrupts the moment it calls request_irq(). And the fact is that these
interrupts are being generated from some other sharing the same irq line.


> 
> > In some cases, we are observing a storm of interrupts while second kernel
> 
> > is booting and kernel disables that irq line. May be the case of stuck
> irq
> > line because it is shared level triggered irq and there is no driver
> > loaded for the device. 
> > 
> > So, we need something generic which disables interrupt generation from
> device
> > until a driver has been registered for that device and driver is ready to
> 
> > receive the interrupts. PCI specifications (ver 2.3 onwards), have
> introduced
> > interrupt disable bit in command register to disable interrupt generation
> > from the device. This can become handy here. In capture kernel, traverse
> all 
> > the PCI devices, disable interrupt generation. Enable the interrupt
> generation
> > back once the driver for that device registers. May be after the probe
> handler 
> > has run. In probe handler, driver can reset the device or register for irq
> so 
> > that it can handle any interrupt from the device after that.
> > 
> > Greg mentioned that there are reasons that we can not disable all pci
> > interrupts. Meanwhile I am going through archives to find more about it.
> 
> You recalled the conversation in the next paragraph:
> 
> > In previous conversations, Alan Stern had raised the issue of console
> also
> > not working if interrupts are disabled on all the devices. I am not sure
> > but this should be working at least for serial consoles and vga text
> consoles.
> > May be sufficient to capture the dump.
> 
> That's the main objection a lot of people had to this kind of patch,
> last time it was discussed.


It can very well be a big concern when it comes to booting normal kernel but
I believe that for capture kernel (kernel booting after a crash), it might
not be that big an issue. Anyway, capture kernel is booting only to capture
and save the dump to some pre configured storage media. Most probably it 
will be done from an initrd or an init script and system will boot into
production kernel back enabling all the consoles. 

Alternatively, pci device id of console can be passed to capture kernel
through command line and disabling interrupts can be skipped on console.
This is little hackish though but crash dump is a peculiar case.


Thanks
Vivek

