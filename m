Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSE3SMC>; Thu, 30 May 2002 14:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316793AbSE3SMB>; Thu, 30 May 2002 14:12:01 -0400
Received: from ppp-217-133-209-102.dialup.tiscali.it ([217.133.209.102]:46741
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316794AbSE3SL7>; Thu, 30 May 2002 14:11:59 -0400
Subject: [PATCH] [2.4] Waitable counter structure
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7yDViTHmZYBl72j52IuT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 20:11:53 +0200
Message-Id: <1022782313.1921.123.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7yDViTHmZYBl72j52IuT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

"Waitable counter": object that keeps a count and allows to wait until
it reaches zero or is no longer zero.

Sample usage: keep track of requests and, on driver shutdown, wait for
completion of all the requests (counter goes to 0) before completing the
shutdown (an alternative design is to have the last request completed
perform the shutdown, but this isn't always possible).

Actually having to do something like the sample seems so common that it
seems strange that there isn't already something to handle this. Am I an
obvious simpler way of doing this? (other than scheduling in a loop,
which is unelegant and inappropriate if the task might wait for a long
time)

diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/include/linux/waitcount.h linux/include/linux/waitcount.h
--- linux-base/include/linux/waitcount.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/waitcount.h	Thu May 30 16:28:45 2002
@@ -0,0 +1,67 @@
+#ifndef __LINUX_WAITCOUNT_H
+#define __LINUX_WAITCOUNT_H
+
+#include <linux/config.h>
+#include <linux/wait.h>
+#include <asm/atomic.h>
+
+/* "Waitable counter": object that keeps a count and allows to wait
+   until it reaches zero or is no longer zero.
+ */
+
+struct waitable_count {
+	atomic_t count;
+	wait_queue_head_t waitq;
+};
+
+
+#define __WAITABLE_COUNT_INITIALIZER(name) (struct waitable_count) {ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).waitq)}
+#define INITIALIZE_WAITABLE_COUNT(name) (name) = __WAITABLE_COUNT_INITIALIZER(name)
+#define DECLARE_WAITABLE_COUNT(name) struct waitable_count name = __WAITABLE_COUNT_INITIALIZER(name)
+
+static inline void
+inc_count(struct waitable_count *wcount)
+{
+	atomic_inc(&wcount->count);
+}
+
+static inline void
+dec_count_wake_up(struct waitable_count *wcount)
+{
+	if (atomic_dec_and_test(&wcount->count) && waitqueue_active(&wcount->waitq)) {
+		wake_up_all(&wcount->waitq);
+	}
+}
+
+static inline void
+inc_count_wake_up(struct waitable_count *wcount)
+{
+	if (!atomic_inc_and_test(&wcount->count) && waitqueue_active(&wcount->waitq)) {
+		wake_up_all(&wcount->waitq);
+	}
+}
+
+static inline void
+dec_count(struct waitable_count *wcount)
+{
+	atomic_dec(&wcount->count);
+}
+
+#define inc_nonzero inc_count_wake_up
+#define dec_nonzero dec_count
+#define inc_zero inc_count
+#define dec_zero dec_count_wake_up
+
+void
+__wait_count(struct waitable_count *wcount, int nonzero, int state);
+
+static inline void
+wait_count(struct waitable_count *wcount, int nonzero, int state)
+{
+	if (!atomic_read(&wcount->count) == nonzero)
+	{
+		__wait_count (wcount, nonzero, state);
+	}
+}
+
+#endif
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-base/kernel/ksyms.c	Wed Apr 10 14:37:33 2002
+++ linux/kernel/ksyms.c	Thu May 30 16:29:13 2002
@@ -47,6 +47,7 @@
 #include <linux/in6.h>
 #include <linux/completion.h>
 #include <linux/seq_file.h>
+#include <linux/waitcount.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -472,6 +473,7 @@
 EXPORT_SYMBOL(sleep_on_timeout);
 EXPORT_SYMBOL(interruptible_sleep_on);
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
+EXPORT_SYMBOL(__wait_count);
 EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(jiffies);
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/kernel/sched.c linux/kernel/sched.c
--- linux-base/kernel/sched.c	Wed Apr 10 14:37:29 2002
+++ linux/kernel/sched.c	Thu May 30 16:29:28 2002
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>
+#include <linux/waitcount.h>
 #include <linux/prefetch.h>
 #include <linux/compiler.h>
 
@@ -851,6 +852,22 @@
 	SLEEP_ON_TAIL
 
 	return timeout;
+}
+
+void
+__wait_count(struct waitable_count *wcount, int nonzero, int state)
+{
+#define q (&wcount->waitq)
+	SLEEP_ON_VAR
+	
+	current->state = state;
+	
+	SLEEP_ON_HEAD
+	if (!atomic_read(&wcount->count) == nonzero)
+		schedule();
+	current->state = TASK_RUNNING;
+	SLEEP_ON_TAIL
+#undef q		
 }
 
 void scheduling_functions_end_here(void) { }

--=-7yDViTHmZYBl72j52IuT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA89mtpdjkty3ft5+cRAhmeAJ9DwBdCYwFBY5f63eIOFaN8h4LhjACeMXnK
uAFRmdpHWah9aeYU0BS+pI8=
=Jb7I
-----END PGP SIGNATURE-----

--=-7yDViTHmZYBl72j52IuT--
