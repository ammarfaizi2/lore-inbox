Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292946AbSCEI1l>; Tue, 5 Mar 2002 03:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310522AbSCEI1k>; Tue, 5 Mar 2002 03:27:40 -0500
Received: from [61.81.112.41] ([61.81.112.41]:4993 "EHLO atj.dyndns.org")
	by vger.kernel.org with ESMTP id <S292946AbSCEI1X>;
	Tue, 5 Mar 2002 03:27:23 -0500
Date: Tue, 5 Mar 2002 17:27:20 +0900 (KST)
From: TeJun Huh <tj@atj.dyndns.org>
Reply-To: tejun@aratech.co.kr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sysevq (kqueue equivalent)
Message-ID: <Pine.LNX.4.21.0203051635130.2316-100000@atj.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I had to port a network application which makes use of freeBSD kqueue
to linux because we didn't like the SMP support of freeBSD. So, I've
implemented a similar thing which is called sysevq. It can be shared
between kernel threads by giving CLONE_SYSEVQ flag to clone systemcall.

 We used sysevq for our web cache (Jaguar3000), and it performed well
and seems stable - we ran a lot of full web polygraph tests with it.
The patch is against linux-2.4.12 and you need to turn on sysevq in
[General Setup] section. Currently it only supports TCP/UDP sockets
and the programming interface is kind of odd (we just needed something
that works).

 Limitations
 1. Only one sysevq per thread. (considering changing it. maybe
    nesting support too?)
 2. Only TCP/UDP sockets are supported. (gonna implement other things
    soon)
 3. Only edge trigerring is supported. Actually, I don't think
    level triggering is a good idea for two reasons. 1 - It can be
    handled in user space without too much trouble, 2 - when shared
    among threads, the semantic is odd. Also the implementation is
    much simpler without level triggering.
 4. Programming interface is kind of odd. (gonna change)
 5. Returned events don't carry useful information like bytes left
    to read, number of connections pending, etc. And it may lead
    to an extra systemcall.

 I wanna know two things. First, is there any plan to include some
event handling mechanism into the official kernel? Second, if so, am I
heading the right direction? Any comments are welcomed.

*******************************************************************
**** An example: This program is just to show what it looks like.
**** I know it isn't correct. :-)

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <linux/sysevq.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define pd(args...)	printf(args)
//#define pd(args...)

#define NR_EVS		64

int main(int argc, char *argv[])
{
	int listenfd, sysevqd, port;
	int nr_socks = 0, rv, i;
	struct sockaddr_in servaddr;
	struct sysev ivec[NR_EVS], ovec[NR_EVS];
	struct sysevq_ioctl_arg arg;
	char buf[8192];

	if (argc < 2) {
		pd("Usage: testsysevq listenfd\n");
		return 1;
	}

	port = atoi(argv[1]);

	if ((sysevqd = open("/dev/sysevq", O_RDONLY)) < 0) {
		pd("open /dev/sysevq failed (%d:%s)\n", errno, strerror(errno));
		return 1;
	}

	if ((listenfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
		pd("socket failed (%d:%s)\n", errno, strerror(errno));
		return 1;
	}
	fcntl(listenfd, F_SETFL, O_NONBLOCK);
	memset(&servaddr, 0, sizeof(servaddr));
	servaddr.sin_family = AF_INET;
	servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	servaddr.sin_port = htons(port);

	if ((rv = bind(listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr))) < 0) {
		pd("bind failed (%d:%s)\n", errno, strerror(errno));
		return 1;
	}

	listen(listenfd, 5);

	ivec[0].type = SYSEV_TYPE_READ;
	ivec[0].id = listenfd;
	ivec[0].flags = SYSEV_PERSIST;
	ivec[0].udata = 1010;
	
	arg.in_cnt = 1;
	arg.out_cnt = NR_EVS;
	arg.in_evs = ivec;
	arg.out_evs = ovec;

 retry:
	pd("\nabout to ioctl SYSEVQ_DOIT\n");
	if ((rv = ioctl(sysevqd, SYSEVQ_DOIT, &arg)) < 0) {
		pd("ioctl SYSEVQ_DOIT failed (%d:%s)\n", errno, strerror(errno));
		return 1;
	}
	pd("SYSEVQ_DOIT done, rv=%d\n", rv);

	arg.in_cnt = 0;

	for (i = 0; i < rv; i++)
		pd("ovec[%d]=%p type=%08x id=%lu flags=%08x udata=%d\n",
		   i, ovec[i], ovec[i].type, ovec[i].id, ovec[i].flags, ovec[i].udata);
	pd("----------------------------------------------------------\n");

	for (i = 0; i < rv; i++) {
		if (ovec[i].id == listenfd) {
			int fd;

			while ((fd = accept(listenfd, NULL, NULL)) >= 0) {
				ivec[arg.in_cnt].type = SYSEV_TYPE_READ;
				ivec[arg.in_cnt].id = fd;
				ivec[arg.in_cnt].flags = 0;
				ivec[arg.in_cnt].udata = 1096;
				arg.in_cnt++;
				nr_socks++;
			}
			if (errno != EAGAIN) {
				pd("accept failed (%d:%s)\n", errno, strerror(errno));
				return 1;
			}
		}
		else {
			int bread;
			do {
				if ((bread = read(ovec[i].id, buf,
						  sizeof(buf)-1)) < 0
				    && errno != EAGAIN) {
					pd("read failed for fd=%2lu (%d:%s)\n", ovec[i].id, errno, strerror(errno));
					return 1;
				}
				if (bread > 0) {
					buf[bread] = 0;
					pd("read done(fd=%02lu %3d bytes)\n", ovec[i].id, bread);
				}
				else
					pd("read done(fd=%02lu bread=%d)\n", ovec[i].id, bread);
			} while (bread == sizeof(buf)-1);

			if (ovec[i].flags & SYSEV_EOF) {
				nr_socks--;
				pd("ev->flags & SYSEV_EOF, nr_socks=%d\n", nr_socks);
				close(ovec[i].id);
			}
			else {
				ovec[i].flags = 0;
				ivec[arg.in_cnt++] = ovec[i];
			}
		}
	}
	goto retry;
}


************************************************************************
**** Patch follows, it's against 2.4.12. I'm gonna port it to upstream
**** kernel soon.

diff -uNr linux-2.4.12-debug/Documentation/Configure.help linux-2.4.12-sysevq/Documentation/Configure.help
--- linux-2.4.12-debug/Documentation/Configure.help	Thu Nov 22 10:40:08 2001
+++ linux-2.4.12-sysevq/Documentation/Configure.help	Wed Nov 28 14:17:38 2001
@@ -18886,6 +18886,12 @@
   To use this option, you have to check that the "/proc file system
   support" (CONFIG_PROC_FS) is enabled, too.
 
+System event queue support
+CONFIG_SYSEVQ
+  Enables system event queue, which can be used by doing ioctl to
+  /dev/sysevq. System event queue is basically similar to FreeBSD
+  kqueue or Solaris /dev/poll.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet, 
diff -uNr linux-2.4.12-debug/arch/i386/config.in linux-2.4.12-sysevq/arch/i386/config.in
--- linux-2.4.12-debug/arch/i386/config.in	Thu Nov 22 10:40:08 2001
+++ linux-2.4.12-sysevq/arch/i386/config.in	Wed Nov 28 14:17:38 2001
@@ -191,6 +191,7 @@
 comment 'General setup'
 
 bool 'Networking support' CONFIG_NET
