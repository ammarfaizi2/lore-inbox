Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVIDXsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVIDXsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVIDXrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:47:51 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:43649 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932118AbVIDXal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:41 -0400
Message-Id: <20050904232333.429481000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:43 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-cinergyT2-ir-rc-fixes.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 44/54] cinergyT2: remote control fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IR RC fixes:
- EVIOCSKEYCODE is not supported by this driver, fix potential crash
  when it is used by not setting rc_input_dev->keycodesize
- fix key repeat handling (hopefully)
- reduce default poll internal to 50msec (necessary for key repeat handling)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/cinergyT2/Kconfig     |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c |   93 +++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 38 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/cinergyT2/Kconfig	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/cinergyT2/Kconfig	2005-09-04 22:30:53.000000000 +0200
@@ -77,7 +77,7 @@ config DVB_CINERGYT2_ENABLE_RC_INPUT_DEV
 config DVB_CINERGYT2_RC_QUERY_INTERVAL
 	int "Infrared Remote Controller update interval [milliseconds]"
 	depends on DVB_CINERGYT2_TUNING && DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE
-        default "100"
+        default "50"
 	help
 	  If you have a very fast-repeating remote control you can try lower
 	  values, for normal consumer receivers the default value should be
--- linux-2.6.13-git4.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-09-04 22:27:49.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-09-04 22:30:53.000000000 +0200
@@ -35,7 +35,6 @@
 #include "dvb_demux.h"
 #include "dvb_net.h"
 
-
 #ifdef CONFIG_DVB_CINERGYT2_TUNING
 	#define STREAM_URB_COUNT (CONFIG_DVB_CINERGYT2_STREAM_URB_COUNT)
 	#define STREAM_BUF_SIZE (CONFIG_DVB_CINERGYT2_STREAM_BUF_SIZE)
@@ -48,7 +47,7 @@
 	#define STREAM_URB_COUNT (32)
 	#define STREAM_BUF_SIZE (512)	/* bytes */
 	#define ENABLE_RC (1)
-	#define RC_QUERY_INTERVAL (100)	/* milliseconds */
+	#define RC_QUERY_INTERVAL (50)	/* milliseconds */
 	#define QUERY_INTERVAL (333)	/* milliseconds */
 #endif
 
@@ -141,6 +140,8 @@ struct cinergyt2 {
 	struct input_dev rc_input_dev;
 	struct work_struct rc_query_work;
 	int rc_input_event;
+	u32 rc_last_code;
+	unsigned long last_event_jiffies;
 #endif
 };
 
@@ -155,7 +156,7 @@ struct cinergyt2_rc_event {
 	uint32_t value;
 } __attribute__((packed));
 
