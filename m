Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTAHLau>; Wed, 8 Jan 2003 06:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbTAHLau>; Wed, 8 Jan 2003 06:30:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:3762 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267023AbTAHLas>;
	Wed, 8 Jan 2003 06:30:48 -0500
Date: Wed, 8 Jan 2003 22:37:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] {get,put}_compat_timspec 1/8 generic
Message-Id: <20030108223744.0c4856b7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Andi Kleen asked for these two, so here they are.  This is the generic
part of the patch.  It is relative to 2.5.54 BK.

The diffstat for the total patch is:
 arch/ia64/ia32/ia32_signal.c      |   11 +++-------
 arch/ia64/ia32/sys_ia32.c         |    2 -
 arch/mips64/kernel/linux32.c      |    3 --
 arch/parisc/kernel/sys_parisc32.c |   11 ----------
 arch/ppc64/kernel/signal32.c      |   15 +++-----------
 arch/ppc64/kernel/sys_ppc32.c     |    4 ---
 arch/s390x/kernel/linux32.c       |   11 +++-------
 arch/sparc64/kernel/sys_sparc32.c |    6 +----
 arch/x86_64/ia32/ipc32.c          |    4 ---
 arch/x86_64/ia32/sys_ia32.c       |   40 +++++++++++---------------------------
 include/linux/compat.h            |    2 +
 kernel/compat.c                   |   23 +++++++++++++++------
 12 files changed, 49 insertions(+), 83 deletions(-)

One thing - would these be better as inline functions in linux/compat.h?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301081106-32bit.2/include/linux/compat.h 2.5.54-200301081106-32bit.3/include/linux/compat.h
--- 2.5.54-200301081106-32bit.2/include/linux/compat.h	2003-01-08 11:41:18.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/include/linux/compat.h	2003-01-08 16:41:48.000000000 +1100
@@ -36,6 +36,8 @@
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
 extern int get_compat_flock(struct flock *, struct compat_flock *);
 extern int put_compat_flock(struct flock *, struct compat_flock *);
+extern int get_compat_timespec(struct timespec *, struct compat_timespec *);
+extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruN 2.5.54-200301081106-32bit.2/kernel/compat.c 2.5.54-200301081106-32bit.3/kernel/compat.c
--- 2.5.54-200301081106-32bit.2/kernel/compat.c	2002-12-16 14:49:55.000000000 +1100
+++ 2.5.54-200301081106-32bit.3/kernel/compat.c	2003-01-08 16:39:44.000000000 +1100
@@ -18,6 +18,20 @@
 
 #include <asm/uaccess.h>
 
+int get_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+{
+	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
+			__get_user(ts->tv_sec, &cts->tv_sec) ||
+			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+}
+
+int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+{
+	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
+			__put_user(ts->tv_sec, &cts->tv_sec) ||
+			__put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
+}
+
 static long compat_nanosleep_restart(struct restart_block *restart)
 {
 	unsigned long expire = restart->arg0, now = jiffies;
@@ -50,15 +64,12 @@
 asmlinkage long compat_sys_nanosleep(struct compat_timespec *rqtp,
 		struct compat_timespec *rmtp)
 {
-	struct compat_timespec ct;
 	struct timespec t;
 	struct restart_block *restart;
 	unsigned long expire;
 
-	if (copy_from_user(&ct, rqtp, sizeof(ct)))
+	if (get_compat_timespec(&t, rqtp))
 		return -EFAULT;
-	t.tv_sec = ct.tv_sec;
-	t.tv_nsec = ct.tv_nsec;
 
 	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;
@@ -71,9 +82,7 @@
 
 	if (rmtp) {
 		jiffies_to_timespec(expire, &t);
-		ct.tv_sec = t.tv_sec;
-		ct.tv_nsec = t.tv_nsec;
-		if (copy_to_user(rmtp, &ct, sizeof(ct)))
+		if (put_compat_timespec(&t, rmtp))
 			return -EFAULT;
 	}
 	restart = &current_thread_info()->restart_block;
