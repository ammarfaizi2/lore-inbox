Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269763AbUJVNu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269763AbUJVNu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUJVNu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:50:56 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:19140 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id S269770AbUJVNtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:49:39 -0400
Message-ID: <20041022134938.27174.qmail@thales.mathematik.uni-ulm.de>
Date: Fri, 22 Oct 2004 15:49:38 +0200
From: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Subject: [2.6.9] Ooops in fib_release_info (fib_semantics.c) with quagga
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Trying to run quagga/ospfd on kernel 2.6.9-rc3 (and 2.6.9-release)
causes an ooops when quagga is terminated. The full text of the ooops
is below but I already did some anlysis and the crash is in fib_release_info:

void fib_release_info(struct fib_info *fi)
{
        write_lock(&fib_info_lock); 
        if (fi && --fi->fib_treeref == 0) {
                hlist_del(&fi->fib_hash);
                if (fi->fib_prefsrc)
                        hlist_del(&fi->fib_lhash);
                change_nexthops(fi) {
                        hlist_del(&nh->nh_hash);    <===== CRASH
                } endfor_nexthops(fi)
                fi->fib_dead = 1;
                fib_info_put(fi);
        }
        write_unlock(&fib_info_lock);
}

At the time of the crash pprev in nh_hash is NULL. The following patch
seems to fix the crash on the affected machine:

Signed-off-by: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>

--- fib_semantics.c.orig	2004-10-22 14:20:33.504225840 +0200
+++ fib_semantics.c	2004-10-22 14:22:17.366436384 +0200
@@ -163,6 +163,8 @@
 		if (fi->fib_prefsrc)
 			hlist_del(&fi->fib_lhash);
 		change_nexthops(fi) {
+			if (!nh->nh_dev)
+				continue;
 			hlist_del(&nh->nh_hash);
 		} endfor_nexthops(fi)
 		fi->fib_dead = 1;

Full text of decoded ooops below.

      regards   Christian

ksymoops 2.4.9 on i686 2.6.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc3/ (specified)
     -m /boot/System.map-2.6.9-rc3 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0315010
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0315010>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9-rc3)
eax: 00000000   ebx: d3943c40   ecx: 00000000   edx: d3943be0
esi: d3943c44   edi: d6e17690   ebp: d7c46dd0   esp: c98cdc28
ds: 007b   es: 007b   ss: 0068
Stack: d7dbc188 00000000 d7dbc188 c03173c5 d3943be0 d7dbc180 d6e17690 00000010
       000000fe d7c46dc0 cdc040f8 00fa22c0 d7414760 00000010 d7dbc180 0000a8c0
       d7c46dd0 d7c46dc0 d7f94f20 d7c46dc0 c03147e6 d7d288a0 d7c46dd0 d7f94f20
Call Trace:
 [<c03173c5>] fn_hash_delete+0x1e5/0x2a0
 [<c03147e6>] inet_rtm_delroute+0x66/0x80
 [<c02d8fb1>] rtnetlink_rcv+0x2e1/0x3a0
 [<c02df46f>] netlink_data_ready+0x5f/0x70
 [<c02de9d2>] netlink_sendskb+0x32/0x60
 [<c02df0e6>] netlink_sendmsg+0x216/0x310
 [<c02c6daa>] sock_sendmsg+0xda/0x100
 [<c02c6daa>] sock_sendmsg+0xda/0x100
 [<c02f79dc>] tcp_rcv_synsent_state_process+0x37c/0x5c0
 [<c01e3a32>] copy_from_user+0x42/0x70
 [<c0116530>] autoremove_wake_function+0x0/0x60
 [<c02c894f>] sys_sendmsg+0x18f/0x1f0
 [<c01439d2>] handle_mm_fault+0x152/0x180
 [<c011387c>] do_page_fault+0x3ac/0x5bd
 [<c01e3a32>] copy_from_user+0x42/0x70
 [<c01e3a32>] copy_from_user+0x42/0x70
 [<c02c8df2>] sys_socketcall+0x242/0x260
 [<c010516b>] syscall_call+0x7/0xb
Code: 8d 5a 08 8b 4b 04 85 c0 89 01 74 03 89 48 04 c7 42 08 00 01 10 00 c7 43 04 00 02 20 00 8d 5a 60 8b 43 04 8d 72 64 8b 4e 04 85 c0 <89> 01 74 03 89 48 04 c7 43 04 00 01 10 00 c7 46 04 00 02 20 00


>>EIP; c0315010 <fib_release_info+80/f0>   <=====

>>ebx; d3943c40 <pg0+1348ac40/3fb45400>
>>edx; d3943be0 <pg0+1348abe0/3fb45400>
>>esi; d3943c44 <pg0+1348ac44/3fb45400>
>>edi; d6e17690 <pg0+1695e690/3fb45400>
>>ebp; d7c46dd0 <pg0+1778ddd0/3fb45400>
>>esp; c98cdc28 <pg0+9414c28/3fb45400>

