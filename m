Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWG0HPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWG0HPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWG0HPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:15:40 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:27290 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932536AbWG0HPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:15:40 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [BUG?] possible recursive locking detected
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       linux-kernel@vger.kernel.org, Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <44C86271.9030603@yahoo.com.au>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org>  <44C86271.9030603@yahoo.com.au>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 27 Jul 2006 08:15:27 +0100
Message-Id: <1153984527.21849.2.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 16:51 +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> > On Wed, 26 Jul 2006 18:05:21 +0200
> > Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > 
> > 
> >>Hi,
> >>
> >>I did some memory stress test (allocating and mlock()ing a huge number of 
> >>pages) from userspace. At the very beginning of that I got that error long 
> >>before the system got unresponsible and the oom killer dropped in.
> >>
> >>Eike
> >>
> >>=============================================
> >>[ INFO: possible recursive locking detected ]
> >>kded/5304 is trying to acquire lock:
> >> (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> >>
> >>but task is already holding lock:
> >> (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> >>
> >>other info that might help us debug this:
> >>3 locks held by kded/5304:
> >> #0:  (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> >> #1:  (shrinker_rwsem){----}, at: [<c1046312>] shrink_slab+0x25/0x136
> >> #2:  (&type->s_umount_key#14){----}, at: [<c106be2e>] prune_dcache+0xf6/0x144
> >>
> >>stack backtrace:
> >> [<c1003aa9>] show_trace_log_lvl+0x54/0xfd
> >> [<c1004915>] show_trace+0xd/0x10
> >> [<c100492f>] dump_stack+0x17/0x1c
> >> [<c102e0e1>] __lock_acquire+0x753/0x99c
> >> [<c102e5ac>] lock_acquire+0x4a/0x6a
> >> [<c11f4609>] __mutex_lock_slowpath+0xb0/0x1f4
> >> [<c11f476e>] mutex_lock+0x21/0x24
> >> [<f0854fc4>] ntfs_put_inode+0x3b/0x74 [ntfs]
> >> [<c106cf3f>] iput+0x33/0x6a
> >> [<c106b707>] dentry_iput+0x5b/0x73
> >> [<c106bd15>] prune_one_dentry+0x56/0x79
> >> [<c106be42>] prune_dcache+0x10a/0x144
> >> [<c106be95>] shrink_dcache_memory+0x19/0x31
> >> [<c10463bd>] shrink_slab+0xd0/0x136
> >> [<c1047494>] try_to_free_pages+0x129/0x1d5
> >> [<c1043d91>] __alloc_pages+0x18e/0x284
> >> [<c104044b>] read_cache_page+0x59/0x131
> >> [<c109e96f>] ext2_get_page+0x1c/0x1ff
> >> [<c109ebc4>] ext2_find_entry+0x72/0x139
> >> [<c109ec99>] ext2_inode_by_name+0xe/0x2e
> >> [<c10a1cad>] ext2_lookup+0x1f/0x65
> >> [<c1064661>] do_lookup+0xa0/0x134
> >> [<c1064e9a>] __link_path_walk+0x7a5/0xbe4
> >> [<c1065329>] link_path_walk+0x50/0xca
> >> [<c106586d>] do_path_lookup+0x212/0x25a
> >> [<c1065da9>] __user_walk_fd+0x2d/0x41
> >> [<c10600bd>] vfs_stat_fd+0x19/0x40
> >> [<c10600f5>] vfs_stat+0x11/0x13
> >> [<c1060826>] sys_stat64+0x14/0x2a
> >> [<c1002845>] sysenter_past_esp+0x56/0x8d
> > 
> > 
> > We hold the ext2 directory mutex, and ntfs_put_inode is trying to take an
> > ntfs i_mutex.  Not a deadlock as such, but it could become one in ntfs if
> > ntfs ever does a __GFP_WAIT allocation inside i_mutex, which it surely
> > does.

Yes we do use __GFP_WAIT but the only alternative is to panic() and I
certainly prefer a __GFP_WAIT allocation that can deadlock in some cases
compared to a 100% certain panic() to kill the system...

> Though it should be using GFP_NOFS, right? So the dcache shrinker would
> not reenter the fs in that case.

NTFS _always_ sets at least GFP_NOFS.

> I'm surprised ext2 is allocating with __GFP_FS set, though. Would that
> cause any problem?

That is an ext2 bug IMO.  A file system should always use GFP_NOFS
otherwise it is asking for trouble.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

