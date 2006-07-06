Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWGFWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWGFWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGFWs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:48:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:47028 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750987AbWGFWs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:48:28 -0400
Date: Thu, 6 Jul 2006 17:48:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix PCI error token awkward value
Message-ID: <20060706224823.GC29526@austin.ibm.com>
References: <20060706220119.GB29526@austin.ibm.com> <20060706152203.5721d54e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706152203.5721d54e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 03:22:03PM -0700, Andrew Morton wrote:
> 
> Wouldn't it be better to sort out our initialisation so we don't actually
> need this memset-equals-pci_channel_io_normal trick?  pci_scan_device()
> looks like a good place..

OK, revised patch below. That's more typical of "application style
coding", where the apps waste a few extra cycles by zeroing a
struct and then immediately initializing struct members to non-zero
values (it seems that CPU designers have noticed that Java does this 
a lot). But I thought the kernel philosophy was "everythings zero
its safe to assume everything's zero, don't waste cycles on such
silliness". which is why you got the ewww pach.  

--linas

Subject: [PATCH] Initialize struct_pci error state

The pci channel state is currently uninitialized, thus there
are two ways of indicating that "everything's OK": 0 and 1.
This is a bit of a burden.

If a devce driver wants to check if the pci channel is in a working
or a disconnected state, the driver writer must perform checks similar
to

   if((pdev->error_state != 0) &&
      (pdev->error_state != pci_channel_io_normal)) {
         whatever();
   }

which is rather akward. The first check is needed because
stuct pci_dev is inited to all-zeros. The scond is needed
because the error recovery will set the state to
pci_channel_io_normal (which is not zero).

This patch fixes this awkwardness.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


----
 drivers/pci/probe.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.17-mm3/drivers/pci/probe.c
===================================================================
--- linux-2.6.17-mm3.orig/drivers/pci/probe.c	2006-06-27 11:39:09.000000000 -0500
+++ linux-2.6.17-mm3/drivers/pci/probe.c	2006-07-06 17:28:20.000000000 -0500
@@ -815,6 +815,7 @@ pci_scan_device(struct pci_bus *bus, int
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 	dev->cfg_size = pci_cfg_space_size(dev);
+	dev->error_state = pci_channel_io_normal;
 
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
