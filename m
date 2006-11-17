Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWKQSkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWKQSkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbWKQSkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:40:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27575 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752255AbWKQSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:40:07 -0500
Date: Fri, 17 Nov 2006 18:40:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static inline void slow_imageblit(const struct fb_image *image,
> > +                                 struct fb_info *p, u8 __iomem *dst,
> > +                                 u32 start_index, u32 pitch_index)
> 
> I still have my problem there: for example if image data are
> 0, 0, 0x54, 0, ...
> 
> then slow_imageblit() will write into the frame buffer, the following bytes:
> 0, 0, 0x2a, 0, ...
> 
> instead of the initial ones:
> 0, 0, 0x54, 0, ...
> 
> Bits of each bytes are reversed. I already tried to explain my
> problem, please look at
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2
 
Are those actually numbers? If they are the problem isn't byte reversal 
but bit shifting.

1010100 = 54
0101010 = 2A
 
> > +       if (fb_logo.depth == 1) {
> > +               if (info->fix.visual == FB_VISUAL_MONO01) {
> > +                       u32 fg = image.fg_color;
> > +
> > +                       image.fg_color = image.bg_color;
> > +                       image.bg_color = fg;
> 
> I had to fix this part to make the bootup logo worked. image.fg_color
> is not uninitialised at this point. I had to change this part as
> follow:
> 
> 	if (fb_logo.depth == 1) {
> 		image.fg_color = (info->fix.visual == FB_VISUAL_MONO01) ? 1:
> 0;
> 		image.bg_color = !image.fg_color;
> 	}
> 
> Otherwise this part of your patch (the one which fix the logo display)
> seems ok for my naive look. It would be nice if this part could be
> sent in a single patch to Andrew. I already tried to fix it but your
> patch looks better.

Your right about the colors not being set for mono logo. Your above fix is 
not correct but it needs to be fixed. I really don't understand why 
fbmem.c has its own routines to handle the logo for the color map. I can 
set creating a fbcmap and calling fb_set_cmap instead. That will be a 
separte patch.