-static const uint32_t rc_keys [] = {
+static const uint32_t rc_keys[] = {
 	CINERGYT2_RC_EVENT_TYPE_NEC,	0xfe01eb04,	KEY_POWER,
 	CINERGYT2_RC_EVENT_TYPE_NEC,	0xfd02eb04,	KEY_1,
 	CINERGYT2_RC_EVENT_TYPE_NEC,	0xfc03eb04,	KEY_2,
@@ -684,52 +685,68 @@ static struct dvb_device cinergyt2_fe_te
 #ifdef ENABLE_RC
 static void cinergyt2_query_rc (void *data)
 {
-	struct cinergyt2 *cinergyt2 = (struct cinergyt2 *) data;
-	char buf [1] = { CINERGYT2_EP1_GET_RC_EVENTS };
+	struct cinergyt2 *cinergyt2 = data;
+	char buf[1] = { CINERGYT2_EP1_GET_RC_EVENTS };
 	struct cinergyt2_rc_event rc_events[12];
-	int n, len;
+	int n, len, i;
 
 	if (down_interruptible(&cinergyt2->sem))
 		return;
 
 	len = cinergyt2_command(cinergyt2, buf, sizeof(buf),
-			     (char *) rc_events, sizeof(rc_events));
-
-	for (n=0; len>0 && n<(len/sizeof(rc_events[0])); n++) {
-		int i;
+				(char *) rc_events, sizeof(rc_events));
+	if (len < 0)
+		goto out;
+	if (len == 0) {
+		if (time_after(jiffies, cinergyt2->last_event_jiffies +
+			       msecs_to_jiffies(150))) {
+			/* stop key repeat */
+			if (cinergyt2->rc_input_event != KEY_MAX) {
+				dprintk(1, "rc_input_event=%d Up\n", cinergyt2->rc_input_event);
+				input_report_key(&cinergyt2->rc_input_dev,
+						 cinergyt2->rc_input_event, 0);
+				cinergyt2->rc_input_event = KEY_MAX;
+			}
+			cinergyt2->rc_last_code = ~0;
+		}
+		goto out;
+	}
+	cinergyt2->last_event_jiffies = jiffies;
 
-/*		dprintk(1,"rc_events[%d].value = %x, type=%x\n",n,le32_to_cpu(rc_events[n].value),rc_events[n].type);*/
+	for (n = 0; n < (len / sizeof(rc_events[0])); n++) {
+		dprintk(1, "rc_events[%d].value = %x, type=%x\n",
+			n, le32_to_cpu(rc_events[n].value), rc_events[n].type);
 
 		if (rc_events[n].type == CINERGYT2_RC_EVENT_TYPE_NEC &&
-		    rc_events[n].value == ~0)
-		{
-			/**
-			 * keyrepeat bit. If we would handle this properly
-			 * we would need to emit down events as long the
-			 * keyrepeat goes, a up event if no further
-			 * repeat bits occur. Would need a timer to implement
-			 * and no other driver does this, so we simply
-			 * emit the last key up/down sequence again.
-			 */
+		    rc_events[n].value == ~0) {
+			/* keyrepeat bit -> just repeat last rc_input_event */
 		} else {
 			cinergyt2->rc_input_event = KEY_MAX;
-			for (i=0; i<sizeof(rc_keys)/sizeof(rc_keys[0]); i+=3) {
-				if (rc_keys[i+0] == rc_events[n].type &&
-				    rc_keys[i+1] == le32_to_cpu(rc_events[n].value))
-				{
-					cinergyt2->rc_input_event = rc_keys[i+2];
+			for (i = 0; i < sizeof(rc_keys) / sizeof(rc_keys[0]); i += 3) {
+				if (rc_keys[i + 0] == rc_events[n].type &&
+				    rc_keys[i + 1] == le32_to_cpu(rc_events[n].value)) {
+					cinergyt2->rc_input_event = rc_keys[i + 2];
 					break;
 				}
 			}
 		}
 
 		if (cinergyt2->rc_input_event != KEY_MAX) {
-			input_report_key(&cinergyt2->rc_input_dev, cinergyt2->rc_input_event, 1);
-			input_report_key(&cinergyt2->rc_input_dev, cinergyt2->rc_input_event, 0);
-			input_sync(&cinergyt2->rc_input_dev);
+			if (rc_events[n].value == cinergyt2->rc_last_code &&
+			    cinergyt2->rc_last_code != ~0) {
+				/* emit a key-up so the double event is recognized */
+				dprintk(1, "rc_input_event=%d UP\n", cinergyt2->rc_input_event);
+				input_report_key(&cinergyt2->rc_input_dev,
+						 cinergyt2->rc_input_event, 0);
+			}
+			dprintk(1, "rc_input_event=%d\n", cinergyt2->rc_input_event);
+			input_report_key(&cinergyt2->rc_input_dev,
+					 cinergyt2->rc_input_event, 1);
+			cinergyt2->rc_last_code = rc_events[n].value;
 		}
 	}
 
+out:
 	schedule_delayed_work(&cinergyt2->rc_query_work,
 			      msecs_to_jiffies(RC_QUERY_INTERVAL));
 
@@ -771,7 +788,10 @@ static int cinergyt2_probe (struct usb_i
 		  const struct usb_device_id *id)
 {
 	struct cinergyt2 *cinergyt2;
-	int i, err;
+	int err;
+#ifdef ENABLE_RC
+	int i;
+#endif
 
 	if (!(cinergyt2 = kmalloc (sizeof(struct cinergyt2), GFP_KERNEL))) {
 		dprintk(1, "out of memory?!?\n");
@@ -827,19 +847,18 @@ static int cinergyt2_probe (struct usb_i
 			    DVB_DEVICE_FRONTEND);
 
 #ifdef ENABLE_RC
-	init_input_dev(&cinergyt2->rc_input_dev);
-
-	cinergyt2->rc_input_dev.evbit[0] = BIT(EV_KEY);
-	cinergyt2->rc_input_dev.keycodesize = sizeof(unsigned char);
-	cinergyt2->rc_input_dev.keycodemax = KEY_MAX;
+	cinergyt2->rc_input_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	cinergyt2->rc_input_dev.keycodesize = 0;
+	cinergyt2->rc_input_dev.keycodemax = 0;
 	cinergyt2->rc_input_dev.name = DRIVER_NAME " remote control";
 
-	for (i=0; i<sizeof(rc_keys)/sizeof(rc_keys[0]); i+=3)
-		set_bit(rc_keys[i+2], cinergyt2->rc_input_dev.keybit);
+	for (i = 0; i < sizeof(rc_keys) / sizeof(rc_keys[0]); i += 3)
+		set_bit(rc_keys[i + 2], cinergyt2->rc_input_dev.keybit);
 
 	input_register_device(&cinergyt2->rc_input_dev);
 
 	cinergyt2->rc_input_event = KEY_MAX;
+	cinergyt2->rc_last_code = ~0;
 
 	INIT_WORK(&cinergyt2->rc_query_work, cinergyt2_query_rc, cinergyt2);
 	schedule_delayed_work(&cinergyt2->rc_query_work, HZ/2);

--

