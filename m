Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTJNTjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTJNTiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:38:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:30398 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262796AbTJNTiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:38:51 -0400
Date: Tue, 14 Oct 2003 21:38:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: mouse driver bug in 2.6.0-test7?
Message-ID: <20031014193847.GA9112@ucw.cz>
References: <3F8C3A99.6020106@opensound.com> <1066159113.12171.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066159113.12171.4.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 09:18:34PM +0200, Martin Josefsson wrote:
> On Tue, 2003-10-14 at 20:04, 4Front Technologies wrote:
> > Why is the PS2 mouse tracking about 2x faster in 2.6.0-test7 compared
> > to 2.4.xx?. Has anybody else seen this problem?.
> > 
> > If I move the mouse 1 inch horizontally left-to-right on the mouse
> > pad, the cursor on the screen moves almost twice the distance on the
> > screen compared to Linux 2.4.xx
> 
> It's probably mostly because Vojtech changed the samplerate from 200 to
> 60. Here's a patch to change it back. I've sent it to Vojtech but he's
> completely ignored it so far. This patch also readds the fallback logic
> that was used before his change, although it uses the new
> samplerate-table.
> 
> Without this patch my mouse is awful to use.
> Vojtech, please consider this patch, at least say yay or nay.

Patch considered. I'll up the samplerate default to 80, but not more,
since samplerates above that cause trouble for a lot of people (keyboard
doesn't work when you're moving the mouse).

The "set lower rate in case ..." part of the patch doesn't make sense.
If the user gives a too low (less than 10) samples per second, then the
original code will try to set 0, which is stupid, but harmless. The
added code will try to access beyond the bounds of the rates[] array.

> --- linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c.orig	2003-10-05 17:02:23.000000000 +0200
> +++ linux-2.6.0-test6-mm4/drivers/input/mouse/psmouse-base.c	2003-10-05 17:06:55.000000000 +0200
> @@ -40,7 +40,7 @@
>  
>  static int psmouse_noext;
>  int psmouse_resolution;
> -unsigned int psmouse_rate = 60;
> +unsigned int psmouse_rate = 200;
>  int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
>  unsigned int psmouse_resetafter;
>  
> @@ -450,6 +450,11 @@
>  	int i = 0;
>  
>  	while (rates[i] > psmouse_rate) i++;
> +
> +	/* set lower rate in case requested rate fails */
> +	if (rates[i])
> +		psmouse_command(psmouse, rates + i + 1, PSMOUSE_CMD_SETRATE);
> +
>  	psmouse_command(psmouse, rates + i, PSMOUSE_CMD_SETRATE);
>  }
>  
> 
> -- 
> /Martin



-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
