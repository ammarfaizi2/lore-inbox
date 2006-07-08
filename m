Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWGHOQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWGHOQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGHOQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:16:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:14280 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964851AbWGHOQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:16:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Aphf+g47yEJJ5+nJalCaAIps1UuVfqw9m3RENr54z7qp1gjd0gqR3gxv7bssqOlvXZa5sExvn4VRUpi/KRoIXAYiXc/sE0GcX0HEaFEzZJW+ze8HggELVybS53BqmAYIosPBDXlSkATcscfEyDQz2bkdMciWiSXSCZD9ZDhzKqU=
Message-ID: <44AFBE47.6070400@gmail.com>
Date: Sat, 08 Jul 2006 08:16:39 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patchset 1/3 -2.6.18-rc1]  pc8736x_gpio:  fix re-modprobe errors
 - define and use constants
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AFBCB5.4040409@gmail.com>
In-Reply-To: <44AFBCB5.4040409@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1 - add constant defines - preparatory patch

- adds #define CONSTs  for max-pin,  gpio-addr-range (for reserving region)
- fix wrong max-pin check in gpio_open()
- add 'Winbond' to module description.  NSC sold the product, Winbond 
has supported us / lm-sensors

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>

$ diffstat fxd1/pc-const-rollup
 pc8736x_gpio.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs x4h-0/drivers/char/pc8736x_gpio.c x4h-1/drivers/char/pc8736x_gpio.c
--- x4h-0/drivers/char/pc8736x_gpio.c	2006-07-06 13:19:16.000000000 -0600
+++ x4h-1/drivers/char/pc8736x_gpio.c	2006-07-07 16:59:14.000000000 -0600
@@ -25,7 +25,7 @@
 #define DEVNAME "pc8736x_gpio"
 
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
-MODULE_DESCRIPTION("NatSemi PC-8736x GPIO Pin Driver");
+MODULE_DESCRIPTION("NatSemi/Winbond PC-8736x GPIO Pin Driver");
 MODULE_LICENSE("GPL");
 
 static int major;		/* default to dynamic major */
@@ -38,14 +38,14 @@ static u8 pc8736x_gpio_shadow[4];
 
 #define SIO_BASE1       0x2E	/* 1st command-reg to check */
 #define SIO_BASE2       0x4E	/* alt command-reg to check */
-#define SIO_BASE_OFFSET 0x20
 
 #define SIO_SID		0x20	/* SuperI/O ID Register */
 #define SIO_SID_VALUE	0xe9	/* Expected value in SuperI/O ID Register */
 
 #define SIO_CF1		0x21	/* chip config, bit0 is chip enable */
 
-#define PC8736X_GPIO_SIZE	16
+#define PC8736X_GPIO_RANGE	16 /* ioaddr range */
+#define PC8736X_GPIO_CT		32 /* minors matching 4 8 bit ports */
 
 #define SIO_UNIT_SEL	0x7	/* unit select reg */
 #define SIO_UNIT_ACT	0x30	/* unit enable */
@@ -231,7 +231,7 @@ static int pc8736x_gpio_open(struct inod
 
 	dev_dbg(&pdev->dev, "open %d\n", m);
 
-	if (m > 63)
+	if (m >= PC8736X_GPIO_CT)
 		return -EINVAL;
 	return nonseekable_open(inode, file);
 }
@@ -297,7 +297,7 @@ static int __init pc8736x_gpio_init(void
 	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
 			     | superio_inb(SIO_BASE_LADDR));
 
-	if (!request_region(pc8736x_gpio_base, 16, DEVNAME)) {
+	if (!request_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE, DEVNAME)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
 			pc8736x_gpio_base);


