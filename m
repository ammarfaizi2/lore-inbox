Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTIDWwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTIDWwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:52:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23504 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262201AbTIDWv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:51:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 5 Sep 2003 00:51:54 +0200 (MEST)
Message-Id: <UTC200309042251.h84MpsX07601.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add_mouse_randomness
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know whether anybody cares, but the random driver
is a little bit broken these days.

Long ago:
Keystrokes cause randomness added via add_keyboard_randomness.
Mouse movements cause randomness added via add_mouse_randomness.
Key repeat does not add randomness.

Today:
Every keypress and every key release causes two calls of
add_mouse_randomness and one call of add_keyboard_randomness.
Key repeat causes lots of calls of add_mouse_randomness.

The random driver contains a mechanism (delta, delta2, delta3)
for estimating the amount of entropy in a stream of moments in
time. But the fact that every event causes two calls, very
quickly after each other, poisons this mechanism, and makes us
overestimate.

I think it would be better to do something like the below.

Andries


[Note that the data in the call to add-X-randomness hardly matters.
Accounted entropy comes from timing only.]


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sat Aug 23 13:30:03 2003
+++ b/drivers/input/input.c	Thu Sep  4 23:51:25 2003
@@ -15,7 +15,6 @@
 #include <linux/smp_lock.h>
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/random.h>
 #include <linux/major.h>
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
@@ -66,8 +65,6 @@
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
-	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
-
 	switch (type) {
 
 		case EV_SYN:
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Mon Jun 23 04:43:33 2003
+++ b/drivers/input/mouse/psmouse-base.c	Thu Sep  4 23:51:57 2003
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <linux/random.h>
 #include <linux/init.h>
 #include "psmouse.h"
 #include "synaptics.h"
@@ -139,6 +140,9 @@
 	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
 
+	if (psmouse->pktcnt == 1)
+		add_mouse_randomness(data);
+
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
 		psmouse_process_packet(psmouse, regs);
 		psmouse->pktcnt = 0;
