Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162248AbWKPCwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162248AbWKPCwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162256AbWKPCwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:52:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8375 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162271AbWKPCwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:52:10 -0500
Message-Id: <20061116024631.028282000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, jeff@garzik.org,
       torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Auke Kok <auke-jan.h.kok@intel.com>,
       nhorman@redhat.com, cluebot@fedorafaq.org, laurent.riffard@free.fr,
       toralf.foerster@gmx.de, bruce.w.allan@intel.com,
       jesse.brandeburg@intel.com, rajesh.shah@intel.com, rjw@sisk.pl,
       e1000-list <e1000-devel@lists.sourceforge.net>, john.ronciak@intel.com,
       pavel@ucw.cz, notting@redhat.com, bunk@stusta.de,
       "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 13/30] e1000: Fix regression: garbled stats and irq allocation during swsusp
Content-Disposition: inline; filename=e1000-fix-regression-garbled-stats-and-irq-allocation-during-swsusp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Auke Kok <auke-jan.h.kok@intel.com>

e1000: Fix suspend/resume powerup and irq allocation

From: Auke Kok <auke-jan.h.kok@intel.com>

After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
device showing garbled statistics and undetermined irq allocation state,
where `ifconfig eth0 down` would display `trying to free already freed irq`.

Explicitly free and allocate irq as well as powerup the PHY during resume
fixes when needed.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
[chrisw: trivial 2.6.18 backport s/err/ret_val/]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/e1000/e1000_main.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.18.2.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6.18.2/drivers/net/e1000/e1000_main.c
@@ -4683,6 +4683,9 @@ e1000_suspend(struct pci_dev *pdev, pm_m
 	if (adapter->hw.phy_type == e1000_phy_igp_3)
 		e1000_phy_powerdown_workaround(&adapter->hw);
 
+	if (netif_running(netdev))
+		e1000_free_irq(adapter);
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant. */
 	e1000_release_hw_control(adapter);
@@ -4710,6 +4713,10 @@ e1000_resume(struct pci_dev *pdev)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
+	if (netif_running(netdev) && (ret_val = e1000_request_irq(adapter)))
+		return ret_val;
+
+	e1000_power_up_phy(adapter);
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
 

--