+bool 'Sysevq support' CONFIG_SYSEVQ
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
diff -uNr linux-2.4.12-debug/arch/i386/kernel/entry.S linux-2.4.12-sysevq/arch/i386/kernel/entry.S
--- linux-2.4.12-debug/arch/i386/kernel/entry.S	Thu Nov 22 10:40:08 2001
+++ linux-2.4.12-sysevq/arch/i386/kernel/entry.S	Fri Jan  4 11:36:21 2002
@@ -646,6 +646,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
+	.long SYMBOL_NAME(sys_sysevq)		/* 225 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -uNr linux-2.4.12-debug/fs/fcntl.c linux-2.4.12-sysevq/fs/fcntl.c
--- linux-2.4.12-debug/fs/fcntl.c	Tue Sep 18 05:16:30 2001
+++ linux-2.4.12-sysevq/fs/fcntl.c	Mon Nov 26 11:17:09 2001
@@ -11,6 +11,9 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/iobuf.h>
+#ifdef CONFIG_SYSEVQ
+#include <linux/sysevq.h>
+#endif
 
 #include <asm/poll.h>
 #include <asm/siginfo.h>
@@ -136,6 +139,12 @@
 	int err = -EBADF;
 	struct file * file, *tofree;
 	struct files_struct * files = current->files;
+#ifdef CONFIG_SYSEVQ
+	struct ksysev *rev = NULL, *wev = NULL;
+	struct sysevq *evq = current->sysevq;
+
+	if (evq) sysevq_down(evq);
+#endif
 
 	write_lock(&files->file_lock);
 	if (!(file = fcheck(oldfd)))
@@ -165,10 +174,20 @@
 	if (!tofree && FD_ISSET(newfd, files->open_fds))
 		goto out_fput;
 
+#ifdef CONFIG_SYSEVQ
+	if (tofree && evq) sysevq_notify_close(newfd, &rev, &wev);
+#endif
 	files->fd[newfd] = file;
 	FD_SET(newfd, files->open_fds);
 	FD_CLR(newfd, files->close_on_exec);
 	write_unlock(&files->file_lock);
+#ifdef CONFIG_SYSEVQ
+	if (evq) {
+		sysevq_up(evq);
+		if (rev) free_sysev(rev);
+		if (wev) free_sysev(wev);
+	}
+#endif
 
 	if (tofree)
 		filp_close(tofree, files);
@@ -177,10 +196,16 @@
 	return err;
 out_unlock:
 	write_unlock(&files->file_lock);
+#ifdef CONFIG_SYSEVQ
+	if (evq) sysevq_up(evq);
+#endif
 	goto out;
 
 out_fput:
 	write_unlock(&files->file_lock);
+#ifdef CONFIG_SYSEVQ
+	if (evq) sysevq_up(evq);
+#endif
 	fput(file);
 	goto out;
 }
diff -uNr linux-2.4.12-debug/fs/open.c linux-2.4.12-sysevq/fs/open.c
--- linux-2.4.12-debug/fs/open.c	Sat Oct  6 04:23:53 2001
+++ linux-2.4.12-sysevq/fs/open.c	Mon Nov 26 11:17:09 2001
@@ -15,6 +15,9 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/iobuf.h>
+#ifdef CONFIG_SYSEVQ
+#include <linux/sysevq.h>
+#endif
 
 #include <asm/uaccess.h>
 
@@ -831,6 +834,12 @@
 {
 	struct file * filp;
 	struct files_struct *files = current->files;
+#ifdef CONFIG_SYSEVQ
+	struct ksysev *rev = NULL, *wev = NULL;
+	struct sysevq *evq = current->sysevq;
+
+	if (evq) sysevq_down(evq);
+#endif
 
 	write_lock(&files->file_lock);
 	if (fd >= files->max_fds)
@@ -838,14 +847,27 @@
 	filp = files->fd[fd];
 	if (!filp)
 		goto out_unlock;
+#ifdef CONFIG_SYSEVQ
+	if (evq) sysevq_notify_close(fd, &rev, &wev);
+#endif
 	files->fd[fd] = NULL;
 	FD_CLR(fd, files->close_on_exec);
 	__put_unused_fd(files, fd);
 	write_unlock(&files->file_lock);
+#ifdef CONFIG_SYSEVQ
+	if (evq) {
+		sysevq_up(evq);
+		if (rev) free_sysev(rev);
+		if (wev) free_sysev(wev);
+	}
+#endif
 	return filp_close(filp, files);
 
 out_unlock:
 	write_unlock(&files->file_lock);
+#ifdef CONFIG_SYSEVQ
+	if (evq) sysevq_up(evq);
+#endif
 	return -EBADF;
 }
 
diff -uNr linux-2.4.12-debug/include/asm-i386/unistd.h linux-2.4.12-sysevq/include/asm-i386/unistd.h
--- linux-2.4.12-debug/include/asm-i386/unistd.h	Tue Oct  9 02:40:16 2001
+++ linux-2.4.12-sysevq/include/asm-i386/unistd.h	Fri Jan  4 12:58:28 2002
@@ -229,6 +229,7 @@
 #define __NR_fcntl64		221
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
+#define __NR_sysevq		225
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
@@ -354,5 +355,7 @@
 }
 
 #endif
+
+static inline _syscall2(int,sysevq,unsigned int,cmd,unsigned long,arg)
 
 #endif /* _ASM_I386_UNISTD_H_ */
diff -uNr linux-2.4.12-debug/include/linux/major.h linux-2.4.12-sysevq/include/linux/major.h
--- linux-2.4.12-debug/include/linux/major.h	Tue Sep 18 15:23:40 2001
+++ linux-2.4.12-sysevq/include/linux/major.h	Mon Nov 26 13:18:50 2001
@@ -142,6 +142,7 @@
 
 #define RTF_MAJOR	150
 #define RAW_MAJOR	162
+#define SYSEVQ_MAJOR	164	/* Inofficial */
 
 #define USB_ACM_MAJOR		166
 #define USB_ACM_AUX_MAJOR	167
diff -uNr linux-2.4.12-debug/include/linux/sched.h linux-2.4.12-sysevq/include/linux/sched.h
--- linux-2.4.12-debug/include/linux/sched.h	Thu Nov 22 10:40:08 2001
+++ linux-2.4.12-sysevq/include/linux/sched.h	Wed Nov 28 14:17:39 2001
@@ -42,6 +42,7 @@
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
 #define CLONE_THREAD	0x00010000	/* Same thread group? */
