Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUJOP2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUJOP2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJOP2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:28:39 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:6980 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267976AbUJOP2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:28:37 -0400
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
	: oops...]
From: Paul Fulghum <paulkf@microgate.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <416F09EF.6040605@free.fr>
References: <Pine.LNX.4.44L0.0410141703260.1026-100000@ida.rowland.org>
	 <416F09EF.6040605@free.fr>
Content-Type: text/plain
Message-Id: <1097853723.5829.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 10:22:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 18:21, Laurent Riffard wrote:
> Alan Stern wrote:
> > Yes, try that.  At least if the problem still occurs, it will be
> > easier to track down.
> > 
> > Alan Stern
> > 
> 
> I just tried kernel 2.6.9-rc4 : it woks fine, there is no oops when 
> I rmmod uhci_hcd.

Alan:

This looks like it is related to the generic-irq-subsystem patches.
Specifically, adding and removing proc entries for each interrupt.

Laurent's configuration has two controllers sharing the same interrupt.
The hcd->description for both controllers are identical: "uhci_hcd"

This string is used when requesting the irq (hcd-pci.c).
request_irq() creates a /proc/irq/nn/uhci_hcd entry.
The IRQ action->dir (one for each device) is a pointer to this entry.
There does not appear to be a check for name collision
when creating this entry. So two identical entries are created,
one for each device. The proc entries are added to the head of
a list so the second entry is 1st in the list.

When unloading the module, the proc entry is removed when free_irq()
is called. Removal of the proc entry is based on name matching
starting at the head of the list so the 2nd entry is found 1st.
It looks like the proc entry of the second device is removed
when calling free_irq() for the first device. When the
second device is removed, the action->dir has already
been freed causing the oops.

Comments?

-- 
Paul Fulghum
paulkf@microgate.com

