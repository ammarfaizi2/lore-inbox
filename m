Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWHXNsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWHXNsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWHXNsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:48:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63873 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751523AbWHXNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:48:03 -0400
Date: Thu, 24 Aug 2006 14:47:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824134759.GA29764@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <32640.1156424442@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32640.1156424442@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 02:00:42PM +0100, David Howells wrote:
> 
> Make it possible to disable the block layer.  Not all embedded devices require
> it, some can make do with just JFFS2, NFS, ramfs, etc - none of which require
> the block layer to be present.
> 
> This patch does the following:
> 
>  (*) Introduces CONFIG_BLOCK to disable the block layer, buffering and blockdev
>      support.
> 
>  (*) Adds dependencies on CONFIG_BLOCK to any configuration item that controls
>      an item that uses the block layer.  This includes:
> 
>      (*) Block I/O tracing.
> 
>      (*) Disk partition code.
> 
>      (*) All filesystems that are block based, eg: Ext3, ReiserFS, ISOFS.
> 
>      (*) The SCSI layer.  As far as I can tell, even SCSI chardevs use the
>      	 block layer to do scheduling.
> 
>      (*) Various block-based device drivers, such as IDE, the old CDROM
>      	 drivers and USB storage.
> 
>      (*) MTD blockdev handling and FTL.
> 
>      (*) JFFS - which uses set_bdev_super(), something it could avoid doing by
>      	 taking a leaf out of JFFS2's book.

So far a very good idea and I very much welcome this - it's been long overdue.

>  (*) Made most of the contents of linux/blkdev.h, linux/buffer_head.h and
>      linux/elevator.h contingent on CONFIG_BLOCK being set.  sector_div() is,
>      however, still used in places.
> 
>  (*) The contents of linux/blktrace_api.h are contingent now on CONFIG_BLOCK in
>      addition to CONFIG_BLK_DEV_IO_TRACE, possibly unnecessarily.
> 
>  (*) Also contingent are the contents of linux/mpage.h, linux/genhd.h and parts
>      of linux/fs.h.
> 
>  (*) The contents of a number of filesystem- and blockdev-specific header files
>      are now contingent on their own configuration options.  This includes:
>      Ext3/JBD, RAID, MSDOS and ReiserFS.
> 

Now this is quite bad - we avoid ifdefs where we can.  People will notice
their module won't link if they don't get the dependencies right.

Note that in the case of linux/blktrace_api.h it's really bad as that
header contains a userspace ABI.

>  (*) Moved some stuff out of fs/buffer.c:
> 
>      (*) The file sync and general sync stuff moved to fs/sync.c.
> 
>      (*) The superblock sync stuff moved to fs/super.c.
> 
>      (*) do_invalidatepage() moved to mm/truncate.c.
> 
>      (*) try_to_release_page() moved to mm/filemap.c.

This is very nice, but please submit it as a separate patch, before the
actual CONFIG_BLOCK introduction.

Also I'm not sure the try_to_release_page variant is actually right as
we still have that horrible default of try_to_free_buffers() if there's
no releasepage method.

>  (*) Moved some stuff between header files:
> 
>      (*) declarations for do_invalidatepage() and try_to_release_page() moved
>      	 to linux/mm.h.
> 
>      (*) __set_page_dirty_buffers() moved to linux/buffer_head.h.

makes sense I think - but this also belongs into the above preparation
patch.

> 
>  (*) The duplicate declaration of exit_io_context() has been removed from
>      linux/sched.h.

ACK, tiny patch of it's own.

> 
>  (*) set_page_dirty() doesn't call __set_page_dirty_buffers() if CONFIG_BLOCK
>      is not enabled.
> 
>  (*) fallback_migrate_page() uses PagePrivate() instead of page_has_buffers().

tiny fix on it's own - it's actually a separate buf

> 
>  (*) The bounce buffer stuff moved from mm/highmem.c to mm/bounce.c, which is
>      contingent on CONFIG_BLOCK.

Nice, but please make this a separate patch.

>  (*) The AFS filesystem specifies block_sync_page() as its sync_page address
>      op, which needs to be checked, and so is commented out.

separate patch, please.

>  (*) The bdev_cache_init() extern declaration was moved from fs/dcache.c to
>      linux/blkdev.h.

dito.

> 
>  (*) The blockdev_superblock extern declaration was moved from
>      fs/fs-writeback.c to linux/blkdev.h.

separate patch

>  (*) fs/fs-writeback.c no longer depends on blockdev_superblock to be present.

please do this without all the ifdefs in .c files.

>  (*) fs/no-block.c was incorporated to hold a couple of things for when
>      CONFIG_BLOCK was not set:
> 
>      (*) A version generic_writepages(), which is used by NFS.  This is derived
>      	 from mpage_writepages() with all the BIO references removed.

if we already have a duplicate copy of it we should use it all the time.
Maybe there's even a way to avoid this.  please submit it as a broken
out patch so smart people like akpm can help solving this problem without
steeping through this huge patch :)

>  (*) In init/do_mounts.c, no reference is made to the blockdev routines if
>      CONFIG_BLOCK is not defined.  This does not prohibit NFS roots or JFFS2.

please split that code out into a do_mounts_block.c like the other special
case root mount code.

>  (*) The bdflush, ioprio_set and ioprio_get syscalls can now be absent (return
>      error ENOSYS if so).

please use cond_syscall for them.

>  (*) The seclvl_bd_claim() and seclvl_bd_release() security calls do nothing if
>      CONFIG_BLOCK is not set, since they can't then happen.

I though we agreed to kill the seclvl crap?  We should kill those broken
LSM callouts aswell then.
