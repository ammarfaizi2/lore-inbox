Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTAXQkX>; Fri, 24 Jan 2003 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267774AbTAXQkX>; Fri, 24 Jan 2003 11:40:23 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20769 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267773AbTAXQkV>; Fri, 24 Jan 2003 11:40:21 -0500
Date: Fri, 24 Jan 2003 11:49:32 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301241649.h0OGnW929426@devserv.devel.redhat.com>
To: Michael Fu <michael.fu@linux.co.intel.com>
cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [BUG] e100 driver fails to initialize the hardware after kernel   bootup through kexec
In-Reply-To: <mailman.1043391842.14884.linux-kernel2news@redhat.com>
References: <1042450072.1744.75.camel@aminoacin.sh.intel.com> <mailman.1043391842.14884.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After kernel was bootup through kexec command, the NIC failed to
> initialize. The 2.5.52 kernel was patched with kexec and kexec-hwfix
> patch.

> PCI: Enabling device 02:09.0 (0000 -> 0003)
> PCI: Setting latency timer of device 02:09.0 to 64
> e100: selftest timeout
> e100: Failed to initialize, instance #0

A very similar thing happens on my laptop. Before the shutdown,
the previous driver puts the chip into D3 power state, and after
reboot the pci_enable_device cannot take it out from there,
because eepro refuses to wake from D3 to D0.
It will go from D3 to D2 and from D2 to D0 though.

Try the attached patch, please. I do not promise it will work,
but it may be worth trying.

-- Pete

--- linux-2.5.54/drivers/net/e100/e100_main.c	2003-01-07 10:43:37.000000000 -0800
+++ linux-2.5.54-p3/drivers/net/e100/e100_main.c	2003-01-24 08:47:14.000000000 -0800
@@ -2957,8 +2957,24 @@
 e100_pci_setup(struct pci_dev *pcid, struct e100_private *bdp)
 {
 	struct net_device *dev = bdp->device;
+	int pm;
+	u16 pmcsr;
 	int rc = 0;
 
+	/*
+	 * Workaround for warm boots and pci_set_power_state which tries
+	 * to set D0 straight out of D3.
+	 */
+	if ((pm = pci_find_capability(pcid, PCI_CAP_ID_PM)) != 0) {
+		pci_read_config_word(pcid, pm + PCI_PM_CTRL, &pmcsr);
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == 3) {
+			/* One step at a time */
+			/* P3 */ printk("e100: fixing PM from 3 to 2\n");
+			pci_write_config_word(pcid, pm + PCI_PM_CTRL, 2);
+			udelay(200);
+		}
+	}
+
 	if ((rc = pci_enable_device(pcid)) != 0) {
 		goto err;
 	}
