Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBWS6x>; Fri, 23 Feb 2001 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBWS6o>; Fri, 23 Feb 2001 13:58:44 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:29436 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129093AbRBWS6b>; Fri, 23 Feb 2001 13:58:31 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102231857.f1NIvnt04330@webber.adilger.net>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <l03130300b6bbd7483cd3@[192.168.239.101]> from Jonathan Morton at
 "Feb 23, 2001 12:20:54 pm"
To: Jonathan Morton <chromi@cyberspace.org>
Date: Fri, 23 Feb 2001 11:57:49 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton writes:
> Meanwhile, let's go back to Linus' comment on compatibility and so on.  He
> has a *very* good point, which I'll expand on slightly here:
> 
> Suppose some stone-age Linux user, running 2.0.35 or something equally old
> (which runs ext2), decides to finally bite the bullet and upgrade...
> ... 2.0.35's old ext2 code suddenly can't read the filesystem, which was
> modified by 2.6.1 before the boot process stalled.

One of the proposals on the table for the indexed directories is read AND
WRITE compatible with older kernels.  For 1.0 through 2.4 kernels the read
compatibility is very safe (it will generate some errors on reads because
of "sparse" directory blocks, but the code will continue on correctly,
<= 1.2 won't even generate an error).  For < 2.2 kernels deleting a file from
an indexed directory will work, but would leave the index out of date.
For < 2.2 kernels adding a new file to an indexed directory would always
overwrite the index, so it is also safe.

> I hope people understand this as well as I do - if a filesystem upgrade is
> desirable, let the user perform some *specific* action to upgrade it, when
> he has an otherwise-working setup *and* sufficient backups.  I for one do
> not want to be caught out like the hypothetical user I mentioned above.

I am on the side of maintaining compatibility.  There _may_ be a _small_
performance (more like capacity) impact on indexed directories for this
compatibility, but it is well worth it, IMHO.

> - Currently, it's a stable and universally-utilised filesystem which offers
> very good performance for most applications.  I'm specifically drawing
> attention to certain benchmarks which place ext2's disk-based performance
> ahead of many commercial UNIX' ram-based filesystem performance.

Totally agree.

> - There are specific problems with performance when reading and/or
> modifying large directories.  I haven't tested for this personally, but I
> have noticed slowness when using 'rm -rf' on a large *tree* of directories.

That is what the index change will address.  Actually, "rm -r" may not
be speeded up very much, but "rm *" definitely would be ("rm -r" deletes
files in directory order, but "rm *" deletes each file individually in
alphabetical order).

> One of the current suggestions, if I've interpreted it correctly, is to
> introduce an extension to ext2 which essentially makes a "fast index" of a
> large directory, attaches it to the directory in some backwards-compatible
> manner, and uses it *in conjunction with* the regular directory structure.

Yes, this is essentially true.  The on-disk directory entries are exactly
the same.  The index itself (in the compatible layout) appears to simply
be empty directory blocks (at the cost of 8 bytes = 1 index entry per block).

> - How much overhead does the "fast index" introduce for modification of the
> directory?  Large directories are the most likely to have stuff added and
> deleted, and it doesn't help if during an "rm *" operation the saving on
> the search is negated by the overhead on the unlink.

The index will improve the performance for file add, stat, and delete.  For
all of these operations you need to find a directory entry (add needs to
check if a file of the same name already exists before a new file is added).

> - If the index gets out of sync with the directory, how is this detected
> and recovered from?  Assuming the index merely points to the correct
> position in the regular directory, some simple sanity checks will suffice
> for most cases (is this entry in the directory the same as I asked for?),
> and if the entry is not in the index then a standard search of the real
> directory can be done.  In either case, the index can be marked as invalid
> (and removed?) and rebuilt whenever necessary.

On an index-aware kernel, the index can obviously not get out of sync.
All 2.2+ kernels that don't understand indexing will clear the "has
index" flag if they modify that directory, and the index will disappear.
Since the index is "hidden" (in my proposal at least) inside a totally
normal directory block, it will simply be overwritten by new entries.
As I mentioned above, 1.x and 2.0 kernels will overwrite the index on
an add, but not on a delete, and will not clear the "has index" flag.
This means we need some extra magic at the start of the index to ensure
we have a valid index header.

> - At what threshold of directory size does the index come into play?
> (fairly obviously, the index is useless for tiny directories)

This remains to be seen.  Definitely not for directories 1 block in size
(which is 85%? of all directories).  It looks like directories with about
250-300 files or more are needed for indexing to be useful.  The good
news is that since indexing is optional, it can be tuned to only improve
performance of directories.

> - What happens when an old kernel encounters a directory which has an index
> attached to it?  Does it look like a virtual file, which has no special
> properties but whose name is reserved for system use?  (cf. lost+found)  Or
> is it some inidentifiable bits in the directory structure and a few lost
> clusters on the disk?  If the latter, it will have to be done in a way that
> older versions of e2fsck can clean it up easily and older versions of ext2
> won't throw up on it, which could be kinda hard.  If the former, an
> 'unused' name will have to be found to avoid conflicts but the big
> advantage is *no* inconsistency with old systems.

This has also been discussed already for the indexing code.  The index
is actually stored inside the directory, so no hidden files or anything,
and no "lost blocks" either.  The original indexing code wasn't 100%
compatible with the older layout, but a proposal has been made to make
it totally compatible with older kernels (excluding some error messages
that all ext2 directory code handles properly).

If (for whatever reason) you started using an indexed ext2 kernel,
created a huge directory of files, and then never used it again, the
only thing wasted would be your time (when you try to delete the files
in the huge directory without the indexed directory ;-).  The ext2 code
has NEVER releases directory blocks, even if all of the files are gone.
All blocks used by the index also appear (in the proposed layout) as
regular directory blocks, so a non-index kernel can use them at any time
(of course the index is destroyed in this case).

As an aside, lost+found is NOT a "special" name in any way to the
filesystem.  The only thing that it is used for is e2fsck - to the kernel
it is just a regular directory.

Basically, I think the compatibility is excellent for the functionality
delivered.  Another reason why I think ext2 will continue to have a long
and prosperous life, without making sacrifices for performance.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
