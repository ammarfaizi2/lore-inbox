Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSA3LmF>; Wed, 30 Jan 2002 06:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSA3Ll4>; Wed, 30 Jan 2002 06:41:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:6163 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289116AbSA3Llt>;
	Wed, 30 Jan 2002 06:41:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.18-pre7 out of line lock code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Jan 2002 22:41:32 +1100
Message-ID: <30289.1012390892@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus pointed out that the out of line lock code is repetitive and can
be abstracted.  The result is more readable and allows for disabling of
out of line code if that should ever become desirable.  It builds for
me on i386, other arch maintainers need to eyeball their bits before
this patch goes to Marcelo.

Note: the generated code must be identical to 2.4.18-pre7, this is
purely an abstraction cleanup.

Index: 18-pre7.1/include/linux/spinlock.h
--- 18-pre7.1/include/linux/spinlock.h Fri, 12 Oct 2001 11:40:38 +1000 kaos (linux-2.4/X/48_spinlock.h 1.1.2.1.1.2 644)
+++ 18-pre7.1(w)/include/linux/spinlock.h Wed, 30 Jan 2002 22:18:05 +1100 kaos (linux-2.4/X/48_spinlock.h 1.1.2.1.1.2 644)
@@ -35,6 +35,23 @@
 						if (!__r) local_bh_enable();   \
 						__r; })
 
+/* Must define these before including other files, inline functions need them */
+
+#include <linux/stringify.h>
+
+#define LOCK_SECTION_NAME			\
+	".text.lock." __stringify(KBUILD_BASENAME)
+
+#define LOCK_SECTION_START(extra)		\
+	".subsection 1\n\t"			\
+	extra					\
+	".ifndef " LOCK_SECTION_NAME "\n\t"	\
+	LOCK_SECTION_NAME ":\n\t"		\
+	".endif\n\t"
+
+#define LOCK_SECTION_END			\
+	".previous\n\t"
+
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
Index: 18-pre7.1/include/asm-m68k/semaphore.h
--- 18-pre7.1/include/asm-m68k/semaphore.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/N/2_semaphore. 1.1.1.1.1.1.1.1 644)
+++ 18-pre7.1(w)/include/asm-m68k/semaphore.h Wed, 30 Jan 2002 22:17:50 +1100 kaos (linux-2.4/N/2_semaphore. 1.1.1.1.1.1.1.1 644)
@@ -9,7 +9,6 @@
 #include <linux/wait.h>
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
-#include <linux/stringify.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -95,14 +94,10 @@ extern inline void down(struct semaphore
 		"subql #1,%0@\n\t"
 		"jmi 2f\n\t"
 		"1:\n"
-		".subsection 1\n"
-		".even\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START(".even\n\t")
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		: /* no outputs */
 		: "a" (sem1)
 		: "memory");
@@ -123,14 +118,10 @@ extern inline int down_interruptible(str
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".subsection 1\n"
-		".even\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START(".even\n\t")
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_interruptible\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		: "=d" (result)
 		: "a" (sem1)
 		: "memory");
@@ -152,14 +143,10 @@ extern inline int down_trylock(struct se
 		"jmi 2f\n\t"
 		"clrl %0\n"
 		"1:\n"
-		".subsection 1\n"
-		".even\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START(".even\n\t")
 		"2:\tpea 1b\n\t"
 		"jbra __down_failed_trylock\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		: "=d" (result)
 		: "a" (sem1)
 		: "memory");
@@ -185,15 +172,11 @@ extern inline void up(struct semaphore *
 		"addql #1,%0@\n\t"
 		"jle 2f\n"
 		"1:\n"
-		".subsection 1\n"
-		".even\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START(".even\n\t")
 		"2:\t"
 		"pea 1b\n\t"
 		"jbra __up_wakeup\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		: /* no outputs */
 		: "a" (sem1)
 		: "memory");
Index: 18-pre7.1/include/asm-i386/rwlock.h
--- 18-pre7.1/include/asm-i386/rwlock.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/T/20_rwlock.h 1.1.1.1 644)
+++ 18-pre7.1(w)/include/asm-i386/rwlock.h Wed, 30 Jan 2002 22:17:01 +1100 kaos (linux-2.4/T/20_rwlock.h 1.1.1.1 644)
@@ -17,8 +17,6 @@
 #ifndef _ASM_I386_RWLOCK_H
 #define _ASM_I386_RWLOCK_H
 
-#include <linux/stringify.h>
-
 #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
@@ -26,29 +24,23 @@
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
+		     LOCK_SECTION_START("") \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".subsection 0\n" \
+		     LOCK_SECTION_END \
 		     ::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
+		     LOCK_SECTION_START("") \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".subsection 0\n" \
+		     LOCK_SECTION_END \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
@@ -62,29 +54,23 @@
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
+		     LOCK_SECTION_START("") \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
-		     ".subsection 0\n" \
+		     LOCK_SECTION_END \
 		     ::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
+		     LOCK_SECTION_START("") \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
 		     "popl %%eax\n\t" \
 		     "jmp 1b\n" \
