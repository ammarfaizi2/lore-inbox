Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264216AbTH2B0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 21:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTH2B0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 21:26:18 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:56807
	"EHLO bastard") by vger.kernel.org with ESMTP id S264348AbTH2B0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 21:26:07 -0400
Message-ID: <3F4EABAD.1020408@tupshin.com>
Date: Thu, 28 Aug 2003 18:26:05 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030813 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shaggy@austin.ibm.com
Cc: linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@Namesys.COM>
Subject: Kernel BUG in JFS 2.6.0-test4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After 2 days of uptime, I got the BUG below. I didn't notice until a 
couple of hours later, when I noticed that I a had a non-functioning and 
non-killable postgresql process, and a lilo install that refused to 
finish or die. This is with a stock 2.6.0-test4 + the Aug 26th reiser4 
patches, but the problem (at least on the surface) doesn't appear to be 
related to the reiser4 stuff. (I'm CCing that list just in case somebody 
there thinks otherwise).

-Tupshin


Aug 28 15:38:32 bastard kernel: BUG at fs/jfs/jfs_dmap.c:468 
assert(blkno + nblocks <= bmp->db_mapsize)
Aug 28 15:38:32 bastard kernel: kernel BUG at fs/jfs/jfs_dmap.c:468!
Aug 28 15:38:32 bastard kernel: invalid operand: 0000 [#1]
Aug 28 15:38:32 bastard kernel: CPU:    0
Aug 28 15:38:32 bastard kernel: EIP:    0060:[<c02526d3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 28 15:38:32 bastard kernel: EFLAGS: 00010282
Aug 28 15:38:32 bastard kernel: eax: 0000004b   ebx: 00000064   ecx: 
c053b544   edx: c0483ad8
Aug 28 15:38:32 bastard kernel: esi: 00726174   edi: 00000000   ebp: 
f03d8000   esp: f7d41e9c
Aug 28 15:38:32 bastard kernel: ds: 007b   es: 007b   ss: 0068
Aug 28 15:38:32 bastard kernel: Stack: c043595b c0435b5c 000001d4 
c0449000 f03e024c c1652e08 d893bd3c 00001000
Aug 28 15:38:32 bastard kernel: c013da09 f03e01c0 00000004 d893bd3c 
00001000 c0155d82 c1652e08 000000d0
Aug 28 15:38:32 bastard kernel: d893bd3c c0156dbe 00000000 00000000 
f7dbf60c f03d8000 c1652e08 c01575c8
Aug 28 15:38:32 bastard kernel: Call Trace:
Aug 28 15:38:32 bastard kernel: [<c013da09>] 
__set_page_dirty_nobuffers+0xa9/0xe0
Aug 28 15:38:32 bastard kernel: [<c0155d82>] mark_buffer_dirty+0x32/0x50
Aug 28 15:38:32 bastard kernel: [<c0156dbe>] __block_commit_write+0x8e/0x90
Aug 28 15:38:32 bastard kernel: [<c01575c8>] block_commit_write+0x28/0x30
Aug 28 15:38:32 bastard kernel: [<c0263ef0>] txFreeMap+0x200/0x2f0
Aug 28 15:38:32 bastard kernel: [<c0263a94>] txUpdateMap+0x174/0x240
Aug 28 15:38:32 bastard kernel: [<c0261e96>] txEnd+0xb6/0x120
Aug 28 15:38:32 bastard kernel: [<c0264220>] txLazyCommit+0x20/0xd0
Aug 28 15:38:32 bastard kernel: [<c026436a>] jfs_lazycommit+0x9a/0x1c0
Aug 28 15:38:32 bastard kernel: [<c011a7a0>] default_wake_function+0x0/0x30
Aug 28 15:38:32 bastard kernel: [<c010b172>] ret_from_fork+0x6/0x14
Aug 28 15:38:32 bastard kernel: [<c011a7a0>] default_wake_function+0x0/0x30
Aug 28 15:38:32 bastard kernel: [<c02642d0>] jfs_lazycommit+0x0/0x1c0
Aug 28 15:38:32 bastard kernel: [<c0109235>] kernel_thread_helper+0x5/0x10
Aug 28 15:38:32 bastard kernel: Code: 0f 0b d4 01 5c 5b 43 c0 8b 84 24 
94 00 00 00 8b 94 24 94 00


 >>EIP; c02526d3 <dbUpdatePMap+83/500>   <=====

 >>ecx; c053b544 <per_cpu__runqueues+24/928>
 >>edx; c0483ad8 <log_wait+0/8>
 >>esi; 00726174 <__crc_pnp_add_card_device+eff42/1a4ff7>
 >>ebp; f03d8000 <__crc_sock_wmalloc+19788c/756028>
 >>esp; f7d41e9c <__crc_ext2_xattr_unregister+3a9ce4/913a65>

Trace; c013da09 <__set_page_dirty_nobuffers+a9/e0>
Trace; c0155d82 <mark_buffer_dirty+32/50>
Trace; c0156dbe <__block_commit_write+8e/90>
Trace; c01575c8 <block_commit_write+28/30>
Trace; c0263ef0 <txFreeMap+200/2f0>
Trace; c0263a94 <txUpdateMap+174/240>
Trace; c0261e96 <txEnd+b6/120>
Trace; c0264220 <txLazyCommit+20/d0>
Trace; c026436a <jfs_lazycommit+9a/1c0>
Trace; c011a7a0 <default_wake_function+0/30>
Trace; c010b172 <ret_from_fork+6/14>
Trace; c011a7a0 <default_wake_function+0/30>
Trace; c02642d0 <jfs_lazycommit+0/1c0>
Trace; c0109235 <kernel_thread_helper+5/10>

Code;  c02526d3 <dbUpdatePMap+83/500>
00000000 <_EIP>:
Code;  c02526d3 <dbUpdatePMap+83/500>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02526d5 <dbUpdatePMap+85/500>
   2:   d4 01                     aam    $0x1
Code;  c02526d7 <dbUpdatePMap+87/500>
   4:   5c                        pop    %esp
Code;  c02526d8 <dbUpdatePMap+88/500>
   5:   5b                        pop    %ebx
Code;  c02526d9 <dbUpdatePMap+89/500>
   6:   43                        inc    %ebx
Code;  c02526da <dbUpdatePMap+8a/500>
   7:   c0 8b 84 24 94 00 00      rorb   $0x0,0x942484(%ebx)
Code;  c02526e1 <dbUpdatePMap+91/500>
   e:   00 8b 94 24 94 00         add    %cl,0x942494(%ebx)


