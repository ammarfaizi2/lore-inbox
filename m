Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUAIPnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUAIPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:43:54 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:2164 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262050AbUAIPmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:42:16 -0500
Date: Fri, 9 Jan 2004 10:42:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 6/7 Add SO_PEERSEC socket option and getpeersec
 LSM hook.
In-Reply-To: <Xine.LNX.4.44.0401091021000.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091023430.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm1 adds a new option for Unix sockets,
SO_PEERSEC, and an associated LSM hook, getpeersec.  The SELinux handler 
is also included.

The purpose of this is to allow applications to obtain each others
security credentials, analagously to the existing SO_PEERCRED option.  

Examples of use are Security Enhanced D-BUS and Security Enhanced X.

This patch was previously approved in principle by David, and has been 
updated with feedback from Chris Wright and extended to cover all 
architectures.

Please apply.

(If you want a patch which applies independently to the previous patches 
in this set, let me know).

 include/asm-alpha/socket.h        |    2 
 include/asm-arm/socket.h          |    2 
 include/asm-arm26/socket.h        |    2 
 include/asm-cris/socket.h         |    2 
 include/asm-h8300/socket.h        |    2 
 include/asm-i386/socket.h         |    2 
 include/asm-ia64/socket.h         |    2 
 include/asm-m68k/socket.h         |    2 
 include/asm-mips/socket.h         |    2 
 include/asm-parisc/socket.h       |    2 
 include/asm-ppc/socket.h          |    2 
 include/asm-ppc64/socket.h        |    2 
 include/asm-s390/socket.h         |    2 
 include/asm-sh/socket.h           |    2 
 include/asm-sparc/socket.h        |    2 
 include/asm-sparc64/socket.h      |    2 
 include/asm-v850/socket.h         |    2 
 include/asm-x86_64/socket.h       |    2 
 include/linux/security.h          |   50 ++++++++++++++++++++
 include/net/sock.h                |    1 
 net/core/sock.c                   |    9 +++
 security/dummy.c                  |   18 +++++++
 security/selinux/hooks.c          |   94 ++++++++++++++++++++++++++++++++++++++
 security/selinux/include/objsec.h |    6 ++
 24 files changed, 214 insertions(+)

diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-alpha/socket.h linux-2.6.1-rc2.w1/include/asm-alpha/socket.h
--- linux-2.6.1-rc2.pending/include/asm-alpha/socket.h	2004-01-07 13:47:13.798933272 -0500
+++ linux-2.6.1-rc2.w1/include/asm-alpha/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -48,6 +48,8 @@
 #define SO_TIMESTAMP		29
 #define SCM_TIMESTAMP		SO_TIMESTAMP
 
+#define SO_PEERSEC		30
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		19
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	20
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-arm/socket.h linux-2.6.1-rc2.w1/include/asm-arm/socket.h
--- linux-2.6.1-rc2.pending/include/asm-arm/socket.h	2004-01-07 13:47:13.844926280 -0500
+++ linux-2.6.1-rc2.w1/include/asm-arm/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-arm26/socket.h linux-2.6.1-rc2.w1/include/asm-arm26/socket.h
--- linux-2.6.1-rc2.pending/include/asm-arm26/socket.h	2004-01-07 13:47:13.867922784 -0500
+++ linux-2.6.1-rc2.w1/include/asm-arm26/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-cris/socket.h linux-2.6.1-rc2.w1/include/asm-cris/socket.h
--- linux-2.6.1-rc2.pending/include/asm-cris/socket.h	2004-01-07 13:47:13.877921264 -0500
+++ linux-2.6.1-rc2.w1/include/asm-cris/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -47,6 +47,8 @@
 
 #define SO_ACCEPTCONN          30
 
+#define SO_PEERSEC             31
+
 #if defined(__KERNEL__)
 /* Socket types. */
 #define SOCK_STREAM     1               /* stream (connection) socket   */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-h8300/socket.h linux-2.6.1-rc2.w1/include/asm-h8300/socket.h
