Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTJ1Jr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTJ1Jr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:47:27 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:36236 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263592AbTJ1JrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:47:21 -0500
Date: Tue, 28 Oct 2003 10:47:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031028094709.GA4325@ucw.cz>
References: <20031027140217.GA1065@averell> <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org> <20031028035244.GA20145@rivenstone.net> <20031028035625.GB20145@rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028035625.GB20145@rivenstone.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 10:56:25PM -0500, jhf@rivenstone.net wrote:
> On Mon, Oct 27, 2003 at 10:52:44PM -0500, I wrote:
> > On Mon, Oct 27, 2003 at 08:32:15AM -0800, Linus Torvalds wrote:
> > > 
> > > On Mon, 27 Oct 2003, Andi Kleen wrote:
> > > > 
> > > > Overall as KVM user I must say I'm not very happy with the 2.6 mouse
> > > > driver. 2.4 pretty much worked out of the box, but 2.6 needs
> > > > lots of strange options (psmouse_noext, psmouse_rate=80) 
> > > > because it does things very differently out of the box.
> > > 
> > > I agree. The keyboard driver has also deteriorated, I think. 
> > > 
> > > I'd suggest we _not_ set the rate by default at all (and let the default
> > > thing just happen). And only set the rate if the user _asks_ for it with
> > > your setup thing. Mind sending me that kind of patch?
> > > 
> > 
> >     I need this patch to use the scroll wheel on my Logitech mouse
> > with my Belkin KVM switch in 2.6. This patch was in -mm for a while
> > before some changes there broke the diff, and I got some mail from
> > people who said it was helpful.  I didn't hear about any problems.
> > 
> >     Linus, will you please consider applying it?

Plase not in this shape. I don't want yet another option to the driver.
Dmitry said he'll whip up a patch that with a single option can limit
the maximum protocol of the PS/2 mouse to either PS/2, IMPS/2 or
ImExPS/2, possibly more, "psmouse_proto=". That's a better solution.

>     D'oh, forgot the patch.  This is the same patch that was in -mm,
> rediffed against -test9 and tested to compile.  I've been running this
> same patch on vanilla and -mm kernels for months now.
> 
> -- 
> Joseph Fannin
> jhf@rivenstone.net
> 
> Rothchild's Rule -- "For every phenomenon, however complex, someone will
> eventually come up with a simple and elegant theory. This theory will
> be wrong."

> diff -aur linux-2.6.0-test9_orig/Documentation/kernel-parameters.txt linux-2.6.0-test9/Documentation/kernel-parameters.txt
> --- linux-2.6.0-test9_orig/Documentation/kernel-parameters.txt	2003-10-27 15:50:46.000000000 -0500
> +++ linux-2.6.0-test9/Documentation/kernel-parameters.txt	2003-10-27 15:53:58.000000000 -0500
> @@ -790,6 +790,8 @@
>  			before loading.
>  			See Documentation/ramdisk.txt.
>  
> +	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol extensions
> +
>  	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
>  
>  	psmouse_resetafter=
> diff -aur linux-2.6.0-test9_orig/drivers/input/mouse/psmouse-base.c linux-2.6.0-test9/drivers/input/mouse/psmouse-base.c
> --- linux-2.6.0-test9_orig/drivers/input/mouse/psmouse-base.c	2003-10-27 15:50:33.000000000 -0500
> +++ linux-2.6.0-test9/drivers/input/mouse/psmouse-base.c	2003-10-27 15:53:58.000000000 -0500
> @@ -24,6 +24,8 @@
>  
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
>  MODULE_DESCRIPTION("PS/2 mouse driver");
> +MODULE_PARM(psmouse_imps2, "1i");
> +MODULE_PARM_DESC(psmouse_imps2, "Limit protocol extensions to the Intellimouse protocol.");
>  MODULE_PARM(psmouse_noext, "1i");
>  MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful for KVM switches.");
>  MODULE_PARM(psmouse_resolution, "i");
> @@ -38,6 +40,7 @@
>  
>  #define PSMOUSE_LOGITECH_SMARTSCROLL	1
>  
> +static int psmouse_imps2;
>  static int psmouse_noext;
>  int psmouse_resolution;
>  unsigned int psmouse_rate = 60;
> @@ -275,66 +278,68 @@
>  	if (psmouse_noext)
>  		return PSMOUSE_PS2;
>  
> -/*
> - * Try Synaptics TouchPad magic ID
> - */
> -
> -       param[0] = 0;
> -       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +	if (!psmouse_imps2) {
>  
> -       if (param[1] == 0x47) {
> -		psmouse->vendor = "Synaptics";
> -		psmouse->name = "TouchPad";
> -		if (!synaptics_init(psmouse))
> -			return PSMOUSE_SYNAPTICS;
> -		else
> -			return PSMOUSE_PS2;
> -       }
> +		/*
> +		 * Try Synaptics TouchPad magic ID
> +		 */
>  
> -/*
> - * Try Genius NetMouse magic init.
> - */
> +		param[0] = 0;
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +
> +		if (param[1] == 0x47) {
> +			psmouse->vendor = "Synaptics";
> +			psmouse->name = "TouchPad";
> +			if (!synaptics_init(psmouse))
> +				return PSMOUSE_SYNAPTICS;
> +			else
> +				return PSMOUSE_PS2;
> +		}
>  
> -	param[0] = 3;
> -	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +		/*
> +		 * Try Genius NetMouse magic init.
> +		 */
>  
> -	if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
> +		param[0] = 3;
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
>  
> -		set_bit(BTN_EXTRA, psmouse->dev.keybit);
> -		set_bit(BTN_SIDE, psmouse->dev.keybit);
> -		set_bit(REL_WHEEL, psmouse->dev.relbit);
> +		if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
>  
> -		psmouse->vendor = "Genius";
> -		psmouse->name = "Wheel Mouse";
> -		return PSMOUSE_GENPS;
> -	}
> +			set_bit(BTN_EXTRA, psmouse->dev.keybit);
> +			set_bit(BTN_SIDE, psmouse->dev.keybit);
> +			set_bit(REL_WHEEL, psmouse->dev.relbit);
>  
> -/*
> - * Try Logitech magic ID.
> - */
> +			psmouse->vendor = "Genius";
> +			psmouse->name = "Wheel Mouse";
> +			return PSMOUSE_GENPS;
> +		}
>  
> -	param[0] = 0;
> -	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> -	param[1] = 0;
> -	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +		/*
> +		 * Try Logitech magic ID.
> +		 */
>  
> -	if (param[1]) {
> -		int type = ps2pp_detect_model(psmouse, param);
> -		if (type)
> -			return type;
> +		param[0] = 0;
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
> +		param[1] = 0;
> +		psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +
> +		if (param[1]) {
> +			int type = ps2pp_detect_model(psmouse, param);
> +			if (type)
> +				return type;
> +		}
>  	}
> -
>  /*
>   * Try IntelliMouse magic init.
>   */
> @@ -627,6 +632,12 @@
>  };
>  
>  #ifndef MODULE
> +static int __init psmouse_imps2_setup(char *str)
> +{
> +	psmouse_imps2 = 1;
> +	return 1;
> +}
> +
>  static int __init psmouse_noext_setup(char *str)
>  {
>  	psmouse_noext = 1;
> @@ -651,6 +662,7 @@
>  	return 1;
>  }
>  
> +__setup("psmouse_imps2", psmouse_imps2_setup);
>  __setup("psmouse_noext", psmouse_noext_setup);
>  __setup("psmouse_resolution=", psmouse_resolution_setup);
>  __setup("psmouse_smartscroll=", psmouse_smartscroll_setup);




-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
