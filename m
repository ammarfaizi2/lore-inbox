Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVICMDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVICMDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 08:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVICMDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 08:03:46 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:54716 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750808AbVICMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 08:03:45 -0400
Date: Sat, 03 Sep 2005 20:59:03 +0900 (JST)
Message-Id: <20050903.205903.706976458.hyoshiok@miraclelinux.com>
To: akpm@osdl.org
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com, hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050902.133716.610538020.hyoshiok@miraclelinux.com>
References: <20050901.180723.982928921.hyoshiok@miraclelinux.com>
	<20050901212929.52e2d2d6.akpm@osdl.org>
	<20050902.133716.610538020.hyoshiok@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Fri, 02 Sep 2005 13:37:16 +0900 (JST)
Message-ID: <20050902.133716.610538020.hyoshiok@miraclelinux.com>

> From: Andrew Morton <akpm@osdl.org>
> > Hiro Yoshioka <hyoshiok@miraclelinux.com> wrote:
> > >
> > > --- linux-2.6.12.4.orig/arch/i386/lib/usercopy.c	2005-08-05 16:04:37.000000000 +0900
> > >  +++ linux-2.6.12.4.nt/arch/i386/lib/usercopy.c	2005-09-01 17:09:41.000000000 +0900
> > 
> > Really.  Please redo and retest the patch against a current kernel.
> 
> Does it mean 2.6.13? I'll do it. 
> 
> Regards,
>   Hiro

Hi,

The following is the patch against 2.6.13

Hiro

diff -ur linux-2.6.13/Makefile linux-2.6.13.nt/Makefile
--- linux-2.6.13/Makefile	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13.nt/Makefile	2005-09-03 14:11:27.000000000 +0900
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 13
-EXTRAVERSION =
+EXTRAVERSION = .nt
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -ur linux-2.6.13/arch/i386/lib/usercopy.c linux-2.6.13.nt/arch/i386/lib/usercopy.c
--- linux-2.6.13/arch/i386/lib/usercopy.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13.nt/arch/i386/lib/usercopy.c	2005-09-03 14:09:18.000000000 +0900
@@ -425,6 +425,107 @@
 		       : "eax", "edx", "memory");
 	return size;
 }
+
+/* Non Temporal Hint version of __copy_user_zeroing_intel */
+/* It is cache aware.                                     */
+/* hyoshiok@miraclelinux.com                              */
+static unsigned long 
+__copy_user_zeroing_intel_nocache(void *to, const void __user *from, unsigned long size)
+{
+        int d0, d1;
+
+	__asm__ __volatile__(
+		       "        .align 2,0x90\n"
+		       "0:      movl 32(%4), %%eax\n"
+		       "        cmpl $67, %0\n"      
+		       "        jbe 2f\n"            
+		       "1:      movl 64(%4), %%eax\n"
+		       "        .align 2,0x90\n"     
+		       "2:      movl 0(%4), %%eax\n" 
+		       "21:     movl 4(%4), %%edx\n" 
+		       "        movnti %%eax, 0(%3)\n" 
+		       "        movnti %%edx, 4(%3)\n" 
+		       "3:      movl 8(%4), %%eax\n" 
+		       "31:     movl 12(%4),%%edx\n" 
+		       "        movnti %%eax, 8(%3)\n" 
+		       "        movnti %%edx, 12(%3)\n"
+		       "4:      movl 16(%4), %%eax\n"
+		       "41:     movl 20(%4), %%edx\n"
+		       "        movnti %%eax, 16(%3)\n"
+		       "        movnti %%edx, 20(%3)\n"
+		       "10:     movl 24(%4), %%eax\n"
+		       "51:     movl 28(%4), %%edx\n"
+		       "        movnti %%eax, 24(%3)\n"
+		       "        movnti %%edx, 28(%3)\n"
+		       "11:     movl 32(%4), %%eax\n"
+		       "61:     movl 36(%4), %%edx\n"
+		       "        movnti %%eax, 32(%3)\n"
+		       "        movnti %%edx, 36(%3)\n"
+		       "12:     movl 40(%4), %%eax\n"
+		       "71:     movl 44(%4), %%edx\n"
+		       "        movnti %%eax, 40(%3)\n"
+		       "        movnti %%edx, 44(%3)\n"
+		       "13:     movl 48(%4), %%eax\n"
+		       "81:     movl 52(%4), %%edx\n"
+		       "        movnti %%eax, 48(%3)\n"
+		       "        movnti %%edx, 52(%3)\n"
+		       "14:     movl 56(%4), %%eax\n"
+		       "91:     movl 60(%4), %%edx\n"
+		       "        movnti %%eax, 56(%3)\n"
+		       "        movnti %%edx, 60(%3)\n"
+		       "        addl $-64, %0\n"     
+		       "        addl $64, %4\n"      
+		       "        addl $64, %3\n"      
+		       "        cmpl $63, %0\n"      
+		       "        ja  0b\n"            
+		       "        sfence \n"
+		       "5:      movl  %0, %%eax\n"   
+		       "        shrl  $2, %0\n"      
+		       "        andl $3, %%eax\n"    
+		       "        cld\n"               
+		       "6:      rep; movsl\n"   
+		       "        movl %%eax,%0\n"
+		       "7:      rep; movsb\n"	
+		       "8:\n"			
+		       ".section .fixup,\"ax\"\n"
+		       "9:      lea 0(%%eax,%0,4),%0\n"	
+		       "16:     pushl %0\n"	
+		       "        pushl %%eax\n"	
+		       "        xorl %%eax,%%eax\n"
+		       "        rep; stosb\n"	
+		       "        popl %%eax\n"	
+		       "        popl %0\n"	
+		       "        jmp 8b\n"	
+		       ".previous\n"		
+		       ".section __ex_table,\"a\"\n"
+		       "	.align 4\n"	   
+		       "	.long 0b,16b\n"	 
+		       "	.long 1b,16b\n"
+		       "	.long 2b,16b\n"
+		       "	.long 21b,16b\n"
+		       "	.long 3b,16b\n"	
+		       "	.long 31b,16b\n"
+		       "	.long 4b,16b\n"	
+		       "	.long 41b,16b\n"
+		       "	.long 10b,16b\n"
+		       "	.long 51b,16b\n"
+		       "	.long 11b,16b\n"
+		       "	.long 61b,16b\n"
+		       "	.long 12b,16b\n"
+		       "	.long 71b,16b\n"
+		       "	.long 13b,16b\n"
+		       "	.long 81b,16b\n"
+		       "	.long 14b,16b\n"
+		       "	.long 91b,16b\n"
+		       "	.long 6b,9b\n"	
+		       "        .long 7b,16b\n" 
+		       ".previous"		
+		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
+		       :  "1"(to), "2"(from), "0"(size)
+		       : "eax", "edx", "memory");
+	return size;
+}
+
 #else
 /*
  * Leave these declared but undefined.  They should not be any references to
@@ -434,6 +535,8 @@
 __copy_user_zeroing_intel(void *to, const void __user *from, unsigned long size);
 unsigned long
 __copy_user_intel(void __user *to, const void *from, unsigned long size);
+unsigned long
+__copy_user_zeroing_intel_nocache(void *to, const void __user *from, unsigned long size);
 #endif /* CONFIG_X86_INTEL_USERCOPY */
 
 /* Generic arbitrary sized copy.  */
