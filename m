Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbTCRHIg>; Tue, 18 Mar 2003 02:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbTCRHIg>; Tue, 18 Mar 2003 02:08:36 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:50070 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262186AbTCRHIY>;
	Tue, 18 Mar 2003 02:08:24 -0500
Date: Tue, 18 Mar 2003 18:18:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, bcrl@redhat.com
Subject: Re: [PATCH][COMPAT] cleanups in net/compat.c and related files
Message-Id: <20030318181824.6f593d2c.sfr@canb.auug.org.au>
In-Reply-To: <20030314180132.4696a7ca.sfr@canb.auug.org.au>
References: <20030314180132.4696a7ca.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dave,

Just rediffed against 2.5.65 and since it is mostly a networking
change, I though I should send it to you.

On Fri, 14 Mar 2003 18:01:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> These are just some cleanups fo the code that went in recently.  They
> depend on my previous compat_uptr_t patch.  A couple of (not so) subtle
> bugs (mostly to do with accessing user mode) are fixed in here as well.

This also moves (almost) all if the compatibility stuff out of
linux/socket.h and into net/compat_socket.h

> Have a look, tell me what you think.
> 
> diffstat looks like this:
> 
>  arch/sparc64/kernel/sparc64_ksyms.c |    2 
>  arch/sparc64/kernel/sys_sunos32.c   |    1 
>  arch/sparc64/solaris/socket.c       |    2 
>  include/linux/compat.h              |    4 
>  include/linux/socket.h              |   13 -
>  include/net/compat_socket.h         |   74 +++-------
>  net/compat.c                        |  265 ++++++++++++++++++++----------------
>  net/core/scm.c                      |    1 
>  net/socket.c                        |   16 --
>  9 files changed, 190 insertions(+), 188 deletions(-)
> 
> My kernel still builds on i386, but beyond that, I have just been
> careful :-)
> 
> There is more to be done.
> 
> Thanks to Ben for doing the hard scm work.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-32bit.2/arch/sparc64/kernel/sparc64_ksyms.c 2.5.65-32bit.3/arch/sparc64/kernel/sparc64_ksyms.c
--- 2.5.65-32bit.2/arch/sparc64/kernel/sparc64_ksyms.c	2003-03-18 10:17:05.000000000 +1100
+++ 2.5.65-32bit.3/arch/sparc64/kernel/sparc64_ksyms.c	2003-03-14 17:40:12.000000000 +1100
@@ -22,6 +22,8 @@
 #include <linux/mm.h>
 #include <linux/socket.h>
 
+#include <net/compat_socket.h>
+
 #include <asm/oplib.h>
 #include <asm/delay.h>
 #include <asm/system.h>
diff -ruN 2.5.65-32bit.2/arch/sparc64/kernel/sys_sunos32.c 2.5.65-32bit.3/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.65-32bit.2/arch/sparc64/kernel/sys_sunos32.c	2003-03-18 10:17:05.000000000 +1100
+++ 2.5.65-32bit.3/arch/sparc64/kernel/sys_sunos32.c	2003-03-14 17:46:09.000000000 +1100
@@ -56,6 +56,7 @@
 /* For SOCKET_I */
 #include <linux/socket.h>
 #include <net/sock.h>
+#include <net/compat_socket.h>
 
 /* Use this to get at 32-bit user passed pointers. */
 #define A(__x)				\
diff -ruN 2.5.65-32bit.2/arch/sparc64/solaris/socket.c 2.5.65-32bit.3/arch/sparc64/solaris/socket.c
--- 2.5.65-32bit.2/arch/sparc64/solaris/socket.c	2003-03-18 10:17:05.000000000 +1100
+++ 2.5.65-32bit.3/arch/sparc64/solaris/socket.c	2003-03-14 17:17:22.000000000 +1100
@@ -16,6 +16,8 @@
 #include <linux/net.h>
 #include <linux/compat.h>
 
+#include <net/compat_socket.h>
+
 #include <asm/uaccess.h>
 #include <asm/string.h>
 #include <asm/oplib.h>
