Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753500AbWKCTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbWKCTns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKCTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:43:47 -0500
Received: from mga03.intel.com ([143.182.124.21]:11932 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1753500AbWKCTnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:43:47 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,386,1157353200"; 
   d="scan'208"; a="140736422:sNHT112217952"
Message-ID: <454B9BED.306@intel.com>
Date: Fri, 03 Nov 2006 11:43:41 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       stable@vger.kernel.org
CC: rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org, laurent.riffard@free.fr,
       rajesh.shah@intel.com, toralf.foerster@gmx.de, jeff@garzik.org,
       pavel@ucw.cz, auke-jan.h.kok@intel.com, jesse.brandeburg@intel.com,
       "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, linville@redhat.com, wtogami@redhat.com,
       dag@wieers.com, error27@gmail.com,
       e1000-list <e1000-devel@lists.sourceforge.net>
Subject: [PATCH] e1000: Fix regression: garbled stats and irq allocation during
 swsusp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 19:43:42.0483 (UTC) FILETIME=[5E039E30:01C6FF80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


e1000: Fix regression: garbled stats and irq allocation during swsusp

After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
device showing garbled statistics and undetermined irq allocation state,
where `ifconfig eth0 down` would display `trying to free already freed irq`.

Explicitly free and allocate irq as well as powerup the PHY during resume
fixes.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index c0269b5..32cdccb 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -5081,6 +5081,8 @@ #endif
  	if (adapter->hw.phy_type == e1000_phy_igp_3)
  		e1000_phy_powerdown_workaround(&adapter->hw);

+	e1000_free_irq(adapter);
+
  	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
  	 * would have already happened in close and is redundant. */
  	e1000_release_hw_control(adapter);
@@ -5111,6 +5113,10 @@ e1000_resume(struct pci_dev *pdev)
  	pci_enable_wake(pdev, PCI_D3hot, 0);
  	pci_enable_wake(pdev, PCI_D3cold, 0);

+	if ((err = e1000_request_irq(adapter)))
+		return err;
+
+	e1000_power_up_phy(adapter);
  	e1000_reset(adapter);
  	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
