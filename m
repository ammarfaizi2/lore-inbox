Return-Path: <linux-kernel-owner+w=401wt.eu-S932622AbXAJBfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXAJBfo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbXAJBfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:35:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54033 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932622AbXAJBfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:35:44 -0500
Date: Wed, 10 Jan 2007 12:34:19 +1100
From: David Chinner <dgc@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Eric Sandeen <sandeen@sandeen.net>, David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-ID: <20070110013419.GP33919298@melbourne.sgi.com>
References: <20070107213734.GS44411608@melbourne.sgi.com> <20070108110323.GA3803@m.safari.iki.fi> <45A27416.8030600@sandeen.net> <20070108234728.GC33919298@melbourne.sgi.com> <20070108161917.73a4c2c6.akpm@osdl.org> <45A30828.6000508@sandeen.net> <20070108191800.9d83ff5e.akpm@osdl.org> <45A30E1D.4030401@sandeen.net> <20070108195127.67fe86b8.akpm@osdl.org> <20070109100420.GB14713@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109100420.GB14713@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 10:04:20AM +0000, Christoph Hellwig wrote:
> On Mon, Jan 08, 2007 at 07:51:27PM -0800, Andrew Morton wrote:
> > I don't even know what code we're talking about here...
> > 
> > I'm under the impression that XFS will return to userspace with a
> > filesystem lock held, under the expectation (ie: requirement) that
> > userspace will later come in and release that lock.
> > 
> > If that's not true, then what _is_ happening in there?
> > 
> > If that _is_ true then, well, that sucks a bit.
> 
> It's not a filesystem lock.  It's a per-blockdevice lock that prevents
> multiple people from freezing the filesystem at the same time, aswell
> as providing exclusion between a frozen filesystem an mount-related
> activity.  It's a traditional text-box example for a semaphore.

This can be done without needing to hold a semaphore across the
freeze/thaw.

In the XFS case, we never try to lock the semaphore a second
time - the freeze code checks if the filesystem is not already
(being) frozen before calling freeze_bdev(). On thaw it also
checks that the filesystem is frozen before calling thaw_bdev().

IOWs, you can safely do:

# xfs_freeze -f /dev/sda1; xfs_freeze -f /dev/sda1; xfs_freeze -f /dev/sda1;
# xfs_freeze -u /dev/sda1; xfs_freeze -u /dev/sda1; xfs_freeze -u /dev/sda1;

And the filesystem will only be frozen once and thawed once. The second
and subsequent incantations of the freeze/thaw are effectively ignored
and don't block.

IMO, if we need to prevent certain operations from occurring when the
filesystem is frozen, those operations need to explicitly check the
frozen state and block i.e. do something like:

	wait_event(sb->s_wait_unfrozen, (sb->s_frozen < SB_FREEZE_WRITE));

If you need to prevent unmounts from occurring while snapshotting a
frozen filesystem, then the snapshot code needs to take the s_umount
semaphore while the snapshot is in progress. We should not be making
frozen filesystems unmountable....

Thoughts?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