diff -ruN 2.5.65-32bit.2/include/linux/compat.h 2.5.65-32bit.3/include/linux/compat.h
--- 2.5.65-32bit.2/include/linux/compat.h	2003-03-18 10:17:24.000000000 +1100
+++ 2.5.65-32bit.3/include/linux/compat.h	2003-03-13 17:54:27.000000000 +1100
@@ -43,11 +43,9 @@
 extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
 
 struct compat_iovec {
-	u32		iov_base;
+	compat_uptr_t	iov_base;
 	compat_size_t	iov_len;
 };
-#else /* no CONFIG_COMPAT */
-#define compat_size_t	size_t
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruN 2.5.65-32bit.2/include/linux/socket.h 2.5.65-32bit.3/include/linux/socket.h
--- 2.5.65-32bit.2/include/linux/socket.h	2003-03-18 10:17:24.000000000 +1100
+++ 2.5.65-32bit.3/include/linux/socket.h	2003-03-14 17:36:50.000000000 +1100
@@ -3,6 +3,7 @@
 
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
+#include <linux/config.h>		/* for CONFIG_COMPAT */
 #include <linux/linkage.h>
 #include <asm/socket.h>			/* arch-dependent defines	*/
 #include <linux/sockios.h>		/* the SIOCxxx I/O controls	*/
@@ -239,18 +240,10 @@
 #define MSG_CMSG_COMPAT	0x80000000	/* This message needs 32 bit fixups */
 #else
 #define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
-#define compat_msghdr	msghdr		/* Needed to avoid compiler hoops */
 #endif
 
-struct compat_msghdr;
-extern int msghdr_from_user_compat_to_kern(struct msghdr *, struct compat_msghdr *);
-extern int verify_compat_iovec(struct msghdr *, struct iovec *, char *, int);
-extern asmlinkage long compat_sys_sendmsg(int,struct compat_msghdr *,unsigned);
-extern asmlinkage long compat_sys_recvmsg(int,struct compat_msghdr *,unsigned);
 extern asmlinkage long sys_sendmsg(int fd, struct msghdr *msg, unsigned flags);
 extern asmlinkage long sys_recvmsg(int fd, struct msghdr *msg, unsigned flags);
-extern asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
-				char *optval, int *optlen);
 
 
 
@@ -295,10 +288,6 @@
 extern int move_addr_to_user(void *kaddr, int klen, void *uaddr, int *ulen);
 extern int move_addr_to_kernel(void *uaddr, int ulen, void *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
-extern int put_cmsg_compat(struct msghdr*, int level, int type, int len, void *data);
-extern void cmsg_compat_recvmsg_fixup(struct msghdr *kmsg, unsigned long orig_cmsg_uptr);
-extern int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg,
-			       unsigned char *stackbuf, int stackbuf_size);
 
 #endif
 #endif /* not kernel and not glibc */
diff -ruN 2.5.65-32bit.2/include/net/compat_socket.h 2.5.65-32bit.3/include/net/compat_socket.h
--- 2.5.65-32bit.2/include/net/compat_socket.h	2003-03-18 10:17:25.000000000 +1100
+++ 2.5.65-32bit.3/include/net/compat_socket.h	2003-03-14 17:43:01.000000000 +1100
@@ -1,67 +1,41 @@
 #ifndef NET_COMPAT_SOCKET_H
 #define NET_COMPAT_SOCKET_H 1
 
-#include <linux/compat.h>
+#include <linux/config.h>
 
 #if defined(CONFIG_COMPAT)
 
-/* XXX This really belongs in some header file... -DaveM */
-#define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
-					   16 for IP, 16 for IPX,
-					   24 for IPv6,
-					   about 80 for AX.25 */
+#include <linux/compat.h>
 
 struct compat_msghdr {
-	u32		msg_name;
-	int		msg_namelen;
-	u32		msg_iov;
+	compat_uptr_t	msg_name;
+	s32		msg_namelen;
+	compat_uptr_t	msg_iov;
 	compat_size_t	msg_iovlen;
-	u32		msg_control;
+	compat_uptr_t	msg_control;
 	compat_size_t	msg_controllen;
-	unsigned	msg_flags;
+	u32		msg_flags;
 };
 
 struct compat_cmsghdr {
 	compat_size_t	cmsg_len;
-	int		cmsg_level;
-	int		cmsg_type;
+	s32		cmsg_level;
+	s32		cmsg_type;
 };
 
