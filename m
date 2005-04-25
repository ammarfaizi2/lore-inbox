Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDYWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDYWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVDYWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:03:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:13755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261245AbVDYV7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:59:10 -0400
Date: Mon, 25 Apr 2005 14:58:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alexn@dsv.su.se, greg@kroah.com, gud@eth.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-Id: <20050425145831.48f27edb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
References: <1114458325.983.17.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 25 Apr 2005, Alexander Nyberg wrote:
> 
> > Not sure what you mean by "make kexec work nicer" but if it is because
> > some devices don't work after a kexec I have some objections.
> 
> That was indeed the reason, at least in my case.  The newly-rebooted
> kernel doesn't work too well when there are active devices, with no driver
> loaded, doing DMA and issuing IRQs because they were never shut down.

I have vague memories of this being discussed at some length last year. 
Nothing comprehensive came of it, except that perhaps the kdump code should
spin with irqs off for a couple of seconds so the DMA and IRQs stop.

(Ongoing DMA is not a problem actually, because the kdump kernel won't be
using that memory anyway)

> > What about the kexec-on-panic?
> > 
> > In the end at least every storage device should work after a
> > kexec-on-panic or else there might be cases where we cannot get dumps of
> > what happened. My guess is that having access to the network might come
> > in handy after a kexec-on-panic as well.
> > 
> > So if this patch is because some devices don't work across kexec I don't
> > think this is a good idea because the same devices won't work after a
> > kexec-on-panic.
> 
> Do I understand your argument correctly?  You seem to be saying that 
> because this new facility sometimes won't work (the kexec-on-panic case) 
> it shouldn't be added at all.  What about all the other times when it will 
> work?

For kdump we really don't want to be doing fancy driver shutdown inside a
crashed kernel.  It would be better to just jump to the new kernel and
to reset the hardware from there.  DMA doesn't matter, and maybe IRQs can
be handled with a sustained local_irq_disable() (hard).

But for the normal kexec path, yes, graceful device shutdown is desirable.

So the requirements for the two different kexec scenarios are quite
different and it seems unlikely that any single approach to device shutdown
will suit both situations.

