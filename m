Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLBFpU>; Sat, 2 Dec 2000 00:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbQLBFpJ>; Sat, 2 Dec 2000 00:45:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61826 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129573AbQLBFpD>;
	Sat, 2 Dec 2000 00:45:03 -0500
Date: Sat, 2 Dec 2000 00:14:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Steven Van Acker <deepstar@ulyssis.org>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext2 directory size bug (?)
In-Reply-To: <20001202175704.B269@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.21.0012020007270.27040-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Chris Wedgwood wrote:

> On Thu, Nov 30, 2000 at 08:24:02AM -0500, Richard B. Johnson wrote:
> 
>     This is actually a feature. The directory does not get truncated.
> 
> Arguably directories could be truncated when objects towards the end
> are removed; I believe UFS under Solaris might do this? 
> 
> An even better heuristic I like would allow repacking of a directory
> and truncation if you could safely half the size -- but I suspect
> locking issues might be hideous here.

Not really. Anything that modifies directories holds both ->i_sem and
->i_zombie, lookups hold ->i_sem and emptiness checks (i.e. victim in
rmdir and overwriting rename) hold ->i_zombie, readdir holds both.

So we could even play with punching holes in them - very easy to do when
you do ext2_delete_entry(). I've done that on directories-in-pagecache
system, but decided that I don't want to deal with (bogus) warnings from
earlier kernels (they would do the right thing, but they would complain
loudly). Truncating is a piece of cake. Repacking is not a good idea,
though, since you are risking massive corruption in case of dirty shutdown
in the wrong moment.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
