Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVBQTEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVBQTEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVBQTEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:04:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42926 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262310AbVBQTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:04:11 -0500
Date: Thu, 17 Feb 2005 19:04:08 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Christophe Lucas <c.lucas@ifrance.com>,
       kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] drivers/char/watchdog/* : pci_request_regions
Message-ID: <20050217190408.GW29917@parcelfarce.linux.theplanet.co.uk>
References: <20050214150111.GH20620@rhum.iomeda.fr> <20050214151244.GF29917@parcelfarce.linux.theplanet.co.uk> <4214E728.3030501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214E728.3030501@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 01:49:12PM -0500, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >On Mon, Feb 14, 2005 at 04:01:11PM +0100, Christophe Lucas wrote:
> >
> >>If PCI request regions fails, then someone else is using the
> >>hardware we wish to use. For that one case, calling
> >>pci_disable_device() is rather rude.
> >>See : http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/1061.html
> >
> >
> >Actually, that isn't necessarily true.  If the request_regions call fails,
> >that can mean there's a resource conflict.  If so, leaving the device
> >enabled is the worst possible thing to do as we'll now have two devices
> >trying to respond to the same io accesses.
> 
> Incorrect.  If request_region() fails, drivers are coded to _not_ touch 
> the hardware.  That's the entire purpose of the whole charade: to avoid 
> having two devices responding to the same io accesses.
> 
> If your driver is talking to the hardware after request_region() fails, 
> it is BROKEN plain and simple.

I don't think you understood my point.  Assume we really do have two
devices in the system with clashing resource settings.  Yes, I really
have seen this happen; it's rare.

While the PCI device is disabled, there is no problem.  But then we call
pci_enable_device(), so now the device is enabled to respond to IO and
memory resources in its BARs.

At the point we discover this, we need to disable the PCI device again
-- exactly the opposite behaviour from your case where we need to leave
the PCI device enabled when we have resource conflicts.

I think the only way to fix this is have pci_enable_device claim the
resources for the BARs before enabling the PCI device to respond to the
resources; that way we leave the enable bits the way they currently are.
No, this doesn't cure the world's ills, but it does obey "First, do
no harm".  One way it'll fail is if the other driver loads after the PCI
driver that claims this resource.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
