Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVLKQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVLKQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVLKQId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:08:33 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:2516 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750733AbVLKQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:08:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2: evdev problem
Date: Sun, 11 Dec 2005 17:02:08 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
References: <20051211041308.7bb19454.akpm@osdl.org> <200512111647.31202.rjw@sisk.pl>
In-Reply-To: <200512111647.31202.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512111702.08556.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The evdev driver is still broken due to the wrong order of arguments of
copy_to_user() in evdev_event_to_user().

The following patch fixes this issue.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Index: linux-2.6.15-rc2-mm1/drivers/input/evdev.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/drivers/input/evdev.c	2005-11-23 22:07:30.000000000 +0100
+++ linux-2.6.15-rc2-mm1/drivers/input/evdev.c	2005-11-26 17:38:02.000000000 +0100
@@ -194,7 +194,7 @@
 	return 0;
 }
 
-static int evdev_event_to_user(const char __user *buffer, struct input_event *event)
+static int evdev_event_to_user(char __user *buffer, struct input_event *event)
 {
 	if (COMPAT_TEST) {
 		struct input_event_compat compat_event;
@@ -205,11 +205,11 @@
 		compat_event.code = event->code;
 		compat_event.value = event->value;
 
-		if (copy_to_user(&compat_event, buffer, sizeof(struct input_event_compat)))
+		if (copy_to_user(buffer, &compat_event, sizeof(struct input_event_compat)))
 			return -EFAULT;
 
 	} else {
-		if (copy_to_user(event, buffer, sizeof(struct input_event)))
+		if (copy_to_user(buffer, event, sizeof(struct input_event)))
 			return -EFAULT;
 	}
 

