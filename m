Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUKPWy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUKPWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUKPWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:52:47 -0500
Received: from linares.terra.com.br ([200.154.55.228]:29585 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S261878AbUKPWvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:51:09 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 37d555b9af5a4ccd0a05c0002b9b211f
Date: Tue, 16 Nov 2004 18:55:26 -0200
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davem@davemloft.net
Subject: [PATCH 2/2] - net/socket.c::__sock_create() cleanup.
Message-Id: <20041116185526.1c5cfb97.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 The 'i' variable in net/socket.c::__sock_create() is not
necessary. It's have been used to store error codes but there is
an 'err' variable already.

 The patch bellow removes the extra variable, and makes use
of 'err' istead.

 Agains't 2.6.10-rc2.


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 net/socket.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/net/socket.c a~/net/socket.c
--- a/net/socket.c	2004-08-14 02:36:45.000000000 -0300
+++ a~/net/socket.c	2004-10-30 23:44:34.000000000 -0200
@@ -1073,7 +1073,6 @@ int sock_wake_async(struct socket *sock,
 
 static int __sock_create(int family, int type, int protocol, struct socket **res, int kern)
 {
-	int i;
 	int err;
 	struct socket *sock;
 
@@ -1118,7 +1117,7 @@ static int __sock_create(int family, int
 
 	net_family_read_lock();
 	if (net_families[family] == NULL) {
-		i = -EAFNOSUPPORT;
+		err = -EAFNOSUPPORT;
 		goto out;
 	}
 
@@ -1131,7 +1130,7 @@ static int __sock_create(int family, int
 	if (!(sock = sock_alloc())) 
 	{
 		printk(KERN_WARNING "socket: no more sockets\n");
-		i = -ENFILE;		/* Not exactly a match, but its the
+		err = -ENFILE;		/* Not exactly a match, but its the
 					   closest posix thing */
 		goto out;
 	}
@@ -1142,11 +1141,11 @@ static int __sock_create(int family, int
 	 * We will call the ->create function, that possibly is in a loadable
 	 * module, so we have to bump that loadable module refcnt first.
 	 */
-	i = -EAFNOSUPPORT;
+	err = -EAFNOSUPPORT;
 	if (!try_module_get(net_families[family]->owner))
 		goto out_release;
 
-	if ((i = net_families[family]->create(sock, protocol)) < 0)
+	if ((err = net_families[family]->create(sock, protocol)) < 0)
 		goto out_module_put;
 	/*
 	 * Now to bump the refcnt of the [loadable] module that owns this
@@ -1166,7 +1165,7 @@ static int __sock_create(int family, int
 
 out:
 	net_family_read_unlock();
-	return i;
+	return err;
 out_module_put:
 	module_put(net_families[family]->owner);
 out_release:
