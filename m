Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUBOUL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 15:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbUBOUL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 15:11:58 -0500
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:50818 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265178AbUBOUL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 15:11:57 -0500
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.3-rc3
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	<m2znbk4s8j.fsf@p4.localdomain> <200402152052.50596.earny@net4u.de>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Feb 2004 21:11:53 +0100
In-Reply-To: <200402152052.50596.earny@net4u.de>
Message-ID: <m28yj42jcm.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg <earny@net4u.de> writes:

> Compile warnings with new driver:
> 
> [...]
> drivers/video/aty/radeon_base.c: In function `radeon_probe_pll_params':
> drivers/video/aty/radeon_base.c:474: warning: `xtal' might be used uninitialized in this function

This looks like a real bug. I guess the patch below fixes it, but I
can't test it because that code is not executed on my hardware. (And I
doubt it will fix your problem.)

--- linux/drivers/video/aty/radeon_base.c.old	2004-02-15 21:06:02.000000000 +0100
+++ linux/drivers/video/aty/radeon_base.c	2004-02-15 20:57:22.000000000 +0100
@@ -566,8 +566,9 @@
 		break;
 	}
 
-	do_div(vclk, 1000);
-	xtal = (xtal * denom) / num;
+	vclk *= denom;
+	do_div(vclk, 1000 * num);
+	xtal = vclk;
 
 	if ((xtal > 26900) && (xtal < 27100))
 		xtal = 2700;

> drivers/video/aty/radeon_base.c: In function `radeon_screen_blank':
> drivers/video/aty/radeon_base.c:944: warning: `val2' might be used uninitialized in this function
> drivers/video/aty/radeon_base.c: In function `radeonfb_setcolreg':
> drivers/video/aty/radeon_base.c:1025: warning: `vclk_cntl' might be used uninitialized in this function
>   CC      net/sunrpc/timer.o
> drivers/video/aty/radeon_base.c: In function `radeon_calc_pll_regs':
> drivers/video/aty/radeon_base.c:1319: warning: `pll_output_freq' might be used uninitialized in this function

I think these warnings are harmless.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
