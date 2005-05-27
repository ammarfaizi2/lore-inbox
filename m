Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVE0MyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVE0MyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVE0MyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:54:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15542 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262456AbVE0Mx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:53:59 -0400
Date: Fri, 27 May 2005 14:04:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] suspend: PCI power managment reference implementation
Message-ID: <20050527120406.GA2088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added reference implementation of suspend and resume routines.

From: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit d9b44d1230ad7a7474583eef8ae57060137466c4
tree c50cf60fc2e546606c2f6e7c5f3f32655dee778d
parent 54afa0887fd3618c7fa350b14cc57446db2a261a
author <pavel@amd.(none)> Fri, 27 May 2005 09:19:51 +0200
committer <pavel@amd.(none)> Fri, 27 May 2005 09:19:51 +0200

 Documentation/power/pci.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+)

Index: Documentation/power/pci.txt
===================================================================
--- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/Documentation/power/pci.txt  (mode:100644)
+++ c50cf60fc2e546606c2f6e7c5f3f32655dee778d/Documentation/power/pci.txt  (mode:100644)
@@ -291,6 +291,44 @@
 pci_enable_wake (one for both D3hot and D3cold).
 
 
+A reference implementation
+-------------------------
+.suspend()
+{
+	/* driver specific operations */
+
+	/* Disable IRQ */
+	free_irq();
+	/* If using MSI */
+	pci_disable_msi();
+
+	pci_save_state();
+	pci_enable_wake();
+	/* Disable IO/bus master/irq router */
+	pci_disable_device();
+	pci_set_power_state(pci_choose_state());
+}
+
+.resume()
+{
+	pci_set_power_state(PCI_D0);
+	pci_restore_state();
+	/* device's irq possibly is changed, driver should take care */
+	pci_enable_device();
+	pci_set_master();
+
+	/* if using MSI, device's vector possibly is changed */
+	pci_enable_msi();
+
+	request_irq();
+	/* driver specific operations; */
+}
+
+This is a typical implementation. Drivers can slightly change the order
+of the operations in the implementation, ignore some operations or add
+more deriver specific operations in it, but drivers should do something like
+this on the whole.
+
 5. Resources
 ~~~~~~~~~~~~
 

