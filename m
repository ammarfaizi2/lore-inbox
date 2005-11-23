Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVKWDM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVKWDM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 22:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVKWDM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 22:12:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:53976 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932491AbVKWDMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 22:12:55 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <1132715288.26560.262.camel@gaston>
References: <1132715288.26560.262.camel@gaston>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 14:09:38 +1100
Message-Id: <1132715379.26560.264.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.

Here it is. it's my understand that it's already been queued somewhere
for submission by David for some time though. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-serialfix/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/core/hcd-pci.c	2005-11-21 11:53:15.000000000 +1100
+++ linux-serialfix/drivers/usb/core/hcd-pci.c	2005-11-23 11:23:24.000000000 +1100
@@ -27,6 +27,13 @@
 #include "usb.h"
 #include "hcd.h"
 
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
+
 
 /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
 
@@ -277,6 +284,16 @@
 	}
 
 done:
+#ifdef CONFIG_PPC_PMAC
+	if (retval == 0 && _machine == _MACH_Pmac) {
+	   	struct device_node	*of_node;
+
+		/* Disable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node(dev);
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
+	}
+#endif /* CONFIG_PPC_PMAC */
 	if (retval == 0)
 		dev->dev.power.power_state = PMSG_SUSPEND;
 	return retval;
@@ -301,6 +318,17 @@
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		/* Re-enable USB PAD & cell clock */
+		of_node = pci_device_to_OF_node(dev);
+		if (of_node)
+			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 1);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
Index: linux-serialfix/drivers/usb/host/ohci-pci.c
===================================================================
--- linux-serialfix.orig/drivers/usb/host/ohci-pci.c	2005-11-14 10:42:00.000000000 +1100
+++ linux-serialfix/drivers/usb/host/ohci-pci.c	2005-11-23 11:25:26.000000000 +1100
@@ -114,40 +114,12 @@
 
 static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
-	/* root hub was already suspended */
-
-	/* FIXME these PMAC things get called in the wrong places.  ASIC
-	 * clocks should be turned off AFTER entering D3, and on BEFORE
-	 * trying to enter D0.  Evidently the PCI layer doesn't currently
-	 * provide the right sort of platform hooks for this ...
-	 */
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-	   	struct device_node	*of_node;
- 
-		/* Disable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature(PMAC_FTR_USB_ENABLE, of_node, 0, 0);
-	}
-#endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 
 
 static int ohci_pci_resume (struct usb_hcd *hcd)
 {
-#ifdef CONFIG_PPC_PMAC
-	if (_machine == _MACH_Pmac) {
-		struct device_node *of_node;
-
-		/* Re-enable USB PAD & cell clock */
-		of_node = pci_device_to_OF_node (to_pci_dev(hcd->self.controller));
-		if (of_node)
-			pmac_call_feature (PMAC_FTR_USB_ENABLE, of_node, 0, 1);
-	}
-#endif /* CONFIG_PPC_PMAC */
-
 	usb_hcd_resume_root_hub(hcd);
 	return 0;
 }


