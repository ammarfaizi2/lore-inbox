Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLCVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTLCVvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:51:45 -0500
Received: from adsl-66-120-161-231.dsl.sntc01.pacbell.net ([66.120.161.231]:55447
	"EHLO duron.graphe.net") by vger.kernel.org with ESMTP
	id S261606AbTLCVub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:50:31 -0500
Date: Wed, 3 Dec 2003 13:50:25 -0800 (PST)
From: Christoph Lameter <christoph@graphe.net>
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org
Subject: Patch for NetMOS based PCI cards providing serial and parallel ports
 against 2.6.0
Message-ID: <Pine.LNX.4.58.0312031342110.30472@duron.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached a patch to support a variety of PCI based serial and parallel
port I/O ports (typically labeled 222N-2 or 9835). The patch was

I just fixed it up and made it work for 2.6.0-test10/10.

I think this should go into 2.6.0 since it has been out there for a long
time and is just some additional driver support that somehow fell through
the cracks in 2.4.X. Tim Waugh submitted it in the 2.4.X series.

See also
http://winterwolf.co.uk/pciio

diff -urN linux-2.6.0-test10/drivers/parport/ChangeLog linux-2.6.0-test10-cl1/drivers/parport/ChangeLog
--- linux-2.6.0-test10/drivers/parport/ChangeLog	2003-10-25 11:44:09.000000000 -0700
+++ linux-2.6.0-test10-cl1/drivers/parport/ChangeLog	2003-11-26 17:04:39.000000000 -0800
@@ -1,3 +1,7 @@
+2001-10-11  Tim Waugh  <twaugh@redhat.com>
+	* parport_pc.c, parport_serial.c: Support for NetMos cards.
+	+ Patch originally from Michael Reinelt <reinelt@eunet.at>.
+
 2002-04-25  Tim Waugh  <twaugh@redhat.com>

 	* parport_serial.c, parport_pc.c: Move some SIIG cards around.
diff -urN linux-2.6.0-test10/drivers/parport/parport_pc.c linux-2.6.0-test10-cl1/drivers/parport/parport_pc.c
--- linux-2.6.0-test10/drivers/parport/parport_pc.c	2003-10-25 11:44:50.000000000 -0700
+++ linux-2.6.0-test10-cl1/drivers/parport/parport_pc.c	2003-11-26 16:58:48.000000000 -0800
@@ -2743,6 +2743,10 @@
 	oxsemi_840,
 	aks_0100,
 	mobility_pp,
+	netmos_9705,
+	netmos_9805,
+	netmos_9815,
+	netmos_9855,
 };


@@ -2827,6 +2831,10 @@
 	/* oxsemi_840 */		{ 1, { { 0, -1 }, } },
 	/* aks_0100 */			{ 1, { { 0, 1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
+	/* netmos_9705 */               { 1, { { 0, -1 }, } }, /* untested */
+	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
+	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
+	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 };

 static struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2925,6 +2933,15 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_840 },
 	{ PCI_VENDOR_ID_AKS, PCI_DEVICE_ID_AKS_ALADDINCARD,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, aks_0100 },
+	/* NetMos communication controllers */
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9805,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
diff -urN linux-2.6.0-test10/drivers/parport/parport_serial.c linux-2.6.0-test10-cl1/drivers/parport/parport_serial.c
--- linux-2.6.0-test10/drivers/parport/parport_serial.c	2003-10-25 11:44:40.000000000 -0700
+++ linux-2.6.0-test10-cl1/drivers/parport/parport_serial.c	2003-11-26 16:58:48.000000000 -0800
@@ -33,6 +33,8 @@
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
+	netmos_9735,
+	netmos_9835,
 	avlab_1s1p,
 	avlab_1s1p_650,
 	avlab_1s1p_850,
@@ -71,6 +73,8 @@
 } cards[] __devinitdata = {
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
+	/* netmos_9735 (not tested) */	{ 1, { { 2, -1 }, } },
+	/* netmos_9835 */		{ 1, { { 2, -1 }, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
@@ -93,6 +97,10 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
 	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -172,6 +180,8 @@

 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+/* netmos_9735 (n/t)*/	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
diff -urN linux-2.6.0-test10/include/linux/pci_ids.h linux-2.6.0-test10-cl1/include/linux/pci_ids.h
--- linux-2.6.0-test10/include/linux/pci_ids.h	2003-11-26 16:53:25.000000000 -0800
+++ linux-2.6.0-test10-cl1/include/linux/pci_ids.h	2003-11-26 17:01:59.000000000 -0800
@@ -2125,8 +2125,12 @@
 #define PCI_DEVICE_ID_HOLTEK_6565	0x6565

 #define PCI_VENDOR_ID_NETMOS		0x9710
+#define PCI_DEVICE_ID_NETMOS_9705	0x9705
 #define PCI_DEVICE_ID_NETMOS_9735	0x9735
+#define PCI_DEVICE_ID_NETMOS_9805	0x9805
+#define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
+#define PCI_DEVICE_ID_NETMOS_9855	0x9855

 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014
