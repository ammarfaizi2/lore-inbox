Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVGCUdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVGCUdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGCUds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:33:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7833 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261527AbVGCUdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:33:42 -0400
Date: Sun, 3 Jul 2005 22:34:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ALPS: fix enabling hardware tapping
Message-ID: <20050703203401.GA3733@ucw.cz>
References: <200506150138.49880.dtor_core@ameritech.net> <m3slyw6reu.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3slyw6reu.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 01:49:13PM +0200, Peter Osterlund wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
> > It looks like logic for enabling hardware tapping in ALPS driver was
> > inverted and we enable it only if it was already enabled by BIOS or
> > firmware.
> 
> It looks like alps_init() has the same bug.  This patch fixes that
> function too by moving the check if the tapping mode needs to change
> into the alps_tap_mode() function, so that the test doesn't have to be
> duplicated.

This looks good. However - what's the point in checking whether tapping
is enabled before enabling it?

> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
> 
>  linux-petero/drivers/input/mouse/alps.c |   29 +++++++++++------------------
>  1 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff -puN drivers/input/mouse/alps.c~alps-hwtaps-fix drivers/input/mouse/alps.c
> --- linux/drivers/input/mouse/alps.c~alps-hwtaps-fix	2005-07-03 13:42:47.000000000 +0200
> +++ linux-petero/drivers/input/mouse/alps.c	2005-07-03 13:42:47.000000000 +0200
> @@ -2,7 +2,7 @@
>   * ALPS touchpad PS/2 mouse driver
>   *
>   * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
> - * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
> + * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
>   * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
>   * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
>   *
> @@ -334,6 +334,13 @@ static int alps_tap_mode(struct psmouse 
>  	int cmd = enable ? PSMOUSE_CMD_SETRATE : PSMOUSE_CMD_SETRES;
>  	unsigned char tap_arg = enable ? 0x0A : 0x00;
>  	unsigned char param[4];
> +	int enabled;
> +
> +	if (alps_get_status(psmouse, param))
> +		return -1;
> +	enabled = (param[0] & 0x04) != 0;
> +	if (enabled == enable)
> +		return 0;
>  
>  	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO) ||
>  	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
> @@ -350,7 +357,6 @@ static int alps_tap_mode(struct psmouse 
>  static int alps_reconnect(struct psmouse *psmouse)
>  {
>  	struct alps_data *priv = psmouse->private;
> -	unsigned char param[4];
>  	int version;
>  
>  	psmouse_reset(psmouse);
> @@ -361,11 +367,7 @@ static int alps_reconnect(struct psmouse
>  	if (priv->i->flags & ALPS_PASS && alps_passthrough_mode(psmouse, 1))
>  		return -1;
>  
> -	if (alps_get_status(psmouse, param))
> -		return -1;
> -
> -	if (!(param[0] & 0x04))
> -		alps_tap_mode(psmouse, 1);
> +	alps_tap_mode(psmouse, 1);
>  
>  	if (alps_absolute_mode(psmouse)) {
>  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
> @@ -389,7 +391,6 @@ static void alps_disconnect(struct psmou
>  int alps_init(struct psmouse *psmouse)
>  {
>  	struct alps_data *priv;
> -	unsigned char param[4];
>  	int version;
>  
>  	psmouse->private = priv = kmalloc(sizeof(struct alps_data), GFP_KERNEL);
> @@ -403,16 +404,8 @@ int alps_init(struct psmouse *psmouse)
>  	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 1))
>  		goto init_fail;
>  
> -	if (alps_get_status(psmouse, param)) {
> -		printk(KERN_ERR "alps.c: touchpad status report request failed\n");
> -		goto init_fail;
> -	}
> -
> -	if (param[0] & 0x04) {
> -		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
> -		if (alps_tap_mode(psmouse, 1))
> -			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
> -	}
> +	if (alps_tap_mode(psmouse, 1))
> +		printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
>  
>  	if (alps_absolute_mode(psmouse)) {
>  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
