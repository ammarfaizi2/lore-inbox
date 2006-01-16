Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWAPJaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWAPJaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAPJ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:29:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932267AbWAPJWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:22:55 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Markus Rechberger <mrechberger@gmail.com>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 25/25] Added remote control support for pinnacle pctv
Date: Mon, 16 Jan 2006 07:11:26 -0200
Message-id: <20060116091126.PS06106100025@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Markus Rechberger <mrechberger@gmail.com>

- Added remote control support for pinnacle pctv

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/em28xx/em28xx-input.c |   77 +++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/em28xx/em28xx-input.c b/drivers/media/video/em28xx/em28xx-input.c
index 9b94f77..30dfa53 100644
--- a/drivers/media/video/em28xx/em28xx-input.c
+++ b/drivers/media/video/em28xx/em28xx-input.c
@@ -76,6 +76,58 @@ static IR_KEYTAB_TYPE ir_codes_em_terrat
 	[ 0x40 ] = KEY_ZOOM,
 };
 
+static IR_KEYTAB_TYPE ir_codes_em_pinnacle_usb[IR_KEYTAB_SIZE] = {
+	[ 0x3a ] = KEY_KP0,
+	[ 0x31 ] = KEY_KP1,
+	[ 0x32 ] = KEY_KP2,
+	[ 0x33 ] = KEY_KP3,
+	[ 0x34 ] = KEY_KP4,
+	[ 0x35 ] = KEY_KP5,
+	[ 0x36 ] = KEY_KP6,
+	[ 0x37 ] = KEY_KP7,
+	[ 0x38 ] = KEY_KP8,
+	[ 0x39 ] = KEY_KP9,
+
+	[ 0x2f ] = KEY_POWER,
+
+	[ 0x2e ] = KEY_P,
+	[ 0x1f ] = KEY_L,
+	[ 0x2b ] = KEY_I,
+
+	[ 0x2d ] = KEY_ZOOM,
+	[ 0x1e ] = KEY_ZOOM,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x0f ] = KEY_VOLUMEDOWN,
+	[ 0x17 ] = KEY_CHANNELUP,
+	[ 0x1c ] = KEY_CHANNELDOWN,
+	[ 0x25 ] = KEY_INFO,
+
+	[ 0x3c ] = KEY_MUTE,
+
+	[ 0x3d ] = KEY_LEFT,
+	[ 0x3b ] = KEY_RIGHT,
+
+	[ 0x3f ] = KEY_UP,
+	[ 0x3e ] = KEY_DOWN,
+	[ 0x1a ] = KEY_PAUSE,
+
+	[ 0x1d ] = KEY_MENU,
+	[ 0x19 ] = KEY_PLAY,
+	[ 0x16 ] = KEY_REWIND,
+	[ 0x13 ] = KEY_FORWARD,
+	[ 0x15 ] = KEY_PAUSE,
+	[ 0x0e ] = KEY_REWIND,
+	[ 0x0d ] = KEY_PLAY,
+	[ 0x0b ] = KEY_STOP,
+	[ 0x07 ] = KEY_FORWARD,
+	[ 0x27 ] = KEY_RECORD,
+	[ 0x26 ] = KEY_TUNER,
+	[ 0x29 ] = KEY_TEXT,
+	[ 0x2a ] = KEY_MEDIA,
+	[ 0x18 ] = KEY_EPG,
+	[ 0x27 ] = KEY_RECORD,
+};
+
 /* ----------------------------------------------------------------------- */
 
 static int get_key_terratec(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
@@ -138,6 +190,28 @@ static int get_key_em_haup(struct IR_i2c
 	return 1;
 }
 
+static int get_key_pinnacle_usb(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
+{
+	unsigned char buf[3];
+
+	/* poll IR chip */
+
+	if (3 != i2c_master_recv(&ir->c,buf,3)) {
+		dprintk("read error\n");
+		return -EIO;
+	}
+
+	dprintk("key %02x\n", buf[2]&0x3f);
+	if (buf[0]!=0x00){
+		return 0;
+	}
+
+	*ir_key = buf[2]&0x3f;
+	*ir_raw = buf[2]&0x3f;
+
+	return 1;
+}
+
 /* ----------------------------------------------------------------------- */
 void em28xx_set_ir(struct em28xx * dev,struct IR_i2c *ir)
 {
@@ -159,6 +233,9 @@ void em28xx_set_ir(struct em28xx * dev,s
 		snprintf(ir->c.name, sizeof(ir->c.name), "i2c IR (EM28XX Terratec)");
 		break;
 	case (EM2820_BOARD_PINNACLE_USB_2):
+		ir->ir_codes = ir_codes_em_pinnacle_usb;
+		ir->get_key = get_key_pinnacle_usb;
+		snprintf(ir->c.name, sizeof(ir->c.name), "i2c IR (EM28XX Pinnacle PCTV)");
 		break;
 	case (EM2820_BOARD_HAUPPAUGE_WINTV_USB_2):
 		ir->ir_codes = ir_codes_hauppauge_new;

