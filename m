Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVKWXqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVKWXqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVKWXqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:20418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751323AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:45:42 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david-b@pacbell.net
Subject: [patch 19/22] USB: ohci, move ppc asic tweaks nearer pci
Message-ID: <20051123234542.GT527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ohci-move-ppc-asic-tweaks-nearer-pci.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This should fix a suspend/resume issues that appear with OHCI on some
PPC hardware.  The PCI layer should doesn't have the hooks needed for
such ASIC-specific hooks (in this case, software clock gating), so
this moves the code to do that into hcd-pci.c ... where it can be
done after the relevant PCI PM state transition (to/from D3).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/hcd-pci.c  |   38 ++++++++++++++++++++++++++++++++++++--
 drivers/usb/host/ohci-pci.c |   36 ------------------------------------
 2 files changed, 36 insertions(+), 38 deletions(-)

--- usb-2.6.orig/drivers/usb/core/hcd-pci.c
+++ usb-2.6/drivers/usb/core/hcd-pci.c
@@ -20,9 +20,17 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/usb.h>
+
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <linux/usb.h>
+
+#ifdef CONFIG_PPC_PMAC
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+#endif
 
 #include "usb.h"
 #include "hcd.h"
@@ -277,8 +285,22 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	}
 
 done:
-	if (retval == 0)
+	if (retval == 0) {
 		dev->dev.power.power_state = PMSG_SUSPEND;
+
+#ifdef CONFIG_PPC_PMAC
+		/* Disable ASIC clocks for USB */
+		if (_machine == _MACH_Pmac) {
+			struct device_node	*of_node;
+
+			of_node = pci_device_to_OF_node (dev);
+			if (of_node)
+				pmac_call_feature(PMAC_FTR_USB_ENABLE,
+							of_node, 0, 0);
+		}
+#endif
+	}
+
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
@@ -301,6 +323,18 @@ int usb_hcd_pci_resume (struct pci_dev *
 		return 0;
 	}
 
+#ifdef CONFIG_PPC_PMAC
+	/* Reenable ASIC clocks for USB */
+	if (_machine == _MACH_Pmac) {
+		struct device_node *of_node;
+
+		of_node = pci_device_to_OF_node (dev);
+		if (of_node)
+			pmac_call_feature (PMAC_FTR_USB_ENABLE,
+						of_node, 0, 1);
+	}
+#endif
+
 	/* NOTE:  chip docs cover clean "real suspend" cases (what Linux
 	 * calls "standby", "suspend to RAM", and so on).  There are also
 	 * dirty cases when swsusp fakes a suspend in "shutdown" mode.
--- usb-2.6.orig/drivers/usb/host/ohci-pci.c
+++ usb-2.6/drivers/usb/host/ohci-pci.c
@@ -14,15 +14,6 @@
  * This file is licenced under the GPL.
  */
  
-#include <linux/jiffies.h>
-
-#ifdef CONFIG_PPC_PMAC
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
-#include <asm/prom.h>
-#endif
-
 #ifndef CONFIG_PCI
 #error "This file is PCI bus glue.  CONFIG_PCI must be defined."
 #endif
@@ -115,39 +106,12 @@ ohci_pci_start (struct usb_hcd *hcd)
 static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t message)
 {
 	/* root hub was already suspended */
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

--
