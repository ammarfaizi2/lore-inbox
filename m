Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281171AbRKTRT5>; Tue, 20 Nov 2001 12:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKTRTs>; Tue, 20 Nov 2001 12:19:48 -0500
Received: from chaos.ao.net ([205.244.242.21]:42693 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S281171AbRKTRTk>;
	Tue, 20 Nov 2001 12:19:40 -0500
Message-Id: <200111201719.fAKHJGYR000699@vulpine.ao.net>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb bug: text ends up scrolling in the middle of t 
Date: Tue, 20 Nov 2001 12:19:16 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Petr Vandrovec" writes:
> On 19 Nov 01 at 23:38, Dan Merillat wrote:
> > > they'll shed some light on the problem.
> > 
> > Yes, yes.  The boot messages are normal, and typing 'reset' once I login 
> > restores normal console.  The code that sets up a scrolling window below tu
x
> > is well, missing the mark.
> > 
> > Tux looks like he's about 5 lines high, so lines 1-3 are tux, 4 is the one
> > line of scroll, 5 is his feet, and 6-30 is the previous kernel boot
> > messages.
> 
> It is known problem. At least known to me. After reboot and typing 'reset'
> type 'dmesg' and then look for 'Console: switching to colour frame buffer 
> device...'. Above that message you'll find couple of radeon messages - 
> and you have to remove all printed during register_framebuffer() from
> driver source - it looks to me like that '#if 1'-ed code in radeon_write_code
> is suspect.

Bingo, that does it exactly.

> You must not do any output during register framebuffer. If you'll output
> one line, I believe that it will still work, but if you'll do more, 
> kernel output is catched in upper Tux window instead of in the bottom half 
> of screen. And if you'll print really much of info during 
> register_framebuffer, kernel will die...

Well, that's a good reason to get this patch into the 2.4.15-final, then.


--- radeonfb.c.orig	Tue Nov 20 12:08:54 2001
+++ radeonfb.c	Tue Nov 20 12:09:24 2001
@@ -2347,7 +2347,7 @@
 	OUTREG(CRTC_OFFSET, 0);
 	OUTREG(CRTC_OFFSET_CNTL, 0);
 	OUTREG(CRTC_PITCH, mode->crtc_pitch);
-#if 1
+#if 0
 	printk("CRTC_H_TOTAL_DISP = 0x%x, H_SYNC = 0x%x\n",
 		mode->crtc_h_total_disp, mode->crtc_h_sync_strt_wid);
 	printk("CRTC_V_TOTAL_DISP = 0x%x, V_SYNC = 0x%x\n",
