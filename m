Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTLDS3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLDS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:28:52 -0500
Received: from relay-3v.club-internet.fr ([194.158.96.114]:17854 "EHLO
	relay-3v.club-internet.fr") by vger.kernel.org with ESMTP
	id S263485AbTLDS1p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:27:45 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org, nathans@sgi.com
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu,  4 Dec 2003 19:27:41 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1070562461.26292.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I tried again the patch on "small kernel" test11 with CONFIG_DEBUG_PAGEALLOC only. Here are the first results. I will do more tests later because it seems weird. This time I have very different behavior for XFS and Ext3.

I got an oops at boot time, when system try to mount root filesystem (XFS).

But when I tried on a root Ext3, I got no problem at all. I even compiled 2 kernel straight without any problems. It seems to be the first time a test11 works flawless on my system.

Of course, XFS and Ext3 were respectively enabled in the kernels.

I hope I didn't make any mistake, I will confirm tomorrow.


Jerome Pinot

The XFS oops (I was too lazy to write down all the backtraces, all about xfs_* things, I can send if needed):

---
kernel BUG at include/linux/mm.h:267!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01aa5ac>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cef3d000   ecx: cef3c000   edx: c1254e28
esi: 00310020   edi: 00000001   ebp: c12f3b18   esp: c12f3b0c
ds: 007b   es: 007b   ss: 0068
Stack: 00000100 00000000 ceee0000 c12f3b28 c01aaf90 c0253d40 cef3d000 c12f3b7c
       c019669b cef3d000 00000100 00000000 00000100 00000000 00000a02 00000000
       00000100 00000000 cef3d000 00000100 00000000 00000a02 00000000 00000802
Call Trace:
 [<c01aaf90>] pagebuf_free+0x24/0x30
 [<c019669b>] xlog_find_verify_cycle+0x18b/0x1e0
Code: 0f 0b 0b 01 d6 cb 1f c0 eb 8e ff 73 54 eb b3 90 53 e8 0e 11


>>EIP; c01aa5ac <_pagebuf_free_object+108/134>   <=====

>>ebx; cef3d000 <_end+ece0e4c/3fda1e4c>
>>ecx; cef3c000 <_end+ecdfe4c/3fda1e4c>
>>edx; c1254e28 <_end+ff8c74/3fda1e4c>
>>ebp; c12f3b18 <_end+1097964/3fda1e4c>
>>esp; c12f3b0c <_end+1097958/3fda1e4c>

Trace; c01aaf90 <pagebuf_free+24/30>
Trace; c019669b <xlog_find_verify_cycle+18b/1e0>

Code;  c01aa5ac <_pagebuf_free_object+108/134>
00000000 <_EIP>:
Code;  c01aa5ac <_pagebuf_free_object+108/134>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01aa5ae <_pagebuf_free_object+10a/134>
   2:   0b 01                     or     (%ecx),%eax
Code;  c01aa5b0 <_pagebuf_free_object+10c/134>
   4:   d6                        (bad)
Code;  c01aa5b1 <_pagebuf_free_object+10d/134>
   5:   cb                        lret
Code;  c01aa5b2 <_pagebuf_free_object+10e/134>
   6:   1f                        pop    %ds
Code;  c01aa5b3 <_pagebuf_free_object+10f/134>
   7:   c0 eb 8e                  shr    $0x8e,%bl
Code;  c01aa5b6 <_pagebuf_free_object+112/134>
   a:   ff 73 54                  pushl  0x54(%ebx)
Code;  c01aa5b9 <_pagebuf_free_object+115/134>
   d:   eb b3                     jmp    ffffffc2 <_EIP+0xffffffc2>
Code;  c01aa5bb <_pagebuf_free_object+117/134>
   f:   90                        nop
Code;  c01aa5bc <_pagebuf_free_object+118/134>
  10:   53                        push   %ebx
Code;  c01aa5bd <_pagebuf_free_object+119/134>
  11:   e8 0e 11 00 00            call   1124 <_EIP+0x1124>

 <0>Kernel panic: Attempted to kill the idle task!
---

