Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbTCaIFj>; Mon, 31 Mar 2003 03:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbTCaIFj>; Mon, 31 Mar 2003 03:05:39 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:40114 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261443AbTCaIFg>;
	Mon, 31 Mar 2003 03:05:36 -0500
Date: Mon, 31 Mar 2003 18:16:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       Randolph Chung <randolph@tausq.org>, Benjamin LaHaise <bcrl@redhat.com>
Subject: [PATCH][COMPAT] another net/compat fix -- for recvmsg
Message-Id: <20030331181644.29a2bfc6.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Ben,

>From Randolph Chung, I got the following:

"Here's another patch for the net/compat stuff... this touches two files:

Some parts of the socket code looks for the CMSG_COMPAT flag in the
msg->msg_flag instead of in the flag passed in to the recvmsg call (e.g.
send_scm), so the net/socket.c code needs to set msg->msg_flags as well

The second part removes the recvmsg_fixup function from net/compat.c,
because it is no longer correct. Previously the fixup function assumed 
the network code will put things into userspace in 64-bit and then the 
fixup code changes it to 32-bit. but now the individual put_cmsg calls 
should be CMSG_COMPAT aware and dtrt, so the fixup routine will not work
correctly."

The first I am pretty sure is correct (and pretty trivial). The second I
am also pretty sure about, but not 100%.  Could you please have a look and
see what you think.  If its OK, the please apply.

I have modified Randolf's patch a little to complete remove
put_compat_msg_controllen as it just degenerates.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66-033114/include/net/compat.h 2.5.66-033114-netfix.1/include/net/compat.h
--- 2.5.66-033114/include/net/compat.h	2003-03-25 12:08:26.000000000 +1100
+++ 2.5.66-033114-netfix.1/include/net/compat.h	2003-03-31 18:12:37.000000000 +1000
@@ -33,8 +33,6 @@
 extern asmlinkage long compat_sys_recvmsg(int,struct compat_msghdr *,unsigned);
 extern asmlinkage long compat_sys_getsockopt(int, int, int, char *, int *);
 extern int put_cmsg_compat(struct msghdr*, int, int, int, void *);
-extern int put_compat_msg_controllen(struct msghdr *, struct compat_msghdr *,
-		unsigned long);
 extern int cmsghdr_from_user_compat_to_kern(struct msghdr *, unsigned char *,
 		int);
 
diff -ruN 2.5.66-033114/net/compat.c 2.5.66-033114-netfix.1/net/compat.c
--- 2.5.66-033114/net/compat.c	2003-03-25 12:08:29.000000000 +1100
+++ 2.5.66-033114-netfix.1/net/compat.c	2003-03-31 18:03:32.000000000 +1000
@@ -296,108 +296,6 @@
 	__scm_destroy(scm);
 }
 
