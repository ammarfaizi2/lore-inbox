Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUJOQUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUJOQUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUJOQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:20:06 -0400
Received: from ida.rowland.org ([192.131.102.52]:16132 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268092AbUJOQSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:18:18 -0400
Date: Fri, 15 Oct 2004 12:18:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
 : oops...]
In-Reply-To: <1097853723.5829.17.camel@deimos.microgate.com>
Message-ID: <Pine.LNX.4.44L0.0410151215440.1052-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Paul Fulghum wrote:

> This looks like it is related to the generic-irq-subsystem patches.
> Specifically, adding and removing proc entries for each interrupt.
> 
> Laurent's configuration has two controllers sharing the same interrupt.
> The hcd->description for both controllers are identical: "uhci_hcd"
> 
> This string is used when requesting the irq (hcd-pci.c).
> request_irq() creates a /proc/irq/nn/uhci_hcd entry.
> The IRQ action->dir (one for each device) is a pointer to this entry.
> There does not appear to be a check for name collision
> when creating this entry. So two identical entries are created,
> one for each device. The proc entries are added to the head of
> a list so the second entry is 1st in the list.
> 
> When unloading the module, the proc entry is removed when free_irq()
> is called. Removal of the proc entry is based on name matching
> starting at the head of the list so the 2nd entry is found 1st.
> It looks like the proc entry of the second device is removed
> when calling free_irq() for the first device. When the
> second device is removed, the action->dir has already
> been freed causing the oops.
> 
> Comments?

Your explanation sounds entirely reasonable to me.  Can you pass it on to 
the people responsible for the generic-irq subsystem?

Alan Stern

