Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUJKAdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUJKAdS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 20:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUJKAdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 20:33:18 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:65494 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268582AbUJKAdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 20:33:14 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Problem with current fb_get_color_depth function
Date: Mon, 11 Oct 2004 08:33:10 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
References: <20041010225903.GA2418@darjeeling.triplehelix.org>
In-Reply-To: <20041010225903.GA2418@darjeeling.triplehelix.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410110832.19978.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 06:59, Joshua Kwan wrote:
> because on advice from Andrew Suffield and Matthew Garrett the first
> conditional was a roundabout way to check for grayscale displays, where
> you can't actually have 24 bits (8 + 8 + 8) of gray. So it is suitable
> to just return one of the values arbitrarily. But I noticed there was
> also a grayscale variable, so I substituted that for the conditional
> and my logo reappeared again :)
>
> So is radeonfb or fb_get_color_depth at fault here? Or was the logo
> never appropriate for my display in the first place? (Unlikely, the
> CLUT224 linux logo always displayed perfectly for me until now.)
>

This is because radeonfb chooses directcolor for its visual.  With RGB565,
the depth == 16, true.  However, unlike truecolor where color values are
hardwired to linear values, directcolor looks at the hardware CLUT.

So, with directcolor RGB656, these are the CLUT lengths:

Red and Blue = 32 (2 ^ 5)
Green        = 64 (2 ^ 6)

(And you can see this in radeonfb_base:radeonfb_setcolreg())

		if (rinfo->bpp == 16) {
			pindex = regno * 8;

			if (rinfo->depth == 16 && regno > 63)
				return 1;
			if (rinfo->depth == 15 && regno > 31)
				return 1;

However, linux_logo_224 requires a CLUT with these lengths:

Red = Green = Blue = 224;

So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555 or
RGB565 because the logo clut requirements exceeds the hardware clut
capability. You need to use a logo image with a lower depth such as the
16-color logo, linux_logo_16.

In short, fb_get_color_depth() and radeonfb both do the correct thing, but
you need a logo with a lower color depth. Or choose RGB888 or higher, or
set the visual to truecolor.

Tony

PS: Note that this behavior is the same as 2.4 behavior (224-color logo is
only chosen if directcolor and bpp >= 24).  It might have worked before, and
this is probably due to the directcolor clut being ramped to truecolor
values. However, the correct solution is to use a 16-color logo.




 




