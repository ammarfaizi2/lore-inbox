Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSHUJvh>; Wed, 21 Aug 2002 05:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318168AbSHUJvh>; Wed, 21 Aug 2002 05:51:37 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:44190 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318155AbSHUJvf>; Wed, 21 Aug 2002 05:51:35 -0400
Date: Wed, 21 Aug 2002 12:50:28 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/linux/smp_lock.h cleanup 2.5.31 (latest bk)
Message-ID: <20020821095027.GB7661@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a resend of a patch to cleanup include/linux/smp_lock.h, based
on a patch to do roughly the same to include/asm-i386/smplock.h from
last week.=20

It's only a cleanup patch, not executable bits were changed. Patch is
against latest bitkeeper (2.5.31+), compiles fine.=20

  - move various defines to static inline functions for type safety of
parameters.
  - change  __inline__ to inline.=20
  - add kernel_locked_for_task(task) which was implicit before
    explicit, and make kernel_locked() use it.=20
  - add do { } while (0) to macros

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.502   -> 1.503 =20
#	include/linux/smp_lock.h	1.4     -> 1.5   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/21	mulix@alhambra.merseine.nu	1.503
# cleanups for smp_lock.h
# --------------------------------------------
#
diff -Nru a/include/linux/smp_lock.h b/include/linux/smp_lock.h
--- a/include/linux/smp_lock.h	Wed Aug 21 12:44:06 2002
+++ b/include/linux/smp_lock.h	Wed Aug 21 12:44:06 2002
@@ -9,9 +9,10 @@
 #define unlock_kernel()				do { } while(0)
 #define release_kernel_lock(task)		do { } while(0)
 #define reacquire_kernel_lock(task)		do { } while(0)
-#define kernel_locked() 1
+#define kernel_locked()                         (1)
+#define kernel_locked_for_task(task)            (1)
=20
-#else
+#else /* defined(CONFIG_SMP) || defined(CONFIG_PREEMPT) */=20
=20
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
@@ -20,29 +21,36 @@
=20
 extern spinlock_t kernel_flag;
=20
-#define kernel_locked()		(current->lock_depth >=3D 0)
+static inline int kernel_locked_for_task(struct task_struct* task)
+{
+	return (task->lock_depth >=3D 0);=20
+}
+
+static inline int kernel_locked(void)
+{
+	return kernel_locked_for_task(current);=20
+}
=20
-#define get_kernel_lock()	spin_lock(&kernel_flag)
-#define put_kernel_lock()	spin_unlock(&kernel_flag)
+#define get_kernel_lock()	do { spin_lock(&kernel_flag); } while (0)
+#define put_kernel_lock()	do { spin_unlock(&kernel_flag); } while (0)
=20
 /*
  * Release global kernel lock and global interrupt lock
  */
-#define release_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >=3D 0))	\
-		put_kernel_lock();		\
-} while (0)
+static inline void release_kernel_lock(struct task_struct* task)
+{
+	if (unlikely(kernel_locked_for_task(task)))
+		put_kernel_lock();
+}
=20
 /*
  * Re-acquire the kernel lock
  */
-#define reacquire_kernel_lock(task)		\
-do {						\
-	if (unlikely(task->lock_depth >=3D 0))	\
-		get_kernel_lock();		\
-} while (0)
-
+static inline void reacquire_kernel_lock(struct task_struct* task)
+{
+	if (unlikely(kernel_locked_for_task(task)))
+		get_kernel_lock();=20
+}
=20
 /*
  * Getting the big kernel lock.
@@ -51,7 +59,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static inline void lock_kernel(void)
 {
 	int depth =3D current->lock_depth+1;
 	if (!depth)
@@ -59,14 +67,14 @@
 	current->lock_depth =3D depth;
 }
=20
-static __inline__ void unlock_kernel(void)
+static inline void unlock_kernel(void)
 {
-	if (current->lock_depth < 0)
+	if (!kernel_locked())
 		BUG();
 	if (--current->lock_depth < 0)
 		put_kernel_lock();
 }
=20
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP || CONFIG_PREEMPT*/
=20
-#endif
+#endif /* __LINUX_SMPLOCK_H */=20

--=20
calm down, it's *only* ones and zeros.=20

http://syscalltrack.sf.net/
http://vipe.technion.ac.il/~mulix/

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Y2JjKRs727/VN8sRAlneAKC0Km/e/YIK+gQh/vqhYm31CSYGaQCgjjrY
nAg6ndEEnUP0n5I3dpBKXvY=
=WozP
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
