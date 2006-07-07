Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWGGLy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWGGLy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWGGLy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:54:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42725 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932136AbWGGLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:54:25 -0400
Date: Fri, 7 Jul 2006 12:54:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060707115422.GA4705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Phillip Hellewell <phillip@hellewell.homeip.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060513033742.GA18598@hellewell.homeip.net> <20060520095740.GA12237@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520095740.GA12237@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 10:57:40AM +0100, Christoph Hellwig wrote:
> I gave the code in -mm a quick look, and it still needs a lot of work.

looking over the code again:

>  - please kill ECRYPTFS_SET_FLAG, ECRYPTFS_CLEAR_FLAG and ECRYPTFS_CHECK_FLAG
>    and just opencode them, it'll make the code a whole lot more readable

these are still there..

>  - please make sure touch_atime goes down to ->setattr for atime updates,
>    that way you don't need all that mess in your read/write.  and in -mm
>    those routines need update for vectored and aio support

you don't seem to have updated the common code for this yet.

>  - NEVER EVER do things like copying locks_delete_block and
>    posix_lock_file_wait (as ecryptfs_posix_lock and based on a previous
>    version) to you code.  It will get stale and create a maintaince nightmare.
>    talk with the subsystem maintainers on how to make the core functionality
>    accesible to you.
>  - similarly ecryptfs_setlk is totally non-acceptable.  find a way with the
>    maintainer to reuse things from fcntl_setlk with a common helper

dito

>  - copying things like lock_parent, unlock_parent and unlock_dir


still there.  sorry, but there's zero changes to get things merged that
opencode

> 
>  - please split all the generic stackable filesystem passthorugh routines
>    into a separated stackfs layer, in a few files in fs/stackfs/ that
>    you depend on.  They'll get _GPL exported to all possible stackable
>    filesystem.  They'll need their own store underlying object helpers,
>    but that can be made to work by embedding the generic stackfs data
>    as first thing in the ecryptfs object.
> 
>
>


More comments:

 - what protects accessing d_parent in lock_parent / unlock_parent?
 - no need to cast the return value of kmem_cache_alloc, it's void *
 - any reason to use the SLAB_* flags instead of GFP_?  I'm a bit surprised
   SLAB_* still exists at all..

 - follow_link handling is wrong.  you need to call the underlying
   ->follow_link in your follow_link implementation and you need to keep
   a separate nameidata for it

 - please kill that ugly ecryptfs_allocated_caches hack and do normal
   goto based unwinding on failure

 - using iget with the lower filesystems i_ino does not work.  There are
   various filesystems were i_ino does not uniqueuely identify an inode.
   You will probably need your own sequence numbers.  Also please don't
   use iget in new code but always the iget_locked variant.

And a more general issue with implementing stackable filesystems:

  I think it's probably much better to not stack ontop of a part of the
  existing namespace but rather let ecryptfs mount the underlying filesystem
  internally using vfs_kern_mount.  This gets out of the way of possible
  lock order problems when doing namespace operation involving both the
  stacked and underlying filesystem aswell as allowing using a stackable
  filesystem as the root filesystem.

