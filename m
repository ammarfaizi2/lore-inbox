Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSLZVtN>; Thu, 26 Dec 2002 16:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSLZVtN>; Thu, 26 Dec 2002 16:49:13 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:34191 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264630AbSLZVtK>; Thu, 26 Dec 2002 16:49:10 -0500
Date: Thu, 26 Dec 2002 00:11:43 -0800 (PST)
From: Max Krasnyansky <maxk@qualcomm.com>
To: <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Message-ID: <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bunch of problems with this patch:
>
> 1) Module leak.  If try_module_get(npf->owner) works but sock_alloc()
>    fails, we never put the module.  It just branches to the "out"
>    label in that case, which unlocks the net_family table and returns
>    err.
Yeah, I missed that one. Fixed in the new patch.

> 2) Bigger issue, why not attach the owner to struct sock
>    instead of socket?  The sock can exist, and thus reference
>    the protocol family code, long after the socket (ie. the
>    user end) is killed off and closed.
>
>    For example, this could happen for just about any protocol family
>    due to stray device sk_buff references to the sock and thus the
>    protocol family.
Good point. Alghough generic socket code does not necessarily reference 
proto family module via struct sock. Only in case when family installed 
non default callbacks (sk->dataready, sk->destruct, etc). Some families
(af_ipx for example) don't. But I think it's a good idea to refcount 
struct sock anyway. 

Ok. Here is the new patch. 
We still need owner field in struct socket.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889   -> 1.890  
#	        net/socket.c	1.39    -> 1.40   
#	 include/linux/net.h	1.7     -> 1.8    
#	  include/net/sock.h	1.29    -> 1.30   
#	     net/core/sock.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/25	maxk@qualcomm.com	1.890
# Convert generic socket code to the new module refcounting API.
# --------------------------------------------
#
diff -Nru a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	Wed Dec 25 23:29:28 2002
+++ b/include/linux/net.h	Wed Dec 25 23:29:28 2002
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
diff -Nru a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	Wed Dec 25 23:29:28 2002
+++ b/include/net/sock.h	Wed Dec 25 23:29:28 2002
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
@@ -577,6 +580,9 @@
 
 static inline void sock_graft(struct sock *sk, struct socket *parent)
 {
+	try_module_get(parent->owner);
+	sk->owner = parent->owner;
+
 	write_lock_bh(&sk->callback_lock);
 	sk->sleep = &parent->wait;
 	parent->sk = sk;
diff -Nru a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	Wed Dec 25 23:29:28 2002
+++ b/net/core/sock.c	Wed Dec 25 23:29:28 2002
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
 
@@ -1084,10 +1087,10 @@
 	sk->zapped	=	1;
 	sk->socket	=	sock;
 
-	if(sock)
-	{
+	if (sock) {
 		sk->type	=	sock->type;
 		sk->sleep	=	&sock->wait;
+		sk->owner       =       sock->owner;
 		sock->sk	=	sk;
 	} else
 		sk->sleep	=	NULL;
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Wed Dec 25 23:29:28 2002
+++ b/net/socket.c	Wed Dec 25 23:29:28 2002
@@ -470,6 +470,8 @@
 
 	sock = SOCKET_I(inode);
 
+	sock->owner = NULL;
+	
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
 	inode->i_sock = 1;
 	inode->i_uid = current->fsuid;
@@ -964,8 +966,9 @@
 
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
-	int i;
+	struct net_proto_family *npf;
 	struct socket *sock;
+	int err;
 
 	/*
 	 *	Check protocol is in range
@@ -990,14 +993,8 @@
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
@@ -1005,29 +1002,31 @@
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
@@ -1036,7 +1035,9 @@
 
 out:
 	net_family_read_unlock();
-	return i;
+	if (err)
+		module_put(npf->owner);
+	return err;
 }
 
 asmlinkage long sys_socket(int family, int type, int protocol)
@@ -1198,9 +1199,10 @@
 	if (!(newsock = sock_alloc())) 
 		goto out_put;
 
-	newsock->type = sock->type;
-	newsock->ops = sock->ops;
-
+	newsock->type  = sock->type;
+	newsock->ops   = sock->ops;
+	newsock->owner = sock->owner;
+	
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
 		goto out_release;

--

Max


