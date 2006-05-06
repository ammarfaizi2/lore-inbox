Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEFLNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEFLNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWEFLNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:13:14 -0400
Received: from tim.rpsys.net ([194.106.48.114]:21456 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750769AbWEFLMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:12:55 -0400
Subject: [PATCH] LED: Fix sysfs store function error handling
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Sat, 06 May 2006 12:12:36 +0100
Message-Id: <1146913956.6237.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error handling of some LED _store functions. This corrects them
to return -EINVAL if the value is not numeric with an optional byte of 
trailing whitespace.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/leds/led-class.c
===================================================================
--- git.orig/drivers/leds/led-class.c	2006-05-04 23:12:57.000000000 +0100
+++ git/drivers/leds/led-class.c	2006-05-06 11:01:04.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/sysdev.h>
 #include <linux/timer.h>
 #include <linux/err.h>
+#include <linux/ctype.h>
 #include <linux/leds.h>
 #include "leds.h"
 
@@ -43,9 +44,13 @@
 	ssize_t ret = -EINVAL;
 	char *after;
 	unsigned long state = simple_strtoul(buf, &after, 10);
+	size_t count = after - buf;
 
-	if (after - buf > 0) {
-		ret = after - buf;
+	if (*after && isspace(*after))
+		count++;
+
+	if (count == size) {
+		ret = count;
 		led_set_brightness(led_cdev, state);
 	}
 
Index: git/drivers/leds/ledtrig-timer.c
===================================================================
--- git.orig/drivers/leds/ledtrig-timer.c	2006-05-04 23:12:57.000000000 +0100
+++ git/drivers/leds/ledtrig-timer.c	2006-05-06 11:01:42.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/ctype.h>
 #include <linux/leds.h>
 #include "leds.h"
 
@@ -69,11 +70,15 @@
 	int ret = -EINVAL;
 	char *after;
 	unsigned long state = simple_strtoul(buf, &after, 10);
+	size_t count = after - buf;
 
-	if (after - buf > 0) {
+	if (*after && isspace(*after))
+		count++;
+
+	if (count == size) {
 		timer_data->delay_on = state;
 		mod_timer(&timer_data->timer, jiffies + 1);
-		ret = after - buf;
+		ret = count;
 	}
 
 	return ret;
@@ -97,11 +102,15 @@
 	int ret = -EINVAL;
 	char *after;
 	unsigned long state = simple_strtoul(buf, &after, 10);
+	size_t count = after - buf;
+
+	if (*after && isspace(*after))
+		count++;
 
-	if (after - buf > 0) {
+	if (count == size) {
 		timer_data->delay_off = state;
 		mod_timer(&timer_data->timer, jiffies + 1);
-		ret = after - buf;
+		ret = count;
 	}
 
 	return ret;


