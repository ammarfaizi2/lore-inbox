Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266703AbSKHB1N>; Thu, 7 Nov 2002 20:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266704AbSKHB1N>; Thu, 7 Nov 2002 20:27:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:34944 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266703AbSKHB1N>;
	Thu, 7 Nov 2002 20:27:13 -0500
Date: Thu, 7 Nov 2002 17:33:49 -0800
From: Richard Henderson <rth@twiddle.net>
To: George France <france@handhelds.org>,
       axp-list mailing list <axp-list@redhat.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate compile warnings
Message-ID: <20021107173349.A4017@twiddle.net>
Mail-Followup-To: George France <france@handhelds.org>,
	axp-list mailing list <axp-list@redhat.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20021106214705.A15525@Marvin.DL8BCU.ampr.org> <02110709222600.14483@shadowfax.middleearth> <20021107202855.B17028@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107202855.B17028@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Thu, Nov 07, 2002 at 08:28:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As for the patch itself, it's not correct.  At a glance,

> 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
> -	if (addr != -ENOMEM)
> +	if (addr != (unsigned) -ENOMEM)

addr is unsigned long.  If you truncate -ENOMEM to 32-bits, it will
never match.  There appears to be much more int/long confusion later.

You have to be /exceedingly/ careful to fix these warnings without
introducing new bugs.  If you change the type of a variable, you 
have to examine each and every use of the variable to determine if
the semantics are unchanged.  If you add a cast, you have to be sure
that you cast to a type of the correct width.  If you're adding lots
of casts, you should think about changing the type of one or more
variables.

It's enough to make me wish we had -Wno-sign-compare in CFLAGS by
default for the nonce.  Which, incidentally, is what I've been doing
for my own builds.

There's absolutely no way I'm going to apply a jumbo patch that
changes hundreds of these at once.  If you still want to fix these,
then you'll need to send them one at a time and include analysis of
why each change is correct.


r~
