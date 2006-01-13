Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWAMHra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWAMHra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWAMHra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:47:30 -0500
Received: from styx.suse.cz ([82.119.242.94]:37010 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1161242AbWAMHra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:47:30 -0500
Date: Fri, 13 Jan 2006 08:47:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060113074749.GA7103@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch> <1137022900.5138.66.camel@localhost.localdomain> <20060112000830.GB10142@hansmi.ch> <200601122312.05210.dtor_core@ameritech.net> <20060113065302.GA3458@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113065302.GA3458@hansmi.ch>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 07:53:02AM +0100, Michael Hanselmann wrote:
 
> It indeed is. Fixed.

It gets better all the time. ;)

> New patch:
> 
> This patch implements support for the fn key on Apple PowerBooks using
> USB based keyboards.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---

> @@ -325,7 +459,27 @@ static void hidinput_configure_usage(str
>  
>  			set_bit(EV_REP, input->evbit);
>  			switch(usage->hid & HID_USAGE) {
> -				case 0x003: map_key_clear(KEY_FN);		break;
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +				/* The fn key on Apple PowerBooks */
> +				case 0x0003: {
> +					struct hidinput_key_translation *trans;
> +
> +					map_key_clear(KEY_FN);
> +
> +					set_bit(KEY_FN, input->keybit);

The set_bit(KEY_FN, input->keybit) is superfluous here, right?
map_key_clear(KEY_FN); will take care of that further down.

> +					set_bit(KEY_NUMLOCK, input->keybit);
> +
> +					/* Enable all needed keys */
> +					for(trans = powerbook_fn_keys; trans->from; trans++)
> +						set_bit(trans->to, input->keybit);
> +
> +					for(trans = powerbook_numlock_keys; trans->from; trans++)
> +						set_bit(trans->to, input->keybit);
> +
> +					goto ignore;
> +				}
> +#endif
> +
>  				default:    goto ignore;
>  			}
>  			break;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
