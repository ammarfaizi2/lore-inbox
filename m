Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUD3Hyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUD3Hyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUD3Hyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:54:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:7218 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265105AbUD3HyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:54:02 -0400
Message-ID: <40920561.2565C9C8@melbourne.sgi.com>
Date: Fri, 30 Apr 2004 17:50:57 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com> <16529.56343.764629.37296@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> If I understand you correctly, the main problem is that a disconnected
> dentry can hold an inode active after the last link has been removed.
> The file will not then be truncated and removed until memory pressure
> flushes the disconnected dentry from the dcache.
> 
> This problem can be resolved by making sure that an inode never has
> both a connected and a disconnected dentry.
> 
> This is already the case for directories (as they must only have one
> dentry), but it is not the case for non-directories.
> 
> The following patch tries to address this.  It is a "technology
> preview" in that the only testing I have done is that it compiles OK.
> 
> Please consider reviewing it to see if it makes sense.
> 
> It:
>  - changes d_alloc_anon to make sure that a new disconnected dentry is
>    only allocated if there is currently no (hashed) dentry for the
>    inode. (Previously this would noramlly be true, but a race was
>    possible).
>  - changes d_splice_alias to re-use a disconnected dentry on
>    non-directories as well as directories.
>  - splits most of d_find_alias out into a separate function to make
>    the above easier.
> 
> I haven't fully thought through issues with unhashed, connected
> dentries.
> __d_find_alias won't return them so d_alloc_anon will never return
> one, so it is possible to have an unhashed dentry and a disconnected
> dentry at the same time, which probably isn't desirable.
> 
> Is it OK for d_alloc_anon to return an unaliased dentry, and then have
> it possibly spliced back into the dentry tree??? I'm not sure.
> 
> Comments welcome.


I've been wrestling with a problem in this area for the last couple of 
days.  The symptoms are different but the ultimate cause appears to (also)
be a race condition somewhere under fh_verify() resulting in confused
dentry structures of some kind.  Eventually this results in __dget_locked()
being called on a dentry which has a zero reference count but is hashed
and not on the unused list, which spuriously decrements dentry_stat.nr_unused.
When this happens enough times dentry_stat.nr_unused drops below zero
and kswapd starts spinning trying to prune a near-infinite number of
dentries.

I just tried your patch and the problem remains.

What I'm getting from my debug setup is:

<4>kernel BUG at fs/dcache.c:289!
<4>nfsd[4981]: bugcheck! 0 [1]


   285	static inline struct dentry * __dget_locked(struct dentry *dentry)
   286	{
   287		atomic_inc(&dentry->d_count);
   288		if (atomic_read(&dentry->d_count) == 1) {
   289		    	BUG_ON(list_empty(&dentry->d_lru));   <-------------
   290			dentry_stat.nr_unused--;
   291			list_del_init(&dentry->d_lru);
   292			BUG_ON(dentry_stat.nr_unused < 0);
   293		}
   294		return dentry;
   295	}

[0]kdb> bt
Stack traceback for pid 4981
0xe00000300b1f0000     4981        1  1    0   R  0xe00000300b1f04f0 *nfsd
0xa0000001001a2250 __d_find_alias+0x250   <----- note: with your patch applied
        args (0xa000000100936acc, 0xe000003009059ba8, 0xa0000001001a23f0,
0x206)        kernel 0xa0000001001a2000 0xa0000001001a2380
0xa0000001001a23f0 d_find_alias+0x70
        args (0xe00000b07aff67b0, 0xa0000001008ec900, 0xa0000001001a4120,
0x287)        kernel 0xa0000001001a2380 0xa0000001001a2420
0xa0000001001a4120 d_alloc_anon+0x20
        args (0xe00000b07aff67b0, 0xe00000300b1f7ad0, 0xe00000300b1f7ac0,
0xa0000001003c4ee0, 0x207)
        kernel 0xa0000001001a4100 0xa0000001001a4440
0xa0000001003c4ee0 linvfs_get_dentry+0x120
        args (0xe00000b07aff67b0, 0xe00000307b299f18, 0xa000000100292860,
0xd1d)        kernel 0xa0000001003c4dc0 0xa0000001003c4f20
0xa000000100292860 find_exported_dentry+0xa0
        args (0xe000003008a9fa00, 0xe00000307b299f18, 0xe00000300b1f7ce0,
0xa000000100861340, 0xe00000b07aa6f180)
        kernel 0xa0000001002927c0 0xa000000100293920
0xa000000100294090 export_decode_fh+0xb0
        args (0xe000003008a9fa00, 0xe00000307b299f24, 0x4, 0x2, 0xa000000100861340)
        kernel 0xa000000100293fe0 0xa000000100294100
0xa0000001002993f0 fh_verify+0x910
        args (0xe000003016c0d000, 0xe00000307b299f08, 0x11270000, 0x44,
0xe00000307b299f14)
        kernel 0xa000000100298ae0 0xa000000100299960
