Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTJaE64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 23:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTJaE6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 23:58:55 -0500
Received: from web12304.mail.yahoo.com ([216.136.173.102]:41489 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263009AbTJaE6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 23:58:49 -0500
Message-ID: <20031031045849.14921.qmail@web12304.mail.yahoo.com>
Date: Thu, 30 Oct 2003 20:58:49 -0800 (PST)
From: Vinayak Kariappa <c_vinayak@yahoo.com>
Subject: 3Dfx framebuffer driver tdfxfb_cursor() bit-wise ANDing
To: linux-kernel maillist <linux-kernel@vger.kernel.org>, hmallat@cc.hut.fi
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is the code section from 
 linux-2.6.0-test9\drivers\video\tdfxfb.c

This is the 3Dfx framebuffer driver.

I have noticed that if statements with bit-wise AND 
(&) is been typed as logical AND (&&) 
i.e. all the if statements anding with FB_CUR_*

as I don't have a 3Dfx card I am unable to test.
Sorry for not attaching a patch file.


---code section---

static int tdfxfb_cursor(struct fb_info *info, struct
fb_cursor *cursor)
{
	struct tdfx_par *par = (struct tdfx_par *) info->par;
	unsigned long flags;

	/*
	 * If the cursor is not be changed this means either
we want the 
	 * current cursor state (if enable is set) or we want
to query what
	 * we can do with the cursor (if enable is not set) 
 	 */
	if (!cursor->set) return 0;

	/* Too large of a cursor :-( */
	if (cursor->image.width > 64 || cursor->image.height
> 64)
		return -ENXIO;

	/* 
	 * If we are going to be changing things we should
disable
	 * the cursor first 
	 */
	if (info->cursor.enable) {
		spin_lock_irqsave(&par->DAClock, flags);
		info->cursor.enable = 0;
		del_timer(&(par->hwcursor.timer));
		tdfx_outl(par, VIDPROCCFG, par->hwcursor.disable);
		spin_unlock_irqrestore(&par->DAClock, flags);
	}

	/* Disable the Cursor */
	if ((cursor->set && FB_CUR_SETCUR) &&
!cursor->enable)
		return 0;

	/* fix cursor color - XFree86 forgets to restore it
properly */
	if (cursor->set && FB_CUR_SETCMAP) {
		struct fb_cmap cmap = cursor->image.cmap;
		unsigned long bg_color, fg_color;

		cmap.len = 2;/* Voodoo 3+ only support 2 color
cursors*/
		fg_color = ((cmap.red[cmap.start] << 16) |
			    (cmap.green[cmap.start] << 8)  |
			    (cmap.blue[cmap.start]));
		bg_color = ((cmap.red[cmap.start+1] << 16) |
			    (cmap.green[cmap.start+1] << 8) |
			    (cmap.blue[cmap.start+1]));
		fb_copy_cmap(&cmap, &info->cursor.image.cmap, 0);
		spin_lock_irqsave(&par->DAClock, flags);
		banshee_make_room(par, 2);
		tdfx_outl(par, HWCURC0, bg_color);
		tdfx_outl(par, HWCURC1, fg_color);
		spin_unlock_irqrestore(&par->DAClock, flags);
	}

	if (cursor->set && FB_CUR_SETPOS) {
		int x, y;

		x = cursor->image.dx;
		y = cursor->image.dy;
		y -= info->var.yoffset;
		info->cursor.image.dx = x;
		info->cursor.image.dy = y;
		x += 63;
		y += 63;
		spin_lock_irqsave(&par->DAClock, flags);
		banshee_make_room(par, 1);
		tdfx_outl(par, HWCURLOC, (y << 16) + x);
		spin_unlock_irqrestore(&par->DAClock, flags);
	}

	/* Not supported so we fake it */
	if (cursor->set && FB_CUR_SETHOT) {
		info->cursor.hot.x = cursor->hot.x;
		info->cursor.hot.y = cursor->hot.y;
	}

	if (cursor->set && FB_CUR_SETSHAPE) {
		/*
	 	 * Voodoo 3 and above cards use 2 monochrome cursor
patterns.
		 *    The reason is so the card can fetch 8 words at
a time
		 * and are stored on chip for use for the next 8
scanlines.
		 * This reduces the number of times for access to
draw the
		 * cursor for each screen refresh.
		 *    Each pattern is a bitmap of 64 bit wide and 64
bit high
		 * (total of 8192 bits or 1024 Kbytes). The two
patterns are
		 * stored in such a way that pattern 0 always
resides in the
		 * lower half (least significant 64 bits) of a 128
bit word
		 * and pattern 1 the upper half. If you examine the
data of
		 * the cursor image the graphics card uses then from
the
		 * begining you see line one of pattern 0, line one
of
		 * pattern 1, line two of pattern 0, line two of
pattern 1,
		 * etc etc. The linear stride for the cursor is
always 16 bytes
		 * (128 bits) which is the maximum cursor width
times two for
		 * the two monochrome patterns.
		 */
		u8 *cursorbase = (u8 *) info->cursor.image.data;
		char *bitmap = (char *)cursor->image.data;
		char *mask = cursor->mask;
		int i, j, k, h = 0;

		for (i = 0; i < 64; i++) {
			if (i < cursor->image.height) {
				j = (cursor->image.width + 7) >> 3;
				k = 8 - j;

				for (;j > 0; j--) {
				/* Pattern 0. Copy the cursor bitmap to it */
					fb_writeb(*bitmap, cursorbase + h);
					bitmap++;
				/* Pattern 1. Copy the cursor mask to it */
					fb_writeb(*mask, cursorbase + h + 8);
					mask++;
					h++;
				}
				for (;k > 0; k--) {
					fb_writeb(0, cursorbase + h);
					fb_writeb(~0, cursorbase + h + 8);
					h++;
				}
			} else {
				fb_writel(0, cursorbase + h);
				fb_writel(0, cursorbase + h + 4);
				fb_writel(~0, cursorbase + h + 8);
				fb_writel(~0, cursorbase + h + 12);
				h += 16;
			}
		}
	}
	/* Turn the cursor on */
	cursor->enable = 1;
	info->cursor = *cursor;
	mod_timer(&par->hwcursor.timer, jiffies+HZ/2);
	spin_lock_irqsave(&par->DAClock, flags);
	banshee_make_room(par, 1);
	tdfx_outl(par, VIDPROCCFG, par->hwcursor.enable);
	spin_unlock_irqrestore(&par->DAClock, flags);
	return 0;
}


Thanks,
Vinayak


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
