Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135204AbRDLPmv>; Thu, 12 Apr 2001 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135181AbRDLPml>; Thu, 12 Apr 2001 11:42:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35280 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135204AbRDLPm2>;
	Thu, 12 Apr 2001 11:42:28 -0400
Date: Thu, 12 Apr 2001 11:42:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.GSO.4.21.0104121113370.19944-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104121136550.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Alexander Viro wrote:

> Bad idea. If you do loops over directory contents you will almost
> permanently have almost all dentries freeable. Doesn't make freeing
> them a good thing - think of the effects it would have.
> 
> Simple question: how many of dentries in /usr/src/linux/include/linux
> are busy at any given moment during the compile? At most 10, I suspect.
> I.e. ~4%.
> 
> I would rather go for active keeping the amount of dirty inodes low,
> so that freeing would be cheap. Doing massive write_inode when we
> get low on memory is, indeed, a bad thing, but you don't have to
> tie that to freeing stuff. Heck, IIRC you are using quite a similar
> logics for pagecache...

PS: with your approach negative entries are dead meat - they won't be
caught used unless you look at them exactly at the moment of d_lookup().

Welcome to massive lookups in /bin due to /usr/bin stuff (and no, shell
own cache doesn't help - it's not shared; think of scripts).

IOW. keeping dcache/icache size low is not a good thing, unless you
have a memory pressure that requires it. More agressive kupdate _is_
a good thing, though - possibly kupdate sans flushing buffers, so that
it would just keep the icache clean and let bdflush do the actual IO.

