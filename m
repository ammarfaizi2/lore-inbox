Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbSLRRmJ>; Wed, 18 Dec 2002 12:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbSLRRmJ>; Wed, 18 Dec 2002 12:42:09 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:41174 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267196AbSLRRmG>; Wed, 18 Dec 2002 12:42:06 -0500
Subject: [PATCH/RFC] New module refcounting for net_proto_family
From: Max Krasnyansky <maxk@qualcomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Qualcomm
Message-Id: <1040225146.1873.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 18 Dec 2002 07:25:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

It seems that new module code is going to stay with us at least for a
while :).
So it's probably time to start fixing old interfaces to use new
refcounting scheme.

Here is a patch for sock_create() and stuff that uses net_proto_family
interface. Tested with modified af_bluetooth.c and seems to work fine.
Other families are unaffected for now because their owner field == NULL.

If people are ok with this aproach I will also fix af_unix and other
families and push all fixes into my BK tree.

(URL in case if my mailer messed up spaces
http://bluez.sourceforge.net/patches/npf_refcnt_patch-2.5.52.gz)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.888   -> 1.889  
#	        net/socket.c	1.39    -> 1.40   
#	 include/linux/net.h	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/17	maxk@qualcomm.com	1.889
# Convert generic socket code to new module refcounting.
# --------------------------------------------
#
diff -Nru a/include/linux/net.h b/include/linux/net.h
--- a/include/linux/net.h	Tue Dec 17 20:02:04 2002
+++ b/include/linux/net.h	Tue Dec 17 20:02:04 2002
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
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Tue Dec 17 20:02:04 2002
+++ b/net/socket.c	Tue Dec 17 20:02:04 2002
@@ -470,6 +470,8 @@
 
 	sock = SOCKET_I(inode);
 
+	sock->owner = NULL;
+	
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
 	inode->i_sock = 1;
 	inode->i_uid = current->fsuid;
@@ -517,6 +519,8 @@
 		return;
 	}
 	sock->file=NULL;
+
+	module_put(sock->owner);
 }
 
 static int __sock_sendmsg(struct kiocb *iocb, struct socket *sock,
struct msghdr *msg, int size)
@@ -964,8 +968,9 @@
 
 int sock_create(int family, int type, int protocol, struct socket
**res)
 {
-	int i;
+	struct net_proto_family *npf;
 	struct socket *sock;
+	int err;
 
 	/*
 	 *	Check protocol is in range
@@ -990,14 +995,8 @@
 	}
 		
 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
-	/* Attempt to load a protocol module if the find failed. 
-	 * 
-	 * 12/09/1996 Marcin: But! this makes REALLY only sense, if the user 
-	 * requested real, full-featured networking support upon
configuration.
-	 * Otherwise module support will break!
-	 */
-	if (net_families[family]==NULL)
-	{
+	/* Attempt to load a protocol module if the find failed. */
+	if (net_families[family]==NULL) {
 		char module_name[30];
 		sprintf(module_name,"net-pf-%d",family);
 		request_module(module_name);
@@ -1005,29 +1004,31 @@
 #endif
 
 	net_family_read_lock();
-	if (net_families[family] == NULL) {
-		i = -EAFNOSUPPORT;
+
+	npf = net_families[family];
+	if (!npf || !try_module_get(npf->owner)) {
+		err = -EAFNOSUPPORT;
 		goto out;
 	}
+	
+	/*
+	 * Allocate the socket and allow the family to set things up. if
+	 * the protocol is 0, the family is instructed to select an
appropriate
+	 * default.
+ 	 */
 
-/*
- *	Allocate the socket and allow the family to set things up. if
- *	the protocol is 0, the family is instructed to select an appropriate
- *	default.
- */
-
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
@@ -1036,7 +1037,7 @@
 
 out:
 	net_family_read_unlock();
-	return i;
+	return err;
 }
 
 asmlinkage long sys_socket(int family, int type, int protocol)
@@ -1201,6 +1202,9 @@
 	newsock->type = sock->type;
 	newsock->ops = sock->ops;
 
+	try_module_get(sock->owner);
+	newsock->owner = sock->owner;
+	
 	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
 	if (err < 0)
 		goto out_release;

-- 
Max Krasnyansky <maxk@qualcomm.com>
Qualcomm

