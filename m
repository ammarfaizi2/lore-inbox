Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVAKRr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVAKRr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVAKRr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:47:57 -0500
Received: from colin2.muc.de ([193.149.48.15]:12812 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261182AbVAKRdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:33:38 -0500
Date: 11 Jan 2005 18:33:32 +0100
Date: Tue, 11 Jan 2005 18:33:32 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050111173332.GA17077@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105454259.15794.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 02:37:40PM +0000, Alan Cox wrote:
> On Llu, 2005-01-10 at 22:57, Brian King wrote:
> > > For this I would add a semaphore or a lock bit to pci_dev.
> > > Probably a simple flag is good enough that is checked by sysfs/proc
> > > and return EBUSY when set. 
> > 
> > How about something like this... (only compile tested at this point)
> 
> 
> User space does not expect to get dumped with -EBUSY randomly on PCI

I think it's a reasonable thing to do.  If you prefer you could fake a
0xffffffff read, that would look like busy or non existing hardware.
But the errno would seem to be cleaner to me.

There may be other reasons to have error codes here in the future
too - e.g. with the upcomming support for real PCI error handling
it would make a lot of sense to return EIO in some cases. User space
will just have to cope with that.

> accesses. Not a viable option in that form _but_ making them sleep would
> work - even with a simple global wait queue
> for the pci_unblock_.. path
> 
> ie add the following (oh and uninlined probably for compatcness)
> 
> static int pci_user_wait_access(struct pci_dev *pdev) {
> 	wait_event(&pci_ucfg_wait, dev->block_ucfg_access == 0);
> }

I don't like this very much. What happens when the device 
doesn't get out of BIST for some reason? 

I think it's better to keep this simple, and an error is fine for that.

-Andi
