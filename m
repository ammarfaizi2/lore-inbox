Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbULaJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbULaJqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbULaJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:46:06 -0500
Received: from mail.portrix.net ([212.202.157.208]:27274 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261829AbULaJpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:45:53 -0500
Message-ID: <41D51FBA.2040002@ppp0.net>
Date: Fri, 31 Dec 2004 10:45:30 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@verizon.net>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] esp: Make driver SMP-correct
References: <20041231014403.3309.58245.96163@localhost.localdomain>
In-Reply-To: <20041231014403.3309.58245.96163@localhost.localdomain>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
>  static inline int serial_paranoia_check(struct esp_struct *info,
>  					char *name, const char *routine)
>  {
> @@ -209,34 +197,38 @@
>  	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
>  	unsigned long flags;
>  
> -	if (serial_paranoia_check(info, tty->name, "rs_stop"))
> -		return;
> +	spin_lock_irqsave(&info->irq_lock, flags);
> +
> +	if (unlikely(serial_paranoia_check(info, tty->name, __FUNCTION__)))
> +		goto out;

>  static void rs_start(struct tty_struct *tty)
>  {
>  	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
>  	unsigned long flags;
> -	
> -	if (serial_paranoia_check(info, tty->name, "rs_start"))
> -		return;
> -	
> -	save_flags(flags); cli();
> +
> +	spin_lock_irqsave(&info->irq_lock, flags);
> +
> +	if (unlikely(serial_paranoia_check(info, tty->name, __FUNCTION__)))
> +		goto out;
> +

This will deadlock. serial_paranoia_check also unconditionally tries to
take the lock.

Jan
