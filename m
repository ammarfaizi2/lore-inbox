Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWGOSnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWGOSnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 14:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWGOSnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 14:43:09 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:16004 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751367AbWGOSnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 14:43:08 -0400
Message-ID: <44B9373A.7020408@bootc.net>
Date: Sat, 15 Jul 2006 19:43:06 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the next48xx LED code use scx200_gpio_ops instead of raw SCx200 GPIO accesses.

Signed-off-by: Chris Boot <bootc@bootc.net>

diff --git a/drivers/leds/leds-net48xx.c b/drivers/leds/leds-net48xx.c
index 713c4a8..45ba3d4 100644
--- a/drivers/leds/leds-net48xx.c
+++ b/drivers/leds/leds-net48xx.c
@@ -16,6 +16,7 @@
  #include <linux/leds.h>
  #include <linux/err.h>
  #include <asm/io.h>
+#include <linux/nsc_gpio.h>
  #include <linux/scx200_gpio.h>

  #define DRVNAME "net48xx-led"
@@ -26,10 +27,7 @@ static struct platform_device *pdev;
  static void net48xx_error_led_set(struct led_classdev *led_cdev,
  		enum led_brightness value)
  {
-	if (value)
-		scx200_gpio_set_high(NET48XX_ERROR_LED_GPIO);
-	else
-		scx200_gpio_set_low(NET48XX_ERROR_LED_GPIO);
+	scx200_gpio_ops.gpio_set(NET48XX_ERROR_LED_GPIO, value ? 1 : 0);
  }

  static struct led_classdev net48xx_error_led = {
@@ -81,7 +79,8 @@ static int __init net48xx_led_init(void)
  {
  	int ret;

-	if (!scx200_gpio_present()) {
+	/* small hack, but scx200_gpio doesn't set .dev if the probe fails */
+	if (!scx200_gpio_ops.dev) {
  		ret = -ENODEV;
  		goto out;
  	}


-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
