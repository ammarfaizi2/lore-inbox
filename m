Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCWGUM>; Sun, 23 Mar 2003 01:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbTCWGUM>; Sun, 23 Mar 2003 01:20:12 -0500
Received: from dp.samba.org ([66.70.73.150]:59018 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262812AbTCWGUH>;
	Sun, 23 Mar 2003 01:20:07 -0500
Date: Sun, 23 Mar 2003 17:25:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-ID: <20030323062547.GG5981@krispykreme>
References: <20030322175816.225a1f23.akpm@digeo.com> <20030323035523.GF5981@krispykreme> <20030322200455.683ef46d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322200455.683ef46d.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Did you end up deciding it was worthwhile putting a spinlock in the ppc64
> pageframe for that?  Or hashing for it.

Heres an old email I dug up. It was running an sdet like thing.

Anton

>From anton@samba.org Fri Jul 26 06:32:52 2002
Date: Fri, 26 Jul 2002 06:32:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [anton@samba.org: raw data] (fwd)

> >  26274 .page_remove_rmap
> >  19059 .page_add_rmap
> >  13378 .save_remaining_regs
> >  11126 .page_cache_release
> >  10031 .clear_user_page
> >   9616 .copy_page
> >   9539 .do_page_fault
> >   8876 .pSeries_insert_hpte
> >   8488 .pSeries_flush_hash_range
> >   8106 .find_get_page
> >   7496 .lru_cache_add
> >   6789 .copy_page_range
> >   6177 .zap_pte_range
> 
> Holy cow.

Here are the results when I embedded a spinlock in the page struct.

 19624 .page_remove_rmap                       
 15682 .save_remaining_regs                    
 13835 .page_cache_release                     
 12827 .zap_pte_range                          
 12624 .do_page_fault                          
 12390 .copy_page_range                        
 10908 .pSeries_insert_hpte                    
 10492 .pSeries_flush_hash_range               
  9219 .find_get_page                          
  8879 .page_add_rmap                          
  7482 .copy_page                              
  6672 .kmem_cache_free                        
  5672 .kmem_cache_alloc                       

page_add_rmap has dropped an awful lot. I need to check that its
actually the change from bitop spinlock to regular spinlock and not the
increase in page struct size (which might be reduce cacheline sharing
between adjacent mem_map entries).

As expected the difference between page_add_rmap and page_remove_rmap
looks to be the linked list walk. From the profile below, lock
aquisition is 15% and list walking is about 40% of the function.

The two things that seem to help us here are:

1. Half as many atomic operations. The lock drop is a simple store
instead of an atomic sequence needed to avoid changing the other bits in
the flags word.

2. Not completing the atomic sequence when we know we arent going to get
the lock. The spinlock backs off to loads when someone else has the
lock, avoiding the costly store with reservation. Perhaps I should make
our bitops do a similar check so we do a load with reservation and
jump straight out if the bit is set. Im guessing you cant do the same on
intel.

Anton

00094864 .page_remove_rmap                         19784
   0.3          c000000000094864  std        r30,-16(r1)
   0.2          c000000000094868  mflr   r0
   0.0          c00000000009486c  ld     r30,-18960(r2)
   0.0          c000000000094870  std    r0,16(r1)
   0.0          c000000000094874  subfic        r0,r3,0
   0.3          c000000000094878  adde  r11,r0,r3
   0.0          c00000000009487c  subfic        r10,r4,0
   0.0          c000000000094880  adde  r0,r10,r4
   0.0          c000000000094884  std   r27,-40(r1)
   0.3          c000000000094888  or    r0,r0,r11
   0.0          c00000000009488c  li    r27,0
   0.0          c000000000094890  std   r28,-32(r1)
   0.0          c000000000094894  cmpwi r0,0
   0.3          c000000000094898  mr    r28,r4
   0.0          c00000000009489c  std   r29,-24(r1)
   0.0          c0000000000948a0  mr    r29,r3
   0.0          c0000000000948a4  std   r31,-8(r1)
   0.3          c0000000000948a8  std   r26,-48(r1)
   0.0          c0000000000948ac  stdu  r1,-160(r1)
   0.0          c0000000000948b0  lbz   r9,40(r3)
   0.5          c0000000000948b4  ld    r8,-32752(r30)
   0.0          c0000000000948b8  rldicr        r9,r9,3,60
   0.0          c0000000000948bc  ld    r10,-32744(r30)
   0.0          c0000000000948c0  ldx   r11,r9,r8
   0.9          c0000000000948c4  ld    r0,4616(r11)
   0.0          c0000000000948c8  ld    r9,4624(r11)
   0.0          c0000000000948cc  subf  r0,r0,r3
   0.0          c0000000000948d0  sradi r0,r0,3
   1.1          c0000000000948d4  rldicl        r9,r9,52,12
   0.0          c0000000000948d8  mulld r0,r0,r10
   0.0          c0000000000948dc  add   r31,r0,r9
   0.0          c0000000000948e0  bne-  c000000000094a34 
   1.6          c0000000000948e4  ld    r9,-32768(r30)
   0.0          c0000000000948e8  ld    r0,0(r9)
   0.0          c0000000000948ec  cmpld r31,r0
   0.0          c0000000000948f0  bge-  c00000000009497c 
   1.1          c0000000000948f4  ld    r0,40(r29)
   0.0          c0000000000948f8  addi  r31,r29,40
   0.0          c0000000000948fc  rldicl        r0,r0,53,63
   0.1          c000000000094900  cmpwi r0,0
   0.0          c000000000094904  bne-  c00000000009497c 
   0.7          c000000000094908  addi  r11,r29,80
   0.0          c00000000009490c  li    r9,1
   0.0          c000000000094910  b     c000000000094920 
   3.4          c000000000094914  lwzx  r10,r0,r11
   0.0          c000000000094918  cmpwi r10,0
   0.0          c00000000009491c  bne-  c000000000094914 
   0.9          c000000000094920  lwarx r10,r0,r11
   3.8          c000000000094924  cmpwi r10,0
   0.0          c000000000094928  bne+  c000000000094914 
   0.5          c00000000009492c  stwcx.        r9,r0,r11
  14.9          c000000000094930  bne+  c000000000094920 
   0.8          c000000000094934  isync
   4.7          c000000000094938  ld    r0,40(r29)
   6.8          c00000000009493c  rldicl        r0,r0,48,63
   0.2          c000000000094940  cmpwi r0,0
   0.0          c000000000094944  beq-  c0000000000949c0 
   0.1          c000000000094948  ld    r0,64(r29)
   0.0          c00000000009494c  cmpd  r0,r28
   0.0          c000000000094950  beq-  c0000000000949a4 
   2.4          c000000000094954  lhz   r10,24(r13)
   0.0          c000000000094958  ld    r0,-32760(r30)
   0.0          c00000000009495c  rldicr        r10,r10,7,56
   0.1          c000000000094960  add   r10,r10,r0
   0.2          c000000000094964  ld   r11,48(r10)
   0.0          c000000000094968  addi r11,r11,-1
   0.0          c00000000009496c  std  r11,48(r10)
   0.3          c000000000094970  eieio
   0.3          c000000000094974  li   r0,0
   0.0          c000000000094978  stw  r0,80(r29)
   0.0          c00000000009497c  addi r1,r1,160
   0.0          c000000000094980  ld   r0,16(r1)
   0.4          c000000000094984  ld   r26,-48(r1)
   0.2          c000000000094988  mtlr r0
   0.0          c00000000009498c  ld   r27,-40(r1)
   0.0          c000000000094990  ld   r28,-32(r1)
   0.0          c000000000094994  ld   r29,-24(r1)
   0.2          c000000000094998  ld   r30,-16(r1)
   0.0          c00000000009499c  ld   r31,-8(r1)
   0.0          c0000000000949a0  blr
   0.1          c0000000000949a4  std  r27,64(r29)
   0.0          c0000000000949a8  lis  r0,1
   0.0          c0000000000949ac  ldarx        r9,r0,r31
   1.2          c0000000000949b0  andc r9,r9,r0
   0.1          c0000000000949b4  stdcx.       r9,r0,r31
   1.4          c0000000000949b8  bne+ c0000000000949ac 
   0.1          c0000000000949bc  b    c000000000094954 
   0.8          c0000000000949c0  ld   r3,64(r29)
   0.0          c0000000000949c4  cmpdi        r3,0
   0.0          c0000000000949c8  beq+ c000000000094954 
   0.7          c0000000000949cc  lis  r26,1
   1.4          c0000000000949d0  ld   r0,8(r3)
   0.0          c0000000000949d4  cmpd r0,r28
   0.0          c0000000000949d8  beq- c0000000000949f0 
  38.4          c0000000000949dc  mr   r27,r3
   0.1          c0000000000949e0  ld   r3,0(r3)
   0.0          c0000000000949e4  cmpdi        r3,0
   0.0          c0000000000949e8  bne+ c0000000000949d0 
   0.0          c0000000000949ec  b    c000000000094954 
   5.4          c0000000000949f0  mr   r4,r27
   0.0          c0000000000949f4  mr   r5,r29
   0.0          c0000000000949f8  bl   c000000000094f14 <.pte_chain_free>
   0.1          c0000000000949fc  ld   r3,64(r29)
   0.1          c000000000094a00  ld   r0,0(r3)
   0.0          c000000000094a04  cmpdi        r0,0
   0.0          c000000000094a08  bne+ c000000000094954 
   0.5          c000000000094a0c  ld   r0,8(r3)
   0.0          c000000000094a10  std  r0,64(r29)
   0.0          c000000000094a14  ldarx        r9,r0,r31
   0.2          c000000000094a18  or   r9,r9,r26
   0.0          c000000000094a1c  stdcx.       r9,r0,r31
   1.3          c000000000094a20  bne+ c000000000094a14 
   0.1          c000000000094a24  li   r4,0
   0.0          c000000000094a28  li   r5,0
   0.0          c000000000094a2c  bl   c000000000094f14 <.pte_chain_free>
   0.0          c000000000094a30  b    c000000000094954 
   0.0          c000000000094a34  ld   r3,-32736(r30)
   0.0          c000000000094a38  li   r5,172
   0.0          c000000000094a3c  ld   r4,-32728(r30)
   0.0          c000000000094a40  bl   c000000000059620 <.printk>
   0.0          c000000000094a44  nop
   0.0          c000000000094a48  li   r3,0
   0.0          c000000000094a4c  bl   c0000000001ce80c <.xmon>
   0.0          c000000000094a50  nop
   0.0          c000000000094a54  b    c0000000000948e4 

000946f8 .page_add_rmap                             9001
   0.7          c0000000000946f8  std   r30,-16(r1)
   0.4          c0000000000946fc  mflr      r0
   0.0          c000000000094700  ld        r30,-18960(r2)
   0.0          c000000000094704  std       r28,-32(r1)
   0.0          c000000000094708  mr       r28,r4
   0.5          c00000000009470c  ld       r11,-32768(r30)
   0.1          c000000000094710  std      r29,-24(r1)
   0.0          c000000000094714  addi     r29,r3,40
   0.0          c000000000094718  std      r31,-8(r1)
   0.6          c00000000009471c  mr       r31,r3
   0.0          c000000000094720  std      r0,16(r1)
   0.0          c000000000094724  stdu     r1,-144(r1)
   0.4          c000000000094728  ld       r0,0(r4)
   0.1          c00000000009472c  ld       r9,0(r11)
   0.0          c000000000094730  rldicl   r0,r0,48,16
   0.0          c000000000094734  cmpld    r0,r9
   0.0          c000000000094738  bge-     c0000000000947d8 
  10.3          c00000000009473c  ld       r0,40(r3)
   0.0          c000000000094740  addi     r9,r3,80
   0.0          c000000000094744  li       r11,1
   0.0          c000000000094748  rldicl   r0,r0,53,63
   1.2          c00000000009474c  cmpwi    r0,0
   0.0          c000000000094750  bne-     c0000000000947d8 
   0.7          c000000000094754  b        c000000000094764 
   4.1          c000000000094758  lwzx     r0,r0,r9
   0.0          c00000000009475c  cmpwi    r0,0
   2.8          c000000000094760  bne-     c000000000094758 
   0.6          c000000000094764  lwarx    r0,r0,r9
   8.9          c000000000094768  cmpwi    r0,0
   0.0          c00000000009476c  bne+     c000000000094758 
   0.9          c000000000094770  stwcx.   r11,r0,r9
  24.6          c000000000094774  bne+     c000000000094764 
   1.3          c000000000094778  isync
   9.7          c00000000009477c  ld       r9,40(r3)
  10.0          c000000000094780  rldicl   r9,r9,48,63
   0.0          c000000000094784  cmpwi    r9,0
   0.0          c000000000094788  bne-     c000000000094810 
   2.3          c00000000009478c  ld       r0,64(r31)
   0.0          c000000000094790  lis      r9,1
   0.0          c000000000094794  cmpdi    r0,0
   0.0          c000000000094798  bne-     c0000000000947f8 
   0.3          c00000000009479c  std      r28,64(r31)
   0.1          c0000000000947a0  ldarx    r0,r0,r29
   2.8          c0000000000947a4  or       r0,r0,r9
   0.1          c0000000000947a8  stdcx.   r0,r0,r29
   2.5          c0000000000947ac  bne+     c0000000000947a0 
   1.1          c0000000000947b0  eieio
   0.9          c0000000000947b4  li       r0,0
   0.0          c0000000000947b8  stw      r0,80(r31)
   0.0          c0000000000947bc  lhz      r9,24(r13)
   0.2          c0000000000947c0  ld       r0,-32760(r30)
   0.6          c0000000000947c4  rldicr   r9,r9,7,56
   0.0          c0000000000947c8  add      r9,r9,r0
   0.0          c0000000000947cc  ld       r10,48(r9)
   0.4          c0000000000947d0  addi     r10,r10,1
   2.3          c0000000000947d4  std      r10,48(r9)
   0.0          c0000000000947d8  addi     r1,r1,144
   0.0          c0000000000947dc  ld       r0,16(r1)
   0.3          c0000000000947e0  ld       r28,-32(r1)
   0.7          c0000000000947e4  mtlr     r0
   0.0          c0000000000947e8  ld       r29,-24(r1)
   0.0          c0000000000947ec  ld       r30,-16(r1)
   0.0          c0000000000947f0  ld       r31,-8(r1)
   0.0          c0000000000947f4  blr
   1.2          c0000000000947f8  bl      c000000000094f98 <.pte_chain_alloc>
   0.4          c0000000000947fc  std     r28,8(r3)
   1.0          c000000000094800  ld      r0,64(r31)
   0.0          c000000000094804  std     r0,0(r3)
   0.0          c000000000094808  std     r3,64(r31)
   0.0          c00000000009480c  b       c0000000000947b0 
   0.4          c000000000094810  bl      c000000000094f98 <.pte_chain_alloc>
   0.1          c000000000094814  li      r0,0
   0.0          c000000000094818  ld      r11,64(r31)
   0.0          c00000000009481c  lis     r9,1
   0.2          c000000000094820  std     r0,0(r3)
   0.1          c000000000094824  std     r11,8(r3)
   0.0          c000000000094828  std     r3,64(r31)
   0.2          c00000000009482c  ldarx   r0,r0,r29
   0.4          c000000000094830  andc    r0,r0,r9
   0.0          c000000000094834  stdcx.  r0,r0,r29
   3.3          c000000000094838  bne+    c00000000009482c 
   0.3          c00000000009483c  b       c00000000009478c 

