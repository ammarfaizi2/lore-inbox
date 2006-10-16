Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWJPDht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWJPDht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 23:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWJPDht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 23:37:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751400AbWJPDhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 23:37:48 -0400
Date: Sun, 15 Oct 2006 20:37:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gareth Knight <gk@garethknight.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic signal code (small new feature - userspace signal
 mask), kernel 2.6.16
In-Reply-To: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com>
Message-ID: <Pine.LNX.4.64.0610152025300.3962@g5.osdl.org>
References: <5B1B60D4-4259-4720-A5A5-9691CA59E250@garethknight.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2006, Gareth Knight wrote:
>
> I looked in MAINTAINERS for a suitable person for the generic signal code, but
> couldn't find anyone in particular.  Please Cc me on comments, which are most
> welcome, as I am not on LKML, although I do peruse the archives.

That's a truly horribly disfigured patch - your whitespace is all screwed 
up.

Anyway, the whole approach is not doable. At all.

Why? You're doing user-space accesses from within critical sections with a 
spinlock, and that's just a big no-no. Think page faults, swapping etc.

That's ignoring all the issues with the fact that doing the user accesses 
during recalc_sigpending is broken for other reasons, namely that we don't 
even _do_ the signal pending recalculation all the time, just when we 
"know" things may have changed. So your approach would miss updates to the 
user-space masks.

So the whole approach is flawed.

You _could_ try to make it do something special at signal delivery time, 
to see if delivery can be delayed at that point, but quite frankly, it's 
going to be nasty there too (and that's going to be a disaster for the 
whole issue of non-thread-specific signals, which have been steered to one 
thread, and then the new mask would say that they can't be accepted by 
that thread after all).

Quite frankly, you'd probably be better off trying to do totally different 
approaches. For example, it would be possible to block all signals 
entirely, and then just create a new system call that uses a _synchronous_ 
delivery method to avoid races with async delivery. Preferably a file 
descriptor, so that you can select/poll on it.

That was discussed at some point. See for example:

	http://groups.google.com/group/linux.kernel/browse_thread/thread/1332715ae3e26b9/1f3fc521db812a07?lnk=st&q=&rnum=1&hl=en#1f3fc521db812a07

which I found by just googling for "synchronous signal queue" with me as 
the author. That's from almost four years ago, and nobody ever got quite 
excited enough about it to actually take it any further, but I still think 
it's a lot better than the alternatives like yours..

			Linus
