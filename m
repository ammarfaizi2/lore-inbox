Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSI3WPL>; Mon, 30 Sep 2002 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSI3WPL>; Mon, 30 Sep 2002 18:15:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:36038 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261356AbSI3WPG>;
	Mon, 30 Sep 2002 18:15:06 -0400
Message-ID: <3D98CE3A.B47251DF@digeo.com>
Date: Mon, 30 Sep 2002 15:20:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, lse-tech@lists.sourceforge.net
Subject: Re: Copy patch for kernel 2.5.38
References: <OFCD687C7E.7D759551-ON87256C40.0068B3E2@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 22:20:23.0061 (UTC) FILETIME=[91A1BC50:01C268CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> 
> Attached is the patch that adds an unrolled loop copy using
> integer registers.
...

OK, thanks.  I'll do some pagecache testing.

>  __generic_copy_to_user(void *to, const void *from, unsigned long n)
>  {
>       prefetch(from);
> -     if (access_ok(VERIFY_WRITE, to, n))
> +     if (access_ok(VERIFY_WRITE, to, n)){
> +       if ((n < 64) || ((((int)from | (int)to) & 0x00000007)==0))
>             __copy_user(to,from,n);
> +       else
> +         n=__copy_user_int(to,from,n);
> +     }
>       return n;
>  }

I was going to whine about the codesize increase from this.

But guess what?  Your patch shrinks 17 kilobytes from my vmlinux's
text section.  That's almost 1%.

How interesting.

mnm:/usr/src/25> size vmlinux 
   text    data     bss     dec     hex filename
1998724  313284  616692 2928700  2cb03c vmlinux

mnm:/usr/src/xx> size vmlinux 
   text    data     bss     dec     hex filename
2016531  313284  616692 2946507  2cf5cb vmlinux

mnm:/usr/src/xx> expr 2016531 - 1998724
17807

mnm:/usr/src/25> size net/socket.o
   text    data     bss     dec     hex filename
   8730    1312     192   10234    27fa net/socket.o

mnm:/usr/src/xx> size net/socket.o
   text    data     bss     dec     hex filename
   8922    1312     192   10426    28ba net/socket.o

Most of this was in tcp_sendmsg().  Having looked at the asm, it's not
immediately clear to me where the reductions come from. It's not due
to the out-of-line exception table stuff.  Looks like the inlines somehow
generated smaller instructions.

I bet we'd get decent gains by just making all the uaccess functions
be simple subroutines.  But the same goes for the rest of the kernel
so whatever.

Making all the out-of-line copy functions be FASTCALL increased
the kernel size by 1k, so forget that.

Here's what I ended up with.  Your code is enabled for CONFIG_M586MMX,
CONFIG_M686, CONFIG_MPENTIUMIII and CONFIG_MPENTIUM4.  Because I'm
pretty sure that this is specific to Intel implementations.

If this tests out OK we should be able to go back to using copy_*_user
in networking, rather than abusing the csum routines as faster copy
functions.

 arch/i386/kernel/i386_ksyms.c |    4 
 arch/i386/lib/usercopy.c      |  210 +++++++++++++++++++++++++++++++++++++++++-
 include/asm-i386/uaccess.h    |   54 +++++++---
 3 files changed, 248 insertions(+), 20 deletions(-)

--- 2.5.39/arch/i386/lib/usercopy.c~intel-user-copy	Mon Sep 30 14:10:23 2002
+++ 2.5.39-akpm/arch/i386/lib/usercopy.c	Mon Sep 30 15:08:43 2002
@@ -45,8 +45,12 @@ unsigned long
 __generic_copy_to_user(void *to, const void *from, unsigned long n)
 {
 	prefetch(from);
-	if (access_ok(VERIFY_WRITE, to, n))
-		__copy_user(to,from,n);
+	if (access_ok(VERIFY_WRITE, to, n)) {
+		if (movsl_is_ok(to, from, n))
+			__copy_user(to, from, n);
+		else
+			n = __copy_user_int(to, from, n);
+	}
 	return n;
 }
 
@@ -54,10 +58,14 @@ unsigned long
 __generic_copy_from_user(void *to, const void *from, unsigned long n)
 {
 	prefetchw(to);
-	if (access_ok(VERIFY_READ, from, n))
-		__copy_user_zeroing(to,from,n);
-	else
+	if (access_ok(VERIFY_READ, from, n)) {
+		if (movsl_is_ok(to, from, n))
+			__copy_user_zeroing(to,from,n);
+		else
+			n = __copy_user_zeroing_int(to, from, n);
+	} else {
 		memset(to, 0, n);
+	}
 	return n;
 }
 
@@ -188,3 +196,195 @@ long strnlen_user(const char *s, long n)
 		:"cc");
 	return res & mask;
 }
