Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbTCXWnU>; Mon, 24 Mar 2003 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264477AbTCXWnU>; Mon, 24 Mar 2003 17:43:20 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:53513 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S264476AbTCXWnH> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 17:43:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] PnP changes to allow MODULE_DEVICE_TABLE()
Date: Mon, 24 Mar 2003 23:54:02 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303242354.03527.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello adam, jaroslav, list

this patch does:
- rename struct pnp_card_id to pnp_card_device_id
- fix all references to it

this is needed for the MODULE_DEVICE_TABLE() macro to work with pnp_card's.
jaroslav did this a while ago (changeset 1.879.79.1), but adam undid it a bit
later (changeset 1.889.202.3). but why?

w/o the patch gcc dies when compiling als100.c with the message 'storage size
of __mod_pnp_card_device_table unknown' (this is from the macro).

any reasons why i should not send this to linus?
against 2.5.65-bk

rgds
-daniel



===== drivers/isdn/hisax/hisax_fcpcipnp.c 1.15 vs edited =====
--- 1.15/drivers/isdn/hisax/hisax_fcpcipnp.c	Sat Feb 22 19:05:19 2003
+++ edited/drivers/isdn/hisax/hisax_fcpcipnp.c	Mon Mar 24 22:44:32 2003
@@ -909,7 +909,7 @@
 #ifdef CONFIG_PNP_CARD
 
 static int __devinit fcpnp_probe(struct pnp_card *card,
-				 const struct pnp_card_id *card_id)
+				 const struct pnp_card_device_id *card_id)
 {
 	struct fritz_adapter *adapter;
 	struct pnp_dev *pnp_dev;
@@ -955,7 +955,7 @@
 	delete_adapter(adapter);
 }
 
