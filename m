Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTLUTO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTLUTO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:14:56 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:995 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263846AbTLUTOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:14:47 -0500
Message-ID: <3FE5F116.9020608@colorfullife.com>
Date: Sun, 21 Dec 2003 20:14:30 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <8765ga6moe.fsf@devron.myhome.or.jp>
In-Reply-To: <8765ga6moe.fsf@devron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------090706000607060106060009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090706000607060106060009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OGAWA Hirofumi wrote:

>Or use inline function for testing *fp.
>  
>
Initially I tried to keep the patch as tiny as possible, thus I avoided 
adding an inline function. But Stephen Hemminger convinced me to update 
the network code, and thus it didn't matter and I've switched to an 
inline function.
What do you think about the attached patch?

--
    Manfred

--------------090706000607060106060009
Content-Type: text/plain;
 name="patch-fasync-rcu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fasync-rcu"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION =
--- 2.6/include/linux/fs.h	2003-12-04 19:44:40.000000000 +0100
+++ build-2.6/include/linux/fs.h	2003-12-21 09:31:16.000000000 +0100
@@ -636,17 +636,36 @@ struct fasync_struct {
 	int	fa_fd;
 	struct	fasync_struct	*fa_next; /* singly linked list */
 	struct	file 		*fa_file;
+	struct  rcu_head	rcu;
 };
 
-#define FASYNC_MAGIC 0x4601
+#define FASYNC_MAGIC 0x4602
 
-/* SMP safe fasync helpers: */
-extern int fasync_helper(int, struct file *, int, struct fasync_struct **);
-/* can be called from interrupts */
-extern void kill_fasync(struct fasync_struct **, int, int);
-/* only for net: no internal synchronization */
-extern void __kill_fasync(struct fasync_struct *, int, int);
+/* fasync helper functions: */
+/* 1) setting up the fasync queue. The functions return negative on error, 0
+ * if they did no changes and positive if they added/deleted the entry.
+ * Networking uses lock_sock, everyone else a global spinlock for locking.
+ */
+struct sock;
+extern int __fasync_helper(int fd, struct file *filp, int on, struct fasync_struct **fapp, struct sock *s);
+static inline int fasync_helper(int fd, struct file * filp, int on, struct fasync_struct **fapp)
+{
+	return __fasync_helper(fd, filp, on, fapp, NULL);
+}
+
+/* 2) send out signals. Can be called from interrupts */
+extern void fasync_send_sig(struct fasync_struct *fa, int sig, int band);
+static inline void kill_fasync(struct fasync_struct **fp, int sig, int band)
+{
+	struct fasync_struct *fa;
+	rcu_read_lock();
+	fa = *fp;
+	if (fa)
+		fasync_send_sig(fa, sig, band);
+	rcu_read_unlock();
+}
 
+/* 3) high level helpers */
 extern int f_setown(struct file *filp, unsigned long arg, int force);
 extern void f_delown(struct file *filp);
 extern int send_sigurg(struct fown_struct *fown);
--- 2.6/fs/fcntl.c	2003-12-04 19:44:38.000000000 +0100
+++ build-2.6/fs/fcntl.c	2003-12-21 09:29:16.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <net/sock.h>
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -537,15 +538,15 @@ int send_sigurg(struct fown_struct *fown
 	return ret;
 }
 
-static rwlock_t fasync_lock = RW_LOCK_UNLOCKED;
+static spinlock_t fasync_lock = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t *fasync_cache;
 
