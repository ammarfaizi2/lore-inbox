Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbWCQVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWCQVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWCQU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63658 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932768AbWCQU47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:59 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 05/21] Added no_overlay option and quirks to saa7134
Date: Fri, 17 Mar 2006 17:54:34 -0300
Message-id: <20060317205433.PS91497800005@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1142020010 \-0300

Some chipsets have several problems when pci to pci transfers are activated
on overlay mode. the option no_overlay allows disabling such feature of
the driver, in favor of keeping the system stable.
The default is to use pcipci_fail flag defined on drivers/pci/quirks.c.
It also allows the user to override it by forcing disable overlay or forcing
enable. Forcing enable may generate PCI transfer corruption, including disk
mass corruption, so should be used with care.
Added a text description to this option and make messages looks the same at
both bttv and saa7134 drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bttv-cards.c           |   10 +++++++---
 drivers/media/video/saa7134/saa7134-core.c |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/bttv-cards.c b/drivers/media/video/bttv-cards.c
index 9749d6e..ffbc848 100644
--- a/drivers/media/video/bttv-cards.c
+++ b/drivers/media/video/bttv-cards.c
@@ -137,6 +137,8 @@ MODULE_PARM_DESC(card,"specify TV/grabbe
 MODULE_PARM_DESC(pll,"specify installed crystal (0=none, 28=28 MHz, 35=35 MHz)");
 MODULE_PARM_DESC(tuner,"specify installed tuner type");
 MODULE_PARM_DESC(autoload,"automatically load i2c modules like tuner.o, default is 1 (yes)");
+MODULE_PARM_DESC(no_overlay,"allow override overlay default (0 disables, 1 enables)"
+		" [some VIA/SIS chipsets are known to have problem with overlay]");
 
 /* ----------------------------------------------------------------------- */
 /* list of card IDs for bt878+ cards                                       */
@@ -4944,12 +4946,14 @@ void __devinit bttv_check_chipset(void)
 	if (vsfx)
 		printk(KERN_INFO "bttv: Host bridge needs VSFX enabled.\n");
 	if (pcipci_fail) {
-		printk(KERN_WARNING "bttv: BT848 and your chipset may not work together.\n");
+		printk(KERN_INFO "bttv: bttv and your chipset may not work "
+							"together.\n");
 		if (!no_overlay) {
-			printk(KERN_WARNING "bttv: overlay will be disabled.\n");
+			printk(KERN_INFO "bttv: overlay will be disabled.\n");
 			no_overlay = 1;
 		} else {
-			printk(KERN_WARNING "bttv: overlay forced. Use this option at your own risk.\n");
+			printk(KERN_INFO "bttv: overlay forced. Use this "
+						"option at your own risk.\n");
 		}
 	}
 	if (UNSET != latency)
diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 028904b..996b5ee 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -66,6 +66,11 @@ static unsigned int latency = UNSET;
 module_param(latency, int, 0444);
 MODULE_PARM_DESC(latency,"pci latency timer");
 
+static int no_overlay=-1;
+module_param(no_overlay, int, 0444);
+MODULE_PARM_DESC(no_overlay,"allow override overlay default (0 disables, 1 enables)"
+		" [some VIA/SIS chipsets are known to have problem with overlay]");
+
 static unsigned int video_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int vbi_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 static unsigned int radio_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
@@ -835,6 +840,22 @@ static int __devinit saa7134_initdev(str
 			latency = 0x0A;
 		}
 #endif
+		if (pci_pci_problems & PCIPCI_FAIL) {
+			printk(KERN_INFO "%s: quirk: this driver and your "
+					"chipset may not work together"
+					" in overlay mode.\n",dev->name);
+			if (!no_overlay) {
+				printk(KERN_INFO "%s: quirk: overlay "
+						"mode will be disabled.\n",
+						dev->name);
+				no_overlay = 1;
+			} else {
+				printk(KERN_INFO "%s: quirk: overlay "
+						"mode will be forced. Use this"
+						" option at your own risk.\n",
+						dev->name);
+			}
+		}
 	}
 	if (UNSET != latency) {
 		printk(KERN_INFO "%s: setting pci latency timer to %d\n",

