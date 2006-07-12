Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWGLTQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWGLTQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGLTQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:16:50 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:39090 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1750808AbWGLTQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:16:49 -0400
Message-ID: <44B54A9D.5000802@bootc.net>
Date: Wed, 12 Jul 2006 20:16:45 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc-patch 01/01]  leds-48xx:  unnecessary extern decl is needed
 !?
References: <44B546EF.8050809@gmail.com>
In-Reply-To: <44B546EF.8050809@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
> 
> in the following patch, this extern decl is necessary.
> 
> +//extern struct nsc_gpio_ops scx200_gpio_ops;
> 
> Because its commented out, I get this error:
> 
> CC [M] drivers/leds/leds-net48xx.o
> drivers/leds/leds-net48xx.c: In function ‘net48xx_error_led_set’:
> drivers/leds/leds-net48xx.c:31: error: ‘scx200_gpio_ops’ undeclared 
> (first use in this function)
> drivers/leds/leds-net48xx.c:31: error: (Each undeclared identifier is 
> reported only once
> drivers/leds/leds-net48xx.c:31: error: for each function it appears in.)
> make[2]: *** [drivers/leds/leds-net48xx.o] Error 1
> make[1]: *** [drivers/leds] Error 2
> make: *** [drivers] Error 2
> 
> 
> Shouldnt EXPORT_SYMBOL(scx200_gpio_ops) prevent exactly that ?
> On a SWAG, I removed 'static' from the 2 vtables, this made no 
> difference (as I expected)
> With the // removed, it builds fine and works.
> What have I missed ?
> What search terms would have found previous cases ?

Well, it wouldn't work without EXPORT_SYMBOL either (probably should be 
EXPORT_SYMBOL_GPL these days too) but you need to declare it one place or 
another or the compiler doesn't know it exists at all! This should ideally be in 
scx200_gpio.h but I was too lazy to add it! :-P

Just add that line to the header and all will be well. Looks good otherwise.

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
> ---
> 
> $ diffstat diff.leds-nsc-gpio
> leds-net48xx.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> diff -ruNp -X dontdiff -X exclude-diffs x-2/drivers/leds/leds-net48xx.c 
> x-led/drivers/leds/leds-net48xx.c
> --- x-2/drivers/leds/leds-net48xx.c    2006-07-09 10:38:00.000000000 -0600
> +++ x-led/drivers/leds/leds-net48xx.c    2006-07-11 13:22:54.000000000 
> -0600
> @@ -15,8 +15,11 @@
> #include <linux/platform_device.h>
> #include <linux/leds.h>
> #include <linux/err.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
> #include <linux/scx200_gpio.h>
> +#include <linux/nsc_gpio.h>
> +
> +//extern struct nsc_gpio_ops scx200_gpio_ops;
> 
> #define NET48XX_ERROR_LED_GPIO    20
> 
> @@ -25,10 +28,7 @@ static struct platform_device *pdev;
> static void net48xx_error_led_set(struct led_classdev *led_cdev,
>         enum led_brightness value)
> {
> -    if (value)
> -        scx200_gpio_set_high(NET48XX_ERROR_LED_GPIO);
> -    else
> -        scx200_gpio_set_low(NET48XX_ERROR_LED_GPIO);
> +    scx200_gpio_ops.gpio_set(NET48XX_ERROR_LED_GPIO, value);
> }
> 
> static struct led_classdev net48xx_error_led = {
> 
> 
> 

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
