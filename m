Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRCJDqE>; Fri, 9 Mar 2001 22:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130922AbRCJDpy>; Fri, 9 Mar 2001 22:45:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34698 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130921AbRCJDpu>;
	Fri, 9 Mar 2001 22:45:50 -0500
Date: Fri, 9 Mar 2001 22:45:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [RFC] Directory index for Ext2 - the pagecache version
In-Reply-To: <01030918083609.11151@gimli>
Message-ID: <Pine.GSO.4.21.0103092200520.17677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, Daniel Phillips wrote:

> Why does read_cache_page unlock the page just before returning?  I'd

Because it may find the thing in cache. Uptodate and unlocked. Since you
want the same result on all ways out of the function, you get to unlock
the thing if you had locked it - just to match the fast path.

	I have one serious problem with the patch: maybe_lock_page().
I can understand why you might want to wait on page, I can understand
why you might want to lock page2 iff page2 != page1, but...

	Aside of that - several bad problems with the style.

> +#ifndef COMBSORT
> +#define COMBSORT(size, i, j, COMPARE, EXCHANGE) { \
> +	unsigned gap = size, more, i; \
> +	do { \
> +		if (gap > 1) gap = gap*10/13; \
> +		if (gap - 9 < 2) gap = 11; \
> +		for (i = size - 1, more = gap > 1; i >= gap; i--) { \
> +			int j = i - gap; \
> +			if (COMPARE) { EXCHANGE; more = 1; } } \
> +	} while (more); }
> +#endif

Don't. Do. That.  C is not Algol 60.  Please, cut down on preprocessor
abuse.  I'm quite serious - you are using the thing once, so there is
no possible reason to write it that way.  It's not cute, it's really,
really ugly.  Make it an inline function if you think that it's
critical to keep it in-line, but for $DEITY sake, make it a C function.

> +#ifndef exchange
> +#define exchange(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)
> +#endif

Ditto. I would simply kill this one off.

> +#define dx_hash(s,n) (dx_hack_hash(s,n) << 1)

Ugh. And the point of that would be? I.e. why not shift in the
function itself?

	OK, I'll go and do incremental over my variant and do some
tweaking on my side. Then I'll put both on ftp. I _really_ don't
like the maybe_{un,}lock_page() logics. I'll try to come up
with cleaner variant, but I think that you are trying to use the
same function in situations of really different nature.
	Off to diffing the thing...
						Cheers,
							Al

PS: Call me a style fascist, but _please_ get rid of preprocessor
abuse.  Code should be readable.  Especially in the core kernel
and frequently used filesystems.

