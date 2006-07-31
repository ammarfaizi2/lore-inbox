Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWGaS6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWGaS6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWGaS6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:58:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57867 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030324AbWGaS6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:58:09 -0400
Date: Mon, 31 Jul 2006 14:58:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Aleksey Gorelov <dared1st@yahoo.com>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier
 in case of failure in ehci hcd
In-Reply-To: <20060731182824.51600.qmail@web81214.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.44L0.0607311450120.8671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Aleksey Gorelov wrote:

> > Why do you need to change the bus glue?  Wouldn't it be a lot simpler just 
> > to add ehci_shutdown as a member of ehci_pci_driver, for instance, with 
> > similar changes to ehci_hcd_au1xxx_driver and ehci_hcd_fsl_driver?
> > 
> > Alan Stern
> 
>   This avoids code duplication for common for both ehci and ohci code

What code duplication?  Doing it the way I suggested doesn't require 
adding any new code at all.  You, on the other hand, added several 
routines for bus glue that does virtually nothing.

> (and possibly for uhci, but
> it currently does not have any notifier/shutdown handler),

Yes it does.  From uhci-hcd.c:

static struct pci_driver uhci_pci_driver = {
        .name =         (char *)hcd_name,
        .id_table =     uhci_pci_ids,

        .probe =        usb_hcd_pci_probe,
        .remove =       usb_hcd_pci_remove,
        .shutdown =     uhci_shutdown,
	^
--------^ See this?

#ifdef  CONFIG_PM
        .suspend =      usb_hcd_pci_suspend,
        .resume =       usb_hcd_pci_resume,
#endif  /* PM */
};


> and is consistent with other functions
> there.

The shutdown routine doesn't have to be consistent with other functions 
because it runs in a very special environment.  Furthermore, those other 
functions use bus glue because they need to do a lot of things in common 
with other HCDs.  A shutdown method doesn't need to do those things.

Alan Stern

