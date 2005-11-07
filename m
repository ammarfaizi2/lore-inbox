Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVKGDTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVKGDTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVKGDSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:18:46 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:26242 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932436AbVKGDSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:18:06 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Ricardo Cerqueira <v4l@cerqueira.org>
Subject: [Patch 11/20] V4L(913) Saa713x cards with i2c remotes now autoload
	ir kbd i2c
Date: Mon, 07 Nov 2005 00:58:09 -0200
Message-Id: <1131333341.25215.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- SAA713x cards with i2c remotes now autoload ir-kbd-i2c
(disable_ir works, as it does for GPIO remotes)

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/saa7134/saa7134-cards.c |    9 +++++++--
 drivers/media/video/saa7134/saa7134-core.c  |    4 +++-
 drivers/media/video/saa7134/saa7134-input.c |    3 ++-
 drivers/media/video/saa7134/saa7134.h       |    6 ++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

--- hg.orig/drivers/media/video/saa7134/saa7134-cards.c
+++ hg/drivers/media/video/saa7134/saa7134-cards.c
@@ -3038,7 +3038,7 @@ int saa7134_board_init1(struct saa7134_d
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
-		dev->has_remote = 1;
+		dev->has_remote = SAA7134_REMOTE_GPIO;
 		board_flyvideo(dev);
 		break;
 	case SAA7134_BOARD_FLYTVPLATINUM_MINI2:
@@ -3068,7 +3068,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_GOTVIEW_7135:
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
 	case SAA7134_BOARD_PCTV_CARDBUS:
-		dev->has_remote = 1;
+		dev->has_remote = SAA7134_REMOTE_GPIO;
 		break;
 	case SAA7134_BOARD_MD5044:
 		printk("%s: seems there are two different versions of the MD5044\n"
@@ -3108,6 +3108,11 @@ int saa7134_board_init1(struct saa7134_d
 
 		saa_writeb (SAA7134_PRODUCTION_TEST_MODE, 0x00);
 		break;
+	/* i2c remotes */
+	case SAA7134_BOARD_PINNACLE_PCTV_110i:
+	case SAA7134_BOARD_UPMOST_PURPLE_TV:
+		dev->has_remote = SAA7134_REMOTE_I2C;
+		break;
 	}
 	return 0;
 }
--- hg.orig/drivers/media/video/saa7134/saa7134-core.c
+++ hg/drivers/media/video/saa7134/saa7134-core.c
@@ -712,10 +712,12 @@ static int saa7134_hwinit2(struct saa713
 		SAA7134_IRQ2_INTE_PE      |
 		SAA7134_IRQ2_INTE_AR;
 
-	if (dev->has_remote)
+	if (dev->has_remote == SAA7134_REMOTE_GPIO)
 		irq2_mask |= (SAA7134_IRQ2_INTE_GPIO18  |
 			      SAA7134_IRQ2_INTE_GPIO18A |
 			      SAA7134_IRQ2_INTE_GPIO16  );
+	else if (dev->has_remote == SAA7134_REMOTE_I2C)
+		request_module("ir-kbd-i2c");
 
 	saa_writel(SAA7134_IRQ1, 0);
 	saa_writel(SAA7134_IRQ2, irq2_mask);
--- hg.orig/drivers/media/video/saa7134/saa7134.h
+++ hg/drivers/media/video/saa7134/saa7134.h
@@ -213,6 +213,12 @@ struct saa7134_format {
 #define SAA7134_INPUT_MAX 8
 
 /* ----------------------------------------------------------- */
+/* Since we support 2 remote types, lets tell them apart       */
+
+#define SAA7134_REMOTE_GPIO  1
+#define SAA7134_REMOTE_I2C   2
+
+/* ----------------------------------------------------------- */
 /* Video Output Port Register Initialization Options           */
 
 #define SET_T_CODE_POLARITY_NON_INVERTED	(1 << 0)
--- hg.orig/drivers/media/video/saa7134/saa7134-input.c
+++ hg/drivers/media/video/saa7134/saa7134-input.c
@@ -716,7 +716,7 @@ int saa7134_input_init1(struct saa7134_d
 	int polling      = 0;
 	int ir_type      = IR_TYPE_OTHER;
 
-	if (!dev->has_remote)
+	if (dev->has_remote != SAA7134_REMOTE_GPIO)
 		return -ENODEV;
 	if (disable_ir)
 		return -ENODEV;
@@ -877,6 +877,7 @@ void saa7134_input_fini(struct saa7134_d
 void saa7134_set_i2c_ir(struct saa7134_dev *dev, struct IR_i2c *ir)
 {
 	if (disable_ir) {
+		dprintk("Found supported i2c remote, but IR has been disabled\n");
 		ir->get_key=NULL;
 		return;
 	}


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

