Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSLZAmI>; Wed, 25 Dec 2002 19:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSLZAmH>; Wed, 25 Dec 2002 19:42:07 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:55021 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S261530AbSLZAmG> convert rfc822-to-8bit; Wed, 25 Dec 2002 19:42:06 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
Subject: 2.4.21pre2 + preempt + xfs BUG?
Date: Thu, 26 Dec 2002 01:49:11 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com, rml@tech9.net
Message-Id: <200212260149.11718.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in my 2.4.21-pre2 based -jp15 kernel patch set I can't boot with XFS and 
preemptive kernel enabled.

I use:
 - 2.4.21pre2
 - preempt 2.4.20-ac1 
 - XFS snapshot 2.4.20-2002-11-29_01:21_UTC
 - and a lot of other patches, see http://infolinux.de/jp15

The kernel boots ok for a long time, but when it enters the init process run 
level 5, it throws a kernel BUG in the O(1) scheduler code in schedule() at 
the first statement when it checks for interrupt code. 

I guess it performs a sync on the XFS root file system for the first time. You 
can find a ksymoops message below. 

Here are my observations after several changes in the configuration:

- if preemptive kernel is disabled, XFS can boot successfully. So, the bug is 
triggered by the preemptive kernel patch.

- with preemptive kernel enabled and reiserfs, booting is no problem. So, the 
bug is specific to the combination XFS and preempt.

Is it just me with this BUG or can it be reproduced? 

A release of the patch set is available at
http://infolinux.de/jp15/patchset-2.4.21-pre2-jp15.tar.bz2

Best regards,

    Jörg

-----------------------snip-----------------------
kernel BUG at sched.c:811!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116660>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c1a42000   ecx: 00000001   edx: 00000001
esi: c051cac0   edi: fffffffe   ebp: c1a43e50   esp: c1a43e34
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=c1a43000)
Stack: c01204b0 c1a0a580 c0534a0c c0534a0c c1a42000 c051cac0 fffffffe c1a43e5c
       c0116694 c0525200 00000046 c0120296 00000001 00000001 c01200dd c051cac0
       c1a42000 c0518900 00000000 c04a5df0 c010a8ff 00000000 c1a43eac c04a5df0
Call Trace:    [<c01204b0>] [<c0116694>] [<c0120296>] [<c01200dd>] 
[<c010a8ff>]
  [<c010d153>] [<c021f614>] [<c021c1db>] [<c0116694>] [<c0130c2d>] 
[<c021f479>]
  [<c0235cec>] [<c014dccf>] [<c014976b>] [<c014989f>] [<c01090cf>]
Code: 0f 0b 2b 03 bf 72 43 c0 e9 23 fd ff ff 90 89 f6 55 89 e5 53


>>EIP; c0116660 <schedule+310/320>   <=====

>>ebx; c1a42000 <_end+14e4170/16a21d0>
>>esi; c051cac0 <softirq_vec+0/100>
>>edi; fffffffe <END_OF_CODE+301054e3/????>
>>ebp; c1a43e50 <_end+14e5fc0/16a21d0>
>>esp; c1a43e34 <_end+14e5fa4/16a21d0>

Trace; c01204b0 <__run_task_queue+60/80>
Trace; c0116694 <preempt_schedule+24/40>
Trace; c0120296 <tasklet_hi_action+46/70>
Trace; c01200dd <do_softirq+bd/c0>
Trace; c010a8ff <do_IRQ+cf/e0>
Trace; c010d153 <call_do_IRQ+5/a>
Trace; c021f614 <xfs_syncsub+194/e60>
Trace; c021c1db <xfs_trans_unlocked_item+3b/60>
Trace; c0116694 <preempt_schedule+24/40>
Trace; c0130c2d <filemap_fdatawait+ed/130>
Trace; c021f479 <xfs_sync+29/30>
Trace; c0235cec <linvfs_write_super+3c/40>
Trace; c014dccf <sync_supers+df/170>
Trace; c014976b <fsync_dev+4b/a0>
Trace; c014989f <sys_sync+f/20>
Trace; c01090cf <system_call+33/38>

Code;  c0116660 <schedule+310/320>
00000000 <_EIP>:
Code;  c0116660 <schedule+310/320>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0116662 <schedule+312/320>
   2:   2b 03                     sub    (%ebx),%eax
Code;  c0116664 <schedule+314/320>
   4:   bf 72 43 c0 e9            mov    $0xe9c04372,%edi
Code;  c0116669 <schedule+319/320>
   9:   23 fd                     and    %ebp,%edi
Code;  c011666b <schedule+31b/320>
   b:   ff                        (bad)
Code;  c011666c <schedule+31c/320>
   c:   ff 90 89 f6 55 89         call   *0x8955f689(%eax)
Code;  c0116672 <preempt_schedule+2/40>
  12:   e5 53                     in     $0x53,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!
