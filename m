Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVKIKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVKIKwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVKIKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:52:17 -0500
Received: from adsl-71-133-204-141.dsl.pltn13.pacbell.net ([71.133.204.141]:58848
	"EHLO mail.teloric.net") by vger.kernel.org with ESMTP
	id S1030433AbVKIKwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:52:17 -0500
Message-ID: <4371D4E0.50901@krellan.com>
Date: Wed, 09 Nov 2005 02:52:16 -0800
From: JoSH Lehan <krellan@krellan.com>
Organization: Dementites And Dementoids
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: psmouse: Patch to reset when lost synchronization throwing bytes
 away
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have made a quick patch for psmouse, that solves a problem I have had
with certain KVM switches.

Windows XP is surprisingly decent at resetting the mouse when an error
or desynchronization occurs.  This seems like an acceptable recovery
strategy, as the only drawback will be loss of mouse responsiveness for
0.5 seconds or so.

In Linux, however, the psmouse driver will clear the buffer but not do
a reset.  This doesn't solve the problem, as the block boundaries have
already been lost and any mouse input will be seen as garbage data.
The result is the infamous "teleporting mouse" bug, where the mouse
pointer jumps around the screen and phantom button presses start
happening.  In this age of GUI context menus for right-clicks, Bad
Things can start to happen very easily, resulting in *much* user
frustration....

The workaround now is to switch to a text-only VC, become root, rmmod
psmouse, and modprobe psmouse again.  This patch makes this behaviour
happen automatically, by asking the mouse to reset itself when the
driver detects a loss of synchronization.


diff -urN OLD-linux-source-2.6.12/drivers/input/mouse/psmouse-base.c NEW-linux-source-2.6.12/drivers/input/mouse/psmouse-base.c
--- OLD-linux-source-2.6.12/drivers/input/mouse/psmouse-base.c	2005-06-17 12:48:29.000000000 -0700
+++ NEW-linux-source-2.6.12/drivers/input/mouse/psmouse-base.c	2005-11-08 03:36:46.000000000 -0800
@@ -175,9 +175,14 @@

  	if (psmouse->state == PSMOUSE_ACTIVATED &&
  	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
+		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away and resetting.\n",
  		       psmouse->name, psmouse->phys, psmouse->pktcnt);
  		psmouse->pktcnt = 0;
+
+		/* linux@krellan.com: Now resetting the mouse when this happens, in order to avoid continuing with garbaged input */
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->ps2dev.serio);
+		goto out;
  	}

  	psmouse->last = jiffies;


Opinions/comments on this?

Thanks!
Josh

