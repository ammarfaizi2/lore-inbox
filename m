Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVCJOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVCJOSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVCJOSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:18:00 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:45264 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262617AbVCJORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:17:12 -0500
Subject: [patch 1/1] /proc/$$/ipaddr and per-task networking bits
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-IMP: AR MAPS ORDB: 0.00,AR XBL: 0.00,AR SORBS: 0.00,AR AHBL: 0.00,AR
	SPAMCOP: 0.00,AR CBL: 0.00,AR SBL: 0.00,AV NONE,CLOUDMARK: 0.00
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wNlQd9/uYt6yRYpF5/V1"
Date: Thu, 10 Mar 2005 15:16:42 +0100
Message-Id: <1110464202.9190.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wNlQd9/uYt6yRYpF5/V1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ported feature from grSecurity that makes possible to add an ipaddr
entry in each /proc/<pid> (/proc/<pid>/ipaddr), where the task originating
IP address is stored, and subsequently made available (readable) by the pro=
cess
itself and also the root user with CAP_DAC_OVERRIDE capability (that can be=
 managed
by specific security models implementations like SELinux).
Available also at http://pearls.tuxedo-es.org/patches/task-curr_ip.patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 linux-2.6.11-lorenzo/fs/Kconfig            |   16 ++
 linux-2.6.11-lorenzo/fs/proc/array.c       |   10 +
 linux-2.6.11-lorenzo/fs/proc/base.c        |   12 ++
 linux-2.6.11-lorenzo/fs/proc/internal.h    |    3=20
 linux-2.6.11-lorenzo/include/linux/sched.h |    8 +
 linux-2.6.11-lorenzo/kernel/exit.c         |    8 +
 linux-2.6.11-lorenzo/net/Makefile          |    4=20
 linux-2.6.11-lorenzo/net/ipv4/tcp_ipv4.c   |   14 ++
 linux-2.6.11-lorenzo/net/proc_ipaddr.c     |  166 ++++++++++++++++++++++++=
+++++
 linux-2.6.11-lorenzo/net/socket.c          |    2=20
 10 files changed, 243 insertions(+)

diff -puN fs/proc/base.c~task-curr_ip fs/proc/base.c
--- linux-2.6.11/fs/proc/base.c~task-curr_ip	2005-03-10 14:56:13.931854168 =
+0100
+++ linux-2.6.11-lorenzo/fs/proc/base.c	2005-03-10 14:56:14.048836384 +0100
@@ -74,6 +74,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
 #endif
+#ifdef CONFIG_PROC_IPADDR
+	PROC_TGID_IPADDR,
+#endif
 	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
@@ -134,6 +137,9 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_MOUNTS,    "mounts",  S_IFREG|S_IRUGO),
+#ifdef CONFIG_PROC_IPADDR
+	E(PROC_TGID_IPADDR,     "ipaddr",  S_IFREG|S_IRUSR),
+#endif
 #ifdef CONFIG_SECURITY
 	E(PROC_TGID_ATTR,      "attr",    S_IFDIR|S_IRUGO|S_IXUGO),
 #endif
@@ -1416,6 +1422,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop =3D &proc_info_file_operations;
 			ei->op.proc_read =3D proc_pid_status;
 			break;
+#ifdef CONFIG_PROC_IPADDR
+		case PROC_TGID_IPADDR:
+			inode->i_fop =3D &proc_info_file_operations;
+			ei->op.proc_read =3D proc_pid_ipaddr;
+			break;
+#endif
 		case PROC_TID_STAT:
 			inode->i_fop =3D &proc_info_file_operations;
 			ei->op.proc_read =3D proc_tid_stat;
