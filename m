Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSAGUGb>; Mon, 7 Jan 2002 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286196AbSAGUGL>; Mon, 7 Jan 2002 15:06:11 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:2829 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S286188AbSAGUGE>; Mon, 7 Jan 2002 15:06:04 -0500
Date: Mon, 7 Jan 2002 20:05:41 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Lightweight user-level semaphores
Message-ID: <Pine.LNX.4.33.0201071902070.5064-101000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1388574315-1064681102-1010430309=:5064"
Content-ID: <Pine.LNX.4.33.0201071905510.5064@sphinx.mythic-beasts.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1388574315-1064681102-1010430309=:5064
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201071905511.5064@sphinx.mythic-beasts.com>

Linus,

The patch below implements some of your design for a really
quick user-level locking primitive, as explained here:

    http://lwn.net/2001/0419/a/lt-semaphores.php3

There's a user-level API and a couple of test programs in
the attached tarball.  I haven't bothered wih the vital
security hash/signature thing yet.

It all seems to work (i686 UP and SMP), but isn't without
issues:

 * It leaks.  How were you going to refcount the kernel
   portions?  Could they be attached to the VM mapping?
   Would a lockfs be too expensive?

 * It doesn't have a timeout.  Is there something like a
   down_timeout() available?

 * I don't do the:

	if (kfs->user_address != fs)
		goto bad_sem;

   because it doesn't seem to add anything, and prevents
   putting these locks in a non-fixed file or SysV SHM
   map.

   Is that a problem?

Any comments?

Matthew.


diff -ruN linux-2.4.17/arch/i386/kernel/entry.S linux-2.4.17-usersem/arch/i386/kernel/entry.S
--- linux-2.4.17/arch/i386/kernel/entry.S	Sat Jan  5 14:00:37 2002
+++ linux-2.4.17-usersem/arch/i386/kernel/entry.S	Sun Jan  6 13:52:50 2002
@@ -622,6 +622,9 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_FS_create)
+	.long SYMBOL_NAME(sys_FS_down)
+	.long SYMBOL_NAME(sys_FS_up)

 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -ruN linux-2.4.17/include/asm-i386/unistd.h linux-2.4.17-usersem/include/asm-i386/unistd.h
--- linux-2.4.17/include/asm-i386/unistd.h	Wed Oct 17 18:03:03 2001
+++ linux-2.4.17-usersem/include/asm-i386/unistd.h	Sun Jan  6 13:49:54 2002
@@ -230,6 +230,9 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define	__NR_FS_create		226
+#define	__NR_FS_down		227
+#define	__NR_FS_up		228

 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */

diff -ruN linux-2.4.17/include/linux/usersem.h linux-2.4.17-usersem/include/linux/usersem.h
--- linux-2.4.17/include/linux/usersem.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.17-usersem/include/linux/usersem.h	Sun Jan  6 17:50:04 2002
@@ -0,0 +1,9 @@
+#ifndef __LINUX_USERSEM_H
+#define __LINUX_USERSEM_H
+
+struct fast_sem {
+	int count;
+	void *__opaque_ksem;
+};
+
+#endif /* __LINUX_USERSEM_H */
diff -ruN linux-2.4.17/kernel/Makefile linux-2.4.17-usersem/kernel/Makefile
--- linux-2.4.17/kernel/Makefile	Mon Sep 17 05:22:40 2001
+++ linux-2.4.17-usersem/kernel/Makefile	Sat Jan  5 14:36:39 2002
@@ -9,12 +9,12 @@

 O_TARGET := kernel.o

-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o usersem.o

 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o usersem.o

 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -ruN linux-2.4.17/kernel/usersem.c linux-2.4.17-usersem/kernel/usersem.c
