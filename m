Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSJGGjU>; Mon, 7 Oct 2002 02:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbSJGGjU>; Mon, 7 Oct 2002 02:39:20 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:776 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262901AbSJGGjI>; Mon, 7 Oct 2002 02:39:08 -0400
Date: Mon, 7 Oct 2002 03:44:41 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BKPATCH] Appletalk: use seq_file for proc stuff
Message-ID: <20021007064441.GI1201@conectiva.com.br>
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

David,

	Please consider pulling from:

master.kernel.org:/home/acme/BK/llc-2.5

	This is the only outstanding changeset there.

	Tomorrow I'll do the missing bit: the aarp proc stuff will
be moved to atalk_proc.c too.

	And will also fix the .permission bogosity in IPX and LLC.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.632, 2002-10-07 03:27:57-03:00, acme@conectiva.com.br
  o Appletalk: use seq_file for proc stuff
  
  And also move MODULE_LICENSE from aarp.c to ddp.c, as its there
  that the module_init/exit is.
  
  Also added MODULE_AUTHOR and MODULE_DESCRIPTION.


 include/linux/atalk.h            |   14 +
 net/appletalk/Makefile           |    2 
 net/appletalk/aarp.c             |   22 --
 net/appletalk/atalk_proc.c       |  319 +++++++++++++++++++++++++++++++++++++++
 net/appletalk/ddp.c              |  244 +++++------------------------
 net/appletalk/sysctl_net_atalk.c |    7 
 6 files changed, 385 insertions(+), 223 deletions(-)


diff -Nru a/include/linux/atalk.h b/include/linux/atalk.h
--- a/include/linux/atalk.h	Mon Oct  7 03:28:22 2002
+++ b/include/linux/atalk.h	Mon Oct  7 03:28:22 2002
@@ -198,5 +198,19 @@
 
 #define at_sk(__sk) ((struct atalk_sock *)(__sk)->protinfo)
 
+extern struct sock *atalk_sockets;
+extern spinlock_t atalk_sockets_lock;
+
+extern struct atalk_route *atalk_routes;
+extern rwlock_t atalk_routes_lock;
+
+extern struct atalk_iface *atalk_interfaces;
+extern spinlock_t atalk_interfaces_lock;
+
+extern struct atalk_route atrtr_default;
+
+extern int atalk_proc_init(void);
+extern void atalk_proc_exit(void);
+
 #endif /* __KERNEL__ */
 #endif /* __LINUX_ATALK_H__ */
diff -Nru a/net/appletalk/Makefile b/net/appletalk/Makefile
--- a/net/appletalk/Makefile	Mon Oct  7 03:28:22 2002
+++ b/net/appletalk/Makefile	Mon Oct  7 03:28:22 2002
@@ -6,7 +6,7 @@
 
 obj-$(CONFIG_ATALK) += appletalk.o
 
-appletalk-y			:= aarp.o ddp.o
+appletalk-y			:= aarp.o ddp.o atalk_proc.o
 appletalk-$(CONFIG_SYSCTL)	+= sysctl_net_atalk.o
 appletalk-objs			:= $(appletalk-y)
 
diff -Nru a/net/appletalk/aarp.c b/net/appletalk/aarp.c
--- a/net/appletalk/aarp.c	Mon Oct  7 03:28:22 2002
+++ b/net/appletalk/aarp.c	Mon Oct  7 03:28:22 2002
@@ -30,34 +30,13 @@
  */
 
 #include <linux/config.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/socket.h>
-#include <linux/sockios.h>
-#include <linux/in.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/if_ether.h>
-#include <linux/inet.h>
-#include <linux/notifier.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/if_arp.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/datalink.h>
 #include <net/psnap.h>
 #include <linux/atalk.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/module.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -995,4 +974,3 @@
 	proc_net_remove("aarp");
 }
 #endif
