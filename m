Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751312AbWFETUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWFETUm (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWFETUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:20:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12678 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751312AbWFETUl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:20:41 -0400
Message-Id: <200606051920.k55JKQGx003031@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, jack@suse.cz, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
In-Reply-To: Your message of "Mon, 05 Jun 2006 19:25:39 +0200."
             <1149528339.3111.114.camel@laptopd505.fenrus.org>
From: Valdis.Kletnieks@vt.edu
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu>
            <1149528339.3111.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149535226_2826P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 15:20:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149535226_2826P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jun 2006 19:25:39 +0200, Arjan van de Ven said:

> The quota code nests 3 mutexes but releases them in a totally different
> order; mark this as such in the code.

> ===================================================================
> --- linux-2.6.17-rc5-mm3.orig/fs/dquot.c
> +++ linux-2.6.17-rc5-mm3/fs/dquot.c
> @@ -1475,7 +1475,7 @@ static int vfs_quota_on_inode(struct ino
>  		goto out_file_init;
>  	}
>  	mutex_unlock(&dqopt->dqio_mutex);
> -	mutex_unlock(&inode->i_mutex);
> +	mutex_unlock_non_nested(&inode->i_mutex);
>  	set_enable_flags(dqopt, type);
>  
>  	add_dquot_ref(sb, type);

Obviously, there be bigger and nastier dragons lurking in the quota code.

This one made it past quotaon, but not as far as the swapon command in the
Fedora /etc/rc.sysinit.  There's a bunch of rm all over the place in that
section of the script, and I'm not sure at all which one triggered it.

[  228.335000] (              rm-1399 |#0): new 231527956 us user-latency.
[  228.335000] stopped custom tracer.
[  228.335000] 
[  228.335000] =====================================================
[  228.335000] [ BUG: possible circular locking deadlock detected! ]
[  228.335000] -----------------------------------------------------
[  228.335000] rm/1399 is trying to acquire lock:
[  228.335000]  (&inode->i_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000] 
[  228.335000] but task is already holding lock:
[  228.335000]  (&s->s_dquot.dqio_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000] 
[  228.335000] which lock already depends on the new lock,
[  228.335000] which could lead to circular deadlocks!
[  228.335000] 
[  228.335000] the existing dependency chain (in reverse order) is:
[  228.335000] 
[  228.335000] -> #5 (&s->s_dquot.dqio_mutex){--..}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c0382919>] __mutex_lock_slowpath+0x3a/0x11d
[  228.335000]        [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000]        [<c0192fbd>] dquot_acquire+0x2d/0xeb
[  228.335000]        [<c01aded9>] ext3_acquire_dquot+0x63/0x89
[  228.335000]        [<c0191d46>] dqget+0x264/0x2b0
[  228.335000]        [<c01934c7>] dquot_initialize+0x92/0xdb
[  228.335000]        [<c01addda>] ext3_dquot_initialize+0x53/0x79
[  228.335000]        [<c01702e6>] may_open+0x1c9/0x243
[  228.335000]        [<c0172a52>] open_namei+0x28f/0x710
[  228.335000]        [<c015f937>] do_filp_open+0x2b/0x42
[  228.335000]        [<c015f9af>] do_sys_open+0x61/0xe8
[  228.335000]        [<c015fa69>] sys_open+0x18/0x1a
[  228.335000]        [<c03845b2>] sysenter_past_esp+0x63/0xa1
[  228.335000] 
[  228.335000] -> #4 (&dquot->dq_lock){--..}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c0382919>] __mutex_lock_slowpath+0x3a/0x11d
[  228.335000]        [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000]        [<c0191d2b>] dqget+0x249/0x2b0
[  228.335000]        [<c01934c7>] dquot_initialize+0x92/0xdb
[  228.335000]        [<c01addda>] ext3_dquot_initialize+0x53/0x79
[  228.335000]        [<c01702e6>] may_open+0x1c9/0x243
[  228.335000]        [<c0172a52>] open_namei+0x28f/0x710
[  228.335000]        [<c015f937>] do_filp_open+0x2b/0x42
[  228.335000]        [<c015f9af>] do_sys_open+0x61/0xe8
[  228.335000]        [<c015fa69>] sys_open+0x18/0x1a
[  228.335000]        [<c03845b2>] sysenter_past_esp+0x63/0xa1
[  228.335000] 
[  228.335000] -> #3 (&s->s_dquot.dqptr_sem){----}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c01939b6>] dquot_free_space+0x4b/0x229
[  228.335000]        [<c01a1953>] ext3_free_blocks+0x75/0x94
[  228.335000]        [<c01a5915>] ext3_clear_blocks+0xcb/0xf8
[  228.335000]        [<c01a59e1>] ext3_free_data+0x9f/0xd4
[  228.335000]        [<c01a604c>] ext3_truncate+0x4a3/0x770
[  228.335000]        [<c015178a>] vmtruncate+0x126/0x151
[  228.335000]        [<c017bb0e>] inode_setattr+0x77/0x1a5
[  228.335000]        [<c01a71bb>] ext3_setattr+0x1b5/0x21d
[  228.335000]        [<c017bdc1>] notify_change+0x185/0x358
[  228.335000]        [<c015fc28>] do_truncate+0x5d/0x78
[  228.335000]        [<c01702f8>] may_open+0x1db/0x243
[  228.335000]        [<c0172a52>] open_namei+0x28f/0x710
[  228.335000]        [<c015f937>] do_filp_open+0x2b/0x42
[  228.335000]        [<c015f9af>] do_sys_open+0x61/0xe8
[  228.335000]        [<c015fa69>] sys_open+0x18/0x1a
[  228.335000]        [<c03845b2>] sysenter_past_esp+0x63/0xa1
[  228.335000] 
[  228.335000] -> #2 (&ei->truncate_mutex){--..}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c0382919>] __mutex_lock_slowpath+0x3a/0x11d
[  228.335000]        [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000]        [<c01a602d>] ext3_truncate+0x484/0x770
[  228.335000]        [<c015178a>] vmtruncate+0x126/0x151
[  228.335000]        [<c017bb0e>] inode_setattr+0x77/0x1a5
[  228.335000]        [<c01a71bb>] ext3_setattr+0x1b5/0x21d
[  228.335000]        [<c017bdc1>] notify_change+0x185/0x358
[  228.335000]        [<c015fc28>] do_truncate+0x5d/0x78
[  228.335000]        [<c01702f8>] may_open+0x1db/0x243
[  228.335000]        [<c0172a52>] open_namei+0x28f/0x710
[  228.335000]        [<c015f937>] do_filp_open+0x2b/0x42
[  228.335000]        [<c015f9af>] do_sys_open+0x61/0xe8
[  228.335000]        [<c015fa69>] sys_open+0x18/0x1a
[  228.335000]        [<c03845b2>] sysenter_past_esp+0x63/0xa1
[  228.335000] 
[  228.335000] -> #1 (&inode->i_alloc_sem){--..}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c017bd4c>] notify_change+0x110/0x358
[  228.335000]        [<c015fc28>] do_truncate+0x5d/0x78
[  228.335000]        [<c01702f8>] may_open+0x1db/0x243
[  228.335000]        [<c0172a52>] open_namei+0x28f/0x710
[  228.335000]        [<c015f937>] do_filp_open+0x2b/0x42
[  228.335000]        [<c015f9af>] do_sys_open+0x61/0xe8
[  228.335000]        [<c015fa69>] sys_open+0x18/0x1a
[  228.335000]        [<c0384644>] syscall_call+0x7/0xb
[  228.335000] 
[  228.335000] -> #0 (&inode->i_mutex){--..}:
[  228.335000]        [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]        [<c0382919>] __mutex_lock_slowpath+0x3a/0x11d
[  228.335000]        [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000]        [<c01adb93>] ext3_quota_write+0x80/0x274
[  228.335000]        [<c019521d>] v2_write_dquot+0x112/0x152
[  228.335000]        [<c01933e9>] dquot_commit+0x88/0xd4
[  228.335000]        [<c01abd84>] ext3_write_dquot+0x63/0x89
[  228.335000]        [<c01919b4>] dqput+0x118/0x1bb
[  228.335000]        [<c0193565>] dquot_drop+0x55/0x9c
[  228.335000]        [<c01ade50>] ext3_dquot_drop+0x50/0x76
[  228.335000]        [<c01a3ca7>] ext3_free_inode+0x100/0x32d
[  228.335000]        [<c01a68d9>] ext3_delete_inode+0xc3/0xe2
[  228.335000]        [<c017ac28>] generic_delete_inode+0xdb/0x164
[  228.335000]        [<c017acca>] generic_drop_inode+0x19/0x14b
[  228.335000]        [<c017a5d6>] iput+0x84/0x8c
[  228.335000]        [<c0172010>] do_unlinkat+0xe7/0x159
[  228.335000]        [<c0172094>] sys_unlink+0x12/0x14
[  228.335000]        [<c03845b2>] sysenter_past_esp+0x63/0xa1
[  228.335000] 
[  228.335000] other info that might help us debug this:
[  228.335000] 
[  228.335000] 2 locks held by rm/1399:
[  228.335000]  #0:  (&s->s_dquot.dqptr_sem){----}, at: [<c0193529>] dquot_drop+0x19/0x9c
[  228.335000]  #1:  (&s->s_dquot.dqio_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000] 
[  228.335000] stack backtrace:
[  228.335000]  [<c01032d6>] show_trace_log_lvl+0x64/0x125
[  228.335000]  [<c0103865>] show_trace+0x1b/0x20
[  228.335000]  [<c010391c>] dump_stack+0x1f/0x24
[  228.335000]  [<c012ce2e>] print_circular_bug_tail+0x5d/0x69
[  228.335000]  [<c012d6d0>] __lockdep_acquire+0x896/0xa91
[  228.335000]  [<c012dd3d>] lockdep_acquire+0x67/0x7f
[  228.335000]  [<c0382919>] __mutex_lock_slowpath+0x3a/0x11d
[  228.335000]  [<c0382a09>] mutex_lock+0xd/0xf
[  228.335000]  [<c01adb93>] ext3_quota_write+0x80/0x274
[  228.335000]  [<c019521d>] v2_write_dquot+0x112/0x152
[  228.335000]  [<c01933e9>] dquot_commit+0x88/0xd4
[  228.335000]  [<c01abd84>] ext3_write_dquot+0x63/0x89
[  228.335000]  [<c01919b4>] dqput+0x118/0x1bb
[  228.335000]  [<c0193565>] dquot_drop+0x55/0x9c
[  228.335000]  [<c01ade50>] ext3_dquot_drop+0x50/0x76
[  228.335000]  [<c01a3ca7>] ext3_free_inode+0x100/0x32d
[  228.335000]  [<c01a68d9>] ext3_delete_inode+0xc3/0xe2
[  228.335000]  [<c017ac28>] generic_delete_inode+0xdb/0x164
[  228.335000]  [<c017acca>] generic_drop_inode+0x19/0x14b
[  228.335000]  [<c017a5d6>] iput+0x84/0x8c
[  228.335000]  [<c0172010>] do_unlinkat+0xe7/0x159
[  228.335000]  [<c0172094>] sys_unlink+0x12/0x14
[  228.335000]  [<c03845b2>] sysenter_past_esp+0x63/0xa1


--==_Exmh_1149535226_2826P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhIP6cC3lWbTT17ARApF4AKC7I90gGAjwyNQ/Izk0PEz9x9h60QCg4DzU
uywEQbpaFHnmy2I2W9pTnw0=
=tIx3
-----END PGP SIGNATURE-----

--==_Exmh_1149535226_2826P--
