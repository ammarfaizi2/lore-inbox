Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291451AbSBSQMT>; Tue, 19 Feb 2002 11:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291455AbSBSQML>; Tue, 19 Feb 2002 11:12:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:65479 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291454AbSBSQL7>;
	Tue, 19 Feb 2002 11:11:59 -0500
Date: Tue, 19 Feb 2002 11:11:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Steve Lord <lord@sgi.com>
cc: Nakayama Shintaro <nakayama@tritech.co.jp>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        shojima@tritech.co.jp, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BKL removal from VFS
In-Reply-To: <1014134071.3384.82.camel@jen.americas.sgi.com>
Message-ID: <Pine.GSO.4.21.0202191102430.9938-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Feb 2002, Steve Lord wrote:

> Al, I am not proposing this to go in, but what is your opinion on a
> change like this? XFS does not need the BKL at all, so for some aim7
> experiments on large systems this  patch was used to bypass the BKL for
> filesystems which state they can live without it:

> +#define lock_kernel_optional(ip)	\
> +	if (!(ip->i_flags & S_NOBKL))	lock_kernel()
> +

Denied.  No way in hell that (or similar) will ever go in.  Locking must
be consistent, _period_.  No provisions for "legacy drivers" and crap
like that - it's a standard policy in all kernel and that had been discussed
a lot of times.

_Please_, check 2.5.  We already don't take BKL on majority of directory
operations.  The rest will follow pretty soon.

In particular, in current Linus' tree there are 3 (three) instances of
lock_kernel() in fs/namei.c.  Namely, ->permission() and two calls of
d_move().  The latter will go when ->d_parent mess is cleaned up.  The
former will go as soon as we get to ->setattr()/->permission() cleanups -
hopefully in a week or so.

In general, such changes are done by global lock shifting - simultaneous
for all instances and being a trivial search-and-replace.  Once the lock
is taken inside the method individual filesystems/drivers/etc. can
shrink the protected areas - in separate patches.

That's how it works - and that's how it had been done for most of the methods
already.  Magic flags that make locking different for different instances
are Not Good.  And not needed - see above for the usual way to do that stuff.

