Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHXWzD>; Sat, 24 Aug 2002 18:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHXWzD>; Sat, 24 Aug 2002 18:55:03 -0400
Received: from [203.167.79.9] ([203.167.79.9]:64783 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S315746AbSHXWzA>; Sat, 24 Aug 2002 18:55:00 -0400
Subject: Re: [Linux-fbdev-devel] cfbimgblt.c
From: Antonino Daplas <adaplas@pol.net>
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15719.32025.236298.592156@argo.ozlabs.ibm.com>
References: <1029972099.551.3.camel@daplas>
	<Pine.LNX.4.33.0208221123140.9077-200000@maxwell.earthlink.net> 
	<15719.32025.236298.592156@argo.ozlabs.ibm.com>
Content-Type: multipart/mixed; boundary="=-CLU+kFUsQcLDGKw0RoLL"
Message-Id: <1030229885.548.18.camel@daplas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Aug 2002 06:59:02 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CLU+kFUsQcLDGKw0RoLL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-08-24 at 20:33, Paul Mackerras wrote: 

Hi Paul, 

> James Simmons writes:
> 
> > Paul please test the code.
> 
> (The new cfbimgblt.c, that is.)
> 
Thanks for testing the code :)   

> It mostly seems to be fine, except there are some problems with the
> cursor.  I have only tested it with the standard 8x16 font so far
> though.  I had to add a #include <video/fbcon.h> near the top to get
> the definitions of fb_readl and fb_writel.
> 
Can you test it with a bit depth not a multiple of 32/64?  Or just force
the code to always call slow_imageblit?  I'm concerned about
slow_imageblit not correct with big endian machines. 

> It seems to be not erasing the cursor image when it should.  So, if I
> am logged in on the console and I type a few characters and then press
> backspace a few times, it leaves those character positions entirely
> white.  Also, when I press return it leaves the cursor image on that
> line as well as drawing the cursor after the shell prompt on the next
> line.
> 
It looks like a fillrect problem. 

> I just tried with the old cfbimgblt.c and it also does the same
> thing.  So it's not the new cfbimgblt.c that is doing this, it's
> something else in your fbcon changes (or just possibly mine :).  This
> is with atyfb with my patches.
> Paul.
I'm also attaching cfbfillrect.c which hopefully addresses some of the
problems which Geert mentioned before (access/pitch alignment, support
for all bit depths, etc). 

Tony 

PS. Sorry about the attachment, my mailer mangles inline text.

--=-CLU+kFUsQcLDGKw0RoLL
Content-Disposition: attachment; filename=cfbfillrect.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=cfbfillrect.c; charset=ISO-8859-1

/*
 *  Generic fillrect for frame buffers with packed pixels of any depth.=20
 *
 *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org)=20
 *
 *  This file is subject to the terms and conditions of the GNU General Pub=
lic
 *  License.  See the file COPYING in the main directory of this archive fo=
r
 *  more details.
 *
 * NOTES:
 *
 *  The code for depths like 24 that don't have integer number of pixels pe=
r=20
 *  long is broken and needs to be fixed. For now I turned these types of=20
 *  mode off.
 *
 *  Also need to add code to deal with cards endians that are different tha=
n
 *  the native cpu endians. I also need to deal with MSB position in the wo=
rd.
 *
 */
#include <linux/string.h>
#include <linux/fb.h>
#include <asm/types.h>
#include <video/fbcon.h>

#if BITS_PER_LONG =3D=3D 32
#define FB_WRITEL(x,y) fb_writel(x,y)
#define FB_READL(x)    fb_readl(x)
#else
#define FB_WRITEL(x,y) fb_writeq(x,y)
#define FB_READL(x)    fb_readq(x)
#endif

#if defined (__BIG_ENDIAN)
#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
#define SHIFT_LOW(val, bits)   ((val) << (bits))
#else
#define SHIFT_HIGH(val, bits)  ((val) << (bits))
#define SHIFT_LOW(val, bits)   ((val) >> (bits))
#endif