--- linux-2.4.17/kernel/usersem.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.17-usersem/kernel/usersem.c	Sun Jan  6 17:50:20 2002
@@ -0,0 +1,82 @@
+/*
+ * Lightweight user-level semaphores
+ */
+
+#include <linux/slab.h>
+#include <linux/usersem.h>
+
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+#include <asm/errno.h>
+
+/* Don't be messin' with my van^H^H^Hopaque data, sucka */
+#define	FS_SIG_MAGIC	0xf001f001
+
+struct ksem {
+	unsigned magic;
+	spinlock_t spin;
+	struct semaphore sem;
+};
+
+
+/* XXX - _from_user */
+static inline struct ksem *get_ksem(struct fast_sem *s)
+{
+	struct ksem *r = (struct ksem*)s->__opaque_ksem;
+	if(!r) return NULL;
+	if(r->magic != FS_SIG_MAGIC) return NULL;
+	return r;
+}
+
+/* XXX - _to_user */
+static inline int store_ksem(struct fast_sem *s, struct ksem *k)
+{
+	s->count = 0;
+	s->__opaque_ksem = (void*)k;
+	return 0;
+}
+
+static struct ksem *ksem_new(void)
+{
+	struct ksem *s;
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s->magic = FS_SIG_MAGIC;
+	spin_lock_init(&s->spin);
+	sema_init(&s->sem, 1);
+	return s;
+}
+
+
+asmlinkage long sys_FS_create(struct fast_sem *sem)
+{
+	struct ksem *ksem;
+	if(!(ksem = ksem_new()))
+		return -ENOMEM;
+	if(store_ksem(sem, ksem)) {
+		//ksem_free(ksem);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+
+asmlinkage long sys_FS_down(struct fast_sem *sem)
+{
+	struct ksem *ksem;
+
+	if(!(ksem = get_ksem(sem)))
+		return -ENOENT;
+
+	down_interruptible(&ksem->sem);
+	return 0;
+}
+
+asmlinkage long sys_FS_up(struct fast_sem *sem)
+{
+	struct ksem *ksem;
+	if(!(ksem = get_ksem(sem)))
+		return -ENOENT;
+
+	up(&ksem->sem);
+	return 0;
+}

--1388574315-1064681102-1010430309=:5064
Content-Type: APPLICATION/OCTET-STREAM; NAME="ust.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201071932560.5064@sphinx.mythic-beasts.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ust.tar.gz"

H4sICGXyOTwCA3VzdC50YXIA7VrrU9w2EOer/VdsTMnYxz2se7ZHLh1KSJOZ
ABlIhi+deBSfzDn4bMeyQ0jD/96VbN+L46BJgNLoNwP2SatdrR67K60znjbW
bhm23bZ7vQ4+bbvXbc89C6zZvTbptnqEtFprNiHdpr0GnbU7QMZTmgCsjWma
jtjZlXTX1T9QoPqNMQ3P6+4tzj+x7W57Mt+LT9Jsd/L5J6TdtomY/w5Wg32X
859EUbqK7rr6B4pGBTLOEs7GkDKe9iGLgYZDGEZnIVAIohQqDX3dD90gGzJ4
ws95Y4wLpj56ulCanseMi+KZ8iz0eTpcoE2HfjRPZxRdqI8MLB0yzw+ZtnPw
dv+NRvI1out+mMKY+qH5KfKHlv63rvE0ydwUPMpTR/S/gv+2dE3UQ2VMY3wX
jfziWfG2dF3DchgAahCbdhXa9m/dKrw+PHjjHO5uP/sq344PX77ZrcLe9mvn
6MX24e6zr+J1e/9gvwo1UgXbEhw9U7IaSLrn2y9f7T6zAHulxSxJosQ0+Igm
bIiDGYVSHnbUD9jQEK21hKVZEgLB9wvslej+AMwFjSpWroUn6lCFiiVlbgL3
v7DIM4XClmBXERS2UA+nU6znFLIwiNxTlI+zp3nccRNGU2aKFoIOu+9Fyalp
wRPUZ67fonxVX7He9KU88LG1nCZ83dzM2aAssXYKSZpmVjxrc3Mrr8nislxw
ihNUykOJfkgD8AYbw79Co4oTJQgKqajVhb6mcJv2H/9u0/xfZ/+bdmti/5uE
SPvfahNl/+/F/udmq5GbLRrHaEKwksajKGF37Qq+2eb/XLZ+haVfMMco/cxP
3VFh/KUSLuUMde3f0AWgd6ZZkEryLOWmEaPqIS4c0YucetEFlHa+pBQazNn6
BU4nUTrD7cZSVvCgAU3GZufm/DQxuu9FJZfjupL7exzx061iJG0xMjxgLC7l
Fdq7Iz8Y4v5i6fwA4Ptsxwqy3H9PejZ1nMvIymn6bg4Xyu/+lP6/MLn34//t
drOb+3+71yV2D+mbzVZX+f+78f86VOCtWAExdRkclb6e67m390K0+Jrz9mj3
8Gh3z3kxOZ9NizQy68Abo2jMGsV1SeOUJWEj8MPsc61Zb9dJr1astkbRIK9s
LLr9GUe2xOWjrSqIcpO9kkRYvuUE+joLh74HaOun2gi1f879797P/m+SbreM
/0mn2ZH7v6n2/x3u/71z+ERD8Pm743fHk3CfA4Y7ctNUwYui4JE+dwAw6vUb
bG/Kx40y9jdmYn8MNcMi9i8NirN/6Dw/Kva9puEauFQntruo6V2qyWJR/utV
Rwmc5dR3wcHjiUuDgIgYuzoRVl2Mxqu5gbiqlejGv22TxVe10NH+fMx891TG
lFCrQRGE4XGi9oUlEaCN4kF0VotpOsJKJE7ygL8U5vghzgJzHBBGz8nNojwJ
ufLcJF4TDPAcB+cDqRznUxRg00A0MXXN0D5HCWzY1Q0bw1LxW3RlC4bMDWCD
FGUfQg7EK36IYYaSnPTlU+uDMfhomIlVxZexYQrx2sx1TiLCyqm+efD5QzRG
K/8D9M2Vmuh78kPUvYlDk4dbNq49daMMqQfyrFVwmSzTIoK/0K/3fnIQPPNR
sRQeT3lb1vRAZ88JmTlOTUVc5T2nApDiRuwnJxB1sPhv+f89eoq2NGD3dP9n
t0iR/8Pgv0e6wv/brZby/3eBVy//GJR+MtJfHx78eYS/xbVbeA7jLEh9oKmu
7+wMTlxX33n+ahsJasfo2KB20ISa50YhT2toIvzwhOs6VvThF1MysnQ9kykl
ntYjLERZWESxhGKBrgsZfSlpplrK7OeiZ4rdgNGwj+ZkjDInAqCCJC6GKsqi
fMf+p7d7/X/t/u80Z/a/PP8T0lbx/13d/4t7/0kSgHL8/z44X7jqX3FR7y69
qJfRQx7GlKE6xN405YeR3ll5ByrugMtwPnYxmpqQbbR5HzY4iChwC5B0Pali
LLe+npiPPQt+B0MEiQZgHCaiE8PaQiG6YCJiGWvhLYuvKll8Lmt9FceHfWUq
v/+Qtta9r/1PWt0y/2e3O9L/k26vp/b/veT/5GKIA5ZnP/DMFSeRy9Aq8Pv+
EOT7vgF5kOnAb0zyXfOJxuUc4CQJCMtTgDDT6TLNdSkBN5/pQuMOZ9EpgyyW
Rt7PaWZOhiLbJEdAJstaN+l5KeGMSsawXngQf0mWK2dLyo9NVF5LQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB4X+EfwAsCdaZAFAAAA==
--1388574315-1064681102-1010430309=:5064--
