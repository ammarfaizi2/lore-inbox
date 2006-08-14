Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWHNIpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWHNIpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWHNIpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:45:17 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:6104 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751646AbWHNIpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:45:15 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: CIFS & Lockdep warnings
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, sfrench@samba.org,
       Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <20060813185102.e01898b9.akpm@osdl.org>
References: <20060814010503.2932.qmail@web52605.mail.yahoo.com>
	 <20060813185102.e01898b9.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 14 Aug 2006 09:44:59 +0100
Message-Id: <1155545099.6673.27.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-13 at 18:51 -0700, Andrew Morton wrote:
> On Mon, 14 Aug 2006 11:05:03 +1000 (EST)
> Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
> 
> > This is observed on 2.6.18-rc4 on SUSE 10.1 x86 on
> > P-IV. The volume is question was mounted from a
> > Windows 2003 server.
> > 
> > =======================================================
> > [ INFO: possible circular locking dependency detected
> > ]
> > -------------------------------------------------------
> > cp/11790 is trying to acquire lock:
> >  (iprune_mutex){--..}, at: [<c029e364>]
> > mutex_lock+0x19/0x20
> > 
> > but task is already holding lock:
> >  (&inode->i_mutex){--..}, at: [<c029e364>]
> > mutex_lock+0x19/0x20
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (&inode->i_mutex){--..}:
> >        [<c012a1c0>] lock_acquire+0x56/0x73
> >        [<c029e205>] __mutex_lock_slowpath+0xa6/0x1ec
> >        [<c029e364>] mutex_lock+0x19/0x20
> >        [<e3cd2b7a>] ntfs_put_inode+0x3e/0x79 [ntfs]
> >        [<c0169ac1>] iput+0x33/0x70
> >        [<c017738e>] inotify_unmount_inodes+0x12e/0x15f
> >        [<c016a55c>] invalidate_inodes+0x38/0xd1
> >        [<c01599b3>] generic_shutdown_super+0x5a/0x108
> >        [<c0159a81>] kill_block_super+0x20/0x36
> >        [<c0159b56>] deactivate_super+0x61/0x78
> >        [<c016c561>] mntput_no_expire+0x44/0x78
> >        [<c015f536>] path_release_on_umount+0x16/0x1d
> >        [<c016d692>] sys_umount+0x1d2/0x208
> >        [<c016d6d5>] sys_oldumount+0xd/0xf
> >        [<c0102cfb>] syscall_call+0x7/0xb
> 
> NTFS takes i_mutex inside iprune_mutex.  NTFS _should_ be deadlocking
> because of this (iprune_mutex nests inside i_mutex on the write() path) but
> somehow it gets away with it.

Directories are not subject to write(2) or at least not last time I
checked.  And ntfs_put_inode() only operates on directories...  To quote
current 2.6 kernel/fs/ntfs/inode.c:

void ntfs_put_inode(struct inode *vi)
{
        if (S_ISDIR(vi->i_mode) && atomic_read(&vi->i_count) == 2) {
                ntfs_inode *ni = NTFS_I(vi);
                if (NInoIndexAllocPresent(ni)) {
                        struct inode *bvi = NULL;
                        mutex_lock(&vi->i_mutex);
                        if (atomic_read(&vi->i_count) == 2) {
                                bvi = ni->itype.index.bmp_ino;
                                if (bvi)
                                        ni->itype.index.bmp_ino = NULL;
                        }
                        mutex_unlock(&vi->i_mutex);
                        if (bvi)
                                iput(bvi);
                }
        }
}

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

