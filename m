Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRK0Lpt>; Tue, 27 Nov 2001 06:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRK0LoT>; Tue, 27 Nov 2001 06:44:19 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:15629 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S277152AbRK0LoO>;
	Tue, 27 Nov 2001 06:44:14 -0500
Date: Tue, 27 Nov 2001 12:43:09 +0100
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200111271143.MAA11403@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] vanilla 2.4.15 iptables/REDIRECT kernel oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got another kernel oops related to iptables/REDIRECT, this time it's a plain vanilla kernel 2.4.15

iptables -t nat -I PREROUTING -p tcp --dst 145.66.1.1 \
               --dport 1080 -j REDIRECT --to 80 > /dev/null 2>&1
iptables -t nat -I OUTPUT     -p tcp --dst 145.66.1.1 \
               --dport 1080 -j REDIRECT --to 80 > /dev/null 2>&1

This redirects connects to the machine itself (145.66.1.1) port 1080 to port
80, which is where apache listens. Connecting to http://145.66.1.1:1080/ seems
to result in the reported oops, as reported before. It's very reproducable
here, on several machines. So enjoy!

Rolf

[fokkensr@iasdev fokkensr]$ ksymoops -k ksyms-2.4.15 -i -m /boot/System.map-2.4.15 -o /lib/modules/2.4.15/ < oops-2.4.15.txt

ksymoops 2.4.3 on i686 2.4.8-clk.  Options used
     -V (default)
     -k ksyms-2.4.15 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15/ (specified)
     -m /boot/System.map-2.4.15 (specified)
     -i

Unable to handle kernel NULL pointer dereference at virtual address 0000034e
c0200cb5
*pde = 00000000
Oops:   0000
CPU:    0
EIP:    0010:[<c0200cb5>] not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 000005dc ebx: f76b0ea0 ecx: f76be800 edx: 00000000
esi: f76b30ac edi: 00000000 ebp: f72ab224 esp: f7193d98
ds: 0010 es: 0018 ss: 0018
Stack: 00000001 f7192000 00000003 00000000 f76be800 c01f102d f76b0ea0 f76bc0ac
       f72fa6d4 f76b0130 f76bc0c0 f7193dd8 c034bed8 c01ffb46 00000002 00000003
       f76b0ea0 00000000 f76be800 c0200c14 0000003c f72fa6d4 f76b0130 f76bc0c0
Call Trace: <c01f102d> <c01ffb46> <c0200c14> <c0198c23> <c0216179>
            <c0210238> <c02107f2> <c0210b23> <c020617f> <c0223acc> <c0223b06>
            <c01e115d> <c0223acc> <c01e137b> <c01437ec> <c01076a3>
Code: 8a 87 4c 03 00 00 3c 02 74 0a 3c 01 75 0b f6 45 20 04 75 05

>>EIP; c0200cb4 <ip_queue_xmit2+a0/22c>   <=====
Trace; c01f102c <nf_hook_slow+19c/21c>
Trace; c01ffb46 <ip_queue_xmit+28e/300>
Trace; c0200c14 <ip_queue_xmit2+0/22c>
Trace; c0198c22 <generic_unplug_device+62/b0>
Trace; c0216178 <tcp_v4_send_check+6c/ac>
Trace; c0210238 <tcp_cwnd_restart+18/a4>
Trace; c02107f2 <tcp_transmit_skb+52e/5ec>
Trace; c0210b22 <tcp_push_one+8a/114>
Trace; c020617e <tcp_sendmsg+b3a/1370>
Trace; c0223acc <inet_sendmsg+0/40>
Trace; c0223b06 <inet_sendmsg+3a/40>
Trace; c01e115c <sock_sendmsg+80/a4>
Trace; c0223acc <inet_sendmsg+0/40>
Trace; c01e137a <sock_write+a2/ac>
Trace; c01437ec <sys_write+8c/c4>
Trace; c01076a2 <system_call+2e/34>
Code;  c0200cb4 <ip_queue_xmit2+a0/22c>
00000000 <_EIP>:
Code;  c0200cb4 <ip_queue_xmit2+a0/22c>   <=====
   0:   8a 87 4c 03 00 00         mov    0x34c(%edi),%al   <=====
Code;  c0200cba <ip_queue_xmit2+a6/22c>
   6:   3c 02                     cmp    $0x2,%al
Code;  c0200cbc <ip_queue_xmit2+a8/22c>
   8:   74 0a                     je     14 <_EIP+0x14> c0200cc8 <ip_queue_xmit2+b4/22c>
Code;  c0200cbe <ip_queue_xmit2+aa/22c>
   a:   3c 01                     cmp    $0x1,%al
Code;  c0200cc0 <ip_queue_xmit2+ac/22c>
   c:   75 0b                     jne    19 <_EIP+0x19> c0200ccc <ip_queue_xmit2+b8/22c>
Code;  c0200cc2 <ip_queue_xmit2+ae/22c>
   e:   f6 45 20 04               testb  $0x4,0x20(%ebp)
Code;  c0200cc6 <ip_queue_xmit2+b2/22c>
  12:   75 05                     jne    19 <_EIP+0x19> c0200ccc <ip_queue_xmit2+b8/22c>
