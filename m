Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753450AbWKFQ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbWKFQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbWKFQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:57:22 -0500
Received: from mga03.intel.com ([143.182.124.21]:24168 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1753450AbWKFQ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:57:21 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,392,1157353200"; 
   d="scan'208"; a="141944628:sNHT30046639"
From: Auke Kok <auke-jan.h.kok@intel.com>
To: jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
CC: rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org, laurent.riffard@free.fr,
       rajesh.shah@intel.com, toralf.foerster@gmx.de, pavel@ucw.cz,
       auke-jan.h.kok@intel.com, jesse.brandeburg@intel.com,
       "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, e1000-list <e1000-devel@lists.sourceforge.net>
Subject: [PATCH] e1000: Fix regression: garbled stats and irq allocation during swsusp
Message-Id: <20061106165712.BAA253FFEA@ahkok-mobl.jf.intel.com>
Date: Mon,  6 Nov 2006 08:57:12 -0800 (PST)
X-OriginalArrivalTime: 06 Nov 2006 16:57:12.0994 (UTC) FILETIME=[9B0DD020:01C701C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e1000: Fix suspend/resume powerup and irq allocation

From: Auke Kok <auke-jan.h.kok@intel.com>

After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
device showing garbled statistics and undetermined irq allocation state,
where `ifconfig eth0 down` would display `trying to free already freed irq`.

Explicitly free and allocate irq as well as powerup the PHY during resume
fixes when needed.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
---

 drivers/net/e1000/e1000_main.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 8d04752..726ec5e 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -4800,6 +4800,9 @@ e1000_suspend(struct pci_dev *pdev, pm_m
 	if (adapter->hw.phy_type == e1000_phy_igp_3)
 		e1000_phy_powerdown_workaround(&adapter->hw);
 
+	if (netif_running(netdev))
+		e1000_free_irq(adapter);
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant. */
 	e1000_release_hw_control(adapter);
@@ -4830,6 +4833,10 @@ e1000_resume(struct pci_dev *pdev)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
+	if (netif_running(netdev) && (err = e1000_request_irq(adapter)))
+		return err;
+
+	e1000_power_up_phy(adapter);
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
 
