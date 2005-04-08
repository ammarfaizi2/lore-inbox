Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVDHSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVDHSpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVDHSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:45:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:18658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbVDHSpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:45:22 -0400
Date: Fri, 8 Apr 2005 11:47:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <4256C0F8.6030008@pobox.com>
Message-ID: <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <4256C0F8.6030008@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Jeff Garzik wrote:
> 
> Well...  it took me over 30 seconds just to 'rm -rf' the unpacked 
> tarballs of git and sparse-git, over my LAN's NFS.

Don't use NFS for development. It sucks for BK too. 

That said, normal _use_ should actually be pretty efficient even over NFS.  
It will "stat" a hell of a lot of files to do the "show-diff", but that
part you really can't avoid unless you depend on all the tools marking
their changes somewhere. Which BK does, actually, but that was pretty
painful, and means that bk needed to re-implement all the normal ops (ie
"bk patch").

What's also nice is that exactly because "git" depends on totally 
immutable files, they actually cache very well over NFS. Even if you were 
to share a database across machines (which is _not_ what git is meant to 
do, but it's certainly possible). 

So I actually suspect that if you actually _work_ with a tree in "git", 
you will find performance very good indeed. The fact that it creates a 
number of files when you pull in a new repository is a different thing.

> Granted that this sort of stuff works well with (a) rsync and (b) 
> hardlinks, but it's still punishment on the i/dcache.

Actually, it's not. Not once it is set up. Exactly because "git" doesn't
actually access those files unless it literally needs the data in one
file, and then it's always set up so that it needs either none or _all_ of
the file. There is no data sharing anywhere, so you are never in the
situation where it needs "ten bytes from file X" and "25 bytes from file
Y".

For example, if you don't have any changes in your tree, there is exactly 
_one_ file that a "show-diff" will read: the .dircache/index file. That's 
it. After that, it will "stat()" exactly the files you are tracking, and 
nothing more. It will not touch any internal "git" data AT ALL. That 
"stat" will be somewhat expensive unless your client caches stat data too, 
but that's it.

And if it turns out that you have changed a file (or even just touched it, 
so that the data is the same, but the index file can no longer guarantee 
it with just a single "stat()"), then git will open have exactly _one_ 
file (no searching, no messing around), which contains absolutely nothing 
except for the compressed (and SHA1-signed) old contents of the file. It 
obviously _has_ to do that, because in order to know whether you've 
changed it, it needs to now compare it to the original.

IOW, "git" will literally touch the minimum IO necessary, and absolutely 
minimum cache-footprint.

The fact is, when tracking the 17,000 files in the kernel directory, most
of them are never actually changed. They literally are "free". They aren't
brought into the cache by "git" - not the file itself, not the backing
store. You set up the index file once, and you never ever touch them
again.  You could put the sha1 files on a tape, for all git cares.

The one exception obviously being when you actually instantiate the git 
archive for the first time (or when you throw it away). At that time you 
do touch all of the data, but that should be the only time.

THAT is what git is good at. It optimized for the "not a lot of changes"  
things, and pretty much all the operations are O(n) in the "size of
change", not in "size of repo".

That includes even things like "give me the diff between the top of tree
and the tree 10 days ago". If you know what your head was 10 days ago,
"git" will open exactly _four_ small files for this operation (the current
"top"  commit, the commit file of ten days ago, and the two "tree" files
associated with those). It will then need to open the backing store files 
for the files that are different between the two versions, but IT WILL 
NEVER EVEN LOOK at the files that it immediately sees are the same.

And that's actually true whether we're talking about the top-of-tree or
not. If I had the kernel history in git format (I don't - I estimate that
it would be about 1.5GB - 2GB in size, and would take me about ten days to
extract from BK ;), I could do a diff between _any_ tagged version (and I
mention "tagged" only as a way to look up the commit ID - it doesn't have
to be tagged if you know it some other way) in O(n) where 'n' is the
number of files that have changed between the revisions.

Number of changesets doesn't matter. Number of files doesn't matter. The
_only_ thing that matters is the size of the change.

Btw, I don't actually have a git command to do this yet. A bit of
scripting required to do it, but it's pretty trivial: you open the two
"commit" files that are the beginning/end of the thing, you look up what
the tree state was at each point, you open up the two tree files involved,
and you ignore all entries that match.

Since the tree files are already sorted, that "ignoring matches" is
basically free (technically that's O(n) in the number of files described,
but we're talking about something that even a slow machine can do so fast
you probably can't even time it with a stop-watch). You now have the 
complete list of files that have been changed (removed, added or "exists 
in both trees, but different contents"), and you can thus trivially create 
the whole tree with opening up _only_ the indexes for those files.

Ergo: O(n) in size of change. Both in work and in disk/cache access (where
the latter is often the more important one). Absolutely _zero_ indirection
anywhere apart from the initial stage to go from "commit" to "tree", so
there's no seeking except to actually read the files once you know what
they are (and since you know them up-front and there are no dependencies
at that point, you could even tell the OS to prefetch them if you really
cared about getting minimal disk seeks).

		Linus
