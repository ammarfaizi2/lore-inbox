Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRAIU7r>; Tue, 9 Jan 2001 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131781AbRAIU7h>; Tue, 9 Jan 2001 15:59:37 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6927 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130113AbRAIU71>;
	Tue, 9 Jan 2001 15:59:27 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101092059.f09Kx9J285829@saturn.cs.uml.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 9 Jan 2001 15:59:09 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), andrea@suse.de (Andrea Arcangeli),
        mhaque@haque.net (Mohammad A. Haque), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101090927040.8865-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 09, 2001 10:00:52 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Tue, 9 Jan 2001, Albert D. Cahalan wrote:
>> Alexander Viro writes:
>>
>>> [...] If you really need to destroy the directory
>>> that happens to be your pwd - sorry, no reliable way to do that without
>>> interesting locking. On _any_ UNIX out there. 2.2 included. It will
>>> happily give you -ENOENT and refuse to perform the action above in
>>> case if some other process renames your pwd. Yes, for rmdir(".");
>>
>> Well, this bites.
>>
>> Locking guess: use a global read-write lock, with the "write" case
>> being deletion of "." and the "read" case being everything else.
>> You could have one lock per CPU, with the writer needing to grab all
>> of them in order. So removal of "." pays the cost.
>
> It's _so_ far from the SMP cache issues that it's not even funny.
> So reference to brw-locks is completely bogus. What you are proposing
> is to serialize rmdir() and rename() (including lookups) wrt rmdir
> and rename. Globally. Fun, fun...

As long as nobody tried to remove ".", nothing is serialized.
You can do your lookups in parallel since they can all grab
the read lock at once.

If you prefer some pentuple_down thing though, cool.

>> If the standards gripe, well, rmdot() is a nice name.
>
> If anything, frmdir() might be a better name. However, it's really
> inconsistent with the whole namespace-modifying stuff. You don't
> have flink(fd, newname). frename() and funlink() are not even
> funny - _which_ link would you want to be renamed/removed?

Linux can tell where you got the "f" from in the first place.
Deleted files could cause an error, or turn frename() into flink()
and return success for funlink().

> Filesystem consists of two types of objects - files (and that includes
> directories, etc.) and links. Pathname can be evaluated to link and to
> file. Namespace syscalls (creat()/mkdir()/mknod()/symlink()/link()/
> unlink()/rmdir()/rename()) operate on links. open(), truncate(), stat(),
> lstat(), etc. operate on files - completely different can of worms.
>
> 2.2 tried (without success) to make rmdir() and some cases of rename() act
> on files. Notice that if you have /foo as pwd, "." and "/foo" will evaluate
> to the same file, but to different links. That's what it's really about.

The whole "." and ".." mess is 100% special case to begin with,
so this argument doesn't make sense. The mess already gives
us a link that gets replaced when some other link is renamed,
and two links that get unlinked when something else is unlinked.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
