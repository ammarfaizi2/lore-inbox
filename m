Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSLHKjj>; Sun, 8 Dec 2002 05:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSLHKjj>; Sun, 8 Dec 2002 05:39:39 -0500
Received: from p3EE3AD9B.dip.t-dialin.net ([62.227.173.155]:1284 "EHLO
	salem.getuid.de") by vger.kernel.org with ESMTP id <S265355AbSLHKjb>;
	Sun, 8 Dec 2002 05:39:31 -0500
Date: Sun, 8 Dec 2002 11:45:41 +0100
From: Christian Kurz <lk@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.5.47
Message-ID: <20021208104540.GA843@salem.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Mail-Copies-To: never
Organization: True happiness will be found only in true love.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the kernel bug by compiling ISDN and the hisax driver directly 
into the kernel. When I then booted the kernel (via grub) and passed the
option hisax=18,2,Elsa0, the kernel will start booting and suddenly stop
with the following message:

put_drv 0: 2 -> 1
kernel bug at kernel/workqueue.c:69!
invalid operand: 0000

CPU:	0
EIP:	0060: [<c0122806>]		Not tainted
eax: 00000000 ebx: c7faa000 ecx: c7ff7820 edx: c7e24a54
esi: c7e24a54 edi: c7e24a58 ebp: c7ff7820 esp: c7fabec8
ds: 0068 es: 0068 ss: 0068
Process swapper (pid: 1, threadinfo = c7faa000 task = c7fa8040)
Stack: 0000000f c7e24000 c7faa000 00000000 c0122fd7 c01ffc1c c02bfe5e c7e24000
       00000002 c7e24000 c027a07d 0000007c c7e24000 00000031 c7e24000 00000001
	   c02c0090 c7e24000 c7e24000 00000000 c01feeef c7e24000 00000001 c7e24000
Call Trace: [<c0122fd7>] [<c01ffc1c>] [<c01feeef>] [<c0110030>] [<c0105086>] [<c0105058>] [<c0106e5d>]
Code: 0f 0b 45 00 de c8 24 c0 89 f6 89 6e 14 9c 5a fa ff 43 10 8d
 <0> Kernel panic: Attempted to kill init!
Debug: sleeping function called from illegal context at include/linux/rwsem.h:4
Call Trace: [<c0113ec2>] [<c015482f>] [<c01548a6>] [<c013c25a>] [<c0115b35>] [<c01193d0>] [<c010907f>] [<c01093a8>] [<c0109464>] [<c0122806>] [<c01c8195>] [<c0185aab>] [<c0018b5d>] [<c0122806>] [<c0122fd7>] [<c01ffc1c>] [<c01feeef>] [<c0110030>] [<c0105086>] [<c0105058>] [<c0106e5d>]

I might have some typos in that output because I had to write it down manually. I then passed the error message to ksymoops and here's the output:

ksymoops 2.4.6 on i586 2.4.19.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.47 (specified)
     -m /boot/System.map-2.5.47 (specified)

No modules in ksyms, skipping objects
kernel bug at kernel/workqueue.c:69!
invalid operand: 0000
CPU:    0
EIP:    0060: [<c0122806>]         Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
eax: 00000000 ebx: c7faa000 ecx: c7ff7820 edx: c7e24a54
esi: c7e24a54 edi: c7e24a58 ebp: c7ff7820 esp: c7fabec8
ds: 0068 es: 0068 ss: 0068
Stack: 0000000f c7e24000 c7faa000 00000000 c0122fd7 c01ffc1c c02bfe5e c7e24000
       00000002 c7e24000 c027a07d 0000007c c7e24000 00000031 c7e24000 00000001
           c02c0090 c7e24000 c7e24000 00000000 c01feeef c7e24000 00000001 c7e240
00
Call Trace: [<c0122fd7>] [<c01ffc1c>] [<c01feeef>] [<c0110030>] [<c0105086>] [<c
0105058>] [<c0106e5d>]
Code: 0f 0b 45 00 de c8 24 c0 89 f6 89 6e 14 9c 5a fa ff 43 10 8d

>>EIP; c0122806 <queue_work+26/98>   <=====

Trace; c0122fd7 <schedule_work+f/10>
Trace; c01ffc1c <isac_sched_event+1c/20>
Trace; c01feeef <Elsa_card_msg+c7/250>
Trace; c0110030 <mtrr_ioctl+1b0/3c8>
Trace; c0105086 <init+2e/178>
Trace; c0105058 <init+0/178>
Trace; c0106e5d <kernel_thread_helper+5/c>

Code;  c0122806 <queue_work+26/98>
00000000 <_EIP>:
Code;  c0122806 <queue_work+26/98>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0122808 <queue_work+28/98>
   2:   45                        inc    %ebp
Code;  c0122809 <queue_work+29/98>
   3:   00 de                     add    %bl,%dh
Code;  c012280b <queue_work+2b/98>
   5:   c8 24 c0 89               enter  $0xc024,$0x89
Code;  c012280f <queue_work+2f/98>
   9:   f6 89 6e 14 9c 5a         (bad)  0x5a9c146e(%ecx)
Code;  c0122815 <queue_work+35/98>
   f:   fa                        cli    
Code;  c0122816 <queue_work+36/98>
  10:   ff 43 10                  incl   0x10(%ebx)
Code;  c0122819 <queue_work+39/98>
  13:   8d 00                     lea    (%eax),%eax

 <0> Kernel panic: Attempted to kill init!
Call Trace: [<c0113ec2>] [<c015482f>] [<c01548a6>] [<c013c25a>] [<c0115b35>] [<c
01193d0>] [<c010907f>] [<c01093a8>] [<c0109464>] [<c0122806>] [<c01c8195>] [<c01
85aab>] [<c0018b5d>] [<c0122806>] [<c0122fd7>] [<c01ffc1c>] [<c01feeef>] [<c0110
030>] [<c0105086>] [<c0105058>] [<c0106e5d>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0113ec2 <__might_sleep+52/60>
Trace; c015482f <get_super_to_sync+4b/94>
Trace; c01548a6 <sync_inodes+2e/74>
Trace; c013c25a <sys_sync+e/24>
Trace; c0115b35 <panic+65/d4>
Trace; c01193d0 <do_exit+44/398>
Trace; c010907f <die+6f/70>
Trace; c01093a8 <do_invalid_op+0/c8>
Trace; c0109464 <do_invalid_op+bc/c8>
Trace; c0122806 <queue_work+26/98>
Trace; c01c8195 <register_cdrom+b5/1a8>
Trace; c0185aab <vsnprintf+39b/3dc>
Trace; c0018b5d Before first symbol
Trace; c0122806 <queue_work+26/98>
Trace; c0122fd7 <schedule_work+f/10>
Trace; c01ffc1c <isac_sched_event+1c/20>
Trace; c01feeef <Elsa_card_msg+c7/250>
Trace; c0110030 <mtrr_ioctl+1b0/3c8>
Trace; c0105086 <init+2e/178>
Trace; c0105058 <init+0/178>
Trace; c0106e5d <kernel_thread_helper+5/c>

1 warning issued.  Results may not be reliable.

I hope this helps you guys to fix the bug. Thanks.

Christian
-- 
Life's most urgent question is: what are you doing for others?
Martin Luther King, Jr.
