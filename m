Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTD1Ui0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTD1UiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 16:38:25 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:3722 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S261270AbTD1UiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 16:38:23 -0400
Date: Mon, 28 Apr 2003 22:50:42 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: vl@kki.org, vandrove@vc.cvut.cz, ollie@sis.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: OOPS, 2.4.20, preemption, ptrace, ext3 patches; (sis900?/ncpfs?)
Message-ID: <20030428205042.GA11571@finwe.eu.org>
Mail-Followup-To: vl@kki.org, vandrove@vc.cvut.cz, ollie@sis.com.tw,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got something like this today (more details below):

<OOPS>
ksymoops 2.4.8 on i686 2.4.20-i.  Options used
     -V (default)
     -k ./ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-i/ (default)
     -m ./System.map-2.4.20-i (specified)

OOPS: 0000
CPU: 0  
EIP: 0010: [<c0114f10>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: c2034000 ebx: 00000000 ecx: 00000001 edx: 00000001
esi: c21234ec edi: 00000001 ebp: c2035f54 esp: c2035f40
ds: 0018 es: 0018 ss: 0018
Process nwsfind (pid: 764, stackpage=c2035000)
Stack: 00000001 00000282 c2aad3e0 c3e9e9e0 fffffffd 00000046 c01c7d4f c2aad3e0
       c01c71f7 c2aad3e0 c3e9e9e0 c01c846a c3e9e9e0 00000000 c01cc9b4 c3e9e9e0
       00000001 c028db68 fffffffd 00000046 c011cfd4 c028db68 c2034000 00000002
Call Trace: [<c01c7d4f>] [<c01c71f7>] [<c01c846a>] [<c01cc9b4>] [<c011cfd4>] [<c0108706>] [[<c010adf3>] 
Code: 8b 53 fc 8b 02 85 c7 75 2f 8b 1b 39 f3 75 f1 b8 00 e0 ff ff


>>EIP; c0114f10 <__wake_up+30/90>   <=====

>>eax; c2034000 <_end+1d7e9c8/455ca28>
>>esi; c21234ec <_end+1e6deb4/455ca28>
>>ebp; c2035f54 <_end+1d8091c/455ca28>
>>esp; c2035f40 <_end+1d80908/455ca28>

Trace; c01c7d4f <sock_def_write_space+8f/a0>
Trace; c01c71f7 <sock_wfree+37/40>
Trace; c01c846a <__kfree_skb+4a/150>
Trace; c01cc9b4 <net_tx_action+34/c0>
Trace; c011cfd4 <do_softirq+d4/e0>
Trace; c0108706 <do_IRQ+f6/130>
Trace; c010adf3 <call_do_IRQ+5/12>

Code;  c0114f10 <__wake_up+30/90>
00000000 <_EIP>:
Code;  c0114f10 <__wake_up+30/90>   <=====
   0:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx   <=====
Code;  c0114f13 <__wake_up+33/90>
   3:   8b 02                     mov    (%edx),%eax
Code;  c0114f15 <__wake_up+35/90>
   5:   85 c7                     test   %eax,%edi
Code;  c0114f17 <__wake_up+37/90>
   7:   75 2f                     jne    38 <_EIP+0x38>
Code;  c0114f19 <__wake_up+39/90>
   9:   8b 1b                     mov    (%ebx),%ebx
Code;  c0114f1b <__wake_up+3b/90>
   b:   39 f3                     cmp    %esi,%ebx
Code;  c0114f1d <__wake_up+3d/90>
   d:   75 f1                     jne    0 <_EIP>
Code;  c0114f1f <__wake_up+3f/90>
   f:   b8 00 e0 ff ff            mov    $0xffffe000,%eax

Aiee, killing interrupt handler. In interrupt handler: not syncing.

</OOPS>

This station has to have access to ncpfs volumes and for last few days
has also been print server. Everything worked fine until motherboard upgrade
(new CPU, network card is now onboard,...). Now kernel oopses every time I reboot,
after umounting local filesystems. 

I believe it may be ncp or sis900 (or both) related (please forgive me if 
I misunderstood this oops :)

I didn't test neither 2.4.21-rc1, nor 2.4.20 without preemption enabled, nor
other NIC, but I will try to do it as soon as possible. 


Linux:
-----
Linux indis 2.4.20-i #1 pon mar 17 21:32:14 CET 2003 i686 unknown unknown GNU/Linux
 (with ptrace, preempt-2.4.20-1, all 2.4.20 ext3 patches)

Utils:
-----
modutils: 2.4.21
gcc: version 3.2.3 20030309 (Debian prerelease
ncpfs: 2.2.3 (without NDS), as in Debian SID
mount: mount-2.11z
binutils: 2.13.90.0.18

NIC:
---
Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 82)

- More -
--------

Config:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/config-2.4.20-i

Dmesg:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/dmesg

cpuinfo:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/cpuinfo.txt

lspci:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/lspci.txt
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/lspci_-v.txt
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/lspci_-v_-v.txt

modules (before reboot):
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/modules.txt

oops (one more time)
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.4.20-i/oops1/oops_decoded.txt


JK

-- 
Jacek Kawa, jfk[at]zeus.polsl.gliwice.pl
