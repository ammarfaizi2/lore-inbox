Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVA1Okf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVA1Okf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVA1Okf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:40:35 -0500
Received: from styx.suse.cz ([82.119.242.94]:57801 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261418AbVA1Ok3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:40:29 -0500
Date: Fri, 28 Jan 2005 15:43:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Gernoth <simigern@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AT-Keyboard probing too strict in current bk?
Message-ID: <20050128144337.GC12137@ucw.cz>
References: <20050127164734.GA12899@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127164734.GA12899@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 05:47:34PM +0100, Michael Gernoth wrote:
> Hi,
> 
> since the introduction of libps2 in the mainline 2.6 kernel I had the
> issue that my keyboard[1] was no longer recognized.
> The cause of this is that my "keyboard" responds to all commands with
> an acknowledgement (0xFA), even if the command is not implemented. One
> of those not implemented commands is 0xF2 (ATKBD_GETID_CMD).
> 
> In drivers/input/keyboard/atkbd.c ATKBD_GETID_CMD is used to probe
> for the keyboard, and if this fails, another method of detecting
> the keyboard is used. It seems that in 2.6.10 atkbd_command
> indicated that my keyboard did not successfully execute the command,
> but in the current bk-version ps2_command is used, which indicates
> a successfull execution, leaving behind invalid keyboard-ids.
> This leads to the kernel ignoring my keyboard.

This is a bug in libps2, that's been fixed and submitted for 2.6.11.
Your keyboard should work again with 2.6.11, if the fix makes it there.
If a keyboard doesn't report the ID on a GETID command, ps2_command
should fail.

Old AT keyboards don't know the GETID command but at least they know
the SETLEDS command, which is how they're identified.

As a temporary workaround you can use atkbd.dumbkbd=1, which will cause
your LEDs not to work as a side effect, though.

> I fixed the problem in my keyboard-converter, but I don't know if
> the checking in keyboard-probing shouldn't be changed to catch that
> case, too. I have included a patch which does that.

We don't need to check the values, since the ps2_command will return an
error when the bug in libps2 is fixed.

> [1] SUN Type 5 keyboard connected to a self-built sun->ps2 adapter
> 
> --- 1.73/drivers/input/keyboard/atkbd.c	2005-01-06 17:42:09 +01:00
> +++ edited/drivers/input/keyboard/atkbd.c	2005-01-27 17:27:03 +01:00
> @@ -512,7 +512,8 @@
>   */
>  
>  	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
> -	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
> +	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID) ||
> +	    (param[0] == 0xa5 && param[1] == 0xa5)) {
>  
>  /*
>   * If the get ID command failed, we check if we can at least set the LEDs on

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
