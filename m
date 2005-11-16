Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVKPL1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVKPL1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 06:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVKPL1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 06:27:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030236AbVKPL1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 06:27:03 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051115112504.4b645a86.akpm@osdl.org> 
References: <20051115112504.4b645a86.akpm@osdl.org>  <20051114150347.1188499e.akpm@osdl.org> <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <11717.1132077542@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 16 Nov 2005 11:26:46 +0000
Message-ID: <1932.1132140406@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > What I'm trying to do is actually fairly simple in concept:
> > 
> >   (1) Have a metadata inode (imeta) that covers the block device.
> > 
> 
> Can you remind me again why it requires a blockdev rather than a regular file?

That's the third time you've asked:-) You should be able to find the previous
conversations in LKML archives.

I presume directing you to go and look at the CacheFS documentation in patch
12/12 would be out of the question? Particularly the section entitled "Why a
block device? Why not a bunch of files?"...

Look also at Documentation/filesystem/caching/fscache.txt provided by patch
9/12 for the constraints I've set, in particular:

 (1) It must be practical to operate without a cache.

 (2) The size of any accessible file must not be limited to the size of the
     cache.

 (3) The combined size of all opened files (this includes mapped libraries)
     must not be limited to the size of the cache.

 (4) The user should not be forced to download an entire file just to do a
     one-off access of a small portion of it (such as might be done with the
     "file" program).

To which I wish to add:

 (5) The netfs pages must remain owned by the netfs, so that there is no
     difference between the netfs operating with a cache and it operating
     without a cache. This means I/O must be done to/from the netfs pages
     directly from/to the cache.


I have a start of a cache-on-files facility (called, most imaginatively,
CacheFiles) which works as another backend to FS-Cache. Of the underlying
filesystem, it requires:

 (*) O_DIRECT

 (*) Reads and writes on arbitrary kernel pages

 (*) Reads on holes must return short or ENODATA. This requires an extra
     O_XXXX flag to be supplied when opening a file or the struct file or
     inode to be flagged appropriately.

 (*) The ability to issue FS operations such as rename, open, setxattr, mkdir
     from kernel space.

This facility isn't well advanced yet, and will initially only be available on
EXT2/3. It will also require a userspace component to clean up dead nodes.


Are you willing to at least carry the FS-Cache core and the AFS usage of it?
They haven't changed for a long time, and hopefully shouldn't need to:

 (*) Subject: [PATCH 8/12] FS-Cache: Add generic filesystem cache core module
     Patch: fscache-core-2614mm2.diff

 (*) Subject: [PATCH 9/12] FS-Cache: Add documentation for FS-Cache and its interfaces
     Patch: fscache-docs-2614mm2.diff

 (*) Subject: [PATCH 10/12] FS-Cache: Make kAFS use FS-Cache
     Patch: fscache-afs-2614mm2.diff

Once I've updated them for Linus's comments, that is...

All the other patches have to do with CacheFS.

David
