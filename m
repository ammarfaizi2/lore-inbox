Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130774AbQLaTq6>; Sun, 31 Dec 2000 14:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130833AbQLaTqt>; Sun, 31 Dec 2000 14:46:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130774AbQLaTqd>; Sun, 31 Dec 2000 14:46:33 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test13-pre5
Date: 31 Dec 2000 11:15:51 -0800
Organization: Transmeta Corporation
Message-ID: <92o0l7$h5v$1@penguin.transmeta.com>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com> <20001231200741.F28963@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001231200741.F28963@mea-ext.zmailer.org>,
Matti Aarnio  <matti.aarnio@zmailer.org> wrote:
>
>	Actually nothing SMP specific in that problem sphere.
>	Alpha has  load-locked/store-conditional  pair for
>	this type of memory accesses to automatically detect,
>	and (conditionally) restart the operation - to form
>	classical  ``locked-read-modify-write'' operations.

Sure, we could make the older alphas use ldl_l stl_c for byte accesses,
but if you thought byte accesses on those machines were kind-of slow
before, just WAIT until that happens.

Old alpha machines (the same ones that would need this code) were
HORRIBLE at ldl_l<->stl_c: they go out all the way to the bus to set the
lock.  So suddenly your every byte access ends up being a few hundred
cycles!

So ldl_l/stc_l is not the answer.  It would work, but it would be so
slow that you'd be a lot better off not doing it. 

I think they fixed ldl/stc later on (so that it only sets a bit locally
that gets cleared by the cache coherency protocol), but as later alphas
have the byte accesses anyway that doesn't matter here. The faster
ldl/stc makes for much faster spinlocks on newer alphas, though.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
