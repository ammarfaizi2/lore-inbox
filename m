Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUDTRm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUDTRm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbUDTRm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:42:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:58276 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263028AbUDTRmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:42:03 -0400
Date: Tue, 20 Apr 2004 18:41:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chris@scary.beasts.org, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add 64-bit get_user and __get_user for i386
Message-ID: <20040420174147.GA20924@mail.shareable.org>
References: <20040420020922.GA18348@mail.shareable.org> <Pine.LNX.4.58.0404191945490.29941@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404191945490.29941@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 20 Apr 2004, Jamie Lokier wrote:
> > Changed the registers for all __get_user_X so they could all be
> > consistent: %ecx now contains the address, and %eax or %edx:%eax
> > contain the result.
> 
> This clobbers unnecessary registers. You now use three registers instead 
> of just two.

Wrong.  It uses two registers for the 1/2/4-byte cases (%ecx and %eax).
It uses three for 8-byte, which is necessary: 8-byte result + error code.

That's achieved by using different asm output constraints: "=a" for
1/2/4 bytes and "=A" for 8 bytes.

> > There was a boundary bug in getuser.S: get_user(x,(char *)0xbfffffff)
> > would fail.  Fixed.
> 
> Hmm. I'll believe you.

Just look, it's obvious.  This is the old code 

__get_user_4:
	addl $3,%eax
	jc bad_get_user
	GET_THREAD_INFO(%edx)
	cmpl TI_ADDR_LIMIT(%edx),%eax
	jae bad_get_user

Change "jae" to "ja" and it's fine.  (x86_64 has copied this bug).

> > +/*
> > + * Careful: we have to cast the result to the type of the pointer for
> > + * sign reasons.
> > + */
> ...
> > +	__typeof__(*(ptr)) __gu_val;					\
> ...
> > +	(x) = (__typeof__(*(ptr)))__gu_val;				\
> 
> And exactly why do you want to cast the value to a type that it already 
> has?

Well spotted.  It's an artifact of experiments with __gu_val being
long, long long etc. for various sizes of get_user() and seeing
unusual warnings when *ptr and/or x are pointers.

Patch re-rolled.  The only change is the removal of that cast,
and a clarifying comment in getuser.S.

I've checked it compiles to identical code.

Enjoy,
-- Jamie


Subject: [PATCH] Add 64-bit get_user and __get_user for i386
Patch: uaccess64-2.6.5-jl4
 
Added 64-bit get_user and __get_user for i386.
 
Changed the registers for all __get_user_X so they could all be
consistent: %ecx now contains the address, and %eax or %edx:%eax
contain the result.
 
There was a boundary bug in getuser.S: get_user(x,(char *)0xbfffffff)
would fail.  Fixed.
 
Added might_sleep() to get_user().
 
Added the 8-byte constant-length cases for __copy_from_user() and
__copy_to_user().

Changed constant-length short copy_from_user() to be out of line (it was
inline), as this is just another way to write get_user().  It calls the
same routines as get_user() and one test showed equivalent uses now
generate identical code (sendfile64).  Constant-length
__copy_from_user() remains inline, just like __get_user().
 
Very slight cosmetic moving of a few definitions into a more
consistent arrangement.
 
This patch shaved about 1.2k off my kernel, due to the un-inlining of
copy_from_user() calls which are equivalent to get_user().



diff -urN --exclude-from=dontdiff dual-2.6.5/arch/i386/kernel/i386_ksyms.c uaccess64-2.6.5/arch/i386/kernel/i386_ksyms.c
--- dual-2.6.5/arch/i386/kernel/i386_ksyms.c	2004-04-14 08:28:07.000000000 +0100
+++ uaccess64-2.6.5/arch/i386/kernel/i386_ksyms.c	2004-04-20 01:55:10.000000000 +0100
@@ -103,6 +103,7 @@
 EXPORT_SYMBOL_NOVERS(__get_user_1);
 EXPORT_SYMBOL_NOVERS(__get_user_2);
 EXPORT_SYMBOL_NOVERS(__get_user_4);