--- linux-2.6.1-rc2.pending/include/asm-h8300/socket.h	2004-01-07 13:47:13.883920352 -0500
+++ linux-2.6.1-rc2.w1/include/asm-h8300/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-i386/socket.h linux-2.6.1-rc2.w1/include/asm-i386/socket.h
--- linux-2.6.1-rc2.pending/include/asm-i386/socket.h	2004-01-07 13:47:13.887919744 -0500
+++ linux-2.6.1-rc2.w1/include/asm-i386/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nasty libc5 fixup - bletch */
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-ia64/socket.h linux-2.6.1-rc2.w1/include/asm-ia64/socket.h
--- linux-2.6.1-rc2.pending/include/asm-ia64/socket.h	2004-01-07 13:47:13.940911688 -0500
+++ linux-2.6.1-rc2.w1/include/asm-ia64/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -52,6 +52,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC             31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-m68k/socket.h linux-2.6.1-rc2.w1/include/asm-m68k/socket.h
--- linux-2.6.1-rc2.pending/include/asm-m68k/socket.h	2004-01-07 13:47:13.958908952 -0500
+++ linux-2.6.1-rc2.w1/include/asm-m68k/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC             31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-mips/socket.h linux-2.6.1-rc2.w1/include/asm-mips/socket.h
--- linux-2.6.1-rc2.pending/include/asm-mips/socket.h	2004-01-07 13:47:13.974906520 -0500
+++ linux-2.6.1-rc2.w1/include/asm-mips/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -66,6 +66,8 @@
 #define SO_TIMESTAMP		29
 #define SCM_TIMESTAMP		SO_TIMESTAMP
 
+#define SO_PEERSEC             30
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-parisc/socket.h linux-2.6.1-rc2.w1/include/asm-parisc/socket.h
--- linux-2.6.1-rc2.pending/include/asm-parisc/socket.h	2004-01-07 13:47:13.990904088 -0500
+++ linux-2.6.1-rc2.w1/include/asm-parisc/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		0x401c
 
+#define SO_PEERSEC		0x401d
+
 #if defined(__KERNEL__)
 #define SOCK_STREAM	1	/* stream (connection) socket	*/
 #define SOCK_DGRAM	2	/* datagram (conn.less) socket	*/
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-ppc/socket.h linux-2.6.1-rc2.w1/include/asm-ppc/socket.h
--- linux-2.6.1-rc2.pending/include/asm-ppc/socket.h	2004-01-07 13:47:14.005901808 -0500
+++ linux-2.6.1-rc2.w1/include/asm-ppc/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -51,6 +51,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-ppc64/socket.h linux-2.6.1-rc2.w1/include/asm-ppc64/socket.h
--- linux-2.6.1-rc2.pending/include/asm-ppc64/socket.h	2004-01-07 13:47:14.015900288 -0500
+++ linux-2.6.1-rc2.w1/include/asm-ppc64/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -52,6 +52,8 @@
 
 #define SO_ACCEPTCONN           30
 
+#define SO_PEERSEC             31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-s390/socket.h linux-2.6.1-rc2.w1/include/asm-s390/socket.h
--- linux-2.6.1-rc2.pending/include/asm-s390/socket.h	2004-01-07 13:47:14.044895880 -0500
+++ linux-2.6.1-rc2.w1/include/asm-s390/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -53,6 +53,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-sh/socket.h linux-2.6.1-rc2.w1/include/asm-sh/socket.h
--- linux-2.6.1-rc2.pending/include/asm-sh/socket.h	2004-01-07 13:47:14.068892232 -0500
+++ linux-2.6.1-rc2.w1/include/asm-sh/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-sparc/socket.h linux-2.6.1-rc2.w1/include/asm-sparc/socket.h
--- linux-2.6.1-rc2.pending/include/asm-sparc/socket.h	2004-01-07 13:47:14.079890560 -0500
+++ linux-2.6.1-rc2.w1/include/asm-sparc/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 #define SO_TIMESTAMP		0x001d
 #define SCM_TIMESTAMP		SO_TIMESTAMP
 
+#define SO_PEERSEC		0x100e
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x5001
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-sparc64/socket.h linux-2.6.1-rc2.w1/include/asm-sparc64/socket.h
--- linux-2.6.1-rc2.pending/include/asm-sparc64/socket.h	2004-01-07 13:47:14.102887064 -0500
+++ linux-2.6.1-rc2.w1/include/asm-sparc64/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 #define SO_TIMESTAMP		0x001d
 #define SCM_TIMESTAMP		SO_TIMESTAMP
 
