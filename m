Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbULRA7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbULRA7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbULRA7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:59:23 -0500
Received: from mail.portrix.net ([212.202.157.208]:15518 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261338AbULRA7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:59:16 -0500
Message-ID: <41C380D0.9020001@ppp0.net>
Date: Sat, 18 Dec 2004 01:58:56 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@verizon.net>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] lcd: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
References: <20041217235927.17998.75228.61750@localhost.localdomain>
In-Reply-To: <20041217235927.17998.75228.61750@localhost.localdomain>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
> Remove the cli()/sti() calls in drivers/char/lcd.c

Why is this cli() there in the first place? ioctl is already
called under lock_kernel.

> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c linux-2.6.10-rc3-mm1/drivers/char/lcd.c
> --- linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c	2004-12-03 16:53:42.000000000 -0500
> +++ linux-2.6.10-rc3-mm1/drivers/char/lcd.c	2004-12-17 18:57:10.760197439 -0500
> @@ -33,6 +33,8 @@
>  
>  #include "lcd.h"
>  
> +static spinlock_t lcd_lock = SPIN_LOCK_UNLOCKED;
> +
>  static int lcd_ioctl(struct inode *inode, struct file *file,
>  		     unsigned int cmd, unsigned long arg);
>  
> @@ -464,14 +466,13 @@
>  			}
>  
>  			printk("Churning and Burning -");
> -			save_flags(flags);
>  			for (i = 0; i < FLASH_SIZE; i = i + 128) {
>  
>  				if (copy_from_user
>  				    (rom, display.RomImage + i, 128))
>  					return -EFAULT;

The driver is leaking memory, rom is not freed in this case.

Jan
