Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTBLEid>; Tue, 11 Feb 2003 23:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbTBLEid>; Tue, 11 Feb 2003 23:38:33 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:7100 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266852AbTBLEib>;
	Tue, 11 Feb 2003 23:38:31 -0500
Date: Wed, 12 Feb 2003 15:47:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_futex 1/7 generic
Message-Id: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates compat_sys_futex and changes the 64 bit architextures
to use it.  This also changes sys_futex to take a "u32 *" as its first
argument as discussed with Rusty and yourself.

This is just the generic part of the patch.  The architecture specific
parts will follow.

There is no mip64 part as the mips port currently does not support
sys_futex.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-32bit.1/kernel/compat.c 2.5.60-32bit.2/kernel/compat.c
--- 2.5.60-32bit.1/kernel/compat.c	2003-01-17 14:01:08.000000000 +1100
+++ 2.5.60-32bit.2/kernel/compat.c	2003-02-11 12:21:56.000000000 +1100
@@ -208,3 +208,19 @@
 		ret = put_user(s, oset);
 	return ret;
 }
+
+extern long do_futex(u32 *, int, int, struct timespec *);
+
+asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+		struct compat_timespec *ct)
+{
+	struct timespec *ts = NULL;
+	struct timespec t;
+
+	if ((op == FUTEX_WAIT) && ct) {
+		if (get_compat_timespec(&t, ct))
+			return -EFAULT;
+		ts = &t;
+	}
+	return do_futex((unsigned long)uaddr, op, val, ts);
+}
diff -ruN 2.5.60-32bit.1/kernel/futex.c 2.5.60-32bit.2/kernel/futex.c
--- 2.5.60-32bit.1/kernel/futex.c	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.60-32bit.2/kernel/futex.c	2003-02-11 12:21:56.000000000 +1100
@@ -318,17 +318,12 @@
 static inline int futex_wait_utime(unsigned long uaddr,
 		      int offset,
 		      int val,
-		      struct timespec* utime)
+		      struct timespec* ts)
 {
 	unsigned long time = MAX_SCHEDULE_TIMEOUT;
 
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
-
+	if (ts)
+		time = timespec_to_jiffies(ts) + 1;
 	return futex_wait(uaddr, offset, val, time);
 }
 
@@ -437,7 +432,7 @@
 	return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+long do_futex(unsigned long uaddr, int op, int val, struct timespec *ts)
 {
 	unsigned long pos_in_page;
 	int ret;
@@ -445,12 +440,12 @@
 	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned */
-	if (pos_in_page % sizeof(int))
+	if (pos_in_page % sizeof(u32))
 		return -EINVAL;
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait_utime(uaddr, pos_in_page, val, utime);
+		ret = futex_wait_utime(uaddr, pos_in_page, val, ts);
 		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
@@ -465,6 +460,19 @@
 	return ret;
 }
 
+asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime)
+{
+	struct timespec *ts = NULL;
+	struct timespec t;
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		ts = &t;
+	}
+	return do_futex((unsigned long)uaddr, op, val, ts);
+}
+
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
 	       int flags, char *dev_name, void *data)
