Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSA3ACP>; Tue, 29 Jan 2002 19:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSA3ABC>; Tue, 29 Jan 2002 19:01:02 -0500
Received: from www.transvirtual.com ([206.14.214.140]:10255 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287145AbSA2X7j>; Tue, 29 Jan 2002 18:59:39 -0500
Date: Tue, 29 Jan 2002 15:59:26 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev accel wrapper. II
In-Reply-To: <Pine.GSO.4.21.0201291034460.3801-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10201291507020.29648-100000@www.transvirtual.com>
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
> > +	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
> > +		region.color = attr_bgcol_ec(p,vc);
> > +	else {
> > +		if (info->var.bits_per_pixel > 16)
> > +			region.color = ((u32*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
> > +		else
> > +			region.color = ((u16*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
> > +	}
> 
> What about non-pseudocolor modes with bpp <= 8? We still use the 16-bit wide
> pseudo-palette in that case?
> 
> Alternatively we can always use the 32-bit wide pseudo-palette, so the test
> for info->var.bits_per_pixel can go away (assumed there are no pixel sizes
> where more than 32 bits are needed for the color information). Then a pixel
> value is just an opaque 32-bit value (cfr. fbtest).

   I have been giving it some thought plus with the conversation with
Petr. The whole point of pseudo_palette was to be a generic data storage
area to pass around in the upper layers without the upper layers touching
it. Even having those simple test in fbcon-accel.c defeats this purpose.
  
  I now feel it is best if we set psuedo_palette to u32 size. The way to
look at pseudo_palette[regno] is not as a place where a pixel value is
stored but a place where device specific data is held. That device
specific data could be anything. We just know that data is related to
a specific color from the palette for the console system. The value in 
pseudo_palette[x] might not match the framebuffer lay out. The value could
be something that optimizes the graphics accelerator when dealing with
colors. For example as Petr pointed out we can fill psuedo_palette[indx] 
with "(value << 16) | value" in 16bpp case. This will make several accelerators 
(such as MGA...) much happier. If we use (value * 0x01010101) for 8bpp the
MGA bitblt/clear functions can be exactly identical for all color depths.
   This is one of the goals. To provide one function for all color depths.
We now have the above as  

void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy, 
                       int sx, int height, int width)
{
    struct fb_info *info = p->fb_info;
    struct fb_fillrect region;

    if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
        region.color = attr_bgcol_ec(p,vc);
    else 
        region.color = info->pseudo_palette)[attr_bgcol_ec(p,vc)];
      
    height++;
    region.dx = sx * fontwidth(p);
    region.dy = sy * fontheight(p);
    region.width = width * fontwidth(p);
    region.height = height * fontheight(p);
    region.rop = ROP_COPY;

    info->fbops->fb_fillrect(info, &region);
}
  
As you can see the upper layer function doesn't care what data is in
pseudo_palette[x]. It just grabs that data and pushes it to xxxfb_fillrect
which does care about the format. How will the driver put the proper data
into pseudo_palette. With xxxfb_setcolreg which handles the hardware
specific stuff. Again this is hidden from the upper layers. Both
xxxfb_setcolreg and xxxfb_fillrect can then work at any color depth.
What do you think?

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/




