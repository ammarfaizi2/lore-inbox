Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270843AbUKBBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270843AbUKBBTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S293166AbUKBBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:19:43 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:63395 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S389823AbUKBBSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 20:18:39 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Adapt drivers to type-safe pci
Date: Mon, 1 Nov 2004 18:00:46 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
References: <20041101202640.GA24855@elf.ucw.cz>
In-Reply-To: <20041101202640.GA24855@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+wthB+5cjJpUpXA"
Message-Id: <200411011700.46493.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_+wthB+5cjJpUpXA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 01 November 2004 12:26, Pavel Machek wrote:
> Hi!
> 
> This adapts few drivers to type-safe pci powermanagment. I introduced
> device_to_pci_state helper that will be usefull to few drivers... Does
> it look okay? 

I'd rather have something like the attached patch.
Fixed policy mappings are generically broken; what
about devices that don't support PCI_D2?

This should I guess use the new "pci_power_t", but
I'm not that current yet.  

- Dave

--Boundary-00=_+wthB+5cjJpUpXA
Content-Type: text/x-diff;
  charset="utf-8";
  name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff"

--- 1.73/drivers/pci/pci.c	2004-10-06 09:42:55 -07:00
+++ edited/drivers/pci/pci.c	2004-11-01 16:55:48 -08:00
@@ -229,7 +229,7 @@
 /**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: Power state we're entering
+ * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
  *
  * Transition a device to a new power state, using the Power Management 
  * Capabilities in the device's config space.
@@ -298,6 +298,54 @@
 
 	return 0;
 }
+
+/**
+ * pci_choose_state - Choose the power state of a PCI device
+ * @dev: PCI device to be suspended
+ * @state: target sleep state for the whole system
+ *
+ * If the device doesn't support PCI power management, this does nothing.
+ * Otherwise it puts the device in a PCI power state that it supports,
+ * and which for most devices is appropriate to that system sleep state.
+ * Some drivers will need to choose the PCI state themselves, calling
+ * pci_set_power_state() directly.
+ */
+void
+pci_choose_state(struct pci_dev *pdev, suspend_state_t sleepstate)
+{
+	int pm, state;
+	u16 pmc;
+
+	/* nothing to do for legacy PCI devices */
+	pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (!pm)
+		return;
+
+	/* map to a PCI PM state this device supports
+	 * FIXME ACPI may know what states to use; we should probably
+	 * prefer that policy to this one.
+	 */
+	state = 3;
+	switch (sleepstate) {
+	case PM_SUSPEND_ON:
+		state = 0;
+		break;
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		pci_read_config_word(pdev, pm + PCI_PM_PMC, &pmc);
+		if (sleepstate == PM_SUSPEND_STANDBY
+				&& (pmc & PCI_PM_CAP_D1) != 0)
+			state = 1;
+		else if ((pmc & PCI_PM_CAP_D2) != 0)
+			state = 2;
+		break;
+	}
+
+	/* maybe go to a deeper power state */
+	if (pdev->current_state < state)
+		pci_set_power_state(pdev, state);
+}
+EXPORT_SYMBOL(pci_choose_state);
 
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending

--Boundary-00=_+wthB+5cjJpUpXA--
