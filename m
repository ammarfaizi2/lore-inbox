Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVCARLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVCARLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVCARLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:11:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5823 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261982AbVCARLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:11:17 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Date: Tue, 1 Mar 2005 09:10:29 -0800
User-Agent: KMail/1.7.2
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503010910.29460.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 1, 2005 8:59 am, Matthew Wilcox wrote:
> The MCA handler has to go and figure out what the hell just happened
> (was it a DIMM error, PCI bus error, etc).  OK, fine, it finds that it
> was an error on PCI bus 73.  At this point, I think the architecture
> error handler needs to call into the PCI subsystem and say "Hey, there
> was an error, you deal with it".
>
> If we're lucky, we get all the information that allows us to figure
> out which device it was (eg a destination address that matches a BAR),
> then we could have a ->error method in the pci_driver that handles it.
> If there's no ->error method, at leat call ->remove so one device only
> takes itself down.
>
> Does this make sense?

This was my thought too last time we had this discussion.  A completely 
asynchronous call is probably needed in addition to Hidetoshi's proposed API, 
since as you point out, the driver may not be running when an error occurs 
(e.g. in the case of a DMA error or more general bus problem).  The async 
->error callback could do a total reset of the card, or something along those 
lines as Jeff suggests, while the inline ioerr_clear/ioerr_check API could 
potentially deal with errors as they happen (probably in the case of PIO 
related errors), when the additional context may allow us to be smarter about 
recovery.

Jesse
