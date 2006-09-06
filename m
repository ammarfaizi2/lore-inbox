Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWIFXDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWIFXDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWIFXD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:36557 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965163AbWIFXDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:15 -0400
Date: Wed, 6 Sep 2006 15:58:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 35/37] sky2: MSI test timing
Message-ID: <20060906225804.GJ15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-post-bug.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

The test for MSI IRQ could have timing issues. The PCI write needs to be 
pushed out before waiting, and the wait queue should be initialized before
the IRQ.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/drivers/net/sky2.c
+++ linux-2.6.17.11/drivers/net/sky2.c
@@ -3184,6 +3184,8 @@ static int __devinit sky2_test_msi(struc
 	struct pci_dev *pdev = hw->pdev;
 	int err;
 
+	init_waitqueue_head (&hw->msi_wait);
+
 	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
 
 	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
@@ -3193,10 +3195,8 @@ static int __devinit sky2_test_msi(struc
 		return err;
 	}
 
-	init_waitqueue_head (&hw->msi_wait);
-
 	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
-	wmb();
+	sky2_read8(hw, B0_CTST);
 
 	wait_event_timeout(hw->msi_wait, hw->msi_detected, HZ/10);
 

--
