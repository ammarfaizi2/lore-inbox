Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbTCLEeD>; Tue, 11 Mar 2003 23:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbTCLEeD>; Tue, 11 Mar 2003 23:34:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:30099 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S263027AbTCLEd6>;
	Tue, 11 Mar 2003 23:33:58 -0500
Date: Wed, 12 Mar 2003 15:44:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
       Linus <torvalds@transmeta.com>
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-Id: <20030312154413.40511744.sfr@canb.auug.org.au>
In-Reply-To: <OF690DDAD1.0533780B-ONC1256CE6.00437602@de.ibm.com>
References: <OF690DDAD1.0533780B-ONC1256CE6.00437602@de.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Arnd,

On Tue, 11 Mar 2003 13:20:39 +0100 "Martin Schwidefsky" <schwidefsky@de.ibm.com> wrote:
>
> 
> > Did you notice the use of the address conversion macro? Maybe I missed
> > something myself, but I suppose this will fail on s390 if the msb of arg
> > is not cleared.
> 
> True. A(arg) removes the high order bit from arg. This can't be done
> in the system call wrapper because in general arg is a 32 bit parameter.

I did notice :-)  Does the following look OK to you?

This patch also (goes some way) to fixing the net/compat.c as pointers
are used there as well.

Linus, if Martin says this is OK, please apply.  This patch is relative
to my previous patch, but applies to recent BK with some fuzz in the
architectures that haven't merged my previous patch yet.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.64-2003031211-32bit.1/fs/compat.c 2.5.64-2003031211-32bit.2/fs/compat.c
--- 2.5.64-2003031211-32bit.1/fs/compat.c	2003-03-12 11:55:17.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/fs/compat.c	2003-03-12 15:11:27.000000000 +1100
@@ -191,7 +191,7 @@
 	case F_GETLK:
 	case F_SETLK:
 	case F_SETLKW:
-		ret = get_compat_flock(&f, (struct compat_flock *)arg);
+		ret = get_compat_flock(&f, COMPAT_UPTR_TO_PTR(arg));
 		if (ret != 0)
 			break;
 		old_fs = get_fs();
@@ -204,14 +204,14 @@
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock(&f,
-						(struct compat_flock *)arg);
+						COMPAT_UPTR_TO_PTR(arg));
 		}
 		break;
 
 	case F_GETLK64:
 	case F_SETLK64:
 	case F_SETLKW64:
-		ret = get_compat_flock64(&f, (struct compat_flock64 *)arg);
+		ret = get_compat_flock64(&f, COMPAT_UPTR_TO_PTR(arg));
 		if (ret != 0)
 			break;
 		old_fs = get_fs();
@@ -227,7 +227,7 @@
 				ret = -EOVERFLOW;
 			if (ret == 0)
 				ret = put_compat_flock64(&f,
-						(struct compat_flock64 *)arg);
+						COMPAT_UPTR_TO_PTR(arg));
 		}
 		break;
 
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-ia64/compat.h 2.5.64-2003031211-32bit.2/include/asm-ia64/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-ia64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-ia64/compat.h	2003-03-12 15:36:14.000000000 +1100
@@ -107,4 +107,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-mips64/compat.h 2.5.64-2003031211-32bit.2/include/asm-mips64/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-mips64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-mips64/compat.h	2003-03-12 15:36:28.000000000 +1100
@@ -103,4 +103,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-parisc/compat.h 2.5.64-2003031211-32bit.2/include/asm-parisc/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-parisc/compat.h	2003-03-12 11:55:19.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-parisc/compat.h	2003-03-12 15:36:42.000000000 +1100
@@ -103,4 +103,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-ppc64/compat.h 2.5.64-2003031211-32bit.2/include/asm-ppc64/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-ppc64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-ppc64/compat.h	2003-03-12 15:36:52.000000000 +1100
@@ -98,4 +98,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-s390x/compat.h 2.5.64-2003031211-32bit.2/include/asm-s390x/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-s390x/compat.h	2003-03-12 11:55:20.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-s390x/compat.h	2003-03-12 15:37:03.000000000 +1100
@@ -101,4 +101,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)((x) & 0x7fffffffUL))
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-sparc64/compat.h 2.5.64-2003031211-32bit.2/include/asm-sparc64/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-sparc64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-sparc64/compat.h	2003-03-12 15:37:12.000000000 +1100
@@ -100,4 +100,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/include/asm-x86_64/compat.h 2.5.64-2003031211-32bit.2/include/asm-x86_64/compat.h
--- 2.5.64-2003031211-32bit.1/include/asm-x86_64/compat.h	2003-03-12 11:55:21.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/include/asm-x86_64/compat.h	2003-03-12 15:37:19.000000000 +1100
@@ -107,4 +107,13 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffff
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+#define COMPAT_UPTR_TO_PTR(ptr)	((void *)(unsigned long)(x))
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.64-2003031211-32bit.1/net/compat.c 2.5.64-2003031211-32bit.2/net/compat.c
--- 2.5.64-2003031211-32bit.1/net/compat.c	2003-03-12 11:55:24.000000000 +1100
+++ 2.5.64-2003031211-32bit.2/net/compat.c	2003-03-12 15:29:48.000000000 +1100
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
+		kiov->iov_base = COMPAT_UPTR_TO_PTR(buf);
 		kiov->iov_len = (__kernel_size_t) len;
 		uiov32++;
 		kiov++;
