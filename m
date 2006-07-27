Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWG0HaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWG0HaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWG0HaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:30:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55984 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932540AbWG0HaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:30:13 -0400
Subject: Re: [BUG?] possible recursive locking detected
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cantab.net>
In-Reply-To: <20060726225311.f51cee6d.akpm@osdl.org>
References: <200607261805.26711.eike-kernel@sf-tec.de>
	 <20060726225311.f51cee6d.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 27 Jul 2006 09:29:57 +0200
Message-Id: <1153985398.3039.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 22:53 -0700, Andrew Morton wrote:
> On Wed, 26 Jul 2006 18:05:21 +0200
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> 
> > Hi,
> > 
> > I did some memory stress test (allocating and mlock()ing a huge number of 
> > pages) from userspace. At the very beginning of that I got that error long 
> > before the system got unresponsible and the oom killer dropped in.
> > 
> > Eike
> > 
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > kded/5304 is trying to acquire lock:
> >  (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> > 
> > but task is already holding lock:
> >  (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> > 
> > other info that might help us debug this:
> > 3 locks held by kded/5304:
> >  #0:  (&inode->i_mutex){--..}, at: [<c11f476e>] mutex_lock+0x21/0x24
> >  #1:  (shrinker_rwsem){----}, at: [<c1046312>] shrink_slab+0x25/0x136
> >  #2:  (&type->s_umount_key#14){----}, at: [<c106be2e>] prune_dcache+0xf6/0x144
> > 
> > stack backtrace:
> >  [<c1003aa9>] show_trace_log_lvl+0x54/0xfd
> >  [<c1004915>] show_trace+0xd/0x10
> >  [<c100492f>] dump_stack+0x17/0x1c
> >  [<c102e0e1>] __lock_acquire+0x753/0x99c
> >  [<c102e5ac>] lock_acquire+0x4a/0x6a
> >  [<c11f4609>] __mutex_lock_slowpath+0xb0/0x1f4
> >  [<c11f476e>] mutex_lock+0x21/0x24
> >  [<f0854fc4>] ntfs_put_inode+0x3b/0x74 [ntfs]
> >  [<c106cf3f>] iput+0x33/0x6a
> >  [<c106b707>] dentry_iput+0x5b/0x73
> >  [<c106bd15>] prune_one_dentry+0x56/0x79
> >  [<c106be42>] prune_dcache+0x10a/0x144
> >  [<c106be95>] shrink_dcache_memory+0x19/0x31
> >  [<c10463bd>] shrink_slab+0xd0/0x136
> >  [<c1047494>] try_to_free_pages+0x129/0x1d5
> >  [<c1043d91>] __alloc_pages+0x18e/0x284
> >  [<c104044b>] read_cache_page+0x59/0x131
> >  [<c109e96f>] ext2_get_page+0x1c/0x1ff
> >  [<c109ebc4>] ext2_find_entry+0x72/0x139
> >  [<c109ec99>] ext2_inode_by_name+0xe/0x2e
> >  [<c10a1cad>] ext2_lookup+0x1f/0x65
> >  [<c1064661>] do_lookup+0xa0/0x134
> >  [<c1064e9a>] __link_path_walk+0x7a5/0xbe4
> >  [<c1065329>] link_path_walk+0x50/0xca
> >  [<c106586d>] do_path_lookup+0x212/0x25a
> >  [<c1065da9>] __user_walk_fd+0x2d/0x41
> >  [<c10600bd>] vfs_stat_fd+0x19/0x40
> >  [<c10600f5>] vfs_stat+0x11/0x13
> >  [<c1060826>] sys_stat64+0x14/0x2a
> >  [<c1002845>] sysenter_past_esp+0x56/0x8d
> 
> We hold the ext2 directory mutex, and ntfs_put_inode is trying to take an
> ntfs i_mutex.  Not a deadlock as such, but it could become one in ntfs if
> ntfs ever does a __GFP_WAIT allocation inside i_mutex, which it surely
> does.

I talked with Al about this one briefly yesterday; he considers it not a
bug but personally I'd be a lot happier if ext2 would use GFP_NOFS for
this allocation. Well not so much ext2 as read_cache_page() which is
generic code....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

