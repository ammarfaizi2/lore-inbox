Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWDYCfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWDYCfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWDYCfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:35:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:28823 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751537AbWDYCfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:35:11 -0400
From: sekharan@us.ibm.com
To: akpm@osdl.org, torvalds@osdl.org
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Date: Mon, 24 Apr 2006 19:35:09 -0700
Message-Id: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/3] Fix for the bug reported by Herbert on 2.6.17-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl (herbert_at_13thfloor.at) got a oops in 2.6.17-rc2 in
notifier_chain_register(), when mounting an xfs filesystem (oops
info at the end).

I started debugging the oops and found that quite a few users of
notifier call chains incorrectly use init section for notifier_block
data structure definitions and notifier_call function definitions.

I went through all the usages of both of those (199 files in total),
and fixed all of them.

I could reproduce the problem that Herbert has reported without these
patches and verified that they do not occur when these patches are
applied.

Herbert, please try this patchset and reply.

chandra
--

This patchset has 3 patches

remove_devinitdata - removes __devinit_data from all the defintions
	of notifier_block
remove_devinit - removed __devinit and __cpuinit from all the definitions
	of notifier_call
check_init_data - Adds an ASSERT to notifier_chain_register() to make 
	sure that the notifier_block and the notifier_call are not in
	the init section.

---- oops report by Herbert


[   64.289157] BUG: unable to handle kernel paging request at virtual address c056a680
[   64.290085]  printing eip:
[   64.290402] c0129290
[   64.290686] *pde = 005bd027
[   64.291037] *pte = 0056a000
[   64.291504] Oops: 0000 [#1]
[   64.291823] SMP DEBUG_PAGEALLOC
[   64.292820] Modules linked in:
[   64.293453] CPU:    0
[   64.293485] EIP:    0060:[<c0129290>]    Not tainted VLI
[   64.293529] EFLAGS: 00000286   (2.6.17-rc2 #1) 
[   64.295055] EIP is at notifier_chain_register+0x20/0x50
[   64.295648] eax: c056a678   ebx: cf5e23f8   ecx: 00000000   edx: c04bea9c
[   64.296362] esi: cf5e23f8   edi: cffc5000   ebp: cf5e2800   esp: cffdad5c
[   64.297140] ds: 007b   es: 007b   ss: 0068
[   64.297613] Process mount (pid: 34, threadinfo=cffda000 task=cff7e570)
[   64.298258] Stack: <0>c04bea80 c0129454 c04bea9c cf5e23f8 cf5e2000 cf5e2000 c01367f7 c04bea80 
[   64.299558]        cf5e23f8 c02d4b26 cf5e23f8 00000404 cf5e2000 cfd1f520 cffc5000 c02d1f53 
[   64.300700]        cf5e2000 00000001 c02e65ef 00000424 00000001 cffc5000 cfd1f520 c02f2880 
[   64.301841] Call Trace:
[   64.302278]  <c0129454> blocking_notifier_chain_register+0x54/0x90   <c01367f7> register_cpu_notifier+0x17/0x20
[   64.303684]  <c02d4b26> xfs_icsb_init_counters+0x46/0xb0   <c02d1f53> xfs_mount_init+0x23/0x160
[   64.304844]  <c02e65ef> kmem_zalloc+0x1f/0x50   <c02f2880> bhv_insert_all_vfsops+0x10/0x50
[   64.305940]  <c02f1f65> xfs_fs_fill_super+0x35/0x1f0   <c0313e97> snprintf+0x27/0x30
[   64.307124]  <c01a24f4> disk_name+0x64/0xc0   <c0168f1f> sb_set_blocksize+0x1f/0x50
[   64.308140]  <c0168869> get_sb_bdev+0x109/0x160   <c02f2150> xfs_fs_get_sb+0x30/0x40
[   64.309129]  <c02f1f30> xfs_fs_fill_super+0x0/0x1f0   <c0168b10> do_kern_mount+0xa0/0x160
[   64.310156]  <c0181187> do_new_mount+0x77/0xc0   <c018184f> do_mount+0x1bf/0x230
[   64.311177]  <c03f4a68> iret_exc+0x3d4/0x6ab   <c0181633> copy_mount_options+0x63/0xc0
[   64.312246]  <c03f427f> lock_kernel+0x2f/0x50   <c0181c5f> sys_mount+0x9f/0xe0
[   64.313237]  <c0102b27> syscall_call+0x7/0xb  
[   64.313917] Code: 90 90 90 90 90 90 90 90 90 90 90 53 8b 54 24 08 8b 5c 24 0c 8b 02 85 c0 74 31 8b 4b 08 8d b4 26 00 00 00
00 8d bc 27 00 00 00 00 <3b> 48 08 7f 1b 8d 50 04 8b 40 04 85 c0 75 f1 31 c0 eb 0d 90 90 
[   64.318371] EIP: [<c0129290>] notifier_chain_register+0x20/0x50 SS:ESP 0068:cffdad5c



-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