+#define CLONE_SYSEVQ	0x00020000
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -401,6 +402,9 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+#ifdef CONFIG_SYSEVQ
+	struct sysevq *sysevq;
+#endif
 };
 
 /*
diff -uNr linux-2.4.12-debug/include/linux/sysevq.h linux-2.4.12-sysevq/include/linux/sysevq.h
--- linux-2.4.12-debug/include/linux/sysevq.h	Thu Jan  1 09:00:00 1970
+++ linux-2.4.12-sysevq/include/linux/sysevq.h	Fri Dec 21 10:00:47 2001
@@ -0,0 +1,136 @@
+/*
+ * Sysevq
+ *
+ * Copyright 2001, Aratech, Inc.
+ *
+ * Written by TeJun Huh (tejun@aratech.co.kr)
+ */
+
+#ifndef _LINUX_SYSEVQ_H
+#define _LINUX_SYSEVQ_H
+
+#ifndef __KERNEL__
+#define CONFIG_SYSEVQ
+#endif
+
+#ifdef CONFIG_SYSEVQ
+
+#ifndef __KERNEL__
+#include <sys/types.h>
+#endif
+
+typedef struct sysev {
+	int			type;
+	unsigned		flags;
+	unsigned long		id;
+	unsigned long		data;
+	unsigned long		udata;
+} sysev_t;
+
+typedef struct sysevq_ioctl_arg {
+	struct sysev *		in_evs;
+	int			in_cnt;
+	struct sysev *		out_evs;
+	int			out_cnt;
+} sysevq_ioctl_arg_t;
+
+/* Event types */
+#define SYSEV_TYPE_READ		0
+#define SYSEV_TYPE_WRITE	1
+
+/* Command/status flags */
+#define SYSEV_ENQ		0
+#define SYSEV_DEQ		1
+#define SYSEV_PERSIST		0x10
+#define SYSEV_EOF		0x20
+
+/* Ioctl cmds */
+#define SYSEVQ_DOIT	_IOW(0xac, 0, sizeof(struct sysevq_ioctl_arg))
+#define SYSEVQ_NBLK	_IOW(0xac, 1, sizeof(struct sysevq_ioctl_arg))
+
+
+/*
+ * Stuff internal to kernel
+ */
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <asm/bitops.h>
+
+/*#define SYSEVQ_DEBUG*/
+
+#ifdef SYSEVQ_DEBUG
+#define _pdsysevq(args...)	printk(args)
+#else
+#define _pdsysevq(args...)
+#endif
+#define pdsysevq(args...)	_pdsysevq(__FUNCTION__ ": " args)
+
+/* Flag masks */
+#define SYSEV_OP_MASK		0xf
+#define SYSEV_INPUT_MASK	(SYSEV_OP_MASK|SYSEV_PERSIST)
+#define SYSEV_OUTPUT_MASK	(SYSEV_INPUT_MASK|SYSEV_EOF)
+
+/* Sync flags */
+#define SYSEV_PENDING_BIT	0
+#define SYSEV_EOF_NOTIFIED_BIT	1
+
+/* Kernel sysev structure */
+struct ksysev {
+	struct sysev		uev;
+	unsigned		sync_flags;
+	struct sysevq *		evq;
+	struct sysev_ops *	ops;
+
+	struct list_head	all_list;	/* All list link */
+	struct list_head	pending_list;	/* Pending list link */
+	/*struct ksysev *	hash_next;*/	/* Hash list next */
+
+	struct list_head	source_list;	/* Source list link */
+	void *			source_data;	/* Source specific data */
+};
+
+void __notify_sysev(struct ksysev *ev, int eof);
+
+static inline void notify_sysev(struct ksysev *ev, int eof)
+{
+	if (eof)
+		set_bit(SYSEV_EOF_NOTIFIED_BIT, &ev->sync_flags);
+
+	if (!test_and_set_bit(SYSEV_PENDING_BIT, &ev->sync_flags))
+		__notify_sysev(ev, eof);
+}
+
+void notify_and_trim_sysevs(struct list_head *head, int eof);
+
+void sysevq_down(struct sysevq *evq);
+void sysevq_up(struct sysevq *evq);
+
+/* Caller must be holding evq->sem */
+void sysevq_notify_close(int fd, struct ksysev **rev, struct ksysev **wev);
+
+int copy_sysevq(unsigned long clone_flags, struct task_struct *tsk);
+void exit_sysevq(struct task_struct *tsk);
+void __exit_sysevq(struct task_struct *tsk);
+
+struct sysev_ops {
+	int		(*enq_sysev)(struct ksysev *ev);
+	void		(*deq_sysev)(struct ksysev *ev);
+};
+
+extern struct sysev_ops socket_sysev_rw_ops;
+
+struct ksysev * alloc_sysev(void);
+void free_sysev(struct ksysev *ev);
+
+int enq_sysev_direct(struct ksysev *ev);
+void deq_sysev_direct(struct ksysev *ev);
+
+#endif /* __KERNEL__ */
+#endif /* CONFIG_SYSEVQ */
+
+#ifndef __KERNEL__
+#undef CONFIG_SYSEVQ
+#endif
+#endif
diff -uNr linux-2.4.12-debug/include/net/sock.h linux-2.4.12-sysevq/include/net/sock.h
--- linux-2.4.12-debug/include/net/sock.h	Thu Oct 11 15:44:57 2001
+++ linux-2.4.12-sysevq/include/net/sock.h	Mon Nov 26 11:33:15 2001
@@ -102,6 +102,9 @@
 #ifdef CONFIG_FILTER
 #include <linux/filter.h>
 #endif
+#ifdef CONFIG_SYSEVQ
+#include <linux/sysevq.h>
+#endif
 
 #include <asm/atomic.h>
 #include <net/dst.h>
@@ -678,6 +681,11 @@
   	int			(*backlog_rcv) (struct sock *sk,
 						struct sk_buff *skb);  
 	void                    (*destruct)(struct sock *sk);
+#ifdef CONFIG_SYSEVQ
+	spinlock_t		sysev_spin;
+	struct list_head	read_sysev_head;
+	struct list_head	write_sysev_head;
+#endif
 };
 
 /* The per-socket spinlock must be held here. */
diff -uNr linux-2.4.12-debug/include/net/tcp.h linux-2.4.12-sysevq/include/net/tcp.h
--- linux-2.4.12-debug/include/net/tcp.h	Thu Oct 11 15:45:22 2001
+++ linux-2.4.12-sysevq/include/net/tcp.h	Mon Nov 26 11:33:40 2001
@@ -721,6 +721,11 @@
 extern struct sock *		tcp_accept(struct sock *sk, int flags, int *err);
 extern unsigned int		tcp_poll(struct file * file, struct socket *sock, struct poll_table_struct *wait);
 extern void			tcp_write_space(struct sock *sk); 
+#ifdef CONFIG_SYSEVQ
+extern void			tcp_state_change(struct sock *sk);
+extern void			tcp_data_ready(struct sock *sk, int bytes);
+extern void			tcp_error_report(struct sock *sk);
+#endif
 
 extern int			tcp_getsockopt(struct sock *sk, int level, 
 					       int optname, char *optval, 
diff -uNr linux-2.4.12-debug/kernel/Makefile linux-2.4.12-sysevq/kernel/Makefile
--- linux-2.4.12-debug/kernel/Makefile	Mon Sep 17 13:22:40 2001
+++ linux-2.4.12-sysevq/kernel/Makefile	Mon Nov 26 11:17:09 2001
@@ -19,6 +19,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SYSEVQ) += sysevq.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uNr linux-2.4.12-debug/kernel/exit.c linux-2.4.12-sysevq/kernel/exit.c
--- linux-2.4.12-debug/kernel/exit.c	Tue Sep 11 05:04:33 2001
+++ linux-2.4.12-sysevq/kernel/exit.c	Mon Nov 26 11:32:49 2001
@@ -15,6 +15,9 @@
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
+#ifdef CONFIG_SYSEVQ
+#include <linux/sysevq.h>
+#endif
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -189,11 +192,28 @@
 			break;
 		set = files->open_fds->fds_bits[j++];
 		while (set) {
-			if (set & 1) {
+			if (set & 1)
+#ifdef CONFIG_SYSEVQ
+			{
+				struct file *file = files->fd[i];
+				if (file) {
+					struct ksysev *rev, *wev;
+					if (current->sysevq) {
+						sysevq_notify_close(i, &rev, &wev);
+						if (rev) free_sysev(rev);
+						if (wev) free_sysev(wev);
+					}
+					filp_close(file, files);
+				}
+				files->fd[i] = NULL;
+			}
+#else
+			{
 				struct file * file = xchg(&files->fd[i], NULL);
 				if (file)
 					filp_close(file, files);
 			}
+#endif
 			i++;
 			set >>= 1;
 		}
@@ -445,6 +465,9 @@
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);
+#ifdef CONFIG_SYSEVQ
+	__exit_sysevq(tsk);
+#endif
 	exit_sighand(tsk);
 	exit_thread();
 
