Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTC0K3v>; Thu, 27 Mar 2003 05:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbTC0K3v>; Thu, 27 Mar 2003 05:29:51 -0500
Received: from smtp1.asco.de ([217.13.70.154]:56326 "EHLO smtp1.asco.de")
	by vger.kernel.org with ESMTP id <S261891AbTC0K3s>;
	Thu, 27 Mar 2003 05:29:48 -0500
Date: Thu, 27 Mar 2003 11:40:57 +0100
From: Sebastian Ohl <s.ohl@asco.de>
To: tytso@mit.edu
cc: linux-kernel@vger.kernel.org
Subject: VSCom Serialcard driver
Message-ID: <1770000.1048761657@[192.168.1.72]>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i just modified the serial driver for 2.4.20 to find VScom Serial and ECP 
cards:

- Supported cards VSCom S,L and H series
- supports VScom ECP cards without IRQ

Cu
 Sebastian Ohl
- asco GmbH

diff -u -r kernel-source-2.4.20/drivers/char/serial.c 
kernel-source-2.4.20.vs/drivers/char/serial.c
--- kernel-source-2.4.20/drivers/char/serial.c	2002-11-29 
00:53:12.000000000 +0100
+++ kernel-source-2.4.20.vs/drivers/char/serial.c	2003-03-27 
11:05:44.000000000 +0100
@@ -4364,6 +4364,11 @@
 	pbn_computone_4,
 	pbn_computone_6,
 	pbn_computone_8,
+	pbn_b1_1_921600,
+	pbn_b1_bt_2_921600,
+	pbn_b1_bt_4_921600,
+	pbn_b1_bt_8_921600,
+	pbn_b4_2_921600,
 };

 static struct pci_board pci_boards[] __devinitdata = {
@@ -4471,6 +4476,12 @@
 		0x40, 2, NULL, 0x200 },
 	{ SPCI_FL_BASE0, 8, 921600, /* IOMEM */		   /* pbn_computone_8 */
 		0x40, 2, NULL, 0x200 },
+	{ SPCI_FL_BASE1, 1, 921600}, /* IOMEM*/	   	   /* pbn_b1_1_921600 */
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600},  /* pbn_b1_bt_2_921600 
*/
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 4, 921600},   /* pbn_b1_bt_4_921600 
*/
+	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 8, 921600},   /* pbn_b1_bt_8_921600 
*/
+	{ SPCI_FL_BASE4 , 2, 921600},			    /* pbn_b4_2_921600 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600},   /* pbn_b0_bt_2_921600 
*/
 };

 /*
@@ -4752,18 +4763,22 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 1, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b1_1_921600},
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b1_bt_2_921600 },
 	/* The 400L and 800L have a custom hack in get_pci_port */
+	/* changed by damian gruszka VScom (TM) VS Vision Systems GmbH */
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 4, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b1_bt_4_921600},
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 8, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b1_bt_8_921600},
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200I,
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b4_2_921600},
+	/* VScom HV2 cards damian gruszka VScom (TM) */
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100HV2,
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b0_1_921600},
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200HV2,
+		PCI_ANY_ID, PCI_ANY_ID,0,0,pbn_b0_bt_2_921600},

 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff -u -r kernel-source-2.4.20/drivers/parport/parport_pc.c 
kernel-source-2.4.20.vs/drivers/parport/parport_pc.c
--- kernel-source-2.4.20/drivers/parport/parport_pc.c	2002-11-30 
05:49:41.000000000 +0100
+++ kernel-source-2.4.20.vs/drivers/parport/parport_pc.c	2003-03-27 
11:00:06.000000000 +0100
@@ -2699,6 +2699,9 @@
 	oxsemi_840,
 	aks_0100,
 	mobility_pp,
+	vscom_010s,
+	vscom_020s,
+	oxsemi_952,
 };


