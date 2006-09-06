Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWIFXLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWIFXLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWIFXC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:53708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964977AbWIFXCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:07 -0400
Date: Wed, 6 Sep 2006 15:56:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, davem@davemloft.net
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Michael Chan <mchan@broadcom.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/37] TG3: Disable TSO by default
Message-ID: <20060906225644.GR15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tg3-disable-tso-by-default.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Michael Chan <mchan@broadcom.com>

Disable TSO by default on some chips due to hardware errata.

Enabling TSO can lead to tx timeouts in some cases when the TSO
header size exceeds 80 bytes on the affected chips.  This limit
can be exceeded when the TCP header contains the timestamp option
plus 2 SACK blocks, for example.  A more complete workaround is
available in the next 2.6.18 kernel.

Signed-off-by: Michael Chan <mchan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/net/tg3.c |   12 ++++++++----
 drivers/net/tg3.h |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

--- linux-2.6.17.11.orig/drivers/net/tg3.c
+++ linux-2.6.17.11/drivers/net/tg3.c
@@ -69,8 +69,8 @@
 
 #define DRV_MODULE_NAME		"tg3"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"3.59"
-#define DRV_MODULE_RELDATE	"June 8, 2006"
+#define DRV_MODULE_VERSION	"3.59.1"
+#define DRV_MODULE_RELDATE	"August 25, 2006"
 
 #define TG3_DEF_MAC_MODE	0
 #define TG3_DEF_RX_MODE		0
@@ -11381,11 +11381,15 @@ static int __devinit tg3_init_one(struct
 		tp->tg3_flags2 |= TG3_FLG2_TSO_CAPABLE;
 	}
 
-	/* TSO is on by default on chips that support hardware TSO.
+	/* TSO is on by default on chips that support HW_TSO_2.
+	 * Some HW_TSO_1 capable chips have bugs that can lead to
+	 * tx timeouts in some cases when TSO is enabled.
 	 * Firmware TSO on older chips gives lower performance, so it
 	 * is off by default, but can be enabled using ethtool.
 	 */
-	if (tp->tg3_flags2 & TG3_FLG2_HW_TSO)
+	if ((tp->tg3_flags2 & TG3_FLG2_HW_TSO_2) ||
+	    (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5750 &&
+	     tp->pci_chip_rev_id >= CHIPREV_ID_5750_C2))
 		dev->features |= NETIF_F_TSO;
 
 #endif
--- linux-2.6.17.11.orig/drivers/net/tg3.h
+++ linux-2.6.17.11/drivers/net/tg3.h
@@ -125,6 +125,7 @@
 #define  CHIPREV_ID_5750_A0		 0x4000
 #define  CHIPREV_ID_5750_A1		 0x4001
 #define  CHIPREV_ID_5750_A3		 0x4003
+#define  CHIPREV_ID_5750_C2		 0x4202
 #define  CHIPREV_ID_5752_A0_HW		 0x5000
 #define  CHIPREV_ID_5752_A0		 0x6000
 #define  CHIPREV_ID_5752_A1		 0x6001

--
