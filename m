Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbTHYK2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTHYK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:27:43 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20167 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261621AbTHYK1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:27:35 -0400
Date: Mon, 25 Aug 2003 12:27:20 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] 1/3 Serio: claim serio early
Message-ID: <20030825102720.GA4369@ucw.cz>
References: <200308230131.50388.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308230131.50388.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 01:31:50AM -0500, Dmitry Torokhov wrote:
> Hi, 
> 
> I think that serio_dev in serio_open should claim serio before calling 
> "open" function as it has already been decided that (in case of success)
> this serio belongs to that serio_dev. Otherwise it might try to find an
> owner on its own, like i8042 module that calls serio_interrupt which in 
> turn will do serio_rescan. From that point on 2 instances may start 
> fighting over the same serio.
> 
> What you think about the patch below?

Agreed.

> 
> Dmitry
> 
> diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/serio/serio.c linux-2.6.0-test4/drivers/input/serio/serio.c
> --- 2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 21:53:29.000000000 -0500
> +++ linux-2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 22:58:37.000000000 -0500
> @@ -204,9 +204,11 @@
>  /* called from serio_dev->connect/disconnect methods under serio_sem */
>  int serio_open(struct serio *serio, struct serio_dev *dev)
>  {
> -	if (serio->open(serio))
> -		return -1;
>  	serio->dev = dev;
> +	if (serio->open(serio)) {
> +		serio->dev = NULL;
> +		return -1;
> +	}
>  	return 0;
>  }
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
