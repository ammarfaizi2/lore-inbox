Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSLWMDG>; Mon, 23 Dec 2002 07:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSLWMDG>; Mon, 23 Dec 2002 07:03:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16813 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264672AbSLWMDF>;
	Mon, 23 Dec 2002 07:03:05 -0500
Date: Mon, 23 Dec 2002 12:10:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Message-ID: <20021223121022.GA32080@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
References: <20021221142226.GA24941@suse.de> <20021223021009.C6CC32C0E3@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223021009.C6CC32C0E3@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 12:10:47PM +1100, Rusty Russell wrote:
 > > This one is due to the way AGPGART does (or has done for the last 3
 > > years) its module locking. It does a MOD_INC_USE_COUNT as soon as
 > > someone calls the acquire routines.
 > Which is racy under SMP, and under preempt, which is why it's
 > deprecated.

Crapola. I've just realised why this is no longer relevant.
I've moved what this was protecting into the per chipset modules.
Right now its possible to load modules, start x (which loads DRM),
then rmmod via_agp from under its feet. result - boom when something
tries to use 3d.

Sure it's unlikely someone would be crazy enough to try and do this,
and they deserve what they get, but it's not exactly clean, or nice.

So where is the documentation describing module locking de jour ?

 > > (So you can't unload agpgart whilst you've a 3d using app (like X)
 > > open).  This seems quite sensible, but these days you can't unload
 > > agpgart.ko anyway because the chipset module (via-agp.ko in your
 > > case) already has it 'in use', so I'm tempted to drop those bits.
 > If this is true (it usually is), you can simply drop them.

I'll need 'something' in the chipset drivers. The first thing that
jumps to mind is to give the chipset drivers an 'acquire' op
which does the locking much like the old agp_backend_acquire() does.
 
 > There are other cases where the caller is not grabbing references, so
 > MOD_INC_USE_COUNT is better than nothing (should the warning stay for
 > 2.6?  Good question).

Why exactly isn't it safe any more?  If there's documentation on this,
I'd love to read it. If there isn't, there really should be.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
