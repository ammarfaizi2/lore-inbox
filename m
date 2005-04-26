Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDZPvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDZPvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDZPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:50:07 -0400
Received: from colo.lackof.org ([198.49.126.79]:34779 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261579AbVDZPrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:47:14 -0400
Date: Tue, 26 Apr 2005 09:49:42 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426154942.GB2612@colo.lackof.org>
References: <1114462323.983.45.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251700560.4896-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0504251700560.4896-100000@iolanthe.rowland.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 05:12:09PM -0400, Alan Stern wrote:
> Do you have any suggestions for a better way to stop a device from issuing
> IRQs and doing DMA at any point between the time when the old kernel
> panics and the time when the new kernel loads the device's driver?

PCI Bus resets?

That means linux kernel needs to reconfigure everything unless
the BIOS gets invoked again (machine reset). Linux has *most*
of the code to do this but I'm pretty sure enough existing
configs won't work that this will be very painful.

> I looked into the possibility of having the PCI core disable interrupt
> generation and DMA on each new device as it is discovered.  Unfortunately
> there is no dependable, universal way to do this for IRQs.

Sure there is. Every IRQ line goes to an IRQ controller.
Arch specific code deals with programming the controller and can
mask all interrupts (or not). Historically, they've been left unmasked
for ISA IRQ discovery and debugging misrouted IRQ lines.

> (A notable gap in the original PCI specification, IMHO.)  Another problem
> with this
> approach is that on some platforms the initial console is a PCI device
> driven by the firmware, but the firmware won't tell Linux which device it
> is!  Disable the wrong device and away goes your screen display.

Exactly. That's really the main problem with disabling DMA globally.
I don't have any brilliant ideas on how to fix this either
except shutdown console before PCI bus walks and switch to 
linux console after PCI bus walks. Makes debugging PCI issues
a bit more difficult though.

grant
