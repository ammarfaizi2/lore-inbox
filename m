Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbSJPQrW>; Wed, 16 Oct 2002 12:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265182AbSJPQqJ>; Wed, 16 Oct 2002 12:46:09 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:49819 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265183AbSJPQpp> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (4/6): 31 bit emulation.
Date: Wed, 16 Oct 2002 18:48:12 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161848.12711.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 31 bit emulation of sys_recvmsg, sys_setsockopt and sys_futex.

diff -urN linux-2.5.43/arch/s390x/kernel/linux32.c linux-2.5.43-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.43/arch/s390x/kernel/linux32.c	Wed Oct 16 05:27:19 2002
+++ linux-2.5.43-s390/arch/s390x/kernel/linux32.c	Wed Oct 16 17:54:11 2002
@@ -2497,8 +2497,23 @@
 			  CMSG32_ALIGN(sizeof(struct cmsghdr32)));
 		kcmsg32->cmsg_len = clen32;
 
+		switch (kcmsg32->cmsg_type) {
+			/*
+			 * The timestamp type's data needs to be converted
+			 * from 64-bit time values to 32-bit time values
+			*/
+		case SO_TIMESTAMP: {
+			__kernel_time_t32* ptr_time32 = CMSG32_DATA(kcmsg32);
+			__kernel_time_t*   ptr_time   = CMSG_DATA(ucmsg);
+			get_user(*ptr_time32, ptr_time);
+			get_user(*(ptr_time32+1), ptr_time+1);
+			kcmsg32->cmsg_len -= 2*(sizeof(__kernel_time_t) -
+						sizeof(__kernel_time_t32));
+		}
+		default:;
+		}
 		ucmsg = (struct cmsghdr *) (((char *)ucmsg) + CMSG_ALIGN(clen64));
-		wp = (((char *)kcmsg32) + CMSG32_ALIGN(clen32));
+		wp = (((char *)kcmsg32) + CMSG32_ALIGN(kcmsg32->cmsg_len));
 	}
 
 	/* Copy back fixed up data, and adjust pointers. */
@@ -2613,6 +2628,9 @@
 
 		err = sock->ops->recvmsg(&iocb, sock, &kern_msg, total_len,
 					 user_flags, si->scm);
+		if (err >= 0)
+			scm_recv32(sock, msg, &iocb, flags, cmsg_ptr);
+
 		if (-EIOCBQUEUED == err)
 			err = wait_on_sync_kiocb(&iocb);
 
@@ -2645,7 +2663,7 @@
 		sockfd_put(sock);
 	}
 
-	if(uaddr != NULL && err >= 0)
+	if(uaddr != NULL && err >= 0 && kern_msg.msg_namelen)
 		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
 	if(cmsg_ptr != 0 && err >= 0) {
 		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
@@ -2747,6 +2765,32 @@
 	return err;
 }
 
+static __inline__ void
+scm_recv32(struct socket *sock, struct msghdr *msg,
+	   struct sock_iocb *si, int flags, unsigned long cmsg_ptr)
+{
+	if(!msg->msg_control) {
+		if(sock->passcred || si->scm->fp)
+			msg->msg_flags |= MSG_CTRUNC;
+		if(si->scm->fp)
+			__scm_destroy(si->scm);
+	} else {
+		/* If recvmsg processing itself placed some
+		 * control messages into user space, it's is
+		 * using 64-bit CMSG processing, so we need
+		 * to fix it up before we tack on more stuff.
+		 */
+		if((unsigned long) msg->msg_control != cmsg_ptr)
+			cmsg32_recvmsg_fixup(msg, cmsg_ptr);
+		/* Wheee... */
+		if(sock->passcred)
+			put_cmsg32(msg,	SOL_SOCKET, SCM_CREDENTIALS,
+				sizeof(si->scm->creds), &si->scm->creds);
+		if(si->scm->fp != NULL)
+			scm_detach_fds32(msg, si->scm);
+	}
+}
+
 /*
  *	BSD recvmsg interface
  */
