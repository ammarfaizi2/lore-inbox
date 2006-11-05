Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWKEWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWKEWyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWKEWyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:54:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40068 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1422795AbWKEWyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:54:37 -0500
X-Sasl-enc: uGJ5W1FqdKTtvfwPZ19l6jnSZ1sN2G3YsUllg+Pxxj/b 1162767276
Date: Sun, 5 Nov 2006 20:54:29 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>, Antonino Daplas <adaplas@pol.net>,
       Holger Macht <hmacht@suse.de>
Subject: [PATCH] backlight: do not power off backlight when unregistering
Message-ID: <20061105225429.GE14295@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI drivers like ibm-acpi are moving to the backlight sysfs infrastructure.
During ibm-acpi testing, I have noticed that backlight_device_unregister()
sets the display brightness and power to zero.

This causes the display to be dimmed on ibm-acpi module removal.  It will
affect all other ACPI drivers that are being converted to use the backlight
class, as well.

This annoying behaviour in backlight_device_unregister() can either be
reverted, or it can be worked around on acpi drivers by doing a
backlightdevice->props->update_status = NULL before calling
backlight_device_unregister().

Given the, AFAIK, lack of a good reason to disable display backlight as the
_general_ behaviour for the entire sysfs class, the attached patch changes
backlight.c to not do so anymore.

Since the commit that introduced this behaviour (commit
6ca017658b1f902c9bba2cc1017e301581f7728d) apparently did so because the
corgi_bl.c driver powered off the backlight, the attached patch also makes
sure that the corgi_bl.c driver will not have its behaviour changed.

Patch against latest linux-2.6.git.  corgi_bl.c changes untested, as I lack
the hardware to do so.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
--

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

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