diff -uNr linux-2.4.12-debug/kernel/fork.c linux-2.4.12-sysevq/kernel/fork.c
--- linux-2.4.12-debug/kernel/fork.c	Tue Sep 18 13:46:04 2001
+++ linux-2.4.12-sysevq/kernel/fork.c	Mon Nov 26 11:30:38 2001
@@ -20,6 +20,9 @@
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
+#ifdef CONFIG_SYSEVQ
+#include <linux/sysevq.h>
+#endif
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -661,9 +664,13 @@
 		goto bad_fork_cleanup_fs;
 	if (copy_mm(clone_flags, p))
 		goto bad_fork_cleanup_sighand;
+#ifdef CONFIG_SYSEVQ
+	if (copy_sysevq(clone_flags, p))
+		goto bad_fork_cleanup_mm;
+#endif
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
-		goto bad_fork_cleanup_mm;
+		goto bad_fork_cleanup_sysevq;
 	p->semundo = NULL;
 	
 	/* Our parent execution domain becomes current domain
@@ -730,6 +737,8 @@
 fork_out:
 	return retval;
 
+bad_fork_cleanup_sysevq:
+	exit_sysevq(p);
 bad_fork_cleanup_mm:
 	exit_mm(p);
 bad_fork_cleanup_sighand:
diff -uNr linux-2.4.12-debug/kernel/sysevq.c linux-2.4.12-sysevq/kernel/sysevq.c
--- linux-2.4.12-debug/kernel/sysevq.c	Thu Jan  1 09:00:00 1970
+++ linux-2.4.12-sysevq/kernel/sysevq.c	Fri Jan  4 11:36:49 2002
@@ -0,0 +1,663 @@
+/*
+ * Sysevq implementation
+ *
+ * Copyright 2001, Aratech, Inc.
+ *
+ * Written by TeJun Huh (tejun@aratech.co.kr)
+ */
+
+#include <linux/config.h>
+#include <linux/sysevq.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/vmalloc.h>
+#include <linux/list.h>
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+
+struct evtbl_entry {
+	struct ksysev *		read_sysev;
+	struct ksysev *		write_sysev;
+};
+
+struct sysevq {
+	struct semaphore	sem;
+
+	struct list_head	all_head;
+	struct evtbl_entry *	evtbl;
+	int			evtbl_sz;
+	wait_queue_head_t	evtbl_expand_wait;
+
+	spinlock_t		pending_spin;	/* Protects pending_head */
+	struct list_head	pending_head;
+	wait_queue_head_t	pending_wait;
+
+	unsigned		flags;
+	atomic_t		refcnt;
+};
+
+#define SYSEVQ_EVTBL_EXPANDING 0x1
+
+static kmem_cache_t *ksysev_cache = NULL;
+
+static int sysevq_init_once(void) __init;
+
+static int init_sysevq(void);
+static int expand_evtbl(struct sysevq *evq, int nr);
+static int find_sysev(struct sysev *uev, struct ksysev **res, void **hint);
+static void register_to_evtbl(struct ksysev *ev);
+static void deregister_from_evtbl(struct ksysev *ev);
+
+static inline int __enq_sysev(struct ksysev *ev);
+static inline void __deq_sysev(struct ksysev *ev);
+static int process_in_evs(struct sysev *inv, int cnt);
+static int process_out_evs(struct sysev *outv, int cnt, int nblk);
+
+static int sysevq_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg);
+
+static struct file_operations sysevq_fops = {
+	ioctl:		sysevq_ioctl,
+};
+
+static int generic_enq_rw_sysev(struct ksysev *ev);
+static void generic_deq_rw_sysev(struct ksysev *ev);
+
+static struct sysev_ops generic_sysev_rw_ops = {
+	generic_enq_rw_sysev,
+	generic_deq_rw_sysev
+};
+
+static struct sysev_ops * sysev_ops[] = {
+	&generic_sysev_rw_ops,
+	&generic_sysev_rw_ops,
+};
+
+static int __init sysevq_init_once(void)
+{
+	ksysev_cache =
+		kmem_cache_create("ksysev_cache", sizeof(struct ksysev),
+				  0, 0, NULL, NULL);
+	if (!ksysev_cache)
+		panic("Cannot create ksysev SLAB cache");
+
+	register_chrdev(SYSEVQ_MAJOR, "sysevq", &sysevq_fops);
+
+	printk("sysevq: TeJun Huh / Aratech, Inc. <tejun@aratech.co.kr>\n");
+	return 0;
+}
+
+__initcall(sysevq_init_once);
+
+
+#define DFL_EVTBL_SZ		(8 * PAGE_SIZE)
+#define DFL_EVTBL_NR_BYTES	(DFL_EVTBL_SZ * sizeof(struct evtbl_entry))
+
+static int init_sysevq(void)
+{
+	struct sysevq *evq;
+	struct evtbl_entry *evtbl;
+
+	if (current->sysevq)
+		return 0;
+	if ((evq = kmalloc(sizeof(struct sysevq), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	if ((evtbl = vmalloc(DFL_EVTBL_NR_BYTES)) == NULL) {
+		kfree(evq);
+		return -ENOMEM;
+	}
+	memset(evtbl, 0, DFL_EVTBL_NR_BYTES);
+
+	sema_init(&evq->sem, 1);
+
+	INIT_LIST_HEAD(&evq->all_head);
+	evq->evtbl = evtbl;
+	evq->evtbl_sz = DFL_EVTBL_SZ;
+	init_waitqueue_head(&evq->evtbl_expand_wait);
+
+	evq->pending_spin = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&evq->pending_head);
+	init_waitqueue_head(&evq->pending_wait);
+
+	evq->flags = 0;
+	atomic_set(&evq->refcnt, 1);
+
+	current->sysevq = evq;
+	return 0;
+}
+
+static int expand_evtbl(struct sysevq *evq, int nr)
+{
+	struct evtbl_entry *oevtbl, *evtbl;
+	int oevtbl_sz, evtbl_sz;
+
+	if (evq->flags & SYSEVQ_EVTBL_EXPANDING) {
+		DECLARE_WAITQUEUE(wait, current);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		add_wait_queue(&evq->evtbl_expand_wait, &wait);
+		up(&evq->sem);
+		schedule();
+		down(&evq->sem);
+		remove_wait_queue(&evq->evtbl_expand_wait, &wait);
+		return 0;
+	}
+	evq->flags |= SYSEVQ_EVTBL_EXPANDING;
+	up(&evq->sem);
+
+	oevtbl = evq->evtbl;
+	oevtbl_sz = evtbl_sz = evq->evtbl_sz;
+	do {
+		evtbl_sz = evtbl_sz * 2;
+		if (evtbl_sz > NR_OPEN)
+			evtbl_sz = NR_OPEN;
+	} while (evtbl_sz <= nr);
+
+	evtbl = vmalloc(evtbl_sz * sizeof(struct evtbl_entry));
+	down(&evq->sem);
+	if (!evtbl) {
+		evq->flags &= ~SYSEVQ_EVTBL_EXPANDING;
+		wake_up_all(&evq->evtbl_expand_wait);
+		up(&evq->sem);
+		return -ENOMEM;
+	}
+	evq->flags &= ~SYSEVQ_EVTBL_EXPANDING;
+	memcpy(evtbl, oevtbl, oevtbl_sz * sizeof(struct evtbl_entry));
+	memset(evtbl + oevtbl_sz, 0, (evtbl_sz - oevtbl_sz) * sizeof(struct evtbl_entry));
+	evq->evtbl = evtbl;
+	evq->evtbl_sz = evtbl_sz;
+	wake_up_all(&evq->evtbl_expand_wait);
+	up(&evq->sem);
+	vfree(oevtbl);
+	return 0;
+}
+
+static int find_sysev(struct sysev *uev, struct ksysev **res, void **hint)
+{
+	int type = uev->type;
+	unsigned long id = uev->id;
+	struct files_struct *files = current->files;
+	struct sysevq *evq = current->sysevq;
+	int err;
+
+ retry:
+	switch (type) {
+	case SYSEV_TYPE_READ:
+	case SYSEV_TYPE_WRITE:
+		read_lock(&current->files->file_lock);
+		if (id >= files->max_fds || !files->fd[id]) {
+			read_unlock(&current->files->file_lock);
+			return -EBADF;
+		}
+		if (id >= evq->evtbl_sz) {
+			read_unlock(&current->files->file_lock);
+			err = expand_evtbl(evq, id);
+			if (err < 0)
+				return err;
+			goto retry;
+		}
+		*hint = files->fd[id];
+		*res = type == SYSEV_TYPE_READ ?
+			evq->evtbl[id].read_sysev : evq->evtbl[id].write_sysev;
+		read_unlock(&current->files->file_lock);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void register_to_evtbl(struct ksysev *ev)
+{
+	int type = ev->uev.type;
+	unsigned long id = ev->uev.id;
+	struct sysevq *evq = ev->evq;
+
+	if (id >= evq->evtbl_sz)
+		BUG();
+
+	switch (type) {
+	case SYSEV_TYPE_READ:
+		if (evq->evtbl[id].read_sysev)
+			BUG();
+		evq->evtbl[id].read_sysev = ev;
+		return;
+	case SYSEV_TYPE_WRITE:
+		if (evq->evtbl[id].write_sysev)
+			BUG();
+		evq->evtbl[id].write_sysev = ev;
+		return;
+	default:
+		return;
+	}
+}
+
+static void deregister_from_evtbl(struct ksysev *ev)
+{
+	int type = ev->uev.type;
+	unsigned long id = ev->uev.id;
+	struct sysevq *evq = ev->evq;
+
+	if (id >= evq->evtbl_sz)
+		BUG();
+
+	switch (type) {
+	case SYSEV_TYPE_READ:
+		if (evq->evtbl[id].read_sysev != ev)
+			BUG();
+		evq->evtbl[id].read_sysev = NULL;
+		return;
+	case SYSEV_TYPE_WRITE:
+		if (evq->evtbl[id].write_sysev != ev)
+			BUG();
+		evq->evtbl[id].write_sysev = NULL;
+		return;
+	default:
+		return;
+	}
+}
+
+static inline int __enq_sysev(struct ksysev *ev)
+{
+	int err;
+	list_add(&ev->all_list, ev->evq->all_head.prev);
+	register_to_evtbl(ev);
+
+	ev->ops = sysev_ops[ev->uev.type];
+	err = ev->ops->enq_sysev(ev);
+	if (err < 0) {
+		list_del(&ev->all_list);
+		deregister_from_evtbl(ev);
+	}
+	return err;
+}
+
+static inline void __deq_sysev(struct ksysev *ev)
+{
+	ev->ops->deq_sysev(ev);		/* Might be bogus */
+	if (test_bit(SYSEV_PENDING_BIT, &ev->sync_flags)) {
+		spin_lock_bh(&ev->evq->pending_spin);
+		list_del(&ev->pending_list);
+		spin_unlock_bh(&ev->evq->pending_spin);
+	}
+	deregister_from_evtbl(ev);
+	list_del(&ev->all_list);
+}
+
+static int process_in_evs(struct sysev *in_evs, int cnt)
+{
+	int i, err;
+	struct sysevq *evq = current->sysevq;
+	struct sysev uev;
+	struct ksysev *ev, *free_ev = NULL;
+
+	for (i = 0; i < cnt; i++) {
+		int is_enq;
+		void *hint;
+
+		if ((err = __copy_from_user(&uev, &in_evs[i], sizeof(uev))) < 0)
+			return err;
+
+		pdsysevq("type=%08x id=%lu flags=%08x evq=%p (%d/%d)\n",
+			 uev.type, uev.id, uev.flags, evq, i + 1, cnt);
+
+		is_enq = (in_evs[i].flags & SYSEV_OP_MASK) == SYSEV_ENQ;
+
+		if (uev.flags & ~SYSEV_INPUT_MASK)
+			return -EINVAL;
+
+		if (is_enq) {
+			free_ev = (struct ksysev *)kmem_cache_alloc(ksysev_cache, SLAB_KERNEL);
+			if (!free_ev)
+				return -ENOMEM;
+		}
+
+		down(&evq->sem);
+
+		if ((err = find_sysev(&uev, &ev, &hint)) < 0)
+			goto out_unlock;
+		if (is_enq) {
+			if (ev) {
+				err = -EBUSY;
+				goto out_unlock;
+			}
+			ev = free_ev;
+			ev->uev = uev;
+			uev.flags &= ~SYSEV_OP_MASK;
+			ev->sync_flags = 0;
+			ev->evq = evq;
+			ev->source_data = hint;
+			if ((err = __enq_sysev(ev)) < 0)
+				goto out_unlock;
+			else
+				free_ev = NULL;
+		}
+		else {
+			if (!ev) {
+				err = -ENOENT;
+				goto out_unlock;
+			}
+			__deq_sysev(ev);
+			free_ev = ev;
+		}
+		up(&evq->sem);
+		if (free_ev)
+			kmem_cache_free(ksysev_cache, free_ev);
+	}
+	return 0;
+
+ out_unlock:
+	up(&evq->sem);
+	if (free_ev)
+		kmem_cache_free(ksysev_cache, free_ev);
+	return err;
+}
+
+static int process_out_evs(struct sysev *out_evs, int cnt, int nblk)
+{
+	struct sysevq *evq = current->sysevq;
+	struct list_head tmp_head;
+	struct list_head *cur, *tmp;
+	struct ksysev *ev;
+	int nr_pending = 0, first = 1;
+
+	pdsysevq("out_evs=%p, cnt=%d, nblk=%d\n",
+		 out_evs, cnt, nblk);
+
+	INIT_LIST_HEAD(&tmp_head);
+
+	down(&evq->sem);
+	spin_lock_bh(&evq->pending_spin);
+ retry:
+	list_for_each_safe(cur, tmp, &evq->pending_head) {
+		if (nr_pending >= cnt)
+			break;
+		nr_pending++;
+		ev = list_entry(cur, struct ksysev, pending_list);
+		list_del(&ev->pending_list);
+		list_add(&ev->pending_list, tmp_head.prev);
+	}
+	
+	if (nr_pending) {
+		int err = 0, i = 0;
+		spin_unlock_bh(&evq->pending_spin);
+		list_for_each_safe(cur, tmp, &tmp_head) {
+			ev = list_entry(cur, struct ksysev, pending_list);
+			pdsysevq("type=%08x id=%lu flags=%08x evq=%p (%d/%d)\n",
+				 ev->uev.type, ev->uev.id, ev->uev.flags, evq, i + 1, cnt);
+			if (!err)
+				err = __copy_to_user(&out_evs[i++], &ev->uev,
+						     sizeof(ev->uev));
+			if (ev->uev.flags & SYSEV_PERSIST) {
+				list_del(&ev->pending_list);
+				clear_bit(SYSEV_PENDING_BIT, &ev->sync_flags);
+				if (test_bit(SYSEV_EOF_NOTIFIED_BIT, &ev->sync_flags)
+				    && !(ev->uev.flags & SYSEV_EOF))
+					notify_sysev(ev, 1);
+			}
+		}
+		list_for_each(cur, &tmp_head) {
+			ev = list_entry(cur, struct ksysev, pending_list);
+			deregister_from_evtbl(ev);
+			list_del(&ev->all_list);
+		}
+		up(&evq->sem);
+		list_for_each_safe(cur, tmp, &tmp_head) {
+			ev = list_entry(cur, struct ksysev, pending_list);
+			kmem_cache_free(ksysev_cache, ev);
+		}
+		pdsysevq("nr_pending=%d\n", nr_pending);
+		return err ? err : nr_pending;
+	}
+	else if (first && !nblk) {
+		DECLARE_WAITQUEUE(wait, current);
+		first = 0;
+		__set_current_state(TASK_INTERRUPTIBLE);
+		add_wait_queue(&evq->pending_wait, &wait);
+		spin_unlock_bh(&evq->pending_spin);
+		up(&evq->sem);
+		schedule();
+		down(&evq->sem);
+		spin_lock_bh(&evq->pending_spin);
+		remove_wait_queue(&evq->pending_wait, &wait);
+		goto retry;
+	}
+	else {
+		spin_unlock_bh(&evq->pending_spin);
+		up(&evq->sem);
+		return nblk ? 0 : -EINTR;
+	}
+}
+
+void __notify_sysev(struct ksysev *ev, int eof)
+{
+	struct sysevq *evq = ev->evq;
+	
+	pdsysevq("ev=%p type=%08x id=%lu flags=%08x sync_flags=%08x udata=%lu eof=%d\n",
+		 ev, ev->uev.type, ev->uev.id, ev->uev.flags, ev->sync_flags, ev->uev.udata, eof);
+	if (eof) {
+		if (ev->uev.flags & SYSEV_EOF) {
+			clear_bit(SYSEV_PENDING_BIT, &ev->sync_flags);
+			return;
+		}
+		ev->uev.flags |= SYSEV_EOF;
+	}
+	spin_lock_bh(&evq->pending_spin);
+	list_add(&ev->pending_list, evq->pending_head.prev);
+	wake_up_all(&evq->pending_wait);
+	spin_unlock_bh(&evq->pending_spin);
+}
+
+void notify_and_trim_sysevs(struct list_head *head, int eof)
+{
+	struct list_head *cur, *tmp;
+	struct ksysev *ev;
+
+	list_for_each_safe(cur, tmp, head) {
+		ev = list_entry(cur, struct ksysev, source_list);
+		if (!(ev->uev.flags & SYSEV_PERSIST))
+			list_del(cur);
+		notify_sysev(ev, eof);
+	}
+}
+
+void sysevq_down(struct sysevq *evq)
+{
+	down(&evq->sem);
+}
+
+void sysevq_up(struct sysevq *evq)
+{
+	up(&evq->sem);
+}
+
+/* Caller must be holding evq->sem */
+void sysevq_notify_close(int fd, struct ksysev **rev, struct ksysev **wev)
+{
+	struct sysevq *evq = current->sysevq;
+	pdsysevq("evq=%p fd=%d\n", evq, fd);
+
+	if (fd >= evq->evtbl_sz)
+		return;
+
+	*rev = evq->evtbl[fd].read_sysev;
+	if (*rev) {
+		pdsysevq("fd=%d dequeueing read_sysev %p, source_data=%p\n",
+			 fd, *rev, (*rev)->source_data);
+		__deq_sysev(evq->evtbl[fd].read_sysev);
+	}
+
+	*wev = evq->evtbl[fd].write_sysev;
+	if (*wev) {
+		pdsysevq("fd=%d dequeueing write_sysev %p, source_data=%p\n",
+			 fd, *wev, (*wev)->source_data);
+		__deq_sysev(evq->evtbl[fd].write_sysev);
+	}
+}
+
+asmlinkage int sys_sysevq(unsigned int cmd, unsigned long arg)
+{
+	return sysevq_ioctl(NULL, NULL, cmd, arg);
+}
+
+static int sysevq_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long _arg)
+{
+	struct sysevq *evq;
+	struct sysevq_ioctl_arg *arg = (struct sysevq_ioctl_arg *)_arg;
+	int err, nblk;
+
+	if (current->sysevq == NULL && (err = init_sysevq()) < 0)
+		return err;
+	evq = current->sysevq;
+
+	nblk = 0;
+	switch (cmd) {
+	case SYSEVQ_NBLK:
+		nblk = 1;
+	case SYSEVQ_DOIT:
+		pdsysevq("cmd=%08x in_cnt=%d in_evs=%p out_cnt=%d out_evs=%p nblk=%d\n",
+			 cmd, arg->in_cnt, arg->in_evs, arg->out_cnt, arg->out_evs, nblk);
+		/* Verify input/output vectors */
+		if (verify_area(VERIFY_READ, arg->in_evs, arg->in_cnt * sizeof(struct sysev)) < 0 ||
+		    verify_area(VERIFY_WRITE, arg->out_evs, arg->out_cnt * sizeof(struct sysev)) < 0)
+			return -EFAULT;
+
+		/* Process inputs */
+		if (arg->in_cnt) {
+			err = process_in_evs(arg->in_evs, arg->in_cnt);
+			if (err < 0)
+				return err;
+		}
+
+		/* Process outputs */
+		return process_out_evs(arg->out_evs, arg->out_cnt, nblk);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int generic_enq_rw_sysev(struct ksysev *ev)
+{
+	struct file *file = (struct file *)ev->source_data;
+
+	if (file->f_dentry->d_inode->i_sock) {
+		ev->ops = &socket_sysev_rw_ops;
+		return ev->ops->enq_sysev(ev);
+	}
+	return -EINVAL;
+}
+
+/*
+ * rw_deq_sysev is _always_ overridden.
+ */
+static void generic_deq_rw_sysev(struct ksysev *ev)
+{
+	printk(KERN_ERR "This function should never be called\n");
+	BUG();
+}
+
+
+/*
+ * Other utility routines
+ */
+struct ksysev * alloc_sysev(void)
+{
+	return (struct ksysev *)kmem_cache_alloc(ksysev_cache, SLAB_KERNEL);
+}
+
+void free_sysev(struct ksysev *ev)
+{
+	kmem_cache_free(ksysev_cache, ev);
+}
+
+int enq_sysev_direct(struct ksysev *ev)
+{
+	int err;
+	if (current->sysevq == NULL && (err = init_sysevq()) < 0)
+		return err;
+	if (ev->evq == NULL)
+		ev->evq = current->sysevq;
+	ev->uev.flags &= SYSEV_INPUT_MASK & ~SYSEV_OP_MASK;
+	ev->sync_flags = 0;
+	down(&ev->evq->sem);
+	list_add(&ev->all_list, ev->evq->all_head.prev);
+	register_to_evtbl(ev);
+	up(&ev->evq->sem);
+	return 0;
+}
+
+void deq_sysev_direct(struct ksysev *ev)
+{
+	down(&ev->evq->sem);
+	if (test_bit(SYSEV_PENDING_BIT, &ev->sync_flags)) {
+		spin_lock_bh(&ev->evq->pending_spin);
+		list_del(&ev->pending_list);
+		spin_unlock_bh(&ev->evq->pending_spin);
+	}
+	deregister_from_evtbl(ev);
+	list_del(&ev->all_list);
+	up(&ev->evq->sem);
+}
+
+int copy_sysevq(unsigned long clone_flags, struct task_struct *tsk)
+{
+	int err;
+
+	tsk->sysevq = NULL;
+
+	if (!(clone_flags & CLONE_SYSEVQ))
+		return 0;
+
+	if (!(clone_flags & CLONE_FILES))
+		return -EINVAL;
+
+	if (current->sysevq == NULL && (err = init_sysevq()) < 0)
+		return err;
+
+	tsk->sysevq = current->sysevq;
+	atomic_inc(&tsk->sysevq->refcnt);
+	pdsysevq("sharing sysevq %d->%d, refcnt=%d\n",
+		 current->pid, tsk->pid, atomic_read(&tsk->sysevq->refcnt));
+	return 0;
+}
+
+void __exit_sysevq(struct task_struct *tsk)
+{
+	struct sysevq *evq = tsk->sysevq;
+	struct ksysev *ev;
+	struct list_head *cur, *tmp;
+
+	if (!evq)
+		return;
+
+	pdsysevq("tsk=%p evq=%p, refcnt=%d\n",
+		 tsk, evq, atomic_read(&tsk->sysevq->refcnt));
+
+	tsk->sysevq = NULL;
+
+	if (!atomic_dec_and_test(&evq->refcnt))
+		return;
+
+	/* No need to grab spins at this point. We're the only thread
+	   messing with this sysevq, and type handlers don't access
+	   all_list. */
+	list_for_each_safe(cur, tmp, &evq->all_head) {
+		ev = list_entry(cur, struct ksysev, all_list);
+		if (ev->uev.flags & SYSEV_PERSIST
+		    || !test_bit(SYSEV_PENDING_BIT, &ev->sync_flags))
+			ev->ops->deq_sysev(ev);
+		kmem_cache_free(ksysev_cache, ev);
+	}
+	vfree(evq->evtbl);
+	kfree(evq);
+}
+
+void exit_sysevq(struct task_struct *tsk)
+{
+	__exit_sysevq(tsk);
+}
diff -uNr linux-2.4.12-debug/net/core/sock.c linux-2.4.12-sysevq/net/core/sock.c
--- linux-2.4.12-debug/net/core/sock.c	Sun Jul 29 04:12:38 2001
+++ linux-2.4.12-sysevq/net/core/sock.c	Mon Nov 26 11:17:09 2001
@@ -592,6 +592,11 @@
 		sk->family = family;
 		sock_lock_init(sk);
 	}
+#ifdef CONFIG_SYSEVQ
+	sk->sysev_spin = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&sk->read_sysev_head);
+	INIT_LIST_HEAD(&sk->write_sysev_head);
+#endif
 
 	return sk;
 }
@@ -610,6 +615,12 @@
 	if (filter) {
 		sk_filter_release(sk, filter);
 		sk->filter = NULL;
+	}
+#endif
+#ifdef CONFIG_SYSEVQ
+	if (!list_empty(&sk->read_sysev_head) || !list_empty(&sk->write_sysev_head)) {
+		printk(KERN_ERR "sk_free: sysev_head's are not empty. sk=%p\n", sk);
+		BUG();
 	}
 #endif
 
diff -uNr linux-2.4.12-debug/net/ipv4/tcp.c linux-2.4.12-sysevq/net/ipv4/tcp.c
--- linux-2.4.12-debug/net/ipv4/tcp.c	Thu Oct 11 15:42:47 2001
+++ linux-2.4.12-sysevq/net/ipv4/tcp.c	Mon Nov 26 11:17:09 2001
@@ -457,6 +457,59 @@
 	return mask;
 }
 
+#ifdef CONFIG_SYSEVQ
+
+void tcp_state_change(struct sock *sk)
+{
+	read_lock(&sk->callback_lock);
+	if (sk->sleep && waitqueue_active(sk->sleep))
+		wake_up_interruptible_all(sk->sleep);
+	read_unlock(&sk->callback_lock);
+
+	if (sk->state != TCP_ESTABLISHED) {
+		spin_lock_bh(&sk->sysev_spin);
+		notify_and_trim_sysevs(&sk->read_sysev_head, 1);
+		notify_and_trim_sysevs(&sk->write_sysev_head, 1);
+		spin_unlock_bh(&sk->sysev_spin);
+	}
+	else {
+		/* This path reports connect. */
+		spin_lock_bh(&sk->sysev_spin);
+		notify_and_trim_sysevs(&sk->write_sysev_head, 0);
+		spin_unlock_bh(&sk->sysev_spin);
+	}
+}
+
+void tcp_error_report(struct sock *sk)
+{
+	read_lock(&sk->callback_lock);
+	if (sk->sleep && waitqueue_active(sk->sleep))
+		wake_up_interruptible(sk->sleep);
+	sk_wake_async(sk,0,POLL_ERR); 
+	read_unlock(&sk->callback_lock);
+
+	if (sk->state != TCP_ESTABLISHED) {
+		spin_lock_bh(&sk->sysev_spin);
+		notify_and_trim_sysevs(&sk->read_sysev_head, 1);
+		notify_and_trim_sysevs(&sk->write_sysev_head, 1);
+		spin_unlock_bh(&sk->sysev_spin);
+	}
+}
+
+void tcp_data_ready(struct sock *sk, int bytes)
+{
+	read_lock(&sk->callback_lock);
+	if (sk->sleep && waitqueue_active(sk->sleep))
+		wake_up_interruptible(sk->sleep);
+	sk_wake_async(sk,1,POLL_IN);
+	read_unlock(&sk->callback_lock);
+
+	spin_lock_bh(&sk->sysev_spin);
+	notify_and_trim_sysevs(&sk->read_sysev_head, 0);
+	spin_unlock_bh(&sk->sysev_spin);
+}
+#endif
+
 /*
  *	TCP socket write_space callback.
  */
@@ -472,6 +525,11 @@
 
 		if (sock->fasync_list && !(sk->shutdown&SEND_SHUTDOWN))
 			sock_wake_async(sock, 2, POLL_OUT);
+#ifdef CONFIG_SYSEVQ
+		spin_lock_bh(&sk->sysev_spin);
+		notify_and_trim_sysevs(&sk->write_sysev_head, 0);
+		spin_unlock_bh(&sk->sysev_spin);
+#endif
 	}
 }
 
