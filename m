Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268531AbUHRAPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268531AbUHRAPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268530AbUHRAPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:15:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58777 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268533AbUHRAPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:15:17 -0400
In-Reply-To: <OF23F9155B.45719C1E-ON88256EF3.008314E2-88256EF3.00833506@LocalDomain>
Subject: Re: Bad: scheduling while atomic, 2.6.7
To: linux-kernel@vger.kernel.org
Cc: rieserfs-list@namesys.com, david@blue-labs.org
X-Mailer: Lotus Notes Release 6.0.1 February 07, 2003
Message-ID: <OFDA04D539.96A63AB2-ON88256EF3.00834277-88256EF4.00013B64@us.ibm.com>
From: Marc Eshel <eshel@almaden.ibm.com>
Date: Tue, 17 Aug 2004 17:13:27 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 6.51HF433 | July 14, 2004) at
 08/17/2004 20:14:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I believe that the problem reported by David is caused by find_inode()
calling test(inode, data)
when the inode is in a transition state(I_LOCK|I_NEW|I_FREEING|I_CLEAR).
The test() call that used to
be called find actor is calling the underling filesystem with an Inode that
is not initialized yet or is
being deleted.
A simple change in find_inode() to move the code that already checks for
this transition state after
the call to test(), to be done before the call to test() will solve the
problem for inode deletion, and
adding a check for I_LOCK and waiting on new inode creation will fix it for
adding inodes.

David Ford wrote on 07/02/2004:

> AMD64, nothing special about the kernel.
>
> Unable to handle kernel paging request at 000001083d74a4c8 RIP:
> <ffffffff801ba763>{find_inode+35}
> PML4 8063 PGD 0
> Oops: 0000 [1] PREEMPT
> CPU 0
> Modules linked in: ipt_REJECT iptable_filter iptable_mangle
> ipt_MASQUERADE iptable_nat ip_conntrack ip_tables
> Pid: 8598, comm: rsync Not tainted 2.6.7
> RIP: 0010:[<ffffffff801ba763>] <ffffffff801ba763>{find_inode+35}
> RSP: 0018:0000010017ca5b78  EFLAGS: 00010202
> RAX: 000001083d74a4c8 RBX: 000001083d74a4c8 RCX: 0000010017ca5c00
> RDX: ffffffff801f5f20 RSI: 000001003fe669a8 RDI: 000001003f82b578
> RBP: 000001003f82b578 R08: 0000010017ca5c00 R09: 0000010012cb97b8
> R10: 0000000000000001 R11: 0000000000000246 R12: 000001003f82b578
> R13: 000001003fe669a8 R14: 0000010017ca5c00 R15: ffffffff801f5f20
> FS:  0000002a95aa2090(0000) GS:ffffffff807fc000(0000)
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 000001083d74a4c8 CR3: 0000000000101000 CR4: 00000000000006e0
> Process rsync (pid: 8598, threadinfo 0000010017ca4000, task
> 000001001fd6ab10)
> Stack: 0000010012cb84c8 0000010017ca5c38 000001003f82b578
000001003fe669a8
>        0000010017ca5c00 ffffffff801f5f20 ffffffff801f5df0
ffffffff801bbb12
>        0000000000000006 0000010017ca5c38
> Call Trace:<ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5df0>{reiserfs_init_locked_inode+0}
>        <ffffffff801bbb12>{iget5_locked+290}
> <ffffffff801f5fa2>{reiserfs_iget+82}
>        <ffffffff801efb1a>{reiserfs_lookup+442}
> <ffffffff801a75a3>{real_lookup+131}
>        <ffffffff801a7a99>{do_lookup+105}
> <ffffffff801a8a19>{link_path_walk+3881}
>        <ffffffff8016e320>{poison_obj+48}
<ffffffff801a90be>{path_lookup+494}
>        <ffffffff801a928e>{__user_walk+62}
<ffffffff801a1720>{vfs_lstat+32}
>        <ffffffff801a1b5f>{sys_newlstat+31}
> <ffffffff8011221a>{system_call+126}
>
>
> Code: 48 8b 03 0f 18 08 4c 39 a3 80 01 00 00 75 23 4c 89 f6 48 89
> RIP <ffffffff801ba763>{find_inode+35} RSP <0000010017ca5b78>
> CR2: 000001083d74a4c8
>  <6>note: rsync[8598] exited with preempt_count 2
> bad: scheduling while atomic!
>
> Call Trace:<ffffffff8053795e>{schedule+94}
> <ffffffff80179d5a>{zap_pmd_range+186}
>        <ffffffff8017a03c>{unmap_vmas+572}
<ffffffff80180b05>{exit_mmap+293}
>        <ffffffff80139600>{mmput+272} <ffffffff80140fdf>{do_exit+815}
>        <ffffffff8011391d>{oops_end+205}
> <ffffffff80127ab5>{do_page_fault+1109}
>        <ffffffff80194610>{bh_wake_function+0}
> <ffffffff80194610>{bh_wake_function+0}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff80112b3d>{error_exit+0}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5f20>{reiserfs_find_actor+0}
>        <ffffffff801ba763>{find_inode+35}
> <ffffffff801ef692>{linear_search_in_dir_item+402}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5df0>{reiserfs_init_locked_inode+0}
>        <ffffffff801bbb12>{iget5_locked+290}
> <ffffffff801f5fa2>{reiserfs_iget+82}
>        <ffffffff801efb1a>{reiserfs_lookup+442}
> <ffffffff801a75a3>{real_lookup+131}
>        <ffffffff801a7a99>{do_lookup+105}
> <ffffffff801a8a19>{link_path_walk+3881}
>        <ffffffff8016e320>{poison_obj+48}
<ffffffff801a90be>{path_lookup+494}
>        <ffffffff801a928e>{__user_walk+62}
<ffffffff801a1720>{vfs_lstat+32}
>        <ffffffff801a1b5f>{sys_newlstat+31}
> <ffffffff8011221a>{system_call+126}
>
> lib/dec_and_lock.c:32: spin_lock(fs/inode.c:ffffffff8069c820) already
> locked by fs/inode.c/775
> Unable to handle kernel paging request at 0000000a00000000 RIP:
> <ffffffff801ba763>{find_inode+35}
> PML4 4f20067 PGD 0
> Oops: 0000 [2] PREEMPT
> CPU 0
> Modules linked in: ipt_REJECT iptable_filter iptable_mangle
> ipt_MASQUERADE iptable_nat ip_conntrack ip_tables
> Pid: 29539, comm: gmake Not tainted 2.6.7
> RIP: 0010:[<ffffffff801ba763>] <ffffffff801ba763>{find_inode+35}
> RSP: 0018:0000010028399b78  EFLAGS: 00010206
> RAX: 0000000a00000000 RBX: 0000000a00000000 RCX: 0000010028399c00
> RDX: ffffffff801f5f20 RSI: 000001003fe7ea40 RDI: 000001003f82b578
> RBP: 000001003f82b578 R08: 0000010028399c00 R09: 0000010009798150
> R10: 0000000000000001 R11: 0000000000000246 R12: 000001003f82b578
> R13: 000001003fe7ea40 R14: 0000010028399c00 R15: ffffffff801f5f20
> FS:  0000002a95aa4090(0000) GS:ffffffff807fc000(0000)
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000a00000000 CR3: 0000000000101000 CR4: 00000000000006e0
> Process gmake (pid: 29539, threadinfo 0000010028398000, task
> 00000100219560b0)
> Stack: 000001002113b0e0 0000010028399c38 000001003f82b578
000001003fe7ea40
>        0000010028399c00 ffffffff801f5f20 ffffffff801f5df0
ffffffff801bbb12
>        0000000000000004 0000010028399c38
> Call Trace:<ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5df0>{reiserfs_init_locked_inode+0}
>        <ffffffff801bbb12>{iget5_locked+290}
> <ffffffff801f5fa2>{reiserfs_iget+82}
>        <ffffffff801efb1a>{reiserfs_lookup+442}
> <ffffffff801a75a3>{real_lookup+131}
>        <ffffffff801a7a99>{do_lookup+105}
> <ffffffff801a8a19>{link_path_walk+3881}
>        <ffffffff8016e320>{poison_obj+48}
<ffffffff801a90be>{path_lookup+494}
>        <ffffffff801a928e>{__user_walk+62} <ffffffff801a16c3>{vfs_stat+35}
>        <ffffffff801a1b0f>{sys_newstat+31}
> <ffffffff8011221a>{system_call+126}
>
>
> Code: 48 8b 03 0f 18 08 4c 39 a3 80 01 00 00 75 23 4c 89 f6 48 89
> RIP <ffffffff801ba763>{find_inode+35} RSP <0000010028399b78>
> CR2: 0000000a00000000
>  <6>note: gmake[29539] exited with preempt_count 2
> bad: scheduling while atomic!
>
> Call Trace:<ffffffff8053795e>{schedule+94}
> <ffffffff80179d5a>{zap_pmd_range+186}
>        <ffffffff8017a03c>{unmap_vmas+572}
<ffffffff80180b05>{exit_mmap+293}
>        <ffffffff80139600>{mmput+272} <ffffffff80140fdf>{do_exit+815}
>        <ffffffff8011391d>{oops_end+205}
> <ffffffff80127ab5>{do_page_fault+1109}
>        <ffffffff80173bc7>{mark_page_accessed+39}
> <ffffffff8019748c>{__find_get_block+252}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff80112b3d>{error_exit+0}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5f20>{reiserfs_find_actor+0}
>        <ffffffff801ba763>{find_inode+35}
> <ffffffff801ef692>{linear_search_in_dir_item+402}
>        <ffffffff801f5f20>{reiserfs_find_actor+0}
> <ffffffff801f5df0>{reiserfs_init_locked_inode+0}
>        <ffffffff801bbb12>{iget5_locked+290}
> <ffffffff801f5fa2>{reiserfs_iget+82}
>        <ffffffff801efb1a>{reiserfs_lookup+442}
> <ffffffff801a75a3>{real_lookup+131}
>        <ffffffff801a7a99>{do_lookup+105}
> <ffffffff801a8a19>{link_path_walk+3881}
>        <ffffffff8016e320>{poison_obj+48}
<ffffffff801a90be>{path_lookup+494}
>        <ffffffff801a928e>{__user_walk+62} <ffffffff801a16c3>{vfs_stat+35}
>        <ffffffff801a1b0f>{sys_newstat+31}
> <ffffffff8011221a>{system_call+126}
>
> fs/fs-writeback.c:96: spin_lock(fs/inode.c:ffffffff8069c820) already
> locked by fs/inode.c/775

