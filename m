Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTGBHkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 03:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTGBHkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 03:40:21 -0400
Received: from mail.zmailer.org ([62.240.94.4]:9651 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261797AbTGBHkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 03:40:16 -0400
Date: Wed, 2 Jul 2003 10:54:38 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-ID: <20030702075438.GO28900@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0307012206530.2047-100000@home.osdl.org> <200307020902.05522.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307020902.05522.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 09:02:05AM +0200, Bernardo Innocenti wrote:
> On Wednesday 02 July 2003 07:09, Linus Torvalds wrote:
>  > > Why 64-bit divides in particular were victimised in this manner is a
>  > > matter for speculation ;)
>  >
>  > Because gcc historically _cannot_ generate an efficient 64/32->64
>  > divide. It ends up doing a full 64/64 divide thing.
> 
>  You're right here. I've been too quick in putting my faith in gcc ;-)
> 
>  Shouldn't we complain to the gcc people? The 64/32 division is a
> rather common operation in many applications besides the kernel, so
> you'd expect gcc to get it right without polluting every single
> project with reimplementations of do_div().

The thinking behind there has been:
 a) arbitrary 64/32 division is _rare_, and shall be used only
    in places that are non-critical to system speed
 b) all places in filesystems, etc. should handle things by
    doing these things with  >>  operators, which of course,
    requires divisor to be power of two, and given as log2()
    of the divisor.
 c) to see usage of sub-optimal speed things, linkage against
    libgcc is expressly forbidden in kernel.

Thus when you see that  _divxyz3()  can not be linked in, the
bug is in its _need_, and thus the code, not in lack of library
to supply it!   The  do_div64()  is there to supply those non-
speed-critical rare uses.

At some platforms there is no way around this rule, but Linux's
primary platform is i386, and there those enforcements are shown.

To an extent, for example  Alpha  platform got several libgcc
functions copied in its arch library, to solve some unavoidable
builtin function needs, while still not blindly linking with
libgcc.

> -- 
>   // Bernardo Innocenti - Develer S.r.l., R&D dept.
> \X/  http://www.develer.com/

/Matti Aarnio
