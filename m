Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266504AbUAIK7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUAIK7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:59:16 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:25541 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266504AbUAIK7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:59:11 -0500
Date: Fri, 9 Jan 2004 11:58:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gunter =?iso-8859-1?Q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Message-ID: <20040109105855.GB9479@ucw.cz>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The sync problems have so far been found to be caused by two possible
causes:

	1) Too long disabled interrupts. This is usually caused by ACPI
	   BIOS, when some application is polling for battery status
	   too often.

	2) Incorrectly working timer (jiffies). This maybe caused by
	   using the ACPI timer instead of the regular PIT one. Check
	   the config.

Both these causes break the lost bytes detection mechanism in the ps/2
code. It then thinks that a byte was lost (and thus the sync, too), but
in reality everything is OK. This in turn causes two consecutive
incorrectly parsed packets.

On Fri, Jan 09, 2004 at 11:17:09AM +0100, Gunter Königsmann wrote:
> 
> Don't know if I'm supposed to the list or to the maintainer, mailing tho
> both.
> 
> PROBLEM: My Touchpad generates rapid movements, random clicks and even
> keypress events on the keyboard connected to the same BUS. Resetting the
> Touchpad after bad syncs doesn't help.
> 
> Throwing away two packets after a bad sync loss fixed the whole problem.
> One packet is not sufficient.
> 
> TODO:
>         Don't know If I also should throw away packages we are supposed to
>         pass through. Didn't touch this part of the driver.
> 
>         Perhaps we need a better resync algorithm anyway or --- even better
>         --- find the reason of the sync losses.
>         Meanwhile this patch shouldn't hurt anyone not suffering from
> 	sync losses on a regular base. This patch might discard a vital
> 	click but ---at least on my system--- prevents the system from
> 	generating them by itself.
> 
> 
> 
> 
> PATCH:
> diff -r -u linux-2.6.0/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> --- linux-2.6.0/drivers/input/mouse/synaptics.c	2003-11-24 02:31:44.000000000 +0100
> +++ b/drivers/input/mouse/synaptics.c	2004-01-09 11:06:55.359149432 +0100
> @@ -1,6 +1,9 @@
>  /*
>   * Synaptics TouchPad PS/2 mouse driver
>   *
> + *   2003 Gunter K\"onigsmann <gunter.koenigsmann@gmx.de>
> + *     Experimental fix for strange behaviour after resync.
> + *
>   *   2003 Dmitry Torokhov <dtor@mail.ru>
>   *     Added support for pass-through port
>   *
> @@ -607,16 +610,23 @@
>  	default:
>  		if (psmouse->pktcnt < 6)
>  			break;		    /* Wait for full packet */
> -
> +
>  		if (priv->out_of_sync) {
>  			priv->out_of_sync = 0;
>  			printk(KERN_NOTICE "Synaptics driver resynced.\n");
>  		}
> -
> +
>  		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
> -			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
> +		        synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
>  		else
> -			synaptics_process_packet(psmouse);
> +			if((priv->throwaway--)>0) /* When sync was
> +			lost --- should we throw away packets we are
> +		        supposed to pass through as well? If yes move
> +		        this line three lines higher. */
> +			{
> +				priv->throwaway=0;
> +				synaptics_process_packet(psmouse);
> +			}
> 
>  		psmouse->pktcnt = 0;
>  		break;
> @@ -625,6 +635,9 @@
> 
>   bad_sync:
>  	priv->out_of_sync++;
> +	priv->throwaway=2;    /* Throw away the next 2 packets after a
> +				 bad sync. Seems like at least one of
> +				 them *will* be bad.*/
>  	psmouse->pktcnt = 0;
>  	if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
>  		psmouse->state = PSMOUSE_IGNORE;
> diff -r -u linux-2.6.0/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> --- linux-2.6.0/drivers/input/mouse/synaptics.h	2003-11-24 02:31:54.000000000 +0100
> +++ b/drivers/input/mouse/synaptics.h	2004-01-09 11:07:01.838164472 +0100
> @@ -104,6 +104,10 @@
> 
>  	/* Data for normal processing */
>  	unsigned int out_of_sync;		/* # of packets out of sync */
> +	unsigned int throwaway;                 /* Packet was out of */
> +						/* sync. Throw away */
> +						/* N packets.*/
> +
>  	int old_w;				/* Previous w value */
> 
>  	struct serio *ptport;			/* pass-through port */
> 
> System:
> 
> Siemens-Amilo M Notebook
> 
> Linux labtop 2.6.0 #14 Fri Jan 9 09:45:26 CET 2004 i686 unknown unknown
> GNU/Linux
> 
> Gnu C                  3.3
> Gnu make               3.80
> util-linux             2.11z
> mount                  2.11z
> module-init-tools      0.9.8
> e2fsprogs              1.28
> jfsutils               1.1.1
> xfsprogs               2.3.9
> pcmcia-cs              3.2.3
> PPP                    2.4.1
> isdn4k-utils           3.2p3
> nfs-utils              1.0.1
> Linux C Library        x    1 root     root      1491599 Mar 14  2003
> /lib/libc.so.6
> Dynamic linker (ldd)   2.3.2
> Linux C++ Library      5.0.3
> Procps                 3.1.6
> Net-tools              1.60
> Kbd                    1.06
> Sh-utils               4.5.8
> Modules Loaded         raw1394
> 
> Touchpad:
> <6>i8042.c: Detected active multiplexing controller, rev 1.1.
> <6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
> <6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
> <6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
> <6>Synaptics Touchpad, model: 1
> <6> Firmware: 5.8
> <6> 180 degree mounted touchpad
> <6> Sensor: 18
> <6> new absolute packet format
> <6> Touchpad has extended capability bits
> <6> -> 4 multi-buttons, i.e. besides standard buttons
> <6> -> multifinger detection
> <6> -> palm detection
> <6>input: SynPS/2 Synaptics TouchPad on isa0060/serio4
> <6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
> <6>input: AT Translated Set 2 keyboard on isa0060/serio0
> <6>serio: i8042 KBD port at 0x60,0x64 irq 1
> --
> The parents of young organic lifeforms be warned: The swallowing of towels
> in great quantities may be harmful.
>         --Douglas Adams.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
