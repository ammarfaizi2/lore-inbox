Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUL2HsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUL2HsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUL2Hmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:42:38 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:19375 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261430AbUL2Hd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 11/16] Use msecs_to_jiffies in input core
Date: Wed, 29 Dec 2004 02:28:12 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290226.37664.dtor_core@ameritech.net> <200412290227.39294.dtor_core@ameritech.net>
In-Reply-To: <200412290227.39294.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290228.14155.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1971, 2004-12-28 00:47:11-05:00, dtor_core@ameritech.net
  Input: use msecs_to_jiffies instead of homegrown ms_to_jiffies
         when setting timer for autorepeat handling. This will
         make sure that autorepeat is scheduled correctly when
         HZ != 1000.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 input.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2004-12-29 01:51:20 -05:00
+++ b/drivers/input/input.c	2004-12-29 01:51:20 -05:00
@@ -54,14 +54,6 @@
 static int input_devices_state;
 #endif
 
-static inline unsigned int ms_to_jiffies(unsigned int ms)
-{
-        unsigned int j;
-        j = (ms * HZ + 500) / 1000;
-        return (j > 0) ? j : 1;
-}
-
-
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct input_handle *handle;
@@ -96,9 +88,9 @@
 
 			change_bit(code, dev->key);
 
-			if (test_bit(EV_REP, dev->evbit) && dev->rep[REP_PERIOD] && dev->timer.data && value) {
+			if (test_bit(EV_REP, dev->evbit) && dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] && dev->timer.data && value) {
 				dev->repeat_key = code;
-				mod_timer(&dev->timer, jiffies + ms_to_jiffies(dev->rep[REP_DELAY]));
+				mod_timer(&dev->timer, jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]));
 			}
 
 			break;
@@ -198,7 +190,8 @@
 	input_event(dev, EV_KEY, dev->repeat_key, 2);
 	input_sync(dev);
 
-	mod_timer(&dev->timer, jiffies + ms_to_jiffies(dev->rep[REP_PERIOD]));
+	if (dev->rep[REP_PERIOD])
+		mod_timer(&dev->timer, jiffies + msecs_to_jiffies(dev->rep[REP_PERIOD]));
 }
 
 int input_accept_process(struct input_handle *handle, struct file *file)