+EXPORT_SYMBOL_NOVERS(__get_user_8);
 
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
diff -urN --exclude-from=dontdiff dual-2.6.5/arch/i386/lib/getuser.S uaccess64-2.6.5/arch/i386/lib/getuser.S
--- dual-2.6.5/arch/i386/lib/getuser.S	2003-12-18 02:57:59.000000000 +0000
+++ uaccess64-2.6.5/arch/i386/lib/getuser.S	2004-04-20 18:15:24.000000000 +0100
@@ -14,10 +14,11 @@
 /*
  * __get_user_X
  *
- * Inputs:	%eax contains the address
+ * Inputs:	%ecx contains the address
  *
- * Outputs:	%eax is error code (0 or -EFAULT)
- *		%edx contains zero-extended value
+ * Outputs:	%ecx is error code (0 or -EFAULT)
+ *		%eax contains zero-extended value
+ *		%edx is high part of 64 bit result, or preserved if <= 32 bits
  *
  * These functions should not modify any other registers,
  * as they get called from within inline assembly.
@@ -27,44 +28,61 @@
 .align 4
 .globl __get_user_1
 __get_user_1:
-	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
-1:	movzbl (%eax),%edx
-	xorl %eax,%eax
+	GET_THREAD_INFO(%eax)
+	cmpl TI_ADDR_LIMIT(%eax),%ecx
+	ja bad_get_user
+1:	movzbl (%ecx),%eax
+	xorl %ecx,%ecx
 	ret
 
 .align 4
 .globl __get_user_2
 __get_user_2:
-	addl $1,%eax
+	addl $1,%ecx
 	jc bad_get_user
-	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
-2:	movzwl -1(%eax),%edx
-	xorl %eax,%eax
+	GET_THREAD_INFO(%eax)
+	cmpl TI_ADDR_LIMIT(%eax),%ecx
+	ja bad_get_user
+2:	movzwl -1(%ecx),%eax
+	xorl %ecx,%ecx
 	ret
 
 .align 4
 .globl __get_user_4
 __get_user_4:
-	addl $3,%eax
+	addl $3,%ecx
 	jc bad_get_user
-	GET_THREAD_INFO(%edx)
-	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
-3:	movl -3(%eax),%edx
-	xorl %eax,%eax
+	GET_THREAD_INFO(%eax)
+	cmpl TI_ADDR_LIMIT(%eax),%ecx
+	ja bad_get_user
+3:	movl -3(%ecx),%eax
+	xorl %ecx,%ecx
 	ret
 
-bad_get_user:
+.align 4
+.globl __get_user_8
+__get_user_8:
+	addl $7,%ecx
+	jc bad_get_user_8
+	GET_THREAD_INFO(%eax)
+	cmpl TI_ADDR_LIMIT(%eax),%ecx
+	ja bad_get_user_8
+4:	movl -7(%ecx),%eax
+5:	movl -3(%ecx),%edx
+	xorl %ecx,%ecx
+	ret
+
+bad_get_user_8:
 	xorl %edx,%edx
-	movl $-14,%eax
+bad_get_user:
+	xorl %eax,%eax
+	movl $-14,%ecx
 	ret
 
 .section __ex_table,"a"
 	.long 1b,bad_get_user
 	.long 2b,bad_get_user
 	.long 3b,bad_get_user
+	.long 4b,bad_get_user_8
+	.long 5b,bad_get_user_8
 .previous
diff -urN --exclude-from=dontdiff dual-2.6.5/include/asm-i386/uaccess.h uaccess64-2.6.5/include/asm-i386/uaccess.h
--- dual-2.6.5/include/asm-i386/uaccess.h	2003-12-18 02:58:16.000000000 +0000
+++ uaccess64-2.6.5/include/asm-i386/uaccess.h	2004-04-20 17:49:53.000000000 +0100
@@ -140,17 +140,7 @@
  * accesses to the same area of user memory).
  */
 
-extern void __get_user_1(void);
-extern void __get_user_2(void);
-extern void __get_user_4(void);
-
-#define __get_user_x(size,ret,x,ptr) \
-	__asm__ __volatile__("call __get_user_" #size \
-		:"=a" (ret),"=d" (x) \
-		:"0" (ptr))
-
 
