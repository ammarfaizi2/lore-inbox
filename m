Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUFFRw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUFFRw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUFFRw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:52:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:24448 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263923AbUFFRtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:49:09 -0400
Date: Sun, 6 Jun 2004 19:49:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Scroll wheel on PS/2 Logitech MouseMan Wheel no longer works (was Re: 2.6.6-mm3)
Message-ID: <20040606174942.GC6561@ucw.cz>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <200405191256.32335.dtor_core@ameritech.net> <6uy8nnczcg.fsf@zork.zork.net> <200405252240.29353.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405252240.29353.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 10:40:25PM -0500, Dmitry Torokhov wrote:
> On Thursday 20 May 2004 02:49 am, Sean Neakums wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> writes:
> > > >
> > > Hmm... it indeed reports REL_X and REL_Y events instead of REL_WHEEL... So
> > > its definitely not a mousedev problem. Could you also try booting with
> > > psmouse.proto=exps and see if it still behaves sanely?
> > 
> > The scrolls wheel appears to do nothing when I boot with psmouse.proto=exps.
> > Here's what the mouse is shown as in /proc/bus/input/devices:
> > 
> 
> Hi,
> 
> Sorry for delay with my answer. I got a hold of a mouse that supports
> Explorer PS/2 protocol and it works fine here. Still could you try
> reverting the patch below and see if it restores the correct behavior.

I think I have a similar fix in the tree already.

> 
> Thanks!
> 
> -- 
> Dmitry
> 
> 
> ===================================================================
> 
> 
> ChangeSet@1.1612.1.17, 2004-05-14 11:18:46+02:00, vojtech@suse.cz
>   input: Check for IM Explorer mice even if IMPS check failed.
> 
> 
>  psmouse-base.c |   21 +++++++++++----------
>  1 files changed, 11 insertions(+), 10 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> --- a/drivers/input/mouse/psmouse-base.c	2004-05-25 22:38:24 -05:00
> +++ b/drivers/input/mouse/psmouse-base.c	2004-05-25 22:38:24 -05:00
> @@ -461,24 +461,25 @@
>  			return type;
>  	}
>  
> -	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
> +	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
>  
>  		if (set_properties) {
>  			set_bit(REL_WHEEL, psmouse->dev.relbit);
> +			set_bit(BTN_SIDE, psmouse->dev.keybit);
> +			set_bit(BTN_EXTRA, psmouse->dev.keybit);
>  			if (!psmouse->name)
> -				psmouse->name = "Wheel Mouse";
> +				psmouse->name = "Explorer Mouse";
>  		}
>  
> -		if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
> +		return PSMOUSE_IMEX;
> +	}
>  
> -			if (!set_properties) {
> -				set_bit(BTN_SIDE, psmouse->dev.keybit);
> -				set_bit(BTN_EXTRA, psmouse->dev.keybit);
> -				if (!psmouse->name)
> -					psmouse->name = "Explorer Mouse";
> -			}
> +	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
>  
> -			return PSMOUSE_IMEX;
> +		if (set_properties) {
> +			set_bit(REL_WHEEL, psmouse->dev.relbit);
> +			if (!psmouse->name)
> +				psmouse->name = "Wheel Mouse";
>  		}
>  
>  		return PSMOUSE_IMPS;
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
