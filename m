Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUFZSAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUFZSAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 14:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUFZSAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 14:00:05 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:25232 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266316AbUFZR76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:59:58 -0400
To: mj@ucw.cz
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] pciutils: Support for MSI-X capability
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Sat, 26 Jun 2004 10:58:49 -0700
Message-ID: <52y8mayzdy.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jun 2004 17:58:49.0282 (UTC) FILETIME=[3BB85A20:01C45BA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here is a patch to pciutils that adds parsing of MSI-X capability
entries.  With this patch, an MSI-X capability will be dumped with -v as

	Capabilities: [40] MSI-X: Enable- Mask- TabSize=32

and with -vv as

	Capabilities: [40] MSI-X: Enable- Mask- TabSize=32
		Vector table: BAR=0 offset=00082000
		PBA: BAR=0 offset=00082200

Please let me know if you need any changes/fixes before you can apply.

Thanks,
  Roland

Index: pciutils-2.1.99-test5/lib/header.h
===================================================================
--- pciutils-2.1.99-test5.orig/lib/header.h	2004-05-28 03:54:41.000000000 -0700
+++ pciutils-2.1.99-test5/lib/header.h	2004-06-26 10:44:14.000000000 -0700
@@ -185,6 +185,7 @@
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX        0x07    /* PCI-X */
 #define  PCI_CAP_ID_HT          0x08    /* HyperTransport */
+#define  PCI_CAP_ID_MSIX        0x11    /* MSI-X */
 #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
 #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
 #define PCI_CAP_SIZEOF		4
@@ -661,6 +662,14 @@
 #define PCI_HT_RM_CNT1		10	/* Retry Count 1 Register */
 #define PCI_HT_RM_SIZEOF	12
 
+/* MSI-X */
+#define  PCI_MSIX_ENABLE  0x8000
+#define  PCI_MSIX_MASK    0x4000
+#define  PCI_MSIX_TABSIZE 0x03ff
+#define PCI_MSIX_TABLE    4
+#define PCI_MSIX_PBA      8
+#define  PCI_MSIX_BIR     0x7
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
Index: pciutils-2.1.99-test5/lspci.c
===================================================================
--- pciutils-2.1.99-test5.orig/lspci.c	2004-06-26 10:32:47.000000000 -0700
+++ pciutils-2.1.99-test5/lspci.c	2004-06-26 10:53:26.000000000 -0700
@@ -924,6 +924,28 @@
 }
 
 static void
+show_msix(struct device *d, int where, int cap)
+{
+  u32 off;
+
+  printf("MSI-X: Enable%c Mask%c TabSize=%d\n",
+	 FLAG(cap, PCI_MSIX_ENABLE),
+	 FLAG(cap, PCI_MSIX_MASK),
+	 (cap & PCI_MSIX_TABSIZE) + 1);
+  if (verbose < 2)
+    return;
+
+  config_fetch(d, where + PCI_MSIX_TABLE, 4);
+  off = get_conf_long(d, where + PCI_MSIX_TABLE);
+  printf("\t\tVector table: BAR=%d offset=%08x\n",
+	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+  config_fetch(d, where + PCI_MSIX_PBA, 4);
+  off = get_conf_long(d, where + PCI_MSIX_PBA);
+  printf("\t\tPBA: BAR=%d offset=%08x\n",
+	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+}
+
+static void
 show_slotid(int cap)
 {
   int esr = cap & 0xff;
@@ -982,6 +1004,9 @@
 	    case PCI_CAP_ID_HT:
 	      show_ht(d, where, cap);
 	      break;
+	    case PCI_CAP_ID_MSIX:
+	      show_msix(d, where, cap);
+	      break;
 	    default:
 	      printf("#%02x [%04x]\n", id, cap);
 	    }
