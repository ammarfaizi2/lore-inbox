Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWD2LeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWD2LeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 07:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWD2LeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 07:34:08 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:32489 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751868AbWD2LeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 07:34:07 -0400
Subject: led_class: storing a value can act but return -EINVAL
From: Johannes Berg <johannes@sipsolutions.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
Content-Type: text/plain
Date: Sat, 29 Apr 2006 13:33:52 +0200
Message-Id: <1146310432.5019.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I store something into the brightness sysfs attribute of an LED, it
will accept the value but return -EINVAL:

johannes:/sys/class/leds/pmu-front-led# echo 255 > brightness
bash: echo: write error: Invalid argument

(yet the LED turns on)

This happens because the store callback doesn't consume all the input.

There are two possible ways to handle this:
a) accept anything that begins with a valid number.
b) reject anything that isn't *only* a number

The following patch implements a), for b) you'd have to make the if
statement have ' && after-buf == size' instead of this patch.

I don't know which approach is generally preferred, but acting and then
returning an error value doesn't seem nice.
Maybe b) should be implemented instead to stop people from storing
things like '0 hahaha stupid kernel ignores this' into the attribute :)

johannes

--- linux-2.6.orig/drivers/leds/led-class.c	2006-04-29 13:23:49.013288994 +0200
+++ linux-2.6/drivers/leds/led-class.c	2006-04-29 13:28:14.183288994 +0200
@@ -45,7 +45,7 @@ static ssize_t led_brightness_store(stru
 	unsigned long state = simple_strtoul(buf, &after, 10);
 
 	if (after - buf > 0) {
-		ret = after - buf;
+		ret = size;
 		led_set_brightness(led_cdev, state);
 	}
 


