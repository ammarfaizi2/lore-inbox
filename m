Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTBLGU1>; Wed, 12 Feb 2003 01:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBLGU0>; Wed, 12 Feb 2003 01:20:26 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:53183 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266938AbTBLGTS>;
	Wed, 12 Feb 2003 01:19:18 -0500
Date: Wed, 12 Feb 2003 17:28:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, davem@redhat.com, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][COMPAT] compat_sys_futex 1/7 generic
Message-Id: <20030212172818.3ae39457.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0302112122130.3901-100000@home.transmeta.com>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0302112122130.3901-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, 11 Feb 2003 21:26:54 -0800 (PST) Linus Torvalds <torvalds@transmeta.com> wrote:
>
> I'd prefer this much more if it just passed the timout around as jiffies
> (unconditionally), instead of converting them from one type of timespec to 
> another, and then converting that other timespec to jiffies, and having 
> multiple tests for NULL because of all that conversion confusion.
> 
> Hmm?

How about this then.  Just the generic part retransmitted.

/me mumbles "I will not ignore Rusty's suggestions ..."

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/kernel/compat.c 2.5.60-32bit.2/kernel/compat.c
--- 2.5.60-32bit.1/kernel/compat.c	2003-01-17 14:01:08.000000000 +1100
+++ 2.5.60-32bit.2/kernel/compat.c	2003-02-12 17:22:18.000000000 +1100
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/signal.h>
+#include <linux/sched.h>	/* for MAX_SCHEDULE_TIMEOUT */
 
 #include <asm/uaccess.h>
 
@@ -208,3 +209,19 @@
 		ret = put_user(s, oset);
 	return ret;
 }
+
+extern long do_futex(u32 *, int, int, unsigned long);
+
+asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+		struct compat_timespec *utime)
+{
+	struct timespec t;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (get_compat_timespec(&t, utime))
+			return -EFAULT;
+		timeout = timespec_to_jiffies(t) + 1;
+	}
+	return do_futex((unsigned long)uaddr, op, val, timeout);
+}
diff -ruN 2.5.60-32bit.1/kernel/futex.c 2.5.60-32bit.2/kernel/futex.c
--- 2.5.60-32bit.1/kernel/futex.c	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.60-32bit.2/kernel/futex.c	2003-02-12 17:18:36.000000000 +1100
@@ -315,23 +315,6 @@
 	return ret;
 }
 
-static inline int futex_wait_utime(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      struct timespec* utime)
-{
-	unsigned long time = MAX_SCHEDULE_TIMEOUT;
-
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
-
-	return futex_wait(uaddr, offset, val, time);
-}
-
 static int futex_close(struct inode *inode, struct file *filp)
 {
 	struct futex_q *q = filp->private_data;
@@ -437,7 +420,7 @@
 	return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+long do_futex(unsigned long uaddr, int op, int val, unsinged long timeout)
 {
 	unsigned long pos_in_page;
 	int ret;
@@ -445,12 +428,12 @@
 	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned */
-	if (pos_in_page % sizeof(int))
+	if (pos_in_page % sizeof(u32))
 		return -EINVAL;
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait_utime(uaddr, pos_in_page, val, utime);
+		ret = futex_wait(uaddr, pos_in_page, val, timeout);
 		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
@@ -465,6 +448,20 @@
 	return ret;
 }
 
+asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime)
+{
+	struct timespec t;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		timeout = timespec_to_jiffies(t) + 1;
+	}
+	return do_futex((unsigned long)uaddr, op, val, timeout);
+}
+
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
 	       int flags, char *dev_name, void *data)
