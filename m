Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSLUOPR>; Sat, 21 Dec 2002 09:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSLUOPR>; Sat, 21 Dec 2002 09:15:17 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51366 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261238AbSLUOPQ>;
	Sat, 21 Dec 2002 09:15:16 -0500
Date: Sat, 21 Dec 2002 14:22:26 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021221142226.GA24941@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ed Tomlinson <tomlins@cam.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org> <200212181803.23279.tomlins@cam.org> <20021219105909.GE29122@suse.de> <200212201829.18430.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212201829.18430.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 06:29:18PM -0500, Ed Tomlinson wrote:
 > Dave, with the pull from this morning (8am EST), it almost works modular.
 > I get:
 > 
 > Dec 20 18:20:19 oscar upsd[636]: Communication established
 > Dec 20 18:20:47 oscar kernel: Linux agpgart interface v0.100 (c) Dave Jones
 > Dec 20 18:20:47 oscar kernel: agpgart: Detected VIA MVP3 chipset
 > Dec 20 18:20:47 oscar kernel: agpgart: AGP aperture is 64M @ 0xe0000000
 > Dec 20 18:20:58 oscar kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
 > Dec 20 18:20:58 oscar kernel: Module agpgart cannot be unloaded due to unsafe usage in drivers/char/ag
 > p/backend.c:58

This one is due to the way AGPGART does (or has done for the last 3
years) its module locking. It does a MOD_INC_USE_COUNT as soon as
someone calls the acquire routines. (So you can't unload agpgart
whilst you've a 3d using app (like X) open).
This seems quite sensible, but these days you can't unload agpgart.ko
anyway because the chipset module (via-agp.ko in your case) already
has it 'in use', so I'm tempted to drop those bits.

 > but find this in the X startup log.
 > (EE) MGA: Failed to load module "mga_hal" (module does not exist, 0)

That's matrox's binary only X blob. Not my fault.

 > (EE) MGA(0): [agp] Out of memory (-1014)

This one is. But it may be a knock-on effect from the bug above.
I'll nail that one first.

 > (EE) MGA(0): [drm] failed to remove DRM signal handler
 > DRIUnlock called when not locked

That one's a problem for the DRI folks.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
