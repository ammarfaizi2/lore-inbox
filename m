Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWJRQqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWJRQqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWJRQqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:46:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:59479 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422682AbWJRQp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:45:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=njiV6dmALRpTbTBkEGfTcifWaf3Zyt0h2WhI/dbZiFPgsm6eI2ZdfIOEDhiz2ymf4rA5UePPpQ2iCnv2cuF/hV2q2fd+z5OrsojcnmcelGDP8S/ZziAGfFWPAV3w5rB1d9kNrTPUOW+H009oKIp9VtIDw2zFjue6+43VFL6+m80=
Date: Thu, 19 Oct 2006 01:46:47 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Mirko Lindner <mlindner@syskonnect.de>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 4/6] net: use bitrev8
Message-ID: <20061018164647.GD21820@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Mirko Lindner <mlindner@syskonnect.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitrev8 for bmac, mace, macmace, macsonic, and skfp drivers.

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mirko Lindner <mlindner@syskonnect.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/net/Kconfig        |    1 
 drivers/net/bmac.c         |   20 ++--------
 drivers/net/mace.c         |   16 +-------
 drivers/net/macmace.c      |   18 +--------
 drivers/net/macsonic.c     |    6 ---
 drivers/net/skfp/can.c     |   83 ---------------------------------------------
 drivers/net/skfp/drvfbi.c  |   21 ++++-------
 drivers/net/skfp/fplustm.c |    4 +-
 drivers/net/skfp/smt.c     |    7 +--
 9 files changed, 25 insertions(+), 151 deletions(-)

Index: work-fault-inject/drivers/net/bmac.c
===================================================================
--- work-fault-inject.orig/drivers/net/bmac.c
+++ work-fault-inject/drivers/net/bmac.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/crc32.h>
+#include <linux/bitrev.h>
 #include <asm/prom.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
@@ -140,7 +141,6 @@ static unsigned char *bmac_emergency_rxb
 	+ (N_RX_RING + N_TX_RING + 4) * sizeof(struct dbdma_cmd) \
 	+ sizeof(struct sk_buff_head))
 
-static unsigned char bitrev(unsigned char b);
 static int bmac_open(struct net_device *dev);
 static int bmac_close(struct net_device *dev);
 static int bmac_transmit_packet(struct sk_buff *skb, struct net_device *dev);
@@ -586,18 +586,6 @@ bmac_construct_rxbuff(struct sk_buff *sk
 		     virt_to_bus(addr), 0);
 }
 
