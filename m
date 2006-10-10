Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWJJOEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWJJOEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJJOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:04:24 -0400
Received: from proof.pobox.com ([207.106.133.28]:1982 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1750793AbWJJOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:04:23 -0400
Date: Tue, 10 Oct 2006 09:04:23 -0500
From: Jon Mason <jdmason@kudzu.us>
To: greg@kroah.com, chrisw@sous-sol.org
Cc: stable@kernel.org, linux-kernel@vger.kernel.org, ak@suse.de,
       muli@il.ibm.com
Subject: [PATCH -stable] x86-64: Calgary IOMMU: Fix off by one when calculating register space location
Message-ID: <20061010140423.GA9656@kudzu.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has already been submitted for inclusion in the 2.6.19
tree, but not backported to the 2.6.18.  Please pull the bug fix
below into the stable tree for the 2.6.18.1 release.

The purpose of the code being modified is to determine the location
of the calgary chip address space.  This is done by a magical formula
of FE0MB-8MB*OneBasedChassisNumber+1MB*(RioNodeId-ChassisBase) to
find the offset where BIOS puts it.  In this formula,
OneBasedChassisNumber corresponds to the NUMA node, and rionodeid is
always 2 or 3 depending on which chip in the system it is.  The
problem was that we had an off by one error that caused us to account
some busses to the wrong chip and thus give them the wrong address
space.

Fixes RH bugzilla #203971.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 5f9cd2c5f515 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Oct 09 14:12:51 2006 -0500
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Oct 09 14:38:17 2006 -0500
@@ -759,7 +759,16 @@ static inline unsigned int __init locate
 	int rionodeid;
 	u32 address;
 
-	rionodeid = (dev->bus->number % 15 > 4) ? 3 : 2;
+	/*
+	 * Each Calgary has four busses. The first four busses (first Calgary)
+	 * have RIO node ID 2, then the next four (second Calgary) have RIO
+	 * node ID 3, the next four (third Calgary) have node ID 2 again, etc.
+	 * We use a gross hack - relying on the dev->bus->number ordering,
+	 * modulo 14 - to decide which Calgary a given bus is on. Busses 0, 1,
+	 * 2 and 4 are on the first Calgary (id 2), 6, 8, a and c are on the
+	 * second (id 3), and then it repeats modulo 14.
+ 	 */
+	rionodeid = (dev->bus->number % 14 > 4) ? 3 : 2;
 	/*
 	 * register space address calculation as follows:
 	 * FE0MB-8MB*OneBasedChassisNumber+1MB*(RioNodeId-ChassisBase)
@@ -767,7 +776,7 @@ static inline unsigned int __init locate
 	 * RioNodeId is 2 for first Calgary, 3 for second Calgary
 	 */
 	address = START_ADDRESS	-
-		(0x800000 * (ONE_BASED_CHASSIS_NUM + dev->bus->number / 15)) +
+		(0x800000 * (ONE_BASED_CHASSIS_NUM + dev->bus->number / 14)) +
 		(0x100000) * (rionodeid - CHASSIS_BASE);
 	return address;
 }
