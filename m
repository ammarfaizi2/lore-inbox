Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWGLTBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWGLTBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWGLTBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:01:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:62819 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWGLTBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:01:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=b7Z0+MrpNb2thOARIliaWbSuqUaNj35qavF0lPVnNw8wJI6y1dVZt6aAxJkNLocAQBLmyZ/Wn1beOEUdXuir34p8uN2HtXF4GkplxdJsH/tKYROQOVqCpAb9UBal+ZVfPjRCtjtEp37zM/dEm/P12JYR9u6tEvXA1O2KO4nbft4=
Message-ID: <44B546EF.8050809@gmail.com>
Date: Wed, 12 Jul 2006 13:01:03 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Chris Boot <bootc@bootc.net>
Subject: [rfc-patch 01/01]  leds-48xx:  unnecessary extern decl is needed
 !?
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in the following patch, this extern decl is necessary.

+//extern struct nsc_gpio_ops scx200_gpio_ops;

Because its commented out, I get this error:

CC [M] drivers/leds/leds-net48xx.o
drivers/leds/leds-net48xx.c: In function ‘net48xx_error_led_set’:
drivers/leds/leds-net48xx.c:31: error: ‘scx200_gpio_ops’ undeclared 
(first use in this function)
drivers/leds/leds-net48xx.c:31: error: (Each undeclared identifier is 
reported only once
drivers/leds/leds-net48xx.c:31: error: for each function it appears in.)
make[2]: *** [drivers/leds/leds-net48xx.o] Error 1
make[1]: *** [drivers/leds] Error 2
make: *** [drivers] Error 2


Shouldnt EXPORT_SYMBOL(scx200_gpio_ops) prevent exactly that ?
On a SWAG, I removed 'static' from the 2 vtables, this made no 
difference (as I expected)
With the // removed, it builds fine and works.
What have I missed ?
What search terms would have found previous cases ?


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

$ diffstat diff.leds-nsc-gpio
 leds-net48xx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs x-2/drivers/leds/leds-net48xx.c x-led/drivers/leds/leds-net48xx.c
--- x-2/drivers/leds/leds-net48xx.c	2006-07-09 10:38:00.000000000 -0600
+++ x-led/drivers/leds/leds-net48xx.c	2006-07-11 13:22:54.000000000 -0600
@@ -15,8 +15,11 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/err.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/scx200_gpio.h>
+#include <linux/nsc_gpio.h>
+
+//extern struct nsc_gpio_ops scx200_gpio_ops;
 
 #define NET48XX_ERROR_LED_GPIO	20
 
@@ -25,10 +28,7 @@ static struct platform_device *pdev;
 static void net48xx_error_led_set(struct led_classdev *led_cdev,
 		enum led_brightness value)
 {
-	if (value)
-		scx200_gpio_set_high(NET48XX_ERROR_LED_GPIO);
-	else
-		scx200_gpio_set_low(NET48XX_ERROR_LED_GPIO);
+	scx200_gpio_ops.gpio_set(NET48XX_ERROR_LED_GPIO, value);
 }
 
 static struct led_classdev net48xx_error_led = {



