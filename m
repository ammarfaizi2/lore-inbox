Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDZQG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDZQG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDZQEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:04:32 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:9461 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261608AbVDZQBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:01:43 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Alexander Nyberg <alexn@dsv.su.se>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, gud@eth.net,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       jgarzik@pobox.com, cramerj@intel.com,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44L0.0504261101060.12725-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0504261101060.12725-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 18:01:30 +0200
Message-Id: <1114531290.10549.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-04-26 klockan 11:11 -0400 skrev Alan Stern:
> On Mon, 25 Apr 2005, Andrew Morton wrote:
> 
> > I have vague memories of this being discussed at some length last year. 
> > Nothing comprehensive came of it, except that perhaps the kdump code should
> > spin with irqs off for a couple of seconds so the DMA and IRQs stop.
> 
> Like Pavel said, this won't work.
> 
> > (Ongoing DMA is not a problem actually, because the kdump kernel won't be
> > using that memory anyway)
> 
> For PCI devices at least, DMA _can_ be disabled in a uniform way as 
> devices are discovered.  Some platforms might not want to do this for fear 
> it would kill the initial console display.
> 
> IRQs _cannot_ be disabled in a uniform way.  So they remain a problem.
> 
> > For kdump we really don't want to be doing fancy driver shutdown inside a
> > crashed kernel.  It would be better to just jump to the new kernel and
> > to reset the hardware from there.  DMA doesn't matter, and maybe IRQs can
> > be handled with a sustained local_irq_disable() (hard).
> 
> But at some point you have to enable local IRQs, and then you're in
> trouble if a device without a driver is generating requests.  Unless the 
> new kernel can run with interrupts entirely disabled?  Seems pretty 
> unlikely.

At least on x86 & x64 both i8259A and optional IOAPIC are initially
fully masked until a driver decides to open up a line.

If driver initialization fails then it should never open up the line on
the interrupt controller. So this shouldn't be a problem with interrupts
or am I missing something?
Shared interrupt lines do present a problem however as someone else gets
the chance to scream on an open line ultimately killing it, hmmm.

> The real problem is that, in general, hardware _can't_ be reset properly
> by a new kernel.  There are things that can help, like the PCI USB quirks
> code.  That might be enough to handle the most pressing existing problems;  
> certainly it would avoid the USB issues we've seen.  (But it needs to be
> updated to avoid interfering with normal operations during
> resume-from-disk.)



