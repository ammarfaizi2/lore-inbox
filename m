Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132133AbRAIVm0>; Tue, 9 Jan 2001 16:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132090AbRAIVmQ>; Tue, 9 Jan 2001 16:42:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45492 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132203AbRAIVmC>;
	Tue, 9 Jan 2001 16:42:02 -0500
Date: Tue, 9 Jan 2001 16:42:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Andrea Arcangeli <andrea@suse.de>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <200101092059.f09Kx9J285829@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0101091623370.9953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Albert D. Cahalan wrote:

> As long as nobody tried to remove ".", nothing is serialized.
> You can do your lookups in parallel since they can all grab
> the read lock at once.

Bzzzert. At which point do you take that lock for rmdir("foo/bar/barf/.")?

> Linux can tell where you got the "f" from in the first place.
> Deleted files could cause an error, or turn frename() into flink()
> and return success for funlink().

For crying out loud, rename() already got a Bastard Semantics From Hell,
choke-full of special cases. Write the complete description of f* behaviour
and let's see what you'll get. Then post it here, OK?

> > 2.2 tried (without success) to make rmdir() and some cases of rename() act
> > on files. Notice that if you have /foo as pwd, "." and "/foo" will evaluate
> > to the same file, but to different links. That's what it's really about.
> 
> The whole "." and ".." mess is 100% special case to begin with,
> so this argument doesn't make sense. The mess already gives
> us a link that gets replaced when some other link is renamed,
> and two links that get unlinked when something else is unlinked.

Side effects. You've got to preserve fs consistency. Operation requested by
caller requires to change the links in (re)moved directory. Which is done.

Again, the main argument is Occam's Razor. I agree that in theory f*()
give things that are not provided by current syscalls. No arguments here.
However, unless you can show the real need to have them in the API they
have no business being there. As an aside, for some filesystems they are
simply impossible - try to implement frmdir() on NFS, for one thing.

The only possible benefit is in atomicity of these guys. _If_ filesystems
can provide it (local ones can do that) _and_ there is a real-world
stuff that needs such atomicity warranties - fine, you've got a case for
inclusion of that stuff. Otherwise presumption of uselessness[1] applies.

[1] Useless until proven useful, aka. Thou Shalt Not Bloat Thy API.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
