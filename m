Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUAPMas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265427AbUAPMas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:30:48 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:56715 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265415AbUAPMak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:30:40 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Pavel Machek <pavel@suse.cz>, Matt Mackall <mpm@selenic.com>
Subject: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Fri, 16 Jan 2004 17:59:59 +0530
User-Agent: KMail/1.5
Cc: discuss@x86-64.org, George Anzinger <george@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401161759.59098.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

KGDB 2.0.3 is available at 
http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2

Ethernet interface still doesn't work. It responds to gdb for a couple of 
packets and then panics. gdb log for ethernet interface is pasted below.

It panics and enter kgdb_handle_exception recursively and silently. To see the 
panic on screen make kgdb_handle_exception return immediately if 
kgdb_connected is non-zero. 

Panic trace is pasted below. It panics in skb_release_data. Looks like skb 
handling will have to changed to be have kgdb specific buffers.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)


(gdb) set debug remote 1
(gdb) tar re udp:192.168.1.4:5001
warning: The remote protocol may be unreliable over UDP.
warning: Some events may be lost, rendering further debugging impossible.
Remote debugging using udp:192.168.1.4:5001
Sending packet: $Hc-1#09...Ack
Packet received: OK
Sending packet: $qC#b4...Ack
Timed out.
Timed out.



Jan 16 17:17:10 pc1 kernel: Unable to handle kernel paging request at virtual 
a
dress 39233134
Starting xinetd: Jan 16 17:17:10 pc1 kernel:  printing eip:
Jan 16 17:17:10 pc1 kernel: c0239074
Jan 16 17:17:10 pc1 kernel: *pde = 00000000
Jan 16 17:17:10 pc1 kernel: Oops: 0000 [#1]
Jan 16 17:17:11 pc1 kernel: CPU:    0
Jan 16 17:17:11 pc1 kernel: EIP:    0060:[<c0239074>]    Not tainted
Jan 16 17:17:11 pc1 kernel: EFLAGS: 00010283
Jan 16 17:17:11 pc1 kernel: EIP is at skb_release_data+0x44/0xb0               
:
Jan 16 17:17:11 pc1 kernel: eax: c7deb220   ebx: c7708c00   ecx: c7deb220   
edx
 39233134                                                                      
:
Jan 16 17:17:11 pc1 kernel: esi: 00000000   edi: c7deb1fb   ebp: c7707e24   
esp
 c7707e18
Jan 16 17:17:11 pc1 kernel: ds: 007b   es: 007b   ss: 0068                     
=
Jan 16 17:17:11 pc1 kernel: Process kgdbeth (pid: 833, threadinfo=c7706000 
task
c12946d0)
Jan 16 17:17:11 pc1 kernel: Stack: ffffffff c7708c00 c7708c00 c7707e38 
c02390f4
c7708c00 00000292 00000000
Jan 16 17:17:12 pc1 kernel:        c7707e50 c02391aa c7708c00 c7e8a600 
c7708c00
c7e8a600 c7707e78 c01f630e
Jan 16 17:17:12 pc1 kernel:        c7708c00 c72c2000 00000000 00000040 
c880d000
c7708c00 c031fbf2 c7deb1fb
Jan 16 17:17:12 pc1 kernel: Call Trace:
Jan 16 17:17:12 pc1 kernel:  [<c02390f4>] kfree_skbmem+0x14/0x30
Jan 16 17:17:12 pc1 kernel:  [<c02391aa>] __kfree_skb+0x9a/0x130
Jan 16 17:17:12 pc1 kernel:  [<c01f630e>] rtl8139_start_xmit+0x7e/0x110
Jan 16 17:17:12 pc1 kernel:  [<c01f3356>] write_buffer+0x256/0x2e0
Jan 16 17:17:12 pc1 kernel:  [<c01f3403>] kgdbeth_flush+0x23/0x30
Jan 16 17:17:12 pc1 kernel:  [<c0133fdd>] putpacket+0x14d/0x170
Jan 16 17:17:12 pc1 kernel:  [<c0133e26>] getpacket+0xd6/0x140
Jan 16 17:17:12 pc1 kernel:  [<c0134875>] kgdb_handle_exception+0x215/0xae0
Jan 16 17:17:12 pc1 kernel:  [<c011d660>] __call_console_drivers+0x60/0x70
Jan 16 17:17:12 pc1 kernel:  [<c010b910>] do_int3+0x0/0x100
Jan 16 17:17:12 pc1 kernel:  [<c010ba07>] do_int3+0xf7/0x100
Jan 16 17:17:12 pc1 kernel:  [<c010b129>] error_code+0x2d/0x38
Jan 16 17:17:12 pc1 kernel:  [<c01351f7>] breakpoint+0x17/0x20
Jan 16 17:17:12 pc1 kernel:  [<c01352b0>] kgdb_entry+0xa0/0xb0
Jan 16 17:17:12 pc1 kernel:  [<c01f3bed>] kgdbeth_thread+0x3d/0x70
Jan 16 17:17:12 pc1 kernel:  [<c01f3bb0>] kgdbeth_thread+0x0/0x70
Jan 16 17:17:12 pc1 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Jan 16 17:17:12 pc1 kernel:                                                    
4
Jan 16 17:17:12 pc1 kernel: Code: 8b 02 a9 00 08 00 00 75 17 8b 42 04 85 c0 74
5 ff 4a 04 0f

