Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbWCTPYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbWCTPYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWCTPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:23:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62434 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965278AbWCTPX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:28 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Patrick Boettcher <pb@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 065/141] V4L/DVB (3313): FIX: Check if FW was downloaded or
	not + new firmware file
Date: Mon, 20 Mar 2006 12:08:47 -0300
Message-id: <20060320150847.PS826126000065@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>
Date: 1139302152 -0200

- When a firmware was downloaded dvb_usb_device_init returns NULL for the
  dvb_usb_device, then nothing should be done with that pointer and device,
  because it will re-enumerate.
- A new firmware should be used with digitv devices. 
- It should make "slave"-devices work and others, too.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-usb/digitv.c b/drivers/media/dvb/dvb-usb/digitv.c
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
 

