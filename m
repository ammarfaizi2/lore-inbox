Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290825AbSBLRVU>; Tue, 12 Feb 2002 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSBLRVL>; Tue, 12 Feb 2002 12:21:11 -0500
Received: from www.transvirtual.com ([206.14.214.140]:23565 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290779AbSBLRVG>; Tue, 12 Feb 2002 12:21:06 -0500
Date: Tue, 12 Feb 2002 09:20:53 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] accel wrapper again
In-Reply-To: <Pine.GSO.4.21.0202120913150.12840-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10202120900200.18583-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy, int sx,
> > +		       int height, int width)
> > +{
> > +	struct fb_info *info = p->fb_info;
> > +	struct fb_fillrect region;
> > +
> > +	region.color = attr_bgcol_ec(p,vc);
> > +	region.dx = sx * fontwidth(p);
> > +	region.dy = sy * fontheight(p);
> > +	region.width = width * fontwidth(p);
> > +	region.height = height * fontheight(p);
> > +	region.rop = ROP_COPY;
> > +
> > +	info->fbops->fb_fillrect(info, &region);
> 
> So now fb_fillrect.color is always the index into the console palette?

Yes. Well more like it is a index into struct fb_cmap. In theory you can
call xxxfb_fillrect outside of the console system and pass in any value
for region.color. That value would just mean look at entry x. Now the code
in xxxfb_fillrect would do its magic for you. BTW I have thought about
adding ioctls to call the accel functions for the purpose of testing the
drivers accel code. It would not be meant to stay in. Just for testing
purposes only. 

> Is there any way to specify a color that's not in the console palette? This is
> very useful in {true,direct}color modes.

Yes. All I did was hide the details into xxxfb_fillrect. For example I
have been working with Denis on a new NeoMagic fdev driver converted over
to the new api. For example I have inside neofb_fillrect:

switch (info->var.bits_per_pixel)
{
	case 8:
        	par->neo2200->fgColor = rect->color;
                break;
        case 16:
                par->neo2200->fgColor = 
				((u16*)(info->pseudo_palette))[rect->color];
		break;
}

The power here is that pseudo_palette is void thus it could be anything. A
struct defining register values to be passed to the hardware etc. Another
thing is pseudo_palette has no size constrant. At present alot of drivers
implement it as 16/17 entries. It could be 10,000. Nothinmg stops us from
doing this. The upper layers don;t have to worry about the details of
what pseudo_palette is.

> How does imageblit work for the logo now, i.e. does an image contain console
> palette indices too?

Yes. 

struct fb_image {
        __u32 width;    /* Size of image */
        __u32 height;
        __u16 dx;       /* Where to place image */
        __u16 dy;
        __u32 fg_color; /* Only used when a mono bitmap */
        __u32 bg_color;
        __u8  depth;    /* Dpeth of the image */
        char  *data;    /* Pointer to image data */
};

data is a collect of indices into the current struct fb_cmap for the case
of a color image. For mono the data is a bitmap and we use the fg_color
and bg_color values. They too are indices into the current struct fb_cmap.





