Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTKYUxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKYUxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:53:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:20664 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263064AbTKYUxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:53:15 -0500
Date: Tue, 25 Nov 2003 13:17:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: francois+kernel@nikita.cx
Subject: [Bugme-new] [Bug 1595] New: Oops in tcp_v4_get_port (fwd)
Message-ID: <60420000.1069795076@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1595

           Summary: Oops in tcp_v4_get_port
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: francois+kernel@nikita.cx


Distribution:

Redhat Linux 7.3

Hardware Environment:

Intel Xeon P4, SMP HyperThreading activated

Software Environment:

# lsmod
Module                  Size  Used by
netconsole              3968  0 
softdog                 5188  0 
ipv6                  259936  16 
autofs                 18432  0 
tg3                    64640  0 
e100                   60804  0 
ipt_REJECT              7360  1 
iptable_filter          3616  1 
ip_tables              18896  2 ipt_REJECT,iptable_filter

Problem Description:

Unable to handle kernel NULL pointer dereference at virtual address 00000049
 printing eip:
802771a7
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<802771a7>]    Not tainted
EFLAGS: 00010246
EIP is at tcp_v4_get_port+0x1b7/0x300
eax: 00000000   ebx: f43f5c90   ecx: 00000001   edx: f43f5c80
esi: f56c1510   edi: f4330b10   ebp: 84837326   esp: f4e11e88
ds: 007b   es: 007b   ss: 0068
Process thttpd (pid: 5659, threadinfo=f4e10000 task=f5a68080)
Stack: 00000001 00000000 00000000 00000001 f7880280 00000050 bffa6d48 bffa6c00
       ffffffea 00000002 80287fd8 bffa6c00 00000050 00000050 f50af380 f4e11ee4
       00000010 00000000 80241736 f50af380 f4e11ee4 00000010 00000000 50000002
Call Trace:
 [<80287fd8>] inet_bind+0x158/0x260
 [<80241736>] sys_bind+0x56/0x80
 [<802406be>] sock_map_fd+0xbe/0x120
 [<8024070d>] sock_map_fd+0x10d/0x120
 [<80287985>] inet_setsockopt+0x25/0x30
 [<80241cec>] sys_setsockopt+0x4c/0x80
 [<80241d0e>] sys_setsockopt+0x6e/0x80
 [<802422e3>] sys_socketcall+0xc3/0x250
 [<80165529>] sys_fcntl64+0x69/0x70
 [<8010aa73>] syscall_call+0x7/0xb

Code: f6 40 49 20 75 52 8d 76 00 8b 44 24 2c 8b 48 04 85 c9 74 0b
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 <0>Rebooting in 15 seconds..

(gdb) list *(tcp_v4_get_port+0x1b7)
0x802771a7 is in tcp_v4_get_port (tcp_ipv4.c:195).
190             struct sock *sk2;
191             struct hlist_node *node;
192             int reuse = sk->sk_reuse;
193
194             sk_for_each_bound(sk2, node, &tb->owners) {
195                     if (sk != sk2 &&
196                         !ipv6_only_sock(sk2) &&
197                         (!sk->sk_bound_dev_if ||
198                          !sk2->sk_bound_dev_if ||
199                          sk->sk_bound_dev_if == sk2->sk_bound_dev_if)) {

Steps to reproduce:

eth0 is 10.0.0.1
eth0:0 is 10.0.0.2

thttpd listening on 10.0.0.1:80 and serving lots of clients
modify configuration so thttpd listen on 10.0.0.2:80
kill thttpd ; restart thttpd
kernel oops