-		     ".subsection 0\n" \
+		     LOCK_SECTION_END \
 		     :"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
Index: 18-pre7.1/include/asm-i386/spinlock.h
--- 18-pre7.1/include/asm-i386/spinlock.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/T/50_spinlock.h 1.1.2.2.1.1 644)
+++ 18-pre7.1(w)/include/asm-i386/spinlock.h Wed, 30 Jan 2002 22:17:08 +1100 kaos (linux-2.4/T/50_spinlock.h 1.1.2.2.1.1 644)
@@ -5,7 +5,6 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 #include <linux/config.h>
-#include <linux/stringify.h>
 
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
@@ -57,16 +56,13 @@ typedef struct {
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
-	".subsection 1\n" \
-	".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-	"_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-	".endif\n" \
+	LOCK_SECTION_START("") \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
 	"jle 2b\n\t" \
 	"jmp 1b\n" \
-	".subsection 0\n"
+	LOCK_SECTION_END
 
 /*
  * This works. Despite all the confusion.
Index: 18-pre7.1/include/asm-i386/softirq.h
--- 18-pre7.1/include/asm-i386/softirq.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/T/51_softirq.h 1.8.1.1.1.1 644)
+++ 18-pre7.1(w)/include/asm-i386/softirq.h Wed, 30 Jan 2002 22:27:31 +1100 kaos (linux-2.4/T/51_softirq.h 1.8.1.1.1.1 644)
@@ -3,7 +3,6 @@
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
-#include <linux/stringify.h>
 
 #define __cpu_bh_enable(cpu) \
 		do { barrier(); local_bh_count(cpu)--; } while (0)
@@ -34,15 +33,12 @@ do {									\
 			"jnz 2f;"					\
 			"1:;"						\
 									\
-			".subsection 1;"				\
-			".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"		\
-			"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"		\
-			".endif\n"					\
+			LOCK_SECTION_START("")				\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
 			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
 			"jmp 1b;"					\
-			".subsection 0;"				\
+			LOCK_SECTION_END				\
 									\
 		: /* no output */					\
 		: "r" (ptr), "i" (do_softirq)				\
Index: 18-pre7.1/include/asm-i386/semaphore.h
--- 18-pre7.1/include/asm-i386/semaphore.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/U/13_semaphore. 1.1.1.3.1.1 644)
+++ 18-pre7.1(w)/include/asm-i386/semaphore.h Wed, 30 Jan 2002 22:29:27 +1100 kaos (linux-2.4/U/13_semaphore. 1.1.1.3.1.1 644)
@@ -40,7 +40,6 @@
 #include <asm/atomic.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
-#include <linux/stringify.h>
 
 struct semaphore {
 	atomic_t count;
@@ -123,13 +122,10 @@ static inline void down(struct semaphore
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		:"=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -153,13 +149,10 @@ static inline int down_interruptible(str
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -184,13 +177,10 @@ static inline int down_trylock(struct se
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		:"=a" (result), "=m" (sem->count)
 		:"c" (sem)
 		:"memory");
@@ -213,12 +203,10 @@ static inline void up(struct semaphore *
 		LOCK "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
+		LOCK_SECTION_END
 		".subsection 0\n"
 		:"=m" (sem->count)
 		:"c" (sem)
Index: 18-pre7.1/include/asm-i386/rwsem.h
--- 18-pre7.1/include/asm-i386/rwsem.h Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/K/d/10_rwsem.h 1.5.1.1 644)
+++ 18-pre7.1(w)/include/asm-i386/rwsem.h Wed, 30 Jan 2002 22:18:10 +1100 kaos (linux-2.4/K/d/10_rwsem.h 1.5.1.1 644)
@@ -40,7 +40,6 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
-#include <linux/stringify.h>
 
 struct rwsem_waiter;
 
@@ -102,10 +101,7 @@ static inline void __down_read(struct rw
 LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
@@ -113,7 +109,7 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
 		"  popl      %%edx\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		"# ending down_read\n\t"
 		: "+m"(sem->count)
 		: "a"(sem)
@@ -134,16 +130,13 @@ LOCK_PREFIX	"  xadd      %0,(%%eax)\n\t"
 		"  testl     %0,%0\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_down_write_failed\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		"# ending down_write"
 		: "+d"(tmp), "+m"(sem->count)
 		: "a"(sem)
@@ -161,10 +154,7 @@ static inline void __up_read(struct rw_s
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
@@ -172,7 +162,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		"# ending __up_read\n"
 		: "+m"(sem->count), "+d"(tmp)
 		: "a"(sem)
@@ -190,10 +180,7 @@ static inline void __up_write(struct rw_
 LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
+		LOCK_SECTION_START("")
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
@@ -201,7 +188,7 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n
 		"  call      rwsem_wake\n\t"
 		"  popl      %%ecx\n\t"
 		"  jmp       1b\n"
-		".subsection 0\n"
+		LOCK_SECTION_END
 		"# ending __up_write\n"
 		: "+m"(sem->count)
 		: "a"(sem), "i"(-RWSEM_ACTIVE_WRITE_BIAS)

