Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbULABSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbULABSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbULABSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:18:33 -0500
Received: from kotol.kotelna.sk ([212.89.232.170]:50191 "EHLO kotol.kotelna.sk")
	by vger.kernel.org with ESMTP id S261227AbULABQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:16:59 -0500
Date: Wed, 1 Dec 2004 02:16:12 +0100
From: Martin Lucina <mato@kotelna.sk>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: OOPS in Linux 2.6.9, fib_release_info
Message-ID: <20041201011612.GA3423@kotelna.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I have found a reproducible OOPS in fib_release_info, in the 2.6.9 kernel.
Tested on two different systems, one UP, one SMP, both i386, both w/
CONFIG_PREEMPT=y, both Debian sarge, both w/ iproute2 version 20010824-13.1
(Debian).

Steps to reproduce:

# ip route add unreachable 1.2.3.4/32
# ip route del 1.2.3.4/32
Memory fault
#

Sample OOPS:

ksymoops 2.4.9 on i686 2.6.9+t7220cte.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9+t7220cte/ (default)
     -m /boot/System.map-2.6.9+t7220cte (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c02bd6c0
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02bd6c0>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9+t7220cte) 
eax: 00000000   ebx: d1ddb280   ecx: 00000000   edx: d1ddb220
esi: d1ddb284   edi: d3a34380   ebp: d037dbf8   esp: d037dbec
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000001 d3a34388 d037dc40 c02bfb8c d1ddb220 d3a34380 d3277310 
       00000020 000000fe d3fa24e0 c13b3378 d3277310 00000fcc d06ea2c0 00000020 
       d3a34380 04030201 d3fa24f0 d3fa24e0 c12fc1a0 d037dc68 c02bce93 d3fa6d00 
Call Trace:
 [<c0104a6f>] show_stack+0x7f/0xa0
 [<c0104c16>] show_registers+0x156/0x1c0
 [<c0104e2a>] die+0xea/0x180
 [<c01120e6>] do_page_fault+0x256/0x609
 [<c0104645>] error_code+0x2d/0x38
 [<c02bfb8c>] fn_hash_delete+0x1dc/0x2a0
 [<c02bce93>] inet_rtm_delroute+0x63/0x80
 [<c027d2b0>] rtnetlink_rcv+0x2f0/0x3c0
 [<c028759e>] netlink_data_ready+0x5e/0x70
 [<c0286acc>] netlink_sendskb+0x9c/0xa0
 [<c0287219>] netlink_sendmsg+0x1f9/0x2f0
 [<c026a85b>] sock_sendmsg+0xbb/0xe0
 [<c026c362>] sys_sendmsg+0x1c2/0x240
 [<c026c808>] sys_socketcall+0x228/0x250
 [<c0104449>] sysenter_past_esp+0x52/0x71
Code: 8d 5a 08 8b 4b 04 85 c0 89 01 74 03 89 48 04 c7 42 08 00 01 10 00 c7 43 04 00 02 20 00 8d 5a 60 8b 43 04 8d 72 64 8b 4e 04 85 c0 <89> 01 74 03 89 48 04 c7 43 04 00 01 10 00 c7 46 04 00 02 20 00 


>>EIP; c02bd6c0 <fib_release_info+80/f0>   <=====

>>ebx; d1ddb280 <pg0+11a24280/3fc47400>
>>edx; d1ddb220 <pg0+11a24220/3fc47400>
>>esi; d1ddb284 <pg0+11a24284/3fc47400>
>>edi; d3a34380 <pg0+1367d380/3fc47400>
>>ebp; d037dbf8 <pg0+ffc6bf8/3fc47400>
>>esp; d037dbec <pg0+ffc6bec/3fc47400>

