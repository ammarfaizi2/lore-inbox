Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVFWTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVFWTXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVFWTRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:17:41 -0400
Received: from apollo.tuxdriver.com ([24.172.12.2]:49418 "EHLO
	apollo.tuxdriver.com") by vger.kernel.org with ESMTP
	id S262706AbVFWTPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:15:14 -0400
Date: Thu, 23 Jun 2005 15:14:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-pm <linux-pm@lists.osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [RFC] firmware leaves device in D3hot at boot
Message-ID: <20050623191451.GA20572@tuxdriver.com>
Mail-Followup-To: linux-pm <linux-pm@lists.osdl.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at a problem caused by a machine's BIOS leaving an adapter
in D3hot when booting.  As part of the boot process, the driver (in
this case 3c59x) calls pci_enable_device which sets the power state to
D0.  The device in question gets its PCI configuration reset, including
the BARs.  As a result, the driver is unable to init the device.

Section 5.4.1 of the "PCI BUS POWER MANAGEMENT INTERFACE SPECIFICATION,
REV. 1.2" indicates that a device transitioning from D3hot to D0
_may_ perform an internal reset, thereby going to "D0 Uninitialized"
rather than "D0 Initialized".  This behaviour requires that the PCI
configuration of the device be restored after the D0 transition.

In most cases (as in calling ->resume), this is No Big Deal.  Many (or
most?) drivers simply call pci_restore_state after the transition to
D0.  However, when a driver loads it typically calls pci_enable_device
very early in the process.  (I guess they presume that the device will
be in D0.)  AFAICT none of them call pci_save_state before doing so
(or pci_restore_state afterward).

Drivers could be modified to do this, but that potentially requires a
lot of very similar changes to many/most/all PCI drivers.  It could
be argued that this is appropriate since the necessity of this step
depends on the hardware in use.  On the other hand, many drivers will
likely support some devices that exhibit this behaviour and some that
do not.

This issue regarding D3hot->D0 state transitions seems like a piece
of minutiae that we should not force individual drivers to address.
There is a bit in the PM status/control register that determines
whether or not the D3hot->D0 transition will cause such a reset.
The pci_set_power_state function is already looking at the PM
status/control register while most drivers have no other need to
do so.  Therefore, I propose handling this situation inside the
pci_set_power_state routine.  Patch below for discussion only...please
do NOT apply at this time...

Anyway, let me know what you think...

John

P.S.  I'm using dev->current_state == PCI_D3cold to indicate the first
use of this device after a (re)boot, and to restrict this behaviour
to that situation.  Part of me thinks that it may be worthwhile to
preserve the PCI configuration on any D3hot->D0 transition in case
the driver is being reloaded and doesn't know to restore the config.

P.P.S. Of course, the above concern may argue in favor of putting
responsibility for this on the drivers in the first place...?  Is there
any way to differentiate between whether or not pci_set_power_state
is being called from a ->probe routine rather than a ->resume routine?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -241,6 +241,7 @@ pci_set_power_state(struct pci_dev *dev,
 {
 	int pm;
 	u16 pmcsr, pmc;
+	int pci_state_saved = 0;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
@@ -278,6 +279,22 @@ pci_set_power_state(struct pci_dev *dev,
 			return -EIO;
 	}
 
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+
+	/* dev->current_state == PCI_D3cold actually indicates (re)boot
+		-- some firmware will leave devices in D3hot on boot
+		-- some devices will loose config (incl BARs) in D3hot->D0
+		-- for those devices, save config and restore after ->D0
+	   Could make drivers do this, but better to leave them ignorant
+	   of PCI PM trivia...
+	*/
+	if ((state == PCI_D0 && dev->current_state == PCI_D3cold) &&
+	    ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot) &&
+	    !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
+		pci_save_state(dev);
+		pci_state_saved = 1;
+	}
+
 	/* If we're in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
@@ -285,7 +302,6 @@ pci_set_power_state(struct pci_dev *dev,
 	if (dev->current_state >= PCI_D3hot)
 		pmcsr = 0;
 	else {
-		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
 	}
@@ -301,6 +317,9 @@ pci_set_power_state(struct pci_dev *dev,
 		udelay(200);
 	dev->current_state = state;
 
+	if (pci_state_saved)
+		pci_restore_state(dev);
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -225,6 +225,7 @@
 #define  PCI_PM_CAP_PME_D3cold  0x8000  /* PME# from D3 (cold) */
 #define PCI_PM_CTRL		4	/* PM control and status register */
 #define  PCI_PM_CTRL_STATE_MASK	0x0003	/* Current power state (D0 to D3) */
+#define  PCI_PM_CTRL_NO_SOFT_RESET	0x0004	/* No reset for D3hot->D0 */
 #define  PCI_PM_CTRL_PME_ENABLE	0x0100	/* PME pin enable */
 #define  PCI_PM_CTRL_DATA_SEL_MASK	0x1e00	/* Data select (??) */
 #define  PCI_PM_CTRL_DATA_SCALE_MASK	0x6000	/* Data scale (??) */
-- 
John W. Linville
linville@tuxdriver.com
