Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUGGQak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUGGQak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUGGQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:30:40 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:64897 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265245AbUGGQah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:30:37 -0400
Date: Wed, 7 Jul 2004 18:31:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040707163103.GA1368@ucw.cz>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407061251.18702.dtor_core@ameritech.net> <20040706231256.GV21066@holomorphy.com> <200407070015.39507.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407070015.39507.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:15:37AM -0500, Dmitry Torokhov wrote:
> The only suspicious thing that I see is that sunzilog tries to register its
> serio ports with spinlock held and interrupts off. I wonder if that is what
> causing a deadlock. Could you please try applying this patch on top of the
> changes to the drivers/Makefile that I sent earlier.

Shall I add this to my BK then?

> -- 
> Dmitry
> 
> 
> ===== drivers/serial/sunzilog.c 1.44 vs edited =====
> --- 1.44/drivers/serial/sunzilog.c	2004-06-28 22:45:23 -05:00
> +++ edited/drivers/serial/sunzilog.c	2004-07-06 23:46:54 -05:00
> @@ -1529,7 +1529,6 @@
>  static void __init sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
>  {
>  	int baud, brg;
> -	struct serio *serio;
>  
>  	if (channel == KEYBOARD_LINE) {
>  		up->flags |= SUNZILOG_FLAG_CONS_KEYB;
> @@ -1546,8 +1545,15 @@
>  	up->curregs[R15] = BRKIE;
>  	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
>  	sunzilog_convert_to_zs(up, up->cflag, 0, brg);
> +	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
> +	__sunzilog_startup(up);
> +}
>  
>  #ifdef CONFIG_SERIO
> +static void __init sunzilog_register_serio(struct uart_sunzilog_port *up, int channel)
> +{
> +	struct serio *serio;
> +
>  	up->serio = serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (serio) {
>  
> @@ -1576,11 +1582,8 @@
>  		printk(KERN_WARNING "zs%d: not enough memory for serio port\n",
>  			channel);
>  	}
> -#endif
> -
> -	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
> -	__sunzilog_startup(up);
>  }
> +#endif
>  
>  static void __init sunzilog_init_hw(void)
>  {
> @@ -1624,6 +1627,11 @@
>  		}
>  
>  		spin_unlock_irqrestore(&up->port.lock, flags);
> +
> +#ifdef CONFIG_SERIO
> +		if (i == KEYBOARD_LINE || i == MOUSE_LINE)
> +			sunzilog_register_serio(up, i);
> +#endif
>  	}
>  }
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
