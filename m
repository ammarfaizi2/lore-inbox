Return-Path: <linux-kernel-owner+w=401wt.eu-S1751029AbXAIEtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXAIEtf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbXAIEtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:49:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43117 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750783AbXAIEte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:49:34 -0500
Date: Tue, 9 Jan 2007 15:49:07 +1100
From: David Chinner <dgc@sgi.com>
To: Nathan Scott <nscott@aconex.com>
Cc: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@sandeen.net>,
       David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-ID: <20070109044907.GH33919298@melbourne.sgi.com>
References: <20070107213734.GS44411608@melbourne.sgi.com> <20070108110323.GA3803@m.safari.iki.fi> <45A27416.8030600@sandeen.net> <20070108234728.GC33919298@melbourne.sgi.com> <20070108161917.73a4c2c6.akpm@osdl.org> <45A30828.6000508@sandeen.net> <20070108191800.9d83ff5e.akpm@osdl.org> <45A30E1D.4030401@sandeen.net> <20070108195127.67fe86b8.akpm@osdl.org> <1168316223.32113.83.camel@edge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168316223.32113.83.camel@edge>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 03:17:03PM +1100, Nathan Scott wrote:
> On Mon, 2007-01-08 at 19:51 -0800, Andrew Morton wrote:
> > On Mon, 08 Jan 2007 21:38:05 -0600
> > Eric Sandeen <sandeen@sandeen.net> wrote:
> > 
> > > Andrew Morton wrote:
> > > > On Mon, 08 Jan 2007 21:12:40 -0600
> > > > Eric Sandeen <sandeen@sandeen.net> wrote:
> > > > 
> > > >> Andrew Morton wrote:
> > > >>> On Tue, 9 Jan 2007 10:47:28 +1100
> > > >>> David Chinner <dgc@sgi.com> wrote:
> > > >>>
> > > >>>> On Mon, Jan 08, 2007 at 10:40:54AM -0600, Eric Sandeen wrote:
> > > >>>>> Sami Farin wrote:
> > > >>>>>> On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
> > > >>>>>> ...
> > > >>>>>>>> fstab was there just fine after -u.
> > > >>>>>>> Oh, that still hasn't been fixed?
> > > >>>>>> Looked like it =)
> > > >>>>> Hm, it was proposed upstream a while ago:
> > > >>>>>
> > > >>>>> http://lkml.org/lkml/2006/9/27/137
> > > >>>>>
> > > >>>>> I guess it got lost?
> > > >>>> Seems like it. Andrew, did this ever get queued for merge?
> > > >>> Seems not.  I think people were hoping that various nasties in there
> > > >>> would go away.  We return to userspace with a kernel lock held??
> > > >> Is a semaphore any worse than the current mutex in this respect?  At 
> > > >> least unlocking from another thread doesn't violate semaphore rules.  :)
> > > > 
> > > > I assume that if we weren't returning to userspace with a lock held, this
> > > > mutex problem would simply go away.
> > > > 
> > > 
> > > Well nobody's asserting that the filesystem must always be locked & 
> > > unlocked by the same thread, are they?  That'd be a strange rule to 
> > > enforce upon the userspace doing the filesystem management wouldn't it? 
> > >   Or am I thinking about this wrong...
> > 
> > I don't even know what code we're talking about here...
> > 
> > I'm under the impression that XFS will return to userspace with a
> > filesystem lock held, under the expectation (ie: requirement) that
> > userspace will later come in and release that lock.
> 
> Its not really XFS, its more the generic device freezing code
> (freeze_bdev) which is called by both XFS and the device mapper
> suspend interface (both of which are exposed to userspace via
> ioctls).  These interfaces are used when doing block level
> snapshots which are "filesystem coherent".
> 
> > If that's not true, then what _is_ happening in there?
> 
> This particular case was a device mapper stack trace, hence the
> confusion, I think.  Both XFS and DM are making the same generic
> block layer call here though (freeze_bdev).

Yup. it's the freeze_bdev/thaw_bdev use of the bd_mount_mutex()
that's the problem. I fail to see _why_ we need to hold a lock
across the freeze/thaw - the only reason i can think of is to
hold out new calls to sget() (via get_sb_bdev()) while the
filesystem is frozen though I'm not sure why you'd need to
do that. Can someone explain why we are holding the lock from
freeze to thaw?

FWIW, the comment in get_sb_bdev() seems to imply s_umount is supposed
to ensure that we don't get unmounted while frozen.

Indeed, in the comment above freeze_bdev:

 * If a superblock is found on this device, we take the s_umount semaphore
 * on it to make sure nobody unmounts until the snapshot creation is done.

implies this as well, but freeze_bdev does not take the s_umount
semaphore, nor does any filesystem that implements ->write_super_lockfs()

So the code is clearly at odds with the comments here.

IMO, you should be able to unmount a frozen filesystem - behaviour
should be the same as crashing while frozen, so i think the comments
about "snapshots" are pretty dodgy as well.

> > If that _is_ true then, well, that sucks a bit.
> 
> Indeed, its a fairly ordinary interface, but thats too late to go
> fix now I guess (since its exposed to userspace already). 

Userspace knows nothing about that lock, so we can change that without
changing the the userspace API.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
