Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbRFXXOb>; Sun, 24 Jun 2001 19:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265789AbRFXXOW>; Sun, 24 Jun 2001 19:14:22 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:43661 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S265788AbRFXXOP>; Sun, 24 Jun 2001 19:14:15 -0400
Date: Sun, 24 Jun 2001 19:14:00 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-computone@lazuli.wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] catch potential null derefs in drivers/char/ip2main.c (245ac16)
Message-ID: <20010624191400.A17692@alcove.wittsend.com>
Mail-Followup-To: Rasmus Andersen <rasmus@jaquet.dk>,
	linux-computone@lazuli.wittsend.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010624230606.G847@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20010624230606.G847@jaquet.dk>; from rasmus@jaquet.dk on Sun, Jun 24, 2001 at 11:06:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 11:06:06PM +0200, Rasmus Andersen wrote:
> Hi.

> (My last mail to dougm@computone.com bounced. Is there another
> maintainer for drivers/char/ip2main.c somewhere?)

	I'm still here.  :-)  Just look one more line down below
Doug's line.  There I am.

	I'm responsible for the kernel / driver integration end of it
anyways.

	I'll find out what's up with Doug, but this is my issue to deal
with anyways.  And yes, I'm looking at it.  I've got a couple of other
patches on the back burner that are overdue for integration.

> The patch below tries to avoid dereferencing (potential)
> NULL pointers. It was reported by the Stanford team way
> back and applies against 245ac16 and 246p6. It could
> probably be done nicer but that would take someone that
> actually understands this code.

> --- linux-245-ac16-clean/drivers/char/ip2main.c	Sat May 19 20:58:17 2001
> +++ linux-245-ac16/drivers/char/ip2main.c	Sun Jun 24 22:37:27 2001
> @@ -866,36 +866,38 @@
>  			}
>  
>  #ifdef	CONFIG_DEVFS_FS
> -			sprintf( name, "ipl%d", i );
> -			i2BoardPtrTable[i]->devfs_ipl_handle =
> -				devfs_register (devfs_handle, name,
> -					DEVFS_FL_DEFAULT,
> -					IP2_IPL_MAJOR, 4 * i,
> -					S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> -					&ip2_ipl, NULL);
> +			if (i2BoardPtrTable[i] && pB) {
> +				sprintf( name, "ipl%d", i );
> +				i2BoardPtrTable[i]->devfs_ipl_handle =
> +					devfs_register (devfs_handle, name,
> +							DEVFS_FL_DEFAULT,
> +							IP2_IPL_MAJOR, 4 * i,
> +							S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> +							&ip2_ipl, NULL);
>  
> -			sprintf( name, "stat%d", i );
> -			i2BoardPtrTable[i]->devfs_stat_handle =
> -				devfs_register (devfs_handle, name,
> -					DEVFS_FL_DEFAULT,
> -					IP2_IPL_MAJOR, 4 * i + 1,
> -					S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> -					&ip2_ipl, NULL);
> +				sprintf( name, "stat%d", i );
> +				i2BoardPtrTable[i]->devfs_stat_handle =
> +					devfs_register (devfs_handle, name,
> +							DEVFS_FL_DEFAULT,
> +							IP2_IPL_MAJOR, 4 * i + 1,
> +							S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
> +							&ip2_ipl, NULL);
>  
> -			for ( box = 0; box < ABS_MAX_BOXES; ++box )
> -			{
> -			    for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
> -			    {
> -				if ( pB->i2eChannelMap[box] & (1 << j) )
> +				for ( box = 0; box < ABS_MAX_BOXES; ++box )
>  				{
> -				    tty_register_devfs(&ip2_tty_driver,
> -					0, j + ABS_BIGGEST_BOX *
> -						(box+i*ABS_MAX_BOXES));
> -				    tty_register_devfs(&ip2_callout_driver,
> -					0, j + ABS_BIGGEST_BOX *
> -						(box+i*ABS_MAX_BOXES));
> +					for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
> +					{
> +						if ( pB->i2eChannelMap[box] & (1 << j) )
> +						{
> +							tty_register_devfs(&ip2_tty_driver,
> +									   0, j + ABS_BIGGEST_BOX *
> +									   (box+i*ABS_MAX_BOXES));
> +							tty_register_devfs(&ip2_callout_driver,
> +									   0, j + ABS_BIGGEST_BOX *
> +									   (box+i*ABS_MAX_BOXES));
> +						}
> +					}
>  				}
> -			    }
>  			}
>  #endif
>  
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> A chicken and an egg are lying in bed. The chicken is smoking a
> cigarette with a satisfied smile on it's face and the egg is frowning
> and looking a bit pissed off. The egg mutters, to no-one in particular,
> "Well, I guess we answered THAT question..."

-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