-/* Bit-reverse one byte of an ethernet hardware address. */
-static unsigned char
-bitrev(unsigned char b)
-{
-	int d = 0, i;
-
-	for (i = 0; i < 8; ++i, b >>= 1)
-		d = (d << 1) | (b & 1);
-	return d;
-}
-
-
 static void
 bmac_init_tx_ring(struct bmac_data *bp)
 {
@@ -1224,8 +1212,8 @@ bmac_get_station_address(struct net_devi
 		{
 			reset_and_select_srom(dev);
 			data = read_srom(dev, i + EnetAddressOffset/2, SROMAddressBits);
-			ea[2*i]   = bitrev(data & 0x0ff);
-			ea[2*i+1] = bitrev((data >> 8) & 0x0ff);
+			ea[2*i]   = bitrev8(data & 0x0ff);
+			ea[2*i+1] = bitrev8((data >> 8) & 0x0ff);
 		}
 }
 
@@ -1315,7 +1303,7 @@ static int __devinit bmac_probe(struct m
 
 	rev = addr[0] == 0 && addr[1] == 0xA0;
 	for (j = 0; j < 6; ++j)
-		dev->dev_addr[j] = rev? bitrev(addr[j]): addr[j];
+		dev->dev_addr[j] = rev ? bitrev8(addr[j]): addr[j];
 
 	/* Enable chip without interrupts for now */
 	bmac_enable_and_reset_chip(dev);
Index: work-fault-inject/drivers/net/mace.c
===================================================================
--- work-fault-inject.orig/drivers/net/mace.c
+++ work-fault-inject/drivers/net/mace.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/crc32.h>
 #include <linux/spinlock.h>
+#include <linux/bitrev.h>
 #include <asm/prom.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
@@ -74,7 +75,6 @@ struct mace_data {
 #define PRIV_BYTES	(sizeof(struct mace_data) \
 	+ (N_RX_RING + NCMDS_TX * N_TX_RING + 3) * sizeof(struct dbdma_cmd))
 
-static int bitrev(int);
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
 static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
@@ -96,18 +96,6 @@ static void __mace_set_address(struct ne
  */
 static unsigned char *dummy_buf;
 
-/* Bit-reverse one byte of an ethernet hardware address. */
-static inline int
-bitrev(int b)
-{
-    int d = 0, i;
-
-    for (i = 0; i < 8; ++i, b >>= 1)
-	d = (d << 1) | (b & 1);
-    return d;
-}
-
-
 static int __devinit mace_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *mace = macio_get_of_node(mdev);
@@ -173,7 +161,7 @@ static int __devinit mace_probe(struct m
 
 	rev = addr[0] == 0 && addr[1] == 0xA0;
 	for (j = 0; j < 6; ++j) {
-		dev->dev_addr[j] = rev? bitrev(addr[j]): addr[j];
+		dev->dev_addr[j] = rev ? bitrev8(addr[j]): addr[j];
 	}
 	mp->chipid = (in_8(&mp->mace->chipid_hi) << 8) |
 			in_8(&mp->mace->chipid_lo);
Index: work-fault-inject/drivers/net/macmace.c
===================================================================
--- work-fault-inject.orig/drivers/net/macmace.c
+++ work-fault-inject/drivers/net/macmace.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/crc32.h>
+#include <linux/bitrev.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
@@ -81,19 +82,6 @@ static irqreturn_t mace_interrupt(int ir
 static irqreturn_t mace_dma_intr(int irq, void *dev_id);
 static void mace_tx_timeout(struct net_device *dev);
 
-/* Bit-reverse one byte of an ethernet hardware address. */
-
-static int bitrev(int b)
-{
-	int d = 0, i;
-
-	for (i = 0; i < 8; ++i, b >>= 1) {
-		d = (d << 1) | (b & 1);
-	}
-
-	return d;
-}
-
 /*
  * Load a receive DMA channel with a base address and ring length
  */
@@ -219,12 +207,12 @@ struct net_device *mace_probe(int unit)
 	addr = (void *)MACE_PROM;
 
 	for (j = 0; j < 6; ++j) {
-		u8 v=bitrev(addr[j<<4]);
+		u8 v = bitrev8(addr[j<<4]);
 		checksum ^= v;
 		dev->dev_addr[j] = v;
 	}
 	for (; j < 8; ++j) {
-		checksum ^= bitrev(addr[j<<4]);
+		checksum ^= bitrev8(addr[j<<4]);
 	}
 
 	if (checksum != 0xFF) {
Index: work-fault-inject/drivers/net/macsonic.c
===================================================================
--- work-fault-inject.orig/drivers/net/macsonic.c
+++ work-fault-inject/drivers/net/macsonic.c
@@ -121,16 +121,12 @@ enum macsonic_type {
  * For reversing the PROM address
  */
 
-static unsigned char nibbletab[] = {0, 8, 4, 12, 2, 10, 6, 14,
-				    1, 9, 5, 13, 3, 11, 7, 15};
-
 static inline void bit_reverse_addr(unsigned char addr[6])
 {
 	int i;
 
 	for(i = 0; i < 6; i++)
-		addr[i] = ((nibbletab[addr[i] & 0xf] << 4) |
-			   nibbletab[(addr[i] >> 4) &0xf]);
+		addr[i] = bitrev8(addr[i]);
 }
 
 int __init macsonic_init(struct net_device* dev)
Index: work-fault-inject/drivers/net/skfp/can.c
===================================================================
--- work-fault-inject.orig/drivers/net/skfp/can.c
+++ /dev/null
@@ -1,83 +0,0 @@
-/******************************************************************************
- *
- *	(C)Copyright 1998,1999 SysKonnect,
- *	a business unit of Schneider & Koch & Co. Datensysteme GmbH.
- *
- *	See the file "skfddi.c" for further information.
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; either version 2 of the License, or
- *	(at your option) any later version.
- *
- *	The information in this file is provided "AS IS" without warranty.
- *
- ******************************************************************************/
-
-#ifndef	lint
-static const char xID_sccs[] = "@(#)can.c	1.5 97/04/07 (C) SK " ;
-#endif
-
-/*
- * canonical bit order
- */
-const u_char canonical[256] = {
-	0x00,0x80,0x40,0xc0,0x20,0xa0,0x60,0xe0,
-	0x10,0x90,0x50,0xd0,0x30,0xb0,0x70,0xf0,
-	0x08,0x88,0x48,0xc8,0x28,0xa8,0x68,0xe8,
-	0x18,0x98,0x58,0xd8,0x38,0xb8,0x78,0xf8,
-	0x04,0x84,0x44,0xc4,0x24,0xa4,0x64,0xe4,
-	0x14,0x94,0x54,0xd4,0x34,0xb4,0x74,0xf4,
-	0x0c,0x8c,0x4c,0xcc,0x2c,0xac,0x6c,0xec,
-	0x1c,0x9c,0x5c,0xdc,0x3c,0xbc,0x7c,0xfc,
-	0x02,0x82,0x42,0xc2,0x22,0xa2,0x62,0xe2,
-	0x12,0x92,0x52,0xd2,0x32,0xb2,0x72,0xf2,
-	0x0a,0x8a,0x4a,0xca,0x2a,0xaa,0x6a,0xea,
-	0x1a,0x9a,0x5a,0xda,0x3a,0xba,0x7a,0xfa,
-	0x06,0x86,0x46,0xc6,0x26,0xa6,0x66,0xe6,
-	0x16,0x96,0x56,0xd6,0x36,0xb6,0x76,0xf6,
-	0x0e,0x8e,0x4e,0xce,0x2e,0xae,0x6e,0xee,
-	0x1e,0x9e,0x5e,0xde,0x3e,0xbe,0x7e,0xfe,
-	0x01,0x81,0x41,0xc1,0x21,0xa1,0x61,0xe1,
-	0x11,0x91,0x51,0xd1,0x31,0xb1,0x71,0xf1,
-	0x09,0x89,0x49,0xc9,0x29,0xa9,0x69,0xe9,
-	0x19,0x99,0x59,0xd9,0x39,0xb9,0x79,0xf9,
-	0x05,0x85,0x45,0xc5,0x25,0xa5,0x65,0xe5,
-	0x15,0x95,0x55,0xd5,0x35,0xb5,0x75,0xf5,
-	0x0d,0x8d,0x4d,0xcd,0x2d,0xad,0x6d,0xed,
-	0x1d,0x9d,0x5d,0xdd,0x3d,0xbd,0x7d,0xfd,
-	0x03,0x83,0x43,0xc3,0x23,0xa3,0x63,0xe3,
-	0x13,0x93,0x53,0xd3,0x33,0xb3,0x73,0xf3,
-	0x0b,0x8b,0x4b,0xcb,0x2b,0xab,0x6b,0xeb,
-	0x1b,0x9b,0x5b,0xdb,0x3b,0xbb,0x7b,0xfb,
-	0x07,0x87,0x47,0xc7,0x27,0xa7,0x67,0xe7,
-	0x17,0x97,0x57,0xd7,0x37,0xb7,0x77,0xf7,
-	0x0f,0x8f,0x4f,0xcf,0x2f,0xaf,0x6f,0xef,
-	0x1f,0x9f,0x5f,0xdf,0x3f,0xbf,0x7f,0xff
-} ;
-
-#ifdef	MAKE_TABLE
-int byte_reverse(x)
-int x ;
-{
-	int     y = 0 ;
-
-	if (x & 0x01)
-		y |= 0x80 ;
-	if (x & 0x02)
-		y |= 0x40 ;
-	if (x & 0x04)
-		y |= 0x20 ;
-	if (x & 0x08)
-		y |= 0x10 ;
-	if (x & 0x10)
-		y |= 0x08 ;
-	if (x & 0x20)
-		y |= 0x04 ;
-	if (x & 0x40)
-		y |= 0x02 ;
-	if (x & 0x80)
-		y |= 0x01 ;
-	return(y) ;
-}
-#endif
Index: work-fault-inject/drivers/net/skfp/drvfbi.c
===================================================================
--- work-fault-inject.orig/drivers/net/skfp/drvfbi.c
+++ work-fault-inject/drivers/net/skfp/drvfbi.c
@@ -23,6 +23,7 @@
 #include "h/smc.h"
 #include "h/supern_2.h"
 #include "h/skfbiinc.h"
+#include <linux/bitrev.h>
 
 #ifndef	lint
 static const char ID_sccs[] = "@(#)drvfbi.c	1.63 99/02/11 (C) SK " ;
@@ -445,16 +446,14 @@ void read_address(struct s_smc *smc, u_c
 	char PmdType ;
 	int	i ;
 
-	extern const u_char canonical[256] ;
-
 #if	(defined(ISA) || defined(MCA))
 	for (i = 0; i < 4 ;i++) {	/* read mac address from board */
 		smc->hw.fddi_phys_addr.a[i] =
-			canonical[(inpw(PR_A(i+SA_MAC))&0xff)] ;
+			byte_rev_table[(inpw(PR_A(i+SA_MAC))&0xff)] ;
 	}
 	for (i = 4; i < 6; i++) {
 		smc->hw.fddi_phys_addr.a[i] =
-			canonical[(inpw(PR_A(i+SA_MAC+PRA_OFF))&0xff)] ;
+			byte_rev_table[(inpw(PR_A(i+SA_MAC+PRA_OFF))&0xff)] ;
 	}
 #endif
 #ifdef	EISA
@@ -464,17 +463,17 @@ void read_address(struct s_smc *smc, u_c
 	 */
 	for (i = 0; i < 4 ;i++) {	/* read mac address from board */
 		smc->hw.fddi_phys_addr.a[i] =
-			canonical[inp(PR_A(i+SA_MAC))] ;
+			byte_rev_table[inp(PR_A(i+SA_MAC))] ;
 	}
 	for (i = 4; i < 6; i++) {
 		smc->hw.fddi_phys_addr.a[i] =
-			canonical[inp(PR_A(i+SA_MAC+PRA_OFF))] ;
+			byte_rev_table[inp(PR_A(i+SA_MAC+PRA_OFF))] ;
 	}
 #endif
 #ifdef	PCI
 	for (i = 0; i < 6; i++) {	/* read mac address from board */
 		smc->hw.fddi_phys_addr.a[i] =
-			canonical[inp(ADDR(B2_MAC_0+i))] ;
+			byte_rev_table[inp(ADDR(B2_MAC_0+i))] ;
 	}
 #endif
 #ifndef	PCI
@@ -493,7 +492,7 @@ void read_address(struct s_smc *smc, u_c
 	if (mac_addr) {
 		for (i = 0; i < 6 ;i++) {
 			smc->hw.fddi_canon_addr.a[i] = mac_addr[i] ;
-			smc->hw.fddi_home_addr.a[i] = canonical[mac_addr[i]] ;
+			smc->hw.fddi_home_addr.a[i] = byte_rev_table[mac_addr[i]] ;
 		}
 		return ;
 	}
@@ -501,7 +500,7 @@ void read_address(struct s_smc *smc, u_c
 
 	for (i = 0; i < 6 ;i++) {
 		smc->hw.fddi_canon_addr.a[i] =
-			canonical[smc->hw.fddi_phys_addr.a[i]] ;
+			byte_rev_table[smc->hw.fddi_phys_addr.a[i]] ;
 	}
 }
 
@@ -1269,10 +1268,8 @@ void driver_get_bia(struct s_smc *smc, s
 {
 	int i ;
 
-	extern const u_char canonical[256] ;
-
 	for (i = 0 ; i < 6 ; i++) {
-		bia_addr->a[i] = canonical[smc->hw.fddi_phys_addr.a[i]] ;
+		bia_addr->a[i] = byte_rev_table[smc->hw.fddi_phys_addr.a[i]] ;
 	}
 }
 
Index: work-fault-inject/drivers/net/skfp/fplustm.c
===================================================================
--- work-fault-inject.orig/drivers/net/skfp/fplustm.c
+++ work-fault-inject/drivers/net/skfp/fplustm.c
@@ -22,7 +22,7 @@
 #include "h/fddi.h"
 #include "h/smc.h"
 #include "h/supern_2.h"
-#include "can.c"
+#include <linux/bitrev.h>
 
 #ifndef	lint
 static const char ID_sccs[] = "@(#)fplustm.c	1.32 99/02/23 (C) SK " ;
@@ -1073,7 +1073,7 @@ static struct s_fpmc* mac_get_mc_table(s
 	if (can) {
 		p = own->a ;
 		for (i = 0 ; i < 6 ; i++, p++)
-			*p = canonical[*p] ;
+			*p = byte_rev_table[*p] ;
 	}
 	slot = NULL;
 	for (i = 0, tb = smc->hw.fp.mc.table ; i < FPMAX_MULTICAST ; i++, tb++){
Index: work-fault-inject/drivers/net/skfp/smt.c
===================================================================
--- work-fault-inject.orig/drivers/net/skfp/smt.c
+++ work-fault-inject/drivers/net/skfp/smt.c
@@ -18,6 +18,7 @@
 #include "h/fddi.h"
 #include "h/smc.h"
 #include "h/smt_p.h"
+#include <linux/bitrev.h>
 
 #define KERNEL
 #include "h/smtstate.h"
@@ -26,8 +27,6 @@
 static const char ID_sccs[] = "@(#)smt.c	2.43 98/11/23 (C) SK " ;
 #endif
 
-extern const u_char canonical[256] ;
-
 /*
  * FC in SMbuf
  */
@@ -180,7 +179,7 @@ void smt_agent_init(struct s_smc *smc)
 	driver_get_bia(smc,&smc->mib.fddiSMTStationId.sid_node) ;
 	for (i = 0 ; i < 6 ; i ++) {
 		smc->mib.fddiSMTStationId.sid_node.a[i] =
-			canonical[smc->mib.fddiSMTStationId.sid_node.a[i]] ;
+			byte_rev_table[smc->mib.fddiSMTStationId.sid_node.a[i]] ;
 	}
 	smc->mib.fddiSMTManufacturerData[0] =
 		smc->mib.fddiSMTStationId.sid_node.a[0] ;
@@ -2050,7 +2049,7 @@ static void hwm_conv_can(struct s_smc *s
 	SK_UNUSED(smc) ;
 
 	for (i = len; i ; i--, data++) {
-		*data = canonical[*(u_char *)data] ;
+		*data = byte_rev_table[*(u_char *)data] ;
 	}
 }
 #endif
Index: work-fault-inject/drivers/net/Kconfig
===================================================================
--- work-fault-inject.orig/drivers/net/Kconfig
+++ work-fault-inject/drivers/net/Kconfig
@@ -2500,6 +2500,7 @@ config DEFXX
 config SKFP
 	tristate "SysKonnect FDDI PCI support"
 	depends on FDDI && PCI
+	select BITREVERSE
 	---help---
 	  Say Y here if you have a SysKonnect FDDI PCI adapter.
 	  The following adapters are supported by this driver:
