Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTATQ7S>; Mon, 20 Jan 2003 11:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTATQ7R>; Mon, 20 Jan 2003 11:59:17 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:7665 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266609AbTATQ7F>; Mon, 20 Jan 2003 11:59:05 -0500
Date: Sun, 19 Jan 2003 19:22:44 -0800 (PST)
From: Max Krasnyansky <maxk@qualcomm.com>
To: <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
In-Reply-To: <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com>
Message-ID: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This isn't rocket science, just make a new sock_foo() interface
> that merely does the module owner setup.

Ok. I really think that we should do module refcounting in the struct 
socket (sock) and struct sock (sk) separately. The only reason to do 
module refcounting in sk is if protocol changes default callbacks 
(i.e. sk->data_ready, etc). Many protocols don't and therefor there is 
no need to keep track of those modules.
So here is new patch.
	socket->owner protects socket->ops
	sk->owner     protects sk callbacks

Protocols that change default callbacks will have to do something like

	sk_set_owner(sk, THIS_MODULE);

	sk->data_read = xxx_data_ready;
	...

Module will be released when sk is destroyed.

Max

===== include/linux/net.h 1.7 vs edited =====
--- 1.7/include/linux/net.h	Tue Oct 15 16:08:01 2002
+++ edited/include/linux/net.h	Sat Jan 18 15:57:01 2003
@@ -76,6 +76,8 @@
 
 	short			type;
 	unsigned char		passcred;
+
+	struct module           *owner;
 };
 
 struct scm_cookie;
@@ -124,6 +126,8 @@
 	short	authentication;
 	short	encryption;
 	short	encrypt_net;
+
+	struct  module *owner;
 };
 
 struct net_proto 
===== include/net/sock.h 1.29 vs edited =====
--- 1.29/include/net/sock.h	Sun Nov 17 04:58:01 2002
+++ edited/include/net/sock.h	Sat Jan 18 18:09:09 2003
@@ -41,6 +41,7 @@
 #include <linux/config.h>
 #include <linux/timer.h>
 #include <linux/cache.h>
+#include <linux/module.h>
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
@@ -196,7 +197,9 @@
 
 	/* RPC layer private data */
 	void			*user_data;
-  
+
+	struct module		*owner;
+	
 	/* Callbacks */
 	void			(*state_change)(struct sock *sk);
 	void			(*data_ready)(struct sock *sk,int bytes);
@@ -685,6 +688,19 @@
 	return dst;
 }
 
+/*
+ * Set sk owner.
+ * Must be called by protocols that change sk callbacks.
+ * Owner module will be released when sk is destroyed.
+ */
+
+static inline int sk_set_owner(struct sock *sk, struct module *owner)
+{
+	if (!try_module_get(owner))
+		return -EINVAL;
+	sk->owner = owner;
+	return 0;
+}
 
 /*
  * 	Queue a received datagram if it will fit. Stream and sequenced
===== net/socket.c 1.41 vs edited =====
--- 1.41/net/socket.c	Tue Jan  7 02:17:34 2003
+++ edited/net/socket.c	Sat Jan 18 18:27:39 2003
@@ -466,6 +466,8 @@
 
 	sock = SOCKET_I(inode);
 
+	sock->owner = NULL;
+	
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
 	inode->i_sock = 1;
 	inode->i_uid = current->fsuid;
@@ -515,6 +517,8 @@
 		return;
 	}
 	sock->file=NULL;
+
+	module_put(sock->owner);
 }
 
 static int __sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, int size)
@@ -962,8 +966,9 @@
 
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
-	int i;
+	struct net_proto_family *npf;
 	struct socket *sock;
+	int err;
 
 	/*
 	 *	Check protocol is in range
@@ -988,14 +993,8 @@
 	}
 		
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
-	/* Attempt to load a protocol module if the find failed. 
-	 * 
-	 * 12/09/1996 Marcin: But! this makes REALLY only sense, if the user 
-	 * requested real, full-featured networking support upon configuration.
-	 * Otherwise module support will break!
-	 */
-	if (net_families[family]==NULL)
-	{
+	/* Attempt to load a protocol module if the find failed. */
+	if (net_families[family]==NULL) {
 		char module_name[30];
 		sprintf(module_name,"net-pf-%d",family);
 		request_module(module_name);
@@ -1003,29 +1002,32 @@
 #endif
 
 	net_family_read_lock();
-	if (net_families[family] == NULL) {
-		i = -EAFNOSUPPORT;
-		goto out;
-	}
 
-/*
- *	Allocate the socket and allow the family to set things up. if
- *	the protocol is 0, the family is instructed to select an appropriate
- *	default.
- */
+	npf = net_families[family];
+	if (!npf || !try_module_get(npf->owner)) {
+		net_family_read_unlock();
+		return -EAFNOSUPPORT;
+	}
+	
+	/*
+	 * Allocate the socket and allow the family to set things up. if
+	 * the protocol is 0, the family is instructed to select an appropriate
+	 * default.
+ 	 */
 
-	if (!(sock = sock_alloc())) 
-	{
+	sock = sock_alloc();
+	if (!sock) {
 		printk(KERN_WARNING "socket: no more sockets\n");
-		i = -ENFILE;		/* Not exactly a match, but its the
+		err = -ENFILE;		/* Not exactly a match, but its the
 					   closest posix thing */
+		module_put(npf->owner);
 		goto out;
 	}
 
 	sock->type  = type;
+	sock->owner = npf->owner;
 
-	if ((i = net_families[family]->create(sock, protocol)) < 0) 
-	{
+	if ((err = npf->create(sock, protocol)) < 0) {
 		sock_release(sock);
 		goto out;
 	}
@@ -1034,7 +1036,7 @@
 
 out:
 	net_family_read_unlock();
-	return i;
+	return err;
 }
 
 asmlinkage long sys_socket(int family, int type, int protocol)
@@ -1196,9 +1198,13 @@
 	if (!(newsock = sock_alloc())) 
 		goto out_put;
 
-	newsock->type = sock->type;
-	newsock->ops = sock->ops;
+	newsock->type  = sock->type;
+	newsock->ops   = sock->ops;
+	newsock->owner = sock->owner;
 
+	try_module_get(sock->owner);
+	newsock->owner = sock->owner;
+	
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
 		goto out_release;
===== net/core/sock.c 1.14 vs edited =====
--- 1.14/net/core/sock.c	Fri Oct 18 17:45:16 2002
+++ edited/net/core/sock.c	Sat Jan 18 17:48:42 2003
@@ -601,6 +601,7 @@
 			sock_lock_init(sk);
 		}
 		sk->slab = slab;
+		sk->owner = NULL;
 	}
 
 	return sk;
@@ -626,6 +627,8 @@
 	if (atomic_read(&sk->omem_alloc))
 		printk(KERN_DEBUG "sk_free: optmem leakage (%d bytes) detected.\n", atomic_read(&sk->omem_alloc));
 
+	module_put(sk->owner);
+	
 	kmem_cache_free(sk->slab, sk);
 }
 
@@ -1084,8 +1087,7 @@
 	sk->zapped	=	1;
 	sk->socket	=	sock;
 
-	if(sock)
-	{
+	if (sock) {
 		sk->type	=	sock->type;
 		sk->sleep	=	&sock->wait;
 		sock->sk	=	sk;
-- 






