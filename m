Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUINOXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUINOXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbUINOXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:23:52 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29449 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269320AbUINOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:23:46 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Kernel stack overflow on 2.6.9-rc2
Date: Tue, 14 Sep 2004 17:23:34 +0300
User-Agent: KMail/1.5.4
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409141723.35009.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am putting to use an ancient box. Pentium 66.
It gives me stack overflow errors on 2.6.9-rc2:

init: spawning /sbin/agetty
do_IRQ: stack overflow: 508
 [<c0105cf2>] dump_stack+0x17/0x1b
 [<c0106fad>] do_IRQ+0x177/0x17e
 [<c0105888>] common_interrupt+0x18/0x20
 [<c038ac44>] kfree_skbmem+0xd/0x21
 [<c038acff>] __kfree_skb+0xa7/0x118
 [<c028efe9>] ei_start_xmit+0x142/0x254
 [<c0399865>] qdisc_restart+0x41/0xc3
 [<c038f3d0>] dev_queue_xmit+0x180/0x20b
 [<c03a7826>] ip_finish_output2+0xa1/0x18b
 [<c0396ec7>] nf_hook_slow+0x91/0xc0
 [<c03a5617>] ip_finish_output+0x1c5/0x1ca
 [<c03a776c>] dst_output+0x11/0x2a
 [<c0396ec7>] nf_hook_slow+0x91/0xc0
 [<c03a73d1>] ip_push_pending_frames+0x39c/0x3f5
 [<c03c05bb>] udp_push_pending_frames+0x13d/0x25c
 [<c03c0a7d>] udp_sendmsg+0x35e/0x61a
 [<c03c72a7>] inet_sendmsg+0x3a/0x45
 [<c0387a15>] sock_sendmsg+0x88/0xa3
 [<c03efb57>] xdr_sendpages+0xb1/0x22e
 [<c03e79fc>] xprt_transmit+0xbe/0x45f
 [<c03e5d04>] call_transmit+0x46/0xa0
 [<c03e93e8>] __rpc_execute+0x29a/0x3b1
 [<c03e5652>] rpc_call_sync+0x59/0x95
 [<c01cb255>] nfs3_rpc_wrapper+0x2d/0x70
 [<c01cb42d>] nfs3_proc_getattr+0x57/0x89
 [<c01c3d26>] __nfs_revalidate_inode+0xc7/0x308
 [<c01c07ef>] nfs_lookup_revalidate+0x257/0x4ed
 [<c014a33b>] do_lookup+0x43/0x76
 [<c014a7b3>] link_path_walk+0x445/0x883
 [<c014cc7b>] __vfs_follow_link+0x28/0x133
 [<c01c8b09>] nfs_follow_link+0x28/0x47
 [<c014a887>] link_path_walk+0x519/0x883
 [<c014cc7b>] __vfs_follow_link+0x28/0x133
 [<c01c8b09>] nfs_follow_link+0x28/0x47
 [<c014a887>] link_path_walk+0x519/0x883
 [<c014add4>] path_lookup+0x70/0x10a
 [<c0147bf0>] open_exec+0x22/0xc4
 [<c015f15a>] load_elf_binary+0xc4f/0xcc8
 [<c01486b3>] search_binary_handler+0x4b/0x196
 [<c015dcae>] load_script+0x1ea/0x220
 [<c01486b3>] search_binary_handler+0x4b/0x196
 [<c0148951>] do_execve+0x153/0x1b9
 [<c01044c2>] sys_execve+0x2d/0x60
 [<c0105667>] syscall_call+0x7/0xb

I've run make checkstack and matched funtions
using this script:

cat stackovf.txt \
| {
sum=0
while read empty addr name_ofs junk; do
        name=${name_ofs/+*/}
        num=`grep -F $name checkstack.list`
        num=${num/*     /}
        let sum+=num
        echo $name_ofs $junk [$num]
done
echo Total: $sum
}

Output:
dump_stack+0x17/0x1b []
do_IRQ+0x177/0x17e []
common_interrupt+0x18/0x20 []
kfree_skbmem+0xd/0x21 []
__kfree_skb+0xa7/0x118 []
ei_start_xmit+0x142/0x254 []
qdisc_restart+0x41/0xc3 []
dev_queue_xmit+0x180/0x20b []
ip_finish_output2+0xa1/0x18b []
nf_hook_slow+0x91/0xc0 []
ip_finish_output+0x1c5/0x1ca []
dst_output+0x11/0x2a []
nf_hook_slow+0x91/0xc0 []
ip_push_pending_frames+0x39c/0x3f5 []
udp_push_pending_frames+0x13d/0x25c []
udp_sendmsg+0x35e/0x61a [220]
inet_sendmsg+0x3a/0x45 []
sock_sendmsg+0x88/0xa3 [208]
xdr_sendpages+0xb1/0x22e []
xprt_transmit+0xbe/0x45f []
call_transmit+0x46/0xa0 []
__rpc_execute+0x29a/0x3b1 []
rpc_call_sync+0x59/0x95 []
nfs3_rpc_wrapper+0x2d/0x70 []
nfs3_proc_getattr+0x57/0x89 []
__nfs_revalidate_inode+0xc7/0x308 [152]
nfs_lookup_revalidate+0x257/0x4ed [312]
do_lookup+0x43/0x76 []
link_path_walk+0x445/0x883 []
__vfs_follow_link+0x28/0x133 []
nfs_follow_link+0x28/0x47 []
link_path_walk+0x519/0x883 []
__vfs_follow_link+0x28/0x133 []
nfs_follow_link+0x28/0x47 []
link_path_walk+0x519/0x883 []
path_lookup+0x70/0x10a []
open_exec+0x22/0xc4 []
load_elf_binary+0xc4f/0xcc8 [268]
search_binary_handler+0x4b/0x196 []
load_script+0x1ea/0x220 [136]
search_binary_handler+0x4b/0x196 []
do_execve+0x153/0x1b9 [336]
sys_execve+0x2d/0x60 []
syscall_call+0x7/0xb []
Total: 1632

To save you filtering out functions with less than 100
bytes of stack:

udp_sendmsg+0x35e/0x61a [220]
sock_sendmsg+0x88/0xa3 [208]
__nfs_revalidate_inode+0xc7/0x308 [152]
nfs_lookup_revalidate+0x257/0x4ed [312]
load_elf_binary+0xc4f/0xcc8 [268]
load_script+0x1ea/0x220 [136]
do_execve+0x153/0x1b9 [336]
Total: 1632

I don't think it's new, 2.6.7-something did it too.
--
vda

