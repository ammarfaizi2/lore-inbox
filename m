Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBGH5D>; Thu, 7 Feb 2002 02:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBGH4z>; Thu, 7 Feb 2002 02:56:55 -0500
Received: from biuro.ertel.com.pl ([212.106.128.2]:11792 "EHLO
	biuro.ertel.com.pl") by vger.kernel.org with ESMTP
	id <S285720AbSBGH4l>; Thu, 7 Feb 2002 02:56:41 -0500
Date: Thu, 7 Feb 2002 08:58:46 +0100 (CET)
From: Damian Wrobel <dwrobel@ertel.com.pl>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@redhat.com>
Subject: mxser.c patch (added support for C102, CI-132, CI-134, CP-132, CP-114
 and CT-114 cards)
Message-ID: <Pine.LNX.4.43.0202070834480.18556-100000@biuro.ertel.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to the "MOXA Smartio Family Serial Driver", which add
support for some additional cards. The patch was well-tested on CP-114IS
and two CP-132IS cards.


--- mxser.c.orig	Mon Nov 12 08:31:44 2001
+++ mxser.c	Thu Feb  7 08:15:18 2002
@@ -32,6 +32,9 @@
  *      version         : 1.2
  *
  *    Fixes for C104H/PCI by Tim Hockin <thockin@sun.com>
+ *    Added support for: C102, CI-132, CI-134, CP-132, CP-114, CT-114 cards
+ *                        by Damian Wrobel <dwrobel@ertel.com.pl>
+ *
  */

 #include <linux/config.h>
@@ -62,7 +65,7 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>

-#define		MXSER_VERSION			"1.2"
+#define		MXSER_VERSION			"1.2.1"

 #define		MXSERMAJOR	 	174
 #define		MXSERCUMAJOR		175
@@ -115,10 +118,22 @@
 #ifndef PCI_DEVICE_ID_C104
 #define PCI_DEVICE_ID_C104	0x1040
 #endif
+#ifndef PCI_DEVICE_ID_CP132
+#define PCI_DEVICE_ID_CP132	0x1320
+#endif
+#ifndef PCI_DEVICE_ID_CP114
+#define PCI_DEVICE_ID_CP114	0x1141
+#endif
+#ifndef PCI_DEVICE_ID_CT114
+#define PCI_DEVICE_ID_CT114	0x1140
+#endif

 #define C168_ASIC_ID    1
 #define C104_ASIC_ID    2
+#define CI134_ASIC_ID   3
+#define CI132_ASIC_ID   4
 #define CI104J_ASIC_ID  5
+#define C102_ASIC_ID	0xB

 enum {
 	MXSER_BOARD_C168_ISA = 0,
@@ -126,6 +141,12 @@
 	MXSER_BOARD_CI104J,
 	MXSER_BOARD_C168_PCI,
 	MXSER_BOARD_C104_PCI,
+	MXSER_BOARD_C102_ISA,
+	MXSER_BOARD_CI132,
+	MXSER_BOARD_CI134,
+	MXSER_BOARD_CP132_PCI,
+	MXSER_BOARD_CP114_PCI,
+	MXSER_BOARD_CT114_PCI
 };

 static char *mxser_brdname[] =
@@ -135,6 +156,12 @@
 	"CI-104J series",
 	"C168H/PCI series",
 	"C104H/PCI series",
+	"C102 series",
+	"CI-132 series",
+	"CI-134 series",
+	"CP-132 series",
+	"CP-114 series",
+	"CT-114 series"
 };

 static int mxser_numports[] =
@@ -144,6 +171,12 @@
 	4,
 	8,
 	4,
+	2,
+	2,
+	4,
+	2,
+	4,
+	4
 };

 /*
@@ -164,6 +197,12 @@
 	  MXSER_BOARD_C168_PCI },
 	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C104, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  MXSER_BOARD_C104_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP132, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  MXSER_BOARD_CP132_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP114, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  MXSER_BOARD_CP114_PCI },
+	{ PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CT114, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  MXSER_BOARD_CT114_PCI },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
@@ -2307,6 +2346,12 @@
 		hwconf->board_type = MXSER_BOARD_C168_ISA;
 	else if (id == C104_ASIC_ID)
 		hwconf->board_type = MXSER_BOARD_C104_ISA;
+	else if (id == C102_ASIC_ID)
+		hwconf->board_type = MXSER_BOARD_C102_ISA;
+	else if (id == CI132_ASIC_ID)
+		hwconf->board_type = MXSER_BOARD_CI132;
+	else if (id == CI134_ASIC_ID)
+		hwconf->board_type = MXSER_BOARD_CI134;
 	else if (id == CI104J_ASIC_ID)
 		hwconf->board_type = MXSER_BOARD_CI104J;
 	else
@@ -2418,7 +2463,8 @@
 	(void) inb(port);
 	restore_flags(flags);
 	id = inb(port + 1) & 0x1F;
-	if ((id != C168_ASIC_ID) && (id != C104_ASIC_ID) && (id != CI104J_ASIC_ID))
+	if ((id != C168_ASIC_ID) && (id != C104_ASIC_ID) && (id != CI104J_ASIC_ID) &&
+		(id != C102_ASIC_ID) &&	(id != CI132_ASIC_ID) && (id != CI134_ASIC_ID))
 		return (-1);
 	for (i = 0, j = 0; i < 4; i++) {
 		n = inb(port + 2);



P.S.: Answers/comments should be personally CC'ed.

Regards,
Damian Wrobel