diff -uNr linux-2.4.12-debug/net/ipv4/tcp_ipv4.c linux-2.4.12-sysevq/net/ipv4/tcp_ipv4.c
--- linux-2.4.12-debug/net/ipv4/tcp_ipv4.c	Tue Oct  2 01:19:56 2001
+++ linux-2.4.12-sysevq/net/ipv4/tcp_ipv4.c	Mon Nov 26 11:17:09 2001
@@ -1910,6 +1910,11 @@
 
 	sk->state = TCP_CLOSE;
 
+#ifdef CONFIG_SYSEVQ
+	sk->state_change = tcp_state_change;
+	sk->data_ready = tcp_data_ready;
+	sk->error_report = tcp_error_report;
+#endif
 	sk->write_space = tcp_write_space;
 	sk->use_write_queue = 1;
 
diff -uNr linux-2.4.12-debug/net/ipv4/tcp_minisocks.c linux-2.4.12-sysevq/net/ipv4/tcp_minisocks.c
--- linux-2.4.12-debug/net/ipv4/tcp_minisocks.c	Tue Oct  2 01:19:57 2001
+++ linux-2.4.12-sysevq/net/ipv4/tcp_minisocks.c	Mon Nov 26 11:17:09 2001
@@ -682,6 +682,11 @@
 		if ((filter = newsk->filter) != NULL)
 			sk_filter_charge(newsk, filter);
 #endif
