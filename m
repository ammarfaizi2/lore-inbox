Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUEMPQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUEMPQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUEMPQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:16:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:10938 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261904AbUEMPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:16:21 -0400
Date: Thu, 13 May 2004 17:15:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040513151549.GB31123@wohnheim.fh-wedel.de>
References: <20040513134847.GA2024@dreamland.darkstar.lan> <20040513145640.GA3430@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040513145640.GA3430@dreamland.darkstar.lan>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 16:56:40 +0200, Kronos wrote:
> Kronos <kronos@kronoz.cjb.net> ha scritto:
> > do_IRQ: stack overflow: 460
> > Call Trace:
> > [<c01086be>] do_IRQ+0x3fe/0x410
> > [<c011c902>] __wake_up_locked+0x22/0x30
> > [<c010633c>] common_interrupt+0x18/0x20
> > [<c02e1baa>] radeon_write_pll_regs+0xbaa/0x1e10
> > [<c011c902>] __wake_up_locked+0x22/0x30
> > [<c02e3c5c>] radeon_calc_pll_regs+0xfc/0x120
> > [<c02e333c>] radeon_write_mode+0x35c/0xb80
> > [<c02e4509>] radeonfb_set_par+0x889/0xb50
> 
> I think that the problem is here:
> 
> int radeonfb_set_par(struct fb_info *info)
> {
>         struct radeonfb_info *rinfo = info->par;
>         struct fb_var_screeninfo *mode = &info->var;
>         struct radeon_regs newmode;
>         
> struct radeon_regs is huge: 2356 bytes
> Quick fix (I'll test ASAP):

Even quicker fix:

--- linux-2.6/drivers/video/aty/radeon_base.c~	2004-05-13 16:51:08.000000000 +0200
+++ linux-2.6/drivers/video/aty/radeon_base.c	2004-05-13 16:55:09.000000000 +0200
@@ -1397,7 +1397,7 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 	struct fb_var_screeninfo *mode = &info->var;
-	struct radeon_regs newmode;
+	static struct radeon_regs newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
 	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};

I'm not sure what the point behind the radeon_write_mode() is at all.
The best solution could be to just merge radeon_write_mode() and
radeonfb_set_par() into a single function and do the tons of OUTREG()
directly.  In that case, don't bother to fix any typos.

Ben?  Wrong analysis?

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
