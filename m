Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVLIOau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVLIOau (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVLIOau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:30:50 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:39054 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932136AbVLIOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:30:49 -0500
Subject: [PATCH 29/56] DVB (2390) Adds a time-delay to IR remote button
	presses for av7110 ir input,
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       akpm@osdl.org, linux-dvb-maintainer@linuxtv.org,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 12:16:52 -0200
Message-Id: <1134137813.10677.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noone Important <nxhxzi702 at sneakemail.com>

- Adds a time-delay to IR remote button presses for av7110_ir input,
such that it acts more like a keyboard. A short press will be treated
as a single button press. Holding down a button on the remote will
respond like holding down a key on the keyboard, and result in a
key-repeat. This just introduces a delay between the 1st press, and
going into key-repeat so that it is possible to get a single 'up'.

Signed-off-by: Noone Important <nxhxzi702 at sneakemail.com>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/dvb/ttpci/av7110_ir.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- git.orig/drivers/media/dvb/ttpci/av7110_ir.c
+++ git/drivers/media/dvb/ttpci/av7110_ir.c
@@ -17,6 +17,8 @@ static int av_cnt;
 static struct av7110 *av_list[4];
 static struct input_dev *input_dev;
 
+static u8 delay_timer_finished;
+
 static u16 key_map [256] = {
 	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7,
 	KEY_8, KEY_9, KEY_BACK, 0, KEY_POWER, KEY_MUTE, 0, KEY_INFO,
@@ -112,13 +114,16 @@ static void av7110_emit_key(unsigned lon
 	if (timer_pending(&keyup_timer)) {
 		del_timer(&keyup_timer);
 		if (keyup_timer.data != keycode || new_toggle != old_toggle) {
+			delay_timer_finished = 0;
 			input_event(input_dev, EV_KEY, keyup_timer.data, !!0);
 			input_event(input_dev, EV_KEY, keycode, !0);
 		} else
-			input_event(input_dev, EV_KEY, keycode, 2);
-
-	} else
+			if (delay_timer_finished)
+				input_event(input_dev, EV_KEY, keycode, 2);
+	} else {
+		delay_timer_finished = 0;
 		input_event(input_dev, EV_KEY, keycode, !0);
+	}
 
 	keyup_timer.expires = jiffies + UP_TIMEOUT;
 	keyup_timer.data = keycode;
@@ -145,7 +150,8 @@ static void input_register_keys(void)
 
 static void input_repeat_key(unsigned long data)
 {
-       /* dummy routine to disable autorepeat in the input driver */
+	/* called by the input driver after rep[REP_DELAY] ms */
+	delay_timer_finished = 1;
 }
 


