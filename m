Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133079AbRDLP1j>; Thu, 12 Apr 2001 11:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133083AbRDLP13>; Thu, 12 Apr 2001 11:27:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37306 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133079AbRDLP1U>;
	Thu, 12 Apr 2001 11:27:20 -0400
Date: Thu, 12 Apr 2001 11:27:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.LNX.4.21.0104121202090.18260-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.GSO.4.21.0104121113370.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Rik van Riel wrote:

> Please take a look at Ed Tomlinson's patch. It also puts pressure
> on the dcache and icache independent of VM pressure, but it does
> so based on the (lack of) pressure inside the dcache and icache
> themselves.
>
> The patch looks simple, sane and it might save us quite a bit of
> trouble in making the prune_{icache,dcache} functions both able
> to avoid low-memory deadlocks *AND* at the same time able to run
> fast under low-memory situations ... we'd just prune from the
> icache and dcache as soon as a "large portion" of the cache isn't
> in use.

Bad idea. If you do loops over directory contents you will almost
permanently have almost all dentries freeable. Doesn't make freeing
them a good thing - think of the effects it would have.

Simple question: how many of dentries in /usr/src/linux/include/linux
are busy at any given moment during the compile? At most 10, I suspect.
I.e. ~4%.

I would rather go for active keeping the amount of dirty inodes low,
so that freeing would be cheap. Doing massive write_inode when we
get low on memory is, indeed, a bad thing, but you don't have to
tie that to freeing stuff. Heck, IIRC you are using quite a similar
logics for pagecache...