+#ifdef CONFIG_SYSEVQ
+		newsk->sysev_spin = SPIN_LOCK_UNLOCKED;
+		INIT_LIST_HEAD(&newsk->read_sysev_head);
+		INIT_LIST_HEAD(&newsk->write_sysev_head);
+#endif
 
 		/* Now setup tcp_opt */
 		newtp = &(newsk->tp_pinfo.af_tcp);
diff -uNr linux-2.4.12-debug/net/ipv4/udp.c linux-2.4.12-sysevq/net/ipv4/udp.c
--- linux-2.4.12-debug/net/ipv4/udp.c	Sat Sep  8 03:01:21 2001
+++ linux-2.4.12-sysevq/net/ipv4/udp.c	Mon Nov 26 11:17:09 2001
@@ -802,6 +802,11 @@
 		return -1;
 	}
 	UDP_INC_STATS_BH(UdpInDatagrams);
+#ifdef CONFIG_SYSEVQ
+	spin_lock_bh(&sk->sysev_spin);
+	notify_and_trim_sysevs(&sk->read_sysev_head, 0);
+	spin_unlock_bh(&sk->sysev_spin);
+#endif
 	return 0;
 }
 
@@ -1006,12 +1011,32 @@
 	return len;
 }
 
+#ifdef CONFIG_SYSEVQ
+void udp_write_space(struct sock *sk)
+{
+	if (sock_writeable(sk)) {
+		spin_lock_bh(&sk->sysev_spin);
+		notify_and_trim_sysevs(&sk->write_sysev_head, 0);
+		spin_unlock_bh(&sk->sysev_spin);
+	}
+}
+
+static int udp_v4_init_sock(struct sock *sk)
+{
+	sk->write_space = udp_write_space;
+	return 0;
+}
+#endif
+
 struct proto udp_prot = {
  	name:		"UDP",
 	close:		udp_close,
 	connect:	udp_connect,
 	disconnect:	udp_disconnect,
 	ioctl:		udp_ioctl,
+#ifdef CONFIG_SYSEVQ
+	init:		udp_v4_init_sock,
+#endif
 	setsockopt:	ip_setsockopt,
 	getsockopt:	ip_getsockopt,
 	sendmsg:	udp_sendmsg,
diff -uNr linux-2.4.12-debug/net/socket.c linux-2.4.12-sysevq/net/socket.c
--- linux-2.4.12-debug/net/socket.c	Sat Sep 29 10:03:48 2001
+++ linux-2.4.12-sysevq/net/socket.c	Mon Nov 26 11:17:09 2001
@@ -1764,3 +1764,92 @@
 		len = 0;
 	return len;
 }
