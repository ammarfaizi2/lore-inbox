Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbUJ2DDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUJ2DDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUJ2DDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:03:44 -0400
Received: from herring.sandwich.net ([64.235.252.202]:25013 "EHLO
	herring.sandwich.net") by vger.kernel.org with ESMTP
	id S262248AbUJ2C5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:57:31 -0400
Date: Fri, 29 Oct 2004 02:57:21 +0000 (UTC)
From: James Renken <jrenken@sandwich.net>
To: linux-kernel@vger.kernel.org
Subject: Assertion failure in journal_start() (ext3/quota related?) kills
 system
Message-ID: <Pine.LNX.4.44.0410290238480.20759-100000@herring.sandwich.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My SMP production machine, which has been running for about a year, has
wedged twice within the past week.  It doesn't die completely, but new
processes run impossibly slowly and the system is unusable until a
hardware reboot.  I don't have any details of the first wedge, but the
second one returned the trace and associated ksymoops below.

This is running stock 2.4.27 plus the 2.4.27-ow1 patch from
http://www.openwall.com/linux/.  My drives are all on a 3ware RAID card,
using the 3w-xxxx 1.02.00.037 driver.  I have five partitions, all ext3,
and three have quotas enabled; these three are using LVM.  The quota
version reported by the kernel is vdquot_6.5.1, and my quota utils are
version 3.09 via backports.org (Debian).  I have CONFIG_QUOTA and
CONFIG_QFMT_V2 set to Y; EXT3_FS is also Y.

This is a newish SuperMicro dual-Xeon server with ECC memory, so I am
fairly sure that this is not a random hardware problem nor a massive I/O
overload.

-----

Oct 28 16:20:33 herring kernel: Assertion failure in journal_start() at transaction.c:251: "handle->h_transaction->t_journal == journal"
Oct 28 16:21:15 herring kernel: kernel BUG at transaction.c:251!
Oct 28 16:21:40 herring kernel: invalid operand: 0000
Oct 28 16:21:42 herring kernel: CPU:    0
Oct 28 16:21:55 herring kernel: EIP:    0010:[journal_start+80/196]    Not tainted
Oct 28 16:21:55 herring kernel: EFLAGS: 00010286
Oct 28 16:21:55 herring kernel: eax: 0000006c   ebx: c9859a80   ecx: ffffffff   edx: 00000002
Oct 28 16:21:55 herring kernel: esi: f6672c00   edi: d9874000   ebp: 00000003   esp: d9875bb0
Oct 28 16:21:55 herring kernel: ds: 0018   es: 0018   ss: 0018
Oct 28 16:21:55 herring kernel: Process ipop3d (pid: 26852, stackpage=d9875000)
Oct 28 16:21:55 herring kernel: Stack: c0280e00 c0280eec c0280de0 000000fb c0280ec0 f6619888 00000004 f65eb900
Oct 28 16:21:55 herring kernel:        c016f597 f6672c00 0000001b debe4380 00000001 d42f8080 00000003 c01598e2
Oct 28 16:21:55 herring kernel:        debe4380 00000000 00000001 c015a4bc debe4380 d42f8080 d42f8080 d9875c4c
Oct 28 16:21:55 herring kernel: Call Trace:    [ext3_write_dquot+211/460] [dqput+90/176] [dquot_drop+56/72] [clear_inode+143/284] [dispose_list+82/196]
Oct 28 16:21:55 herring kernel:   [prune_icache+189/528] [shrink_icache_memory+27/48] [shrink_cache+778/1028] [shrink_caches+60/72] [try_to_free_pages_zone+100/240] [balance_classzone+72/456]
Oct 28 16:21:58 herring kernel:   [getblk+28/76] [__alloc_pages+396/652] [_alloc_pages+22/24] [do_generic_file_read+829/1168] [generic_file_read+139/396] [file_read_actor+0/224]
Oct 28 16:21:59 herring kernel:   [read_blk+84/100] [find_tree_dqentry+63/204] [v2_read_dquot+70/312] [kmem_cache_alloc+116/316] [get_empty_dquot+23/172] [read_dqblk+70/120]
Oct 28 16:21:59 herring kernel:   [dqget+330/464] [dquot_initialize+168/332] [ext3_new_inode+1966/2516] [ext3_new_inode+2138/2516] [journal_start+149/196] [ext3_create+130/256]
Oct 28 16:21:59 herring kernel:   [vfs_create+323/412] [open_namei+324/1960] [filp_open+59/92] [sys_open+54/156] [system_call+51/56]
Oct 28 16:21:59 herring kernel:
Oct 28 16:21:59 herring kernel: Code: 0f 0b fb 00 e0 0d 28 c0 83 c4 14 ff 43 08 89 d8 eb 5b 8d b6

Using defaults from ksymoops -t elf32-i386 -a i386

>>ebx; c9859a80 <_end+94ec900/385cce80>
>>ecx; ffffffff <END_OF_CODE+758f8bc/????>
>>esi; f6672c00 <_end+36305a80/385cce80>
>>edi; d9874000 <_end+19506e80/385cce80>
>>esp; d9875bb0 <_end+19508a30/385cce80>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   fb                        sti
Code;  00000003 Before first symbol
   3:   00 e0                     add    %ah,%al
Code;  00000005 Before first symbol
   5:   0d 28 c0 83 c4            or     $0xc483c028,%eax
Code;  0000000a Before first symbol
   a:   14 ff                     adc    $0xff,%al
Code;  0000000c Before first symbol
   c:   43                        inc    %ebx
Code;  0000000d Before first symbol
   d:   08 89 d8 eb 5b 8d         or     %cl,0x8d5bebd8(%ecx)
Code;  00000013 Before first symbol
  13:   b6 00                     mov    $0x0,%dh

-----

Any ideas?  This is mostly over my head, but I'd be happy to do any
additional debugging.  Thanks in advance!

(P.S.: This is my first post to linux-kernel; my apologies if I've missed
anything important.)

-- 
James Renken, System Administrator                 jrenken@sandwich.net
Sandwich.Net Internet Services  http://www.sandwich.net/  1-877-HUBWICH


