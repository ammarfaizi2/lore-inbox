Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUHSCMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUHSCMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHSCMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:12:44 -0400
Received: from fmr05.intel.com ([134.134.136.6]:31718 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267992AbUHSCMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:12:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: PATCH futex on fusyn 2/2: fusyn-2.3.1-01-futex-switch.patch
Date: Wed, 18 Aug 2004 19:11:46 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F9424@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH futex on fusyn 2/2: fusyn-2.3.1-01-futex-switch.patch
Thread-Index: AcR67KSkq2pUMRq9QeihuSVc82SjGgKme+MwAAK3kwAAABLPEA==
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, <robustmutexes@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 19 Aug 2004 02:11:55.0364 (UTC) FILETIME=[E64AF240:01C48591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple futex-on-fusyn-or-not sysctl switch. Default to pure
futexes. 

 include/linux/sysctl.h |    1 
 kernel/futex.c         |   96 ++++++++++++++++++++++++++++++++++++++-----------
 kernel/sysctl.c        |   11 +++++
 3 files changed, 88 insertions(+), 20 deletions(-)

diff -u -r1.1.1.1.2.5 sysctl.h
--- linux/include/linux/sysctl.h	27 Jul 2004 02:20:54 -0000
+++ linux/include/linux/sysctl.h	17 Aug 2004 22:40:18 -0000
@@ -133,6 +133,7 @@
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_FUTEX_USES_FUSYN=66, /* int: futexes use fusyn layer */
 };
 
 
diff -u -r1.1.1.1.2.8 futex.c
--- linux/kernel/futex.c	27 Jul 2004 02:20:59 -0000
+++ linux/kernel/futex.c	19 Aug 2004 00:35:04 -0000
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/time.h>
 
 #define FUTEX_HASHBITS 8
 
@@ -658,30 +659,85 @@
 	return ret;
 }
 
+
+/* Simple switch for making futexes use fusyns--toggle with sysclt */
+int futex_uses_fusyn = 0;
+
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
 		unsigned long uaddr2, int val2, int val3)
 {
 	int ret;
-
-	switch (op) {
-	case FUTEX_WAIT:
-		ret = futex_wait(uaddr, val, timeout);
-		break;
-	case FUTEX_WAKE:
-		ret = futex_wake(uaddr, val);
-		break;
-	case FUTEX_FD:
-		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
-		ret = futex_fd(uaddr, val);
-		break;
-	case FUTEX_REQUEUE:
-		ret = futex_requeue(uaddr, uaddr2, val, val2, NULL);
-		break;
-	case FUTEX_CMP_REQUEUE:
-		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
-		break;
-	default:
-		ret = -ENOSYS;
+	
+	if (futex_uses_fusyn == 0) {
+		/* Use real futexes */
+		switch (op) {
+		case FUTEX_WAIT:
+			ret = futex_wait(uaddr, val, timeout);
+			break;
+		case FUTEX_WAKE:
+			ret = futex_wake(uaddr, val);
+			break;
+		case FUTEX_FD:
+			/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
+			ret = futex_fd(uaddr, val);
+			break;
+		case FUTEX_REQUEUE:
+			ret = futex_requeue(uaddr, uaddr2, val, val2, NULL);
+			break;
+		case FUTEX_CMP_REQUEUE:
+			ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
+	}
+	else {
+		/* Redirect into fuqueues (behaving as futexes) */
+		struct timeout timeout_ext = {
+			.flags = TIMEOUT_USE_JIFFIES | TIMEOUT_RELATIVE,
+		};
+		timeout_ext.jiffies = timeout;
+		extern asmlinkage int sys_ufuqueue_wake (
+			volatile unsigned __user *, size_t, int);
+		extern fastcall int ufuqueue_wait (
+			volatile unsigned __user *_vfuqueue, unsigned val,
+			const struct timeout *timeout);
+		extern asmlinkage int sys_ufuqueue_requeue (
+			volatile unsigned __user *_vfuqueue1,
+			volatile unsigned __user *_vfuqueue0,
+			unsigned val0, size_t nr_wake, int do_cmp);
+
+		switch (op) {
+		case FUTEX_WAIT:
+			ret = ufuqueue_wait ((volatile unsigned __user *) uaddr,
+					     (unsigned) val, &timeout_ext);
+			break;
+		case FUTEX_WAKE:
+			ret = sys_ufuqueue_wake ((volatile unsigned __user *) uaddr,
+						 (size_t) val, 0);
+			break;
+		case FUTEX_FD:
+			/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
+			// ret = futex_fd(uaddr, val);
+			ret = -ENOSYS;
+			break;
+		case FUTEX_REQUEUE:
+			//ret = futex_requeue(uaddr, uaddr2, val, val2, NULL);
+			WARN_ON (val2 != INT_MAX);
+			ret = sys_ufuqueue_requeue ((volatile unsigned __user *) uaddr2,
+						    (volatile unsigned __user *) uaddr,
+						    0, val, 0);
+			break;
+		case FUTEX_CMP_REQUEUE:
+			//ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
+			WARN_ON (val2 != INT_MAX);
+			ret = sys_ufuqueue_requeue ((volatile unsigned __user *) uaddr2,
+						    (volatile unsigned __user *) uaddr,
+						    val3, val, 1);
+			break;
+		default:
+			ret = -ENOSYS;
+		}
 	}
 	return ret;
 }
diff -u -r1.1.1.1.2.5 sysctl.c
--- linux/kernel/sysctl.c	27 Jul 2004 02:21:00 -0000
+++ linux/kernel/sysctl.c	17 Aug 2004 22:41:21 -0000
@@ -64,6 +64,7 @@
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern int futex_uses_fusyn;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -636,6 +637,16 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_FUSYN
+	{
+		.ctl_name	= KERN_FUTEX_USES_FUSYN,
+		.procname	= "futex_uses_fusyn",
+		.data		= &futex_uses_fusyn,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