@@ -2768,6 +2771,9 @@
 	/* oxsemi_840 */		{ 1, { { 0, -1 }, } },
 	/* aks_0100 */			{ 1, { { 0, 1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
+	/* vscom_010s */		{ 1, { { 2,1 }, } },
+	/* vscom_020s */		{ 2, { { 2, -1 },{3,-1}} },
+	/* oxsemi_952 */		{ 1, { { 0, 1 }, } },
 };

 static struct pci_device_id parport_pc_pci_tbl[] __devinitdata = {
@@ -2795,6 +2801,9 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, boca_ioppar },
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 	  PCI_SUBVENDOR_ID_EXSYS, PCI_SUBDEVICE_ID_EXSYS_4014, 0,0, plx_9050 },
+	/* VScom / Titan parallel ports */
+	{ PCI_VENDOR_ID_PLX, 0x1147, PCI_ANY_ID, PCI_ANY_ID, 0,0, vscom_020s },
+	{ PCI_VENDOR_ID_PLX, 0x1146, PCI_ANY_ID, PCI_ANY_ID, 0,0, vscom_010s },
 	/* PCI_VENDOR_ID_TIMEDIA/SUNIX has many differing cards ...*/
 	{ 0x1409, 0x7168, 0x1409, 0x4078, 0, 0, timedia_4078a },
 	{ 0x1409, 0x7168, 0x1409, 0x4079, 0, 0, timedia_4079h },
@@ -2827,6 +2836,10 @@
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_010L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_010l },
 	{ 0x9710, 0x9815, 0x1000, 0x0020, 0, 0, titan_1284p2 },
+	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_010H,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_954 },
+	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_010HV2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_952 },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1p}, /* 
AFAVLAB_TK9902 */
 	{ 0x14db, 0x2121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2p},
diff -u -r kernel-source-2.4.20/drivers/parport/parport_serial.c 
kernel-source-2.4.20.vs/drivers/parport/parport_serial.c
--- kernel-source-2.4.20/drivers/parport/parport_serial.c	2002-08-05 
13:23:34.000000000 +0200
+++ kernel-source-2.4.20.vs/drivers/parport/parport_serial.c	2003-03-27 
10:56:11.000000000 +0100
@@ -32,6 +32,8 @@
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
+	/* d.gruszka VScom (R) */
+	vscom_2s1p_210s,
 	avlab_1s1p,
 	avlab_1s1p_650,
 	avlab_1s1p_850,
@@ -70,6 +72,7 @@
 } cards[] __devinitdata = {
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
+	/* vscom_2s1p_210s */		{ 1, { { 5, -1}, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
@@ -92,6 +95,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_TITAN_210S,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, vscom_2s1p_210s },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
 	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -171,6 +176,7 @@

 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+/* vscom_2s1p_210s */	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
diff -u -r kernel-source-2.4.20/include/linux/pci_ids.h 
kernel-source-2.4.20.vs/include/linux/pci_ids.h
--- kernel-source-2.4.20/include/linux/pci_ids.h	2002-11-30 
05:49:28.000000000 +0100
+++ kernel-source-2.4.20.vs/include/linux/pci_ids.h	2003-03-27 
10:56:11.000000000 +0100
@@ -1530,6 +1530,14 @@
 #define PCI_DEVICE_ID_TITAN_200		0xA005
 #define PCI_DEVICE_ID_TITAN_400		0xA003
 #define PCI_DEVICE_ID_TITAN_800B	0xA004
+/* d.gruszka VScom (R) */
+#define PCI_DEVICE_ID_TITAN_200I	0x8028
+#define PCI_DEVICE_ID_TITAN_100HV2	0xE010
+#define PCI_DEVICE_ID_TITAN_200HV2	0xE020
+#define PCI_DEVICE_ID_TITAN_010HV2	0xE001
+#define PCI_DEVICE_ID_TITAN_010H	0xA000
+#define PCI_DEVICE_ID_TITAN_210S	0x1078
+

 #define PCI_VENDOR_ID_PANACOM		0x14d4
 #define PCI_DEVICE_ID_PANACOM_QUADMODEM	0x0400
Only in kernel-source-2.4.20.vs/include/linux: pci_ids.h.orig

