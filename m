Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTIQMb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTIQMb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:31:27 -0400
Received: from smtp0.telegraaf.net ([217.196.45.130]:20420 "EHLO
	smtp0.telegraaf.net") by vger.kernel.org with ESMTP id S262736AbTIQMbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:31:23 -0400
Date: Wed, 17 Sep 2003 14:31:20 +0200
From: Brendan Keessen <brendan@telegraafnet.nl>
To: linux-kernel@vger.kernel.org
Subject: kernel panic 2.4.22
Message-ID: <20030917123120.GB29164@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We had a problem on our GigE Linux router/firewall which was caused by
the fallback to ksoftirqd when the router/firewall was under a high
load (70 Mbits/sec). Alan Cox emailed the following advise:

| From: Alan Cox <alan@lxorguk.ukuu.org.uk>
| To: Brendan Keessen <brendan@telegraafnet.nl>
| Date: Tue, 09 Sep 2003 15:34:17 +0100
| Subject: Re: ksoftirqd causing severe network performance problems
| 
| Under high load ksoftirqd is used so that user apps also get to take CPU
| time, thats often the wrong choice for a GigE router especially an SMP
| one. What you can do is simply disable the ksoftirqd fallback. Under
| ultra high load user space will basically grind to a halt but packet
| performance should stay good

We made the following little patch to disable the ksoftirqd fallback
mechanism. We tested it and it seemed to work correctly:

--- linux-2.4.22.vanilla/kernel/softirq.c       2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.22/kernel/softirq.c       2003-09-17 14:03:28.000000000 +0200
@@ -101,8 +101,6 @@
                }
                __local_bh_enable();
 
-               if (pending)
-                       wakeup_softirqd(cpu);
        }
 
        local_irq_restore(flags);

After running with this kernel for a couple of days. An hour ago we had
a little bit more traffic and we got 2 kernel panics on a 2.4.22 kernel
with the above patch and with the following kernel modules loaded: 

Module                  Size  Used by    Not tainted
ipt_mark                 504   2  (autoclean)
ipt_multiport            696   3  (autoclean)
ipt_MARK                 760   2  (autoclean)
ipt_state                568   2  (autoclean)
iptable_nat            18616   1  (autoclean)
iptable_mangle          2168   1  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_tables              13600   9  [ipt_mark ipt_multiport ipt_MARK ipt_state iptable_nat iptable_mangle iptable_filter]
8021q                  15144   5  (autoclean)
bcm5700                97160   2 
ip_conntrack           21896   2  [ipt_state iptable_nat]

This is the first one:

