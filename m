Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263455AbSJGXGD>; Mon, 7 Oct 2002 19:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263492AbSJGXGD>; Mon, 7 Oct 2002 19:06:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263455AbSJGXEJ>;
	Mon, 7 Oct 2002 19:04:09 -0400
Date: Tue, 8 Oct 2002 00:09:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Second round of ioctl cleanups
Message-ID: <20021008000948.O18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - decnet: we should always call the device for unknown ioctls.
 - move dlci, bridging, vlan and divert ioctls from af_inet.c to net/socket.c.
 - remove duplicate code from af_packet.c and af_wanpipe.c.
 - remove kmod from af_inet.c; no longer needed.
 - no longer export divert_ioctl; it's not used from a module.
 - don't depend on CONFIG_*_MODULE so we can just add these later as modules
   without forcing a kernel recompile.  total cost: 3 * sizeof(void *) in bss.
 - remove the WIRELESS_EXT conditional; always compiling this in costs
   almost nothing.

diff -urpNX dontdiff linux-2.5.41/net/decnet/af_decnet.c linux-2.5.41-willy/net/decnet/af_decnet.c
--- linux-2.5.41/net/decnet/af_decnet.c	2002-10-01 03:07:01.000000000 -0400
+++ linux-2.5.41-willy/net/decnet/af_decnet.c	2002-10-07 18:10:19.000000000 -0400
@@ -1227,10 +1227,6 @@ static int dn_ioctl(struct socket *sock,
 	case OSIOCGNETADDR:
 		err = put_user(decnet_address, (unsigned short *)arg);
 		break;
-        case SIOCGIFCONF:
-        case SIOCGIFFLAGS:
-        case SIOCGIFBRDADDR:
-                return dev_ioctl(cmd,(void *)arg);
 
 	case TIOCOUTQ:
 		amount = sk->sndbuf - atomic_read(&sk->wmem_alloc);
@@ -1255,6 +1251,10 @@ static int dn_ioctl(struct socket *sock,
 		release_sock(sk);
 		err = put_user(amount, (int *)arg);
 		break;
+
+	default:
+		err = dev_ioctl(cmd,(void *)arg);
+		break;
 	}
 
 	return err;
diff -urpNX dontdiff linux-2.5.41/net/ipv4/af_inet.c linux-2.5.41-willy/net/ipv4/af_inet.c
--- linux-2.5.41/net/ipv4/af_inet.c	2002-10-07 17:00:40.000000000 -0400
+++ linux-2.5.41-willy/net/ipv4/af_inet.c	2002-10-07 17:00:55.000000000 -0400
@@ -54,11 +54,9 @@
  *		Alan Cox	:	Only sendmsg/recvmsg now supported.
  *		Alan Cox	:	Locked down bind (see security list).
  *		Alan Cox	:	Loosened bind a little.
- *		Mike McLagan	:	ADD/DEL DLCI Ioctls
  *	Willy Konynenberg	:	Transparent proxying support.
  *		David S. Miller	:	New socket lookup architecture.
  *					Some other random speedups.
- *		Cyrus Durgin	:	Cleaned up file for kmod hacks.
  *		Andi Kleen	:	Fix inet_stream_connect TCP race.
  *
  *		This program is free software; you can redistribute it and/or
@@ -110,13 +108,6 @@
 #ifdef CONFIG_IP_MROUTE
 #include <linux/mroute.h>
 #endif
-#include <linux/if_bridge.h>
-#ifdef CONFIG_KMOD
-#include <linux/kmod.h>
-#endif
-#ifdef CONFIG_NET_DIVERT
-#include <linux/divert.h>
-#endif /* CONFIG_NET_DIVERT */
 
 struct linux_mib net_statistics[NR_CPUS * 2];
 
@@ -132,22 +123,6 @@ extern int tcp_get_info(char *, char **,
 extern int udp_get_info(char *, char **, off_t, int);
 extern void ip_mc_drop_socket(struct sock *sk);
 
-#ifdef CONFIG_DLCI
-extern int dlci_ioctl(unsigned int, void *);
-#endif
-
-#ifdef CONFIG_DLCI_MODULE
-int (*dlci_ioctl_hook)(unsigned int, void *);
-#endif
-
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-int (*br_ioctl_hook)(unsigned long);
-#endif
-
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
-int (*vlan_ioctl_hook)(unsigned long arg);
-#endif
-
 /* Per protocol sock slabcache */
 kmem_cache_t *tcp_sk_cachep;
 static kmem_cache_t *udp_sk_cachep;
@@ -879,60 +854,6 @@ int inet_ioctl(struct socket *sock, unsi
 		case SIOCSIFFLAGS:
 			err = devinet_ioctl(cmd, (void *)arg);
 			break;
-		case SIOCGIFBR:
-		case SIOCSIFBR:
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-#ifdef CONFIG_KMOD
-			if (!br_ioctl_hook)
-				request_module("bridge");
-#endif
-			if (br_ioctl_hook)
-				err = br_ioctl_hook(arg);
-			else
-#endif
-			err = -ENOPKG;
-			break;
-		case SIOCGIFVLAN:
-		case SIOCSIFVLAN:
-#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
-#ifdef CONFIG_KMOD
-			if (!vlan_ioctl_hook)
-				request_module("8021q");
-#endif
-			if (vlan_ioctl_hook)
-				err = vlan_ioctl_hook(arg);
-			else
-#endif
-			err = -ENOPKG;
-			break;
-		case SIOCGIFDIVERT:
-		case SIOCSIFDIVERT:
-#ifdef CONFIG_NET_DIVERT
-			err = divert_ioctl(cmd, (struct divert_cf *)arg);
-#else
-			err = -ENOPKG;
-#endif	/* CONFIG_NET_DIVERT */
-			break;
-		case SIOCADDDLCI:
-		case SIOCDELDLCI:
-#ifdef CONFIG_DLCI
-			lock_kernel();
-			err = dlci_ioctl(cmd, (void *)arg);
-			unlock_kernel();
-			break;
-#elif CONFIG_DLCI_MODULE
-#ifdef CONFIG_KMOD
-			if (!dlci_ioctl_hook)
-				request_module("dlci");
-#endif
-			if (dlci_ioctl_hook) {
-				lock_kernel();
-				err = (*dlci_ioctl_hook)(cmd, (void *)arg);
-				unlock_kernel();
-			} else
-#endif
-			err = -ENOPKG;
-			break;
 		default:
 			if (!sk->prot->ioctl ||
 			    (err = sk->prot->ioctl(sk, cmd, arg)) ==
diff -urpNX dontdiff linux-2.5.41/net/netsyms.c linux-2.5.41-willy/net/netsyms.c
--- linux-2.5.41/net/netsyms.c	2002-10-07 17:00:40.000000000 -0400
+++ linux-2.5.41-willy/net/netsyms.c	2002-10-07 17:44:41.000000000 -0400
@@ -220,8 +220,8 @@ EXPORT_SYMBOL(destroy_EII_client);
 /* for 801q VLAN support */
 #if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 EXPORT_SYMBOL(dev_change_flags);
-EXPORT_SYMBOL(vlan_ioctl_hook);
 #endif
+EXPORT_SYMBOL(vlan_ioctl_hook);
 
 EXPORT_SYMBOL(sklist_destroy_socket);
 EXPORT_SYMBOL(sklist_insert_socket);
@@ -230,15 +230,12 @@ EXPORT_SYMBOL(scm_detach_fds);
 
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 EXPORT_SYMBOL(br_handle_frame_hook);
-#ifdef CONFIG_INET
-EXPORT_SYMBOL(br_ioctl_hook);
-#endif
 #endif
+EXPORT_SYMBOL(br_ioctl_hook);
 
 #ifdef CONFIG_NET_DIVERT
 EXPORT_SYMBOL(alloc_divert_blk);
 EXPORT_SYMBOL(free_divert_blk);
-EXPORT_SYMBOL(divert_ioctl);
 #endif /* CONFIG_NET_DIVERT */
 
 #ifdef CONFIG_INET
diff -urpNX dontdiff linux-2.5.41/net/packet/af_packet.c linux-2.5.41-willy/net/packet/af_packet.c
--- linux-2.5.41/net/packet/af_packet.c	2002-10-07 17:00:40.000000000 -0400
+++ linux-2.5.41-willy/net/packet/af_packet.c	2002-10-07 18:43:19.000000000 -0400
@@ -67,20 +67,11 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/if_bridge.h>
-
-#ifdef CONFIG_NET_DIVERT
-#include <linux/divert.h>
-#endif /* CONFIG_NET_DIVERT */
 
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
 #endif
 
-#ifdef CONFIG_DLCI
-extern int dlci_ioctl(unsigned int, void*);
-#endif
-
 #define CONFIG_SOCK_PACKET	1
 
 /*
@@ -1489,28 +1480,6 @@ static int packet_ioctl(struct socket *s
 		case SIOCSIFHWBROADCAST:
 			return(dev_ioctl(cmd,(void *) arg));
 
-		case SIOCGIFBR:
-		case SIOCSIFBR:
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-#ifdef CONFIG_INET
-#ifdef CONFIG_KMOD
-			if (br_ioctl_hook == NULL)
-				request_module("bridge");
-#endif
-			if (br_ioctl_hook != NULL)
-				return br_ioctl_hook(arg);
-#endif
-#endif				
-			return -ENOPKG;
-
-		case SIOCGIFDIVERT:
-		case SIOCSIFDIVERT:
-#ifdef CONFIG_NET_DIVERT
-			return divert_ioctl(cmd, (struct divert_cf *) arg);
-#else
-			return -ENOPKG;
-#endif /* CONFIG_NET_DIVERT */
-			
 #ifdef CONFIG_INET
 		case SIOCADDRT:
 		case SIOCDELRT:
@@ -1526,8 +1495,6 @@ static int packet_ioctl(struct socket *s
 		case SIOCGIFDSTADDR:
 		case SIOCSIFDSTADDR:
 		case SIOCSIFFLAGS:
-		case SIOCADDDLCI:
-		case SIOCDELDLCI:
 			return inet_dgram_ops.ioctl(sock, cmd, arg);
 #endif
 
diff -urpNX dontdiff linux-2.5.41/net/socket.c linux-2.5.41-willy/net/socket.c
--- linux-2.5.41/net/socket.c	2002-10-07 17:00:40.000000000 -0400
+++ linux-2.5.41-willy/net/socket.c	2002-10-07 17:00:56.000000000 -0400
@@ -74,6 +74,8 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/wireless.h>
+#include <linux/divert.h>
 
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
 #include <linux/kmod.h>
@@ -678,6 +680,15 @@ static ssize_t sock_writev(struct file *
 				 file, vector, count, tot_len);
 }
 
+int (*br_ioctl_hook)(unsigned long arg);
+int (*vlan_ioctl_hook)(unsigned long arg);
+
+#ifdef CONFIG_DLCI
+extern int dlci_ioctl(unsigned int, void *);
+#else
+int (*dlci_ioctl_hook)(unsigned int, void *);
+#endif
+
 /*
  *	With an ioctl, arg may well be a user mode pointer, but we don't know
  *	what to do with it - that's up to the protocol still.
@@ -693,13 +704,9 @@ int sock_ioctl(struct inode *inode, stru
 	sock = SOCKET_I(inode);
 	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		err = dev_ioctl(cmd, (void *)arg);
-	} else
-#ifdef WIRELESS_EXT
-	if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
+	} else if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST) {
 		err = dev_ioctl(cmd, (void *)arg);
-	} else
-#endif	/* WIRELESS_EXT */
-	switch (cmd) {
+	} else switch (cmd) {
 		case FIOSETOWN:
 		case SIOCSPGRP:
 			err = -EFAULT;
@@ -711,6 +718,56 @@ int sock_ioctl(struct inode *inode, stru
 		case SIOCGPGRP:
 			err = put_user(sock->file->f_owner.pid, (int *)arg);
 			break;
+		case SIOCGIFBR:
+		case SIOCSIFBR:
+			err = -ENOPKG;
+#ifdef CONFIG_KMOD
+			if (!br_ioctl_hook)
+				request_module("bridge");
+#endif
+			if (br_ioctl_hook)
+				err = br_ioctl_hook(arg);
+			break;
+		case SIOCGIFVLAN:
+		case SIOCSIFVLAN:
+			err = -ENOPKG;
+#ifdef CONFIG_KMOD
+			if (!vlan_ioctl_hook)
+				request_module("8021q");
+#endif
+			if (vlan_ioctl_hook)
+				err = vlan_ioctl_hook(arg);
+			break;
+		case SIOCGIFDIVERT:
+		case SIOCSIFDIVERT:
+		/* Convert this to call through a hook */
+#ifdef CONFIG_NET_DIVERT
+			err = divert_ioctl(cmd, (struct divert_cf *)arg);
+#else
+			err = -ENOPKG;
+#endif	/* CONFIG_NET_DIVERT */
+			break;
+		case SIOCADDDLCI:
+		case SIOCDELDLCI:
+		/* Convert this to always call through a hook */
+#ifdef CONFIG_DLCI
+			lock_kernel();
+			err = dlci_ioctl(cmd, (void *)arg);
+			unlock_kernel();
+			break;
+#else
+			err = -ENOPKG;
+#ifdef CONFIG_KMOD
+			if (!dlci_ioctl_hook)
+				request_module("dlci");
+#endif
+			if (dlci_ioctl_hook) {
+				lock_kernel();
+				err = dlci_ioctl_hook(cmd, (void *)arg);
+				unlock_kernel();
+			}
+#endif
+			break;
 		default:
 			err = sock->ops->ioctl(sock, cmd, arg);
 			break;
diff -urpNX dontdiff linux-2.5.41/net/wanrouter/af_wanpipe.c linux-2.5.41-willy/net/wanrouter/af_wanpipe.c
--- linux-2.5.41/net/wanrouter/af_wanpipe.c	2002-10-07 17:00:40.000000000 -0400
+++ linux-2.5.41-willy/net/wanrouter/af_wanpipe.c	2002-10-07 18:42:47.000000000 -0400
@@ -1963,8 +1963,6 @@ static int wanpipe_ioctl(struct socket *
 		case SIOCGIFDSTADDR:
 		case SIOCSIFDSTADDR:
 		case SIOCSIFFLAGS:
-		case SIOCADDDLCI:
-		case SIOCDELDLCI:
 			return inet_dgram_ops.ioctl(sock, cmd, arg);
 #endif
 

-- 
Revolutions do not require corporate support.