-/* Careful: we have to cast the result to the type of the pointer for sign reasons */
 /**
  * get_user: - Get a simple variable from user space.
  * @x:   Variable to store result.
@@ -168,19 +158,36 @@
  * Returns zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
+/*
+ * Careful: we have to cast the result to the type of the pointer for
+ * sign reasons.
+ */
 #define get_user(x,ptr)							\
-({	int __ret_gu,__val_gu;						\
+({									\
+	__typeof__(*(ptr)) __gu_val;					\
+	int __gu_err;							\
+	might_sleep();							\
 	switch(sizeof (*(ptr))) {					\
-	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
-	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
-	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		\
-	default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;		\
+	case 1: __get_user_x(1,__gu_val,ptr,__gu_err,"=a"); break;	\
+	case 2: __get_user_x(2,__gu_val,ptr,__gu_err,"=a"); break;	\
+	case 4: __get_user_x(4,__gu_val,ptr,__gu_err,"=a"); break;	\
+	case 8: __get_user_x(8,__gu_val,ptr,__gu_err,"=A"); break;	\
+	default: __get_user_bad(); __gu_val = 0; __gu_err = 0;		\
 	}								\
-	(x) = (__typeof__(*(ptr)))__val_gu;				\
-	__ret_gu;							\
+	(x) = __gu_val;							\
+	__gu_err;							\
 })
 
-extern void __put_user_bad(void);
+extern void __get_user_1(void);
+extern void __get_user_2(void);
+extern void __get_user_4(void);
+extern void __get_user_8(void);
+
+#define __get_user_x(size, x, ptr, err, rtype)		\
+	__asm__ __volatile__("call __get_user_" #size	\
+		: "=c" (err), rtype (x)			\
+		: "0" (ptr));
+
 
 /**
  * put_user: - Write a simple value into user space.
@@ -255,33 +262,17 @@
 	__pu_err;						\
 })
 
-
 #define __put_user_check(x,ptr,size)					\
 ({									\
 	long __pu_err = -EFAULT;					\
 	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
-	might_sleep();						\
+	might_sleep();							\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
 	__pu_err;							\
 })							
 
-#define __put_user_u64(x, addr, err)				\
-	__asm__ __volatile__(					\
-		"1:	movl %%eax,0(%2)\n"			\
-		"2:	movl %%edx,4(%2)\n"			\
-		"3:\n"						\
-		".section .fixup,\"ax\"\n"			\
-		"4:	movl %3,%0\n"				\
-		"	jmp 3b\n"				\
-		".previous\n"					\
-		".section __ex_table,\"a\"\n"			\
-		"	.align 4\n"				\
-		"	.long 1b,4b\n"				\
-		"	.long 2b,4b\n"				\
-		".previous"					\
-		: "=r"(err)					\
-		: "A" (x), "r" (addr), "i"(-EFAULT), "0"(err))
+extern void __put_user_bad(void);
 
 #ifdef CONFIG_X86_WP_WORKS_OK
 
@@ -292,8 +283,8 @@
 	case 1: __put_user_asm(x,ptr,retval,"b","b","iq",errret);break;	\
 	case 2: __put_user_asm(x,ptr,retval,"w","w","ir",errret);break; \
 	case 4: __put_user_asm(x,ptr,retval,"l","","ir",errret); break;	\
-	case 8: __put_user_u64((__typeof__(*ptr))(x),ptr,retval); break;\
-	  default: __put_user_bad();					\
+	case 8: __put_user_u64(x,ptr,retval,errret); break;		\
+	default: __put_user_bad();					\
 	}								\
 } while (0)
 
@@ -301,7 +292,7 @@
 
 #define __put_user_size(x,ptr,size,retval,errret)			\
 do {									\
-	__typeof__(*(ptr)) __pus_tmp = x;				\
+	__typeof__(*(ptr)) __pus_tmp = (x);				\
 	retval = 0;							\
 									\
 	if(unlikely(__copy_to_user_ll(ptr, &__pus_tmp, size) != 0))	\
@@ -332,12 +323,31 @@
 		: "=r"(err)						\
 		: ltype (x), "m"(__m(addr)), "i"(errret), "0"(err))
 
+#define __put_user_u64(x, addr, err, errret)				\
+	__asm__ __volatile__(						\
+		"1:	movl %%eax,%2\n"				\
+		"2:	movl %%edx,%3\n"				\
+		"3:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"4:	movl %4,%0\n"					\
+		"	jmp 3b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 1b,4b\n"					\
+		"	.long 2b,4b\n"					\
+		".previous"						\
+		: "=r" (err)						\
+		: "A" (x), "m" (__m(addr)), "m" (__m(4+(char*)addr)),	\
+		  "i" (errret), "0" (err))
+
 
 #define __get_user_nocheck(x,ptr,size)				\
 ({								\
-	long __gu_err, __gu_val;				\
+	__typeof__(*(ptr)) __gu_val;				\
+	int __gu_err;						\
 	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);\
-	(x) = (__typeof__(*(ptr)))__gu_val;			\
+	(x) = __gu_val;						\
 	__gu_err;						\
 })
 
@@ -350,7 +360,8 @@
 	case 1: __get_user_asm(x,ptr,retval,"b","b","=q",errret);break;	\
 	case 2: __get_user_asm(x,ptr,retval,"w","w","=r",errret);break;	\
 	case 4: __get_user_asm(x,ptr,retval,"l","","=r",errret);break;	\
-	default: (x) = __get_user_bad();				\
+	case 8: __get_user_u64(x,ptr,retval,errret);break;		\
+	default: __get_user_bad(); (x) = 0;				\
 	}								\
 } while (0)
 
@@ -370,6 +381,26 @@
 		: "=r"(err), ltype (x)					\
 		: "m"(__m(addr)), "i"(errret), "0"(err))
 
+#define __get_user_u64(x, addr, err, errret)				\
+	__asm__ __volatile__(						\
+		"1:	movl %2,%%eax\n"				\
+		"2:	movl %3,%%edx\n"				\
+		"3:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"4:	movl %4,%0\n"					\
+		"	xorl %%eax,%%eax\n"				\
+		"	xorl %%edx,%%edx\n"				\
+		"	jmp 3b\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.align 4\n"					\
+		"	.long 1b,4b\n"					\
+		"	.long 2b,4b\n"					\
+		".previous"						\
+		: "=r" (err), "=A" (x)					\
+		: "m" (__m(addr)), "m" (__m(4+(char*)addr)),		\
+		  "i" (errret), "0" (err));
+
 
 unsigned long __copy_to_user_ll(void __user *to, const void *from, unsigned long n);
 unsigned long __copy_from_user_ll(void *to, const void __user *from, unsigned long n);
@@ -411,6 +442,9 @@
 		case 4:
 			__put_user_size(*(u32 *)from, (u32 *)to, 4, ret, 4);
 			return ret;
+		case 8:
+			__put_user_size(*(u64 *)from, (u64 *)to, 8, ret, 8);
+			return ret;
 		}
 	}
 	return __copy_to_user_ll(to, from, n);
@@ -449,6 +483,9 @@
 		case 4:
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
 			return ret;
+		case 8:
+			__get_user_size(*(u64 *)to, from, 8, ret, 8);
+			return ret;
 		}
 	}
 	return __copy_from_user_ll(to, from, n);
@@ -496,8 +533,24 @@
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
+	if (__builtin_constant_p(n)) {
+		switch (n) {
+		case 1:
+			__get_user_x(1, *(u8 *)to, from, n, "=a");
+			return n ? 1 : 0;
+		case 2:
+			__get_user_x(2, *(u16 *)to, from, n, "=a");
+			return n ? 2 : 0;
+		case 4:
+			__get_user_x(4, *(u32 *)to, from, n, "=a");
+			return n ? 4 : 0;
+		case 8:
+			__get_user_x(8, *(u64 *)to, from, n, "=A");
+			return n ? 8 : 0;
+		}
+	}
 	if (access_ok(VERIFY_READ, from, n))
-		n = __copy_from_user(to, from, n);
+		n = __copy_from_user_ll(to, from, n);
 	else
 		memset(to, 0, n);
 	return n;
