Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756720AbWKVTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbWKVTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbWKVTn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:43:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8352 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756720AbWKVTnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:43:25 -0500
Date: Wed, 22 Nov 2006 19:43:18 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611221930510.26028@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org> 
 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com> 
 <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org> 
 <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com> 
 <Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org>
 <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going away for the weekend so you wouldn't here from me but I will 
look over the code and test it out.

On Wed, 22 Nov 2006, Franck Bui-Huu wrote:

> James Simmons wrote:
> > Lets look at the new code that I have done with your above parameters.
> >
> >        for (i = image->height; i--; ) {
> >                shift = val = 0;
> >                n = image->width;
> >                dst = (u32 __iomem *) dst1;
> >
> > 		while (n--) {
> > 			if (!s) { src++; s = 32; }
> > 			s -= 1;
> > 			color = (swapb32p(src) & (1 << s)) ? 1 : 0;
> > 			val |= color << shift;
> >
> > 		       /* Did the bitshift spill bits to the next long? */
> >                        if (shift >= 31) {
> >                                FB_WRITEL(val, dst++);
> >                                val = (shift == 31) ? 0 :(color >> (32 - shift));
> >                        }
> >                        shift += 1;
> >                        shift &= (32 - 1);
> >                }
> >
> >                [ ...]
> >
> > with 's' taking values from 31 to 0, and 'shift' taking values from 0 to
> > 31. In the case of bits_per_pixel = 1 we have
> >
> > s -= 1;
> > color = (swapb32p(src) & (1 << s)) ? 1 : 0;
> > val |= color << shift;
> 
> I suppose here that you meant 'swab32p' instead of 'swapb32p'. I can't
> find any definition of 'swapb32p' and in your last patch you sent you
> is using 'swab32p' which converts a 32-bits little endian word into a
> 32-bits big endian one.
> 
> >
> > which reduces to val = color;
> >
> > I'm I seeing it wrong?
> 
> Well, I would say yes you are. If src = { 0xa3, 0x30, 0xef, 0x72 ...}
> 
> 	swab32p(src) -> 0x72ef30a3 -> 01110010 11101111 00110000 10100011
> 
> 
> during loop #1 (s=31, shift=0):
> 
> 	color = 0x72ef30a3 & (1<<31) ? 1 : 0;	color is 0
> 	val |= 0 << 0;				val is 0
> 
> during loop #2 (s=30, shift=1):
> 
> 	color = 0x72ef30a3 & (1<<30) ? 1 : 0;	color is 1
> 	val |= 1 << 1;				val is 2
> 	
> during loop #3 (s=29, shift=2):
> 
> 	color = 0x72ef30a3 & (1<<29) ? 1 : 0;	color is 1
> 	val |= 1 << 2;				val is 6
> 
> during loop #4 (s=28, shift=3):
> 
> 	color = 0x72ef30a3 & (1<<28) ? 1 : 0;	color is 1
> 	val |= 1 << 3;				val is 0xe
> 
> during loop #5 (s=27, shift=4):
> 
> 	color = 0x72ef30a3 & (1<<27) ? 1 : 0;	color is 0
> 	val |= 0 << 4;				val is 0xe
> 
> during loop #6 (s=26, shift=5):
> 
> 	color = 0x72ef30a3 & (1<<26) ? 1 : 0;	color is 0
> 	val |= 0 << 5;				val is 0xe
> 
> during loop #7 (s=25, shift=6):
> 
> 	color = 0x72ef30a3 & (1<<25) ? 1 : 0;	color is 1
> 	val |= 1 << 6;				val is 0x4e
> 
> during loop #8 (s=24, shift=7):
> 
> 	color = 0x72ef30a3 & (1<<24) ? 1 : 0;	color is 0
> 	val |= 0 << 7;				val is 0x4e
> 
> and so on...
> 
> Finally val -> 11000101 00001100 11110111 01001110 -> 0xc50cf74e
> 
> and FB_WRITEL(val, dst++) will write { 0x4e, 0xf7, 0x0c, 0xc5} into
> the frame buffer.
> 
> Am I seeing it wrong ?
> 
> > BTW what is your visual?
> >
> 
> FYI, I give you all screen info, maybe something is miss-initialized...
> 
> static struct fb_fix_screeninfo t6963c_fb_fix __initdata = {
> 	.id		= DRIVER_NAME,
> 	.type		= FB_TYPE_PACKED_PIXELS,
> 	.visual		= FB_VISUAL_MONO01,
> 	.accel		= FB_ACCEL_NONE,
> };
> 
> static struct fb_var_screeninfo t6963c_fb_var __initdata = {
> 	.bits_per_pixel	= 1,
> 	.red		= {0, 1, 0},
> 	.green		= {0, 1, 0},
> 	.blue		= {0, 1, 0},
> 	.transp		= {0, 0, 0},
> 	.activate	= FB_ACTIVATE_NOW,
> 	.height		= -1,		/* height of picture in mm */
> 	.width		= -1,		/* width of picture in mm */
> 	.accel_flags	= 0,
> 	.vmode		= FB_VMODE_NONINTERLACED,
> };
> 
> 		Franck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
