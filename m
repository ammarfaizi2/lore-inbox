Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTCEUU4>; Wed, 5 Mar 2003 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTCEUU4>; Wed, 5 Mar 2003 15:20:56 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:27530 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262425AbTCEUUz>;
	Wed, 5 Mar 2003 15:20:55 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 5 Mar 2003 21:31:05 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
X-mailer: Pegasus Mail v3.50
Message-ID: <11EC6AF51A4E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Mar 03 at 20:22, James Simmons wrote:
>  
> >   And one (or two...) generic questions: why is not pseudo_palette
> > u32* pseudo_palette, or even directly u32 pseudo_palette[17] ?
> 
> pseudo_palette was originally designed to be a pointer to some kind of 
> data for color register programming. For example many PPC graphics cards 
> have a color register region. Now you could have that point to 
> pseudo_palette.  Note pseudo_palette is only visiable in fbmem.c for the 
> logo drawing code. Personally I liek to see that hidden.

cfbfillrect? cfbimageblit? Both use pseudo_palette, and both convert
it to u32*.
 
> > And why we do not fill this pseudo_palette with
> > i * 0x01010101U for 8bpp pseudocolor and i * 0x11111111U for 4bpp
> > pseudocolor? This allowed me to remove couple of switches and tests
> > from acceleration fastpaths (and from cfb_imageblit and cfb_fillrect,
> > but I did not changed these two in my benchmarks below).
> 
> ??? Does your accel engine require these kinds of values?

Yes. It is 32bit engine, and so it wants 32bit value. And even if 
not, code doing

if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
      fg = p->pseudo_palette[rect->color];
else
      fg = rect->color;

is horrible. Two conditional jumps on each rectangle. If you'll do
always lookup through pseudo_palette, not only that you get rid of
these jumps, you can also remove calls to pixel_to_pat32 (and accompanying
tables & lookups), as you do this expansion at set_var time,
instead of at blit/clear time.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

