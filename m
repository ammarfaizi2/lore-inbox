Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJGD0f>; Sun, 6 Oct 2002 23:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJGD0f>; Sun, 6 Oct 2002 23:26:35 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:42503 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262838AbSJGD00>; Sun, 6 Oct 2002 23:26:26 -0400
Date: Mon, 7 Oct 2002 00:31:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH] X25: use seq_file for proc stuff
Message-ID: <20021007033155.GB1201@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please consider pulling from:

master.kernel.org:/home/acme/BK/x25-2.5

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.623, 2002-10-07 00:18:10-03:00, acme@conectiva.com.br
  o X25: use seq_file for proc stuff
  
  Also some CodingStyle cleanups.


 include/net/x25.h   |   11 +-
 net/x25/Makefile    |    2 
 net/x25/af_x25.c    |  146 ++++++++--------------------
 net/x25/x25_proc.c  |  263 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/x25/x25_route.c |   65 ------------
 5 files changed, 320 insertions(+), 167 deletions(-)


diff -Nru a/include/net/x25.h b/include/net/x25.h
--- a/include/net/x25.h	Mon Oct  7 00:29:00 2002
+++ b/include/net/x25.h	Mon Oct  7 00:29:00 2002
@@ -220,9 +220,8 @@
 /* x25_route.c */
 extern struct x25_route *x25_get_route(struct x25_address *addr);
 extern struct net_device *x25_dev_get(char *);
-extern void x25_route_device_down(struct net_device *);
+extern void x25_route_device_down(struct net_device *dev);
 extern int  x25_route_ioctl(unsigned int, void *);
-extern int  x25_routes_get_info(char *, char **, off_t, int);
 extern void x25_route_free(void);
 
 static __inline__ void x25_route_hold(struct x25_route *rt)
@@ -263,4 +262,12 @@
 	unsigned flags;
 };
 #define X25_SKB_CB(s) ((struct x25_skb_cb *) ((s)->cb))
+
+extern struct sock *x25_list;
+extern rwlock_t x25_list_lock;
+extern struct list_head x25_route_list;
+extern rwlock_t x25_route_list_lock;
+
+extern int x25_proc_init(void);
+extern void x25_proc_exit(void);
 #endif
diff -Nru a/net/x25/Makefile b/net/x25/Makefile
--- a/net/x25/Makefile	Mon Oct  7 00:29:00 2002
+++ b/net/x25/Makefile	Mon Oct  7 00:29:00 2002
@@ -6,7 +6,7 @@
 
 x25-y			:= af_x25.o x25_dev.o x25_facilities.o x25_in.o \
 			   x25_link.o x25_out.o x25_route.o x25_subr.o \
-			   x25_timer.o
+			   x25_timer.o x25_proc.o
 x25-$(CONFIG_SYSCTL)	+= sysctl_net_x25.o
 x25-objs		:= $(x25-y)
 
diff -Nru a/net/x25/af_x25.c b/net/x25/af_x25.c
--- a/net/x25/af_x25.c	Mon Oct  7 00:29:00 2002
+++ b/net/x25/af_x25.c	Mon Oct  7 00:29:00 2002
@@ -27,6 +27,8 @@
  *	2000-10-02	Henner Eisen	Made x25_kick() single threaded per socket.
  *	2000-10-27	Henner Eisen    MSG_DONTWAIT for fragment allocation.
  *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
+ *	2002-10-06	Arnaldo C. Melo Get rid of cli/sti, move proc stuff to
+ *					x25_proc.c, using seq_file
  */
 
 #include <linux/config.h>
@@ -55,7 +57,6 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
-#include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <net/x25.h>
 
@@ -65,8 +66,8 @@
 int sysctl_x25_clear_request_timeout   = X25_DEFAULT_T23;
 int sysctl_x25_ack_holdback_timeout    = X25_DEFAULT_T2;
 
-static struct sock *x25_list;
-static rwlock_t x25_list_lock = RW_LOCK_UNLOCKED;
+struct sock *x25_list;
+rwlock_t x25_list_lock = RW_LOCK_UNLOCKED;
 
 static struct proto_ops x25_proto_ops;
 
