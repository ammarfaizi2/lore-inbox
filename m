Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271086AbUJUXgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271086AbUJUXgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271095AbUJUXdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:33:10 -0400
Received: from ozlabs.org ([203.10.76.45]:2959 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S271051AbUJUXXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:23:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.16691.697562.175054@cargo.ozlabs.ibm.com>
Date: Fri, 22 Oct 2004 09:07:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, John Rose <johnrose@austin.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] PPC64 remove __ioremap_explicit() error message
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, from John Rose, is the counterpart of one recently
forwarded by Greg KH.  It has the same description, but isn't the same
patch - this is the arch/ppc64 part of the change.

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

Here's the first of these.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Nru a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	Wed Sep 29 14:10:06 2004
+++ b/arch/ppc64/mm/init.c	Wed Sep 29 14:10:06 2004
@@ -265,7 +265,7 @@
 	} else {
 		area = im_get_area(ea, size, IM_REGION_UNUSED|IM_REGION_SUBSET);
 		if (area == NULL) {
-			printk(KERN_ERR "could not obtain imalloc area for ea 0x%lx\n", ea);
+			/* Expected when PHB-dlpar is in play */
 			return 1;
 		}
 		if (ea != (unsigned long) area->addr) {