-MODULE_LICENSE("GPL");
diff -Nru a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/appletalk/atalk_proc.c	Mon Oct  7 03:28:22 2002
@@ -0,0 +1,319 @@
+/*
+ * 	atalk_proc.c - proc support for Appletalk
+ *
+ * 	Copyright(c) Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ *	This program is free software; you can redistribute it and/or modify it
+ *	under the terms of the GNU General Public License as published by the
+ *	Free Software Foundation, version 2.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <net/sock.h>
+#include <linux/atalk.h>
+
+#ifdef CONFIG_PROC_FS
+static __inline__ struct atalk_iface *atalk_get_interface_idx(loff_t pos)
+{
+	struct atalk_iface *i;
+
+	for (i = atalk_interfaces; pos && i; i = i->next)
+		--pos;
+
+	return i;
+}
+
+static void *atalk_seq_interface_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	spin_lock_bh(&atalk_interfaces_lock);
+	return l ? atalk_get_interface_idx(--l) : (void *)1;
+}
+
+static void *atalk_seq_interface_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct atalk_iface *i;
+
+	++*pos;
+	if (v == (void *)1) {
+		i = NULL;
+		if (atalk_interfaces)
+			i = atalk_interfaces;
+		goto out;
+	}
+	i = v;
+	i = i->next;
+out:
+	return i;
+}
+
+static void atalk_seq_interface_stop(struct seq_file *seq, void *v)
+{
+	spin_unlock_bh(&atalk_interfaces_lock);
+}
+
+static int atalk_seq_interface_show(struct seq_file *seq, void *v)
+{
+	struct atalk_iface *iface;
+
+	if (v == (void *)1) {
+		seq_puts(seq, "Interface	  Address   Networks   "
+			      "Status\n");
+		goto out;
+	}
+
+	iface = v;
+	seq_printf(seq, "%-16s %04X:%02X  %04X-%04X  %d\n",
+		   iface->dev->name, ntohs(iface->address.s_net),
+		   iface->address.s_node, ntohs(iface->nets.nr_firstnet),
+		   ntohs(iface->nets.nr_lastnet), iface->status);
+out:
+	return 0;
+}
+
+static __inline__ struct atalk_route *atalk_get_route_idx(loff_t pos)
+{
+	struct atalk_route *r;
+
+	for (r = atalk_routes; pos && r; r = r->next)
+		--pos;
+
+	return r;
+}
+
+static void *atalk_seq_route_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	read_lock_bh(&atalk_routes_lock);
+	return l ? atalk_get_route_idx(--l) : (void *)1;
+}
+
+static void *atalk_seq_route_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct atalk_route *r;
+
+	++*pos;
+	if (v == (void *)1) {
+		r = NULL;
+		if (atalk_routes)
+			r = atalk_routes;
+		goto out;
+	}
+	r = v;
+	r = r->next;
+out:
+	return r;
+}
+
+static void atalk_seq_route_stop(struct seq_file *seq, void *v)
+{
+	read_unlock_bh(&atalk_routes_lock);
+}
+
+static int atalk_seq_route_show(struct seq_file *seq, void *v)
+{
+	struct atalk_route *rt;
+
+	if (v == (void *)1) {
+		seq_puts(seq, "Target        Router  Flags Dev\n");
+		goto out;
+	}
+
+	if (atrtr_default.dev) {
+		rt = &atrtr_default;
+		seq_printf(seq, "Default     %04X:%02X  %-4d  %s\n",
+			       ntohs(rt->gateway.s_net), rt->gateway.s_node,
+			       rt->flags, rt->dev->name);
+	}
+
+	rt = v;
+	seq_printf(seq, "%04X:%02X     %04X:%02X  %-4d  %s\n",
+		   ntohs(rt->target.s_net), rt->target.s_node,
+		   ntohs(rt->gateway.s_net), rt->gateway.s_node,
+		   rt->flags, rt->dev->name);
+out:
+	return 0;
+}
+
+static __inline__ struct sock *atalk_get_socket_idx(loff_t pos)
+{
+	struct sock *s;
+
+	for (s = atalk_sockets; pos && s; s = s->next)
+		--pos;
+
+	return s;
+}
+
+static void *atalk_seq_socket_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t l = *pos;
+
+	spin_lock_bh(&atalk_sockets_lock);
+	return l ? atalk_get_socket_idx(--l) : (void *)1;
+}
+
+static void *atalk_seq_socket_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock *i;
+
+	++*pos;
+	if (v == (void *)1) {
+		i = NULL;
+		if (atalk_sockets)
+			i = atalk_sockets;
+		goto out;
+	}
+	i = v;
+	i = i->next;
+out:
+	return i;
+}
+
+static void atalk_seq_socket_stop(struct seq_file *seq, void *v)
+{
+	spin_unlock_bh(&atalk_sockets_lock);
+}
+
+static int atalk_seq_socket_show(struct seq_file *seq, void *v)
+{
+	struct sock *s;
+	struct atalk_sock *at;
+
+	if (v == (void *)1) {
+		seq_printf(seq, "Type Local_addr  Remote_addr Tx_queue "
+				"Rx_queue St UID\n");
+		goto out;
+	}
+
+	s = v;
+	at = at_sk(s);
+
+	seq_printf(seq, "%02X   %04X:%02X:%02X  %04X:%02X:%02X  %08X:%08X "
+			"%02X %d\n",
+		   s->type, ntohs(at->src_net), at->src_node, at->src_port,
+		   ntohs(at->dest_net), at->dest_node, at->dest_port,
+		   atomic_read(&s->wmem_alloc), atomic_read(&s->rmem_alloc),
+		   s->state, SOCK_INODE(s->socket)->i_uid);
+out:
+	return 0;
+}
+
+struct seq_operations atalk_seq_interface_ops = {
+	.start  = atalk_seq_interface_start,
+	.next   = atalk_seq_interface_next,
+	.stop   = atalk_seq_interface_stop,
+	.show   = atalk_seq_interface_show,
+};
+
+struct seq_operations atalk_seq_route_ops = {
+	.start  = atalk_seq_route_start,
+	.next   = atalk_seq_route_next,
+	.stop   = atalk_seq_route_stop,
+	.show   = atalk_seq_route_show,
+};
+
+struct seq_operations atalk_seq_socket_ops = {
+	.start  = atalk_seq_socket_start,
+	.next   = atalk_seq_socket_next,
+	.stop   = atalk_seq_socket_stop,
+	.show   = atalk_seq_socket_show,
+};
+
+static int atalk_seq_interface_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &atalk_seq_interface_ops);
+}
+
+static int atalk_seq_route_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &atalk_seq_route_ops);
+}
+
+static int atalk_seq_socket_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &atalk_seq_socket_ops);
+}
+
+static struct file_operations atalk_seq_interface_fops = {
+	.open		= atalk_seq_interface_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct file_operations atalk_seq_route_fops = {
+	.open		= atalk_seq_route_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct file_operations atalk_seq_socket_fops = {
+	.open		= atalk_seq_socket_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct proc_dir_entry *atalk_proc_dir;
+
+int __init atalk_proc_init(void)
+{
+	struct proc_dir_entry *p;
+	int rc = -ENOMEM;
+
+	atalk_proc_dir = proc_mkdir("atalk", proc_net);
+	if (!atalk_proc_dir)
+		goto out;
+
+	p = create_proc_entry("interface", S_IRUGO, atalk_proc_dir);
+	if (!p)
+		goto out_interface;
+	p->proc_fops = &atalk_seq_interface_fops;
+
+	p = create_proc_entry("route", S_IRUGO, atalk_proc_dir);
+	if (!p)
+		goto out_route;
+	p->proc_fops = &atalk_seq_route_fops;
+
+	p = create_proc_entry("socket", S_IRUGO, atalk_proc_dir);
+	if (!p)
+		goto out_socket;
+	p->proc_fops = &atalk_seq_socket_fops;
+
+	rc = 0;
+out:
+	return rc;
+out_socket:
+	remove_proc_entry("route", atalk_proc_dir);
+out_route:
+	remove_proc_entry("interface", atalk_proc_dir);
+out_interface:
+	remove_proc_entry("atalk", proc_net);
+	goto out;
+}
+
+void __exit atalk_proc_exit(void)
+{
+	remove_proc_entry("interface", atalk_proc_dir);
+	remove_proc_entry("route", atalk_proc_dir);
+	remove_proc_entry("socket", atalk_proc_dir);
+	remove_proc_entry("atalk", proc_net);
+}
+
+#else /* CONFIG_PROC_FS */
+int __init atalk_proc_init(void)
+{
+	return 0;
+}
+
+void __exit atalk_proc_exit(void)
+{
+}
+#endif /* CONFIG_PROC_FS */
diff -Nru a/net/appletalk/ddp.c b/net/appletalk/ddp.c
--- a/net/appletalk/ddp.c	Mon Oct  7 03:28:22 2002
+++ b/net/appletalk/ddp.c	Mon Oct  7 03:28:22 2002
@@ -40,6 +40,8 @@
  *                                              result.
  *		Arnaldo C. de Melo	:	Cleanup, in preparation for
  *						shared skb support 8)
