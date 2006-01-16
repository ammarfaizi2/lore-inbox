Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWAPXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWAPXNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWAPXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:13:20 -0500
Received: from [203.2.177.25] ([203.2.177.25]:7981 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1751052AbWAPXNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:13:18 -0500
Subject: [PATCH 2/4 - 2.6.15]net: 32 bit (socket layer) ioctl emulation for
	64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>
Cc: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>,
       acme@ghostprotocols.net, ak@muc.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, pereira.shaun@gmail.com
In-Reply-To: <200601161043.31742.arnd@arndb.de>
References: <1137122079.5589.34.camel@spereira05.tusc.com.au>
	 <1137391160.5588.32.camel@spereira05.tusc.com.au>
	 <20060116.154106.64415709.yoshfuji@linux-ipv6.org>
	 <200601161043.31742.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 10:11:49 +1100
Message-Id: <1137453109.6553.18.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a 32 bit conversion function for SIOCGSTAMP
diff -uprN -X dontdiff linux-2.6.15-vanilla/include/net/compat.h
linux-2.6.15/include/net/compat.h
--- linux-2.6.15-vanilla/include/net/compat.h	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/include/net/compat.h	2006-01-17 09:52:50.000000000
+1100
@@ -23,6 +23,8 @@ struct compat_cmsghdr {
 	compat_int_t	cmsg_type;
 };
 
+extern int compat_sock_get_timestamp(struct sock *, struct timeval
__user *);
+
 #else /* defined(CONFIG_COMPAT) */
 #define compat_msghdr	msghdr		/* to avoid compiler warnings */
 #endif /* defined(CONFIG_COMPAT) */
diff -uprN -X dontdiff linux-2.6.15-vanilla/net/compat.c
linux-2.6.15/net/compat.c
--- linux-2.6.15-vanilla/net/compat.c	2006-01-03 14:21:10.000000000
+1100
+++ linux-2.6.15/net/compat.c	2006-01-17 09:52:50.000000000 +1100
@@ -503,6 +503,23 @@ static int do_get_sock_timeout(int fd, i
 	return err;
 }
 
+int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
*userstamp)
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

