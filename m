Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSGGQNT>; Sun, 7 Jul 2002 12:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSGGQNS>; Sun, 7 Jul 2002 12:13:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316089AbSGGQNR>;
	Sun, 7 Jul 2002 12:13:17 -0400
Date: Sun, 7 Jul 2002 17:15:55 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] simplify networking fcntl
Message-ID: <20020707171555.L27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sockets haven't had their own special ioctls since before linux 2.0.29.
sock_no_fcntl is only called for F_SETOWN, so it can stand some
simplification.

diff -urNX dontdiff linux-2.5.24/fs/fcntl.c linux-2.5.24-mm/fs/fcntl.c
--- linux-2.5.24/fs/fcntl.c	Sun Jun  9 06:09:49 2002
+++ linux-2.5.24-mm/fs/fcntl.c	Tue Jul  2 10:55:29 2002
@@ -347,10 +345,6 @@
 			err = fcntl_dirnotify(fd, filp, arg);
 			break;
 		default:
-			/* sockets need a few special fcntls. */
-			err = -EINVAL;
-			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
-				err = sock_fcntl (filp, cmd, arg);
 			break;
 	}
 
diff -urNX dontdiff linux-2.5.24/net/core/sock.c linux-2.5.24-mm/net/core/sock.c
--- linux-2.5.24/net/core/sock.c	Sun Jun  2 18:44:52 2002
+++ linux-2.5.24-mm/net/core/sock.c	Tue Jul  2 10:37:58 2002
@@ -1048,32 +1048,17 @@
 	return -EOPNOTSUPP;
 }
 
-/* 
- * Note: if you add something that sleeps here then change sock_fcntl()
- *       to do proper fd locking.
- */
 int sock_no_fcntl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
-	struct sock *sk = sock->sk;
-
-	switch(cmd)
-	{
-		case F_SETOWN:
-			/*
-			 * This is a little restrictive, but it's the only
-			 * way to make sure that you can't send a sigurg to
-			 * another process.
-			 */
-			if (current->pgrp != -arg &&
-				current->pid != arg &&
-				!capable(CAP_KILL)) return(-EPERM);
-			sk->proc = arg;
-			return(0);
-		case F_GETOWN:
-			return(sk->proc);
-		default:
-			return(-EINVAL);
-	}
+	/*
+	 * TCP doesn't use the standard fasync method to deliver
+	 * SIGURG and SIGIO, so we check permissions at setup time.
+	 * This should be fixed.
+	 */
+	if (current->pgrp != -arg && current->pid != arg && !capable(CAP_KILL))
+		return -EPERM;
+	sock->sk->proc = arg;
+	return 0;
 }
 
 int sock_no_sendmsg(struct socket *sock, struct msghdr *m, int flags,

-- 
Revolutions do not require corporate support.
