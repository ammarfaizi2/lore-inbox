Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSKRT3x>; Mon, 18 Nov 2002 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSKRT3T>; Mon, 18 Nov 2002 14:29:19 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:40106 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264755AbSKRTYy> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (12/16): 31bit emulation.
Date: Mon, 18 Nov 2002 20:22:08 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182022.08264.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fixes for the 31 bit emulation layer. New interface
[un]register_ioctl32_conversion.

diff -urN linux-2.5.48/arch/s390x/kernel/ioctl32.c linux-2.5.48-s390/arch/s390x/kernel/ioctl32.c
--- linux-2.5.48/arch/s390x/kernel/ioctl32.c	Mon Nov 18 05:29:56 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/ioctl32.c	Mon Nov 18 20:11:57 2002
@@ -1024,6 +1024,8 @@
 static void ioctl32_insert(struct ioctl32_list *entry)
 {
 	int hash = ioctl32_hash(entry->handler.cmd);
+
+	entry->next = 0;
 	if (!ioctl32_hash_table[hash])
 		ioctl32_hash_table[hash] = entry;
 	else {
@@ -1032,10 +1034,51 @@
 		while (l->next)
 			l = l->next;
 		l->next = entry;
-		entry->next = 0;
 	}
 }
 
+int register_ioctl32_conversion(unsigned int cmd,
+				int (*handler)(unsigned int, unsigned int,
+					       unsigned long, struct file *))
+{
+	struct ioctl32_list *l, *new;
+	int hash;
+
+	hash = ioctl32_hash(cmd);
+	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next)
+		if (l->handler.cmd == cmd)
+			return -EBUSY;
+	new = kmalloc(sizeof(struct ioctl32_list), GFP_KERNEL);
+	if (new == NULL)
+		return -ENOMEM;
+	new->handler.cmd = cmd;
+	new->handler.function = (void *) handler;
+	ioctl32_insert(new);
+	return 0;
+}
+
+int unregister_ioctl32_conversion(unsigned int cmd)
+{
+	struct ioctl32_list *p, *l;
+	int hash;
+
+	hash = ioctl32_hash(cmd);
+	p = NULL;
+	for (l = ioctl32_hash_table[hash]; l != NULL; l = l->next) {
+		if (l->handler.cmd == cmd)
+			break;
+		p = l;
+	}
+	if (l == NULL)
+		return -ENOENT;
+	if (p == NULL)
+		ioctl32_hash_table[hash] = l->next;
+	else
+		p->next = l->next;
+	kfree(l);
+	return 0;
+}
+
 static int __init init_ioctl32(void)
 {
 	int i;
diff -urN linux-2.5.48/arch/s390x/kernel/linux32.c linux-2.5.48-s390/arch/s390x/kernel/linux32.c
--- linux-2.5.48/arch/s390x/kernel/linux32.c	Mon Nov 18 20:11:29 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/linux32.c	Mon Nov 18 20:11:57 2002
@@ -2492,8 +2492,23 @@
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
@@ -2516,148 +2531,6 @@
 	kmsg->msg_control = (void *) orig_cmsg_uptr;
 }
 