-/*
- * fasync_helper() is used by some character device drivers (mainly mice)
- * to set up the fasync queue. It returns negative on error, 0 if it did
- * no changes and positive if it added/deleted the entry.
- */
-int fasync_helper(int fd, struct file * filp, int on, struct fasync_struct **fapp)
+static void fasync_free(void *data)
+{
+	kmem_cache_free(fasync_cache, data);
+}
+
+int __fasync_helper(int fd, struct file *filp, int on, struct fasync_struct **fapp, struct sock *s)
 {
 	struct fasync_struct *fa, **fp;
 	struct fasync_struct *new = NULL;
@@ -556,15 +557,27 @@ int fasync_helper(int fd, struct file * 
 		if (!new)
 			return -ENOMEM;
 	}
-	write_lock_irq(&fasync_lock);
+	if (s)
+		lock_sock(s);
+	else
+		spin_lock(&fasync_lock);
+
 	for (fp = fapp; (fa = *fp) != NULL; fp = &fa->fa_next) {
 		if (fa->fa_file == filp) {
 			if(on) {
+				/* RCU violation:
+				 * We are modifying a struct that can be seen
+				 * by readers. If there is a fasync
+				 * notification right now, then it could go
+				 * to either the old or the new fd. Shouldn't
+				 * matter.
+				 * 	Manfred <manfred@colorfullife.com>
+				 */
 				fa->fa_fd = fd;
 				kmem_cache_free(fasync_cache, new);
 			} else {
 				*fp = fa->fa_next;
-				kmem_cache_free(fasync_cache, fa);
+				call_rcu(&fa->rcu, fasync_free, fa);
 				result = 1;
 			}
 			goto out;
@@ -576,21 +589,27 @@ int fasync_helper(int fd, struct file * 
 		new->fa_file = filp;
 		new->fa_fd = fd;
 		new->fa_next = *fapp;
+		smp_wmb();
 		*fapp = new;
 		result = 1;
 	}
 out:
-	write_unlock_irq(&fasync_lock);
+	if (s)
+		release_sock(s);
+	else
+		spin_unlock(&fasync_lock);
+	spin_unlock(&fasync_lock);
 	return result;
 }
 
-EXPORT_SYMBOL(fasync_helper);
+EXPORT_SYMBOL(__fasync_helper);
 
-void __kill_fasync(struct fasync_struct *fa, int sig, int band)
+void fasync_send_sig(struct fasync_struct *fa, int sig, int band)
 {
-	while (fa) {
+	do {
 		struct fown_struct * fown;
-		if (fa->magic != FASYNC_MAGIC) {
+		smp_read_barrier_depends();
+		if (unlikely(fa->magic != FASYNC_MAGIC)) {
 			printk(KERN_ERR "kill_fasync: bad magic number in "
 			       "fasync_struct!\n");
 			return;
@@ -602,19 +621,10 @@ void __kill_fasync(struct fasync_struct 
 		if (!(sig == SIGURG && fown->signum == 0))
 			send_sigio(fown, fa->fa_fd, band);
 		fa = fa->fa_next;
-	}
-}
-
-EXPORT_SYMBOL(__kill_fasync);
-
-void kill_fasync(struct fasync_struct **fp, int sig, int band)
-{
-	read_lock(&fasync_lock);
-	__kill_fasync(*fp, sig, band);
-	read_unlock(&fasync_lock);
+	} while(fa);
 }
 
-EXPORT_SYMBOL(kill_fasync);
+EXPORT_SYMBOL(fasync_send_sig);
 
 static int __init fasync_init(void)
 {
--- 2.6/net/socket.c	2003-12-04 19:44:40.000000000 +0100
+++ build-2.6/net/socket.c	2003-12-21 09:01:48.000000000 +0100
@@ -878,81 +878,29 @@ int sock_close(struct inode *inode, stru
  *	Fasync_list locking strategy.
  *
  *	1. fasync_list is modified only under process context socket lock
- *	   i.e. under semaphore.
- *	2. fasync_list is used under read_lock(&sk->sk_callback_lock)
- *	   or under socket lock.
- *	3. fasync_list can be used from softirq context, so that
- *	   modification under socket lock have to be enhanced with
- *	   write_lock_bh(&sk->sk_callback_lock).
- *							--ANK (990710)
+ *	   i.e. under semaphore, following rcu rules.
+ *	2. All users are either under read_lock(&sk->sk_callback_lock),
+ *	   or rcu_read_lock().
+ *	3. Exception: wakeup calls are skipped if sock->fasync_list is NULL,
+ *	   and these checks are done without locking. Doesn't matter.
+ *				Manfred <manfred@colorfullife.com>
  */
 
 static int sock_fasync(int fd, struct file *filp, int on)
 {
-	struct fasync_struct *fa, *fna=NULL, **prev;
 	struct socket *sock;
 	struct sock *sk;
 
-	if (on)
-	{
-		fna=(struct fasync_struct *)kmalloc(sizeof(struct fasync_struct), GFP_KERNEL);
-		if(fna==NULL)
-			return -ENOMEM;
-	}
-
 	sock = SOCKET_I(filp->f_dentry->d_inode);
 
 	if ((sk=sock->sk) == NULL) {
-		if (fna)
-			kfree(fna);
 		return -EINVAL;
 	}
 
-	lock_sock(sk);
-
-	prev=&(sock->fasync_list);
-
-	for (fa=*prev; fa!=NULL; prev=&fa->fa_next,fa=*prev)
-		if (fa->fa_file==filp)
-			break;
-
-	if(on)
-	{
-		if(fa!=NULL)
-		{
-			write_lock_bh(&sk->sk_callback_lock);
-			fa->fa_fd=fd;
-			write_unlock_bh(&sk->sk_callback_lock);
-
-			kfree(fna);
-			goto out;
-		}
-		fna->fa_file=filp;
-		fna->fa_fd=fd;
-		fna->magic=FASYNC_MAGIC;
-		fna->fa_next=sock->fasync_list;
-		write_lock_bh(&sk->sk_callback_lock);
-		sock->fasync_list=fna;
-		write_unlock_bh(&sk->sk_callback_lock);
-	}
-	else
-	{
-		if (fa!=NULL)
-		{
-			write_lock_bh(&sk->sk_callback_lock);
-			*prev=fa->fa_next;
-			write_unlock_bh(&sk->sk_callback_lock);
-			kfree(fa);
-		}
-	}
-
-out:
-	release_sock(sock->sk);
-	return 0;
+	return __fasync_helper(fd, filp, on, &sock->fasync_list, sk);
 }
 
 /* This function may be called only under socket lock or callback_lock */
-
 int sock_wake_async(struct socket *sock, int how, int band)
 {
 	if (!sock || !sock->fasync_list)
@@ -970,10 +918,10 @@ int sock_wake_async(struct socket *sock,
 		/* fall through */
 	case 0:
 	call_kill:
-		__kill_fasync(sock->fasync_list, SIGIO, band);
+		kill_fasync(&sock->fasync_list, SIGIO, band);
 		break;
 	case 3:
-		__kill_fasync(sock->fasync_list, SIGURG, band);
+		kill_fasync(&sock->fasync_list, SIGURG, band);
 	}
 	return 0;
 }
--- 2.6/arch/sparc64/solaris/timod.c	2003-10-25 20:43:27.000000000 +0200
+++ build-2.6/arch/sparc64/solaris/timod.c	2003-12-21 08:31:34.000000000 +0100
@@ -151,7 +151,7 @@ static void timod_wake_socket(unsigned i
 	wake_up_interruptible(&sock->wait);
 	read_lock(&sock->sk->sk_callback_lock);
 	if (sock->fasync_list && !test_bit(SOCK_ASYNC_WAITDATA, &sock->flags))
-		__kill_fasync(sock->fasync_list, SIGIO, POLL_IN);
+		kill_fasync(&sock->fasync_list, SIGIO, POLL_IN);
 	read_unlock(&sock->sk->sk_callback_lock);
 	SOLD("done");
 }
--- 2.6/net/decnet/dn_nsp_in.c	2003-10-25 20:43:22.000000000 +0200
+++ build-2.6/net/decnet/dn_nsp_in.c	2003-12-21 08:31:27.000000000 +0100
@@ -602,7 +602,7 @@ static __inline__ int dn_queue_skb(struc
 		wake_up_interruptible(sk->sk_sleep);
 		if (sock && sock->fasync_list &&
 		    !test_bit(SOCK_ASYNC_WAITDATA, &sock->flags))
-			__kill_fasync(sock->fasync_list, sig, 
+			kill_fasync(&sock->fasync_list, sig, 
 				    (sig == SIGURG) ? POLL_PRI : POLL_IN);
 	}
 	read_unlock(&sk->sk_callback_lock);

--------------090706000607060106060009--

