Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEaWa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEaWa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVEaW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:29:44 -0400
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:48285
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261177AbVEaW2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:28:31 -0400
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
From: Paul Fulghum <paulkf@microgate.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200505312356.00853.adobriyan@gmail.com>
References: <200505312356.00853.adobriyan@gmail.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 17:28:11 -0500
Message-Id: <1117578491.4627.14.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is wrong. Please do not apply.

An unmodified ldisc driver (externally maintained) will continue to call
tty_register_ldisc with NULL, but the new behavior will be to set the
ldisc pointer to NULL but have LDISC_FLAG_DEFINED set.

If you feel it is absolutely necessary to add this new function
for cosmetic reasons, then leave the old behavior in place
and make tty_unregister_ldisc a wrapper to tty_register_ldisc
that uses a NULL pointer.

This preserves sanity and compatibility.

The existing function has a bug:
If new_ldisc != NULL and LDISC_FLAG_DEFINED is set,
the ldisc is switched to new_ldisc without checking
for non-zero refcount of current ldisc.

--
Paul Fulghum
paulkf@microgate.com


On Tue, 2005-05-31 at 23:56 +0400, Alexey Dobriyan wrote:
> It's a bit strange to see tty_register_ldisc() call in modules' exit functions.
> ...
> --- linux-tty_register_ldisc_000/Documentation/tty.txt	2005-05-31 20:12:47.000000000 +0400
> +++ linux-tty_register_ldisc_001/Documentation/tty.txt	2005-05-31 23:19:32.000000000 +0400
> @@ -22,7 +22,7 @@ copy of the structure. You must not re-r
>  discipline even with the same data or your computer again will be eaten by
>  demons.
>  
> -In order to remove a line discipline call tty_register_ldisc passing NULL.
> +In order to remove a line discipline call tty_unregister_ldisc().
>  In ancient times this always worked. In modern times the function will
>  return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
>  code manages the module counts this should not usually be a concern.
> diff -uprN linux-tty_register_ldisc_000/drivers/char/tty_io.c linux-tty_register_ldisc_001/drivers/char/tty_io.c
> --- linux-tty_register_ldisc_000/drivers/char/tty_io.c	2005-05-31 20:13:34.000000000 +0400
> +++ linux-tty_register_ldisc_001/drivers/char/tty_io.c	2005-05-31 23:17:40.000000000 +0400
> @@ -262,17 +262,10 @@ int tty_register_ldisc(int disc, struct 
>  		return -EINVAL;
>  	
>  	spin_lock_irqsave(&tty_ldisc_lock, flags);
> -	if (new_ldisc) {
> -		tty_ldiscs[disc] = *new_ldisc;
> -		tty_ldiscs[disc].num = disc;
> -		tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
> -		tty_ldiscs[disc].refcount = 0;
> -	} else {
> -		if(tty_ldiscs[disc].refcount)
> -			ret = -EBUSY;
> -		else
> -			tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
> -	}
> +	tty_ldiscs[disc] = *new_ldisc;
> +	tty_ldiscs[disc].num = disc;
> +	tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
> +	tty_ldiscs[disc].refcount = 0;
>  	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
>  	
>  	return ret;
> @@ -280,6 +273,26 @@ int tty_register_ldisc(int disc, struct 
>  
>  EXPORT_SYMBOL(tty_register_ldisc);
>  
> +int tty_unregister_ldisc(int disc)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (disc < N_TTY || disc >= NR_LDISCS)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&tty_ldisc_lock, flags);
> +	if (tty_ldiscs[disc].refcount)
> +		ret = -EBUSY;
> +	else
> +		tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
> +	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
> +
> +	return ret;
> +}
> +
> +EXPORT_SYMBOL(tty_unregister_ldisc);
> +
>  struct tty_ldisc *tty_ldisc_get(int disc)
>  {
>  	unsigned long flags;
> diff -uprN linux-tty_register_ldisc_000/include/linux/tty.h linux-tty_register_ldisc_001/include/linux/tty.h
> --- linux-tty_register_ldisc_000/include/linux/tty.h	2005-05-31 20:15:51.000000000 +0400
> +++ linux-tty_register_ldisc_001/include/linux/tty.h	2005-05-31 23:18:23.000000000 +0400
> @@ -345,6 +345,7 @@ extern int tty_check_change(struct tty_s
>  extern void stop_tty(struct tty_struct * tty);
>  extern void start_tty(struct tty_struct * tty);
>  extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
> +extern int tty_unregister_ldisc(int disc);
>  extern int tty_register_driver(struct tty_driver *driver);
>  extern int tty_unregister_driver(struct tty_driver *driver);
>  extern void tty_register_device(struct tty_driver *driver, unsigned index, struct device *dev);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
--
Paul Fulghum
paulkf@microgate.com

