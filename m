Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSJZPmT>; Sat, 26 Oct 2002 11:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSJZPmT>; Sat, 26 Oct 2002 11:42:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15763 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261598AbSJZPmQ>; Sat, 26 Oct 2002 11:42:16 -0400
Date: Sat, 26 Oct 2002 21:24:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021026212434.A24376@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021024211633.A21583@in.ibm.com> <20021025002228.A14712C2DD@lists.samba.org> <20021025175705.A14451@in.ibm.com> <3DB98823.67FDBEF3@digeo.com> <20021025235222.A25786@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021025235222.A25786@in.ibm.com>; from dipankar@in.ibm.com on Fri, Oct 25, 2002 at 11:52:22PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -urN linux-2.5.44-mm5/include/asm-i386/bitops.h linux-2.5.44-mm5-fix/include/asm-i386/bitops.h
--- linux-2.5.44-mm5/include/asm-i386/bitops.h	Sat Oct 19 09:32:01 2002
+++ linux-2.5.44-mm5-fix/include/asm-i386/bitops.h	Sat Oct 26 17:52:09 2002
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
 