+
+#ifdef INTEL_MOVSL
+/*
+ * Copy To/From Userspace
+ */
+
+/* Generic arbitrary sized copy.  */
+unsigned long __copy_user_int(void *to, const void *from,unsigned long size)
+{
+	int d0, d1;
+	__asm__ __volatile__(
+		       "       .align 2,0x90\n" 
+		       "0:     movl 32(%4), %%eax\n"
+		       "       cmpl $67, %0\n"     
+		       "       jbe 1f\n"            
+		       "       movl 64(%4), %%eax\n"
+		       "       .align 2,0x90\n"     
+		       "1:     movl 0(%4), %%eax\n" 
+		       "       movl 4(%4), %%edx\n" 
+		       "2:     movl %%eax, 0(%3)\n" 
+		       "21:    movl %%edx, 4(%3)\n" 
+		       "       movl 8(%4), %%eax\n" 
+		       "       movl 12(%4),%%edx\n" 
+		       "3:     movl %%eax, 8(%3)\n" 
+		       "31:    movl %%edx, 12(%3)\n"
+		       "       movl 16(%4), %%eax\n"
+		       "       movl 20(%4), %%edx\n"
+		       "4:     movl %%eax, 16(%3)\n"
+		       "41:    movl %%edx, 20(%3)\n"
+		       "       movl 24(%4), %%eax\n"
+		       "       movl 28(%4), %%edx\n"
+		       "10:    movl %%eax, 24(%3)\n"
+		       "51:    movl %%edx, 28(%3)\n"
+		       "       movl 32(%4), %%eax\n"
+		       "       movl 36(%4), %%edx\n"
+		       "11:    movl %%eax, 32(%3)\n"
+		       "61:    movl %%edx, 36(%3)\n"
+		       "       movl 40(%4), %%eax\n"
+		       "       movl 44(%4), %%edx\n"
+		       "12:    movl %%eax, 40(%3)\n"
+		       "71:    movl %%edx, 44(%3)\n"
+		       "       movl 48(%4), %%eax\n"
+		       "       movl 52(%4), %%edx\n"
+		       "13:    movl %%eax, 48(%3)\n"
+		       "81:    movl %%edx, 52(%3)\n"
+		       "       movl 56(%4), %%eax\n"
+		       "       movl 60(%4), %%edx\n"
+		       "14:    movl %%eax, 56(%3)\n"
+		       "91:    movl %%edx, 60(%3)\n"
+		       "       addl $-64, %0\n"     
+		       "       addl $64, %4\n"      
+		       "       addl $64, %3\n"      
+		       "       cmpl $63, %0\n"      
+		       "       ja  0b\n"            
+		       "5:     movl  %0, %%eax\n"   
+		       "       shrl  $2, %0\n"      
+		       "       andl  $3, %%eax\n"   
+		       "       cld\n"               
+		       "6:     rep; movsl\n"        
+		       "       movl %%eax, %0\n"    
+		       "7:     rep; movsb\n"		
+		       "8:\n"				
+		       ".section .fixup,\"ax\"\n"	
+		       "9:     lea 0(%%eax,%0,4),%0\n"	
+		       "       jmp 8b\n"		
+		       "15:    movl %6, %0\n"          
+		       "       jmp 8b\n"               
+		       ".previous\n"			
+		       ".section __ex_table,\"a\"\n"	
+		       "       .align 4\n"		
+		       "       .long 2b,15b\n"		
+		       "       .long 21b,15b\n"	
+		       "       .long 3b,15b\n"		
+		       "       .long 31b,15b\n"	
+		       "       .long 4b,15b\n"		
+		       "       .long 41b,15b\n"	
+		       "       .long 10b,15b\n"	
+		       "       .long 51b,15b\n"	
+		       "       .long 11b,15b\n"	
+		       "       .long 61b,15b\n"	
+		       "       .long 12b,15b\n"	
+		       "       .long 71b,15b\n"	
+		       "       .long 13b,15b\n"	
+		       "       .long 81b,15b\n"	
+		       "       .long 14b,15b\n"	
+		       "       .long 91b,15b\n"	
+		       "       .long 6b,9b\n"		
+		       "       .long 7b,8b\n"          
+		       ".previous"			
+		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
+		       :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)
+		       : "eax", "edx", "memory");			
+	return size;
+}
+
+unsigned long
+__copy_user_zeroing_int(void *to, const void *from, unsigned long size)
+{
+	int d0, d1;
+	__asm__ __volatile__(
+		       "        .align 2,0x90\n"
+		       "0:      movl 32(%4), %%eax\n"
+		       "        cmpl $67, %0\n"      
+		       "        jbe 2f\n"            
+		       "1:      movl 64(%4), %%eax\n"
+		       "        .align 2,0x90\n"     
+		       "2:      movl 0(%4), %%eax\n" 
+		       "21:     movl 4(%4), %%edx\n" 
+		       "        movl %%eax, 0(%3)\n" 
+		       "        movl %%edx, 4(%3)\n" 
+		       "3:      movl 8(%4), %%eax\n" 
+		       "31:     movl 12(%4),%%edx\n" 
+		       "        movl %%eax, 8(%3)\n" 
+		       "        movl %%edx, 12(%3)\n"
+		       "4:      movl 16(%4), %%eax\n"
+		       "41:     movl 20(%4), %%edx\n"
+		       "        movl %%eax, 16(%3)\n"
+		       "        movl %%edx, 20(%3)\n"
+		       "10:     movl 24(%4), %%eax\n"
+		       "51:     movl 28(%4), %%edx\n"
+		       "        movl %%eax, 24(%3)\n"
+		       "        movl %%edx, 28(%3)\n"
+		       "11:     movl 32(%4), %%eax\n"
+		       "61:     movl 36(%4), %%edx\n"
+		       "        movl %%eax, 32(%3)\n"
+		       "        movl %%edx, 36(%3)\n"
+		       "12:     movl 40(%4), %%eax\n"
+		       "71:     movl 44(%4), %%edx\n"
+		       "        movl %%eax, 40(%3)\n"
+		       "        movl %%edx, 44(%3)\n"
+		       "13:     movl 48(%4), %%eax\n"
+		       "81:     movl 52(%4), %%edx\n"
+		       "        movl %%eax, 48(%3)\n"
+		       "        movl %%edx, 52(%3)\n"
+		       "14:     movl 56(%4), %%eax\n"
+		       "91:     movl 60(%4), %%edx\n"
+		       "        movl %%eax, 56(%3)\n"
+		       "        movl %%edx, 60(%3)\n"
+		       "        addl $-64, %0\n"     
+		       "        addl $64, %4\n"      
+		       "        addl $64, %3\n"      
+		       "        cmpl $63, %0\n"      
+		       "        ja  0b\n"            
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
+		       "15:     movl %6, %0\n"  
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
+		       :  "1"(to), "2"(from), "0"(size),"i"(-EFAULT)
+		       : "eax", "edx", "memory");
+	return size;
+}
+#endif	/* INTEL_MOVSL */
--- 2.5.39/include/asm-i386/uaccess.h~intel-user-copy	Mon Sep 30 14:10:23 2002
+++ 2.5.39-akpm/include/asm-i386/uaccess.h	Mon Sep 30 15:16:37 2002
@@ -33,7 +33,33 @@
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
-extern int __verify_write(const void *, unsigned long);
+/*
+ * movsl can be slow when source and dest are not both 8-byte aligned
+ */
+#if defined(CONFIG_M586MMX) || defined(CONFIG_M686) || \
+	defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
+#define INTEL_MOVSL
+#endif
+
+#ifdef INTEL_MOVSL
+static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
+{
+	if (n < 64)
+		return 1;
+	if ((((const long)a1 | (const long)a2) & 7) == 0)
+		return 1;
+	return 0;
+}
+unsigned long __copy_user_int(void *, const void *, unsigned long);
+unsigned long __copy_user_zeroing_int(void *, const void *, unsigned long);
+#else
+static inline int movsl_is_ok(const void *a1, const void *a2, unsigned long n)
+{
+	return 1;
+}
+#endif
+
+int __verify_write(const void *, unsigned long);
 
 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()->addr_limit.seg))
 
