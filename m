Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVASFsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVASFsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 00:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVASFsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 00:48:18 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:33768 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261591AbVASFr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 00:47:57 -0500
Date: Wed, 19 Jan 2005 16:47:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64: remove some unused iSeries functions
Message-Id: <20050119164753.5af63cc5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__19_Jan_2005_16_47_53_+1100_BWrgZfMgW4CXacuS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__19_Jan_2005_16_47_53_+1100_BWrgZfMgW4CXacuS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus, Andrew,

This patch removes some unused stuff from PPC64 iSeries:
	- asm-ppc64/iSeries/iSeries_VpdInfo.h
	- iSeries_GetLocationData()
	- LocationData structure
	- device_Location()

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/arch/ppc64/kernel/iSeries_VpdInfo.c linus-bk-sfr.16/arch/ppc64/kernel/iSeries_VpdInfo.c
--- linus-bk/arch/ppc64/kernel/iSeries_VpdInfo.c	2004-04-01 06:59:36.000000000 +1000
+++ linus-bk-sfr.16/arch/ppc64/kernel/iSeries_VpdInfo.c	2005-01-19 16:36:40.000000000 +1100
@@ -36,7 +36,6 @@
 #include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/mf.h>
 #include <asm/iSeries/LparData.h>
-//#include <asm/iSeries/iSeries_VpdInfo.h>
 #include <asm/iSeries/iSeries_pci.h>
 #include "pci.h"
 
@@ -85,30 +84,6 @@
 #define SLOT_ENTRY_SIZE   16
 
 /*
- * Bus, Card, Board, FrameId, CardLocation.
- */
-LocationData* iSeries_GetLocationData(struct pci_dev *PciDev)
-{
-	struct iSeries_Device_Node *DevNode =
-		(struct iSeries_Device_Node *)PciDev->sysdata;
-	LocationData *LocationPtr =
-		(LocationData *)kmalloc(LOCATION_DATA_SIZE, GFP_KERNEL);
-
-	if (LocationPtr == NULL) {
-		printk("PCI: LocationData area allocation failed!\n");
-		return NULL;
-	}
-	memset(LocationPtr, 0, LOCATION_DATA_SIZE);
-	LocationPtr->Bus = ISERIES_BUS(DevNode);
-	LocationPtr->Board = DevNode->Board;
-	LocationPtr->FrameId = DevNode->FrameId;
-	LocationPtr->Card = PCI_SLOT(DevNode->DevFn);
-	strcpy(&LocationPtr->CardLocation[0], &DevNode->CardLocation[0]);
-	return LocationPtr;
-}
-EXPORT_SYMBOL(iSeries_GetLocationData);
-
-/*
  * Formats the device information.
  * - Pass in pci_dev* pointer to the device.
  * - Pass in buffer to place the data.  Danger here is the buffer must
@@ -149,18 +124,6 @@
 }
 
 /*
- * Build a character string of the device location, Frame  1, Card  C10
- */
-int device_Location(struct pci_dev *PciDev, char *BufPtr)
-{
-	struct iSeries_Device_Node *DevNode =
-		(struct iSeries_Device_Node *)PciDev->sysdata;
-	return sprintf(BufPtr, "PCI: Bus%3d, AgentId%3d, Vendor %04X, Location %s",
-		       DevNode->DsaAddr.Dsa.busNumber, DevNode->AgentId,
-		       DevNode->Vendor, DevNode->Location);
-}
-
-/*
  * Parse the Slot Area
  */
 void iSeries_Parse_SlotArea(SlotMap *MapPtr, int MapLen,
diff -ruN linus-bk/include/asm-ppc64/iSeries/iSeries_VpdInfo.h linus-bk-sfr.16/include/asm-ppc64/iSeries/iSeries_VpdInfo.h
--- linus-bk/include/asm-ppc64/iSeries/iSeries_VpdInfo.h	2002-02-14 23:14:36.000000000 +1100
+++ linus-bk-sfr.16/include/asm-ppc64/iSeries/iSeries_VpdInfo.h	1970-01-01 10:00:00.000000000 +1000
@@ -1,56 +0,0 @@
-#ifndef _ISERIES_VPDINFO_H
-#define _ISERIES_VPDINFO_H
-/************************************************************************/
-/* File iSeries_VpdInfo.h created by Allan Trautman Feb 08 2001.        */
-/************************************************************************/
-/* This code supports the location data fon on the IBM iSeries systems. */
-/* Copyright (C) 20yy  <Allan H Trautman> <IBM Corp>                    */
-/*                                                                      */
-/* This program is free software; you can redistribute it and/or modify */
-/* it under the terms of the GNU General Public License as published by */
-/* the Free Software Foundation; either version 2 of the License, or    */
-/* (at your option) any later version.                                  */
-/*                                                                      */
-/* This program is distributed in the hope that it will be useful,      */ 
-/* but WITHOUT ANY WARRANTY; without even the implied warranty of       */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        */
-/* GNU General Public License for more details.                         */
-/*                                                                      */
-/* You should have received a copy of the GNU General Public License    */ 
-/* along with this program; if not, write to the:                       */
-/* Free Software Foundation, Inc.,                                      */ 
-/* 59 Temple Place, Suite 330,                                          */ 
-/* Boston, MA  02111-1307  USA                                          */
-/************************************************************************/
-/* Change Activity:                                                     */
-/*   Created, Feg  8, 2001                                              */
-/*   Reformated for Card, March 8, 2001                                 */
-/* End Change Activity                                                  */
-/************************************************************************/
-
-struct pci_dev; 		/* Forward Declare                      */
-/************************************************************************/
-/* Location Data extracted from the VPD list and device info.           */
-/************************************************************************/
-struct LocationDataStruct {	/* Location data structure for device   */
-	u16  Bus;		/* iSeries Bus Number		    0x00*/
-	u16  Board;		/* iSeries Board                    0x02*/
-	u8   FrameId;		/* iSeries spcn Frame Id            0x04*/
-	u8   PhbId;		/* iSeries Phb Location             0x05*/
-	u16  Card;		/* iSeries Card Slot                0x06*/
-	char CardLocation[4];	/* Char format of planar vpd        0x08*/
-	u8   AgentId;		/* iSeries AgentId                  0x0C*/
-	u8   SecondaryAgentId;	/* iSeries Secondary Agent Id       0x0D*/
-	u8   LinuxBus;		/* Linux Bus Number                 0x0E*/
-	u8   LinuxDevFn;	/* Linux Device Function            0x0F*/
-};
-typedef struct LocationDataStruct  LocationData;
-#define LOCATION_DATA_SIZE      16
-
-/************************************************************************/
-/* Protypes                                                             */
-/************************************************************************/
-extern LocationData* iSeries_GetLocationData(struct pci_dev* PciDev);
-extern int           iSeries_Device_Information(struct pci_dev*,char*, int);
-
-#endif /* _ISERIES_VPDINFO_H */
diff -ruN linus-bk/include/asm-ppc64/iSeries/iSeries_pci.h linus-bk-sfr.16/include/asm-ppc64/iSeries/iSeries_pci.h
--- linus-bk/include/asm-ppc64/iSeries/iSeries_pci.h	2004-04-01 06:59:37.000000000 +1000
+++ linus-bk-sfr.16/include/asm-ppc64/iSeries/iSeries_pci.h	2005-01-19 16:33:01.000000000 +1100
@@ -102,27 +102,9 @@
 };
 
 /************************************************************************/