+#define SO_PEERSEC		0x001e
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x5001
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-v850/socket.h linux-2.6.1-rc2.w1/include/asm-v850/socket.h
--- linux-2.6.1-rc2.pending/include/asm-v850/socket.h	2004-01-07 13:47:14.108886152 -0500
+++ linux-2.6.1-rc2.w1/include/asm-v850/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC		31
+
 /* Nast libc5 fixup - bletch */
 #if defined(__KERNEL__)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/asm-x86_64/socket.h linux-2.6.1-rc2.w1/include/asm-x86_64/socket.h
--- linux-2.6.1-rc2.pending/include/asm-x86_64/socket.h	2004-01-07 13:47:14.130882808 -0500
+++ linux-2.6.1-rc2.w1/include/asm-x86_64/socket.h	2004-01-07 13:38:09.000000000 -0500
@@ -45,6 +45,8 @@
 
 #define SO_ACCEPTCONN		30
 
+#define SO_PEERSEC             31
+
 /* Nasty libc5 fixup - bletch */
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 /* Socket types. */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/linux/security.h linux-2.6.1-rc2.w1/include/linux/security.h
--- linux-2.6.1-rc2.pending/include/linux/security.h	2004-01-07 13:47:14.188873992 -0500
+++ linux-2.6.1-rc2.w1/include/linux/security.h	2004-01-07 13:38:09.000000000 -0500
@@ -757,6 +757,22 @@
  *	incoming sk_buff @skb has been associated with a particular socket, @sk.
  *	@sk contains the sock (not socket) associated with the incoming sk_buff.
  *	@skb contains the incoming network data.
+ * @socket_getpeersec:
+ *	This hook allows the security module to provide peer socket security
+ *	state to userspace via getsockopt SO_GETPEERSEC.
+ *	@sock is the local socket.
+ *	@optval userspace memory where the security state is to be copied.
+ *	@optlen userspace int where the module should copy the actual length
+ *	of the security state.
+ *	@len as input is the maximum length to copy to userspace provided
+ *	by the caller.
+ *	Return 0 if all is well, otherwise, typical getsockopt return
+ *	values.
+ * @sk_alloc_security:
+ *      Allocate and attach a security structure to the sk->sk_security field,
+ *      which is used to copy security attributes between local stream sockets.
+ * @sk_free_security:
+ *	Deallocate security structure.
  *
  * Security hooks affecting all System V IPC operations.
  *
@@ -1183,6 +1199,9 @@
 	int (*socket_setsockopt) (struct socket * sock, int level, int optname);
 	int (*socket_shutdown) (struct socket * sock, int how);
 	int (*socket_sock_rcv_skb) (struct sock * sk, struct sk_buff * skb);
+	int (*socket_getpeersec) (struct socket *sock, char __user *optval, int __user *optlen, unsigned len);
+	int (*sk_alloc_security) (struct sock *sk, int family, int priority);
+	void (*sk_free_security) (struct sock *sk);
 #endif	/* CONFIG_SECURITY_NETWORK */
 };
 
@@ -2564,6 +2583,22 @@
 {
 	return security_ops->socket_sock_rcv_skb (sk, skb);
 }
+
+static inline int security_socket_getpeersec(struct socket *sock, char __user *optval,
+					     int __user *optlen, unsigned len)
+{
+	return security_ops->socket_getpeersec(sock, optval, optlen, len);
+}
+
+static inline int security_sk_alloc(struct sock *sk, int family, int priority)
+{
+	return security_ops->sk_alloc_security(sk, family, priority);
+}
+
+static inline void security_sk_free(struct sock *sk)
+{
+	return security_ops->sk_free_security(sk);
+}
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct socket * sock,
 					       struct socket * other, 
@@ -2664,6 +2699,21 @@
 {
 	return 0;
 }