+ *		Arnaldo C. de Melo	:	Move proc stuff to atalk_proc.c,
+ *						use seq_file
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -50,41 +52,14 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/socket.h>
-#include <linux/sockios.h>
-#include <linux/in.h>
 #include <linux/tcp.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/if_ether.h>
-#include <linux/notifier.h>
-#include <linux/netdevice.h>
-#include <linux/inetdevice.h>
-#include <linux/route.h>
-#include <linux/inet.h>
-#include <linux/etherdevice.h>
 #include <linux/if_arp.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
 #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
 #include <net/datalink.h>
-#include <net/p8022.h>
 #include <net/psnap.h>
 #include <net/sock.h>
-#include <linux/ip.h>
 #include <net/route.h>
 #include <linux/atalk.h>
-#include <linux/proc_fs.h>
-#include <linux/stat.h>
-#include <linux/init.h>
 
 #ifdef CONFIG_PROC_FS
 extern void aarp_register_proc_fs(void);
@@ -112,8 +87,8 @@
 *                                                                          *
 \**************************************************************************/
 
-static struct sock *atalk_sockets;
-static spinlock_t atalk_sockets_lock = SPIN_LOCK_UNLOCKED;
+struct sock *atalk_sockets;
+spinlock_t atalk_sockets_lock = SPIN_LOCK_UNLOCKED;
 
 extern inline void atalk_insert_socket(struct sock *sk)
 {
@@ -244,53 +219,6 @@
 	}
 }
 
