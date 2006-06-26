Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWFZOwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFZOwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWFZOwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:52:41 -0400
Received: from styx.suse.cz ([82.119.242.94]:64463 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750936AbWFZOwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:52:40 -0400
Date: Mon, 26 Jun 2006 16:52:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       dtor_core@ameritech.net
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Message-ID: <20060626145237.GA24275@suse.cz>
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:21:29AM -0400, Alan Stern wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> 
> This patch (as728) makes the AT keyboard driver store the current
> autorepeat rate so that it can be restored properly following a 
> suspend/resume cycle.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

IMO this should be done in keyboard.c, similar to the LED setting upon
keyboard plug-in.

> ---
> 
> Index: usb-2.6/drivers/input/keyboard/atkbd.c
> ===================================================================
> --- usb-2.6.orig/drivers/input/keyboard/atkbd.c
> +++ usb-2.6/drivers/input/keyboard/atkbd.c
> @@ -39,6 +39,8 @@ static int atkbd_set = 2;
>  module_param_named(set, atkbd_set, int, 0);
>  MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3 = PS/2 native)");
>  
> +static int atkbd_repeatrate;
> +
>  #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
>  static int atkbd_reset;
>  #else
> @@ -477,7 +479,7 @@ static void atkbd_event_work(void *data)
>  			j++;
>  		dev->rep[REP_PERIOD] = period[i];
>  		dev->rep[REP_DELAY] = delay[j];
> -		param[0] = i | (j << 5);
> +		param[0] = atkbd_repeatrate = i | (j << 5);
>  		ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
>  	}
>  
> @@ -676,10 +678,10 @@ static int atkbd_activate(struct atkbd *
>  		return -1;
>  
>  /*
> - * Set autorepeat to fastest possible.
> + * Set autorepeat to whatever it used to be.
>   */
>  
> -	param[0] = 0;
> +	param[0] = atkbd_repeatrate;
>  	if (ps2_command(ps2dev, param, ATKBD_CMD_SETREP))
>  		return -1;
>  
> 
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs
