Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264016AbTCXAZf>; Sun, 23 Mar 2003 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264017AbTCXAZf>; Sun, 23 Mar 2003 19:25:35 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:18606 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264016AbTCXAZa>;
	Sun, 23 Mar 2003 19:25:30 -0500
Date: Mon, 24 Mar 2003 11:36:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
Message-Id: <20030324113626.3267fb08.sfr@canb.auug.org.au>
In-Reply-To: <20030323.010026.18275919.davem@redhat.com>
References: <20030318182935.0aa53710.sfr@canb.auug.org.au>
	<20030317.233337.76754195.davem@redhat.com>
	<20030318223919.4bceb9f5.sfr@canb.auug.org.au>
	<20030323.010026.18275919.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sun, 23 Mar 2003 01:00:26 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
> I'm fine with this, but I just tried to apply it and there were a ton
> of rejects.  Can you rediff this against Linus's current tree and send
> it to me?

The real problem is that Linus has not applied one of my previous
patches.  Included below.  Linus please, please, pleas apply ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-32bit.1/fs/compat.c 2.5.65-32bit.2/fs/compat.c
--- 2.5.65-32bit.1/fs/compat.c	2003-03-18 10:17:19.000000000 +1100
+++ 2.5.65-32bit.2/fs/compat.c	2003-03-12 17:56:59.000000000 +1100
@@ -191,7 +191,7 @@
 	case F_GETLK:
 	case F_SETLK:
 	case F_SETLKW:
-		ret = get_compat_flock(&f, (struct compat_flock *)arg);
+		ret = get_compat_flock(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
 		old_fs = get_fs();
@@ -203,15 +203,14 @@
 			    ((f.l_start + f.l_len) >= COMPAT_OFF_T_MAX))
 				ret = -EOVERFLOW;
 			if (ret == 0)
-				ret = put_compat_flock(&f,
-						(struct compat_flock *)arg);
+				ret = put_compat_flock(&f, compat_ptr(arg));
 		}
 		break;
 
 	case F_GETLK64:
 	case F_SETLK64:
 	case F_SETLKW64:
-		ret = get_compat_flock64(&f, (struct compat_flock64 *)arg);
+		ret = get_compat_flock64(&f, compat_ptr(arg));
 		if (ret != 0)
 			break;
 		old_fs = get_fs();
@@ -226,8 +225,7 @@
 			    ((f.l_start + f.l_len) >= COMPAT_LOFF_T_MAX))
 				ret = -EOVERFLOW;
 			if (ret == 0)
-				ret = put_compat_flock64(&f,
-						(struct compat_flock64 *)arg);
+				ret = put_compat_flock64(&f, compat_ptr(arg));
 		}
 		break;
 
diff -ruN 2.5.65-32bit.1/include/asm-parisc/compat.h 2.5.65-32bit.2/include/asm-parisc/compat.h
--- 2.5.65-32bit.1/include/asm-parisc/compat.h	2003-03-18 10:17:22.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-parisc/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -103,4 +103,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)uptr;
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.65-32bit.1/include/asm-ppc64/compat.h 2.5.65-32bit.2/include/asm-ppc64/compat.h
--- 2.5.65-32bit.1/include/asm-ppc64/compat.h	2003-03-18 10:17:23.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-ppc64/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -98,4 +98,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)uptr;
+}
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.65-32bit.1/include/asm-s390x/compat.h 2.5.65-32bit.2/include/asm-s390x/compat.h
--- 2.5.65-32bit.1/include/asm-s390x/compat.h	2003-03-18 10:17:23.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-s390x/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -101,4 +101,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)(uptr & 0x7fffffffUL);
+}
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN 2.5.65-32bit.1/include/asm-sparc64/compat.h 2.5.65-32bit.2/include/asm-sparc64/compat.h
--- 2.5.65-32bit.1/include/asm-sparc64/compat.h	2003-03-18 10:17:23.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-sparc64/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -100,4 +100,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)uptr;
+}
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.65-32bit.1/include/asm-x86_64/compat.h 2.5.65-32bit.2/include/asm-x86_64/compat.h
--- 2.5.65-32bit.1/include/asm-x86_64/compat.h	2003-03-18 10:17:23.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-x86_64/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -107,4 +107,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffff
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)uptr;
+}
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.65-32bit.1/net/compat.c 2.5.65-32bit.2/net/compat.c
--- 2.5.65-32bit.1/net/compat.c	2003-03-18 10:17:26.000000000 +1100
+++ 2.5.65-32bit.2/net/compat.c	2003-03-12 17:57:00.000000000 +1100
@@ -27,7 +27,6 @@
 #include <asm/uaccess.h>
 #include <net/compat_socket.h>
 
-#define A(__x)		((unsigned long)(__x))
 #define AA(__x)		((unsigned long)(__x))
 
 extern asmlinkage long sys_getsockopt(int fd, int level, int optname,
@@ -49,7 +48,7 @@
 			break;
 		}
 		tot_len += len;
