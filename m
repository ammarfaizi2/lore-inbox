Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVFJWpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVFJWpC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVFJWpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:45:01 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35050 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261370AbVFJWoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:44:15 -0400
Date: Fri, 10 Jun 2005 16:22:52 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH] Fix PCI BAR size interpretation on 64-bit arches
Message-ID: <20050610212252.GA28655@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 64-bit machines, PCI_BASE_ADDRESS_MEM_MASK and other mask constants
passed to pci_size() are 64-bit (for example ~0x0fUL). However, pci_size
does comparisons between the u32 arguments and the mask, which will fail
even though any result from pci_size is still just 32-bit.

Changing the mask argument to u32 seems the obvious thing to do, since
all arithmetic in the function is 32-bit and having a larger mask makes
no sense.

This triggered on a PPC64 system here where an adapter (VGA, as it
happened) had a memory region base of 0xfe000000 and a sz of the same,
matching the if (max == maxbase ...) test at the bottom of pci_size
but failing the mask comparison. Quite a corner case which I guess
explains why we haven't seen it until now.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/drivers/pci/probe.c
===================================================================
--- 2.6.orig/drivers/pci/probe.c	2005-06-10 15:09:37.000000000 -0500
+++ 2.6/drivers/pci/probe.c	2005-06-10 15:43:36.000000000 -0500
@@ -125,7 +125,7 @@ static inline unsigned int pci_calc_reso
 /*
  * Find the extent of a PCI decode..
  */
-static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
+static u32 pci_size(u32 base, u32 maxbase, u32 mask)
 {
 	u32 size = mask & maxbase;	/* Find the significant bits */
 	if (!size)
