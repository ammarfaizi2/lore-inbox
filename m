Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUF0RHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUF0RHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUF0RHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:07:17 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:14160 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264098AbUF0RHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:07:14 -0400
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
X-Message-Flag: Warning: May contain useful information
References: <52y8mayzdy.fsf@topspin.com> <20040627114329.GE670@ucw.cz>
From: Roland Dreier <roland@topspin.com>
Date: Sun, 27 Jun 2004 10:07:12 -0700
In-Reply-To: <20040627114329.GE670@ucw.cz> (Martin Mares's message of "Sun,
 27 Jun 2004 13:43:29 +0200")
Message-ID: <528ye9ylof.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Jun 2004 17:07:12.0716 (UTC) FILETIME=[306FA0C0:01C45C69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Martin> Applied and will appear in -test6 soon.

    Martin> Could you please add a couple of comments to the
    Martin> capability defines in header.h?

Thanks, sorry about leaving out the comments.  Here is a patch.  I
also added _CAP_ to the capability register defines so that I match
the naming convention better.

Best,
  Roland

Index: pciutils-2.1.99-test6/lib/header.h
===================================================================
--- pciutils-2.1.99-test6.orig/lib/header.h	2004-06-27 04:38:42.000000000 -0700
+++ pciutils-2.1.99-test6/lib/header.h	2004-06-27 10:01:04.000000000 -0700
@@ -727,12 +727,12 @@
 #define PCI_EXP_RTSTA		0x20	/* Root Status */
 
 /* MSI-X */
-#define  PCI_MSIX_ENABLE	0x8000
-#define  PCI_MSIX_MASK		0x4000
-#define  PCI_MSIX_TABSIZE	0x03ff
-#define PCI_MSIX_TABLE		4
-#define PCI_MSIX_PBA		8
-#define  PCI_MSIX_BIR		0x7
+#define  PCI_MSIX_CAP_ENABLE	0x8000	/* MSI-X enabled */
+#define  PCI_MSIX_CAP_MASK	0x4000	/* All vectors masked */
+#define  PCI_MSIX_CAP_TABSIZE	0x03ff	/* Mask for (table_size - 1) */
+#define PCI_MSIX_TABLE		4	/* Vector table offset/BAR register */
+#define PCI_MSIX_PBA		8	/* PBA offset/BAR register */
+#define  PCI_MSIX_BIR_MASK	0x7	/* Mask of BAR index for table/PBA */
 
 /*
  * The PCI interface treats multi-function devices as independent
Index: pciutils-2.1.99-test6/lspci.c
===================================================================
--- pciutils-2.1.99-test6.orig/lspci.c	2004-06-27 04:41:39.000000000 -0700
+++ pciutils-2.1.99-test6/lspci.c	2004-06-27 10:01:13.000000000 -0700
@@ -990,18 +990,18 @@
   u32 off;
 
   printf("MSI-X: Enable%c Mask%c TabSize=%d\n",
-	 FLAG(cap, PCI_MSIX_ENABLE),
-	 FLAG(cap, PCI_MSIX_MASK),
-	 (cap & PCI_MSIX_TABSIZE) + 1);
+	 FLAG(cap, PCI_MSIX_CAP_ENABLE),
+	 FLAG(cap, PCI_MSIX_CAP_MASK),
+	 (cap & PCI_MSIX_CAP_TABSIZE) + 1);
   if (verbose < 2 || !config_fetch(d, where + PCI_MSIX_TABLE, 8))
     return;
 
   off = get_conf_long(d, where + PCI_MSIX_TABLE);
   printf("\t\tVector table: BAR=%d offset=%08x\n",
-	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+	 off & PCI_MSIX_BIR_MASK, off & ~PCI_MSIX_BIR_MASK);
   off = get_conf_long(d, where + PCI_MSIX_PBA);
   printf("\t\tPBA: BAR=%d offset=%08x\n",
-	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
+	 off & PCI_MSIX_BIR_MASK, off & ~PCI_MSIX_BIR_MASK);
 }
 
 static void