0xa00000010029cb00 nfsd_open+0x40
        args (0xe000003016c0d000, 0xe00000307b299f08, 0x8000, 0x4,
0xe00000300b1f7d00)
        kernel 0xa00000010029cac0 0xa00000010029cea0
0xa00000010029d440 nfsd_read+0x40
        args (0xe000003016c0d000, 0xe00000307b299f08, 0xe00000300b1f7d10,
0xe00000307b299c38, 0x2)
        kernel 0xa00000010029d400 0xa00000010029dda0
0xa0000001002b02f0 nfsd3_proc_read+0x190
        args (0xe00000307b299f90, 0xe00000307b299b00, 0xe00000307b299f00,
0xe00000307b29a030, 0xe00000307b299f08)
        kernel 0xa0000001002b0160 0xa0000001002b0400
0xa000000100295120 nfsd_dispatch+0x280
        args (0xe000003016c0d000, 0xe00000306b888014, 0xa000000100ce7520,
0xe000003016c0d490, 0xa00000010093e0d0)
        kernel 0xa000000100294ea0 0xa000000100295320
0xa000000100721810 svc_process+0xff0
        args (0xe00000b07aa6e928, 0xe000003016c0d000, 0xe000003016c0d240,
0xe000003016c0d068, 0xa000000100ce7520)
        kernel 0xa000000100720820 0xa000000100721b60
0xa000000100294a60 nfsd+0x480
        args (0xe000003016c0d000, 0xfffeba2f, 0xfffeba2f, 0xe00000b07aa6e900,
0xa000000100b008a0)
        kernel 0xa0000001002945e0 0xa000000100294ea0
0xa00000010001ae60 kernel_thread_helper+0xe0
[...]

arg0 of the new d_find_alias() is the inode

[0]kdb> inode 0xe00000b07aff67b0 
struct inode at  0xe00000b07aff67b0
 i_ino = 137 i_count = 3 i_size 8589934592
 i_mode = 0100777  i_nlink = 1  i_rdev = 0x0
 i_hash.nxt = 0x0000000000000000 i_hash.pprev = 0xe00000307bcb6408
 i_list.nxt = 0xe000003008a9fac8 i_list.prv = 0xe000003008a9fac8
 i_dentry.nxt = 0xe000003009059b80 i_dentry.prv = 0xe000003009059b80
 i_sb = 0xe000003008a9fa00 i_op = 0xa0000001009422b0 i_data = 0xe00000b07aff68a8
nrpages = 73612
 i_fop= 0xa000000100941fe8 i_flock = 0x0000000000000000 i_mapping =
0xe00000b07aff68a8
 i_flags 0x0 i_state 0x1 [I_DIRTY_SYNC]  fs specific info @ 0xe00000b07aff6a10

Walk the dentry chain...only one entry

[0]kdb> dentry 0xe000003009059b80
Dentry at 0xe000003009059b80
 d_name.len = 16 d_name.name = 0xe000003016ca7010 <read_load_test.0>   <----- not
anonymous
 d_count = 1 d_flags = 0x4 d_inode = 0xe00000b07aff67b0
           ^           ^^^ DCACHE_DISCONNECTED
       count=0 before line 287
 d_parent = 0xe00000b0065d5480
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0xe00000307bbccbf0    <---- hashed
 d_lru.nxt = 0xe000003009059ba0 d_lru.prv = 0xe000003009059ba0      <---- not on
unused list
 d_child.nxt = 0xe00000b0065d54c0 d_child.prv = 0xe00000b0065d54c0
 d_subdirs.nxt = 0xe000003009059bc0 d_subdirs.prv = 0xe000003009059bc0
 d_alias.nxt = 0xe00000b07aff67d0 d_alias.prv = 0xe00000b07aff67d0
 d_op = 0x0000000000000000 d_sb = 0xe000003008a9fa00


>  /*
>   *     Try to kill dentries associated with this inode.
>   * WARNING: you must own a reference to inode.
> @@ -835,28 +841,22 @@ struct dentry * d_alloc_anon(struct inod
>         tmp->d_parent = tmp; /* make sure dput doesn't croak */
> 
>         spin_lock(&dcache_lock);
> -       if (S_ISDIR(inode->i_mode) && !list_empty(&inode->i_dentry)) {
> -               /* A directory can only have one dentry.
> -                * This (now) has one, so use it.
> -                */
> -               res = list_entry(inode->i_dentry.next, struct dentry, d_alias);
> -               __dget_locked(res);
> -       } else {
> -               /* attach a disconnected dentry */
> +
> +       res = __d_find_alias(inode, 0);
> +       if (!res) {
>                 res = tmp;

Yes this is an obvious (well, now) race condition. But not apparently the
whole story.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
