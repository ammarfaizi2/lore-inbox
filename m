Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSEELFG>; Sun, 5 May 2002 07:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSEELFF>; Sun, 5 May 2002 07:05:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37051 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293510AbSEELFD>;
	Sun, 5 May 2002 07:05:03 -0400
Date: Sun, 5 May 2002 21:04:37 +1000
From: Anton Blanchard <anton@samba.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yossi@ixiacom.com" <yossi@ixiacom.com>
Subject: Re: khttpd newbie problem
Message-ID: <20020505110437.GB12430@krispykreme>
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> That's an excellent suggestion.  It certainly seems that khttpd
> is no longer production quality (if it ever was), and tux is.
> 
> I'm on an embedded system, so if tux is much larger, I'll
> be annoyed; but the system does have 64 MB, so it's not *that*
> cramped.  And working is much better than crashing.

Here are two sets of patches, one for the tux userspace utilities
and one for the kernel - apply it after the tux patch. 

I'll push the relevant changes to Ingo and Paulus.

Anton


kernel patch:


diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/arch/ppc/kernel/misc.S linux-2.4_tux_work/arch/ppc/kernel/misc.S
--- linux-2.4_tux/arch/ppc/kernel/misc.S	Sun May  5 18:38:37 2002
+++ linux-2.4_tux_work/arch/ppc/kernel/misc.S	Sun May  5 18:02:20 2002
@@ -1162,6 +1162,30 @@
 	.long sys_mincore
 	.long sys_gettid
 	.long sys_tkill
+	.long sys_ni_syscall	/* sys_setxattr */
+	.long sys_ni_syscall	/* sys_lsetxattr */    /* 210 */
+	.long sys_ni_syscall	/* sys_fsetxattr */
+	.long sys_ni_syscall	/* sys_getxattr */
+	.long sys_ni_syscall	/* sys_lgetxattr */
+	.long sys_ni_syscall	/* sys_fgetxattr */
+	.long sys_ni_syscall	/* sys_listxattr */    /* 215 */
+	.long sys_ni_syscall	/* sys_llistxattr */
+	.long sys_ni_syscall	/* sys_flistxattr */
+	.long sys_ni_syscall	/* sys_removexattr */
+	.long sys_ni_syscall	/* sys_lremovexattr */
+	.long sys_ni_syscall	/* sys_fremovexattr */  /* 220 */
+	.long sys_ni_syscall	/* sys_futex */
+	.long sys_ni_syscall	/* sys_sched_setaffinity */
+	.long sys_ni_syscall	/* sys_sched_getaffinity */
+#ifdef CONFIG_TUX
+	.long __sys_tux
+#else
+# ifdef CONFIG_TUX_MODULE
+	.long sys_tux
+# else
+	.long sys_ni_syscall
+# endif
+#endif
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/include/asm-ppc/fcntl.h linux-2.4_tux_work/include/asm-ppc/fcntl.h
--- linux-2.4_tux/include/asm-ppc/fcntl.h	Sun May  5 18:38:55 2002
+++ linux-2.4_tux_work/include/asm-ppc/fcntl.h	Sun May  5 18:02:22 2002
@@ -23,6 +23,7 @@
 #define O_NOFOLLOW      0100000	/* don't follow links */
 #define O_LARGEFILE     0200000
 #define O_DIRECT	0400000	/* direct disk access hint */
+#define O_ATOMICLOOKUP 01000000	/* do atomic file lookup */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/include/asm-ppc/unistd.h linux-2.4_tux_work/include/asm-ppc/unistd.h
--- linux-2.4_tux/include/asm-ppc/unistd.h	Sun May  5 18:38:55 2002
+++ linux-2.4_tux_work/include/asm-ppc/unistd.h	Sun May  5 18:02:21 2002
@@ -216,6 +216,22 @@
 #define __NR_mincore		206
 #define __NR_gettid		207
 #define __NR_tkill		208
+#define __NR_setxattr		209
+#define __NR_lsetxattr		210
+#define __NR_fsetxattr		211
+#define __NR_getxattr		212
+#define __NR_lgetxattr		213
+#define __NR_fgetxattr		214
+#define __NR_listxattr		215
+#define __NR_llistxattr		216
+#define __NR_flistxattr		217
+#define __NR_removexattr	218
+#define __NR_lremovexattr	219
+#define __NR_fremovexattr	220
+#define __NR_futex		221
+#define __NR_sched_setaffinity  222
+#define __NR_sched_getaffinity  223
+#define __NR_tux		224
 
 #define __NR(n)	#n
 
diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/net/tux/accept.c linux-2.4_tux_work/net/tux/accept.c
--- linux-2.4_tux/net/tux/accept.c	Sun May  5 17:56:44 2002
+++ linux-2.4_tux_work/net/tux/accept.c	Sun May  5 18:02:21 2002
@@ -64,7 +64,13 @@
 #define IP(n) ((unsigned char *)&addr)[n]
 	err = sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
 	if (err < 0) {
-		printk(KERN_ERR "TUX: error %d binding socket. This means that probably some other process is (or was a short time ago) using addr %s://%d.%d.%d.%d:%d.\n", err, proto->name, IP(3), IP(2), IP(1), IP(0), port);
+		printk(KERN_ERR "TUX: error %d binding socket. This means that probably some other process is (or was a short time ago) using addr %s://%d.%d.%d.%d:%d.\n", err, proto->name,
+#ifdef __BIG_ENDIAN
+			IP(0), IP(1), IP(2), IP(3), 
+#else
+			IP(3), IP(2), IP(1), IP(0), 
+#endif
+			port);
 		goto err;
 	}
 
@@ -87,7 +93,13 @@
 	}
 
 	printk(KERN_NOTICE "TUX: thread %d listens on %s://%d.%d.%d.%d:%d.\n",
-		nr, proto->name, IP(3), IP(2), IP(1), IP(0), port);
+		nr, proto->name, 
+#ifdef __BIG_ENDIAN
+		IP(0), IP(1), IP(2), IP(3), 
+#else
+		IP(3), IP(2), IP(1), IP(0), 
+#endif
+		port);
 	return sock;
 
 err:
diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/net/tux/proc.c linux-2.4_tux_work/net/tux/proc.c
--- linux-2.4_tux/net/tux/proc.c	Sun May  5 17:56:44 2002
+++ linux-2.4_tux_work/net/tux/proc.c	Sun May  5 18:02:21 2002
@@ -1005,7 +1005,12 @@
 #define IP(n) ((unsigned char *)&listen->ip)[n]
 
 	return sprintf (page, "%s://%u.%u.%u.%u:%hu\n", listen->proto->name,
-		IP(3), IP(2), IP(1), IP(0), listen->port);
+#ifdef __BIG_ENDIAN
+		IP(0), IP(1), IP(2), IP(3), 
+#else
+		IP(3), IP(2), IP(1), IP(0), 
+#endif
+		listen->port);
 }
 
 static int listen_write_proc (struct file *file, const char *buffer,
diff -ru --exclude-from=/home/anton/ppc64/exclude linux-2.4_tux/net/tux/proto_ftp.c linux-2.4_tux_work/net/tux/proto_ftp.c
--- linux-2.4_tux/net/tux/proto_ftp.c	Sun May  5 17:56:44 2002
+++ linux-2.4_tux_work/net/tux/proto_ftp.c	Sun May  5 18:02:21 2002
@@ -602,8 +602,10 @@
 	}
 #if CONFIG_TUX_DEBUG
 	req->bytes_expected = 0;
+#ifndef __powerpc__
 	if (tux_TDprintk)
 		show_stack(NULL);
+#endif
 #endif
 	req->in_file.f_pos = 0;
 	TDprintk("zapping, data sock state: %d (err: %d, urg: %d)\n",


tux userspace patch:


diff -ru tux-2.2.5/tux.c tux-2.2.5_work/tux.c
--- tux-2.2.5/tux.c	Fri Feb  8 04:27:43 2002
+++ tux-2.2.5_work/tux.c	Sun May  5 17:22:52 2002
@@ -33,7 +33,13 @@
 }
 
 #else
+
+#ifdef __powerpc__
+#define __NR_tux 224
+#else
 #define __NR_tux 222
+#endif
+
 _syscall2 (int, tux, unsigned int, action, user_req_t *, req)
 #endif
 
diff -ru tux-2.2.5/tux2w3c.c tux-2.2.5_work/tux2w3c.c
--- tux-2.2.5/tux2w3c.c	Wed Feb 20 21:30:55 2002
+++ tux-2.2.5_work/tux2w3c.c	Sat Apr  6 11:16:04 2002
@@ -35,6 +35,23 @@
 #ifdef __ia64__
 #define O_LARGEFILE    0100000
 #endif
+
+#ifdef __powerpc__
+#define O_LARGEFILE 0200000
+#endif
+
+#ifdef _BIG_ENDIAN
+#define LOG_ID1 0x1111beef
+#define LOG_ID2 0x2222beef
+#define LOG_ID3 0x1112beef
+#define LOG_ID4 0x2223beef
+#else
+#define LOG_ID1 0xefbe1111
+#define LOG_ID2 0xefbe2222
+#define LOG_ID3 0xefbe1211
+#define LOG_ID4 0xefbe2322
+#endif
+
 typedef struct standard_tux_record {
 	__u32 ip_addr;
 	__u32 time;
@@ -147,14 +164,14 @@
 		if (c == EOF)
 			break;
 		id = (id << 8) | c;
-		if ((id != 0xefbe1111) && (id != 0xefbe2222) &&
-				(id != 0xefbe1211) && (id != 0xefbe2322))
+		if ((id != LOG_ID1) && (id != LOG_ID2) &&
+				(id != LOG_ID3) && (id != LOG_ID4))
 			continue;
 		extended_rec = 0;
-		if ((id == 0xefbe2222) || (id == 0xefbe2322))
+		if ((id == LOG_ID2) || (id == LOG_ID4))
 			extended_rec = 1;
 		referer_log = 0;
-		if ((id == 0xefbe2322) || (id == 0xefbe1211))
+		if ((id == LOG_ID4) || (id == LOG_ID3))
 			referer_log = 1;
 		if (!extended_rec) {
 			if (my_read(file, &std_rec, sizeof(std_rec)) != sizeof(std_rec))
diff -ru tux-2.2.5/tuxmodule.h tux-2.2.5_work/tuxmodule.h
--- tux-2.2.5/tuxmodule.h	Wed Jan  9 07:24:53 2002
+++ tux-2.2.5_work/tuxmodule.h	Sat Apr  6 11:12:29 2002
@@ -108,6 +108,8 @@
 	exit(-1);							\
 } while (0)
 
+#ifdef __i386__
+
 #define LOCK_PREFIX "lock ; "
 
 #define barrier() __asm__ __volatile__("": : :"memory")
@@ -117,17 +119,66 @@
 extern __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
 	int oldbit;
-#if __i386__
+
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %2,%1\n\tsbbl %0,%0"
 		:"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr));
+	return oldbit;
+}
+
+extern __inline__ void TUXAPI_down (int *sem)
+{
+	while (test_and_set_bit(0, sem))
+		barrier();
+}
+
+extern __inline__ void TUXAPI_up (int *sem)
+{
+	*((volatile int *)sem) = 0;
+}
+
+#elif defined(__powerpc__)
+
+extern __inline__ void TUXAPI_down (int *sem)
+{
+	unsigned int tmp;
+
+	__asm__ __volatile__(
+	"b		2f\n\
+1:	lwzx		%0,0,%1\n\
+	cmpwi		0,%0,0\n\
+	bne+		1b\n\
+2:	lwarx		%0,0,%1\n\
+	cmpwi		0,%0,0\n\
+	bne-		1b\n\
+	stwcx.		%2,0,%1\n\
+	bne-		2b\n\
+	isync"
+	: "=&r"(tmp)
+	: "r"((volatile int *)sem), "r"(1)
+	: "cr0", "memory");
+}
+
+extern __inline__ void TUXAPI_up (int *sem)
+{
+	__asm__ __volatile__("lwsync": : :"memory");
+	*((volatile int *)sem) = 0;
+}
+
 #else
+
+#warning Using generic TUXAPI locks - not SMP safe
+
+extern __inline__ int test_and_set_bit(int nr, volatile void * addr)
+{
+	int oldbit;
 	unsigned long *foo;
+
 	foo = addr;
 	oldbit = (*foo >> nr) & 1;
 	*foo = *foo | (1<<nr);
-#endif
+
 	return oldbit;
 }
 
@@ -141,6 +192,8 @@
 {
 	*((volatile int *)sem) = 0;
 }
+
+#endif
 
 #define TUX_DEBUG 0
 
