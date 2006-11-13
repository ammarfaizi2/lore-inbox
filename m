Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752646AbWKMXoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWKMXoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbWKMXoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:44:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:47027 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752646AbWKMXoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:44:55 -0500
Date: Mon, 13 Nov 2006 15:03:00 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: eric@buddington.net, Eric Buddington <ebuddington@verizon.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@novell.com>,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.19-rc4-mm2: BUG modprobeing sound driver
Message-ID: <20061113230300.GA16571@kroah.com>
References: <20061109142208.GA4291@pool-70-109-251-157.wma.east.verizon.net> <20061109220515.7a127070.akpm@osdl.org> <20061109222829.fe9de523.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109222829.fe9de523.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:28:29PM -0800, Andrew Morton wrote:
> On Thu, 9 Nov 2006 22:05:15 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Yup, trivial to reproduce: modprobe snd_serial_u16550 -> splat.
> > 
> > Bisection indicates that this oops is triggered by
> > gregkh-driver-sound-device.patch.
> > 
> > snd_serial_probe() never got to call snd_card_register(), so card->dev is
> > NULL.
> > 
> > snd_serial_probe() calls snd_card_free(card) on the error path and
> > snd_card_do_free() does device_del(card->dev) which oopses over the null
> > pointer it got.  
> 
> I suppose doing this is legit:
> 
> diff -puN sound/core/init.c~fix-gregkh-driver-sound-device sound/core/init.c
> --- a/sound/core/init.c~fix-gregkh-driver-sound-device
> +++ a/sound/core/init.c
> @@ -361,7 +361,8 @@ static int snd_card_do_free(struct snd_c
>  		snd_printk(KERN_WARNING "unable to free card info\n");
>  		/* Not fatal error */
>  	}
> -	device_unregister(card->dev);
> +	if (card->dev)
> +		device_unregister(card->dev);
>  	kfree(card);
>  	return 0;
>  }

Good idea, I've made that change now to the sound code.

thanks,

greg k-h