+
+static inline int security_socket_getpeersec(struct socket *sock, char __user *optval,
+					     int __user *optlen, unsigned len)
+{
+	return -ENOPROTOOPT;
+}
+
+static inline int security_sk_alloc(struct sock *sk, int family, int priority)
+{
+	return 0;
+}
+
+static inline void security_sk_free(struct sock *sk)
+{
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #endif /* ! __LINUX_SECURITY_H */
diff -urN -X dontdiff linux-2.6.1-rc2.pending/include/net/sock.h linux-2.6.1-rc2.w1/include/net/sock.h
--- linux-2.6.1-rc2.pending/include/net/sock.h	2004-01-07 13:47:14.223868672 -0500
+++ linux-2.6.1-rc2.w1/include/net/sock.h	2004-01-07 13:38:09.000000000 -0500
@@ -246,6 +246,7 @@
 	struct socket		*sk_socket;
 	void			*sk_user_data;
 	struct module		*sk_owner;
+	void			*sk_security;
 	void			(*sk_state_change)(struct sock *sk);
 	void			(*sk_data_ready)(struct sock *sk, int bytes);
 	void			(*sk_write_space)(struct sock *sk);
diff -urN -X dontdiff linux-2.6.1-rc2.pending/net/core/sock.c linux-2.6.1-rc2.w1/net/core/sock.c
--- linux-2.6.1-rc2.pending/net/core/sock.c	2004-01-07 13:47:14.251864416 -0500
+++ linux-2.6.1-rc2.w1/net/core/sock.c	2004-01-07 13:38:09.000000000 -0500
@@ -564,6 +564,9 @@
 			v.val = sk->sk_state == TCP_LISTEN;
 			break;
 
+		case SO_PEERSEC:
+			return security_socket_getpeersec(sock, optval, optlen, len);
+
 		default:
 			return(-ENOPROTOOPT);
 	}
@@ -606,6 +609,11 @@
 			sock_lock_init(sk);
 		}
 		sk->sk_slab = slab;
+		
+		if (security_sk_alloc(sk, family, priority)) {
+			kmem_cache_free(sk->sk_slab, sk);
+			sk = NULL;
+		}
 	}
 	return sk;
 }
@@ -628,6 +636,7 @@
 		printk(KERN_DEBUG "%s: optmem leakage (%d bytes) detected.\n",
 		       __FUNCTION__, atomic_read(&sk->sk_omem_alloc));
 
+	security_sk_free(sk);
 	kmem_cache_free(sk->sk_slab, sk);
 	module_put(owner);
 }
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/dummy.c linux-2.6.1-rc2.w1/security/dummy.c
--- linux-2.6.1-rc2.pending/security/dummy.c	2004-01-07 13:47:14.252864264 -0500
+++ linux-2.6.1-rc2.w1/security/dummy.c	2004-01-07 13:38:09.000000000 -0500
@@ -793,6 +793,21 @@
 {
 	return 0;
 }
+
+static int dummy_socket_getpeersec(struct socket *sock, char __user *optval,
+				   int __user *optlen, unsigned len)
+{
+	return -ENOPROTOOPT;
+}
+
+static inline int dummy_sk_alloc_security (struct sock *sk, int family, int priority)
+{
+	return 0;
+}
+
+static inline void dummy_sk_free_security (struct sock *sk)
+{
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 static int dummy_register_security (const char *name, struct security_operations *ops)
@@ -969,6 +984,9 @@
 	set_to_dummy_if_null(ops, socket_getsockopt);
 	set_to_dummy_if_null(ops, socket_shutdown);
 	set_to_dummy_if_null(ops, socket_sock_rcv_skb);
+	set_to_dummy_if_null(ops, socket_getpeersec);
+	set_to_dummy_if_null(ops, sk_alloc_security);
+	set_to_dummy_if_null(ops, sk_free_security);
 #endif	/* CONFIG_SECURITY_NETWORK */
 }
 
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 13:47:14.278860312 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 13:39:42.000000000 -0500
@@ -244,6 +244,39 @@
 	kfree(sbsec);
 }
 