-/* Location Data extracted from the VPD list and device info.           */
-/************************************************************************/
-
-struct LocationDataStruct { 	/* Location data structure for device  */
-	u16  Bus;               /* iSeries Bus Number              0x00*/
-	u16  Board;             /* iSeries Board                   0x02*/
-	u8   FrameId;           /* iSeries spcn Frame Id           0x04*/
-	u8   PhbId;             /* iSeries Phb Location            0x05*/
-	u8   AgentId;           /* iSeries AgentId                 0x06*/
-	u8   Card;
-	char CardLocation[4];      
-};
-
-typedef struct LocationDataStruct  LocationData;
-#define LOCATION_DATA_SIZE      48
-
-/************************************************************************/
 /* Functions                                                            */
 /************************************************************************/
 
-extern LocationData* iSeries_GetLocationData(struct pci_dev* PciDev);
 extern int           iSeries_Device_Information(struct pci_dev*,char*, int);
 extern void          iSeries_Get_Location_Code(struct iSeries_Device_Node*);
 extern int           iSeries_Device_ToggleReset(struct pci_dev* PciDev, int AssertTime, int DelayTime);

--Signature=_Wed__19_Jan_2005_16_47_53_+1100_BWrgZfMgW4CXacuS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB7fSJ4CJfqux9a+8RAo4GAJ4kDbbd/F9iMc+bzYZQWeyuawaIqwCeKaLn
UHcPSuml55SiER7JjIgDn84=
=1oZR
-----END PGP SIGNATURE-----

--Signature=_Wed__19_Jan_2005_16_47_53_+1100_BWrgZfMgW4CXacuS--
