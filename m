Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbRAKLsS>; Thu, 11 Jan 2001 06:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbRAKLsH>; Thu, 11 Jan 2001 06:48:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130864AbRAKLrr>;
	Thu, 11 Jan 2001 06:47:47 -0500
Date: Wed, 10 Jan 2001 19:47:40 -0800
Message-Id: <200101110347.TAA00866@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: darryl@netbauds.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A5D9A82.2568646B@netbauds.net> (message from Darryl Miles on
	Thu, 11 Jan 2001 11:35:30 +0000)
Subject: Re: 2.4.0: Small observation in /proc/sys/net/unix/
In-Reply-To: <3A5D9A82.2568646B@netbauds.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 11 Jan 2001 11:35:30 +0000
   From: Darryl Miles <darryl@netbauds.net>

   Identical filenames, nothing bad appears to be happening it just
   looks weird.

Known problem, here is the fix:

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/sysctl_net.c linux/net/sysctl_net.c
--- vanilla/linux/net/sysctl_net.c	Thu Mar  9 06:57:17 2000
+++ linux/net/sysctl_net.c	Sat Jan  6 22:45:24 2001
@@ -26,10 +26,6 @@
 
 extern ctl_table core_table[];
 
-#ifdef CONFIG_UNIX
-extern ctl_table unix_table[];
-#endif
-
 #ifdef CONFIG_NET
 extern ctl_table ether_table[], e802_table[];
 #endif
