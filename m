Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271458AbRHPEk0>; Thu, 16 Aug 2001 00:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271459AbRHPEkS>; Thu, 16 Aug 2001 00:40:18 -0400
Received: from zero.tech9.net ([209.61.188.187]:4619 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S271458AbRHPEkA>;
	Thu, 16 Aug 2001 00:40:00 -0400
Subject: [PATCH] 2.4.9-pre4: Optionally let Net Devices feed Entropy (1/2)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <997936615.921.22.camel@phantasy>
In-Reply-To: <997936615.921.22.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 00:40:31 -0400
Message-Id: <997936843.921.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

against 2.4.9-pre4, patch #1 of 2 (required: adds the new define
for all architectures, configure support, etc.) see previous email.

diff -urN linux-2.4.9-pre4/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.9-pre4/Documentation/Configure.help	Wed Aug 15 23:12:28 2001
+++ linux/Documentation/Configure.help	Wed Aug 15 23:19:52 2001
@@ -7728,6 +7728,19 @@
 
   If you don't know what to use this for, you don't need it.
 
+Allow Net Devices to contribute to /dev/random
+CONFIG_NET_RANDOM
+  If you say Y here, network device interrupts will contribute to the
+  kernel entropy pool at /dev/random. Normally, block devices and
+  some other devices (keyboard, mouse) add to the pool. Some people,
+  however, feel that network devices should not contribute to /dev/random
+  because an external attacker could manipulate incoming packets in a
+  manner to force the pool into a determinable state. Note this is
+  completely theoretical.
+
+  If you don't mind the risk or are using a headless system and are in
+  need of more entropy, say Y.
+
 Ethertap network tap (OBSOLETE)
 CONFIG_ETHERTAP
   If you say Y here (and have said Y to "Kernel/User network link
diff -urN linux-2.4.9-pre4/drivers/net/Config.in linux/drivers/net/Config.in
--- linux-2.4.9-pre4/drivers/net/Config.in	Wed Aug 15 23:09:39 2001
+++ linux/drivers/net/Config.in	Wed Aug 15 23:19:52 2001
@@ -9,6 +9,7 @@
 tristate 'Bonding driver support' CONFIG_BONDING
 tristate 'EQL (serial line load balancing) support' CONFIG_EQUALIZER
 tristate 'Universal TUN/TAP device driver support' CONFIG_TUN
+bool 'Allow Net Devices to contribute to /dev/random' CONFIG_NET_RANDOM
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    if [ "$CONFIG_NETLINK" = "y" ]; then
       tristate 'Ethertap network tap (OBSOLETE)' CONFIG_ETHERTAP
diff -urN linux-2.4.9-pre4/include/asm-alpha/signal.h linux/include/asm-alpha/signal.h
--- linux-2.4.9-pre4/include/asm-alpha/signal.h	Wed Aug 15 23:09:20 2001
+++ linux/include/asm-alpha/signal.h	Wed Aug 15 23:19:52 2001
@@ -121,8 +121,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x40000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          1	/* for blocking signals */
 #define SIG_UNBLOCK        2	/* for unblocking signals */
 #define SIG_SETMASK        3	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-arm/signal.h linux/include/asm-arm/signal.h
--- linux-2.4.9-pre4/include/asm-arm/signal.h	Wed Aug 15 23:09:28 2001
+++ linux/include/asm-arm/signal.h	Wed Aug 15 23:19:52 2001
@@ -124,8 +124,20 @@
 #define SA_SAMPLE_RANDOM	0x10000000
 #define SA_IRQNOMASK		0x08000000
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-cris/signal.h linux/include/asm-cris/signal.h
--- linux-2.4.9-pre4/include/asm-cris/signal.h	Wed Aug 15 23:09:37 2001
+++ linux/include/asm-cris/signal.h	Wed Aug 15 23:19:52 2001
@@ -120,8 +120,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-i386/signal.h linux/include/asm-i386/signal.h
--- linux-2.4.9-pre4/include/asm-i386/signal.h	Wed Aug 15 23:09:17 2001
+++ linux/include/asm-i386/signal.h	Wed Aug 15 23:19:52 2001
@@ -119,8 +119,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-ia64/signal.h linux/include/asm-ia64/signal.h
--- linux-2.4.9-pre4/include/asm-ia64/signal.h	Wed Aug 15 23:09:36 2001
+++ linux/include/asm-ia64/signal.h	Wed Aug 15 23:19:52 2001
@@ -106,6 +106,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.4.9-pre4/include/asm-m68k/signal.h linux/include/asm-m68k/signal.h
--- linux-2.4.9-pre4/include/asm-m68k/signal.h	Wed Aug 15 23:09:21 2001
+++ linux/include/asm-m68k/signal.h	Wed Aug 15 23:19:52 2001
@@ -116,8 +116,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-mips/signal.h linux/include/asm-mips/signal.h
--- linux-2.4.9-pre4/include/asm-mips/signal.h	Wed Aug 15 23:09:18 2001
+++ linux/include/asm-mips/signal.h	Wed Aug 15 23:19:52 2001
@@ -111,6 +111,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x02000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK	1	/* for blocking signals */
diff -urN linux-2.4.9-pre4/include/asm-mips64/signal.h linux/include/asm-mips64/signal.h
--- linux-2.4.9-pre4/include/asm-mips64/signal.h	Wed Aug 15 23:09:37 2001
+++ linux/include/asm-mips64/signal.h	Wed Aug 15 23:19:53 2001
@@ -112,6 +112,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x02000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK	1	/* for blocking signals */
diff -urN linux-2.4.9-pre4/include/asm-parisc/signal.h linux/include/asm-parisc/signal.h
--- linux-2.4.9-pre4/include/asm-parisc/signal.h	Wed Aug 15 23:09:37 2001
+++ linux/include/asm-parisc/signal.h	Wed Aug 15 23:19:53 2001
@@ -100,6 +100,17 @@
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
 
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
+#endif
+
 #endif /* __KERNEL__ */
 
 #define SIG_BLOCK          0	/* for blocking signals */
diff -urN linux-2.4.9-pre4/include/asm-ppc/signal.h linux/include/asm-ppc/signal.h
--- linux-2.4.9-pre4/include/asm-ppc/signal.h	Wed Aug 15 23:09:25 2001
+++ linux/include/asm-ppc/signal.h	Wed Aug 15 23:19:53 2001
@@ -114,8 +114,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-s390/signal.h linux/include/asm-s390/signal.h
--- linux-2.4.9-pre4/include/asm-s390/signal.h	Wed Aug 15 23:09:37 2001
+++ linux/include/asm-s390/signal.h	Wed Aug 15 23:20:04 2001
@@ -127,8 +127,20 @@
 #define SA_PROBE                SA_ONESHOT
 #define SA_SAMPLE_RANDOM        SA_RESTART
 #define SA_SHIRQ                0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0    /* for blocking signals */
 #define SIG_UNBLOCK        1    /* for unblocking signals */
 #define SIG_SETMASK        2    /* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-s390x/signal.h linux/include/asm-s390x/signal.h
--- linux-2.4.9-pre4/include/asm-s390x/signal.h	Wed Aug 15 23:09:37 2001
+++ linux/include/asm-s390x/signal.h	Wed Aug 15 23:20:04 2001
@@ -127,8 +127,20 @@
 #define SA_PROBE                SA_ONESHOT
 #define SA_SAMPLE_RANDOM        SA_RESTART
 #define SA_SHIRQ                0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0    /* for blocking signals */
 #define SIG_UNBLOCK        1    /* for unblocking signals */
 #define SIG_SETMASK        2    /* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-sh/signal.h linux/include/asm-sh/signal.h
--- linux-2.4.9-pre4/include/asm-sh/signal.h	Wed Aug 15 23:09:29 2001
+++ linux/include/asm-sh/signal.h	Wed Aug 15 23:20:04 2001
@@ -107,8 +107,20 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 #define SIG_BLOCK          0	/* for blocking signals */
 #define SIG_UNBLOCK        1	/* for unblocking signals */
 #define SIG_SETMASK        2	/* for setting the signal mask */
diff -urN linux-2.4.9-pre4/include/asm-sparc/signal.h linux/include/asm-sparc/signal.h
--- linux-2.4.9-pre4/include/asm-sparc/signal.h	Wed Aug 15 23:09:23 2001
+++ linux/include/asm-sparc/signal.h	Wed Aug 15 23:20:04 2001
@@ -176,8 +176,20 @@
 #define SA_PROBE SA_ONESHOT
 #define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, int, struct sigcontext *, char *);
diff -urN linux-2.4.9-pre4/include/asm-sparc64/signal.h linux/include/asm-sparc64/signal.h
--- linux-2.4.9-pre4/include/asm-sparc64/signal.h	Wed Aug 15 23:09:27 2001
+++ linux/include/asm-sparc64/signal.h	Wed Aug 15 23:20:04 2001
@@ -192,8 +192,20 @@
 #define SA_PROBE SA_ONESHOT
 #define SA_SAMPLE_RANDOM SA_RESTART
 #define SA_STATIC_ALLOC		0x80
+
+/*
+ * Net Devices can use SA_SAMPLE_NET_RANDOM and thus only
+ * contribute to the kernel entropy pool if users want that
+ * at compile time.
+ */
+#ifdef CONFIG_NET_RANDOM
+#define SA_SAMPLE_NET_RANDOM	SA_SAMPLE_RANDOM
+#else
+#define SA_SAMPLE_NET_RANDOM	0
 #endif
 
+#endif /* __KERNEL__ */
+
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, struct sigcontext *);

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

