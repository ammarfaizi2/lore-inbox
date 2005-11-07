Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVKGDSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVKGDSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVKGDSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:18:08 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:16276 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932430AbVKGDRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:25 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Hans Verkuil <hverkuil@xs4all.nl>
Subject: [Patch 14/20] V4L(915) Fixes compilation problems due removal of
	media id h and i2c algo bit
Date: Mon, 07 Nov 2005 00:58:10 -0200
Message-Id: <1131333341.25215.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

- Fixes compilation problems due removal of media/id.h and I2C_ALGO_BIT

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 Documentation/video4linux/CARDLIST.saa7134 |    2 +-
 drivers/media/video/cs53l32a.c             |   10 ++++++++--
 drivers/media/video/wm8775.c               |   12 ++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

--- hg.orig/Documentation/video4linux/CARDLIST.saa7134
+++ hg/Documentation/video4linux/CARDLIST.saa7134
@@ -77,6 +77,6 @@
  76 -> SKNet MonsterTV Mobile                   [1131:4ee9]
  77 -> Pinnacle PCTV 110i (saa7133)             [11bd:002e]
  78 -> ASUSTeK P7131 Dual                       [1043:4862]
- 79 -> PCTV Cardbus TV/Radio (ITO25 Rev:2B)
+ 79 -> Sedna/MuchTV PC TV Cardbus TV/Radio (ITO25 Rev:2B)
  80 -> ASUS Digimatrix TV                       [1043:0210]
  81 -> Philips Tiger reference design           [1131:2018]
--- hg.orig/drivers/media/video/cs53l32a.c
+++ hg/drivers/media/video/cs53l32a.c
@@ -25,9 +25,9 @@
 #include <linux/ioctl.h>
 #include <asm/uaccess.h>
 #include <linux/i2c.h>
+#include <linux/i2c-id.h>
 #include <linux/videodev.h>
 #include <media/audiochip.h>
-#include <media/id.h>
 
 MODULE_DESCRIPTION("i2c device driver for cs53l32a Audio ADC");
 MODULE_AUTHOR("Martin Vaughan");
@@ -190,7 +190,13 @@ static int cs53l32a_attach(struct i2c_ad
 
 static int cs53l32a_probe(struct i2c_adapter *adapter)
 {
-	return i2c_probe(adapter, &addr_data, cs53l32a_attach);
+#ifdef I2C_CLASS_TV_ANALOG
+	if (adapter->class & I2C_CLASS_TV_ANALOG)
+#else
+	if (adapter->id == I2C_HW_B_BT848)
+#endif
+		return i2c_probe(adapter, &addr_data, cs53l32a_attach);
+	return 0;
 }
 
 static int cs53l32a_detach(struct i2c_client *client)
--- hg.orig/drivers/media/video/wm8775.c
+++ hg/drivers/media/video/wm8775.c
@@ -26,9 +26,9 @@
 #include <linux/ioctl.h>
 #include <asm/uaccess.h>
 #include <linux/i2c.h>
+#include <linux/i2c-id.h>
 #include <linux/videodev.h>
 #include <media/audiochip.h>
-#include <media/id.h>
 
 MODULE_DESCRIPTION("wm8775 driver");
 MODULE_AUTHOR("Ulf Eklund");
@@ -204,14 +204,10 @@ static int wm8775_probe(struct i2c_adapt
 {
 #ifdef I2C_CLASS_TV_ANALOG
 	if (adapter->class & I2C_CLASS_TV_ANALOG)
-		return i2c_probe(adapter, &addr_data, wm8775_attach);
 #else
-	switch (adapter->id) {
-	case I2C_HW_B_BT848:
-		return i2c_probe(adapter, &addr_data, tda9887_attach);
-	}
-#endif /* I2C_CLASS_TV_ANALOG */
-
+	if (adapter->id == I2C_HW_B_BT848)
+#endif
+		return i2c_probe(adapter, &addr_data, wm8775_attach);
 	return 0;
 }
 


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

