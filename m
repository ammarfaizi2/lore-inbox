Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEWXpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEWXpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVEWXWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:22:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:35713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbVEWXSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:18:43 -0400
Date: Mon, 23 May 2005 16:18:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, daniel.ritz@gmx.ch
Subject: [patch 02/16] 3c59x: only put the device into D3 when we're actually using WOL
Message-ID: <20050523231813.GN27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During a warm boot the device is in D3 and has troubles coming out of it.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/3c59x.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.11.10.orig/drivers/net/3c59x.c	2005-05-20 09:34:18.788560304 -0700
+++ linux-2.6.11.10/drivers/net/3c59x.c	2005-05-20 09:34:22.644974040 -0700
@@ -1581,7 +1581,8 @@
 
 	if (VORTEX_PCI(vp)) {
 		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
-		pci_restore_state(VORTEX_PCI(vp));
+		if (vp->pm_state_valid)
+			pci_restore_state(VORTEX_PCI(vp));
 		pci_enable_device(VORTEX_PCI(vp));
 	}
 
@@ -2741,6 +2742,7 @@
 		outl(0, ioaddr + DownListPtr);
 
 	if (final_down && VORTEX_PCI(vp)) {
+		vp->pm_state_valid = 1;
 		pci_save_state(VORTEX_PCI(vp));
 		acpi_set_WOL(dev);
 	}
@@ -3243,9 +3245,10 @@
 		outw(RxEnable, ioaddr + EL3_CMD);
 
 		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
+
+		/* Change the power state to D3; RxEnable doesn't take effect. */
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 	}
-	/* Change the power state to D3; RxEnable doesn't take effect. */
-	pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
 }
 
 
