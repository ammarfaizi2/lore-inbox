Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316373AbSETVJR>; Mon, 20 May 2002 17:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316379AbSETVJQ>; Mon, 20 May 2002 17:09:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60145 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316373AbSETVJO>; Mon, 20 May 2002 17:09:14 -0400
Subject: [PATCH] 2.4-ac: more scheduler updates (1/3)
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-aoOlZndTrRYLYpoXaAkU"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 May 2002 14:08:39 -0700
Message-Id: <1021928919.925.314.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aoOlZndTrRYLYpoXaAkU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

I promise these are the last of them :)

This patch does some remaining cleanup and optimization.  I choose not
to send these as individual diffs because they are simple. 
Specifically:

	- move sched_find_first_bit from mmu_context.h to bitops.h
	  as in 2.5.  Why it was ever in mmu_context.h is beyond me.
	- remove the RUN_CHILD_FIRST cruft from kernel/fork.c.
	  Pretty clear this works great; we do not need the ifdefs.
	- Add comments to top of kernel/sched.c to briefly explain
	  new scheduler design, give credit, and update copyright.
	- set_cpus_allowed optimization from Mike Kravetz: we do not
	  need to invoke the migration_thread's if the task is not
	  running; just update task->cpu.

Patch is against 2.4.19-pre8-ac5, please apply.

	Robert Love


--=-aoOlZndTrRYLYpoXaAkU
Content-Disposition: attachment; filename=sched-cleanups-rml-2.4.19-pre8-ac5-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-cleanups-rml-2.4.19-pre8-ac5-1.patch;
	charset=ISO-8859-15

diff -urN linux-2.4.19-pre8-ac5/include/asm-i386/bitops.h linux/include/asm=
-i386/bitops.h
--- linux-2.4.19-pre8-ac5/include/asm-i386/bitops.h	Mon May 20 13:45:58 200=
2
+++ linux/include/asm-i386/bitops.h	Mon May 20 13:52:06 2002
@@ -6,6 +6,7 @@
  */
=20
 #include <linux/config.h>
+#include <linux/compiler.h>
=20
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -421,6 +422,25 @@
=20
 #ifdef __KERNEL__
=20
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(unsigned long *b)
+{
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+}
+
 /**
  * ffs - find first bit set
  * @x: the word to search
diff -urN linux-2.4.19-pre8-ac5/include/asm-i386/mmu_context.h linux/includ=
e/asm-i386/mmu_context.h
--- linux-2.4.19-pre8-ac5/include/asm-i386/mmu_context.h	Mon May 20 13:45:5=
8 2002
+++ linux/include/asm-i386/mmu_context.h	Mon May 20 13:52:06 2002
@@ -7,25 +7,6 @@
 #include <asm/pgalloc.h>
=20
 /*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
  * possibly do the LDT unload here?
  */
 #define destroy_context(mm)		do { } while(0)
diff -urN linux-2.4.19-pre8-ac5/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.19-pre8-ac5/kernel/fork.c	Mon May 20 13:45:54 2002
+++ linux/kernel/fork.c	Mon May 20 13:52:06 2002
@@ -770,24 +770,16 @@
=20
 	if (p->ptrace & PT_PTRACED)
 		send_sig(SIGSTOP, p, 1);
-
-#define RUN_CHILD_FIRST 1
-#if RUN_CHILD_FIRST
 	wake_up_forked_process(p);	/* do this last */
-#else
-	wake_up_process(p);		/* do this last */
-#endif
 	++total_forks;
 	if (clone_flags & CLONE_VFORK)
 		wait_for_completion(&vfork);
-#if RUN_CHILD_FIRST
 	else
 		/*
 		 * Let the child process run first, to avoid most of the
 		 * COW overhead when the child exec()s afterwards.
 		 */
 		current->need_resched =3D 1;
-#endif
=20
 fork_out:
 	return retval;
diff -urN linux-2.4.19-pre8-ac5/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre8-ac5/kernel/sched.c	Mon May 20 13:45:54 2002
+++ linux/kernel/sched.c	Mon May 20 13:52:06 2002
@@ -3,13 +3,17 @@
  *
  *  Kernel scheduler and related syscalls
  *
- *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 1991-2002  Linus Torvalds
  *
  *  1996-12-23  Modified by Dave Grothe to fix bugs in semaphores and
  *              make semaphores SMP safe
  *  1998-11-19	Implemented schedule_timeout() and related stuff
  *		by Andrea Arcangeli
- *  1998-12-28  Implemented better SMP scheduling by Ingo Molnar
+ *  2002-01-04	New ultra-scalable O(1) scheduler by Ingo Molnar:
+ *  		hybrid priority-list and round-robin design with
+ *  		an array-switch method of distributing timeslices
+ *  		and per-CPU runqueues.  Additional code by Davide
+ *  		Libenzi, Robert Love, and Rusty Russel.
  */
=20
 #include <linux/mm.h>
@@ -1530,6 +1534,16 @@
 		task_rq_unlock(rq, &flags);
 		return;
 	}
+
+	/*
+	 * If the task is not on a runqueue, then it is safe to
+	 * simply update the task's cpu field.
+	 */
+	if (!p->array) {
+		p->cpu =3D __ffs(p->cpus_allowed);
+		task_rq_unlock(rq, &flags);
+		return;
+	}
=20
 	init_MUTEX_LOCKED(&req.sem);
 	req.task =3D p;

--=-aoOlZndTrRYLYpoXaAkU--

