Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVIHBbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVIHBbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbVIHB3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:29:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932854AbVIHB3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:37 -0400
Message-Id: <20050908012904.302688000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Sebastian Krahmer <krahmer@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, viro@ZenIV.linux.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       David Woodhouse <dwmw2@infradead.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 9/9] [PATCH] 32bit sendmsg() flaw (CAN-2005-2490)
Content-Disposition: inline; filename=sendmsg-stackoverflow.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

When we copy 32bit ->msg_control contents to kernel, we walk the same
userland data twice without sanity checks on the second pass.

Second version of this patch: the original broke with 64-bit arches
running 32-bit-compat-mode executables doing sendmsg() syscalls with
unaligned CMSG data areas

Another thing is that we use kmalloc() to allocate and sock_kfree_s()
to free afterwards; less serious, but also needs fixing.

Patch by Al Viro, David Miller, David Woodhouse

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 include/net/compat.h |    2 +-
 net/compat.c         |   44 ++++++++++++++++++++++++++------------------
 net/socket.c         |    3 ++-
 3 files changed, 29 insertions(+), 20 deletions(-)

Index: linux-2.6.13.y/include/net/compat.h
===================================================================
--- linux-2.6.13.y.orig/include/net/compat.h
+++ linux-2.6.13.y/include/net/compat.h
@@ -33,7 +33,7 @@ extern asmlinkage long compat_sys_sendms
 extern asmlinkage long compat_sys_recvmsg(int,struct compat_msghdr __user *,unsigned);
 extern asmlinkage long compat_sys_getsockopt(int, int, int, char __user *, int __user *);
 extern int put_cmsg_compat(struct msghdr*, int, int, int, void *);
-extern int cmsghdr_from_user_compat_to_kern(struct msghdr *, unsigned char *,
+extern int cmsghdr_from_user_compat_to_kern(struct msghdr *, struct sock *, unsigned char *,
 		int);
 
 #endif /* NET_COMPAT_H */
Index: linux-2.6.13.y/net/compat.c
===================================================================
--- linux-2.6.13.y.orig/net/compat.c
+++ linux-2.6.13.y/net/compat.c
@@ -135,13 +135,14 @@ static inline struct compat_cmsghdr __us
  * thus placement) of cmsg headers and length are different for
  * 32-bit apps.  -DaveM
  */
-int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg,
+int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct sock *sk,
 			       unsigned char *stackbuf, int stackbuf_size)
 {
 	struct compat_cmsghdr __user *ucmsg;
 	struct cmsghdr *kcmsg, *kcmsg_base;
 	compat_size_t ucmlen;
 	__kernel_size_t kcmlen, tmp;
+	int err = -EFAULT;
 
 	kcmlen = 0;
 	kcmsg_base = kcmsg = (struct cmsghdr *)stackbuf;
@@ -156,6 +157,7 @@ int cmsghdr_from_user_compat_to_kern(str
 
 		tmp = ((ucmlen - CMSG_COMPAT_ALIGN(sizeof(*ucmsg))) +
 		       CMSG_ALIGN(sizeof(struct cmsghdr)));
+		tmp = CMSG_ALIGN(tmp);
 		kcmlen += tmp;
 		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, ucmlen);
 	}
@@ -167,30 +169,34 @@ int cmsghdr_from_user_compat_to_kern(str
 	 * until we have successfully copied over all of the data
 	 * from the user.
 	 */
-	if(kcmlen > stackbuf_size)
-		kcmsg_base = kcmsg = kmalloc(kcmlen, GFP_KERNEL);
-	if(kcmsg == NULL)
+	if (kcmlen > stackbuf_size)
+		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen, GFP_KERNEL);
+	if (kcmsg == NULL)
 		return -ENOBUFS;
 
 	/* Now copy them over neatly. */
 	memset(kcmsg, 0, kcmlen);
 	ucmsg = CMSG_COMPAT_FIRSTHDR(kmsg);
 	while(ucmsg != NULL) {
-		__get_user(ucmlen, &ucmsg->cmsg_len);
+		if (__get_user(ucmlen, &ucmsg->cmsg_len))
+			goto Efault;
+		if (!CMSG_COMPAT_OK(ucmlen, ucmsg, kmsg))
+			goto Einval;
 		tmp = ((ucmlen - CMSG_COMPAT_ALIGN(sizeof(*ucmsg))) +
 		       CMSG_ALIGN(sizeof(struct cmsghdr)));
+		if ((char *)kcmsg_base + kcmlen - (char *)kcmsg < CMSG_ALIGN(tmp))
+			goto Einval;
 		kcmsg->cmsg_len = tmp;
-		__get_user(kcmsg->cmsg_level, &ucmsg->cmsg_level);
-		__get_user(kcmsg->cmsg_type, &ucmsg->cmsg_type);
-
-		/* Copy over the data. */
-		if(copy_from_user(CMSG_DATA(kcmsg),
-				  CMSG_COMPAT_DATA(ucmsg),
-				  (ucmlen - CMSG_COMPAT_ALIGN(sizeof(*ucmsg)))))
-			goto out_free_efault;
+		tmp = CMSG_ALIGN(tmp);
+		if (__get_user(kcmsg->cmsg_level, &ucmsg->cmsg_level) ||
+		    __get_user(kcmsg->cmsg_type, &ucmsg->cmsg_type) ||
+		    copy_from_user(CMSG_DATA(kcmsg),
+				   CMSG_COMPAT_DATA(ucmsg),
+				   (ucmlen - CMSG_COMPAT_ALIGN(sizeof(*ucmsg)))))
+			goto Efault;
 
 		/* Advance. */
-		kcmsg = (struct cmsghdr *)((char *)kcmsg + CMSG_ALIGN(tmp));
+		kcmsg = (struct cmsghdr *)((char *)kcmsg + tmp);
 		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, ucmlen);
 	}
 
@@ -199,10 +205,12 @@ int cmsghdr_from_user_compat_to_kern(str
 	kmsg->msg_controllen = kcmlen;
 	return 0;
 
-out_free_efault:
-	if(kcmsg_base != (struct cmsghdr *)stackbuf)
-		kfree(kcmsg_base);
-	return -EFAULT;
+Einval:
+	err = -EINVAL;
+Efault:
+	if (kcmsg_base != (struct cmsghdr *)stackbuf)
+		sock_kfree_s(sk, kcmsg_base, kcmlen);
+	return err;
 }
 
 int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *data)
Index: linux-2.6.13.y/net/socket.c
===================================================================
--- linux-2.6.13.y.orig/net/socket.c
+++ linux-2.6.13.y/net/socket.c
@@ -1739,10 +1739,11 @@ asmlinkage long sys_sendmsg(int fd, stru
 		goto out_freeiov;
 	ctl_len = msg_sys.msg_controllen; 
 	if ((MSG_CMSG_COMPAT & flags) && ctl_len) {
-		err = cmsghdr_from_user_compat_to_kern(&msg_sys, ctl, sizeof(ctl));
+		err = cmsghdr_from_user_compat_to_kern(&msg_sys, sock->sk, ctl, sizeof(ctl));
 		if (err)
 			goto out_freeiov;
 		ctl_buf = msg_sys.msg_control;
+		ctl_len = msg_sys.msg_controllen;
 	} else if (ctl_len) {
 		if (ctl_len > sizeof(ctl))
 		{

--
