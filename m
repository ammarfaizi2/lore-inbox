Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUJIUCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUJIUCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJIUCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:02:12 -0400
Received: from [145.85.127.2] ([145.85.127.2]:21476 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267345AbUJIUB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:01:56 -0400
Message-ID: <53754.217.121.83.210.1097352107.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 22:01:47 +0200 (CEST)
Subject: [Patch 3/5] xbox: block certain PCI devices
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When probing certain devices or busses on the Xbox, the system may hang.
Therefore, we need to blacklist certain busses.

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-xbox-pci_workaround.diff
---

 direct.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

diff -u -r --new-file linux-2.6.9-rc3/arch/i386/pci/direct.c
linux-2.6.9-rc3-ed0/arch/i386/pci/direct.c
--- linux-2.6.9-rc3/arch/i386/pci/direct.c	2004-09-30 05:04:23.000000000
+0200
+++ linux-2.6.9-rc3-ed0/arch/i386/pci/direct.c	2004-10-09
19:49:54.677610000 +0200
@@ -20,6 +20,22 @@
 	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;

+#ifdef CONFIG_X86_XBOX
+	/*
+	 * Workaround for the Microsoft Xbox:
+	 * Prevent it from tampering with some devices.
+	 */
+	if ((bus == 0) && !PCI_SLOT(devfn) &&
+			((PCI_FUNC(devfn) == 1) || (PCI_FUNC(devfn) == 2)))
+		return -EINVAL;
+
+	if ((bus == 1) && (PCI_SLOT(devfn) || PCI_FUNC(devfn)))
+		return -EINVAL;
+
+	if (bus >= 2)
+		return -EINVAL;
+#endif
+
 	spin_lock_irqsave(&pci_config_lock, flags);

 	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
