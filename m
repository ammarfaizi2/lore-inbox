Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936707AbWLCOZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936707AbWLCOZT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 09:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936705AbWLCOZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 09:25:18 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:25488 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S935231AbWLCOZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 09:25:17 -0500
X-Sasl-enc: CtqrkHNPGAh2u3YdAyJbXw+q4CBwY4SvR+BX9rxZuUx0 1165155916
Date: Sun, 3 Dec 2006 12:24:52 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] backlight: do not power off backlight when unregistering (try 3)
Message-ID: <20061203142452.GA23662@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sieve: CMU Sieve 2.3
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI drivers like ibm-acpi are moving to the backlight sysfs infrastructure.
During ibm-acpi testing, I have noticed that backlight_device_unregister()
sets the display brightness and power to zero.

This causes the display to be dimmed on ibm-acpi module removal.  It will
affect all other ACPI drivers that are being converted to use the backlight
class, as well.  It also affects a number of framebuffer devices that are
used on desktops and laptops which might also not want such behaviour.

Since working around this behaviour requires undesireable hacks, Richard
Purdie decided that we would be better off reverting the changes in the
sysfs class, and adding the code to dim and power off the backlight device
to the drivers that want it.  This patch is my attempt to do so.

Patch against latest linux-2.6.git.  Changes untested, as I lack the
required hardware.  Still, they are trivial enough that, apart from typos,
there is little chance of getting them wrong.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Pavel Machek <pavel@ucw.cz>
---

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..de5a6b3 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -259,12 +259,6 @@ void backlight_device_unregister(struct
 					 &bl_class_device_attributes[i]);
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->update_status)) {
-		bd->props->brightness = 0;
-		bd->props->power = 0;
-		bd->props->update_status(bd);
-	}
-
 	bd->props = NULL;
 	up(&bd->sem);
 
diff --git a/drivers/video/backlight/corgi_bl.c b/drivers/video/backlight/corgi_bl.c
index d07ecb5..61587ca 100644
--- a/drivers/video/backlight/corgi_bl.c
+++ b/drivers/video/backlight/corgi_bl.c
@@ -135,6 +135,10 @@ static int corgibl_probe(struct platform
 
 static int corgibl_remove(struct platform_device *dev)
 {
+	corgibl_data.power = 0;
+	corgibl_data.brightness = 0;
+	corgibl_send_intensity(corgi_backlight_device);
+
 	backlight_device_unregister(corgi_backlight_device);
 
 	printk("Corgi Backlight Driver Unloaded\n");
diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index e399321..1c569fb 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -117,6 +117,10 @@ static int __init hp680bl_probe(struct p
 
 static int hp680bl_remove(struct platform_device *dev)
 {
+	hp680bl_data.brightness = 0;
+	hp680bl_data.power = 0;
+	hp680bl_send_intensity(hp680_backlight_device);
+
 	backlight_device_unregister(hp680_backlight_device);
 
 	return 0;
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 628571c..2d79054 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -200,6 +200,10 @@ static int locomolcd_remove(struct locom
 {
 	unsigned long flags;
 
+	locomobl_data.brightness = 0;
+	locomobl_data.power = 0;
+	locomolcd_set_intensity(locomolcd_bl_device);
+
 	backlight_device_unregister(locomolcd_bl_device);
 	local_irq_save(flags);
 	locomolcd_dev = NULL;

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