@@ -2820,6 +2864,9 @@
 
 	err = sock->ops->recvmsg(&iocb, sock, &msg_sys, total_len,
 				 flags, si->scm);
+	if (err >= 0)
+		scm_recv32(sock, msg, &iocb, flags, cmsg_ptr);
+
 	if (-EIOCBQUEUED == err)
 		err = wait_on_sync_kiocb(&iocb);
 	if (err < 0)
@@ -2833,27 +2880,13 @@
 		if (err < 0)
 			goto out_freeiov;
 	}
-	if(!msg_sys.msg_control) {
-		if(sock->passcred || si->scm->fp)
-			msg_sys.msg_flags |= MSG_CTRUNC;
-		if(si->scm->fp)
-			__scm_destroy(si->scm);
-	} else {
-		/* If recvmsg processing itself placed some
-		 * control messages into user space, it's is
-		 * using 64-bit CMSG processing, so we need
-		 * to fix it up before we tack on more stuff.
-		 */
-		if((unsigned long) msg_sys.msg_control != cmsg_ptr)
-			cmsg32_recvmsg_fixup(&msg_sys, cmsg_ptr);
-		/* Wheee... */
-		if(sock->passcred)
-			put_cmsg32(&msg_sys,
-				SOL_SOCKET, SCM_CREDENTIALS,
-				sizeof(si->scm->creds), &si->scm->creds);
-		if(si->scm->fp != NULL)
-			scm_detach_fds32(&msg_sys, si->scm);
-	}
+	err = __put_user(msg_sys.msg_flags, &msg->msg_flags);
+	if (err)
+		goto out_freeiov;
+	err = __put_user((__kernel_size_t32) ((unsigned long)msg_sys.msg_control - cmsg_ptr), &msg->msg_controllen);
+	if (err)
+		goto out_freeiov;
+	err = len;
 
 out_freeiov:
 	if (iov != iovstack)
@@ -2946,6 +2979,20 @@
 	if (level == SOL_ICMPV6 && optname == ICMPV6_FILTER)
 		return do_set_icmpv6_filter(fd, level, optname,
 					    optval, optlen);
+	if (level == SOL_SOCKET && 
+	    (optname == SO_SNDTIMEO || optname == SO_RCVTIMEO)) {
+		long ret;
+		struct timeval tmp;
+		mm_segment_t old_fs;
+
+		if (get_tv32(&tmp, (struct timeval32 *)optval ))
+			return -EFAULT;
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		ret = sys_setsockopt(fd, level, optname, (char *) &tmp, sizeof(struct timeval));
+		set_fs(old_fs);
+		return ret; 
+	}
 
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
@@ -4556,26 +4603,19 @@
 sys32_futex(void *uaddr, int op, int val, 
 		 struct timespec32 *timeout32)
 {
-	long ret;
-	struct timespec tmp, *timeout;
-
-	ret = -ENOMEM;
-	timeout = kmalloc(sizeof(*timeout), GFP_USER);
-	if (!timeout)
-		goto out;
+	struct timespec tmp;
+	mm_segment_t old_fs;
+	int ret;
 
-	ret = -EINVAL;
 	if (get_user (tmp.tv_sec,  &timeout32->tv_sec)  ||
-	    get_user (tmp.tv_nsec, &timeout32->tv_nsec) ||
-	    put_user (tmp.tv_sec,  &timeout->tv_sec)    ||
-	    put_user (tmp.tv_nsec, &timeout->tv_nsec))
-		goto out_free;
+	    get_user (tmp.tv_nsec, &timeout32->tv_nsec))
+		return -EINVAL;
 
-	ret = sys_futex(uaddr, op, val, timeout);
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_futex(uaddr, op, val, &tmp);
+	set_fs(old_fs);
 
-out_free:
-	kfree(timeout);
-out:
 	return ret;
 }
 