@@ -309,14 +335,20 @@ do {									\
 static inline unsigned long
 __generic_copy_from_user_nocheck(void *to, const void *from, unsigned long n)
 {
-	__copy_user_zeroing(to,from,n);
+	if (movsl_is_ok(to, from, n))
+		__copy_user_zeroing(to, from, n);
+	else
+		n = __copy_user_zeroing_int(to, from, n);
 	return n;
 }
 
 static inline unsigned long
 __generic_copy_to_user_nocheck(void *to, const void *from, unsigned long n)
 {
-	__copy_user(to,from,n);
+	if (movsl_is_ok(to, from, n))
+		__copy_user(to, from, n);
+	else
+		n = __copy_user_int(to, from, n);
 	return n;
 }
 
@@ -578,24 +610,16 @@ __constant_copy_from_user_nocheck(void *
 }
 
 #define copy_to_user(to,from,n)				\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_to_user((to),(from),(n)) :	\
-	 __generic_copy_to_user((to),(from),(n)))
+	 __generic_copy_to_user((to),(from),(n))
 
 #define copy_from_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_from_user((to),(from),(n)) :	\
-	 __generic_copy_from_user((to),(from),(n)))
+	 __generic_copy_from_user((to),(from),(n))
 
 #define __copy_to_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_to_user_nocheck((to),(from),(n)) :	\
-	 __generic_copy_to_user_nocheck((to),(from),(n)))
+	 __generic_copy_to_user_nocheck((to),(from),(n))
 
 #define __copy_from_user(to,from,n)			\
-	(__builtin_constant_p(n) ?			\
-	 __constant_copy_from_user_nocheck((to),(from),(n)) :	\
-	 __generic_copy_from_user_nocheck((to),(from),(n)))
+	 __generic_copy_from_user_nocheck((to),(from),(n))
 
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
--- 2.5.39/arch/i386/kernel/i386_ksyms.c~intel-user-copy	Mon Sep 30 14:55:22 2002
+++ 2.5.39-akpm/arch/i386/kernel/i386_ksyms.c	Mon Sep 30 15:11:13 2002
@@ -111,6 +111,10 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__generic_copy_from_user);
 EXPORT_SYMBOL(__generic_copy_to_user);
 EXPORT_SYMBOL(strnlen_user);
+#ifdef INTEL_MOVSL
+EXPORT_SYMBOL(__copy_user_int);
+EXPORT_SYMBOL(__copy_user_zeroing_int);
+#endif
 
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);

.
