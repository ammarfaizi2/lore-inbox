Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWBGPlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWBGPlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWBGPk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20418 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751130AbWBGPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:54 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/16] Fix [Bug 5895] to correct snd_87x autodetect
Date: Tue, 07 Feb 2006 13:33:30 -0200
Message-id: <20060207153330.PS44220900004@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

With DVB drivers enabled snd_87x (ALSA) don't detect.


Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/bt878.c |   44 ++++++++++++++++++++++++++++++++++++++-
 drivers/media/dvb/bt8xx/bt878.h |   17 +++++++++++++++
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
index a04bb61..34c3189 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -381,6 +381,23 @@ bt878_device_control(struct bt878 *bt, u
 
 EXPORT_SYMBOL(bt878_device_control);
 
+
+struct cards card_list[] __devinitdata = {
+
+	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,			"Nebula Electronics DigiTV" },
+	{ 0x07611461, BTTV_BOARD_AVDVBT_761,			"AverMedia AverTV DVB-T 761" },
+	{ 0x001c11bd, BTTV_BOARD_PINNACLESAT,			"Pinnacle PCTV Sat" },
+	{ 0x002611bd, BTTV_BOARD_TWINHAN_DST,			"Pinnacle PCTV SAT CI" },
+	{ 0x00011822, BTTV_BOARD_TWINHAN_DST,			"Twinhan VisionPlus DVB" },
+	{ 0xfc00270f, BTTV_BOARD_TWINHAN_DST,			"ChainTech digitop DST-1000 DVB-S" },
+	{ 0x07711461, BTTV_BOARD_AVDVBT_771,			"AVermedia AverTV DVB-T 771" },
+	{ 0xdb1018ac, BTTV_BOARD_DVICO_DVBT_LITE,		"DViCO FusionHDTV DVB-T Lite" },
+	{ 0xd50018ac, BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE,	"DViCO FusionHDTV 5 Lite" },
+	{ 0x20007063, BTTV_BOARD_PC_HDTV,			"pcHDTV HD-2000 TV"},
+	{ 0, -1, NULL }
+};
+
+
 /***********************/
 /* PCI device handling */
 /***********************/
@@ -388,18 +405,41 @@ EXPORT_SYMBOL(bt878_device_control);
 static int __devinit bt878_probe(struct pci_dev *dev,
 				 const struct pci_device_id *pci_id)
 {
-	int result;
+	int result = 0, has_dvb = 0, i;
 	unsigned char lat;
 	struct bt878 *bt;
 #if defined(__powerpc__)
 	unsigned int cmd;
 #endif
+	unsigned int cardid;
+	unsigned short id;
+	struct cards *dvb_cards;
 
 	printk(KERN_INFO "bt878: Bt878 AUDIO function found (%d).\n",
 	       bt878_num);
 	if (pci_enable_device(dev))
 		return -EIO;
 
+	pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &id);
+	cardid = id << 16;
+	pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &id);
+	cardid |= id;
+
+	for (i = 0, dvb_cards = card_list; i < ARRAY_SIZE(card_list); i++, dvb_cards++) {
+		if (cardid == dvb_cards->pci_id) {
+			printk("%s: card id=[0x%x],[ %s ] has DVB functions.\n",
+				__func__, cardid, dvb_cards->name);
+			has_dvb = 1;
+		}
+	}
+
+	if (!has_dvb) {
+		printk("%s: card id=[0x%x], Unknown card.\nExiting..\n", __func__, cardid);
+		result = -EINVAL;
+
+		goto fail0;
+	}
+
 	bt = &bt878[bt878_num];
 	bt->dev = dev;
 	bt->nr = bt878_num;
@@ -416,6 +456,8 @@ static int __devinit bt878_probe(struct 
 
 	pci_read_config_byte(dev, PCI_CLASS_REVISION, &bt->revision);
 	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
+
+
 	printk(KERN_INFO "bt878(%d): Bt%x (rev %d) at %02x:%02x.%x, ",
 	       bt878_num, bt->id, bt->revision, dev->bus->number,
 	       PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
diff --git a/drivers/media/dvb/bt8xx/bt878.h b/drivers/media/dvb/bt8xx/bt878.h
index a73baf0..9faf937 100644
--- a/drivers/media/dvb/bt8xx/bt878.h
+++ b/drivers/media/dvb/bt8xx/bt878.h
@@ -88,6 +88,23 @@
 
 #define BT878_RISC_SYNC_MASK	(1 << 15)
 
+
+#define BTTV_BOARD_UNKNOWN                 0x00
+#define BTTV_BOARD_PINNACLESAT             0x5e
+#define BTTV_BOARD_NEBULA_DIGITV           0x68
+#define BTTV_BOARD_PC_HDTV                 0x70
+#define BTTV_BOARD_TWINHAN_DST             0x71
+#define BTTV_BOARD_AVDVBT_771              0x7b
+#define BTTV_BOARD_AVDVBT_761              0x7c
+#define BTTV_BOARD_DVICO_DVBT_LITE         0x80
+#define BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE 0x87
+
+struct cards {
+	__u32 pci_id;
+	__u16 card_id;
+	char  *name;
+};
+
 extern int bt878_num;
 
 struct bt878 {

