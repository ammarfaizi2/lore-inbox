Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUHEUqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUHEUqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUHEUqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:46:48 -0400
Received: from web14921.mail.yahoo.com ([216.136.225.5]:64175 "HELO
	web14921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267945AbUHEUpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:45:19 -0400
Message-ID: <20040805204518.21243.qmail@web14921.mail.yahoo.com>
Date: Thu, 5 Aug 2004 13:45:18 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200408050925.16695.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> pci_assign_resource is mucking with the values in 
> pci_dev->resource[PCI_ROM_RESOURCE].  If I remove the call to 
> pci_assign_resource, things work for me.  Is that call really
> necessary?  
> Don't we just need ioremap?

/* assign the ROM an address if it doesn't have one */
if (res->parent == NULL)
	pci_assign_resource(dev, PCI_ROM_RESOURCE);

It is protected by the (res->parent == NULL). Looking at the code in
kernel/resource.c this is the correct check to see if the resource does
not have an address assigned. If (res->parent != NULL) then it is
supposed to muck with the addresses.

If you follow the code path of pci_assign_resource() it will program
the ROM to appear at the newly assigned address in
pci_update_resource(). I'd check these code paths and see if they are
64 bit broken. This process does work on ia32.

If you can read the ROM without a resource assigned it is just luck
that everything is still in the same place as boot. If you start
hotpluging the original ROM address could get used by another card
since is is not actively assigned.

I didn't check the error code from pci_assign_resource(). If it can't
match the PREFETCH type it will fail. That may be what is happening.
I'll add a check.




=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