@@ -48,9 +44,6 @@
 
 ctl_table net_table[] = {
 	{NET_CORE,   "core",      NULL, 0, 0555, core_table},      
-#ifdef CONFIG_UNIX
-        {NET_UNIX,   "unix",      NULL, 0, 0555, unix_table},
-#endif
 #ifdef CONFIG_NET
 	{NET_802,    "802",       NULL, 0, 0555, e802_table},
 	{NET_ETHER,  "ethernet",  NULL, 0, 0555, ether_table},
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/unix/Makefile linux/net/unix/Makefile
--- vanilla/linux/net/unix/Makefile	Fri Dec 29 14:07:24 2000
+++ linux/net/unix/Makefile	Sat Jan  6 22:45:24 2001
@@ -16,5 +16,3 @@
 
 include $(TOPDIR)/Rules.make
 
-tar:
-		tar -cvf /dev/f1 .
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/unix/af_unix.c linux/net/unix/af_unix.c
--- vanilla/linux/net/unix/af_unix.c	Sat Nov 11 19:02:41 2000
+++ linux/net/unix/af_unix.c	Sat Jan  6 22:45:24 2001
@@ -1,5 +1,5 @@
 /*
- * NET3:	Implementation of BSD Unix domain sockets.
+ * NET4:	Implementation of BSD Unix domain sockets.
  *
  * Authors:	Alan Cox, <alan.cox@linux.org>
  *
@@ -8,7 +8,7 @@
  *		as published by the Free Software Foundation; either version
  *		2 of the License, or (at your option) any later version.
  *
- * Version:	$Id: af_unix.c,v 1.108 2000/11/10 04:02:04 davem Exp $
+ * Version:	$Id: af_unix.c,v 1.109 2001/01/06 00:42:23 davem Exp $
  *
  * Fixes:
  *		Linus Torvalds	:	Assorted bug cures.
@@ -124,13 +124,12 @@
 #define UNIX_ABSTRACT(sk)	((sk)->protinfo.af_unix.addr->hash!=UNIX_HASH_SIZE)
 
 /*
-   SMP locking strategy.
-   * hash table is protceted with rwlock unix_table_lock
-   * each socket state is protected by separate rwlock.
-
+ *  SMP locking strategy:
+ *    hash table is protected with rwlock unix_table_lock
+ *    each socket state is protected by separate rwlock.
  */
 
-extern __inline__ unsigned unix_hash_fold(unsigned hash)
+static inline unsigned unix_hash_fold(unsigned hash)
 {
 	hash ^= hash>>16;
 	hash ^= hash>>8;
@@ -139,17 +138,17 @@
 
 #define unix_peer(sk) ((sk)->pair)
 
-extern __inline__ int unix_our_peer(unix_socket *sk, unix_socket *osk)
+static inline int unix_our_peer(unix_socket *sk, unix_socket *osk)
 {
 	return unix_peer(osk) == sk;
 }
 
-extern __inline__ int unix_may_send(unix_socket *sk, unix_socket *osk)
+static inline int unix_may_send(unix_socket *sk, unix_socket *osk)
 {
 	return (unix_peer(osk) == NULL || unix_our_peer(sk, osk));
 }
 
-static __inline__ unix_socket * unix_peer_get(unix_socket *s)
+static inline unix_socket * unix_peer_get(unix_socket *s)
 {
 	unix_socket *peer;
 
@@ -161,7 +160,7 @@
 	return peer;
 }
 
-extern __inline__ void unix_release_addr(struct unix_address *addr)
+extern inline void unix_release_addr(struct unix_address *addr)
 {
 	if (atomic_dec_and_test(&addr->refcnt))
 		kfree(addr);
@@ -231,14 +230,14 @@
 	sock_hold(sk);
 }
 
-static __inline__ void unix_remove_socket(unix_socket *sk)
+static inline void unix_remove_socket(unix_socket *sk)
 {
 	write_lock(&unix_table_lock);
 	__unix_remove_socket(sk);
 	write_unlock(&unix_table_lock);
 }
 
-static __inline__ void unix_insert_socket(unix_socket **list, unix_socket *sk)
+static inline void unix_insert_socket(unix_socket **list, unix_socket *sk)
 {
 	write_lock(&unix_table_lock);
 	__unix_insert_socket(list, sk);
@@ -258,7 +257,7 @@
 	return NULL;
 }
 
-static __inline__ unix_socket *
+static inline unix_socket *
 unix_find_socket_byname(struct sockaddr_un *sunname,
 			int len, int type, unsigned hash)
 {
@@ -291,7 +290,7 @@
 	return s;
 }
 
-static __inline__ int unix_writable(struct sock *sk)
+static inline int unix_writable(struct sock *sk)
 {
 	return ((atomic_read(&sk->wmem_alloc)<<2) <= sk->sndbuf);
 }
@@ -1823,7 +1822,7 @@
 
 struct proto_ops unix_dgram_ops = {
 	family:		PF_UNIX,
-	
+
 	release:	unix_release,
 	bind:		unix_bind,
 	connect:	unix_dgram_connect,
@@ -1842,20 +1841,25 @@
 };
 
 struct net_proto_family unix_family_ops = {
-	PF_UNIX,
-	unix_create
+	family:		PF_UNIX,
+	create:		unix_create
 };
 
 #ifdef CONFIG_SYSCTL
 extern void unix_sysctl_register(void);
 extern void unix_sysctl_unregister(void);
+#else
+static inline unix_sysctl_register() {};
+static inline unix_sysctl_unregister() {};
 #endif
 
+static const char banner[] __initdata = KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";
+
 static int __init af_unix_init(void)
 {
 	struct sk_buff *dummy_skb;
-	
-	printk(KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n");
+
+	printk(banner);
 	if (sizeof(struct unix_skb_parms) > sizeof(dummy_skb->cb))
 	{
 		printk(KERN_CRIT "unix_proto_init: panic\n");
@@ -1865,23 +1869,15 @@
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("net/unix", 0, 0, unix_read_proc, NULL);
 #endif
-
-#ifdef CONFIG_SYSCTL
 	unix_sysctl_register();
-#endif
-
 	return 0;
 }
 
 static void __exit af_unix_exit(void)
 {
 	sock_unregister(PF_UNIX);
-#ifdef CONFIG_SYSCTL
 	unix_sysctl_unregister();
-#endif
-#ifdef CONFIG_PROC_FS
 	remove_proc_entry("net/unix", 0);
-#endif
 }
 
 module_init(af_unix_init);
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/net/unix/sysctl_net_unix.c linux/net/unix/sysctl_net_unix.c
--- vanilla/linux/net/unix/sysctl_net_unix.c	Mon Oct 16 12:42:54 2000
+++ linux/net/unix/sysctl_net_unix.c	Sat Jan  6 22:45:24 2001
@@ -1,10 +1,8 @@
 /*
- * NET3:	Sysctl interface to net af_unix subsystem.
+ * NET4:	Sysctl interface to net af_unix subsystem.
  *
  * Authors:	Mike Shaver.
  *
- *		Added /proc/sys/net/unix directory entry (empty =) ).
- *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
  *		as published by the Free Software Foundation; either version
@@ -15,8 +13,6 @@
 #include <linux/sysctl.h>
 #include <linux/config.h>
 
-#ifdef CONFIG_SYSCTL
-
 extern int sysctl_unix_max_dgram_qlen;
 
 ctl_table unix_table[] = {
@@ -26,20 +22,18 @@
 	{0}
 };
 
-static struct ctl_table_header * unix_sysctl_header;
-static struct ctl_table unix_root_table[];
-static struct ctl_table unix_net_table[];
-
-ctl_table unix_root_table[] = {
-	{CTL_NET, "net", NULL, 0, 0555, unix_net_table},
+static ctl_table unix_net_table[] = {
+	{NET_UNIX, "unix", NULL, 0, 0555, unix_table},
 	{0}
 };
 
-ctl_table unix_net_table[] = {
-	{NET_UNIX, "unix", NULL, 0, 0555, unix_table},
+static ctl_table unix_root_table[] = {
+	{CTL_NET, "net", NULL, 0, 0555, unix_net_table},
 	{0}
 };
 
+static struct ctl_table_header * unix_sysctl_header;
+
 void unix_sysctl_register(void)
 {
 	unix_sysctl_header = register_sysctl_table(unix_root_table, 0);
@@ -50,4 +44,3 @@
 	unregister_sysctl_table(unix_sysctl_header);
 }
 
-#endif	/* CONFIG_SYSCTL */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
