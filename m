Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCGXi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCGXi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCGXfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:35:20 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:47759 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261899AbVCGWz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:55:58 -0500
Date: Mon, 7 Mar 2005 14:55:45 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] crash after fsync causing serious FS corruptions (ext2,
 2.6.11)
In-Reply-To: <20050307104513.GD8071@suse.de>
Message-ID: <Pine.GSO.4.44.0503071433490.7287-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fsync on ext2 only really guarantees that the data has reached
> the disk, what the disk does it outside the realm of the fs.
> If the ide drive has write back caching enabled, the data just
> might only be in cache. If the power is removed right after fsync
> returns, the drive might not get a chance to actually commit the
> write to platter.

Hi Jens,

Thanks for the reply.  I tried your patch, and also setting hdparm -W0.
The warning is still there.  This warning and the previous ones I reported
should be irrelevant to IDE drivers, as FiSC (our FS checker) doesn't
actually crash the machine but simulates a crash using a ramdisk.

It appears to me that this warning can be triggered by the following steps:

1. create a file A with several data blocks. fsync(A) to disk

2. truncate A to a smaller size, causing a few blocks to be freed.
However, they are only freed in memory.  The corresponding changes in
bitmaps haven't yet hit the disk.

3. create a file B with several data blocks.  ext2 will re-use the freed
blocks from step 2.

4. fsync(B).  Once fsync returns, crash.

At this moment, the truncate in step 2 hasn't reached the disk yet, so the
file A on disk still contains pointers to the freed blocks.  However, the
fsync(B) in step 4 flushes B's inode and other metadata to disk.  Now we
end up with a file system where a block is shared by two files.

I'm not sure how the invalid block number warning is triggered.

-Junfeng

