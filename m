Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRFKRho>; Mon, 11 Jun 2001 13:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbRFKRhf>; Mon, 11 Jun 2001 13:37:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32884 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261473AbRFKRh2>; Mon, 11 Jun 2001 13:37:28 -0400
Date: Mon, 11 Jun 2001 19:37:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: softirq bugs in pre2
Message-ID: <20010611193703.S5468@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in pre2 ret_from_exception reschedule and handle signals even if it is
returning to kernel code. rescheduling was not so obviously broken (at
least not for the page fault ;) but it just slowdown the code as I just
have all the necessary explicit checks in copy-user itself (which are
needed anyways exactly because there may not be any page fault).

diff -urN 2.4.6pre2/arch/i386/kernel/entry.S softirq-smp-fixes/arch/i386/kernel/entry.S
--- 2.4.6pre2/arch/i386/kernel/entry.S	Sat Jun  9 00:04:47 2001
+++ softirq-smp-fixes/arch/i386/kernel/entry.S	Mon Jun 11 19:25:06 2001
@@ -246,16 +246,9 @@
 	jmp ret_from_sys_call
 
 	ALIGN
-ret_from_exception:
-	cli
-	cmpl $0,need_resched(%ebx)
-	jne reschedule
-	cmpl $0,sigpending(%ebx)
-	jne signal_return
-	jmp restore_all
-
 ENTRY(ret_from_intr)
 	GET_CURRENT(%ebx)
+ret_from_exception:
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
 	movb CS(%esp),%al
 	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
@@ -313,14 +306,16 @@
 	pushl $-1		# mark this as an int
 	SAVE_ALL
 	GET_CURRENT(%ebx)
-	pushl $ret_from_exception
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
-	je SYMBOL_NAME(math_state_restore)
+	jne device_not_available_emulate
+	call SYMBOL_NAME(math_state_restore)
+	jmp ret_from_exception
+device_not_available_emulate:
 	pushl $0		# temporary storage for ORIG_EIP
 	call  SYMBOL_NAME(math_emulate)
 	addl $4,%esp
-	ret
+	jmp ret_from_exception
 
 ENTRY(debug)
 	pushl $0

(side note, I also removed the call prediction invalidation so fpu
restore is faster)

Since I mentioned the copy-user latency fixes (even if offtopic with the
above) this is the URL for trivial merging:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_copy-user-lat-2

00_copy-user-lat-2:

diff -urN 2.4.4/arch/i386/lib/usercopy.c lowlat/arch/i386/lib/usercopy.c
--- 2.4.4/arch/i386/lib/usercopy.c	Sat Apr 28 05:24:30 2001
+++ lowlat/arch/i386/lib/usercopy.c	Sun Apr 29 18:33:13 2001
@@ -6,6 +6,7 @@
  * Copyright 1997 Linus Torvalds
  */
 #include <linux/config.h>
+#include <linux/condsched.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -91,6 +92,7 @@
 		  "=&D" (__d2)						   \
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src), "4"(dst) \
 		: "memory");						   \
+	conditional_schedule();						   \
 } while (0)
 
 long
@@ -134,6 +136,7 @@
 		".previous"						\
 		: "=&c"(size), "=&D" (__d0)				\
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
+	conditional_schedule();						\
 } while (0)
 
 unsigned long
@@ -180,5 +183,6 @@
 		:"=r" (n), "=D" (s), "=a" (res), "=c" (tmp)
 		:"0" (n), "1" (s), "2" (0), "3" (mask)
 		:"cc");
+	conditional_schedule();
 	return res & mask;
 }
