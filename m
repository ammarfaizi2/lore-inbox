Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157476-27302>; Sat, 30 Jan 1999 21:46:26 -0500
Received: by vger.rutgers.edu id <157503-27302>; Sat, 30 Jan 1999 21:46:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20842 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157476-27300>; Sat, 30 Jan 1999 21:45:49 -0500
Date: Sun, 31 Jan 1999 03:04:55 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
To: Tim Waugh <tim@cyberelk.demon.co.uk>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [patch] down_norecurse(), down_interruptible_norecurse(), up_norecurse()
In-Reply-To: <Pine.LNX.3.96.990131012137.303A-100000@laser.bogus>
Message-ID: <Pine.LNX.3.96.990131030435.10544B-100000@laser.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 31 Jan 1999, Andrea Arcangeli wrote:

> initialized to 1 (as a mutex unlocked), but agreed, SEMAPHORE(x) looks a
> better name for the norecursive semaphore initializer. 

Does this looks better to you?

Index: include/asm-i386/semaphore.h
===================================================================
RCS file: /var/cvs/linux/include/asm-i386/semaphore.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 semaphore.h
--- semaphore.h	1999/01/18 13:39:43	1.1.1.2
+++ linux/include/asm-i386/semaphore.h	1999/01/31 02:03:27
@@ -47,11 +47,17 @@
  * Other (saner) architectures would use "wmb()" and "rmb()" to
  * do this in a more obvious manner.
  */
-struct semaphore {
-	atomic_t count;
-	unsigned long owner, owner_depth;
-	int waking;
+#define STRUCT_SEMAPHORE			\
+	atomic_t count;				\
+	unsigned long owner, owner_depth;	\
+	int waking;				\
 	struct wait_queue * wait;
+
+struct semaphore {
+	STRUCT_SEMAPHORE
+};
+struct semaphore_norecurse {
+	STRUCT_SEMAPHORE
 };
 
 /*
@@ -62,10 +68,11 @@
  * operation into the slow path.
  */
 #define semaphore_owner(sem) \
-	((struct task_struct *)((2*PAGE_MASK) & (sem)->owner))
+	((struct task_struct *)(((PAGE_SIZE<<1)-1) & (sem)->owner))
 
 #define MUTEX ((struct semaphore) { ATOMIC_INIT(1), 0, 0, 0, NULL })
 #define MUTEX_LOCKED ((struct semaphore) { ATOMIC_INIT(0), 0, 1, 0, NULL })
+#define SEMAPHORE_NORECURSE(val) ((struct semaphore_norecurse) { ATOMIC_INIT(val), 0, 0, 0, NULL })
 
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
@@ -211,6 +218,69 @@
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		"decl 8(%0)\n\t"
+#ifdef __SMP__
+		"lock ; "
+#endif
+		"incl 0(%0)\n\t"
+		"jle 2f\n"
+		"1:\n"
+		".section .text.lock,\"ax\"\n"
+		"2:\tpushl $1b\n\t"
+		"jmp __up_wakeup\n"
+		".previous"
+		:/* no outputs */
+		:"c" (sem)
+		:"memory");
+}
+
+extern inline void down_norecurse(struct semaphore_norecurse * sem)
+{
+	__asm__ __volatile__(
+		"# atomic down operation\n\t"
+#ifdef __SMP__
+		"lock ; "
+#endif
+		"decl 0(%0)\n\t"
+		"js 2f\n\t"
+		"1:\n"
+		".section .text.lock,\"ax\"\n"
+		"2:\tpushl $1b\n\t"
+		"jmp __down_failed\n"
+		".previous"
+		:/* no outputs */
+		:"c" (sem)
+		:"memory");
+}
+
+extern inline int down_interruptible_norecurse(struct semaphore_norecurse * sem)
+{
+	int result;
+
+	__asm__ __volatile__(
+		"# atomic interruptible down operation\n\t"
+#ifdef __SMP__
+		"lock ; "
+#endif
+		"decl 0(%1)\n\t"
+		"js 2f\n\t"
+		"xorl %0,%0\n"
+		"1:\n"
+		".section .text.lock,\"ax\"\n"
+		"2:\tpushl $1b\n\t"
+		"jmp __down_failed_interruptible\n"
+		".previous"
+		:"=a" (result)
+		:"c" (sem)
+		:"memory");
+	return result;
+}
+
+extern inline void up_norecurse(struct semaphore_norecurse * sem)
+{
+	__asm__ __volatile__(
+		"movl $0,4(%0)\n\t"
+		"movl $-1,8(%0)\n\t"
+		"# atomic up operation\n\t"
 #ifdef __SMP__
 		"lock ; "
 #endif


Andrea Arcangeli


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
