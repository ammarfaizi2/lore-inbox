Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPBL>; Tue, 9 Jan 2001 10:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRAIPBA>; Tue, 9 Jan 2001 10:01:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4742 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129324AbRAIPAy>;
	Tue, 9 Jan 2001 10:00:54 -0500
Date: Tue, 9 Jan 2001 10:00:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Andrea Arcangeli <andrea@suse.de>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <200101090931.f099VOk277651@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0101090927040.8865-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Albert D. Cahalan wrote:

> Alexander Viro writes:
> 
> > [...] If you really need to destroy the directory
> > that happens to be your pwd - sorry, no reliable way to do that without
> > interesting locking. On _any_ UNIX out there. 2.2 included. It will
> > happily give you -ENOENT and refuse to perform the action above in
> > case if some other process renames your pwd. Yes, for rmdir(".");
> 
> Well, this bites.
> 
> Locking guess: use a global read-write lock, with the "write" case
> being deletion of "." and the "read" case being everything else.
> You could have one lock per CPU, with the writer needing to grab all
> of them in order. So removal of "." pays the cost.

It's _so_ far from the SMP cache issues that it's not even funny. So reference
to brw-locks is completely bogus. What you are proposing is to serialize
rmdir() and rename() (including lookups) wrt rmdir and rename. Globally.
Fun, fun...
 
> If the standards gripe, well, rmdot() is a nice name.

If anything, frmdir() might be a better name. However, it's really
inconsistent with the whole namespace-modifying stuff. You don't have
flink(fd, newname). frename() and funlink() are not even funny - _which_
link would you want to be renamed/removed?

Filesystem consists of two types of objects - files (and that includes
directories, etc.) and links. Pathname can be evaluated to link and to
file. Namespace syscalls (creat()/mkdir()/mknod()/symlink()/link()/
unlink()/rmdir()/rename()) operate on links. open(), truncate(), stat(),
lstat(), etc. operate on files - completely different can of worms.

2.2 tried (without success) to make rmdir() and some cases of rename() act
on files. Notice that if you have /foo as pwd, "." and "/foo" will evaluate
to the same file, but to different links. That's what it's really about.

We could add new syscalls. However, I'm yet to see the real-world situation
where they would be needed enough to warrant their inclusion. And I mean
real-world, not an exercise asking for that functionality. Occam's Razor...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
