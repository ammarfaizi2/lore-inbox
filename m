Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbSKHIby>; Fri, 8 Nov 2002 03:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266790AbSKHIbw>; Fri, 8 Nov 2002 03:31:52 -0500
Received: from dp.samba.org ([66.70.73.150]:51142 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266795AbSKHIbq>;
	Fri, 8 Nov 2002 03:31:46 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: UP went into unexpected trashing
Date: Fri, 08 Nov 2002 19:33:21 +1100
Message-Id: <20021108083828.699642C456@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ find_first_bit on x86 returns 32 even if you said to stop at (say) 5
  bits.  Uncovered by the larger cpu mask patch. ]

From:  dipankar@in.ibm.com

  Well, my earlier find_first_bit() implementation was completely bogus.
  My sanity has now returned and I coded this patch below that fixes 
  find_find_bit() to return "size" if all bits are zero. I have tested it 
  extensively in userspace and it boots 2.5.44-mm5 which crashed with the earlier
  version of the bitops_fix patch. I have coded the assembly routine
  as optimal as I could think of and without introducing any new
  branches or memory loads.
  
  Along with this patch, I applied the larger_cpu_mask patch to -mm5
  and sanity tested both UP and SMP kernels for dcache leaks in a 4CPU P3 box.
  An ls -lR and subsequent unmounting of that filesystems showed that
  the dentries were correctly getting returned the dcache slab and
  that indicates that the larger_cpu_mask patch no longer breaks RCU.
  I will do some more testing with this combination later with
  rcu_stats applied on this tree (just to be sure), but so far it looks good.
  
  Thanks
  -- 
  Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
  Linux Technology Center, IBM Software Lab, Bangalore, India.
  
  
  bitops_fix.patch
  -----------------
  

--- trivial-2.5-bk/include/asm-i386/bitops.h.orig	2002-11-08 18:47:20.000000000 +1100
+++ trivial-2.5-bk/include/asm-i386/bitops.h	2002-11-08 18:47:20.000000000 +1100
@@ -311,12 +311,13 @@
 		"repe; scasl\n\t"
 		"jz 1f\n\t"
 		"leal -4(%%edi),%%edi\n\t"
-		"bsfl (%%edi),%%eax\n"
-		"1:\tsubl %%ebx,%%edi\n\t"
+		"bsfl (%%edi),%%edx\n"
+		"subl %%ebx,%%edi\n\t"
 		"shll $3,%%edi\n\t"
-		"addl %%edi,%%eax"
+		"addl %%edi,%%edx\n\t"
+		"1:\tmovl %%edx,%%eax\n\t"
 		:"=a" (res), "=&c" (d0), "=&D" (d1)
-		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr));
+		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr), "d" (size));
 	return res;
 }
 
-- 
  Don't blame me: the Monkey is driving
  File: dipankar@in.ibm.com: Re: [long]2.5.44-mm3 UP went into unexpected trashing
