Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282378AbRKXGh7>; Sat, 24 Nov 2001 01:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282376AbRKXGhu>; Sat, 24 Nov 2001 01:37:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47808 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282375AbRKXGhm>;
	Sat, 24 Nov 2001 01:37:42 -0500
Date: Sat, 24 Nov 2001 01:37:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <Pine.GSO.4.21.0111240129470.4000-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111240132290.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Alexander Viro wrote:

> On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> 
> > you are screwed because you were running a broken filesystem: it is its
> > own business to drop the inodes if it fails, all it needs to do is to
> > call invalidate_inodes(s) internally before returning from the read_super
> > in the failure case.
> 
> Cute.  Do you realize that _every_ fs would have to do that?

Put it that way:
	* if ->read_super() decides to fail, it should evict all inodes
it had put into icache.
	* if ->put_super() does any iput(), it should take care to evict
that inode from icache.

IOW,
	* if we do iput() while we are outside of (success of ->read_super(),
call of ->put_super()) - we want that inode to be evicted ASAP.

Which is precisely what 2.4.15+patch does.