diff -puN fs/proc/internal.h~task-curr_ip fs/proc/internal.h
--- linux-2.6.11/fs/proc/internal.h~task-curr_ip	2005-03-10 14:56:13.932854=
016 +0100
+++ linux-2.6.11-lorenzo/fs/proc/internal.h	2005-03-10 14:56:14.048836384 +=
0100
@@ -36,6 +36,9 @@ extern int proc_tid_stat(struct task_str
 extern int proc_tgid_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
+#ifdef CONFIG_PROC_IPADDR
+extern int proc_pid_ipaddr(struct task_struct*,char*);
+#endif
=20
 static inline struct task_struct *proc_task(struct inode *inode)
 {
diff -puN fs/proc/array.c~task-curr_ip fs/proc/array.c
--- linux-2.6.11/fs/proc/array.c~task-curr_ip	2005-03-10 14:56:13.934853712=
 +0100
+++ linux-2.6.11-lorenzo/fs/proc/array.c	2005-03-10 14:56:14.048836384 +010=
0
@@ -473,3 +473,13 @@ int proc_pid_statm(struct task_struct *t
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+#ifdef CONFIG_PROC_IPADDR
+int proc_pid_ipaddr(struct task_struct *task, char * buffer)
+{
+	int len;
+
+	len =3D sprintf(buffer, "%u.%u.%u.%u\n", NIPQUAD(task->curr_ip));
+	return len;
+}
+#endif
diff -puN fs/Kconfig~task-curr_ip fs/Kconfig
--- linux-2.6.11/fs/Kconfig~task-curr_ip	2005-03-10 14:56:13.936853408 +010=
0
+++ linux-2.6.11-lorenzo/fs/Kconfig	2005-03-10 14:56:14.049836232 +0100
@@ -716,6 +716,22 @@ config PROC_FS
 config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
 	depends on PROC_FS && MMU
+=09
+config PROC_IPADDR
+	bool "/proc/<pid>/ipaddr support"
+	depends on PROC_FS && NET && INET
+	help
+	  If you say Y here, a new entry will be added to each /proc/<pid>
+	  directory that contains the IP address of the person using the task.
+	  The IP is carried across local TCP and AF_UNIX stream sockets.
+	  This information can be useful for IDS/IPSes to perform remote response
+	  to a local attack.  The entry is readable by only the owner of the
+	  process (and root if he has CAP_DAC_OVERRIDE, which can be handled in
+	  different manners depending on the used model, ie. RBAC and the engine
+	  implementing it, ie. SELinux), and thus does not create privacy concern=
s.
+	 =20
+	  This feature has been ported out of grSecurity from Brad Spengler by
+	  lorenzo@gnu.org.
=20
 config SYSFS
 	bool "sysfs file system support" if EMBEDDED
diff -puN net/socket.c~task-curr_ip net/socket.c
--- linux-2.6.11/net/socket.c~task-curr_ip	2005-03-10 14:56:13.938853104 +0=
100
+++ linux-2.6.11-lorenzo/net/socket.c	2005-03-10 14:56:14.050836080 +0100
@@ -114,6 +114,7 @@ static ssize_t sock_writev(struct file *
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more);
=20
+extern void proc_attach_curr_ip(const struct sock *sk);
=20
 /*
  *	Socket files have a set of 'special' operations as well as the generic =
file ones. These don't appear
@@ -1386,6 +1387,7 @@ asmlinkage long sys_accept(int fd, struc
 		goto out_release;
=20
 	security_socket_post_accept(sock, newsock);
+	proc_attach_curr_ip(newsock->sk);
=20
 out_put:
 	sockfd_put(sock);
diff -puN include/linux/sched.h~task-curr_ip include/linux/sched.h
--- linux-2.6.11/include/linux/sched.h~task-curr_ip	2005-03-10 14:56:13.963=
849304 +0100
+++ linux-2.6.11-lorenzo/include/linux/sched.h	2005-03-10 14:56:14.05183592=
8 +0100
@@ -685,6 +685,14 @@ struct task_struct {
   	struct mempolicy *mempolicy;
 	short il_next;
 #endif
+#ifdef CONFIG_PROC_IPADDR
+	u32 curr_ip;		/* per-task originating ip address */
+	u8 used_accept:1;
+	u32 net_saddr;
+	u32 net_daddr;
+	u16 net_sport;
+	u16 net_dport;
+#endif
 };
=20
 static inline pid_t process_group(struct task_struct *tsk)
diff -puN net/ipv4/tcp_ipv4.c~task-curr_ip net/ipv4/tcp_ipv4.c
--- linux-2.6.11/net/ipv4/tcp_ipv4.c~task-curr_ip	2005-03-10 14:56:13.97784=
7176 +0100
+++ linux-2.6.11-lorenzo/net/ipv4/tcp_ipv4.c	2005-03-10 14:56:14.052835776 =
+0100
@@ -82,6 +82,11 @@ int sysctl_tcp_low_latency;
 /* Check TCP sequence numbers in ICMP packets. */
 #define ICMP_MIN_LENGTH 8
=20
+#ifdef CONFIG_PROC_IPADDR
+extern void net_add_to_task_ip_table(struct task_struct *p);
+extern void net_del_task_from_ip_table(struct task_struct *p);
+#endif
+
 /* Socket used for sending RSTs */
 static struct socket *tcp_socket;
=20
@@ -717,6 +722,15 @@ ok:
  			__tcp_v4_hash(sk, 0);
  		}
  		spin_unlock(&head->lock);
+ 	=09
+#ifdef CONFIG_PROC_IPADDR
+		net_del_task_from_ip_table(current);
+		current->net_saddr =3D inet_sk(sk)->rcv_saddr;
+		current->net_daddr =3D inet_sk(sk)->daddr;
+		current->net_sport =3D inet_sk(sk)->sport;
+		current->net_dport =3D inet_sk(sk)->dport;
+		net_add_to_task_ip_table(current);
+#endif
=20
  		if (tw) {
  			tcp_tw_deschedule(tw);
diff -puN kernel/exit.c~task-curr_ip kernel/exit.c
--- linux-2.6.11/kernel/exit.c~task-curr_ip	2005-03-10 14:56:13.979846872 +=
0100
+++ linux-2.6.11-lorenzo/kernel/exit.c	2005-03-10 14:56:14.053835624 +0100
@@ -35,6 +35,10 @@
 extern void sem_exit (void);
 extern struct task_struct *child_reaper;
=20
+#ifdef CONFIG_PROC_IPADDR
+extern void net_del_task_from_ip_table(struct task_struct *p);
+#endif
+
 int getrusage(struct task_struct *, int, struct rusage __user *);
=20
 static void __unhash_process(struct task_struct *p)
@@ -811,6 +815,10 @@ fastcall NORET_TYPE void do_exit(long co
 	group_dead =3D atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead)
 		acct_process(code);
+	=09
+#ifdef CONFIG_PROC_IPADDR
+	net_del_task_from_ip_table(tsk);
+#endif
 	exit_mm(tsk);
=20
 	exit_sem(tsk);
diff -puN /dev/null net/proc_ipaddr.c
--- /dev/null	2005-03-01 21:41:03.335473768 +0100
+++ linux-2.6.11-lorenzo/net/proc_ipaddr.c	2005-03-10 14:56:14.054835472 +0=
100
@@ -0,0 +1,166 @@
+/*
+ * Per-task originating IP address & /proc/$$/ipaddr entry support.
+ *
+ * Copyright (C) 2005 Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
+ * Copyright (C) 2004, 2005 Brad Spengler <spender@grsecurity.net>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+=20
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/net.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <net/sock.h>
+
+#ifdef CONFIG_PROC_IPADDR
+#define net_conn_table_size 65521
+struct task_struct *net_conn_table[net_conn_table_size];
+struct task_struct *deleted_conn =3D (struct task_struct *)~0;
+spinlock_t net_conn_table_lock =3D SPIN_LOCK_UNLOCKED;
+
+static __inline__ int
+conn_hash(__u32 saddr, __u32 daddr, __u16 sport, __u16 dport, unsigned int=
 size)
+{
+	return ((daddr + saddr + (sport << 8) + (dport << 16)) % size);
+}
+
+static __inline__ int
+conn_match(const struct task_struct *task, __u32 saddr, __u32 daddr,
+	   __u16 sport, __u16 dport)
+{
+	if (unlikely(task !=3D deleted_conn && task->net_saddr =3D=3D saddr &&
+		     task->net_daddr =3D=3D daddr && task->net_sport =3D=3D sport &&
+		     task->net_dport =3D=3D dport))
+		return 1;
+	else
+		return 0;
+}
+
+void net_add_to_task_ip_table(struct task_struct *task)
+{
+	unsigned int index;
+
+	if (unlikely(net_conn_table =3D=3D NULL))
+		return;
+
+	if (!thread_group_leader(task))
+		task =3D task->group_leader;
+
+	index =3D conn_hash(task->net_saddr, task->net_daddr,
+			  task->net_sport, task->net_dport,
+			  net_conn_table_size);
+
+	spin_lock(&net_conn_table_lock);
+
+	while (net_conn_table[index] && net_conn_table[index] !=3D deleted_conn) =
{
+		index =3D (index + 1) % net_conn_table_size;
+	}
+
+	net_conn_table[index] =3D task;
+
+	spin_unlock(&net_conn_table_lock);
+
+	return;
+}
+
+void net_del_task_from_ip_table_nolock(struct task_struct *task)
+{
+	unsigned int index;
+
+	if (unlikely(net_conn_table =3D=3D NULL))
+		return;
+
+	if (!thread_group_leader(task))
+		task =3D task->group_leader;
+
+	index =3D conn_hash(task->net_saddr, task->net_daddr,
+			  task->net_sport, task->net_dport,
+			  net_conn_table_size);
+
+	while (net_conn_table[index] && !conn_match(net_conn_table[index],
+		task->net_saddr, task->net_daddr, task->net_sport,
+		task->net_dport)) {
+		index =3D (index + 1) % net_conn_table_size;
+	}
+
+	if (net_conn_table[index]) {
+		if (net_conn_table[(index + 1) % net_conn_table_size])
+			net_conn_table[index] =3D deleted_conn;
+		else
+			net_conn_table[index] =3D NULL;
+	}
+
+	return;
+}
+
+struct task_struct * net_lookup_task_ip_table(__u32 saddr, __u32 daddr,
+					     __u16 sport, __u16 dport)
+{
+	unsigned int index;
+
+	if (unlikely(net_conn_table =3D=3D NULL))
+		return NULL;
+
+	index =3D conn_hash(saddr, daddr, sport, dport, net_conn_table_size);
+
+	while (net_conn_table[index] && !conn_match(net_conn_table[index],
+		saddr, daddr, sport, dport)) {
+		index =3D (index + 1) % net_conn_table_size;
+	}
+
+	return net_conn_table[index];
+}
+#endif
+
+void net_del_task_from_ip_table(struct task_struct *task)
+{
+#ifdef CONFIG_PROC_IPADDR
+	spin_lock(&net_conn_table_lock);
+	if (!thread_group_leader(task))
+		net_del_task_from_ip_table_nolock(task->group_leader);
+	else
+		net_del_task_from_ip_table_nolock(task);
+	spin_unlock(&net_conn_table_lock);
+#endif
+	return;
+}
+
+void
+proc_attach_curr_ip(const struct sock *sk)
+{
+#ifdef CONFIG_PROC_IPADDR
+	struct task_struct *p;
+	struct task_struct *set;
+	const struct inet_sock *inet =3D inet_sk(sk);
+
+	if (unlikely(sk->sk_protocol !=3D IPPROTO_TCP))
+		return;
+
+	set =3D current;
+	if (!thread_group_leader(set))
+		set =3D set->group_leader;
+
+	spin_lock(&net_conn_table_lock);
+	p =3D net_lookup_task_ip_table(inet->daddr, inet->rcv_saddr,
+				    inet->dport, inet->sport);
+	if (unlikely(p !=3D NULL)) {
+		set->curr_ip =3D p->curr_ip;
+		set->used_accept =3D 1;
+		net_del_task_from_ip_table_nolock(p);
+		spin_unlock(&net_conn_table_lock);
+		return;
+	}
+	spin_unlock(&net_conn_table_lock);
+
+	set->curr_ip =3D inet->daddr;
+	set->used_accept =3D 1;
+#endif
+	return;
+}
diff -puN net/Makefile~task-curr_ip net/Makefile
--- linux-2.6.11/net/Makefile~task-curr_ip	2005-03-10 14:56:13.981846568 +0=
100
+++ linux-2.6.11-lorenzo/net/Makefile	2005-03-10 14:56:14.054835472 +0100
@@ -46,3 +46,7 @@ obj-$(CONFIG_IP_SCTP)		+=3D sctp/
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+=3D sysctl_net.o
 endif
+
+ifeq ($(CONFIG_NET),y)
+obj-$(CONFIG_PROC_IPADDR)	+=3D proc_ipaddr.o
+endif

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-wNlQd9/uYt6yRYpF5/V1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCMFbKDcEopW8rLewRAqciAJ9pWLCK4pEV2wVVreHFG02n5Bwo1QCg15PS
U7JU+JARH3PVH0azqRRfmAI=
=wHq6
-----END PGP SIGNATURE-----

--=-wNlQd9/uYt6yRYpF5/V1--