@@ -69,9 +68,9 @@
 	if (err)
 		return -EFAULT;
 
-	kmsg->msg_name = (void *)A(tmp1);
-	kmsg->msg_iov = (struct iovec *)A(tmp2);
-	kmsg->msg_control = (void *)A(tmp3);
+	kmsg->msg_name = COMPAT_UPTR_TO_PTR(tmp1);
+	kmsg->msg_iov = COMPAT_UPTR_TO_PTR(tmp2);
+	kmsg->msg_control = COMPAT_UPTR_TO_PTR(tmp3);
 
 	err = get_user(kmsg->msg_namelen, &umsg->msg_namelen);
 	err |= get_user(kmsg->msg_iovlen, &umsg->msg_iovlen);
@@ -458,7 +457,7 @@
 	    __get_user(uptr, &fprog32->filter))
 		return -EFAULT;
 
-	kfprog.filter = (struct sock_filter *)A(uptr);
+	kfprog.filter = COMPAT_UPTR_TO_PTR(uptr);
 	fsize = kfprog.len * sizeof(struct sock_filter);
 
 	kfilter = (struct sock_filter *)kmalloc(fsize, GFP_KERNEL);
@@ -639,36 +638,37 @@
 		ret = sys_socket(a0, a1, a[2]);
 		break;
 	case SYS_BIND:
-		ret = sys_bind(a0, (struct sockaddr *)A(a1), a[2]);
+		ret = sys_bind(a0, COMPAT_UPTR_TO_PTR(a1), a[2]);
 		break;
 	case SYS_CONNECT:
-		ret = sys_connect(a0, (struct sockaddr *)A(a1), a[2]);
+		ret = sys_connect(a0, COMPAT_UPTR_TO_PTR(a1), a[2]);
 		break;
 	case SYS_LISTEN:
 		ret = sys_listen(a0, a1);
 		break;
 	case SYS_ACCEPT:
-		ret = sys_accept(a0, (struct sockaddr *)A(a1), (int *)A(a[2]));
+		ret = sys_accept(a0, COMPAT_UPTR_TO_PTR(a1),
+				COMPAT_UPTR_TO_PTR(a[2]));
 		break;
 	case SYS_GETSOCKNAME:
-		ret = sys_getsockname(a0, (struct sockaddr *)A(a1),
-				       (int *)A(a[2]));
+		ret = sys_getsockname(a0, COMPAT_UPTR_TO_PTR(a1),
+				       COMPAT_UPTR_TO_PTR(a[2]));
 		break;
 	case SYS_GETPEERNAME:
-		ret = sys_getpeername(a0, (struct sockaddr *)A(a1),
-				       (int *)A(a[2]));
+		ret = sys_getpeername(a0, COMPAT_UPTR_TO_PTR(a1),
+				       COMPAT_UPTR_TO_PTR(a[2]));
 		break;
 	case SYS_SOCKETPAIR:
-		ret = sys_socketpair(a0, a1, a[2], (int *)A(a[3]));
+		ret = sys_socketpair(a0, a1, a[2], COMPAT_UPTR_TO_PTR(a[3]));
 		break;
 	case SYS_SEND:
-		ret = sys_send(a0, (void *)A(a1), a[2], a[3]);
+		ret = sys_send(a0, COMPAT_UPTR_TO_PTR(a1), a[2], a[3]);
 		break;
 	case SYS_SENDTO:
 		ret = sys_sendto(a0, a1, a[2], a[3], a[4], a[5]);
 		break;
 	case SYS_RECV:
-		ret = sys_recv(a0, (void *)A(a1), a[2], a[3]);
+		ret = sys_recv(a0, COMPAT_UPTR_TO_PTR(a1), a[2], a[3]);
 		break;
 	case SYS_RECVFROM:
 		ret = sys_recvfrom(a0, a1, a[2], a[3], a[4], a[5]);
@@ -677,19 +677,20 @@
 		ret = sys_shutdown(a0,a1);
 		break;
 	case SYS_SETSOCKOPT:
-		ret = compat_sys_setsockopt(a0, a1, a[2], (char *)A(a[3]),
-				      a[4]);
+		ret = compat_sys_setsockopt(a0, a1, a[2],
+				COMPAT_UPTR_TO_PTR(a[3]), a[4]);
 		break;
 	case SYS_GETSOCKOPT:
-		ret = compat_sys_getsockopt(a0, a1, a[2], (char *)(u64)a[3],
-					    (int *)(u64)a[4]);
+		ret = compat_sys_getsockopt(a0, a1, a[2],
+				COMPAT_UPTR_TO_PTR(a[3]),
+				COMPAT_UPTR_TO_PTR(a[4]));
 		break;
 	case SYS_SENDMSG:
-		ret = compat_sys_sendmsg(a0, (struct compat_msghdr *)A(a1),
+		ret = compat_sys_sendmsg(a0, COMPAT_UPTR_TO_PTR(a1),
 				         a[2]);
 		break;
 	case SYS_RECVMSG:
-		ret = compat_sys_recvmsg(a0, (struct compat_msghdr *)A(a1),
+		ret = compat_sys_recvmsg(a0, COMPAT_UPTR_TO_PTR(a1),
 				         a[2]);
 		break;
 	default:
