Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282628AbRKZXL0>; Mon, 26 Nov 2001 18:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282633AbRKZXLR>; Mon, 26 Nov 2001 18:11:17 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:11780 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S282628AbRKZXLJ>;
	Mon, 26 Nov 2001 18:11:09 -0500
Date: Tue, 27 Nov 2001 00:10:27 +0100
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200111262310.AAA02873@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.15 iptables/REDIRECT kernel oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a repost of a previous message, with some new info: the oops is related
to iptables/REDIRECT:

iptables -t nat -I PREROUTING -p tcp --dst 145.66.1.1 \
               --dport 1080 -j REDIRECT --to 80 > /dev/null 2>&1
iptables -t nat -I OUTPUT     -p tcp --dst 145.66.1.1 \
               --dport 1080 -j REDIRECT --to 80 > /dev/null 2>&1

This redirects connects to the machine itself (145.66.1.1) port 1080 to port
80, which is where apache listens. Connecting to http://145.66.1.1:1080/ seems
to result in the reported oops, as reported before. It's very reproducable
here, on several machines. So enjoy!

* Both with standard iptables and iptables-1.2.4 have this problem.
* Based on a previous response I upgraded ksymoops. Didn't change the output
* Using the PREROUTING chain results in the oops. The OUTPUT chain just freezes
  the system.
* It's reproducable here, so try for yourself.
* I think it's a bug

Rolf

[fokkensr@iasdev fokkensr]$ ksymoops -k ksyms-2.4.15-pre8 -o /lib/modules/2.4.15-pre8-fks/ -m /boot/System.map-2.4.15-pre8-fks oops-2.4.15-pre8.txt

ksymoops 0.7c on i686 2.4.8-clk.  Options used
     -V (default)
     -k ksyms-2.4.15-pre8 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre8-fks/ (specified)
     -m /boot/System.map-2.4.15-pre8-fks (specified)

Error (expand_objects): cannot stat(/lib/cpqarray.o) for cpqarray
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.15-pre8-fks/build/include/sound/isapnp.h: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_ksyms_lsmod): module e1000 is in lsmod but not in ksyms, probably no symbols exported
Error (compare_ksyms_lsmod): module nfsd is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module lockd is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module sunrpc is in ksyms but not in lsmod
Warning (map_ksym_to_module): cannot match loaded module cpqarray to a unique module object.  Trace may not be reliable.
Oops:   0000
CPU:    0
EIP:    0010:[<c02000c5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 000005dc ebx: edbea7e8 ecx: edca8800 edx: 00000000
esi: ee91c0ac edi: 00000000 ebp: ec6147a4 esp: f0d4bd84
ds: 0010 es: 0018 ss: 0018
Stack: 00000001 f0d4a000 00000003 00000000 edca8800 c01f043d edbea7e8 ec2468ac
       ed63c6d4 f77f0084 ee2468c0 f0d4bdc4 c034fed8 c01fef56 00000002 00000003
       edbea7e8 00000000 edca8800 c0200024 00000045 ec63c6d4 f77f0084 ee2468c0
Call Trace: <c01f043d> <c01fef56> <c0200024> <c01163cc> <c0215589>
            <c020f648> <c020fc02> <c0130521> <c02106df> <c0205a2b> <c0222edc>
            <c0222f16> <c01e056d> <c0222edc> <c01e078b> <c014329e> <c01076a3>
Code: 8a 87 4c 03 00 00 3c 02 74 0a 3c 01 75 0b f6 45 20 04 75 05

>>EIP; c02000c5 <ip_queue_xmit2+a1/22c>   <=====
Trace; c01f043d <nf_hook_slow+19d/21c>
Trace; c01fef56 <ip_queue_xmit+28e/300>
Trace; c0200024 <ip_queue_xmit2+0/22c>
Trace; c01163cc <schedule+500/8d0>
Trace; c0215589 <tcp_v4_send_check+6d/ac>
Trace; c020f648 <tcp_cwnd_restart+18/a4>
Trace; c020fc02 <tcp_transmit_skb+52e/5ec>
Trace; c0130521 <__lock_page+91/9c>
Trace; c02106df <tcp_write_xmit+18f/2dc>
Trace; c0205a2b <tcp_sendmsg+fd7/1370>
Trace; c0222edc <inet_sendmsg+0/40>
Trace; c0222f16 <inet_sendmsg+3a/40>
Trace; c01e056d <sock_sendmsg+81/a4>
Trace; c0222edc <inet_sendmsg+0/40>
Trace; c01e078b <sock_write+a3/ac>
Trace; c014329e <sys_write+8e/c4>
Trace; c01076a3 <system_call+2f/34>

Code;  c02000c5 <ip_queue_xmit2+a1/22c>
00000000 <_EIP>:
Code;  c02000c5 <ip_queue_xmit2+a1/22c>   <=====
   0:   8a 87 4c 03 00 00         mov    0x34c(%edi),%al   <=====
Code;  c02000cb <ip_queue_xmit2+a7/22c>
   6:   3c 02                     cmp    $0x2,%al
Code;  c02000cd <ip_queue_xmit2+a9/22c>
   8:   74 0a                     je     14 <_EIP+0x14> c02000d9 <ip_queue_xmit2+b5/22c>
Code;  c02000cf <ip_queue_xmit2+ab/22c>
   a:   3c 01                     cmp    $0x1,%al
Code;  c02000d1 <ip_queue_xmit2+ad/22c>
   c:   75 0b                     jne    19 <_EIP+0x19> c02000de <ip_queue_xmit2+ba/22c>
Code;  c02000d3 <ip_queue_xmit2+af/22c>
   e:   f6 45 20 04               testb  $0x4,0x20(%ebp)
Code;  c02000d7 <ip_queue_xmit2+b3/22c>
  12:   75 05                     jne    19 <_EIP+0x19> c02000de <ip_queue_xmit2+ba/22c>


2 warnings and 6 errors issued.  Results may not be reliable.

[fokkensr@iasdev fokkensr]$ rpm -q -i kernel-2.4.15-pre8-freeswan-1.91-1fks-7redhat
Name        : kernel-2.4.15-pre8-freeswan-1.91  Relocations: (not relocateable)
Version     : 1fks                              Vendor: (none)
Release     : 7redhat                       Build Date: Wed 21 Nov 2001 02:39:43 PM CET
Install date: Wed 21 Nov 2001 03:07:58 PM CET      Build Host: iasdev
Group       : System Environment/Kernel     Source RPM: kernel-2.4.15-pre8-freeswan-1.91-1fks-7redhat.src.rpm
Size        : 26095803                         License: GPL
URL         : http://www.kernel.org/
Summary     : A kernel with FreeS/WAN included
Description :
Linux kernel 2.4.15-pre8
* FreeS/WAN 1.91
* X.509 Certificate Support 0.8.5
* 3Dfx module
* Alsa 0.5.12
* QLogic Fibre Channel Driver for QLA2x00 4.25
* VLAN packet size support for 3c59x NICs
* HZ is 2048 instead of 100
* iptables 1.2.4
* lm_sensors 2.6.1
* Intel e1000 3.1.23
and more in the future.

