Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287454AbSABNpg>; Wed, 2 Jan 2002 08:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSABNp1>; Wed, 2 Jan 2002 08:45:27 -0500
Received: from [217.118.66.254] ([217.118.66.254]:15746 "EHLO
	backtop.namesys.com") by vger.kernel.org with ESMTP
	id <S287590AbSABNpO>; Wed, 2 Jan 2002 08:45:14 -0500
From: Alexander Zarochentcev <zam@namesys.com>
Message-ID: <15411.1131.936970.188735@backtop.namesys.com>
Date: Wed, 2 Jan 2002 16:00:27 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
        <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: reiserfs does not work with linux 2.4.17 on
 sparc64 CPUs
In-Reply-To: <Pine.LNX.4.33.0201021143270.7126-100000@Expansa.sns.it>
In-Reply-To: <3C2C4B6A.2010705@namesys.com>
	<Pine.LNX.4.33.0201021143270.7126-100000@Expansa.sns.it>
X-Mailer: VM 7.00 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

As I guess, the problem is that sparc64's set_bit() does not like addresses
which are not aligned on 8-byte boundary. New `s_properties' field of reiserfs
specific part of super block is such kind of.

Can you try this patch:

--- linux/include/linux/reiserfs_fs_sb.h.org	Wed Jan  2 15:45:20 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Wed Jan  2 15:45:36 2002
@@ -407,7 +407,7 @@
 				/* To be obsoleted soon by per buffer seals.. -Hans */
     atomic_t s_generation_counter; // increased by one every time the
     // tree gets re-balanced
-    unsigned int s_properties;    /* File system properties. Currently holds
+    unsigned long s_properties;    /* File system properties. Currently holds
 				     on-disk FS format */
     
     /* session statistics */



Luigi Genoni writes:
 > OK, here is what ksymoops output
 > 
 >               \|/ ____ \|/
 >               "@'/ .. \`@"
 >               /_| \__/ |_\
 >                  \__U_/
 > mount(38): Kernel does fpu/atomic unaligned load/store.
 > TSTATE: 0000004411009603 TPC: 000000000059bae8 TNPC: 000000000059baec Y:
 > 00000000    Not tainted
 > Using defaults from ksymoops -a sparc
 > g0: 000000000000ff00 g1: 0000000000000142 g2: 0000000000000001 g3:
 > 0000000000000000
 > g4: fffff80000000000 g5: 0000000000000002 g6: fffff8006f27c000 g7:
 > 0000000000000140
 > o0: 0000000000000000 o1: fffff8006f3241c4 o2: 0000000000000000 o3:
 > 0000000000000073
 > o4: 0000000000000073 o5: 0000000000000000 sp: fffff8006f27f1b1 ret_pc:
 > 00000000004ae6dc
 > l0: 0000000000000000 l1: fffff8006f1b8000 l2: fffff8006f1b8034 l3:
 > 00000000005a9800
 > l4: 00000000019cc780 l5: 00000000005ca7a0 l6: fffff8006f1ba001 l7:
 > 0000000000030000
 > i0: fffff8006f324000 i1: fffff8006f3241c4 i2: 0000000000000000 i3:
 > 00000000004ae480
 > i4: 0814000000000000 i5: 0000000000000800 i6: fffff8006f27f2a1 i7:
 > 00000000004694b4
 > Caller[00000000004694b4]
 > Caller[0000000000469c10]
 > Caller[000000000047d370]
 > Caller[000000000047d688]
 > Caller[000000000042da08]
 > Caller[0000000000410af4]
 > Caller[000000000001274c]
 > Instruction DUMP: 9089c005  12600006  8219c005 <c3f25007> 80a1c001
 > 3267fffb  ce5a4000  81c3e008  8143e00a
 > 
 > >>TPC; 0059bae8 <__bitops_begin+28/40>   <=====
 > >>O7;  004ae6dc <reiserfs_read_super+25c/580>
 > >>I7;  004694b4 <get_sb_bdev+274/360>
 > Trace; 004694b4 <get_sb_bdev+274/360>
 > Trace; 00469c10 <do_kern_mount+b0/1c0>
 > Trace; 0047d370 <do_add_mount+10/140>
 > Trace; 0047d688 <do_mount+148/180>
 > Trace; 0042da08 <sys32_mount+108/160>
 > Trace; 00410af4 <linux_sparc_syscall32+34/40>
 > Trace; 0001274c Before first symbol
 > Code;  0059badc <__bitops_begin+1c/40>
 > 0000000000000000 <_TPC>:
 > Code;  0059badc <__bitops_begin+1c/40>
 >    0:   90 89 c0 05       andcc  %g7, %g5, %o0
 > Code;  0059bae0 <__bitops_begin+20/40>
 >    4:   12 60 00 06       bne,pn   %xcc, 1c <_TPC+0x1c> 0059baf8
 > <__bitops_begin+38/40>
 > Code;  0059bae4 <__bitops_begin+24/40>
 >    8:   82 19 c0 05       xor  %g7, %g5, %g1
 > Code;  0059bae8 <__bitops_begin+28/40>   <=====
 >    c:   c3 f2 50 07       casx  [ %o1 ], %g7, %g1   <=====
 > Code;  0059baec <__bitops_begin+2c/40>
 >   10:   80 a1 c0 01       cmp  %g7, %g1
 > Code;  0059baf0 <__bitops_begin+30/40>
 >   14:   32 67 ff fb       bne,a,pn   %xcc, 0 <_TPC>
 > Code;  0059baf4 <__bitops_begin+34/40>
 >   18:   ce 5a 40 00       ldx  [ %o1 ], %g7
 > Code;  0059baf8 <__bitops_begin+38/40>
 >   1c:   81 c3 e0 08       retl
 > Code;  0059bafc <__bitops_begin+3c/40>
 >   20:   81 43 e0 0a       membar  #StoreStore|#StoreLoad
 > 
 > 



-- 
Alex.