-static struct pnp_card_id fcpnp_ids[] __devinitdata = {
+static struct pnp_card_device_id fcpnp_ids[] __devinitdata = {
 	{ .id          = "AVM0900", 
 	  .driver_data = (unsigned long) "Fritz!Card PnP",
 	  .devs        = { { "AVM0900" } },
===== drivers/pnp/card.c 1.10 vs edited =====
--- 1.10/drivers/pnp/card.c	Mon Mar 10 00:44:14 2003
+++ edited/drivers/pnp/card.c	Mon Mar 24 22:41:56 2003
@@ -21,9 +21,9 @@
 LIST_HEAD(pnp_cards);
 
 
-static const struct pnp_card_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
+static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
 {
-	const struct pnp_card_id * drv_id = drv->id_table;
+	const struct pnp_card_device_id * drv_id = drv->id_table;
 	while (*drv_id->id){
 		if (compare_pnp_id(card->id,drv_id->id))
 			return drv_id;
@@ -274,7 +274,7 @@
 
 	list_for_each_safe(pos,temp,&pnp_cards){
 		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
-		const struct pnp_card_id *id = match_card(drv,card);
+		const struct pnp_card_device_id *id = match_card(drv,card);
 		if (id) {
 			struct pnp_card_link * clink = pnp_alloc(sizeof(struct pnp_card_link));
 			if (!clink)
===== include/linux/pnp.h 1.17 vs edited =====
--- 1.17/include/linux/pnp.h	Tue Mar 11 07:34:19 2003
+++ edited/include/linux/pnp.h	Mon Mar 24 23:08:17 2003
@@ -295,7 +295,7 @@
 	unsigned long driver_data;	/* data private to the driver */
 };
 
-struct pnp_card_id {
+struct pnp_card_device_id {
 	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
@@ -316,9 +316,9 @@
 
 struct pnp_card_driver {
 	char * name;
-	const struct pnp_card_id *id_table;
+	const struct pnp_card_device_id *id_table;
 	unsigned int flags;
-	int  (*probe)  (struct pnp_card_link *card, const struct pnp_card_id *card_id);
+	int  (*probe)  (struct pnp_card_link *card, const struct pnp_card_device_id *card_id);
 	void (*remove) (struct pnp_card_link *card);
 	struct pnp_driver link;
 };
===== sound/isa/als100.c 1.9 vs edited =====
--- 1.9/sound/isa/als100.c	Mon Mar 10 00:44:14 2003
+++ edited/sound/isa/als100.c	Mon Mar 24 22:58:26 2003
@@ -98,7 +98,7 @@
 	struct pnp_dev *devopl;
 };
 
-static struct pnp_card_id snd_als100_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_als100_pnpids[] __devinitdata = {
 	/* ALS100 - PRO16PNP */
 	{ .id = "ALS0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
 	/* ALS110 - MF1000 - Digimate 3D Sound */
@@ -118,7 +118,7 @@
 
 static int __devinit snd_card_als100_isapnp(int dev, struct snd_card_als100 *acard,
 					    struct pnp_card_link *card,
-					    const struct pnp_card_id *id)
+					    const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
 	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
@@ -209,7 +210,7 @@
 
 static int __init snd_card_als100_probe(int dev,
 					struct pnp_card_link *pcard,
-					const struct pnp_card_id *pid)
+					const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -287,7 +288,7 @@
 }
 
 static int __devinit snd_als100_pnp_detect(struct pnp_card_link *card,
-					   const struct pnp_card_id *id)
+					   const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
===== sound/isa/sb/es968.c 1.9 vs edited =====
--- 1.9/sound/isa/sb/es968.c	Thu Mar 20 19:13:41 2003
+++ edited/sound/isa/sb/es968.c	Mon Mar 24 22:56:34 2003
@@ -69,7 +69,7 @@
 	struct pnp_dev *dev;
 };
 
-static struct pnp_card_id snd_es968_pnpids[] __devinitdata = {
+static struct pnp_card_device_id snd_es968_pnpids[] __devinitdata = {
 	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
 	{ .id = "", } /* end */
 };
@@ -92,7 +92,7 @@
 
 static int __devinit snd_card_es968_isapnp(int dev, struct snd_card_es968 *acard,
 					struct pnp_card_link *card,
-					const struct pnp_card_id *id)
+					const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
 	struct pnp_resource_table * cfg = kmalloc(GFP_ATOMIC, sizeof(struct pnp_resource_table));
@@ -133,7 +133,7 @@
 
 static int __init snd_card_es968_probe(int dev,
 					struct pnp_card_link *pcard,
-					const struct pnp_card_id *pid)
+					const struct pnp_card_device_id *pid)
 {
 	int error;
 	sb_t *chip;
@@ -188,7 +188,7 @@
 }
 
 static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
-                                          const struct pnp_card_id *id)
+                                          const struct pnp_card_device_id *id)
 {
 	static int dev;
 	int res;
===== sound/oss/sb_card.c 1.17 vs edited =====
--- 1.17/sound/oss/sb_card.c	Mon Mar 10 00:44:14 2003
+++ edited/sound/oss/sb_card.c	Mon Mar 24 22:52:59 2003
@@ -224,7 +224,7 @@
 }
 
 /* Probe callback function for the PnP API */
-static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_id *card_id)
+static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_device_id *card_id)
 {
 	struct sb_card_config *scc;
 	struct sb_module_options sbmo = {0}; /* Default to 0 for PnP */
===== sound/oss/sb_card.h 1.2 vs edited =====
--- 1.2/sound/oss/sb_card.h	Mon Mar 10 00:44:14 2003
+++ edited/sound/oss/sb_card.h	Mon Mar 24 22:54:47 2003
@@ -23,7 +23,7 @@
  */
 
 /* Card PnP ID Table */
-static struct pnp_card_id sb_pnp_card_table[] = {
+static struct pnp_card_device_id sb_pnp_card_table[] = {
 	/* Sound Blaster 16 */
 	{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
 	/* Sound Blaster 16 */

