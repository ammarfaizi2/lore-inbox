Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbTKSLue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 06:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTKSLue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 06:50:34 -0500
Received: from pD951C2B8.dip.t-dialin.net ([217.81.194.184]:59776 "EHLO
	defiant.crash") by vger.kernel.org with ESMTP id S264040AbTKSLuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 06:50:32 -0500
From: Ronald Lembcke <es186@fen-net.de>
Date: Wed, 19 Nov 2003 12:50:16 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ronald Lembcke <es186@fen-net.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: bugfix =?iso-8859-1?Q?f=FC?=
	=?iso-8859-1?Q?r?= RadeonFB (against 2.4.22-ac4, bug in 2.6.0-test9, too)
Message-ID: <20031119115016.GA2912@defiant.crash>
References: <20031105225724.GA21030@defiant.crash> <Pine.GSO.4.21.0311191043110.7852-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0311191043110.7852-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 10:50:22AM +0100, Geert Uytterhoeven wrote:
> Your change is not correct: bpp is the _physical_ bits per pixel, i.e. it's 16
> for both color depth 15 (5/5/5 mode) and color depth 16 (5/6/5).
> 
> To differentiate between 5/5/5 and 5/6/5, you have to look at green.length, and
> apply standard fbdev fit-our-round-up[*] rules.
I don't see where this rule applies here. I searched on google, but
did't find anything about rounding of color depth.

> Note that some hardware in addition does RGBA4444, too.
Yes, but that nothing to do with these patches.

Sorry, I don't see, where my patches for intelfb and radonfb (as said
before, I'm not sure about the imsttfb patch anyway) make the driver
less correct. Where are they wrong?

Nothing about the use of bits_per_pixel is changed.
The only change is whether 555 or 565 is default.

If those patches are wrong, than matroxfb and rivafb are buggy, too:

matrox/matroxfb_crtc2.c:
	if (var->bits_per_pixel == 16) {
		if (var->green.length == 5) {
			var->red.offset = 10;
			var->red.length = 5;
			var->green.offset = 5;
			var->green.length = 5;
			var->blue.offset = 0;
			var->blue.length = 5;
			var->transp.offset = 15;
			var->transp.length = 1;
			*mode = 15;
		} else {
			var->red.offset = 11;
			var->red.length = 5;
			var->green.offset = 5;
			var->green.length = 6;
			var->blue.offset = 0;
			var->blue.length = 5;
			var->transp.offset = 0;
			var->transp.length = 0;
		}



riva/fbdev.c
        switch (v.bits_per_pixel) {
[...]
	case 9 ... 15:
		v.green.length = 5;
		/* fall through */
	case 16:
		v.bits_per_pixel = 16;
		nom = 2;
		den = 1;
		if (v.green.length == 5) {
			/* 0rrrrrgg gggbbbbb */
			v.red.offset = 10;
			v.green.offset = 5;
			v.blue.offset = 0;
			v.red.length = 5;
			v.green.length = 5;
			v.blue.length = 5;
		} else {
			/* rrrrrggg gggbbbbb */
			v.red.offset = 11;
			v.green.offset = 5;
			v.blue.offset = 0;
			v.red.length = 5;
			v.green.length = 6;
			v.blue.length = 5;
		}
		break;


They do the same thing as intelfb and radonfb with the patches applied.
So both must be wrong or right.

Roni