@@ -246,8 +247,10 @@
 	read_lock_bh(&x25_list_lock);
 
 	for (s = x25_list; s; s = s->next)
-		if ((!strcmp(addr->x25_addr, x25_sk(s)->source_addr.x25_addr) ||
-		     !strcmp(addr->x25_addr, null_x25_address.x25_addr)) &&
+		if ((!strcmp(addr->x25_addr,
+			     x25_sk(s)->source_addr.x25_addr) ||
+		     !strcmp(addr->x25_addr,
+			     null_x25_address.x25_addr)) &&
 		     s->state == TCP_LISTEN)
 			break;
 
@@ -318,12 +321,13 @@
 }
 
 /*
- *	This is called from user mode and the timers. Thus it protects itself against
- *	interrupt users but doesn't worry about being called during work.
- *	Once it is removed from the queue no interrupt or bottom half will
- *	touch it and we are (fairly 8-) ) safe.
+ *	This is called from user mode and the timers. Thus it protects itself
+ *	against interrupt users but doesn't worry about being called during
+ *	work. Once it is removed from the queue no interrupt or bottom half
+ *	will touch it and we are (fairly 8-) ) safe.
+ *	Not static as it's used by the timer
  */
-void x25_destroy_socket(struct sock *sk)	/* Not static as it's used by the timer */
+void x25_destroy_socket(struct sock *sk)
 {
 	struct sk_buff *skb;
 
@@ -337,7 +341,10 @@
 
 	while ((skb = skb_dequeue(&sk->receive_queue)) != NULL) {
 		if (skb->sk != sk) {		/* A pending connection */
-			skb->sk->dead = 1;	/* Queue the unaccepted socket for death */
+			/*
+			 * Queue the unaccepted socket for death
+			 */
+			skb->sk->dead = 1;
 			x25_start_heartbeat(skb->sk);
 			x25_sk(skb->sk)->state = X25_STATE_0;
 		}
@@ -631,7 +638,8 @@
 	return rc;
 }
 
-static int x25_connect(struct socket *sock, struct sockaddr *uaddr, int addr_len, int flags)
+static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
+		       int addr_len, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct x25_opt *x25 = x25_sk(sk);
@@ -642,7 +650,7 @@
 	lock_sock(sk);
 	if (sk->state == TCP_ESTABLISHED && sock->state == SS_CONNECTING) {
 		sock->state = SS_CONNECTED;
-		goto out;	/* Connect completed during a ERESTARTSYS event */
+		goto out; /* Connect completed during a ERESTARTSYS event */
 	}
 
 	rc = -ECONNREFUSED;
@@ -679,7 +687,7 @@
 		goto out_put_neigh;
 
 	rc = -EINVAL;
-	if (sk->zapped)		/* Must bind first - autobinding does not work */
+	if (sk->zapped)	/* Must bind first - autobinding does not work */
 		goto out_put_neigh;
 
 	if (!strcmp(x25->source_addr.x25_addr, null_x25_address.x25_addr))
@@ -785,7 +793,8 @@
 	return rc;
 }
 
-static int x25_getname(struct socket *sock, struct sockaddr *uaddr, int *uaddr_len, int peer)
+static int x25_getname(struct socket *sock, struct sockaddr *uaddr,
+		       int *uaddr_len, int peer)
 {
 	struct sockaddr_x25 *sx25 = (struct sockaddr_x25 *)uaddr;
 	struct sock *sk = sock->sk;
@@ -804,7 +813,8 @@
 	return 0;
 }
  
-int x25_rx_call_request(struct sk_buff *skb, struct x25_neigh *nb, unsigned int lci)
+int x25_rx_call_request(struct sk_buff *skb, struct x25_neigh *nb,
+			unsigned int lci)
 {
 	struct sock *sk;
 	struct sock *make;
@@ -906,7 +916,8 @@
 	goto out;
 }
 