diff -urN 2.4.4/include/asm-alpha/uaccess.h lowlat/include/asm-alpha/uaccess.h
--- 2.4.4/include/asm-alpha/uaccess.h	Sun Apr  1 20:11:14 2001
+++ lowlat/include/asm-alpha/uaccess.h	Sun Apr 29 18:33:15 2001
@@ -3,6 +3,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/condsched.h>
 
 
 /*
@@ -384,19 +385,36 @@
 	return len;
 }
 
-#define __copy_to_user(to,from,n)   __copy_tofrom_user_nocheck((to),(from),(n))
-#define __copy_from_user(to,from,n) __copy_tofrom_user_nocheck((to),(from),(n))
+static inline long
+__copy_to_user(void *to, const void *from, long n)
+{
+	n = __copy_tofrom_user_nocheck(to, from, n);
+	conditional_schedule();
+	return n;
+}
+
+static inline long
+__copy_from_user(void *to, const void *from, long n)
+{
+	n = __copy_tofrom_user_nocheck(to, from, n);
+	conditional_schedule();
+	return n;
+}
 
 extern inline long
 copy_to_user(void *to, const void *from, long n)
 {
-	return __copy_tofrom_user(to, from, n, to);
+	n = __copy_tofrom_user(to, from, n, to);
+	conditional_schedule();
+	return n;
 }
 
 extern inline long
 copy_from_user(void *to, const void *from, long n)
 {
-	return __copy_tofrom_user(to, from, n, from);
+	n = __copy_tofrom_user(to, from, n, from);
+	conditional_schedule();
+	return n;
 }
 
 extern void __do_clear_user(void);
@@ -434,6 +452,7 @@
 			: "$1","$2","$3","$4","$5","$28","memory");
 		len = __cl_len;
 	}
+	conditional_schedule();
 	return len;
 }
 
@@ -448,6 +467,7 @@
 	long ret = -EFAULT;
 	if (__access_ok((long)from, 0, get_fs()))
 		ret = __strncpy_from_user(to, from, n);
+	conditional_schedule();
 	return ret;
 }
 
@@ -456,7 +476,11 @@
 
 extern inline long strlen_user(const char *str)
 {
-	return access_ok(VERIFY_READ,str,0) ? __strlen_user(str) : 0;
+	long ret = 0;
+	if (access_ok(VERIFY_READ,str,0))
+		ret = __strlen_user(str);
+	conditional_schedule();
+	return ret;
 }
 
 /* Returns: 0 if exception before NUL or reaching the supplied limit (N),
@@ -465,7 +489,11 @@
 
 extern inline long strnlen_user(const char *str, long n)
 {
-	return access_ok(VERIFY_READ,str,0) ? __strnlen_user(str, n) : 0;
+	long ret = 0;
+	if (access_ok(VERIFY_READ,str,0))
+		ret = __strnlen_user(str, n);
+	conditional_schedule();
+	return ret;
 }
 
 /*
diff -urN 2.4.4/include/asm-i386/uaccess.h lowlat/include/asm-i386/uaccess.h
--- 2.4.4/include/asm-i386/uaccess.h	Sat Apr 28 05:24:45 2001
+++ lowlat/include/asm-i386/uaccess.h	Sun Apr 29 18:33:13 2001
@@ -6,6 +6,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/condsched.h>
 #include <asm/page.h>
 
 #define VERIFY_READ 0
@@ -258,6 +259,7 @@
 		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
 		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
 		: "memory");						\
+	conditional_schedule();						\
 } while (0)
 
 #define __copy_user_zeroing(to,from,size)				\
@@ -286,6 +288,7 @@
 		: "=&c"(size), "=&D" (__d0), "=&S" (__d1)		\
 		: "r"(size & 3), "0"(size / 4), "1"(to), "2"(from)	\
 		: "memory");						\
+	conditional_schedule();						\
 } while (0)
 
 /* We let the __ versions of copy_from/to_user inline, because they're often
@@ -326,6 +329,7 @@
 			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
+		conditional_schedule();				\
 		break;						\
 	case 1:							\
 		__asm__ __volatile__(				\
@@ -416,6 +420,7 @@
 			: "=c"(size), "=&S" (__d0), "=&D" (__d1)\
 			: "1"(from), "2"(to), "0"(size/4)	\
 			: "memory");				\
+		conditional_schedule();				\
 		break;						\
 	case 1:							\
 		__asm__ __volatile__(				\
diff -urN 2.4.4/include/linux/condsched.h lowlat/include/linux/condsched.h
--- 2.4.4/include/linux/condsched.h	Thu Jan  1 01:00:00 1970
+++ lowlat/include/linux/condsched.h	Sun Apr 29 18:33:13 2001
@@ -0,0 +1,14 @@
+#ifndef _LINUX_CONDSCHED_H
+#define _LINUX_CONDSCHED_H
+
+#ifndef __ASSEMBLY__
+#define conditional_schedule() \
+do { \
+	if (current->need_resched) { \
+		current->state = TASK_RUNNING; \
+		schedule(); \
+	} \
+} while(0)
+#endif
+
+#endif



Andrea