+#ifdef CONFIG_SECURITY_NETWORK
+static int sk_alloc_security(struct sock *sk, int family, int priority)
+{
+	struct sk_security_struct *ssec;
+
+	if (family != PF_UNIX)
+		return 0;
+
+	ssec = kmalloc(sizeof(*ssec), priority);
+	if (!ssec)
+		return -ENOMEM;
+
+	memset(ssec, 0, sizeof(*ssec));
+	ssec->magic = SELINUX_MAGIC;
+	ssec->sk = sk;
+	ssec->peer_sid = SECINITSID_UNLABELED;
+	sk->sk_security = ssec;
+
+	return 0;
+}
+
+static void sk_free_security(struct sock *sk)
+{
+	struct task_security_struct *ssec = sk->sk_security;
+
+	if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
+		return;
+
+	sk->sk_security = NULL;
+	kfree(ssec);
+}
+#endif	/* CONFIG_SECURITY_NETWORK */
+
 /* The security server must be initialized before
    any labeling or access decisions can be provided. */
 extern int ss_initialized;
@@ -2540,6 +2573,7 @@
 					      struct socket *other,
 					      struct sock *newsk)
 {
+	struct sk_security_struct *ssec;
 	struct inode_security_struct *isec;
 	struct inode_security_struct *other_isec;
 	struct avc_audit_data ad;
@@ -2558,6 +2592,14 @@
 	if (err)
 		return err;
 
+	/* connecting socket */
+	ssec = sock->sk->sk_security;
+	ssec->peer_sid = other_isec->sid;
+	
+	/* server child socket */
+	ssec = newsk->sk_security;
+	ssec->peer_sid = isec->sid;
+	
 	return 0;
 }
 
@@ -2664,6 +2706,54 @@
 	return err;
 }
 
+static int selinux_socket_getpeersec(struct socket *sock, char __user *optval,
+				     int __user *optlen, unsigned len)
+{
+	int err = 0;
+	char *scontext;
+	u32 scontext_len;
+	struct sk_security_struct *ssec;
+	struct inode_security_struct *isec;
+
+	isec = SOCK_INODE(sock)->i_security;
+	if (isec->sclass != SECCLASS_UNIX_STREAM_SOCKET) {
+		err = -ENOPROTOOPT;
+		goto out;
+	}
+
+	ssec = sock->sk->sk_security;
+	
+	err = security_sid_to_context(ssec->peer_sid, &scontext, &scontext_len);
+	if (err)
+		goto out;
+
+	if (scontext_len > len) {
+		err = -ERANGE;
+		goto out_len;
+	}
+
+	if (copy_to_user(optval, scontext, scontext_len))
+		err = -EFAULT;
+
+out_len:
+	if (put_user(scontext_len, optlen))
+		err = -EFAULT;
+
+	kfree(scontext);
+out:	
+	return err;
+}
+
+static int selinux_sk_alloc_security(struct sock *sk, int family, int priority)
+{
+	return sk_alloc_security(sk, family, priority);
+}
+
+static void selinux_sk_free_security(struct sock *sk)
+{
+	sk_free_security(sk);
+}
+
 #ifdef CONFIG_NETFILTER
 static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
                                               struct sk_buff **pskb,
@@ -2741,6 +2831,7 @@
 out:
 	return err;
 }
+
 #endif	/* CONFIG_NETFILTER */
 
 #endif	/* CONFIG_SECURITY_NETWORK */
@@ -3479,6 +3570,9 @@
 	.socket_setsockopt =		selinux_socket_setsockopt,
 	.socket_shutdown =		selinux_socket_shutdown,
 	.socket_sock_rcv_skb =		selinux_socket_sock_rcv_skb,
+	.socket_getpeersec =		selinux_socket_getpeersec,
+	.sk_alloc_security =		selinux_sk_alloc_security,
+	.sk_free_security =		selinux_sk_free_security,
 #endif
 };
 
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/objsec.h linux-2.6.1-rc2.w1/security/selinux/include/objsec.h
--- linux-2.6.1-rc2.pending/security/selinux/include/objsec.h	2004-01-07 13:47:14.279860160 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/objsec.h	2004-01-07 13:38:09.000000000 -0500
@@ -100,6 +100,12 @@
 	struct avc_entry_ref avcr;	/* reference to permissions */
 };
 
+struct sk_security_struct {
+	unsigned long magic;		/* magic number for this module */
+	struct sock *sk;		/* back pointer to sk object */
+	u32 peer_sid;			/* SID of peer */
+};
+
 extern int inode_security_set_sid(struct inode *inode, u32 sid);
 
 #endif /* _SELINUX_OBJSEC_H_ */




