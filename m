Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVDHQ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVDHQ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVDHQ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:29:04 -0400
Received: from waste.org ([216.27.176.166]:31183 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262869AbVDHQ25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:28:57 -0400
Date: Fri, 8 Apr 2005 09:27:46 -0700
From: Matt Mackall <mpm@selenic.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Yura Pakhuchiy <pakhuchiy@iptel.by>,
       Patrice Martinez <patrice.martinez@ext.bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: buggy ia64_fls() ? (was Re: /dev/random problem on 2.6.12-rc1)
Message-ID: <20050408162746.GZ3174@waste.org>
References: <42552A33.6070704@ext.bull.net> <1112879666.2035.10.camel@chaos.void> <Pine.LNX.4.58.0504071727080.5654@localhost.localdomain> <20050407211257.GK25554@waste.org> <Pine.LNX.4.61.0504080817370.15652@openx3.frec.bull.fr> <20050408075532.GX3174@waste.org> <Pine.LNX.4.61.0504081024120.15652@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504081024120.15652@openx3.frec.bull.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 02:12:04PM +0200, Simon Derr wrote:
> I enabled the debug messages in random.c and I think I found the problem 
> lying in the IA64 version of fls().

Good catch.
 
> It turns out that the generic and IA64 versions of fls() disagree:
> 
> (output from a small test program)
> 
>      x   ia64_fls(x)      generic_fls(x)
> 
> i=-1, t=0, ia64: -65535 et generic:0
> i=0, t=1, ia64: 0 et generic:1
> i=1, t=2, ia64: 1 et generic:2
> i=2, t=4, ia64: 2 et generic:3
> i=3, t=8, ia64: 3 et generic:4

Well PPC at least sez:

/*
 * fls: find last (most-significant) bit set.
 * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
 */

And that agrees with the generic code (used by x86). So I think IA64
is probably wrong here indeed. It's amazing that the other users of
fls don't blow up spectacularly.

> I tried to fix it with an ia64 version that would give the same result as 
> the generic version, but the kernel did not boot, I guess some functions 
> rely on the ""broken"" ia64_fls() behaviour.
> 
> So I just changed fls() to use generic_fls() instead of ia64_fls().

If the "fixed" version didn't boot, how did the "alternate fixed"
version boot?

-- 
Mathematics is the supreme nostalgia of our time.
