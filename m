Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbULRBVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbULRBVS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 20:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbULRBVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 20:21:18 -0500
Received: from mail.portrix.net ([212.202.157.208]:54943 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262806AbULRBVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 20:21:11 -0500
Message-ID: <41C385FC.3010109@ppp0.net>
Date: Sat, 18 Dec 2004 02:21:00 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@verizon.net>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] esp: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
References: <20041217231915.14919.49991.15433@localhost.localdomain>
In-Reply-To: <20041217231915.14919.49991.15433@localhost.localdomain>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
> This is an attempt to make the esp driver SMP-correct.

You're trying to protect the info data, correct? Could you please
add a comment to the locks which data structures need to be
protected by them?!
Just blindly replacing cli/sti with spin_(un)lock doesn't make it
SMP save.

> diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/esp.c linux-2.6.10-rc3-mm1/drivers/char/esp.c
> --- linux-2.6.10-rc3-mm1-original/drivers/char/esp.c	2004-12-03 16:52:13.000000000 -0500
> +++ linux-2.6.10-rc3-mm1/drivers/char/esp.c	2004-12-17 18:11:31.275037730 -0500
> @@ -212,14 +214,14 @@
>  	if (serial_paranoia_check(info, tty->name, "rs_stop"))
>  		return;
>  	
> -	save_flags(flags); cli();
> +	spin_lock_irqsave(&esp_lock, flags);

info can change between return and lock

>  	if (info->IER & UART_IER_THRI) {
>  		info->IER &= ~UART_IER_THRI;
>  		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
>  		serial_out(info, UART_ESI_CMD2, info->IER);
>  	}
>  
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&esp_lock, flags);
>  }
>  
>  static void rs_start(struct tty_struct *tty)
> @@ -230,13 +232,13 @@
>  	if (serial_paranoia_check(info, tty->name, "rs_start"))
>  		return;
>  	
> -	save_flags(flags); cli();
> +	spin_lock_irqsave(&esp_lock, flags);

same here.

>  	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
>  		info->IER |= UART_IER_THRI;
>  		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
>  		serial_out(info, UART_ESI_CMD2, info->IER);
>  	}
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&esp_lock, flags);
>  }
>  
>  /*

Didn't read the rest. Are you sure you didn't introduce a deadlock in
the interrupt handler? {transmit,receiver}_chars_{pio,dma} also try to take
the lock.

Jan
