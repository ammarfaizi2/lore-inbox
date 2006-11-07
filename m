Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753980AbWKGDoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbWKGDoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 22:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbWKGDoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 22:44:19 -0500
Received: from thunk.org ([69.25.196.29]:39810 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1753977AbWKGDoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 22:44:18 -0500
Date: Mon, 6 Nov 2006 22:43:44 -0500
From: Theodore Tso <tytso@mit.edu>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Message-ID: <20061107034344.GA23959@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Eric Sandeen <sandeen@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454FC20F.8040206@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 05:15:27PM -0600, Eric Sandeen wrote:
> Christoph Hellwig wrote:
> > On Mon, Nov 06, 2006 at 03:50:02PM -0600, Eric Sandeen wrote:
> >> so I would propose the following patch to make PAGE_CACHE_SIZE the default (again), 
> >> and let filesystems which need something -else- do that on their own.
> > 
> > I agree with the conclusion, but the patch is incomplete.  You went down
> > all the way to find out what the fileystems do in this messages, so add
> > the hunks to override the defaults for non-standard filesystems to the
> > patch aswell to restore the pre-inode diet state.
> 
> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
> :)  So it's less broken with my patch than without, so at least it's
> moving forward.  So... Ted's patches get in w/o fixing up all the other
> filesystems (left as an exercise to the patch reader) but mine can't? :)

Note that *I* wasn't the one who changed it from PAGE_CACHE_SIZE to (1
<< inode->i_blkbits).  This was done by Andrew.  (See below, from an
e-mail dated September 19th).

Given that Steve French was cc'ed, I assume this was done as a hack to
fix CIFS, but it was a bad idea; I agree that PAGE_CACHE_SIZE is a way
better default than (1 << inode->i_blkbits).

As far as fixing all of the other filesystems, I did *try*; I know I
screwed up with XFS, but that's because I still think the code is a
screaming horror of indirections that make it impossible to understand
what the heck is going on, and I guess I screwed up with CIFS.  Some
of the changes away from "pre inode diet" state were deliberate,
though, since some filesystems had very clearly broken "optimal I/O
sizes" of 512, and one even had something incredibly bogus that was
something like 96 bytes (!) if I remember correctly.

					- Ted


Subject: inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-fix
From: Andrew Morton <akpm@osdl.org>

Cc: <sbenni@gmx.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Steven French <sfrench@us.ibm.com>,
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/stat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN
fs/stat.c~inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-fi
x fs/stat.c
---
a/fs/stat.c~inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-fix-
fix
+++ a/fs/stat.c
@@ -33,7 +33,7 @@ void generic_fillattr(struct inode *inod
        stat->ctime = inode->i_ctime;
        stat->size = i_size_read(inode);
        stat->blocks = inode->i_blocks;
-       stat->blksize = PAGE_CACHE_SIZE;
+       stat->blksize = (1 << inode->i_blkbits);
 }

 EXPORT_SYMBOL(generic_fillattr);
_

