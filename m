Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272521AbVBEVMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbVBEVMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272506AbVBEVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:11:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:30123 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S269599AbVBEVLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:11:15 -0500
Date: Sat, 5 Feb 2005 22:11:36 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       zhilla <zhilla@spymac.com>, Victor Hahn <victorhahn@web.de>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Message-ID: <20050205211136.GB8451@ucw.cz>
References: <200502051448.57492.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051448.57492.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 02:48:56PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> The patch below attempts to better handle situation when psmouse interrupt
> is delayed for more than 0.5 sec by requesting a resend. This will allow
> properly synchronize with the beginning of the packet as mouse is supposed
> to resend entire package.

Have you actually tested the mouse is really sending the whole packet?
I'd suspect it could just resend the last byte. :I Maybe using the
GET_PACKET command would be more useful in this case.

Also, we could use GET_PACKET to check the mode of the mouse, when we
get several successive lost bytes.

> Additionally, psmouse will also request resend if KBC indicates parity or
> timeout errors. 
> 
> The patch should apply to 2.6.11-rc2+. A version of this patch for 2.6.10
> is available here:
> 
> 	http://www.geocities.com/dt_or/input/2_6_10/
> 
> -- 
> Dmitry
> 
> 
> ===================================================================
> 
> 
> ChangeSet@1.2006, 2005-02-05 14:33:05-05:00, dtor_core@ameritech.net
>   Input: psmouse - better handle bad transfers and interrupt delays
>          by requesting resend of the last packet so we don't need to
>          guess if received byte is remainder of last packet or start
>          of a new one.
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  psmouse-base.c |   48 +++++++++++++++++++++++++++++++++++++++++++-----
>  psmouse.h      |    2 ++
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> --- a/drivers/input/mouse/psmouse-base.c	2005-02-05 14:37:51 -05:00
> +++ b/drivers/input/mouse/psmouse-base.c	2005-02-05 14:37:51 -05:00
> @@ -134,6 +134,42 @@
>  	return PSMOUSE_FULL_PACKET;
>  }
>  
> +static void psmouse_handle_bad_xfer(struct psmouse *psmouse, unsigned int flags)
> +{
> +	if (psmouse->state == PSMOUSE_ACTIVATED)
> +		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
> +			flags & SERIO_TIMEOUT ? " timeout" : "",
> +			flags & SERIO_PARITY ? " bad parity" : "");
> +
> +	if (!psmouse->resend) {
> +		/*
> +		 * This is first error. Try to request resend but not if we got
> +		 * timeout and we are in initialize phase - there most likely no
> +		 * mouse at all.
> +		 */
> +		if (psmouse->state > PSMOUSE_INITIALIZING || (~flags & SERIO_TIMEOUT)) {
> +			if (serio_write(psmouse->ps2dev.serio, PSMOUSE_CMD_RESEND) == 0) {
> +				psmouse->resend = 1;
> +				psmouse->pktcnt = 0;
> +			}
> +		}
> +	} else {
> +		/*
> +		 * This is second error in a row. If mouse was itialized - attempt
> +		 * to rconnect, otherwise just signal failure.
> +		 */
> +		psmouse->resend = 0;
> +		if (psmouse->state > PSMOUSE_INITIALIZING) {
> +			psmouse->state = PSMOUSE_IGNORE;
> +			printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
> +			serio_reconnect(psmouse->ps2dev.serio);
> +		}
> +	}
> +
> +	if (!psmouse->resend)
> +		ps2_cmd_aborted(&psmouse->ps2dev);
> +}
> +
>  /*
>   * psmouse_interrupt() handles incoming characters, either gathering them into
>   * packets or passing them to the command routine as command output.
> @@ -149,11 +185,7 @@
>  		goto out;
>  
>  	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
> -		if (psmouse->state == PSMOUSE_ACTIVATED)
> -			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
> -				flags & SERIO_TIMEOUT ? " timeout" : "",
> -				flags & SERIO_PARITY ? " bad parity" : "");
> -		ps2_cmd_aborted(&psmouse->ps2dev);
> +		psmouse_handle_bad_xfer(psmouse, flags);
>  		goto out;
>  	}
>  
> @@ -168,11 +200,17 @@
>  	if (psmouse->state == PSMOUSE_INITIALIZING)
>  		goto out;
>  
> +	psmouse->resend = 0;
> +
>  	if (psmouse->state == PSMOUSE_ACTIVATED &&
>  	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
>  		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
>  		       psmouse->name, psmouse->phys, psmouse->pktcnt);
>  		psmouse->pktcnt = 0;
> +		if (serio_write(serio, PSMOUSE_CMD_RESEND) == 0) {
> +			psmouse->resend = 1;
> +			goto out;
> +		}
>  	}
>  
>  	psmouse->last = jiffies;
> diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> --- a/drivers/input/mouse/psmouse.h	2005-02-05 14:37:51 -05:00
> +++ b/drivers/input/mouse/psmouse.h	2005-02-05 14:37:51 -05:00
> @@ -13,6 +13,7 @@
>  #define PSMOUSE_CMD_ENABLE	0x00f4
>  #define PSMOUSE_CMD_DISABLE	0x00f5
>  #define PSMOUSE_CMD_RESET_DIS	0x00f6
> +#define PSMOUSE_CMD_RESEND	0x00fe
>  #define PSMOUSE_CMD_RESET_BAT	0x02ff
>  
>  #define PSMOUSE_RET_BAT		0xaa
> @@ -48,6 +49,7 @@
>  	unsigned long last;
>  	unsigned long out_of_sync;
>  	enum psmouse_state state;
> +	unsigned int resend;
>  	char devname[64];
>  	char phys[32];
>  
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