void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)
{
	unsigned long start_index, pitch_index;
	unsigned long height, fg, bitstart, shift, color;
	unsigned long bpp =3D p->var.bits_per_pixel;
	unsigned long null_bits =3D BITS_PER_LONG - bpp;
	unsigned long n, x2, y2, linesize =3D p->fix.line_length;
	unsigned long bpl =3D sizeof(unsigned long);
	unsigned long *dst =3D NULL;
	char *dst1, *dst2;

	if (!rect->width || !rect->height)
		return;

	/* We could use hardware clipping but on many cards you get around
	 * hardware clipping by writing to framebuffer directly. */
	x2 =3D rect->dx + rect->width;
	y2 =3D rect->dy + rect->height;
	x2 =3D x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
	y2 =3D y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
	rect->width =3D x2 - rect->dx;
	height =3D y2 - rect->dy;

	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
		fg =3D ((u32 *) (p->pseudo_palette))[rect->color];
	else
		fg =3D rect->color;

	bitstart =3D (((rect->dy * linesize) * 8) +=20
		    rect->dx * bpp);
=09
	start_index =3D bitstart & (BITS_PER_LONG - 1);

	/* line_length not a multiple of an unsigned long? */
	pitch_index =3D (linesize & (bpl - 1)) * 8;

	bitstart /=3D 8;
	bitstart &=3D ~(bpl - 1);
	dst1 =3D dst2 =3D p->screen_base + bitstart;

	switch (rect->rop) {
	case ROP_COPY:
		do {
			dst =3D (unsigned long *) dst1;
			shift =3D 0;
			color =3D 0;
			n =3D rect->width;

			/*=20
			 * read leading bits
			 */
			if (start_index) {
				unsigned long start_mask =3D ~(SHIFT_HIGH(~0UL, start_index));
			=09
				color =3D FB_READL(dst) & start_mask;
				shift =3D start_index;
			}

			while (n--) {
				color |=3D SHIFT_HIGH(fg, shift);
				if (shift >=3D null_bits) {
					FB_WRITEL(color, dst++);
					if (shift =3D=3D null_bits)
						color =3D 0;
					else
						color =3D SHIFT_LOW(color, BITS_PER_LONG - shift);
				}
				shift +=3D bpp;
				shift &=3D (BITS_PER_LONG - 1);
			}
		=09
			/*=20
			 * write trailing bits
			 */
			if (shift) {
				unsigned long end_mask =3D SHIFT_HIGH(~0UL, shift);

				FB_WRITEL((FB_READL(dst) & end_mask) | color, dst);
			}
		=09
			if (!pitch_index) {
				dst1 +=3D linesize;
			}
			else {
				dst2 +=3D linesize;
				dst1 =3D dst2;
				(unsigned long) dst1 &=3D ~(bpl - 1);
				start_index +=3D pitch_index;
				start_index &=3D BITS_PER_LONG - 1;
			}

		} while (--height);
		break;
	case ROP_XOR:
		do {
			dst =3D (unsigned long *) dst1;
			shift =3D start_index;
			color =3D 0;
			n =3D rect->width;

			while (n--) {
				color |=3D SHIFT_HIGH(fg, shift);
				if (shift >=3D null_bits) {
					FB_WRITEL(FB_READL(dst) ^ color, dst);
					dst++;
					if (shift =3D=3D null_bits)
						color =3D 0;
					else
						color =3D SHIFT_LOW(color, BITS_PER_LONG - shift);
				}
				shift +=3D bpp;
				shift &=3D (BITS_PER_LONG - 1);
			}
			if (shift)=20
				FB_WRITEL(FB_READL(dst) ^ color, dst);

			if (!pitch_index) {
				dst1 +=3D linesize;
			}
			else {
				dst2 +=3D linesize;
				dst1 =3D dst2;
				(unsigned long) dst1 &=3D ~(bpl - 1);
				start_index +=3D pitch_index;
				start_index &=3D BITS_PER_LONG - 1;
			}
		} while (--height);
		break;
	}
=09
	return;
}

--=-CLU+kFUsQcLDGKw0RoLL--


