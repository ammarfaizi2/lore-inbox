Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTBVH7f>; Sat, 22 Feb 2003 02:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTBVH7f>; Sat, 22 Feb 2003 02:59:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26030 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267843AbTBVH7d>; Sat, 22 Feb 2003 02:59:33 -0500
Date: Sat, 22 Feb 2003 00:09:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: zwane@linuxpower.ca
Subject: Oops in rpc_depopulate with 2.5.62
Message-ID: <25140000.1045901377@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting rpc/nfs bugs on at least two different machines I've seen
and reports of a third from Zwane - all look similar. Anyone got
any bright ideas?

M.

Unable to handle kernel NULL pointer dereference at virtual address 0000006c
 printing eip:
c03415e2
*pde = 358d2001
*pte = 00000000
Oops: 0002
CPU:    1
EIP:    0060:[<c03415e2>]    Not tainted
EFLAGS: 00010206
EIP is at rpc_depopulate+0x22/0xf0
eax: 00000000   ebx: f5133680   ecx: 0000006c   edx: f50afc1c
esi: f50afbf4   edi: f50afbf4   ebp: f50afc08   esp: f50afbec
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 1166, threadinfo=f50ae000 task=f5766d80)
Stack: c01562f0 00000000 f50afbf4 f50afbf4 f5133680 f5133680 f51c1e00 f50afc40 
       c0341af5 f5133680 f5117880 f7ff9800 f50afcec 00000000 f50afc34 00000010 
       00000001 00000000 f5982680 f50afcec 00000000 f50afc50 c0333066 f5982714 
Call Trace:
 [<c01562f0>] lookup_hash+0x70/0xa0
 [<c0341af5>] rpc_rmdir+0x55/0x90
 [<c0333066>] rpc_destroy_client+0x46/0x70
 [<c03330db>] rpc_release_client+0x4b/0x60
 [<c0337bc7>] rpc_release_task+0x1a7/0x1d0
 [<c033754b>] __rpc_execute+0x35b/0x370
 [<c011a980>] default_wake_function+0x0/0x20
 [<c0333274>] rpc_call_sync+0x64/0xa0
 [<c0333287>] rpc_call_sync+0x77/0xa0
 [<c03366b0>] rpc_run_timer+0x0/0xa0
 [<c033e5fb>] rpc_register+0xcb/0x100
 [<c0110000>] mask_and_ack_8259A+0x10/0xf0
 [<c0339d24>] svc_register+0x94/0x100
 [<c0339944>] svc_create+0xd4/0xe0
 [<c01c1fb8>] lockd_up+0x58/0x110
 [<c01a63f4>] nfs_fill_super+0x374/0x3a0
 [<c01a7e90>] nfs_get_sb+0x1f0/0x230
 [<c0150052>] do_kern_mount+0x42/0xa0
 [<c01631e6>] do_add_mount+0x76/0x150
 [<c0133596>] __alloc_pages+0x76/0x2c0
 [<c01634d7>] do_mount+0x147/0x160
 [<c0163908>] sys_mount+0xa8/0x110
 [<c010ae7b>] syscall_call+0x7/0xb

Code: f0 ff 48 6c 0f 88 70 09 00 00 f0 fe 0d 00 d2 44 c0 0f 88 6d 

Seems to be crashing on the  deference of:

        down(&dir->i_sem);

in rpc_depopulate. But there's a big comment just above saying:

-----------------------
/*
 * FIXME: This probably has races.
 */
static void
rpc_depopulate(struct dentry *parent)
{
        struct inode *dir = parent->d_inode;
        LIST_HEAD(head);
        struct list_head *pos, *next;
        struct dentry *dentry;

        down(&dir->i_sem);

------------------

Looks like dir is NULL here ... might be dcache_rcu (a recent dcache_rcu
patch fixed the same file) or a race brought out by the changes.