-#if 0
-asmlinkage int sys32_sendmsg(int fd, struct msghdr32 *user_msg, unsigned user_flags)
-{
-	struct socket *sock;
-	char address[MAX_SOCK_ADDR];
-	struct iovec iov[UIO_FASTIOV];
-	unsigned char ctl[sizeof(struct cmsghdr) + 20];
-	unsigned char *ctl_buf = ctl;
-	struct msghdr kern_msg;
-	int err, total_len;
-
-	if(msghdr_from_user32_to_kern(&kern_msg, user_msg))
-		return -EFAULT;
-	if(kern_msg.msg_iovlen > UIO_MAXIOV)
-		return -EINVAL;
-	err = verify_iovec32(&kern_msg, iov, address, VERIFY_READ);
-	if (err < 0)
-		goto out;
-	total_len = err;
-
-	if(kern_msg.msg_controllen) {
-		err = cmsghdr_from_user32_to_kern(&kern_msg, ctl, sizeof(ctl));
-		if(err)
-			goto out_freeiov;
-		ctl_buf = kern_msg.msg_control;
-	}
-	kern_msg.msg_flags = user_flags;
-
-	sock = sockfd_lookup(fd, &err);
-	if (sock != NULL) {
-		if (sock->file->f_flags & O_NONBLOCK)
-			kern_msg.msg_flags |= MSG_DONTWAIT;
-		err = sock_sendmsg(sock, &kern_msg, total_len);
-		sockfd_put(sock);
-	}
-
-	/* N.B. Use kfree here, as kern_msg.msg_controllen might change? */
-	if(ctl_buf != ctl)
-		kfree(ctl_buf);
-out_freeiov:
-	if(kern_msg.msg_iov != iov)
-		kfree(kern_msg.msg_iov);
-out:
-	return err;
-}
-
-asmlinkage int sys32_recvmsg(int fd, struct msghdr32 *user_msg, unsigned int user_flags)
-{
-	struct iovec iovstack[UIO_FASTIOV];
-	struct msghdr kern_msg;
-	char addr[MAX_SOCK_ADDR];
-	struct socket *sock;
-	struct iovec *iov = iovstack;
-	struct sockaddr *uaddr;
-	int *uaddr_len;
-	unsigned long cmsg_ptr;
-	int err, total_len, len = 0;
-
-	if(msghdr_from_user32_to_kern(&kern_msg, user_msg))
-		return -EFAULT;
-	if(kern_msg.msg_iovlen > UIO_MAXIOV)
-		return -EINVAL;
-
-	uaddr = kern_msg.msg_name;
-	uaddr_len = &user_msg->msg_namelen;
-	err = verify_iovec32(&kern_msg, iov, addr, VERIFY_WRITE);
-	if (err < 0)
-		goto out;
-	total_len = err;
-
-	cmsg_ptr = (unsigned long) kern_msg.msg_control;
-	kern_msg.msg_flags = 0;
-
-	sock = sockfd_lookup(fd, &err);
-	if (sock != NULL) {
-		struct sock_iocb *si;
-		struct kiocb iocb;
-
-		if (sock->file->f_flags & O_NONBLOCK)
-			user_flags |= MSG_DONTWAIT;
-
-		init_sync_kiocb(&iocb, NULL);
-		si = kiocb_to_siocb(&iocb);
-		si->sock = sock;
-		si->scm = &si->async_scm;
-		si->msg = &kern_msg;
-		si->size = total_len;
-		si->flags = user_flags;
-		memset(si->scm, 0, sizeof(*si->scm));
-
-		err = sock->ops->recvmsg(&iocb, sock, &kern_msg, total_len,
-					 user_flags, si->scm);
-		if (-EIOCBQUEUED == err)
-			err = wait_on_sync_kiocb(&iocb);
-
-		if(err >= 0) {
-			len = err;
-			if(!kern_msg.msg_control) {
-				if(sock->passcred || si->scm->fp)
-					kern_msg.msg_flags |= MSG_CTRUNC;
-				if(si->scm->fp)
-					__scm_destroy(si->scm);
-			} else {
-				/* If recvmsg processing itself placed some
-				 * control messages into user space, it's is
-				 * using 64-bit CMSG processing, so we need
-				 * to fix it up before we tack on more stuff.
-				 */
-				if((unsigned long) kern_msg.msg_control != cmsg_ptr)
-					cmsg32_recvmsg_fixup(&kern_msg, cmsg_ptr);
-
-				/* Wheee... */
-				if(sock->passcred)
-					put_cmsg32(&kern_msg,
-						   SOL_SOCKET, SCM_CREDENTIALS,
-						   sizeof(si->scm->creds),
-						   &si->scm->creds);
-				if(si->scm->fp != NULL)
-					scm_detach_fds32(&kern_msg, si->scm);
-			}
-		}
-		sockfd_put(sock);
-	}
-
-	if(uaddr != NULL && err >= 0)
-		err = move_addr_to_user(addr, kern_msg.msg_namelen, uaddr, uaddr_len);
-	if(cmsg_ptr != 0 && err >= 0) {
-		unsigned long ucmsg_ptr = ((unsigned long)kern_msg.msg_control);
-		__kernel_size_t32 uclen = (__kernel_size_t32) (ucmsg_ptr - cmsg_ptr);
-		err |= __put_user(uclen, &user_msg->msg_controllen);
-	}
-	if(err >= 0)
-		err = __put_user(kern_msg.msg_flags, &user_msg->msg_flags);
-	if(kern_msg.msg_iov != iov)
-		kfree(kern_msg.msg_iov);
-out:
-	if(err < 0)
-		return err;
-	return len;
-}
-#endif
-
 /*
  *	BSD sendmsg interface
  */
@@ -2742,6 +2615,63 @@
 	return err;
 }
 
+static __inline__ void
+scm_recv32(struct socket *sock, struct msghdr *msg,
+		struct scm_cookie *scm, int flags, unsigned long cmsg_ptr)
+{
+	if(!msg->msg_control)
+	{
+		if(sock->passcred || scm->fp)
+			msg->msg_flags |= MSG_CTRUNC;
+		scm_destroy(scm);
+		return;
+	}
+	/* If recvmsg processing itself placed some
+	 * control messages into user space, it's is
+	 * using 64-bit CMSG processing, so we need
+	 * to fix it up before we tack on more stuff.
+	 */
+	if((unsigned long) msg->msg_control != cmsg_ptr)
+		cmsg32_recvmsg_fixup(msg, cmsg_ptr);
+	/* Wheee... */
+	if(sock->passcred)
+		put_cmsg32(msg,
+			SOL_SOCKET, SCM_CREDENTIALS,
+			sizeof(scm->creds), &scm->creds);
+	if(!scm->fp)
+		return;
+
+	scm_detach_fds32(msg, scm);
+}
+
+static int  
+sock_recvmsg32(struct socket *sock, struct msghdr *msg, int size, int flags,
+               unsigned long cmsg_ptr)
+{
+	struct sock_iocb *si;
+	struct kiocb iocb;
+
+	init_sync_kiocb(&iocb, NULL);
+
+	si = kiocb_to_siocb(&iocb);
+	si->sock = sock;
+	si->scm = &si->async_scm;
+	si->msg = msg;
+	si->size = size;
+	si->flags = flags;
+
+	memset(si->scm, 0, sizeof(*si->scm));
+
+	size = sock->ops->recvmsg(&iocb, sock, msg, size, flags, si->scm);
+	if (size >= 0)
+		scm_recv32(sock, msg, si->scm, flags, cmsg_ptr);
+
+	if (-EIOCBQUEUED == size)
+		size = wait_on_sync_kiocb(&iocb);
+
+	return size;
+}
+
 /*
  *	BSD recvmsg interface
  */
