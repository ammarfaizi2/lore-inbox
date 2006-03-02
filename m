Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCBXJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCBXJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCBXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:18 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:36543 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751159AbWCBXJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:17 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 1/9] parport: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:15 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Phil Blundell <philb@gnu.org>, Tim Waugh <tim@cyberelk.net>,
       Andrea Arcangeli <andrea@suse.de>, linux-parport@lists.infradead.org
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.15330.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

parport_pc_init() does nothing with "count", so remove it.  Then nobody
uses the return value of parport_pc_find_ports(), so make it void.
Finally, update pnp_register_driver() usage.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/parport/parport_pc.c
===================================================================
--- work-mm4.orig/drivers/parport/parport_pc.c	2006-03-01 15:37:16.000000000 -0700
+++ work-mm4/drivers/parport/parport_pc.c	2006-03-02 12:41:33.000000000 -0700
@@ -3126,9 +3126,9 @@
  * autoirq is PARPORT_IRQ_NONE, PARPORT_IRQ_AUTO, or PARPORT_IRQ_PROBEONLY
  * autodma is PARPORT_DMA_NONE or PARPORT_DMA_AUTO
  */
-static int __init parport_pc_find_ports (int autoirq, int autodma)
+static void __init parport_pc_find_ports (int autoirq, int autodma)
 {
-	int count = 0, r;
+	int count = 0, err;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
@@ -3140,23 +3140,17 @@
 
 	/* PnP ports, skip detection if SuperIO already found them */
 	if (!count) {
-		r = pnp_register_driver (&parport_pc_pnp_driver);
-		if (r >= 0) {
+		err = pnp_register_driver (&parport_pc_pnp_driver);
+		if (!err)
 			pnp_registered_parport = 1;
-			count += r;
-		}
 	}
 
 	/* ISA ports and whatever (see asm/parport.h). */
-	count += parport_pc_find_nonpci_ports (autoirq, autodma);
-
-	r = pci_register_driver (&parport_pc_pci_driver);
-	if (r)
-		return r;
-	pci_registered_parport = 1;
-	count += 1;
+	parport_pc_find_nonpci_ports (autoirq, autodma);
 
-	return count;
+	err = pci_register_driver (&parport_pc_pci_driver);
+	if (!err)
+		pci_registered_parport = 1;
 }
 
 /*
@@ -3381,8 +3375,6 @@
 
 static int __init parport_pc_init(void)
 {
-	int count = 0;
-
 	if (parse_parport_params())
 		return -EINVAL;
 
@@ -3395,12 +3387,11 @@
 				break;
 			if ((io_hi[i]) == PARPORT_IOHI_AUTO)
 			       io_hi[i] = 0x400 + io[i];
-			if (parport_pc_probe_port(io[i], io_hi[i],
-						  irqval[i], dmaval[i], NULL))
-				count++;
+			parport_pc_probe_port(io[i], io_hi[i],
+						  irqval[i], dmaval[i], NULL);
 		}
 	} else
-		count += parport_pc_find_ports (irqval[0], dmaval[0]);
+		parport_pc_find_ports (irqval[0], dmaval[0]);
 
 	return 0;
 }
