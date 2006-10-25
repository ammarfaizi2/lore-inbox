Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423067AbWJYGl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423067AbWJYGl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 02:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423065AbWJYGl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 02:41:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43945 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423062AbWJYGl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 02:41:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 25 Oct 2006 08:40:54 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: pci_set_power_state() failure and breaking suspend
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1161675611.10524.598.camel@localhost.localdomain>
Message-ID: <tkrat.1b479115136413cf@s5r6.in-berlin.de>
References: <1161672898.10524.596.camel@localhost.localdomain>
 <1161675611.10524.598.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Okt, Benjamin Herrenschmidt wrote:
>> Recently, ohci1394 grew some "proper" error handling in its suspend
>> function, something that looks like:
>> 
>>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>>         if (err)
>>                 goto out;
...
> First, it breaks some old PowerBooks where the internal OHCI has no PM
> feature exposed on PCI....

What about the following? Could someone compile-test it with gcc4
and CONFIG_IEEE1394_VERBOSEDEBUG=n?



From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: ohci1394: revert fail on error in suspend

The error checks in the suspend code were too harsh and broke
suspend on some PPC_PMACs again which have extra platform code.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-10-25 08:26:44.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-10-25 08:28:34.000000000 +0200
@@ -3553,11 +3553,16 @@ static int ohci1394_pci_suspend (struct 
 	int err;
 
 	err = pci_save_state(pdev);
-	if (err)
-		goto out;
+	if (err) {
+		printk(KERN_ERR "%s: pci_save_state failed with %d\n",
+		       OHCI1394_DRIVER_NAME, err);
+		return err;
+	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+#ifdef OHCI1394_DEBUG
 	if (err)
-		goto out;
+		printk(KERN_DEBUG "pci_set_power_state failed %d\n", err);
+#endif /* OHCI1394_DEBUG */
 
 /* PowerMac suspend code comes last */
 #ifdef CONFIG_PPC_PMAC
@@ -3570,8 +3575,8 @@ static int ohci1394_pci_suspend (struct 
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 0);
 	}
 #endif /* CONFIG_PPC_PMAC */
-out:
-	return err;
+
+	return 0;
 }
 #endif /* CONFIG_PM */
 


