Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274529AbRITOuQ>; Thu, 20 Sep 2001 10:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274530AbRITOuG>; Thu, 20 Sep 2001 10:50:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15769 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274529AbRITOt4>;
	Thu, 20 Sep 2001 10:49:56 -0400
Date: Thu, 20 Sep 2001 10:50:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <627000000.1000996685@tiny>
Message-ID: <Pine.GSO.4.21.0109201046270.3498-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Chris Mason wrote:

> 
> 
> On Thursday, September 20, 2001 09:56:22 AM -0400 Alexander Viro <viro@math.psu.edu> wrote:
> 
> > Had you actually read the fsync_dev()?  Let me make it clear: you are
> > flushing _buffer_ cache upon blkdev_put(bdev, BDEV_FILE).  It was
> > the right thing when file access went through buffer cache.  It's
> > blatantly wrong with page cache.
> 
> Well, fsync_dev will flush anything on the dirty list.  Since 
> blkdev_commit_write puts things on the dirty list, andrea's current 
> code will flush changes through the page cache.
> 
> The biggest exception is blkdev_writepage directly submits the io instead
> of marking the buffers dirty.  This means the buffers won't be on
> the locked/dirty list, and they won't get waited on.  Similar problem
> for direct io.

<nod>  And if you add Andrea's (perfectly valid) observation re having no
need to sync any fs structures we might have for that device, you get
__block_fsync().  After that it's easy to merge blkdev_close() code into
blkdev_put().

