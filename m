Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWHUSrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWHUSrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHUSrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:47:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:29628 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750716AbWHUSrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:47:32 -0400
Date: Mon, 21 Aug 2006 11:45:54 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/20] sky2: phy power problem on 88e805x
Message-ID: <20060821184554.GC21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-phy-power-problem-on-88e805x.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

On the 88E805X chipsets (used in laptops), the PHY was not getting powered
out of shutdown properly. The variable reg1 was getting reused incorrectly.
This is probably the cause of the bug.
	http://bugzilla.kernel.org/show_bug.cgi?id=6471

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17.8.orig/drivers/net/sky2.c
+++ linux-2.6.17.8/drivers/net/sky2.c
@@ -233,6 +233,8 @@ static void sky2_set_power_state(struct 
 			if (hw->ports > 1)
 				reg1 |= PCI_Y2_PHY2_COMA;
 		}
+		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+		udelay(100);
 
 		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
 			sky2_write16(hw, B0_CTST, Y2_HW_WOL_ON);
@@ -243,8 +245,6 @@ static void sky2_set_power_state(struct 
 			sky2_pci_write32(hw, PCI_DEV_REG5, 0);
 		}
 
-		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
-
 		break;
 
 	case PCI_D3hot:

--