-/* Bleech... */
-#define __CMSG_COMPAT_NXTHDR(ctl, len, cmsg, cmsglen) __cmsg_compat_nxthdr((ctl),(len),(cmsg),(cmsglen))
-#define CMSG_COMPAT_NXTHDR(mhdr, cmsg, cmsglen) cmsg_compat_nxthdr((mhdr), (cmsg), (cmsglen))
-
-#define CMSG_COMPAT_ALIGN(len) ( ((len)+sizeof(int)-1) & ~(sizeof(int)-1) )
-
-#define CMSG_COMPAT_DATA(cmsg)	((void *)((char *)(cmsg) + CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr))))
-#define CMSG_COMPAT_SPACE(len) (CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr)) + CMSG_COMPAT_ALIGN(len))
-#define CMSG_COMPAT_LEN(len) (CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr)) + (len))
-
-#define __CMSG_COMPAT_FIRSTHDR(ctl,len) ((len) >= sizeof(struct compat_cmsghdr) ? \
-				    (struct compat_cmsghdr *)(ctl) : \
-				    (struct compat_cmsghdr *)NULL)
-#define CMSG_COMPAT_FIRSTHDR(msg)	__CMSG_COMPAT_FIRSTHDR((msg)->msg_control, (msg)->msg_controllen)
-
-static __inline__ struct compat_cmsghdr *__cmsg_compat_nxthdr(void *__ctl, __kernel_size_t __size,
-					      struct compat_cmsghdr *__cmsg, int __cmsg_len)
-{
-	struct compat_cmsghdr * __ptr;
-
-	__ptr = (struct compat_cmsghdr *)(((unsigned char *) __cmsg) +
-				     CMSG_COMPAT_ALIGN(__cmsg_len));
-	if ((unsigned long)((char*)(__ptr+1) - (char *) __ctl) > __size)
-		return NULL;
-
-	return __ptr;
-}
-
-static __inline__ struct compat_cmsghdr *cmsg_compat_nxthdr (struct msghdr *__msg,
-					    struct compat_cmsghdr *__cmsg,
-					    int __cmsg_len)
-{
-	return __cmsg_compat_nxthdr(__msg->msg_control, __msg->msg_controllen,
-			       __cmsg, __cmsg_len);
-}
+#else /* defined(CONFIG_COMPAT) */
+#define compat_msghdr	msghdr		/* to avoid compiler warnings */
+#endif /* defined(CONFIG_COMPAT) */
+
+extern int get_compat_msghdr(struct msghdr *, struct compat_msghdr *);
+extern int verify_compat_iovec(struct msghdr *, struct iovec *, char *, int);
+extern asmlinkage long compat_sys_sendmsg(int,struct compat_msghdr *,unsigned);
+extern asmlinkage long compat_sys_recvmsg(int,struct compat_msghdr *,unsigned);
+extern asmlinkage long compat_sys_getsockopt(int, int, int, char *, int *);
+extern int put_cmsg_compat(struct msghdr*, int, int, int, void *);
+extern int put_compat_msg_controllen(struct msghdr *, struct compat_msghdr *,
+		unsigned long);
+extern int cmsghdr_from_user_compat_to_kern(struct msghdr *, unsigned char *,
+		int);
 
-#endif /* CONFIG_COMPAT */
-#endif
+#endif /* NET_COMPAT_SOCKET_H */
diff -ruN 2.5.65-32bit.2/net/compat.c 2.5.65-32bit.3/net/compat.c
--- 2.5.65-32bit.2/net/compat.c	2003-03-12 17:57:00.000000000 +1100
+++ 2.5.65-32bit.3/net/compat.c	2003-03-14 16:42:39.000000000 +1100
@@ -29,10 +29,6 @@
 
 #define AA(__x)		((unsigned long)(__x))
 
-extern asmlinkage long sys_getsockopt(int fd, int level, int optname,
-				       void * optval, int *optlen);
-
-
 static inline int iov_from_user_compat_to_kern(struct iovec *kiov,
 					  struct compat_iovec *uiov32,
 					  int niov)
