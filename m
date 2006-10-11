Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161440AbWJKVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbWJKVMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWJKVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:48035 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161447AbWJKVJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:29 -0400
Date: Wed, 11 Oct 2006 14:09:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, muli@il.ibm.com, ak@suse.de,
       Jon Mason <jdmason@kudzu.us>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 64/67] x86-64: Calgary IOMMU: Fix off by one when calculating register space location
Message-ID: <20061011210907.GM16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86-64-calgary-iommu-fix-off-by-one-when-calculating-register-space-location.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jon Mason <jdmason@kudzu.us>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux-2.6.18/arch/x86_64/kernel/pci-calgary.c
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

--
