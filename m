Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWGFWBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWGFWBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWGFWBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:01:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31625 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750884AbWGFWBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:01:21 -0400
Date: Thu, 6 Jul 2006 17:01:19 -0500
To: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix PCI error token awkward value
Message-ID: <20060706220119.GB29526@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The pci channel state token currently has a poor choice of values;
there  are two ways of indicating that "everything's OK": 0 and 1.
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

 include/linux/pci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-mm3/include/linux/pci.h
===================================================================
--- linux-2.6.17-mm3.orig/include/linux/pci.h	2006-06-27 11:39:16.000000000 -0500
+++ linux-2.6.17-mm3/include/linux/pci.h	2006-07-06 15:15:09.000000000 -0500
@@ -85,7 +85,7 @@ typedef unsigned int __bitwise pci_chann
 
 enum pci_channel_state {
 	/* I/O channel is in normal state */
-	pci_channel_io_normal = (__force pci_channel_state_t) 1,
+	pci_channel_io_normal = (__force pci_channel_state_t) 0,
 
 	/* I/O to channel is blocked */
 	pci_channel_io_frozen = (__force pci_channel_state_t) 2,