Trace; c0104a6f <show_stack+7f/a0>
Trace; c0104c16 <show_registers+156/1c0>
Trace; c0104e2a <die+ea/180>
Trace; c01120e6 <do_page_fault+256/609>
Trace; c0104645 <error_code+2d/38>
Trace; c02bfb8c <fn_hash_delete+1dc/2a0>
Trace; c02bce93 <inet_rtm_delroute+63/80>
Trace; c027d2b0 <rtnetlink_rcv+2f0/3c0>
Trace; c028759e <netlink_data_ready+5e/70>
Trace; c0286acc <netlink_sendskb+9c/a0>
Trace; c0287219 <netlink_sendmsg+1f9/2f0>
Trace; c026a85b <sock_sendmsg+bb/e0>
Trace; c026c362 <sys_sendmsg+1c2/240>
Trace; c026c808 <sys_socketcall+228/250>
Trace; c0104449 <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c02bd695 <fib_release_info+55/f0>
00000000 <_EIP>:
Code;  c02bd695 <fib_release_info+55/f0>
   0:   8d 5a 08                  lea    0x8(%edx),%ebx
Code;  c02bd698 <fib_release_info+58/f0>
   3:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  c02bd69b <fib_release_info+5b/f0>
   6:   85 c0                     test   %eax,%eax
Code;  c02bd69d <fib_release_info+5d/f0>
   8:   89 01                     mov    %eax,(%ecx)
Code;  c02bd69f <fib_release_info+5f/f0>
   a:   74 03                     je     f <_EIP+0xf>
Code;  c02bd6a1 <fib_release_info+61/f0>
   c:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c02bd6a4 <fib_release_info+64/f0>
   f:   c7 42 08 00 01 10 00      movl   $0x100100,0x8(%edx)
Code;  c02bd6ab <fib_release_info+6b/f0>
  16:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)
Code;  c02bd6b2 <fib_release_info+72/f0>
  1d:   8d 5a 60                  lea    0x60(%edx),%ebx
Code;  c02bd6b5 <fib_release_info+75/f0>
  20:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c02bd6b8 <fib_release_info+78/f0>
  23:   8d 72 64                  lea    0x64(%edx),%esi
Code;  c02bd6bb <fib_release_info+7b/f0>
  26:   8b 4e 04                  mov    0x4(%esi),%ecx
Code;  c02bd6be <fib_release_info+7e/f0>
  29:   85 c0                     test   %eax,%eax

This decode from eip onwards should be reliable

Code;  c02bd6c0 <fib_release_info+80/f0>
00000000 <_EIP>:
Code;  c02bd6c0 <fib_release_info+80/f0>   <=====
   0:   89 01                     mov    %eax,(%ecx)   <=====
Code;  c02bd6c2 <fib_release_info+82/f0>
   2:   74 03                     je     7 <_EIP+0x7>
Code;  c02bd6c4 <fib_release_info+84/f0>
   4:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c02bd6c7 <fib_release_info+87/f0>
   7:   c7 43 04 00 01 10 00      movl   $0x100100,0x4(%ebx)
Code;  c02bd6ce <fib_release_info+8e/f0>
   e:   c7 46 04 00 02 20 00      movl   $0x200200,0x4(%esi)

 [<c0104aae>] dump_stack+0x1e/0x30
 [<c02cd38c>] schedule+0x4ec/0x500
 [<c013f056>] unmap_vmas+0x1a6/0x1c0
 [<c014359d>] exit_mmap+0x7d/0x160
 [<c0115236>] mmput+0x66/0xb0
 [<c01197b8>] do_exit+0x148/0x420
 [<c0104ebd>] die+0x17d/0x180
 [<c01120e6>] do_page_fault+0x256/0x609
 [<c0104645>] error_code+0x2d/0x38
 [<c02bfb8c>] fn_hash_delete+0x1dc/0x2a0
 [<c02bce93>] inet_rtm_delroute+0x63/0x80
 [<c027d2b0>] rtnetlink_rcv+0x2f0/0x3c0
 [<c028759e>] netlink_data_ready+0x5e/0x70
 [<c0286acc>] netlink_sendskb+0x9c/0xa0
 [<c0287219>] netlink_sendmsg+0x1f9/0x2f0
 [<c026a85b>] sock_sendmsg+0xbb/0xe0
 [<c026c362>] sys_sendmsg+0x1c2/0x240
 [<c026c808>] sys_socketcall+0x228/0x250
 [<c0104449>] sysenter_past_esp+0x52/0x71

Will send other relevant information on request.

-mato
