Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSJYMOu>; Fri, 25 Oct 2002 08:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJYMOu>; Fri, 25 Oct 2002 08:14:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:28627 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261370AbSJYMOt>;
	Fri, 25 Oct 2002 08:14:49 -0400
Date: Fri, 25 Oct 2002 17:57:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021025175705.A14451@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021024211633.A21583@in.ibm.com> <20021025002228.A14712C2DD@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021025002228.A14712C2DD@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Oct 25, 2002 at 09:35:17AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 09:35:17AM +1000, Rusty Russell wrote:
> In message <20021024211633.A21583@in.ibm.com> you write:
> > AFAICS, find_first_bit() needs to be fixed to return "size" if the
> > bitmask is all zeros.
> 
> Yes, the x86 one looks wrong.  Other archs seem to get this correct.
> 

I tested this code in userspace and seems to do the right thing - return
"size" if no bit is set. But I can't find a larger_cpu_mask patch to
test with -mm5. Should I forward port the one from -mm4 experimental or
is there a new version available somewhere ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

bitops_fix.patch
----------------

diff -urN linux-2.5.44-mm5/include/asm-i386/bitops.h linux-2.5.44-mm5-fix/include/asm-i386/bitops.h
--- linux-2.5.44-mm5/include/asm-i386/bitops.h	Sat Oct 19 09:32:01 2002
+++ linux-2.5.44-mm5-fix/include/asm-i386/bitops.h	Fri Oct 25 15:19:54 2002
@@ -306,18 +306,23 @@
 	int res;
 
 	/* This looks at memory. Mark it volatile to tell gcc not to move it around */
-	__asm__ __volatile__(
-		"xorl %%eax,%%eax\n\t"
-		"repe; scasl\n\t"
-		"jz 1f\n\t"
-		"leal -4(%%edi),%%edi\n\t"
-		"bsfl (%%edi),%%eax\n"
-		"1:\tsubl %%ebx,%%edi\n\t"
-		"shll $3,%%edi\n\t"
-		"addl %%edi,%%eax"
-		:"=a" (res), "=&c" (d0), "=&D" (d1)
-		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr));
-	return res;
+        __asm__ __volatile__(
+                "movl %%edi,%%esi\n\t"
+                "movl %%ecx,%%edx\n\t"
+                "repe; scasl\n\t"
+                "subl %%ecx,%%edx\n\t"
+                "movl %%edx,%%ecx\n\t"
+                "shll $5,%%edx\n\t"
+                "movl (%%esi,%%ecx,4),%%edi\n\t"
+                "movl %%ebx,%%eax\n\t"
+                "testl %%edi,%%edi\n\t"
+                "jz 1f\n\t"
+                "bsfl %%edi,%%eax\n\t"
+                "addl %%edx,%%eax\n\t"
+                "1:\t"
+                :"=a" (res), "=&c" (d0), "=&D" (d1)
+                :"1" ((size - 1) >> 5), "2" (addr), "b" (size));
+        return res;
 }
 
 /**
