Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVDZDrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVDZDrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDZDrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:47:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:11206 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261294AbVDZDqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:46:31 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se,
       Greg KH <greg@kroah.com>, gud@eth.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>,
       cramerj@intel.com, Linux-USB <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425145831.48f27edb.akpm@osdl.org>
References: <1114458325.983.17.camel@localhost.localdomain>
	 <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	 <20050425145831.48f27edb.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:45:43 +1000
Message-Id: <1114487143.7112.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 14:58 -0700, Andrew Morton wrote:
> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, 25 Apr 2005, Alexander Nyberg wrote:
> > 
> > > Not sure what you mean by "make kexec work nicer" but if it is because
> > > some devices don't work after a kexec I have some objections.
> > 
> > That was indeed the reason, at least in my case.  The newly-rebooted
> > kernel doesn't work too well when there are active devices, with no driver
> > loaded, doing DMA and issuing IRQs because they were never shut down.
> 
> I have vague memories of this being discussed at some length last year. 
> Nothing comprehensive came of it, except that perhaps the kdump code should
> spin with irqs off for a couple of seconds so the DMA and IRQs stop.

That i bogus, USB will never stop DMA unless told to do so for example.

> (Ongoing DMA is not a problem actually, because the kdump kernel won't be
> using that memory anyway)

Ok, good. So kdump don't need to call PMSG_FREEZE, normal kexec still
does though.

> > > What about the kexec-on-panic?
> > > 
> > > In the end at least every storage device should work after a
> > > kexec-on-panic or else there might be cases where we cannot get dumps of
> > > what happened. My guess is that having access to the network might come
> > > in handy after a kexec-on-panic as well.
> > > 
> > > So if this patch is because some devices don't work across kexec I don't
> > > think this is a good idea because the same devices won't work after a
> > > kexec-on-panic.
> > 
> > Do I understand your argument correctly?  You seem to be saying that 
> > because this new facility sometimes won't work (the kexec-on-panic case) 
> > it shouldn't be added at all.  What about all the other times when it will 
> > work?
> 
> For kdump we really don't want to be doing fancy driver shutdown inside a
> crashed kernel.  It would be better to just jump to the new kernel and
> to reset the hardware from there.  DMA doesn't matter, and maybe IRQs can
> be handled with a sustained local_irq_disable() (hard).

Yup.

> But for the normal kexec path, yes, graceful device shutdown is desirable.
> 
> So the requirements for the two different kexec scenarios are quite
> different and it seems unlikely that any single approach to device shutdown
> will suit both situations.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

