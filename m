Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317689AbSGOXGe>; Mon, 15 Jul 2002 19:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317688AbSGOXGd>; Mon, 15 Jul 2002 19:06:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54257 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317687AbSGOXGb>; Mon, 15 Jul 2002 19:06:31 -0400
Subject: [PATCH] fix memory leak in socket.c
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 16:09:26 -0700
Message-Id: <1026774566.940.496.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a memory leak in sock_fasync :: net/socket.c.

I sent a fix to Linus and it is now in 2.5.

2.4 and 2.4-ac still require the fix... the following patch applies to
2.4.19-rc1 and 2.4.19-rc1-ac5.

	Robert Love

diff -urN linux-2.4.19-sausage/net/socket.c linux/net/socket.c
--- linux-sausage/net/socket.c	Mon Jun 10 15:26:30 2002
+++ linux/net/socket.c	Mon Jun 10 15:37:48 2002
@@ -743,11 +743,13 @@
 			return -ENOMEM;
 	}
 
-
 	sock = socki_lookup(filp->f_dentry->d_inode);
 	
-	if ((sk=sock->sk) == NULL)
+	if ((sk=sock->sk) == NULL) {
+		if (fna)
+			kfree(fna);
 		return -EINVAL;
+	}
 
 	lock_sock(sk);
 