@@ -40,7 +36,8 @@
 	int tot_len = 0;
 
 	while(niov > 0) {
-		u32 len, buf;
+		compat_uptr_t buf;
+		compat_size_t len;
 
 		if(get_user(len, &uiov32->iov_len) ||
 		   get_user(buf, &uiov32->iov_base)) {
@@ -57,27 +54,23 @@
 	return tot_len;
 }
 
-int msghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct compat_msghdr *umsg)
+int get_compat_msghdr(struct msghdr *kmsg, struct compat_msghdr *umsg)
 {
 	compat_uptr_t tmp1, tmp2, tmp3;
-	int err;
 
-	err = get_user(tmp1, &umsg->msg_name);
-	err |= __get_user(tmp2, &umsg->msg_iov);
-	err |= __get_user(tmp3, &umsg->msg_control);
-	if (err)
+	if (!access_ok(VERIFY_READ, umsg, sizeof(*umsg)) ||
+	    __get_user(tmp1, &umsg->msg_name) ||
+	    __get_user(kmsg->msg_namelen, &umsg->msg_namelen) ||
+	    __get_user(tmp2, &umsg->msg_iov) ||
+	    __get_user(kmsg->msg_iovlen, &umsg->msg_iovlen) ||
+	    __get_user(tmp3, &umsg->msg_control) ||
+	    __get_user(kmsg->msg_controllen, &umsg->msg_controllen) ||
+	    __get_user(kmsg->msg_flags, &umsg->msg_flags))
 		return -EFAULT;
-
 	kmsg->msg_name = compat_ptr(tmp1);
 	kmsg->msg_iov = compat_ptr(tmp2);
 	kmsg->msg_control = compat_ptr(tmp3);
-
-	err = get_user(kmsg->msg_namelen, &umsg->msg_namelen);
-	err |= get_user(kmsg->msg_iovlen, &umsg->msg_iovlen);
-	err |= get_user(kmsg->msg_controllen, &umsg->msg_controllen);
-	err |= get_user(kmsg->msg_flags, &umsg->msg_flags);
-	
-	return err;
+	return 0;
 }
 
 /* I've named the args so it is easy to tell whose space the pointers are in. */
@@ -116,6 +109,34 @@
 	return tot_len;
 }
 
+/* Bleech... */
+#define CMSG_COMPAT_ALIGN(len)	ALIGN((len), sizeof(s32))
+
+#define CMSG_COMPAT_DATA(cmsg)				\
+	((void *)((char *)(cmsg) + CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr))))
+#define CMSG_COMPAT_SPACE(len)				\
+	(CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr)) + CMSG_COMPAT_ALIGN(len))
+#define CMSG_COMPAT_LEN(len)				\
+	(CMSG_COMPAT_ALIGN(sizeof(struct compat_cmsghdr)) + (len))
+
+#define CMSG_COMPAT_FIRSTHDR(msg)			\
+	(((msg)->msg_controllen) >= sizeof(struct compat_cmsghdr) ?	\
+	 (struct compat_cmsghdr *)((msg)->msg_control) :		\
+	 (struct compat_cmsghdr *)NULL)
+
+static inline struct compat_cmsghdr *cmsg_compat_nxthdr(struct msghdr *msg,
+		struct compat_cmsghdr *cmsg, int cmsg_len)
+{
+	struct compat_cmsghdr *ptr;
+
+	ptr = (struct compat_cmsghdr *)(((unsigned char *)cmsg) +
+			CMSG_COMPAT_ALIGN(cmsg_len));
+	if ((unsigned long)((char *)(ptr + 1) - (char *)msg->msg_control) >
+			msg->msg_controllen)
+		return NULL;
+	return ptr;
+}
+
 /* There is a lot of hair here because the alignment rules (and
  * thus placement) of cmsg headers and length are different for
  * 32-bit apps.  -DaveM
@@ -146,7 +167,7 @@
 		tmp = ((ucmlen - CMSG_COMPAT_ALIGN(sizeof(*ucmsg))) +
 		       CMSG_ALIGN(sizeof(struct cmsghdr)));
 		kcmlen += tmp;
-		ucmsg = CMSG_COMPAT_NXTHDR(kmsg, ucmsg, ucmlen);
+		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, ucmlen);
 	}
 	if(kcmlen == 0)
 		return -EINVAL;
@@ -180,7 +201,7 @@
 
 		/* Advance. */
 		kcmsg = (struct cmsghdr *)((char *)kcmsg + CMSG_ALIGN(tmp));
-		ucmsg = CMSG_COMPAT_NXTHDR(kmsg, ucmsg, ucmlen);
+		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, ucmlen);
 	}
 
 	/* Ok, looks like we made it.  Hook it up and return success. */
@@ -303,7 +324,7 @@
  *		IPV6_RTHDR	ipv6 routing exthdr	32-bit clean
  *		IPV6_AUTHHDR	ipv6 auth exthdr	32-bit clean
  */
-void cmsg_compat_recvmsg_fixup(struct msghdr *kmsg, unsigned long orig_cmsg_uptr)
+static void cmsg_compat_recvmsg_fixup(struct msghdr *kmsg, unsigned long orig_cmsg_uptr)
 {
 	unsigned char *workbuf, *wp;
 	unsigned long bufsz, space_avail;
@@ -364,112 +385,133 @@
 	kmsg->msg_control = (void *) orig_cmsg_uptr;
 }
 
+int put_compat_msg_controllen(struct msghdr *msg_sys,
+		struct compat_msghdr *msg_compat, unsigned long cmsg_ptr)
+{
+	unsigned long ucmsg_ptr;
+	compat_size_t uclen;
+
+	if ((unsigned long)msg_sys->msg_control != cmsg_ptr)
+		cmsg_compat_recvmsg_fixup(msg_sys, cmsg_ptr);
+	ucmsg_ptr = ((unsigned long)msg_sys->msg_control);
+	uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
+	return __put_user(uclen, &msg_compat->msg_controllen);
+}
+
 extern asmlinkage int sys_setsockopt(int fd, int level, int optname,
 				     char *optval, int optlen);
 
+/*
+ * For now, we assume that the compatibility and native version
+ * of struct ipt_entry are the same - sfr.  FIXME
+ */
+struct compat_ipt_replace {
+	char			name[IPT_TABLE_MAXNAMELEN];
+	u32			valid_hooks;
+	u32			num_entries;
+	u32			size;
+	u32			hook_entry[NF_IP_NUMHOOKS];
+	u32			underflow[NF_IP_NUMHOOKS];
+	u32			num_counters;
+	compat_uptr_t		counters;	/* struct ipt_counters * */
+	struct ipt_entry	entries[0];
+};
+
 static int do_netfilter_replace(int fd, int level, int optname,
 				char *optval, int optlen)
 {
-	struct ipt_replace32 {
-		char name[IPT_TABLE_MAXNAMELEN];
-		__u32 valid_hooks;
-		__u32 num_entries;
-		__u32 size;
-		__u32 hook_entry[NF_IP_NUMHOOKS];
-		__u32 underflow[NF_IP_NUMHOOKS];
-		__u32 num_counters;
-		__u32 counters;
-		struct ipt_entry entries[0];
-	} *repl32 = (struct ipt_replace32 *)optval;
+	struct compat_ipt_replace *urepl = (struct compat_ipt_replace *)optval;
 	struct ipt_replace *krepl;
-	struct ipt_counters *counters32;
-	__u32 origsize;
-	unsigned int kreplsize, kcountersize;
+	struct ipt_counters *ucounters;
+	u32 origsize;
+	unsigned int kreplsize;
 	mm_segment_t old_fs;
 	int ret;
+	int i;
+	compat_uptr_t ucntrs;
 
-	if (optlen < sizeof(repl32))
-		return -EINVAL;
-
-	if (copy_from_user(&origsize,
-			&repl32->size,
-			sizeof(origsize)))
+	if (get_user(origsize, &urepl->size))
 		return -EFAULT;
 
-	kreplsize = sizeof(*krepl) + origsize;
-	kcountersize = krepl->num_counters * sizeof(struct ipt_counters);
-
 	/* Hack: Causes ipchains to give correct error msg --RR */
-	if (optlen != kreplsize)
+	if (optlen != sizeof(*urepl) + origsize)
 		return -ENOPROTOOPT;
 
+	kreplsize = sizeof(*krepl) + origsize - num_entries *
+		(sizeof(struct compat_ipt_entry) - sizeof(struct ipt_entry));
 	krepl = (struct ipt_replace *)kmalloc(kreplsize, GFP_KERNEL);
 	if (krepl == NULL)
 		return -ENOMEM;
 
-	if (copy_from_user(krepl, optval, kreplsize)) {
-		kfree(krepl);
-		return -EFAULT;
+	ret = -EFAULT;
+	krepl->size = origsize;
+	if (!access_ok(VERIFY_READ, urepl, optlen) ||
+	    __copy_from_user(krepl->name, urepl->name, sizeof(urepl->name)) ||
+	    __get_user(krepl->valid_hooks, &urepl->valid_hooks) ||
+	    __get_user(krepl->num_entries, &urepl->num_entries) ||
+	    __get_user(krepl->num_counters, &urepl->num_counters) ||
+	    __get_user(ucntrs, &urepl->counters) ||
+	    __copy_from_user(krepl->entries, &urepl->entries, origsize))
+		goto out_free;
+	for (i = 0; i < NF_IP_NUM_HOOKS; i++) {
+		if (__get_user(krepl->hook_entry[i], &urepl->hook_entry[i]) ||
+		    __get_user(krepl->underflow[i], &urepl->underflow[i]))
+			goto out_free;
 	}
 
-	counters32 = (struct ipt_counters *)AA(
-		((struct ipt_replace32 *)krepl)->counters);
-
-	kcountersize = krepl->num_counters * sizeof(struct ipt_counters);
-	krepl->counters = (struct ipt_counters *)kmalloc(
-					kcountersize, GFP_KERNEL);
-	if (krepl->counters == NULL) {
-		kfree(krepl);
-		return -ENOMEM;
-	}
+	/*
+	 * Since struct ipt_counters just contains two u_int64_t members
+	 * we can just do the access_ok check here and pass the (converted)
+	 * pointer into the standard syscall.  We hope that the pointer is
+	 * not misaligned ...
+	 */
+	krepl->counters = compat_ptr(ucntrs);
+	if (!access_ok(VERIFY_WRITE, krepl->counters,
+			krepl->num_counters * sizeof(struct ipt_counters)))
+		goto out_free;
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
-	ret = sys_setsockopt(fd, level, optname,
-			     (char *)krepl, kreplsize);
+	ret = sys_setsockopt(fd, level, optname, (char *)krepl, kreplsize);
 	set_fs(old_fs);
 
-	if (ret == 0 &&
-		copy_to_user(counters32, krepl->counters, kcountersize))
-			ret = -EFAULT;
-
-	kfree(krepl->counters);
+out_free:
 	kfree(krepl);
-
 	return ret;
 }
 
+/*
+ * A struct sock_filter is architecture independent.
+ */
+struct compat_sock_fprog {
+	u16		len;
+	compat_uptr_t	filter;		/* struct sock_filter * */
+};
+
 static int do_set_attach_filter(int fd, int level, int optname,
 				char *optval, int optlen)
 {
-	struct sock_fprog32 {
-		__u16 len;
-		__u32 filter;
-	} *fprog32 = (struct sock_fprog32 *)optval;
+	struct compat_sock_fprog *fprog32 = (struct compat_sock_fprog *)optval;
 	struct sock_fprog kfprog;
 	struct sock_filter *kfilter;
-	unsigned int fsize;
 	mm_segment_t old_fs;
 	compat_uptr_t uptr;
 	int ret;
 
-	if (get_user(kfprog.len, &fprog32->len) ||
+	if (!access_ok(VERIFY_READ, fprog32, sizeof(*fprog32)) ||
+	    __get_user(kfprog.len, &fprog32->len) ||
 	    __get_user(uptr, &fprog32->filter))
 		return -EFAULT;
 
 	kfprog.filter = compat_ptr(uptr);
-	fsize = kfprog.len * sizeof(struct sock_filter);
-
-	kfilter = (struct sock_filter *)kmalloc(fsize, GFP_KERNEL);
-	if (kfilter == NULL)
-		return -ENOMEM;
-
-	if (copy_from_user(kfilter, kfprog.filter, fsize)) {
-		kfree(kfilter);
+	/*
+	 * Since struct sock_filter is architecure independent,
+	 * we can just do the access_ok check and pass the
+	 * same pointer to the real syscall.
+	 */
+	if (!access_ok(VERIFY_READ, kfprog.filter,
+			kfprog.len * sizeof(struct sock_filter)))
 		return -EFAULT;
-	}
-
-	kfprog.filter = kfilter;
 
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -477,8 +519,6 @@
 			     (char *)&kfprog, sizeof(kfprog));
 	set_fs(old_fs);
 
-	kfree(kfilter);
-
 	return ret;
 }
 
@@ -489,10 +529,11 @@
 	mm_segment_t old_fs;
 	int ret, i;
 
+	if (optlen < sizeof(*kfilter))
+		return -EINVAL;
 	if (copy_from_user(&kfilter, optval, sizeof(kfilter)))
 		return -EFAULT;
 
-
 	for (i = 0; i < 8; i += 2) {
 		u32 tmp = kfilter.data[i];
 
@@ -518,7 +559,8 @@
 
 	if (optlen < sizeof(*up))
 		return -EINVAL;
-	if (get_user(ktime.tv_sec, &up->tv_sec) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    __get_user(ktime.tv_sec, &up->tv_sec) ||
 	    __get_user(ktime.tv_usec, &up->tv_usec))
 		return -EFAULT;
 	old_fs = get_fs();
@@ -529,7 +571,7 @@
 	return err;
 }
 
-asmlinkage int compat_sys_setsockopt(int fd, int level, int optname,
+asmlinkage long compat_sys_setsockopt(int fd, int level, int optname,
 				char *optval, int optlen)
 {
 	if (optname == IPT_SO_SET_REPLACE)
@@ -547,7 +589,11 @@
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-static int do_get_sock_timeout(int fd, int level, int optname, char *optval, int *optlen)
+extern asmlinkage long sys_getsockopt(int fd, int level, int optname,
+				       void * optval, int *optlen);
+
+static int do_get_sock_timeout(int fd, int level, int optname, char *optval,
+		int *optlen)
 {
 	struct compat_timeval *up = (struct compat_timeval *) optval;
 	struct timeval ktime;
@@ -566,7 +612,8 @@
 
 	if (!err) {
 		if (put_user(sizeof(*up), optlen) ||
-		    put_user(ktime.tv_sec, &up->tv_sec) ||
+		    !access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+		    __put_user(ktime.tv_sec, &up->tv_sec) ||
 		    __put_user(ktime.tv_usec, &up->tv_usec))
 			err = -EFAULT;
 	}
@@ -588,27 +635,21 @@
 				AL(6),AL(2),AL(5),AL(5),AL(3),AL(3)};
 #undef AL
 
-extern asmlinkage long sys_bind(int fd, struct sockaddr *umyaddr, int addrlen);
-extern asmlinkage long sys_connect(int fd, struct sockaddr *uservaddr,
-				  int addrlen);
-extern asmlinkage long sys_accept(int fd, struct sockaddr *upeer_sockaddr,
-				 int *upeer_addrlen); 
-extern asmlinkage long sys_getsockname(int fd, struct sockaddr *usockaddr,
-				      int *usockaddr_len);
-extern asmlinkage long sys_getpeername(int fd, struct sockaddr *usockaddr,
-				      int *usockaddr_len);
-extern asmlinkage long sys_send(int fd, void *buff, size_t len, unsigned flags);
-extern asmlinkage long sys_sendto(int fd, u32 buff, compat_size_t len,
-				   unsigned flags, u32 addr, int addr_len);
-extern asmlinkage long sys_recv(int fd, void *ubuf, size_t size, unsigned flags);
-extern asmlinkage long sys_recvfrom(int fd, u32 ubuf, compat_size_t size,
-				     unsigned flags, u32 addr, u32 addr_len);
-extern asmlinkage long sys_socket(int family, int type, int protocol);
-extern asmlinkage long sys_socketpair(int family, int type, int protocol,
-				     int usockvec[2]);
-extern asmlinkage long sys_shutdown(int fd, int how);
-extern asmlinkage long sys_listen(int fd, int backlog);
-
+extern asmlinkage long sys_bind(int, struct sockaddr *, int);
+extern asmlinkage long sys_connect(int, struct sockaddr *, int);
+extern asmlinkage long sys_accept(int, struct sockaddr *, int *); 
+extern asmlinkage long sys_getsockname(int, struct sockaddr *, int *);
+extern asmlinkage long sys_getpeername(int, struct sockaddr *, int *);
+extern asmlinkage long sys_send(int, void *, size_t, unsigned);
+extern asmlinkage long sys_sendto(int, void *, size_t, unsigned,
+		struct sockaddr *, int);
+extern asmlinkage long sys_recv(int, void *, size_t, unsigned);
+extern asmlinkage long sys_recvfrom(int, void *, size_t, unsigned,
+		struct sockaddr *, int *);
+extern asmlinkage long sys_socket(int, int, int);
+extern asmlinkage long sys_socketpair(int, int, int, int [2]);
+extern asmlinkage long sys_shutdown(int, int);
+extern asmlinkage long sys_listen(int, int);
 
 asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr *msg, unsigned flags)
 {
diff -ruN 2.5.65-32bit.2/net/core/scm.c 2.5.65-32bit.3/net/core/scm.c
--- 2.5.65-32bit.2/net/core/scm.c	2003-03-18 10:17:26.000000000 +1100
+++ 2.5.65-32bit.3/net/core/scm.c	2003-03-14 17:44:07.000000000 +1100
@@ -30,6 +30,7 @@
 #include <net/protocol.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
+#include <net/compat_socket.h>
 #include <net/scm.h>
 
 
diff -ruN 2.5.65-32bit.2/net/socket.c 2.5.65-32bit.3/net/socket.c
--- 2.5.65-32bit.2/net/socket.c	2003-03-18 10:17:29.000000000 +1100
+++ 2.5.65-32bit.3/net/socket.c	2003-03-13 18:03:23.000000000 +1100
@@ -1558,7 +1558,7 @@
 	
 	err = -EFAULT;
 	if (MSG_CMSG_COMPAT & flags) {
-		if (msghdr_from_user_compat_to_kern(&msg_sys, msg_compat))
+		if (get_compat_msghdr(&msg_sys, msg_compat))
 			return -EFAULT;
 	} else if (copy_from_user(&msg_sys, msg, sizeof(struct msghdr)))
 		return -EFAULT;
@@ -1652,7 +1652,7 @@
 	int *uaddr_len;
 	
 	if (MSG_CMSG_COMPAT & flags) {
-		if (msghdr_from_user_compat_to_kern(&msg_sys, msg_compat))
+		if (get_compat_msghdr(&msg_sys, msg_compat))
 			return -EFAULT;
 	} else
 		if (copy_from_user(&msg_sys,msg,sizeof(struct msghdr)))
@@ -1708,15 +1708,9 @@
 	err = __put_user(msg_sys.msg_flags, COMPAT_FLAGS(msg));
 	if (err)
 		goto out_freeiov;
-	if (MSG_CMSG_COMPAT & flags) {
-		unsigned long ucmsg_ptr;
-		compat_size_t uclen;
-		if((unsigned long) msg_sys.msg_control != cmsg_ptr)
-			cmsg_compat_recvmsg_fixup(&msg_sys, cmsg_ptr);
-		ucmsg_ptr = ((unsigned long)msg_sys.msg_control);
-		uclen = (compat_size_t) (ucmsg_ptr - cmsg_ptr);
-		err = __put_user(uclen, &msg_compat->msg_controllen);
-	} else
+	if (MSG_CMSG_COMPAT & flags)
+		err = put_compat_msg_controllen(&msg_sys, msg_compat, cmsg_ptr);
+	else
 		err = __put_user((unsigned long)msg_sys.msg_control-cmsg_ptr, 
 				 &msg->msg_controllen);
 	if (err)
