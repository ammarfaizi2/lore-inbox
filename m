Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbTEMFNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbTEMFNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:13:09 -0400
Received: from dp.samba.org ([66.70.73.150]:51173 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262869AbTEMFNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:13:04 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.33200.514264.873611@argo.ozlabs.ibm.com>
Date: Tue, 13 May 2003 15:25:04 +1000
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Powermac ALSA sound driver updates
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sound/ppc/awacs.c driver so that the sound works
on my G4 powerbook (titanium) after waking it up from sleep, and also
fixes sound/ppc/keywest.c to adapt it to changes in the i2c layer.

Takashi, please pass this on to Linus if it looks OK to you.

Thanks,
Paul.

diff -urN linux-2.5/sound/ppc/awacs.c pmac-2.5/sound/ppc/awacs.c
--- linux-2.5/sound/ppc/awacs.c	2003-04-14 09:28:43.000000000 +1000
+++ pmac-2.5/sound/ppc/awacs.c	2003-04-15 22:43:33.000000000 +1000
@@ -649,8 +649,22 @@
 }
 
 #ifdef CONFIG_PMAC_PBOOK
+static void snd_pmac_awacs_suspend(pmac_t *chip)
+{
+	snd_pmac_awacs_write_noreg(chip, 1, (chip->awacs_reg[1]
+					     | MASK_AMUTE | MASK_CMUTE));
+}
+
 static void snd_pmac_awacs_resume(pmac_t *chip)
 {
+	if (machine_is_compatible("PowerBook3,1")
+	    || machine_is_compatible("PowerBook3,2")) {
+		do_mdelay(100, 0);
+		snd_pmac_awacs_write_reg(chip, 1,
+			chip->awacs_reg[1] & ~MASK_PAROUT);
+		do_mdelay(300, 0);
+	}
+
 	awacs_restore_all_regs(chip, 0);
 	if (chip->model == PMAC_SCREAMER) {
 		/* reset power bits in reg 6 */
@@ -868,6 +882,7 @@
 	 */
 	chip->set_format = snd_pmac_awacs_set_format;
 #ifdef CONFIG_PMAC_PBOOK
+	chip->suspend = snd_pmac_awacs_suspend;
 	chip->resume = snd_pmac_awacs_resume;
 #endif
 #ifdef PMAC_SUPPORT_AUTOMUTE
diff -urN linux-2.5/sound/ppc/keywest.c pmac-2.5/sound/ppc/keywest.c
--- linux-2.5/sound/ppc/keywest.c	2003-02-04 19:36:43.000000000 +1100
+++ pmac-2.5/sound/ppc/keywest.c	2003-04-06 12:14:38.000000000 +1000
@@ -57,20 +57,21 @@
 	if (! keywest_ctx)
 		return -EINVAL;
 
-	if (strncmp(adapter->name, "mac-io", 6))
+	if (strncmp(adapter->dev.name, "mac-io", 6))
 		return 0; /* ignored */
 
 	new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (! new_client)
 		return -ENOMEM;
+	memset(new_client, 0, sizeof(struct i2c_client));
 
 	new_client->addr = keywest_ctx->addr;
-	new_client->data = keywest_ctx;
+	i2c_set_clientdata(new_client, keywest_ctx);
 	new_client->adapter = adapter;
 	new_client->driver = &keywest_driver;
 	new_client->flags = 0;
 
-	strcpy(new_client->name, keywest_ctx->name);
+	strcpy(new_client->dev.name, keywest_ctx->name);
 
 	new_client->id = keywest_ctx->id++; /* Automatically unique */
 	keywest_ctx->client = new_client;
