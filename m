Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263325AbTDCJFr>; Thu, 3 Apr 2003 04:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbTDCJFr>; Thu, 3 Apr 2003 04:05:47 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:32252
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263325AbTDCJFp>; Thu, 3 Apr 2003 04:05:45 -0500
Date: Thu, 3 Apr 2003 04:12:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops on netdevice down w/ 2.5.66
Message-ID: <Pine.LNX.4.50.0304030408540.30262-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting this in case someone would like to have a look, please ask if 
you need more debug info, this one seems to happen on device shutdown. The 
backtrace looks pretty revealing too but i won't have time to look at 
this until later tommorrow. The system was 8 way PIII 700

Shutting down loopback interface:  Unable to handle kernel paging request 
at vir
tual address 631cc03a
 printing eip:
c0129935
*pde = 6b6b6b6b
Oops: 0000 [#1]
CPU:    4
EIP:    0060:[<c0129935>]    Not tainted
EFLAGS: 00010286
EIP is at unregister_sysctl_table+0x5/0x30
eax: 631cc032   ebx: 631cc032   ecx: 00000000   edx: e268e000
esi: f7d662d4   edi: f7d662d4   ebp: f6a224e0   esp: e268fbd4
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 12678, threadinfo=e268e000 task=e2590660)
Stack: f7c8180a c02c207b 631cc032 00000000 c02c0137 f7d662f8 e268e000 00000001 
       0100007f e268e000 00000000 f6a224e0 00000001 c02c054f f7d662d4 f6a224e0 
       00000001 00000000 00000296 00000296 f7d662d4 000000ff 0100007f f1191c88 
Call Trace:
 [<c02c207b>] devinet_sysctl_unregister+0x1b/0x28
 [<c02c0137>] inetdev_destroy+0x97/0x180
 [<c02c054f>] inet_del_ifa+0x26f/0x280
 [<c02c0a84>] inet_rtm_deladdr+0x114/0x150
 [<c0286bc8>] rtnetlink_rcv+0x358/0x540
 [<c028f11c>] netlink_destroy_callback+0x2c/0x40
 [<c011f5d6>] __wake_up+0x66/0xb0
 [<c028f01a>] netlink_data_ready+0x1a/0x60
 [<c028e775>] netlink_unicast+0x385/0x3d0
 [<c011f4f0>] default_wake_function+0x0/0x20
 [<c011f4f0>] default_wake_function+0x0/0x20
 [<c027a823>] alloc_skb+0xe3/0x270
 [<c028ee1c>] netlink_sendmsg+0x29c/0x2b0
 [<c0276cdf>] sock_sendmsg+0x7f/0xa0
 [<c027687b>] move_addr_to_user+0x5b/0x80
 [<c027870c>] sys_recvmsg+0x1dc/0x1f0
 [<c02767ff>] move_addr_to_kernel+0x4f/0x70
 [<c0276b01>] sockfd_lookup+0x11/0x70
 [<c0278080>] sys_sendto+0xd0/0xf0
 [<c027887b>] sys_socketcall+0x15b/0x220
 [<c010aecf>] syscall_call+0x7/0xb

Code: 8b 53 08 8b 43 04 89 50 04 89 02 8b 0d b8 59 40 c0 51 8b 13 

(gdb) list *unregister_sysctl_table+0x4
0xc0129934 is in unregister_sysctl_table (kernel/sysctl.c:629).
624      *
625      * Unregisters the sysctl table and all children. proc entries may 
not
626      * actually be removed until they are no longer used by anyone.
627      */
628     void unregister_sysctl_table(struct ctl_table_header * header)
629     {
630             list_del(&header->ctl_entry);
631     #ifdef CONFIG_PROC_FS
632             unregister_proc_table(header->ctl_table, proc_sys_root);
633     #endif

(gdb) disassemble unregister_sysctl_table
Dump of assembler code for function unregister_sysctl_table:
0xc0129930 <unregister_sysctl_table>:   push   %ebx
0xc0129931 <unregister_sysctl_table+1>: mov    0x8(%esp,1),%ebx
0xc0129935 <unregister_sysctl_table+5>: mov    0x8(%ebx),%edx
0xc0129938 <unregister_sysctl_table+8>: mov    0x4(%ebx),%eax
0xc012993b <unregister_sysctl_table+11>:        mov    %edx,0x4(%eax)
0xc012993e <unregister_sysctl_table+14>:        mov    %eax,(%edx)
0xc0129940 <unregister_sysctl_table+16>:        mov    0xc04059b8,%ecx
0xc0129946 <unregister_sysctl_table+22>:        push   %ecx
0xc0129947 <unregister_sysctl_table+23>:        mov    (%ebx),%edx
0xc0129949 <unregister_sysctl_table+25>:        push   %edx

