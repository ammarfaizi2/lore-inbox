Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEBKbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEBKbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWEBKbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 06:31:35 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:34609
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750790AbWEBKbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 06:31:34 -0400
Message-Id: <44575154.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 02 May 2006 12:32:20 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Kristen Accardi" <kristen.c.accardi@intel.com>
Cc: <pcihpd-discuss@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] [PATCH] correct pciehp init recovery
References: <445249FE.76E4.0078.0@novell.com> <1146245903.25490.10.camel@whizzy>
In-Reply-To: <1146245903.25490.10.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Kristen Accardi <kristen.c.accardi@intel.com> 28.04.06 19:38 >>>
>On Fri, 2006-04-28 at 16:59 +0200, Jan Beulich wrote:
>> Clean up the recovery path from errors during pcie_init().
>> 
>It's possible that this driver never actually requested an irq if was in
>poll mode.  Then you will call free_irq, when what you really want to do
>is kill the timer that may have been started. 

Thanks for pointing this out, here's the updated patch:

Clean up the recovery path from errors during pcie_init().

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.17-rc3/drivers/pci/hotplug/pciehp_hpc.c	2006-04-27 17:49:41.000000000 +0200
+++ 2.6.17-rc3-pciehp-init-recovery/drivers/pci/hotplug/pciehp_hpc.c	2006-04-28 09:20:55.000000000 +0200
@@ -1474,7 +1474,7 @@ int pcie_init(struct controller * ctrl, 
 	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_CTRL failed\n", __FUNCTION__);
-		goto abort_free_ctlr;
+		goto abort_free_irq;
 	}
 
 	intr_enable = intr_enable | PRSN_DETECT_ENABLE;
@@ -1500,19 +1500,19 @@ int pcie_init(struct controller * ctrl, 
 	rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_CTRL failed\n", __FUNCTION__);
-		goto abort_free_ctlr;
+		goto abort_free_irq;
 	}
 	rc = hp_register_read_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), slot_status);
 	if (rc) {
 		err("%s : hp_register_read_word SLOT_STATUS failed\n", __FUNCTION__);
-		goto abort_free_ctlr;
+		goto abort_disable_intr;
 	}
 	
 	temp_word =  0x1F; /* Clear all events */
 	rc = hp_register_write_word(php_ctlr->pci_dev, SLOT_STATUS(ctrl->cap_base), temp_word);
 	if (rc) {
 		err("%s : hp_register_write_word SLOT_STATUS failed\n", __FUNCTION__);
-		goto abort_free_ctlr;
+		goto abort_disable_intr;
 	}
 	
 	if (pciehp_force) {
@@ -1521,7 +1521,7 @@ int pcie_init(struct controller * ctrl, 
 	} else {
 		rc = pciehp_get_hp_hw_control_from_firmware(ctrl->pci_dev);
 		if (rc)
-			goto abort_free_ctlr;
+			goto abort_disable_intr;
 	}
 
 	/*  Add this HPC instance into the HPC list */
@@ -1548,6 +1548,21 @@ int pcie_init(struct controller * ctrl, 
 	return 0;
 
 	/* We end up here for the many possible ways to fail this API.  */
+abort_disable_intr:
+	rc = hp_register_read_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
+	if (!rc) {
+		temp_word &= ~(intr_enable | HP_INTR_ENABLE);
+		rc = hp_register_write_word(pdev, SLOT_CTRL(ctrl->cap_base), temp_word);
+	}
+	if (rc)
+		err("%s : disabling interrupts failed\n", __FUNCTION__);
+
+abort_free_irq:
+	if (pciehp_poll_mode)
+		del_timer_sync(&php_ctlr->int_poll_timer);
+	else
+		free_irq(php_ctlr->irq, ctrl);
+
 abort_free_ctlr:
 	pcie_cap_base = saved_cap_base;
 	kfree(php_ctlr);


