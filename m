Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCTUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCTUyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVCTUyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:54:17 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:48559 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261279AbVCTUxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:53:49 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
Date: Mon, 21 Mar 2005 04:53:47 +0800
User-Agent: KMail/1.5.4
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net,
       Alex Kern <alex.kern@gmx.de>, Ani Joshi <ajoshi@shell.unixbox.com>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sf.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503210453.47487.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 March 2005 06:59, Jesper Juhl wrote:
> Checking a pointer for NULL before calling kfree() on it is redundant,
> kfree() deals with NULL pointers just fine.
> This patch removes such checks from files in drivers/video/
>
> Since this is a fairly trivial change (and the same change made
> everywhere) I've just made a single patch for all the files and CC all
> authors/maintainers of those files I could find for comments. If spliting
> this into one patch pr file is prefered, then I can easily do that as
> well.
>

[snip]

> --- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16
> 15:45:26.000000000 +0100 +++
> linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19
> 22:27:39.000000000 +0100 @@ -199,8 +199,7 @@ static void bit_putcs(struct
> vc_data *vc
>  		count -= cnt;
>  	}
>
> -	if (buf)
> -		kfree(buf);
> +	kfree(buf);
>  }
>

This is performance critical, so I would like the check to remain. A comment
may be added in this section.

>  static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
> @@ -273,8 +272,7 @@ static void bit_cursor(struct vc_data *v
>  		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
>  		if (!dst)
>  			return;
> -		if (ops->cursor_data)
> -			kfree(ops->cursor_data);
> +		kfree(ops->cursor_data);
>  		ops->cursor_data = dst;
>  		update_attr(dst, src, attribute, vc);
>  		src = dst;
> @@ -321,8 +319,7 @@ static void bit_cursor(struct vc_data *v
>  		if (!mask)
>  			return;
>
> -		if (ops->cursor_state.mask)
> -			kfree(ops->cursor_state.mask);
> +		kfree(ops->cursor_state.mask);
>  		ops->cursor_state.mask = mask;

Although these are also performance critical, I will agree that the checks
can go.  Very rarely will ops->cursor_state.mask and ops->cursor_data be
NULL.

As for the rest, they are acceptable, as long as the maintainers agree.

Tony