-/* Called from proc fs */
-static int atalk_get_info(char *buffer, char **start, off_t offset, int length)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	int len = sprintf(buffer, "Type local_addr  remote_addr tx_queue "
-				  "rx_queue st uid\n");
-	struct sock *s;
-	/* Output the AppleTalk data for the /proc filesystem */
-
-	spin_lock_bh(&atalk_sockets_lock);
-	for (s = atalk_sockets; s; s = s->next) {
-		struct atalk_sock *at = at_sk(s);
-
-		len += sprintf(buffer + len, "%02X   ", s->type);
-		len += sprintf(buffer + len, "%04X:%02X:%02X  ",
-			       ntohs(at->src_net), at->src_node, at->src_port);
-		len += sprintf(buffer + len, "%04X:%02X:%02X  ",
-			       ntohs(at->dest_net), at->dest_node,
-			       at->dest_port);
-		len += sprintf(buffer + len, "%08X:%08X ",
-			       atomic_read(&s->wmem_alloc),
-			       atomic_read(&s->rmem_alloc));
-		len += sprintf(buffer + len, "%02X %d\n", s->state, 
-			       SOCK_INODE(s->socket)->i_uid);
-
-		/* Are we still dumping unwanted data then discard the record */
-		pos = begin + len;
-
-		if (pos < offset) {
-			len = 0;	/* Keep dumping into the buffer start */
-			begin = pos;
-		}
-		if (pos > offset + length)	/* We have dumped enough */
-			break;
-	}
-	spin_unlock_bh(&atalk_sockets_lock);
-
-	/* The data in question runs from begin to begin + len */
-	*start = buffer + offset - begin;	/* Start of wanted data */
-	len -= offset - begin;   /* Remove unwanted header data from length */
-	if (len > length)
-		len = length;	   /* Remove unwanted tail data from length */
-
-	return len;
-}
-
 /**************************************************************************\
 *                                                                          *
 * Routing tables for the AppleTalk socket layer.                           *
@@ -298,14 +226,14 @@
 \**************************************************************************/
 
 /* Anti-deadlock ordering is router_lock --> iface_lock -DaveM */
-static struct atalk_route *atalk_router_list;
-static rwlock_t atalk_router_lock = RW_LOCK_UNLOCKED;
+struct atalk_route *atalk_routes;
+rwlock_t atalk_routes_lock = RW_LOCK_UNLOCKED;
 
-static struct atalk_iface *atalk_iface_list;
-static spinlock_t atalk_iface_lock = SPIN_LOCK_UNLOCKED;
+struct atalk_iface *atalk_interfaces;
+spinlock_t atalk_interfaces_lock = SPIN_LOCK_UNLOCKED;
 
 /* For probing devices or in a routerless network */
