Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270042AbUJSXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270042AbUJSXBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270189AbUJSWzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:55:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:61065 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270046AbUJSWqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:20 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257393636@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257394160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.57, 2004/10/06 13:53:18-07:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: RPA DLPAR - remove error check

Here's a really long explanation for a really short patch! :)

As an unfortunate side effect of runtime addition/removal of PCI Host Bridges,
the RPA DLPAR driver can no longer depend on the success of ioremap_explicit()
(and therefore remap_page_range()) for the case of DLPAR adding an I/O Slot.

Without addressing this, an attempt to add the first child slot of a newly
added PHB will fail when __ioremap_explicit() determines the mappings for that
range to already exist.

For a little context, __ioremap_explicit() creates mappings for the range of a
newly added slot.  Here's why these calls will be expected to fail in some
cases.  Keep in mind that at boot-time, the PPC64 kernel calls ioremap() for
the entire range spanned by each PHB.  Consider the following scenarios of
DLPAR-adding an I/O slot.

1) Just after boot, one removes an I/O slot.  At this point the range
   associated with the parent PHB is fragmented, and the child range for the
   slot in question is iounmap()'ed.  One then re-adds the slot, at which point
   remap_page_range()/ioremap_explicit() restores the mappings that were
   previously removed.

2) One adds a new PHB, at which point the ppc64-specific addition ioremaps the
   entire PHB range.  One then performs a DLPAR-add of a child slot of that
   PHB.  At this point, mappings already exist for the range of the slot to
   be added.  So remap_page_range()/ioremap_explicit() will fail at this point.

The problem is, there's not a good way to distinguish between cases 1 and 2
from the perspective of the DLPAR driver.  Because of that, I believe the
correct solution to be:

- Removal of relevant error prints from iounmap_explicit(), which is only used
  for DLPAR.
- Removal of error code checks from the RPA driver


Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpadlpar_core.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- a/drivers/pci/hotplug/rpadlpar_core.c	2004-10-19 15:22:29 -07:00
+++ b/drivers/pci/hotplug/rpadlpar_core.c	2004-10-19 15:22:29 -07:00
@@ -158,12 +158,8 @@
 
 	dn->bussubno = child->number;
 
-	/* ioremap() for child bus */
-	if (remap_bus_range(child)) {
-		printk(KERN_ERR "%s: could not ioremap() child bus\n",
-			__FUNCTION__);
-		return 1;
-	}
+	/* ioremap() for child bus, which may or may not succeed */
+	remap_bus_range(child);
 
 	return 0;
 }