-static int x25_sendmsg(struct socket *sock, struct msghdr *msg, int len, struct scm_cookie *scm)
+static int x25_sendmsg(struct socket *sock, struct msghdr *msg, int len,
+		       struct scm_cookie *scm)
 {
 	struct sock *sk = sock->sk;
 	struct x25_opt *x25 = x25_sk(sk);
@@ -1118,7 +1129,8 @@
 		msg->msg_flags |= MSG_OOB;
 	} else {
 		/* Now we can treat all alike */
-		skb = skb_recv_datagram(sk, flags & ~MSG_DONTWAIT, flags & MSG_DONTWAIT, &rc);
+		skb = skb_recv_datagram(sk, flags & ~MSG_DONTWAIT,
+					flags & MSG_DONTWAIT, &rc);
 		if (!skb)
 			goto out;
 
@@ -1236,14 +1248,16 @@
 			break;
 		case SIOCX25GFACILITIES: {
 			struct x25_facilities fac = x25->facilities;
-			rc = copy_to_user((void *)arg, &fac, sizeof(fac)) ? -EFAULT : 0;
+			rc = copy_to_user((void *)arg, &fac,
+					  sizeof(fac)) ? -EFAULT : 0;
 			break;
 		}
 
 		case SIOCX25SFACILITIES: {
 			struct x25_facilities facilities;
 			rc = -EFAULT;
-			if (copy_from_user(&facilities, (void *)arg, sizeof(facilities)))
+			if (copy_from_user(&facilities, (void *)arg,
+					   sizeof(facilities)))
 				break;
 			rc = -EINVAL;
 			if (sk->state != TCP_LISTEN && sk->state != TCP_CLOSE)
@@ -1269,7 +1283,8 @@
 
 		case SIOCX25GCALLUSERDATA: {
 			struct x25_calluserdata cud = x25->calluserdata;
-			rc = copy_to_user((void *)arg, &cud, sizeof(cud)) ? -EFAULT : 0;
+			rc = copy_to_user((void *)arg, &cud,
+					  sizeof(cud)) ? -EFAULT : 0;
 			break;
 		}
 
@@ -1277,7 +1292,8 @@
 			struct x25_calluserdata calluserdata;
 
 			rc = -EFAULT;
-			if (copy_from_user(&calluserdata, (void *)arg, sizeof(calluserdata)))
+			if (copy_from_user(&calluserdata, (void *)arg,
+					   sizeof(calluserdata)))
 				break;
 			rc = -EINVAL;
 			if (calluserdata.cudlength > X25_MAX_CUD_LEN)
@@ -1290,7 +1306,8 @@
 		case SIOCX25GCAUSEDIAG: {
 			struct x25_causediag causediag;
 			causediag = x25->causediag;
-			rc = copy_to_user((void *)arg, &causediag, sizeof(causediag)) ? -EFAULT : 0;
+			rc = copy_to_user((void *)arg, &causediag,
+					  sizeof(causediag)) ? -EFAULT : 0;
 			break;
 		}
 
@@ -1302,70 +1319,6 @@
 	return rc;
 }
 
-static int x25_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	struct sock *s;
-	struct net_device *dev;
-	const char *devname;
-	off_t pos = 0;
-	off_t begin = 0;
-	int len = sprintf(buffer, "dest_addr  src_addr   dev   lci st vs vr "
-				  "va   t  t2 t21 t22 t23 Snd-Q Rcv-Q inode\n");
-
-	read_lock_bh(&x25_list_lock);
-
-	for (s = x25_list; s; s = s->next) {
-		struct x25_opt *x25 = x25_sk(s);
-
-		if (!x25->neighbour || (dev = x25->neighbour->dev) == NULL)
-			devname = "???";
-		else
-			devname = x25->neighbour->dev->name;
-
-		len += sprintf(buffer + len, "%-10s %-10s %-5s %3.3X  %d  %d  "
-					     "%d  %d %3lu %3lu %3lu %3lu %3lu "
-					     "%5d %5d %ld\n",
-			!x25->dest_addr.x25_addr[0] ? "*" :
-						x25->dest_addr.x25_addr,
-			!x25->source_addr.x25_addr[0] ? "*" :
-						x25->source_addr.x25_addr,
-			devname, 
-			x25->lci & 0x0FFF,
-			x25->state,
-			x25->vs,
-			x25->vr,
-			x25->va,
-			x25_display_timer(s) / HZ,
-			x25->t2  / HZ,
-			x25->t21 / HZ,
-			x25->t22 / HZ,
-			x25->t23 / HZ,
-			atomic_read(&s->wmem_alloc),
-			atomic_read(&s->rmem_alloc),
-			s->socket ? SOCK_INODE(s->socket)->i_ino : 0L);
-
-		pos = begin + len;
-
-		if (pos < offset) {
-			len   = 0;
-			begin = pos;
-		}
-
-		if (pos > offset + length)
-			break;
-	}
-
-	read_unlock_bh(&x25_list_lock);
-
-	*start = buffer + (offset - begin);
-	len   -= (offset - begin);
-
-	if (len > length)
-		len = length;
-
-	return len;
-} 
-
 struct net_proto_family x25_family_ops = {
 	.family =	AF_X25,
 	.create =	x25_create,
@@ -1395,7 +1348,6 @@
 #include <linux/smp_lock.h>
 SOCKOPS_WRAP(x25_proto, AF_X25);
 
-
 static struct packet_type x25_packet_type = {
 	.type =	__constant_htons(ETH_P_X25),
 	.func =	x25_lapb_receive_frame,
@@ -1435,9 +1387,7 @@
 	x25_register_sysctl();
 #endif
 
-	proc_net_create("x25", 0, x25_get_info);
-	proc_net_create("x25_routes", 0, x25_routes_get_info);
-
+	x25_proc_init();
 #ifdef MODULE
 	/*
 	 *	Register any pre existing devices.
@@ -1457,18 +1407,9 @@
 }
 module_init(x25_init);
 
-
-
-MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
-MODULE_DESCRIPTION("The X.25 Packet Layer network layer protocol");
-MODULE_LICENSE("GPL");
-
 static void __exit x25_exit(void)
 {
-
-	proc_net_remove("x25");
-	proc_net_remove("x25_routes");
-
+	x25_proc_exit();
 	x25_link_free();
 	x25_route_free();
 
@@ -1484,3 +1425,6 @@
 }
 module_exit(x25_exit);
 
+MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
+MODULE_DESCRIPTION("The X.25 Packet Layer network layer protocol");
+MODULE_LICENSE("GPL");
diff -Nru a/net/x25/x25_proc.c b/net/x25/x25_proc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/x25/x25_proc.c	Mon Oct  7 00:29:00 2002
@@ -0,0 +1,263 @@
+/*
+ *	X.25 Packet Layer release 002
+ *
+ *	This is ALPHA test software. This code may break your machine,
+ *	randomly fail to work with new releases, misbehave and/or generally
+ *	screw up. It might even work. 
+ *
+ *	This code REQUIRES 2.4 with seq_file support
+ *
+ *	This module:
+ *		This module is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ *	History
+ *	2002/10/06	Arnaldo Carvalho de Melo  seq_file support
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <net/sock.h>
+#include <net/x25.h>
+
+#ifdef CONFIG_PROC_FS
+static __inline__ struct x25_route *x25_get_route_idx(loff_t pos)
+{
+	struct list_head *route_entry;
+	struct x25_route *rt = NULL;
+
+	list_for_each(route_entry, &x25_route_list) {
+		rt = list_entry(route_entry, struct x25_route, node);
+		if (--pos)
+			break;
+	}
+
+	return rt;
+}
+
+static void *x25_seq_route_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	read_lock_bh(&x25_route_list_lock);
+	return l ? x25_get_route_idx(--l) : (void *)1;
+}
+
+static void *x25_seq_route_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct x25_route *rt;
+
+	++*pos;
+	if (v == (void *)1) {
+		rt = NULL;
+		if (!list_empty(&x25_route_list))
+			rt = list_entry(x25_route_list.next,
+					struct x25_route, node);
+		goto out;
+	}
+	rt = v;
+	if (rt->node.next != &x25_route_list)
+		rt = list_entry(rt->node.next, struct x25_route, node);
+	else 
+		rt = NULL;
+out:
+	return rt;
+}
+
+static void x25_seq_route_stop(struct seq_file *seq, void *v)
+{
+	read_unlock_bh(&x25_route_list_lock);
+}
+
+static int x25_seq_route_show(struct seq_file *seq, void *v)
+{
+	struct x25_route *rt;
+
+	if (v == (void *)1) {
+		seq_puts(seq, "Address          Digits  Device\n");
+		goto out;
+	}
+
+	rt = v;
+	seq_printf(seq, "%-15s  %-6d  %-5s\n",
+		   rt->address.x25_addr, rt->sigdigits,
+		   rt->dev ? rt->dev->name : "???");
+out:
+	return 0;
+} 
+
+static __inline__ struct sock *x25_get_socket_idx(loff_t pos)
+{
+	struct sock *s;
+
+	for (s = x25_list; pos && s; s = s->next)
+		--pos;
+
+	return s;
+}
+
+static void *x25_seq_socket_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	read_lock_bh(&x25_list_lock);
+	return l ? x25_get_socket_idx(--l) : (void *)1;
+}
+
+static void *x25_seq_socket_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock *s;
+
+	++*pos;
+	if (v == (void *)1) {
+		s = NULL;
+		if (x25_list)
+			s = x25_list;
+		goto out;
+	}
+	s = v;
+	s = s->next;
+out:
+	return s;
+}
+
+static void x25_seq_socket_stop(struct seq_file *seq, void *v)
+{
+	read_unlock_bh(&x25_list_lock);
+}
+
+static int x25_seq_socket_show(struct seq_file *seq, void *v)
+{
+	struct sock *s;
+	struct x25_opt *x25;
+	struct net_device *dev;
+	const char *devname;
+
+	if (v == (void *)1) {
+		seq_printf(seq, "dest_addr  src_addr   dev   lci st vs vr "
+				"va   t  t2 t21 t22 t23 Snd-Q Rcv-Q inode\n");
+		goto out;
+	}
+
+	s = v;
+	x25 = x25_sk(s);
+
+	if (!x25->neighbour || (dev = x25->neighbour->dev) == NULL)
+		devname = "???";
+	else
+		devname = x25->neighbour->dev->name;
+
+	seq_printf(seq, "%-10s %-10s %-5s %3.3X  %d  %d  %d  %d %3lu %3lu "
+			"%3lu %3lu %3lu %5d %5d %ld\n",
+		   !x25->dest_addr.x25_addr[0] ? "*" : x25->dest_addr.x25_addr,
+		   !x25->source_addr.x25_addr[0] ? "*" : x25->source_addr.x25_addr,
+		   devname, x25->lci & 0x0FFF, x25->state, x25->vs, x25->vr,
+		   x25->va, x25_display_timer(s) / HZ, x25->t2  / HZ,
+		   x25->t21 / HZ, x25->t22 / HZ, x25->t23 / HZ,
+		   atomic_read(&s->wmem_alloc), atomic_read(&s->rmem_alloc),
+		   s->socket ? SOCK_INODE(s->socket)->i_ino : 0L);
+out:
+	return 0;
+} 
+
+struct seq_operations x25_seq_route_ops = {
+	.start  = x25_seq_route_start,
+	.next   = x25_seq_route_next,
+	.stop   = x25_seq_route_stop,
+	.show   = x25_seq_route_show,
+};
+
+struct seq_operations x25_seq_socket_ops = {
+	.start  = x25_seq_socket_start,
+	.next   = x25_seq_socket_next,
+	.stop   = x25_seq_socket_stop,
+	.show   = x25_seq_socket_show,
+};
+
+static int x25_seq_socket_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &x25_seq_socket_ops);
+}
+
+static int x25_seq_route_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &x25_seq_route_ops);
+}
+
+static struct file_operations x25_seq_socket_fops = {
+	.open		= x25_seq_socket_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct file_operations x25_seq_route_fops = {
+	.open		= x25_seq_route_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int x25_proc_perms(struct inode* inode, int op)
+{
+	return 0;
+}
+
+static struct inode_operations x25_seq_inode = {
+	.permission	= x25_proc_perms,
+};
+
+static struct proc_dir_entry *x25_proc_dir;
+
+int __init x25_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = -ENOMEM;
+
+	x25_proc_dir = proc_mkdir("x25", proc_net);
+	if (!x25_proc_dir)
+		goto out;
+
+	p = create_proc_entry("route", 0, x25_proc_dir);
+	if (!p)
+		goto out_route;
+	p->proc_fops = &x25_seq_route_fops;
+	p->proc_iops = &x25_seq_inode;
+
+	p = create_proc_entry("socket", 0, x25_proc_dir);
+	if (!p)
+		goto out_socket;
+	p->proc_fops = &x25_seq_socket_fops;
+	p->proc_iops = &x25_seq_inode;
+	rc = 0;
+out:
+	return rc;
+out_socket:
+	remove_proc_entry("route", x25_proc_dir);
+out_route:
+	remove_proc_entry("x25", proc_net);
+	goto out;
+}
+
+void __exit x25_proc_exit(void)
+{
+	remove_proc_entry("route", x25_proc_dir);
+	remove_proc_entry("socket", x25_proc_dir);
+	remove_proc_entry("x25", proc_net);
+}
+
+#else /* CONFIG_PROC_FS */
+
+int __init x25_proc_init(void)
+{
+	return 0;
+}
+
+void __exit x25_proc_exit(void)
+{
+}
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/x25/x25_route.c b/net/x25/x25_route.c
--- a/net/x25/x25_route.c	Mon Oct  7 00:29:00 2002
+++ b/net/x25/x25_route.c	Mon Oct  7 00:29:00 2002
@@ -18,34 +18,12 @@
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
-#include <net/arp.h>
 #include <linux/if_arp.h>
-#include <linux/skbuff.h>
-#include <net/sock.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <linux/fcntl.h>
-#include <linux/termios.h>	/* For TIOCINQ/OUTQ */
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/notifier.h>
 #include <linux/init.h>
 #include <net/x25.h>
 
-static struct list_head x25_route_list = LIST_HEAD_INIT(x25_route_list);
-static rwlock_t x25_route_list_lock = RW_LOCK_UNLOCKED;
+struct list_head x25_route_list = LIST_HEAD_INIT(x25_route_list);
+rwlock_t x25_route_list_lock = RW_LOCK_UNLOCKED;
 
 /*
  *	Add a new route.
@@ -225,45 +203,6 @@
 out:
 	return rc;
 }
-
-int x25_routes_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	struct x25_route *rt;
-	struct list_head *entry;
-	off_t pos   = 0;
-	off_t begin = 0;
-	int len = sprintf(buffer, "address          digits  device\n");
-
-	read_lock_bh(&x25_route_list_lock);
-
-	list_for_each(entry, &x25_route_list) {
-		rt = list_entry(entry, struct x25_route, node);
-		len += sprintf(buffer + len, "%-15s  %-6d  %-5s\n",
-			       rt->address.x25_addr,
-			       rt->sigdigits,
-			       rt->dev ? rt->dev->name : "???");
-
-		pos = begin + len;
-
-		if (pos < offset) {
-			len   = 0;
-			begin = pos;
-		}
-
-		if (pos > offset + length)
-			break;
-	}
-
-	read_unlock_bh(&x25_route_list_lock);
-
-	*start = buffer + (offset - begin);
-	len   -= (offset - begin);
-
-	if (len > length)
-		len = length;
-
-	return len;
-} 
 
 /*
  *	Release all memory associated with X.25 routing structures.

===================================================================


This BitKeeper patch contains the following changesets:
1.623
## Wrapped with gzip_uu ##


begin 664 bkpatch9058
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
#,```
`
end