@@ -515,7 +618,6 @@
 		: "memory");						\
 } while (0)
 
-
 unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n)
 {
 	BUG_ON((long) n < 0);
@@ -588,6 +690,21 @@
 }
 EXPORT_SYMBOL(__copy_from_user_ll);
 
+unsigned long
+__copy_from_user_ll_nocache(void *to, const void __user *from, unsigned long n)
+{
+	BUG_ON((long)n < 0);
+#ifdef CONFIG_X86_INTEL_USERCOPY
+	if ( n > 64 && cpu_has_xmm2)
+                n = __copy_user_zeroing_intel_nocache(to, from, n);
+	else
+		__copy_user_zeroing(to, from, n);
+#else
+        __copy_user_zeroing(to, from, n);
+#endif
+	return n;
+}
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
diff -ur linux-2.6.13/include/asm-i386/uaccess.h linux-2.6.13.nt/include/asm-i386/uaccess.h
--- linux-2.6.13/include/asm-i386/uaccess.h	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13.nt/include/asm-i386/uaccess.h	2005-09-03 14:09:18.000000000 +0900
@@ -413,6 +413,8 @@
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
 				const void __user *from, unsigned long n);
+unsigned long __must_check __copy_from_user_ll_nocache(void *to,
+				const void __user *from, unsigned long n);
 
 /*
  * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
@@ -502,11 +504,40 @@
 }
 
 static inline unsigned long
+__copy_from_user_inatomic_nocache(void *to, const void __user *from, unsigned long n)
+{
+	if (__builtin_constant_p(n)) {
+		unsigned long ret;
+
+		switch (n) {
+		case 1:
+			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			return ret;
+		case 2:
+			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			return ret;
+		case 4:
+			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			return ret;
+		}
+	}
+	return __copy_from_user_ll_nocache(to, from, n);
+}
+
+static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
+
+static inline unsigned long
+__copy_from_user_nocache(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_from_user_inatomic_nocache(to, from, n);
+}
+
 unsigned long __must_check copy_to_user(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check copy_from_user(void *to,
diff -ur linux-2.6.13/mm/filemap.c linux-2.6.13.nt/mm/filemap.c
--- linux-2.6.13/mm/filemap.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13.nt/mm/filemap.c	2005-09-03 14:09:18.000000000 +0900
@@ -1726,7 +1726,7 @@
 		int copy = min(bytes, iov->iov_len - base);
 
 		base = 0;
-		left = __copy_from_user_inatomic(vaddr, buf, copy);
+		left = __copy_from_user_inatomic_nocache(vaddr, buf, copy);
 		copied += copy;
 		bytes -= copy;
 		vaddr += copy;
diff -ur linux-2.6.13/mm/filemap.h linux-2.6.13.nt/mm/filemap.h
--- linux-2.6.13/mm/filemap.h	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13.nt/mm/filemap.h	2005-09-03 16:47:39.000000000 +0900
@@ -34,13 +34,13 @@
 	int left;
 
 	kaddr = kmap_atomic(page, KM_USER0);
-	left = __copy_from_user_inatomic(kaddr + offset, buf, bytes);
+	left = __copy_from_user_inatomic_nocache(kaddr + offset, buf, bytes);
 	kunmap_atomic(kaddr, KM_USER0);
 
 	if (left != 0) {
 		/* Do it the slow way */
 		kaddr = kmap(page);
-		left = __copy_from_user(kaddr + offset, buf, bytes);
+		left = __copy_from_user_nocache(kaddr + offset, buf, bytes);
 		kunmap(page);
 	}
 	return bytes - left;
