Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274521AbRITOiD>; Thu, 20 Sep 2001 10:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274525AbRITOhx>; Thu, 20 Sep 2001 10:37:53 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:11173
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274521AbRITOhq>; Thu, 20 Sep 2001 10:37:46 -0400
Date: Thu, 20 Sep 2001 10:38:05 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <627000000.1000996685@tiny>
In-Reply-To: <Pine.GSO.4.21.0109200952350.3498-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109200952350.3498-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, September 20, 2001 09:56:22 AM -0400 Alexander Viro <viro@math.psu.edu> wrote:

> Had you actually read the fsync_dev()?  Let me make it clear: you are
> flushing _buffer_ cache upon blkdev_put(bdev, BDEV_FILE).  It was
> the right thing when file access went through buffer cache.  It's
> blatantly wrong with page cache.

Well, fsync_dev will flush anything on the dirty list.  Since 
blkdev_commit_write puts things on the dirty list, andrea's current 
code will flush changes through the page cache.

The biggest exception is blkdev_writepage directly submits the io instead
of marking the buffers dirty.  This means the buffers won't be on
the locked/dirty list, and they won't get waited on.  Similar problem
for direct io.

The fix shouldn't be too bad, I'll code it up...

-chris

