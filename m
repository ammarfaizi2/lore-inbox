Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbUCMPSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 10:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbUCMPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 10:18:17 -0500
Received: from ns.suse.de ([195.135.220.2]:43983 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263113AbUCMPSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 10:18:15 -0500
Subject: Re: [PATCH] lockfs patch for 2.6
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040313131447.A25900@infradead.org>
References: <1078867885.25075.1458.camel@watt.suse.com>
	 <20040313131447.A25900@infradead.org>
Content-Type: text/plain
Message-Id: <1079191213.4187.243.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 10:20:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 08:14, Christoph Hellwig wrote:
> On Tue, Mar 09, 2004 at 04:31:25PM -0500, Chris Mason wrote:
> > Hello everyone,
> > 
> > In order to get consistent snapshots with the device mapper code, you
> > need to sync and lock down any filesystems sitting on top of the
> > device.  This isn't as critical in the 2.6 code since it can do writable
> > snapshots, but it is still nice to have things properly synced and
> > consistent.  
> > 
> > I've had various forms of this against 2.4, the ugly part was always the
> > locking to make sure a new FS wasn't mounted on the source while the
> > snapshot was being setup.  Here's my 2.6 version, with the DM code
> > contributed by Kevin Corry.  The basic idea is to add a semaphore to the
> > block device that gets used to make sure there are no new mounts.
> 
> Okay, I actually took a look at the XFS freeze code and it seems the
> current infrastructure doesn't suite XFS very well.
> 
> What XFS currently does when freezing is
> 
> 1.	set a flag in the mount structure that blocks all new writes
> 2.	flush all file data
> 3.	set a flag blocking all new transactions
> 4.	flush any dirty inode state into buffers
> 5.	push out all buffers to disk
> 6.	mark the filesystem clean
> 
> Now how does this fit into generic freeze/thaw fs structure?
> 
> 1.	should probably move into the VFS (generic_file_write)
> 
> 2,4,5	basically is fsync_bdev except that we have no chance to block
> transaction that way.  So either we need two calls into the fs or have
> some trivial state in the superblock that tells xfs to block transaction,
> basically an enum { FS_UNFROZEN, FS_FROZEN_WRITE, FS_FROZEN_FULL };
> 
> and a function fs_check_frozen similar to xfs_check_frozen that makes the
> caller block until the fs is unfrozen.
> 
> Doing it that way would get rid of lots of mess in XFS so I'm all for it :)

This is basically how reiserfs does it.  Various critical spots (like
the code to start a transaction) check to see if the FS is frozen.

I'll rework the patch as we've discussed on Friday, if you need it
broken up differently, please let me know.

-chris