Trace; c03173c5 <fn_hash_delete+1e5/2a0>
Trace; c03147e6 <inet_rtm_delroute+66/80>
Trace; c02d8fb1 <rtnetlink_rcv+2e1/3a0>
Trace; c02df46f <netlink_data_ready+5f/70>
Trace; c02de9d2 <netlink_sendskb+32/60>
Trace; c02df0e6 <netlink_sendmsg+216/310>
Trace; c02c6daa <sock_sendmsg+da/100>
Trace; c02c6daa <sock_sendmsg+da/100>
Trace; c02f79dc <tcp_rcv_synsent_state_process+37c/5c0>
Trace; c01e3a32 <copy_from_user+42/70>
Trace; c0116530 <autoremove_wake_function+0/60>
Trace; c02c894f <sys_sendmsg+18f/1f0>
Trace; c01439d2 <handle_mm_fault+152/180>
Trace; c011387c <do_page_fault+3ac/5bd>
Trace; c01e3a32 <copy_from_user+42/70>
Trace; c01e3a32 <copy_from_user+42/70>
Trace; c02c8df2 <sys_socketcall+242/260>
Trace; c010516b <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0314fe5 <fib_release_info+55/f0>
00000000 <_EIP>:
Code;  c0314fe5 <fib_release_info+55/f0>
   0:   8d 5a 08                  lea    0x8(%edx),%ebx
Code;  c0314fe8 <fib_release_info+58/f0>
   3:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  c0314feb <fib_release_info+5b/f0>
   6:   85 c0                     test   %eax,%eax
Code;  c0314fed <fib_release_info+5d/f0>
   8:   89 01                     mov    %eax,(%ecx)
Code;  c0314fef <fib_release_info+5f/f0>
   a:   74 03                     je     f <_EIP+0xf>
Code;  c0314ff1 <fib_release_info+61/f0>
   c:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0314ff4 <fib_release_info+64/f0>
   f:   c7 42 08 00 01 10 00      movl   $0x100100,0x8(%edx)
Code;  c0314ffb <fib_release_info+6b/f0>
  16:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c0315002 <fib_release_info+72/f0>
  1d:   8d 5a 60                  lea    0x60(%edx),%ebx
Code;  c0315005 <fib_release_info+75/f0>
  20:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0315008 <fib_release_info+78/f0>
  23:   8d 72 64                  lea    0x64(%edx),%esi
Code;  c031500b <fib_release_info+7b/f0>
  26:   8b 4e 04                  mov    0x4(%esi),%ecx
Code;  c031500e <fib_release_info+7e/f0>
  29:   85 c0                     test   %eax,%eax

This decode from eip onwards should be reliable

Code;  c0315010 <fib_release_info+80/f0>
00000000 <_EIP>:
Code;  c0315010 <fib_release_info+80/f0>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c0315012 <fib_release_info+82/f0>
   2:   74 03                     je     7 <_EIP+0x7>
Code;  c0315014 <fib_release_info+84/f0>
   4:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0315017 <fib_release_info+87/f0>
   7:   c7 43 04 00 01 10 00      movl   $0x100100,0x4(%ebx)
Code;  c031501e <fib_release_info+8e/f0>
   e:   c7 46 04 00 02 20 00      movl   $0x200200,0x4(%esi)

 [<c034ba0c>] schedule+0x4ec/0x500
 [<c0141e43>] unmap_page_range+0x53/0x80
 [<c0142026>] unmap_vmas+0x1b6/0x1d0
 [<c014661d>] exit_mmap+0x7d/0x160
 [<c0116815>] mmput+0x65/0xb0
 [<c011ac5a>] do_exit+0x14a/0x410
 [<c0105b7d>] die+0x18d/0x190
 [<c0118c37>] printk+0x17/0x20
 [<c01136fe>] do_page_fault+0x22e/0x5bd
 [<c02d0a0f>] process_backlog+0x7f/0x100
 [<c011d0bb>] __do_softirq+0x7b/0x90
 [<c02ded69>] netlink_broadcast+0x1d9/0x2a0
 [<c01134d0>] do_page_fault+0x0/0x5bd
 [<c0105315>] error_code+0x2d/0x38
 [<c0315010>] fib_release_info+0x80/0xf0
 [<c03173c5>] fn_hash_delete+0x1e5/0x2a0
 [<c03147e6>] inet_rtm_delroute+0x66/0x80
 [<c02d8fb1>] rtnetlink_rcv+0x2e1/0x3a0
 [<c02df46f>] netlink_data_ready+0x5f/0x70
 [<c02de9d2>] netlink_sendskb+0x32/0x60
 [<c02df0e6>] netlink_sendmsg+0x216/0x310
 [<c02c6daa>] sock_sendmsg+0xda/0x100
 [<c02c6daa>] sock_sendmsg+0xda/0x100
 [<c02f79dc>] tcp_rcv_synsent_state_process+0x37c/0x5c0
 [<c01e3a32>] copy_from_user+0x42/0x70
 [<c0116530>] autoremove_wake_function+0x0/0x60
 [<c02c894f>] sys_sendmsg+0x18f/0x1f0

1 error issued.  Results may not be reliable.

-- 
THAT'S ALL FOLKS!
