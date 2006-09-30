Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWI3Ioa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWI3Ioa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWI3In7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:43:59 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:51985 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751159AbWI3Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 4] x86-64: Calgary IOMMU: Fix off by one when calculating
	register space
X-Mercurial-Node: 1e2a3d57541a0d31894c179ef45dd4c5a21ca308
Message-Id: <1e2a3d57541a0d31894c.1159605812@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1159605808@rhun.haifa.ibm.com>
Date: Sat, 30 Sep 2006 11:43:32 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 11 insertions(+), 2 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   13 +++++++++++--


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1159604463 -10800
# Node ID 1e2a3d57541a0d31894c179ef45dd4c5a21ca308
# Parent  7aff757cee0ea0566ae4016b43a0284769b0b27a
x86-64: Calgary IOMMU: Fix off by one when calculating register space
location

From: Jon Mason <jdmason@kudzu.us>

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
Signed-off-bu: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 7aff757cee0e -r 1e2a3d57541a arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:19:39 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:21:03 2006 +0300
@@ -792,7 +792,16 @@ static inline unsigned int __init locate
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
@@ -800,7 +809,7 @@ static inline unsigned int __init locate
 	 * RioNodeId is 2 for first Calgary, 3 for second Calgary
 	 */
 	address = START_ADDRESS	-
-		(0x800000 * (ONE_BASED_CHASSIS_NUM + dev->bus->number / 15)) +
+		(0x800000 * (ONE_BASED_CHASSIS_NUM + dev->bus->number / 14)) +
 		(0x100000) * (rionodeid - CHASSIS_BASE);
 	return address;
 }