-static struct atalk_route atrtr_default;
+struct atalk_route atrtr_default;
 
 /* AppleTalk interface control */
 /*
@@ -314,10 +242,10 @@
  */
 static void atif_drop_device(struct net_device *dev)
 {
-	struct atalk_iface **iface = &atalk_iface_list;
+	struct atalk_iface **iface = &atalk_interfaces;
 	struct atalk_iface *tmp;
 
-	spin_lock_bh(&atalk_iface_lock);
+	spin_lock_bh(&atalk_interfaces_lock);
 	while ((tmp = *iface) != NULL) {
 		if (tmp->dev == dev) {
 			*iface = tmp->next;
@@ -327,7 +255,7 @@
 		} else
 			iface = &tmp->next;
 	}
-	spin_unlock_bh(&atalk_iface_lock);
+	spin_unlock_bh(&atalk_interfaces_lock);
 }
 
 static struct atalk_iface *atif_add_device(struct net_device *dev,
@@ -346,10 +274,10 @@
 	iface->address = *sa;
 	iface->status = 0;
 
-	spin_lock_bh(&atalk_iface_lock);
-	iface->next = atalk_iface_list;
-	atalk_iface_list = iface;
-	spin_unlock_bh(&atalk_iface_lock);
+	spin_lock_bh(&atalk_interfaces_lock);
+	iface->next = atalk_interfaces;
+	atalk_interfaces = iface;
+	spin_unlock_bh(&atalk_interfaces_lock);
 out:
 	return iface;
 out_mem:
@@ -466,8 +394,8 @@
 	 * Return a point-to-point interface only if
 	 * there is no non-ptp interface available.
 	 */
-	spin_lock_bh(&atalk_iface_lock);
-	for (iface = atalk_iface_list; iface; iface = iface->next) {
+	spin_lock_bh(&atalk_interfaces_lock);
+	for (iface = atalk_interfaces; iface; iface = iface->next) {
 		if (!fiface && !(iface->dev->flags & IFF_LOOPBACK))
 			fiface = iface;
 		if (!(iface->dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))) {
@@ -478,12 +406,12 @@
 
 	if (fiface)
 		retval = &fiface->address;
-	else if (atalk_iface_list)
-		retval = &atalk_iface_list->address;
+	else if (atalk_interfaces)
+		retval = &atalk_interfaces->address;
 	else
 		retval = NULL;
 out:
-	spin_unlock_bh(&atalk_iface_lock);
+	spin_unlock_bh(&atalk_interfaces_lock);
 	return retval;
 }
 
@@ -514,8 +442,8 @@
 {
 	struct atalk_iface *iface;
 
-	spin_lock_bh(&atalk_iface_lock);
-	for (iface = atalk_iface_list; iface; iface = iface->next) {
+	spin_lock_bh(&atalk_interfaces_lock);
+	for (iface = atalk_interfaces; iface; iface = iface->next) {
 		if ((node == ATADDR_BCAST ||
 		     node == ATADDR_ANYNODE ||
 		     iface->address.s_node == node) &&
@@ -529,7 +457,7 @@
 		    ntohs(net) <= ntohs(iface->nets.nr_lastnet))
 		        break;
 	}
-	spin_unlock_bh(&atalk_iface_lock);
+	spin_unlock_bh(&atalk_interfaces_lock);
 	return iface;
 }
 
@@ -549,8 +477,8 @@
 	struct atalk_route *net_route = NULL;
 	struct atalk_route *r;
 	
-	read_lock_bh(&atalk_router_lock);
-	for (r = atalk_router_list; r; r = r->next) {
+	read_lock_bh(&atalk_routes_lock);
+	for (r = atalk_routes; r; r = r->next) {
 		if (!(r->flags & RTF_UP))
 			continue;
 
@@ -582,7 +510,7 @@
 	else /* No route can be found */
 		r = NULL;
 out:
-	read_unlock_bh(&atalk_router_lock);
+	read_unlock_bh(&atalk_routes_lock);
 	return r;
 }
 
@@ -630,8 +558,8 @@
 		goto out;
 
 	/* Now walk the routing table and make our decisions */
-	write_lock_bh(&atalk_router_lock);
-	for (rt = atalk_router_list; rt; rt = rt->next) {
+	write_lock_bh(&atalk_routes_lock);
+	for (rt = atalk_routes; rt; rt = rt->next) {
 		if (r->rt_flags != rt->flags)
 			continue;
 
@@ -646,8 +574,8 @@
 	if (!devhint) {
 		riface = NULL;
 
-		spin_lock_bh(&atalk_iface_lock);
-		for (iface = atalk_iface_list; iface; iface = iface->next) {
+		spin_lock_bh(&atalk_interfaces_lock);
+		for (iface = atalk_interfaces; iface; iface = iface->next) {
 			if (!riface &&
 			    ntohs(ga->sat_addr.s_net) >=
 			    		ntohs(iface->nets.nr_firstnet) &&
@@ -659,7 +587,7 @@
 			    ga->sat_addr.s_node == iface->address.s_node)
 				riface = iface;
 		}		
-		spin_unlock_bh(&atalk_iface_lock);
+		spin_unlock_bh(&atalk_interfaces_lock);
 
 		retval = -ENETUNREACH;
 		if (!riface)
@@ -675,8 +603,8 @@
 		if (!rt)
 			goto out;
 
-		rt->next = atalk_router_list;
-		atalk_router_list = rt;
+		rt->next = atalk_routes;
+		atalk_routes = rt;
 	}
 
 	/* Fill in the routing entry */
@@ -687,7 +615,7 @@
 
 	retval = 0;
 out_unlock:
-	write_unlock_bh(&atalk_router_lock);
+	write_unlock_bh(&atalk_routes_lock);
 out:
 	return retval;
 }
@@ -695,11 +623,11 @@
 /* Delete a route. Find it and discard it */
 static int atrtr_delete(struct atalk_addr * addr)
 {
-	struct atalk_route **r = &atalk_router_list;
+	struct atalk_route **r = &atalk_routes;
 	int retval = 0;
 	struct atalk_route *tmp;
 
-	write_lock_bh(&atalk_router_lock);
+	write_lock_bh(&atalk_routes_lock);
 	while ((tmp = *r) != NULL) {
 		if (tmp->target.s_net == addr->s_net &&
 		    (!(tmp->flags&RTF_GATEWAY) ||
@@ -712,7 +640,7 @@
 	}
 	retval = -ENOENT;
 out:
-	write_unlock_bh(&atalk_router_lock);
+	write_unlock_bh(&atalk_routes_lock);
 	return retval;
 }
 
@@ -722,10 +650,10 @@
  */
 void atrtr_device_down(struct net_device *dev)
 {
-	struct atalk_route **r = &atalk_router_list;
+	struct atalk_route **r = &atalk_routes;
 	struct atalk_route *tmp;
 
-	write_lock_bh(&atalk_router_lock);
+	write_lock_bh(&atalk_routes_lock);
 	while ((tmp = *r) != NULL) {
 		if (tmp->dev == dev) {
 			*r = tmp->next;
@@ -733,7 +661,7 @@
 		} else
 			r = &tmp->next;
 	}
-	write_unlock_bh(&atalk_router_lock);
+	write_unlock_bh(&atalk_routes_lock);
 
 	if (atrtr_default.dev == dev)
 		atrtr_set_default(NULL);
@@ -1013,81 +941,6 @@
 	return -EINVAL;
 }
 
-/* Called from proc fs - just make it print the ifaces neatly */
-static int atalk_if_get_info(char *buffer, char **start, off_t offset,
-			     int length)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	struct atalk_iface *iface;
-	int len = sprintf(buffer, "Interface	  Address   "
-				  "Networks   Status\n");
-
-	spin_lock_bh(&atalk_iface_lock);
-	for (iface = atalk_iface_list; iface; iface = iface->next) {
-		len += sprintf(buffer + len, "%-16s %04X:%02X  %04X-%04X  %d\n",
-			       iface->dev->name, ntohs(iface->address.s_net),
-			       iface->address.s_node,
-			       ntohs(iface->nets.nr_firstnet),
-			       ntohs(iface->nets.nr_lastnet), iface->status);
-		pos = begin + len;
-		if (pos < offset) {
-			len   = 0;
-			begin = pos;
-		}
-		if (pos > offset + length)
-			break;
-	}
-	spin_unlock_bh(&atalk_iface_lock);
-
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
-	if (len > length)
-		len = length;
-	return len;
-}
-
-/* Called from proc fs - just make it print the routes neatly */
-static int atalk_rt_get_info(char *buffer, char **start, off_t offset,
-			     int length)
-{
-	off_t pos = 0;
-	off_t begin = 0;
-	int len = sprintf(buffer, "Target        Router  Flags Dev\n");
-	struct atalk_route *rt;
-
-	if (atrtr_default.dev) {
-		rt = &atrtr_default;
-		len += sprintf(buffer + len,
-			       "Default     %04X:%02X  %-4d  %s\n",
-			       ntohs(rt->gateway.s_net), rt->gateway.s_node,
-			       rt->flags, rt->dev->name);
-	}
-
-	read_lock_bh(&atalk_router_lock);
-	for (rt = atalk_router_list; rt; rt = rt->next) {
-		len += sprintf(buffer + len,
-				"%04X:%02X     %04X:%02X  %-4d  %s\n",
-			       ntohs(rt->target.s_net), rt->target.s_node,
-			       ntohs(rt->gateway.s_net), rt->gateway.s_node,
-			       rt->flags, rt->dev->name);
-		pos = begin + len;
-		if (pos < offset) {
-			len = 0;
-			begin = pos;
-		}
-		if (pos > offset + length)
-			break;
-	}
-	read_unlock_bh(&atalk_router_lock);
-
-	*start = buffer + (offset - begin);
-	len -= (offset - begin);
-	if (len > length)
-		len = length;
-	return len;
-}
-
 /**************************************************************************\
 *                                                                          *
 * Handling for system calls applied via the various interfaces to an       *
@@ -1991,17 +1844,14 @@
 
 	register_netdevice_notifier(&ddp_notifier);
 	aarp_proto_init();
-
-	proc_net_create("appletalk", 0, atalk_get_info);
-	proc_net_create("atalk_route", 0, atalk_rt_get_info);
-	proc_net_create("atalk_iface", 0, atalk_if_get_info);
+	atalk_proc_init();
 #ifdef CONFIG_PROC_FS
 	aarp_register_proc_fs();
 #endif /* CONFIG_PROC_FS */
 #ifdef CONFIG_SYSCTL
 	atalk_register_sysctl();
 #endif /* CONFIG_SYSCTL */
-	printk(KERN_INFO "NET4: AppleTalk 0.18a for Linux NET4.0\n");
+	printk(KERN_INFO "NET4: AppleTalk 0.20 for Linux NET4.0\n");
 	return 0;
 }
 module_init(atalk_init);
@@ -2024,9 +1874,7 @@
 #ifdef CONFIG_SYSCTL
 	atalk_unregister_sysctl();
 #endif /* CONFIG_SYSCTL */
-	proc_net_remove("appletalk");
-	proc_net_remove("atalk_route");
-	proc_net_remove("atalk_iface");
+	atalk_proc_exit();
 #ifdef CONFIG_PROC_FS
 	aarp_unregister_proc_fs();
 #endif /* CONFIG_PROC_FS */
@@ -2039,3 +1887,7 @@
 }
 module_exit(atalk_exit);
 #endif  /* MODULE */
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alan Cox <Alan.Cox@linux.org>");
+MODULE_DESCRIPTION("AppleTalk 0.20 for Linux NET4.0\n");
diff -Nru a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
--- a/net/appletalk/sysctl_net_atalk.c	Mon Oct  7 03:28:22 2002
+++ b/net/appletalk/sysctl_net_atalk.c	Mon Oct  7 03:28:22 2002
@@ -7,7 +7,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/mm.h>
 #include <linux/sysctl.h>
 
 extern int sysctl_aarp_expiry_time;
@@ -16,7 +15,7 @@
 extern int sysctl_aarp_resolve_time;
 
 #ifdef CONFIG_SYSCTL
-static ctl_table atalk_table[] = {
+static struct ctl_table atalk_table[] = {
 	{
 		.ctl_name	= NET_ATALK_AARP_EXPIRY_TIME,
 		.procname	= "aarp-expiry-time",
@@ -52,7 +51,7 @@
 	{ 0 },
 };
 
-static ctl_table atalk_dir_table[] = {
+static struct ctl_table atalk_dir_table[] = {
 	{
 		.ctl_name	= NET_ATALK,
 		.procname	= "appletalk",
@@ -62,7 +61,7 @@
 	{ 0 },
 };
 
-static ctl_table atalk_root_table[] = {
+static struct ctl_table atalk_root_table[] = {
 	{
 		.ctl_name	= CTL_NET,
 		.procname	= "net",

===================================================================


This BitKeeper patch contains the following changesets:
1.632
## Wrapped with gzip_uu ##


begin 664 bkpatch18241
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
@@>]'.='TCX7M";7OPL7TC3$:XV=T3?@O_'+2#)X\````
`
end