@@ -2755,8 +2685,6 @@
 	struct msghdr msg_sys;
 	unsigned long cmsg_ptr;
 	int err, iov_size, total_len, len;
-	struct sock_iocb *si;
-	struct kiocb iocb;
 
 	/* kernel mode address */
 	char addr[MAX_SOCK_ADDR];
@@ -2803,20 +2731,7 @@
 	
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
-
-	init_sync_kiocb(&iocb, NULL);
-	si = kiocb_to_siocb(&iocb);
-	si->sock = sock;
-	si->scm = &si->async_scm;
-	si->msg = &msg_sys;
-	si->size = total_len;
-	si->flags = flags;
-	memset(si->scm, 0, sizeof(*si->scm));
-
-	err = sock->ops->recvmsg(&iocb, sock, &msg_sys, total_len,
-				 flags, si->scm);
-	if (-EIOCBQUEUED == err)
-		err = wait_on_sync_kiocb(&iocb);
+	err = sock_recvmsg32(sock, &msg_sys, total_len, flags, cmsg_ptr);
 	if (err < 0)
 		goto out_freeiov;
 	len = err;
@@ -2828,27 +2743,13 @@
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
@@ -2941,6 +2842,20 @@
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
@@ -3897,12 +3812,16 @@
 asmlinkage ssize_t32 sys32_pread64(unsigned int fd, char *ubuf,
 				 __kernel_size_t32 count, u32 poshi, u32 poslo)
 {
+	if ((ssize_t32) count < 0)
+		return -EINVAL;
 	return sys_pread64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
 asmlinkage ssize_t32 sys32_pwrite64(unsigned int fd, char *ubuf,
 				  __kernel_size_t32 count, u32 poshi, u32 poslo)
 {
+	if ((ssize_t32) count < 0)
+		return -EINVAL;
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)AA(poshi) << 32) | AA(poslo));
 }
 
@@ -4436,26 +4355,38 @@
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
 
+asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
+
+asmlinkage ssize_t32 sys32_read(unsigned int fd, char * buf, size_t count)
+{
+	if ((ssize_t32) count < 0)
+		return -EINVAL; 
+
+	return sys_read(fd, buf, count);
+}
+
+asmlinkage ssize_t sys_write(unsigned int fd, const char * buf, size_t count);
+
+asmlinkage ssize_t32 sys32_write(unsigned int fd, char * buf, size_t count)
+{
+	if ((ssize_t32) count < 0)
+		return -EINVAL; 
+
+	return sys_write(fd, buf, count);
+}
diff -urN linux-2.5.48/arch/s390x/kernel/s390_ksyms.c linux-2.5.48-s390/arch/s390x/kernel/s390_ksyms.c
--- linux-2.5.48/arch/s390x/kernel/s390_ksyms.c	Mon Nov 18 05:29:52 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/s390_ksyms.c	Mon Nov 18 20:11:57 2002
@@ -60,6 +60,20 @@
 EXPORT_SYMBOL(overflowuid);
 EXPORT_SYMBOL(overflowgid);
 
+#ifdef CONFIG_S390_SUPPORT
+/*
+ * Dynamically add/remove 31 bit ioctl conversion functions.
+ */
+extern int register_ioctl32_conversion(unsigned int cmd,
+				       int (*handler)(unsigned int, 
+						      unsigned int,
+						      unsigned long,
+						      struct file *));
+int unregister_ioctl32_conversion(unsigned int cmd);
+EXPORT_SYMBOL(register_ioctl32_conversion);
+EXPORT_SYMBOL(unregister_ioctl32_conversion);
+#endif
+
 /*
  * misc.
  */
diff -urN linux-2.5.48/arch/s390x/kernel/wrapper32.S linux-2.5.48-s390/arch/s390x/kernel/wrapper32.S
--- linux-2.5.48/arch/s390x/kernel/wrapper32.S	Mon Nov 18 20:11:29 2002
+++ linux-2.5.48-s390/arch/s390x/kernel/wrapper32.S	Mon Nov 18 20:11:57 2002
@@ -17,14 +17,14 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys_read		# branch to sys_read
+	jg	sys32_read		# branch to sys_read
 
 	.globl  sys32_write_wrapper 
 sys32_write_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
 	llgfr	%r4,%r4			# size_t
-	jg	sys_write		# branch to system call
+	jg	sys32_write		# branch to system call
 
 	.globl  sys32_open_wrapper 
 sys32_open_wrapper:

