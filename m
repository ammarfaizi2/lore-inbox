Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSGHQMf>; Mon, 8 Jul 2002 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSGHQMe>; Mon, 8 Jul 2002 12:12:34 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:2944 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S316611AbSGHQMc>;
	Mon, 8 Jul 2002 12:12:32 -0400
Subject: [BUG] Unable to handle kernel paging request in 2.4.19-rc1
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 08 Jul 2002 18:15:01 +0200
Message-Id: <1026144901.805.12.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just experienced a paging request problem in 2.4.19-rc1 running on x86
(pIII 700 with 704MB ram. Motherboard, cpu, memory is very cool).

My kernel is tainted because I'm using the NAPI patch and tulip-NAPI
driver (by Robert, Jamal, Alexey) and that driver doesn't set
MODULE_LICENSE("GPL");
I have the same patches running in a few production systems/routers
without any problems so I don't think they are the problem.

The process that caused it was wmnd which is a small X network monitor
applet (much like wmnet) which I think accesses /proc/net/dev all the
time to get stats.

Machine was still usable for a while after the failed paging request.
But after a minute or so nmbd died aswell, probably a result of this
first problem and then X segfaulted.

I was in X when it happened, using xmms, ssh, evolution, galeon, xchat
and wmnd.

Hopefully someone can tell me what's going on or if it might be a
hardware problem.


ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map-2.4.19-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 89000000
c014a464
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014a464>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286
eax: 00000000   ebx: da190e40   ecx: 00000002   edx: 89000000
esi: da190e9d   edi: ebda738d   ebp: fffffffe   esp: e4d6ded4
ds: 0018   es: 0018   ss: 0018
Process wmnd (pid: 743, stackpage=e4d6d000)
Stack: fffffff4 da190e40 e602c0a0 e602c108 c0139037 e602c0a0 da190e40 00000000 
       00000000 e4d6df8c e4d6df40 c0139753 da1902c0 e4d6df34 00000000 00000001 
       00000000 e4d6df8c e4d6df34 e4d6c000 e4d6c000 00000001 c1f5b00d 00000000 
Call Trace: [<c0139037>] [<c0139753>] [<c01399e2>] [<c0139ea4>] [<c0112b8e>] 
   [<c01301e3>] [<c013052a>] [<c0108bf7>] 
Code: 66 83 3a 00 74 16 0f b7 4a 02 3b 4b 40 75 0d 8b 73 3c 8b 7a 


>>EIP; c014a464 <proc_lookup+24/90>   <=====

>>ebx; da190e40 <_end+19e4b704/2c4fc8c4>
>>edx; 89000000 Before first symbol
>>esi; da190e9d <_end+19e4b761/2c4fc8c4>
>>edi; ebda738d <_end+2ba61c51/2c4fc8c4>
>>ebp; fffffffe <END_OF_CODE+1159eca7/????>
>>esp; e4d6ded4 <_end+24a28798/2c4fc8c4>

Trace; c0139037 <real_lookup+53/c4>
Trace; c0139753 <link_path_walk+5bf/834>
Trace; c01399e2 <path_walk+1a/1c>
Trace; c0139ea4 <open_namei+88/534>
Trace; c0112b8e <schedule_timeout+7e/98>
Trace; c01301e3 <filp_open+3b/5c>
Trace; c013052a <sys_open+36/84>
Trace; c0108bf7 <system_call+33/38>

Code;  c014a464 <proc_lookup+24/90>
00000000 <_EIP>:
Code;  c014a464 <proc_lookup+24/90>   <=====
   0:   66 83 3a 00               cmpw   $0x0,(%edx)   <=====
Code;  c014a468 <proc_lookup+28/90>
   4:   74 16                     je     1c <_EIP+0x1c> c014a480 <proc_lookup+40/90>
Code;  c014a46a <proc_lookup+2a/90>
   6:   0f b7 4a 02               movzwl 0x2(%edx),%ecx
Code;  c014a46e <proc_lookup+2e/90>
   a:   3b 4b 40                  cmp    0x40(%ebx),%ecx
Code;  c014a471 <proc_lookup+31/90>
   d:   75 0d                     jne    1c <_EIP+0x1c> c014a480 <proc_lookup+40/90>
Code;  c014a473 <proc_lookup+33/90>
   f:   8b 73 3c                  mov    0x3c(%ebx),%esi
Code;  c014a476 <proc_lookup+36/90>
  12:   8b 7a 00                  mov    0x0(%edx),%edi


-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