+
+#ifdef CONFIG_SYSEVQ
+
+static int socket_enq_rw_sysev(struct ksysev *ev)
+{
+	struct file *file = (struct file *)ev->source_data;
+	struct socket *sock;
+	struct sock *sk;
+	struct list_head *head;
+	int is_read, read_eof, notified;
+	unsigned int mask;
+
+	pdsysevq("ev=%p type=%08x id=%lu flags=%08x\n",
+		 ev, ev->uev.type, ev->uev.id, ev->uev.flags);
+
+	sock = &file->f_dentry->d_inode->u.socket_i;
+	sk = sock->sk;
+	ev->source_data = (void *)sk;
+
+	is_read = ev->uev.type == SYSEV_TYPE_READ;
+	head = is_read ? &sk->read_sysev_head : &sk->write_sysev_head;
+
+	read_eof = 0;
+	if (is_read && sk->shutdown & RCV_SHUTDOWN) {
+		int bytes_readable, rv;
+		mm_segment_t old_fs;
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		if ((rv = sock->ops->ioctl(sock, FIONREAD, (unsigned long)&bytes_readable)) < 0)
+			bytes_readable = 1;
+		set_fs(old_fs);
+		if (!bytes_readable)
+			read_eof = 1;
+	}
+
+	spin_lock_bh(&sk->sysev_spin);
+
+	notified = 1;
+	if (read_eof)
+		notify_sysev(ev, 1);
+	else {
+		mask = sock->file->f_op->poll(sock->file, NULL);
+		if (mask & (POLLERR|POLLHUP))
+			notify_sysev(ev, 1);
+		else if ((is_read && (mask & (POLLIN|POLLRDNORM)))
+			 || (!is_read && (mask & (POLLOUT|POLLWRNORM))))
+			notify_sysev(ev, 0);
+		else
+			notified = 0;
+	}
+	if (!notified || (ev->uev.flags & SYSEV_PERSIST))
+		list_add(&ev->source_list, head);
+
+	spin_unlock_bh(&sk->sysev_spin);
+
+	return 0;
+}
+
+void socket_deq_rw_sysev(struct ksysev *ev)
+{
+	struct sock *sk;
+	struct ksysev *tev;
+	struct list_head *head, *cur;
+
+	pdsysevq("ev=%p type=%08x id=%lu\n", ev, ev->uev.type, ev->uev.id);
+
+	sk = (struct sock *)ev->source_data;
+	head = ev->uev.type == SYSEV_TYPE_READ ?
+		&sk->read_sysev_head : &sk->write_sysev_head;
+
+	spin_lock_bh(&sk->sysev_spin);
+
+	tev = NULL;
+	list_for_each(cur, head) {
+		tev = list_entry(cur, struct ksysev, source_list);
+		if (tev == ev)
+			break;
+	}
+	if (tev == ev)
+		list_del(cur);
+
+	spin_unlock_bh(&sk->sysev_spin);
+}
+
+struct sysev_ops socket_sysev_rw_ops = {
+	socket_enq_rw_sysev,
+	socket_deq_rw_sysev,
+};
+#endif

