Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVCTWBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVCTWBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCTWBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:01:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:58333 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261295AbVCTWAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:00:43 -0500
Date: Sun, 20 Mar 2005 23:02:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Antonino Daplas <adaplas@pol.net>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net, Alex Kern <alex.kern@gmx.de>,
       Ani Joshi <ajoshi@shell.unixbox.com>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sf.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
In-Reply-To: <200503210453.47487.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.62.0503202255060.2508@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
 <200503210453.47487.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Antonino A. Daplas wrote:

> On Sunday 20 March 2005 06:59, Jesper Juhl wrote:
> > Checking a pointer for NULL before calling kfree() on it is redundant,
> > kfree() deals with NULL pointers just fine.
> > This patch removes such checks from files in drivers/video/
> >
> > Since this is a fairly trivial change (and the same change made
> > everywhere) I've just made a single patch for all the files and CC all
> > authors/maintainers of those files I could find for comments. If spliting
> > this into one patch pr file is prefered, then I can easily do that as
> > well.
> >
> 
> [snip]
> 
> > --- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16
> > 15:45:26.000000000 +0100 +++
> > linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19
> > 22:27:39.000000000 +0100 @@ -199,8 +199,7 @@ static void bit_putcs(struct
> > vc_data *vc
> >  		count -= cnt;
> >  	}
> >
> > -	if (buf)
> > -		kfree(buf);
> > +	kfree(buf);
> >  }
> >
> 
> This is performance critical, so I would like the check to remain. A comment
> may be added in this section.
> 
Ok, I believe Andrew already merged the patch into -mm, if you really want 
that check back then I'll send him a patch to put it back and add a 
comment once he puts out the next -mm.
But, at the risk of exposing my ignorance, I have to ask if it wouldn't 
actually perform better /without/ the if(buf) bit?  The reason I say that 
is that the generated code shrinks quite a bit when it's removed, and also 
kfree() itself does the same NULL check as the very first thing, so it 
comes down to the bennefit of shorter generated code, one less branch, 
against the overhead of a function call - and how often will 'buf' be 
NULL? if buff is != NULL the majority of the time, then it should be a 
gain to remove the if().


> >  static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
> > @@ -273,8 +272,7 @@ static void bit_cursor(struct vc_data *v
> >  		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
> >  		if (!dst)
> >  			return;
> > -		if (ops->cursor_data)
> > -			kfree(ops->cursor_data);
> > +		kfree(ops->cursor_data);
> >  		ops->cursor_data = dst;
> >  		update_attr(dst, src, attribute, vc);
> >  		src = dst;
> > @@ -321,8 +319,7 @@ static void bit_cursor(struct vc_data *v
> >  		if (!mask)
> >  			return;
> >
> > -		if (ops->cursor_state.mask)
> > -			kfree(ops->cursor_state.mask);
> > +		kfree(ops->cursor_state.mask);
> >  		ops->cursor_state.mask = mask;
> 
> Although these are also performance critical, I will agree that the checks
> can go.  Very rarely will ops->cursor_state.mask and ops->cursor_data be
> NULL.
> 
> As for the rest, they are acceptable, as long as the maintainers agree.
> 
Ok, thank you for commenting.


-- 
Jesper Juhl