-/* In these cases we (currently) can just copy to data over verbatim
- * because all CMSGs created by the kernel have well defined types which
- * have the same layout in both the 32-bit and 64-bit API.  One must add
- * some special cased conversions here if we start sending control messages
- * with incompatible types.
- *
- * SCM_RIGHTS and SCM_CREDENTIALS are done by hand in recvmsg_compat right after
- * we do our work.  The remaining cases are:
- *
- * SOL_IP	IP_PKTINFO	struct in_pktinfo	32-bit clean
- *		IP_TTL		int			32-bit clean
- *		IP_TOS		__u8			32-bit clean
- *		IP_RECVOPTS	variable length		32-bit clean
- *		IP_RETOPTS	variable length		32-bit clean
- *		(these last two are clean because the types are defined
- *		 by the IPv4 protocol)
- *		IP_RECVERR	struct sock_extended_err +
- *				struct sockaddr_in	32-bit clean
- * SOL_IPV6	IPV6_RECVERR	struct sock_extended_err +
- *				struct sockaddr_in6	32-bit clean
- *		IPV6_PKTINFO	struct in6_pktinfo	32-bit clean
- *		IPV6_HOPLIMIT	int			32-bit clean
- *		IPV6_FLOWINFO	u32			32-bit clean
- *		IPV6_HOPOPTS	ipv6 hop exthdr		32-bit clean
- *		IPV6_DSTOPTS	ipv6 dst exthdr(s)	32-bit clean
- *		IPV6_RTHDR	ipv6 routing exthdr	32-bit clean
- *		IPV6_AUTHHDR	ipv6 auth exthdr	32-bit clean
- */
-static void cmsg_compat_recvmsg_fixup(struct msghdr *kmsg, unsigned long orig_cmsg_uptr)
-{
-	unsigned char *workbuf, *wp;
-	unsigned long bufsz, space_avail;
-	struct cmsghdr *ucmsg;
-
-	bufsz = ((unsigned long)kmsg->msg_control) - orig_cmsg_uptr;
-	space_avail = kmsg->msg_controllen + bufsz;
-	wp = workbuf = kmalloc(bufsz, GFP_KERNEL);
-	if(workbuf == NULL)
-		goto fail;
-
-	/* To make this more sane we assume the kernel sends back properly
-	 * formatted control messages.  Because of how the kernel will truncate
-	 * the cmsg_len for MSG_TRUNC cases, we need not check that case either.
-	 */
-	ucmsg = (struct cmsghdr *) orig_cmsg_uptr;
-	while(((unsigned long)ucmsg) <=
-	      (((unsigned long)kmsg->msg_control) - sizeof(struct cmsghdr))) {
-		struct compat_cmsghdr *kcmsg_compat = (struct compat_cmsghdr *) wp;
-		int clen64, clen32;
-
-		/* UCMSG is the 64-bit format CMSG entry in user-space.
-		 * KCMSG_COMPAT is within the kernel space temporary buffer
-		 * we use to convert into a 32-bit style CMSG.
-		 */
-		__get_user(kcmsg_compat->cmsg_len, &ucmsg->cmsg_len);
-		__get_user(kcmsg_compat->cmsg_level, &ucmsg->cmsg_level);
-		__get_user(kcmsg_compat->cmsg_type, &ucmsg->cmsg_type);
-
-		clen64 = kcmsg_compat->cmsg_len;
-		copy_from_user(CMSG_COMPAT_DATA(kcmsg_compat), CMSG_DATA(ucmsg),
-			       clen64 - CMSG_ALIGN(sizeof(*ucmsg)));
-		clen32 = ((clen64 - CMSG_ALIGN(sizeof(*ucmsg))) +
-			  CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr)));
-		kcmsg_compat->cmsg_len = clen32;
-
-		ucmsg = (struct cmsghdr *) (((char *)ucmsg) + CMSG_ALIGN(clen64));
-		wp = (((char *)kcmsg_compat) + CMSG_COMPAT_ALIGN(clen32));
-	}
-
-	/* Copy back fixed up data, and adjust pointers. */
-	bufsz = (wp - workbuf);
-	copy_to_user((void *)orig_cmsg_uptr, workbuf, bufsz);
-
-	kmsg->msg_control = (struct cmsghdr *)
-		(((char *)orig_cmsg_uptr) + bufsz);
-	kmsg->msg_controllen = space_avail - bufsz;
-
-	kfree(workbuf);
-	return;
-
-fail:
-	/* If we leave the 64-bit format CMSG chunks in there,
-	 * the application could get confused and crash.  So to
-	 * ensure greater recovery, we report no CMSGs.
-	 */
-	kmsg->msg_controllen += bufsz;
-	kmsg->msg_control = (void *) orig_cmsg_uptr;
-}
-
-int put_compat_msg_controllen(struct msghdr *msg_sys,
-		struct compat_msghdr *msg_compat, unsigned long cmsg_ptr)
-{
-	unsigned long ucmsg_ptr;
-	compat_size_t uclen;
-
-	if ((unsigned long)msg_sys->msg_control != cmsg_ptr)
-		cmsg_compat_recvmsg_fixup(msg_sys, cmsg_ptr);
-	ucmsg_ptr = ((unsigned long)msg_sys->msg_control);
-	uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
-	return __put_user(uclen, &msg_compat->msg_controllen);
-}
-
 extern asmlinkage long sys_setsockopt(int fd, int level, int optname,
 				     char *optval, int optlen);
 
diff -ruN 2.5.66-033114/net/socket.c 2.5.66-033114-netfix.1/net/socket.c
--- 2.5.66-033114/net/socket.c	2003-03-31 15:46:36.000000000 +1000
+++ 2.5.66-033114-netfix.1/net/socket.c	2003-03-31 18:03:30.000000000 +1000
@@ -1692,6 +1692,8 @@
 
 	cmsg_ptr = (unsigned long)msg_sys.msg_control;
 	msg_sys.msg_flags = 0;
+	if (MSG_CMSG_COMPAT & flags)
+		msg_sys.msg_flags = MSG_CMSG_COMPAT;
 	
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
@@ -1709,7 +1711,8 @@
 	if (err)
 		goto out_freeiov;
 	if (MSG_CMSG_COMPAT & flags)
-		err = put_compat_msg_controllen(&msg_sys, msg_compat, cmsg_ptr);
+		err = __put_user((unsigned long)msg_sys.msg_control-cmsg_ptr, 
+				 &msg_compat->msg_controllen);
 	else
 		err = __put_user((unsigned long)msg_sys.msg_control-cmsg_ptr, 
 				 &msg->msg_controllen);
