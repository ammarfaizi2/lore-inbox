Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUDGIr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUDGIr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:47:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5087 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261366AbUDGIrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:47:24 -0400
Date: Wed, 7 Apr 2004 09:47:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407084722.GQ31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040407064637.GB28941@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407064637.GB28941@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:46:37AM +0200, Herbert Poetzl wrote:
> originally there was a 'comment' which said, the
> (m) check can be removed, when we are sure that this
> isn't called with mnt == NULL ...
> 
> so maybe a BUGON(!m) might be useful? 

Accessing m->mnt_flags will do just fine ;-)

> > Note that we don't need to keep MS_NOATIME check in update_atime() - that
> > animal is purely per-mountpoint now.
> 
> hmm, wasn't there a reason, for having them per inode
> like for 'special' files, which I do not remember atm?

Yes, but that's S_NOATIME in inode->i_flags, not MS_NOATIME in sb->s_flags.
Actually, I've been wrong here - we *do* need that check, since there are
filesystems that force noatime or nodiratime.

>From grepping for that stuff it appears that

a) a bunch of filesystems force nodiratime and do not allow to override it
on remount.  Same for noatime (BTW, noatime implies nodiratime, so setting
both is pointless).

b) some filesystems force nodiratime at mount time, but do not care to preserve
it on remount.  Most of those are my fault - I've missed the remount side of
things in readdir patch.  They should have nodiratime always on to match
the original behaviour.  IMO, both (a) and (b) should be handled by a new
field - sb->s_forced_flags.  do_remount_sb() would set those in flags before
doing anything else.  Note that assignment to ->s_flags in do_remount_sb()
is not safe - e.g. ext[23] can get forced r/o by fs error and if that
happens after return from ->remount_sb() but before assignement, we are
screwed.  IOW, do_remount_sb() will need more work.

c) XFS has an odd wankfest around MS_NOATIME - grep for XFSMNT_NOATIME and
XFS_MOUNT_NOATIME.  AFAICS the only use is in xfs_ichgtime() and it's
redundant - we check IS_NOATIME() right after checking for XFS_MOUNT_NOATIME
there.  However, that will become very interesting when it gets to
per-mountpoint r/o
        /*
         * We're not supposed to change timestamps in readonly-mounted
         * filesystems.  Throw it away if anyone asks us.
         */
        if (unlikely(vp->v_vfsp->vfs_flag & VFS_RDONLY))
                return;
in xfs_ichgtime() is too damn deep in call chains, so...

d) nfs_getattr() is very odd - it overloads semantics of noatime and nodiratime
for NFS in a strange way.
