Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272011AbTHHTRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTHHTRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:17:23 -0400
Received: from maja.beep.pl ([195.245.198.10]:19214 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S272011AbTHHTRH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:17:07 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: watchdog daemon causes kernel oops (2.4.18, 2.4.20, 2.4.21)
Date: Fri, 8 Aug 2003 16:30:31 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308081630.31947.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using watchdog daemon 
(ftp://ftp.debian.org/debian/pool/main/w/watchdog/watchdog_5.2.4.orig.tar.gz).

The problem is that kernels oops if watchdog is started and it uses softdog 
driver and then some networking operation like loading driver for network 
card and setting it up or doing something with nfs occurrs.

If network driver is loaded before starting watchdog then everything is fine
until for example rmmod network module and load it again+try to setup some ip.
I've checked it on 2.4.18, 2.4.20, 2.4.21 - everywhere oops.

I've also asked two other person to check this - for them it also oopses.

Oppses from 2.4.21:

Oops: 0002
CPU:    0
EIP:    0010:[<c0196687>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d08f33a0   ebx: d08ea000   ecx: 00007123   edx: d0864020
esi: d08f02a0   edi: d08ea000   ebp: bffffe7e   esp: cb77df80
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 21701, stackpage=cb77d000)
Stack: d08ea000 00000000 d08ede27 d08f02a0 c011a2b3 d08ea000 00000000 cf247000
       bffffe7e c0119751 d08ea000 00000000 cb77c000 00000001 bfffecec bfffecec
       c010864b bffffe7e bffffd94 bfffecec 00000001 bfffecec bfffecec 00000081
Call Trace:    [<d08ede27>] [<d08f02a0>] [<c011a2b3>] [<c0119751>] 
[<c010864b>]
Code: 89 50 04 89 02 c7 06 00 00 00 00 c7 46 04 00 00 00 00 8b 1d


>>EIP; c0196687 <pci_unregister_driver+b/174>   <=====

>>eax; d08f33a0 <[softdog].bss.end+cdd/793d>
>>ebx; d08ea000 <[3c59x]__module_kernel_version+0/20>
>>edx; d0864020 <[aic7xxx]aic7xxx_pci_driver+0/3f>
>>esi; d08f02a0 <[3c59x]vortex_driver+0/3f>
>>edi; d08ea000 <[3c59x]__module_kernel_version+0/20>
>>esp; cb77df80 <___strtok+b4ad618/1053e698>

Trace; d08ede27 <[3c59x]vortex_cleanup+13/25>
Trace; d08f02a0 <[3c59x]vortex_driver+0/3f>
Trace; c011a2b3 <try_inc_mod_count+c9b/1390>
Trace; c0119751 <try_inc_mod_count+139/1390>
Trace; c010864b <__up_wakeup+f87/1334>

Code;  c0196687 <pci_unregister_driver+b/174>
00000000 <_EIP>:
Code;  c0196687 <pci_unregister_driver+b/174>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c019668a <pci_unregister_driver+e/174>
   3:   89 02                     mov    %eax,(%edx)
Code;  c019668c <pci_unregister_driver+10/174>
   5:   c7 06 00 00 00 00         movl   $0x0,(%esi)
Code;  c0196692 <pci_unregister_driver+16/174>
   b:   c7 46 04 00 00 00 00      movl   $0x0,0x4(%esi)
Code;  c0196699 <pci_unregister_driver+1d/174>
  12:   8b 1d 00 00 00 00         mov    0x0,%ebx

and second one
Unable to handle kernel paging request at virtual address 2cd08f22
d08ed39f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d08ed39f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000802   ebx: 00000020   ecx: 00000020   edx: e40ce40e
esi: ce6de400   edi: ce6de580   ebp: 0000e400   esp: ce5b5e90
ds: 0018   es: 0018   ss: 0018
Process ip (pid: 1071, stackpage=ce5b5000)
Stack: 000001f0 ce6de580 00000020 00000020 01000000 ce6de478 000001f0 e40ce40e
       e406e40a 0000782d d08ed7da ce6de400 ce6de400 00000000 00001002 00000000
       ce6de590 c01a8b19 ce6de400 ce6de400 00001003 c01a9bd5 ce6de400 ce5b5f48
Call Trace:    [<d08ed7da>] [<c01a8b19>] [<c01a9bd5>] [<c01dbd91>] 
[<c01ddd57>]
  [<c01a27f5>] [<c0142e17>] [<c010873c>] [<c010864b>]
Code: 66 a0 22 8f d0 2c 31 db 8a 49 28 88 4c 24 1b 8b b7 54 01 00


>>EIP; d08ed39f <[3c59x]vortex_down+47/bc>   <=====

>>esi; ce6de400 <___strtok+e40da98/1053e698>
>>edi; ce6de580 <___strtok+e40dc18/1053e698>
>>esp; ce5b5e90 <___strtok+e2e5528/1053e698>

Trace; d08ed7da <[3c59x]netdev_ethtool_ioctl+3e/128>
Trace; c01a8b19 <dev_open+51/a8>
Trace; c01a9bd5 <dev_change_flags+51/488>
Trace; c01dbd91 <devinet_ioctl+325/764>
Trace; c01ddd57 <inet_shutdown+2bb/3dc>
Trace; c01a27f5 <sock_recvmsg+3ad/654>
Trace; c0142e17 <kill_fasync+3bf/3d8>
Trace; c010873c <__up_wakeup+1078/1334>
Trace; c010864b <__up_wakeup+f87/1334>

Code;  d08ed39f <[3c59x]vortex_down+47/bc>
00000000 <_EIP>:
Code;  d08ed39f <[3c59x]vortex_down+47/bc>   <=====
   0:   66                        data16   <=====
Code;  d08ed3a0 <[3c59x]vortex_down+48/bc>
   1:   a0 22 8f d0 2c            mov    0x2cd08f22,%al
Code;  d08ed3a5 <[3c59x]vortex_down+4d/bc>
   6:   31 db                     xor    %ebx,%ebx
Code;  d08ed3a7 <[3c59x]vortex_down+4f/bc>
   8:   8a 49 28                  mov    0x28(%ecx),%cl
Code;  d08ed3aa <[3c59x]vortex_down+52/bc>
   b:   88 4c 24 1b               mov    %cl,0x1b(%esp,1)
Code;  d08ed3ae <[3c59x]vortex_down+56/bc>
   f:   8b b7 54 01 00 00         mov    0x154(%edi),%esi

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm@sse.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