-		kiov->iov_base = (void *)A(buf);
+		kiov->iov_base = compat_ptr(buf);
 		kiov->iov_len = (__kernel_size_t) len;
 		uiov32++;
 		kiov++;
@@ -60,7 +59,7 @@
 
 int msghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct compat_msghdr *umsg)
 {
-	u32 tmp1, tmp2, tmp3;
+	compat_uptr_t tmp1, tmp2, tmp3;
 	int err;
 
 	err = get_user(tmp1, &umsg->msg_name);
@@ -69,9 +68,9 @@
 	if (err)
 		return -EFAULT;
 
-	kmsg->msg_name = (void *)A(tmp1);
-	kmsg->msg_iov = (struct iovec *)A(tmp2);
-	kmsg->msg_control = (void *)A(tmp3);
+	kmsg->msg_name = compat_ptr(tmp1);
+	kmsg->msg_iov = compat_ptr(tmp2);
+	kmsg->msg_control = compat_ptr(tmp3);
 
 	err = get_user(kmsg->msg_namelen, &umsg->msg_namelen);
 	err |= get_user(kmsg->msg_iovlen, &umsg->msg_iovlen);
@@ -451,14 +450,14 @@
 	struct sock_filter *kfilter;
 	unsigned int fsize;
 	mm_segment_t old_fs;
-	__u32 uptr;
+	compat_uptr_t uptr;
 	int ret;
 
 	if (get_user(kfprog.len, &fprog32->len) ||
 	    __get_user(uptr, &fprog32->filter))
 		return -EFAULT;
 
-	kfprog.filter = (struct sock_filter *)A(uptr);
+	kfprog.filter = compat_ptr(uptr);
 	fsize = kfprog.len * sizeof(struct sock_filter);
 
 	kfilter = (struct sock_filter *)kmalloc(fsize, GFP_KERNEL);
@@ -639,36 +638,34 @@
 		ret = sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
-		ret = sys_bind(a0, (struct sockaddr *)A(a1), a[2]);
+		ret = sys_bind(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_CONNECT:
-		ret = sys_connect(a0, (struct sockaddr *)A(a1), a[2]);
+		ret = sys_connect(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_LISTEN:
 		ret = sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
-		ret = sys_accept(a0, (struct sockaddr *)A(a1), (int *)A(a[2]));
+		ret = sys_accept(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_GETSOCKNAME:
-		ret = sys_getsockname(a0, (struct sockaddr *)A(a1),
-				       (int *)A(a[2]));
+		ret = sys_getsockname(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_GETPEERNAME:
-		ret = sys_getpeername(a0, (struct sockaddr *)A(a1),
-				       (int *)A(a[2]));
+		ret = sys_getpeername(a0, compat_ptr(a1), compat_ptr(a[2]));
 		break;
 	case SYS_SOCKETPAIR:
-		ret = sys_socketpair(a0, a1, a[2], (int *)A(a[3]));
+		ret = sys_socketpair(a0, a1, a[2], compat_ptr(a[3]));
 		break;
 	case SYS_SEND:
-		ret = sys_send(a0, (void *)A(a1), a[2], a[3]);
+		ret = sys_send(a0, compat_ptr(a1), a[2], a[3]);
 		break;
 	case SYS_SENDTO:
 		ret = sys_sendto(a0, a1, a[2], a[3], a[4], a[5]);
 		break;
 	case SYS_RECV:
-		ret = sys_recv(a0, (void *)A(a1), a[2], a[3]);
+		ret = sys_recv(a0, compat_ptr(a1), a[2], a[3]);
 		break;
 	case SYS_RECVFROM:
 		ret = sys_recvfrom(a0, a1, a[2], a[3], a[4], a[5]);
@@ -677,20 +674,18 @@
 		ret = sys_shutdown(a0,a1);
 		break;
 	case SYS_SETSOCKOPT:
-		ret = compat_sys_setsockopt(a0, a1, a[2], (char *)A(a[3]),
-				      a[4]);
+		ret = compat_sys_setsockopt(a0, a1, a[2],
+				compat_ptr(a[3]), a[4]);
 		break;
 	case SYS_GETSOCKOPT:
-		ret = compat_sys_getsockopt(a0, a1, a[2], (char *)(u64)a[3],
-					    (int *)(u64)a[4]);
+		ret = compat_sys_getsockopt(a0, a1, a[2],
+				compat_ptr(a[3]), compat_ptr(a[4]));
 		break;
 	case SYS_SENDMSG:
-		ret = compat_sys_sendmsg(a0, (struct compat_msghdr *)A(a1),
-				         a[2]);
+		ret = compat_sys_sendmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	case SYS_RECVMSG:
-		ret = compat_sys_recvmsg(a0, (struct compat_msghdr *)A(a1),
-				         a[2]);
+		ret = compat_sys_recvmsg(a0, compat_ptr(a1), a[2]);
 		break;
 	default:
 		ret = -EINVAL;
