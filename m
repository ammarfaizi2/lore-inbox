Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWBQFDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBQFDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 00:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBQFDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 00:03:51 -0500
Received: from [203.2.177.25] ([203.2.177.25]:30490 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751360AbWBQFDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 00:03:50 -0500
Subject: [PATCH 2/6]net:socket timestamp 32 bit handler for 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Cc: Andre Hendry <ahendry@tusc.com.au>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 16:01:02 +1100
Message-Id: <1140152462.1475.23.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: spereira@tusc.com.au

Get socket timestamp handler function that does not
use the ioctl32_hash_table.

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/include/net/compat.h linux-2.6.16-rc3/include/net/compat.h
--- linux-2.6.16-rc3-vanilla/include/net/compat.h	2006-02-16 14:57:01.000000000 +1100
+++ linux-2.6.16-rc3/include/net/compat.h	2006-02-16 14:58:58.000000000 +1100
@@ -23,6 +23,8 @@ struct compat_cmsghdr {
 	compat_int_t	cmsg_type;
 };
 
+extern int compat_sock_get_timestamp(struct sock *, struct timeval __user *);
+
 #else /* defined(CONFIG_COMPAT) */
 #define compat_msghdr	msghdr		/* to avoid compiler warnings */
 #endif /* defined(CONFIG_COMPAT) */
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/compat.c linux-2.6.16-rc3/net/compat.c
--- linux-2.6.16-rc3-vanilla/net/compat.c	2006-02-16 14:57:01.000000000 +1100
+++ linux-2.6.16-rc3/net/compat.c	2006-02-16 14:58:58.000000000 +1100
@@ -503,6 +503,23 @@ static int do_get_sock_timeout(int fd, i
 	return err;
 }
 
+int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
+{
+	struct compat_timeval __user *ctv
+		= (struct compat_timeval __user*) userstamp;
+	int err = -ENOENT;
+	if(!sock_flag(sk, SOCK_TIMESTAMP))
+		sock_enable_timestamp(sk);
+	if(sk->sk_stamp.tv_sec == -1)
+		return err;
+	if(sk->sk_stamp.tv_sec == 0)
+		do_gettimeofday(&sk->sk_stamp);
+	if (put_user(sk->sk_stamp.tv_sec, &ctv->tv_sec) |
+			put_user(sk->sk_stamp.tv_usec, &ctv->tv_usec))
+				err = -EFAULT;
+	return err;
+}
+
 asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
@@ -602,3 +619,5 @@ asmlinkage long compat_sys_socketcall(in
 	}
 	return ret;
 }
+
+EXPORT_SYMBOL(compat_sock_get_timestamp);

