Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDZPMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDZPMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVDZPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:12:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:3968 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261572AbVDZPL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:11:57 -0400
Date: Tue, 26 Apr 2005 11:11:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: alexn@dsv.su.se, <greg@kroah.com>, <gud@eth.net>,
       <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <jgarzik@pobox.com>, <cramerj@intel.com>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <20050425145831.48f27edb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0504261101060.12725-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Andrew Morton wrote:

> I have vague memories of this being discussed at some length last year. 
> Nothing comprehensive came of it, except that perhaps the kdump code should
> spin with irqs off for a couple of seconds so the DMA and IRQs stop.

Like Pavel said, this won't work.

> (Ongoing DMA is not a problem actually, because the kdump kernel won't be
> using that memory anyway)

For PCI devices at least, DMA _can_ be disabled in a uniform way as 
devices are discovered.  Some platforms might not want to do this for fear 
it would kill the initial console display.

IRQs _cannot_ be disabled in a uniform way.  So they remain a problem.

> For kdump we really don't want to be doing fancy driver shutdown inside a
> crashed kernel.  It would be better to just jump to the new kernel and
> to reset the hardware from there.  DMA doesn't matter, and maybe IRQs can
> be handled with a sustained local_irq_disable() (hard).

But at some point you have to enable local IRQs, and then you're in
trouble if a device without a driver is generating requests.  Unless the 
new kernel can run with interrupts entirely disabled?  Seems pretty 
unlikely.

The real problem is that, in general, hardware _can't_ be reset properly
by a new kernel.  There are things that can help, like the PCI USB quirks
code.  That might be enough to handle the most pressing existing problems;  
certainly it would avoid the USB issues we've seen.  (But it needs to be
updated to avoid interfering with normal operations during
resume-from-disk.)

Alan Stern

