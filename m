Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUCMNOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUCMNOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:14:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:14858 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263093AbUCMNOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:14:49 -0500
Date: Sat, 13 Mar 2004 13:14:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040313131447.A25900@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1078867885.25075.1458.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078867885.25075.1458.camel@watt.suse.com>; from mason@suse.com on Tue, Mar 09, 2004 at 04:31:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 04:31:25PM -0500, Chris Mason wrote:
> Hello everyone,
> 
> In order to get consistent snapshots with the device mapper code, you
> need to sync and lock down any filesystems sitting on top of the
> device.  This isn't as critical in the 2.6 code since it can do writable
> snapshots, but it is still nice to have things properly synced and
> consistent.  
> 
> I've had various forms of this against 2.4, the ugly part was always the
> locking to make sure a new FS wasn't mounted on the source while the
> snapshot was being setup.  Here's my 2.6 version, with the DM code
> contributed by Kevin Corry.  The basic idea is to add a semaphore to the
> block device that gets used to make sure there are no new mounts.

Okay, I actually took a look at the XFS freeze code and it seems the
current infrastructure doesn't suite XFS very well.

What XFS currently does when freezing is

1.	set a flag in the mount structure that blocks all new writes
2.	flush all file data
3.	set a flag blocking all new transactions
4.	flush any dirty inode state into buffers
5.	push out all buffers to disk
6.	mark the filesystem clean

Now how does this fit into generic freeze/thaw fs structure?

1.	should probably move into the VFS (generic_file_write)

2,4,5	basically is fsync_bdev except that we have no chance to block
transaction that way.  So either we need two calls into the fs or have
some trivial state in the superblock that tells xfs to block transaction,
basically an enum { FS_UNFROZEN, FS_FROZEN_WRITE, FS_FROZEN_FULL };

and a function fs_check_frozen similar to xfs_check_frozen that makes the
caller block until the fs is unfrozen.

Doing it that way would get rid of lots of mess in XFS so I'm all for it :)
