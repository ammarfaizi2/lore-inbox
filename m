Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319060AbSHMWMC>; Tue, 13 Aug 2002 18:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319064AbSHMWMC>; Tue, 13 Aug 2002 18:12:02 -0400
Received: from dp.samba.org ([66.70.73.150]:6629 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319060AbSHMWL6>;
	Tue, 13 Aug 2002 18:11:58 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.33902.745399.721518@argo.ozlabs.ibm.com>
Date: Wed, 14 Aug 2002 08:13:02 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] add FP exception mode prctl
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch that adds a prctl so that processes can set their
floating-point exception mode on PPC and on PPC64.  We need this
because the FP exception mode is controlled by bits in the machine
state register, which can only be accessed by the kernel, and because
the exception mode setting interacts with the lazy FPU save/restore
that the kernel does.

Would you mind applying this to your tree?

Also, how about taking the generic RTC patches that Tom Rini has
posted a few times now?

Thanks,
Paul.


diff -urN linux-2.5/include/linux/prctl.h pmac-2.5/include/linux/prctl.h
--- linux-2.5/include/linux/prctl.h	Thu Apr 18 10:38:54 2002
+++ pmac-2.5/include/linux/prctl.h	Fri Aug  2 10:34:04 2002
@@ -26,4 +26,12 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get/set floating-point exception mode (if meaningful) */
+#define PR_GET_FPEXC	11
+#define PR_SET_FPEXC	12
+# define PR_FP_EXC_DISABLED	0	/* FP exceptions disabled */
+# define PR_FP_EXC_NONRECOV	1	/* async non-recoverable exc. mode */
+# define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
+# define PR_FP_EXC_PRECISE	3	/* precise exception mode */
+
 #endif /* _LINUX_PRCTL_H */
diff -urN linux-2.5/kernel/sys.c pmac-2.5/kernel/sys.c
--- linux-2.5/kernel/sys.c	Fri Aug  2 07:48:46 2002
+++ pmac-2.5/kernel/sys.c	Fri Aug  2 16:25:32 2002
@@ -37,6 +37,12 @@
 #ifndef GET_FPEMU_CTL
 # define GET_FPEMU_CTL(a,b)	(-EINVAL)
 #endif
+#ifndef SET_FPEXC_CTL
+# define SET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
+#ifndef GET_FPEXC_CTL
+# define GET_FPEXC_CTL(a,b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -1283,6 +1289,13 @@
 		case PR_GET_FPEMU:
 			error = GET_FPEMU_CTL(current, arg2);
 			break;
+		case PR_SET_FPEXC:
+			error = SET_FPEXC_CTL(current, arg2);
+			break;
+		case PR_GET_FPEXC:
+			error = GET_FPEXC_CTL(current, arg2);
+			break;
+
 
 		case PR_GET_KEEPCAPS:
 			if (current->keep_capabilities)