Unable to handle kernel paging request at virtual address fffffffc
c0158363
*pde = 00004063
Oops: 0000
CPU:    1
EIP:    0010:[<c0158363>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: eb3edf48   ebx: ffffffe8   ecx: 00000000   edx: 00000000
esi: e8dd1008   edi: e8dd1000   ebp: 00000001   esp: eb3edf18
ds: 0018   es: 0018   ss: 0018
Process mgetty (pid: 22745, stackpage=eb3ed000)
Stack: 00000000 00000000 00000001 c0158693 eb3edf48 00000000 eb3ec000 00000104
       eb3ec000 00000000 00000000 00000000 00000000 e8dd1000 00000000 00000080
       e8dfff00 bffff500 c0158b0e 00000001 eb3edf90 eb3edf8c 0000041f 00000020
Call Trace:    [<c0158693>] [<c0158b0e>] [<c01093ef>]
Code: 8b 43 14 8d 53 04 e8 22 64 fc ff 8b 03 e8 cb f4 fe ff 39 f3


>>EIP; c0158363 <poll_freewait+23/50>   <=====

>>eax; eb3edf48 <_end+2af8f8c4/384d79dc>
>>esi; e8dd1008 <_end+28972984/384d79dc>
>>edi; e8dd1000 <_end+2897297c/384d79dc>
>>esp; eb3edf18 <_end+2af8f894/384d79dc>

Trace; c0158693 <do_select+153/250>
Trace; c0158b0e <sys_select+34e/4e0>
Trace; c01093ef <system_call+33/38>

Code;  c0158363 <poll_freewait+23/50>
00000000 <_EIP>:
Code;  c0158363 <poll_freewait+23/50>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c0158366 <poll_freewait+26/50>
   3:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c0158369 <poll_freewait+29/50>
   6:   e8 22 64 fc ff            call   fffc642d <_EIP+0xfffc642d>
Code;  c015836e <poll_freewait+2e/50>
   b:   8b 03                     mov    (%ebx),%eax
Code;  c0158370 <poll_freewait+30/50>
   d:   e8 cb f4 fe ff            call   fffef4dd <_EIP+0xfffef4dd>
Code;  c0158375 <poll_freewait+35/50>
  12:   39 f3                     cmp    %esi,%ebx

This is the second one:

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000001
c011d1ea
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011d1ea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000038   ebx: e8dd102c   ecx: c283d140   edx: 00000001
esi: f55d3978   edi: f55d3974   ebp: eb3edd9c   esp: eb3edd7c
ds: 0018   es: 0018   ss: 0018
Process mgetty (pid: 22875, stackpage=eb3ed000)
Stack: eb3ec000 00000000 00000001 00000286 00000001 eb3edda8 eb3edda8 00000000
       00000000 c012612a f7b9aa80 f7b9aafc f7b9aafc 00000001 00000000 c021936d
       c037e36c c0126044 c041b8bc c0125ee7 00000003 00000007 c03efa00 fffffff8
Call Trace:    [<c012612a>] [<c021936d>] [<c0126044>] [<c0125ee7>] [<c0125cac>]
  [<c010b039>] [<c010db98>] [<c02189ee>] [<c021aa38>] [<c0208920>] [<c02ac469>]
  [<c0209fb7>] [<c02082ed>] [<c020573e>] [<c0209e20>] [<c01467b3>] [<c01093ef>]
Code: 8b 02 89 d3 89 c2 0f 18 00 39 f3 75 e9 c6 07 01 ff 75 ec 9d


>>EIP; c011d1ea <__wake_up+4a/90>   <=====

>>ebx; e8dd102c <_end+289729a8/384d79dc>
>>ecx; c283d140 <_end+23deabc/384d79dc>
>>esi; f55d3978 <_end+351752f4/384d79dc>
>>edi; f55d3974 <_end+351752f0/384d79dc>
>>ebp; eb3edd9c <_end+2af8f718/384d79dc>
>>esp; eb3edd7c <_end+2af8f6f8/384d79dc>

Trace; c012612a <__run_task_queue+6a/80>
Trace; c021936d <do_serial_bh+1d/20>
Trace; c0126044 <bh_action+54/80>
Trace; c0125ee7 <tasklet_hi_action+67/a0>
Trace; c0125cac <do_softirq+bc/c0>
Trace; c010b039 <do_IRQ+f9/120>
Trace; c010db98 <call_do_IRQ+5/d>
Trace; c02189ee <serial_out+1e/40>
Trace; c021aa38 <rs_write+188/210>
Trace; c0208920 <opost_block+e0/180>
Trace; c02ac469 <net_rx_action+99/140>
Trace; c0209fb7 <write_chan+197/220>
Trace; c02082ed <do_tty_write+14d/1d7>
Trace; c020573e <tty_write+14e/190>
Trace; c0209e20 <write_chan+0/220>
Trace; c01467b3 <sys_write+a3/160>
Trace; c01093ef <system_call+33/38>

Code;  c011d1ea <__wake_up+4a/90>
00000000 <_EIP>:
Code;  c011d1ea <__wake_up+4a/90>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c011d1ec <__wake_up+4c/90>
   2:   89 d3                     mov    %edx,%ebx
Code;  c011d1ee <__wake_up+4e/90>
   4:   89 c2                     mov    %eax,%edx
Code;  c011d1f0 <__wake_up+50/90>
   6:   0f 18 00                  prefetchnta (%eax)
Code;  c011d1f3 <__wake_up+53/90>
   9:   39 f3                     cmp    %esi,%ebx
Code;  c011d1f5 <__wake_up+55/90>
   b:   75 e9                     jne    fffffff6 <_EIP+0xfffffff6>
Code;  c011d1f7 <__wake_up+57/90>
   d:   c6 07 01                  movb   $0x1,(%edi)
Code;  c011d1fa <__wake_up+5a/90>
  10:   ff 75 ec                  pushl  0xffffffec(%ebp)
Code;  c011d1fd <__wake_up+5d/90>
  13:   9d                        popf   

Anyone an idea what causes these kernel oopses. Did I maybe disable the
fallback to ksoftirqd incorrectly?

Thanks,
Brendan 
