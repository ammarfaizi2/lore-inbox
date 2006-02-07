Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWBGPlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWBGPlk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBGPlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27330 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751134AbWBGPle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:34 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/16] FIX: Check if FW was downloaded or not + new
	firmware file
Date: Tue, 07 Feb 2006 13:33:33 -0200
Message-id: <20060207153333.PS47276100012@infradead.org>
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

From: Patrick Boettcher <pb@linuxtv.org>

- When a firmware was downloaded dvb_usb_device_init returns NULL for the
  dvb_usb_device, then nothing should be done with that pointer and device,
  because it will re-enumerate.
- A new firmware should be used with digitv devices. 
- It should make "slave"-devices work and others, too.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/digitv.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/digitv.c b/drivers/media/dvb/dvb-usb/digitv.c
index e6c55c9..caa1346 100644
--- a/drivers/media/dvb/dvb-usb/digitv.c
+++ b/drivers/media/dvb/dvb-usb/digitv.c
@@ -175,11 +175,13 @@ static int digitv_probe(struct usb_inter
 	if ((ret = dvb_usb_device_init(intf,&digitv_properties,THIS_MODULE,&d)) == 0) {
 		u8 b[4] = { 0 };
 
-		b[0] = 1;
-		digitv_ctrl_msg(d,USB_WRITE_REMOTE_TYPE,0,b,4,NULL,0);
+		if (d != NULL) { /* do that only when the firmware is loaded */
+			b[0] = 1;
+			digitv_ctrl_msg(d,USB_WRITE_REMOTE_TYPE,0,b,4,NULL,0);
 
-		b[0] = 0;
-		digitv_ctrl_msg(d,USB_WRITE_REMOTE,0,b,4,NULL,0);
+			b[0] = 0;
+			digitv_ctrl_msg(d,USB_WRITE_REMOTE,0,b,4,NULL,0);
+		}
 	}
 	return ret;
 }
@@ -194,7 +196,7 @@ static struct dvb_usb_properties digitv_
 	.caps = DVB_USB_IS_AN_I2C_ADAPTER,
 
 	.usb_ctrl = CYPRESS_FX2,
-	.firmware = "dvb-usb-digitv-01.fw",
+	.firmware = "dvb-usb-digitv-02.fw",
 
 	.size_of_priv     = 0,
 
@@ -229,6 +231,7 @@ static struct dvb_usb_properties digitv_
 			{ &digitv_table[0], NULL },
 			{ NULL },
 		},
+		{ NULL },
 	}
 };
 

