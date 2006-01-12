Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWALGCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWALGCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWALGCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:02:49 -0500
Received: from [203.2.177.25] ([203.2.177.25]:315 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1030301AbWALGCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:02:49 -0500
Subject: [PATCH 2/4 - 2.6.15]net: 32 bit (socket layer) ioctl emulation for
	64 bit kernels
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: Arnd Bergmann <arnd@arndb.de>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Andi Kleen <ak@muc.de>, linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>,
       "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>
Cc: SP <pereira.shaun@gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 17:02:12 +1100
Message-Id: <1137045732.5221.21.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second part of this series. 

This routine is needed by the x25 module (32-64 bit patch), as
recommended it has been added to compat.c

diff -uprN -X dontdiff linux-2.6.15-vanilla/include/net/compat.h
linux-2.6.15/include/net/compat.h
--- linux-2.6.15-vanilla/include/net/compat.h	2006-01-03
14:21:10.000000000 +1100
+++ linux-2.6.15/include/net/compat.h	2006-01-12 16:01:09.000000000
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
+++ linux-2.6.15/net/compat.c	2006-01-12 16:01:09.000000000 +1100
@@ -503,6 +503,20 @@ static int do_get_sock_timeout(int fd, i
 	return err;
 }
 
+int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
*userstamp)
+{
+	struct compat_timeval __user *ctv;
+	ctv = (struct compat_timeval __user*) userstamp;
+	if(!sock_flag(sk, SOCK_TIMESTAMP))
+		sock_enable_timestamp(sk);
+	if(sk->sk_stamp.tv_sec == -1)
+		return -ENOENT;
+	if(sk->sk_stamp.tv_sec == 0)
+		do_gettimeofday(&sk->sk_stamp);
+	return copy_to_user(ctv, &sk->sk_stamp, sizeof(struct
compat_timeval)) ?
+			-EFAULT : 0;
+}
+
 asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
@@ -602,3 +616,5 @@ asmlinkage long compat_sys_socketcall(in
 	}
 	return ret;
 }
+
+EXPORT_SYMBOL(compat_sock_get_timestamp);





