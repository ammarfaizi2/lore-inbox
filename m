Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUD0OyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUD0OyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUD0OyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:54:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264160AbUD0Ox2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:53:28 -0400
Date: Tue, 27 Apr 2004 11:54:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040427145424.GA10530@logos.cnet>
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <40875944.4060405@colorfullife.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 07:33:56AM +0200, Manfred Spraul wrote:
> Marcelo Tosatti wrote:
> 
> >I'm thinking about how to do the mqueue "kernel allocated memory" 
> >accounting, and I have a problem. A user can create an mqueue of given 
> >size via sys_mq_open()
> >using "msg_attr" structure (will be created in do_create). I can account 
> >for how much memory has been allocated, but I can't at "deaccount" at 
> >kfree() time (this memory is stored in inode->(mqueue_inode_info 
> >*)info->messages), because I dont know how big
> >it is (its user selectable via "msg_attr" structure). 
> > 
> >
> Why not? mqueue_delete_inode can look at info->attr.mq_maxmsg and 
> info->attr.mq_curmsg.

Hi, 

Here goes the latest signal/mqueue per-uid limits patch. It now does:

- Create per-user signal limits, remove global limit

- Create per-user message queue limits, accounting is 
  now done on memory-allocated (queue creation and message
  allocation). Note: it might be nice to move deaccounting
  inside free_msg().

I added an int to mqueue inode and to "struct msg_msg" (to save
the UID of inode creator, to guarantee deaccounting is done 
correctly if another UID deletes the entries (eg root)). I wonder
about cache locality. Has anyone cared enough to align the mqueue
structures? Dont think so... Does it impact performance?

Thanks Andrew, Manfred and Jakub for their comments.

Attached are "mqsend.c" and "mqrec.c", two simple programs (copied from
libmqueue) which I used for testing, in case anyone is interested.

Comments are welcome

diff -Nur --show-c-function a/linux-2.6.5/arch/i386/kernel/init_task.c linux-2.6.5/arch/i386/kernel/init_task.c
--- a/linux-2.6.5/arch/i386/kernel/init_task.c	2004-04-04 00:38:20.000000000 -0300
+++ linux-2.6.5/arch/i386/kernel/init_task.c	2004-04-27 08:32:46.000000000 -0300
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -Nur --show-c-function a/linux-2.6.5/include/asm-alpha/resource.h linux-2.6.5/include/asm-alpha/resource.h
--- a/linux-2.6.5/include/asm-alpha/resource.h	2004-04-04 00:36:17.000000000 -0300
+++ linux-2.6.5/include/asm-alpha/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_NPROC	8		/* max number of processes */
 #define RLIMIT_MEMLOCK	9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
@@ -41,6 +43,8 @@
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},                       /* RLIMIT_LOCKS */      \
+    {MAX_USER_SIGNALS, MAX_USER_SIGNALS},	/* RLIMIT_SIGPENDING */ \
+    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},	/* RLIMIT_MSGQUEUE */	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-arm/resource.h linux-2.6.5/include/asm-arm/resource.h
--- a/linux-2.6.5/include/asm-arm/resource.h	2004-04-04 00:38:10.000000000 -0300
+++ linux-2.6.5/include/asm-arm/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},  \
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-arm26/resource.h linux-2.6.5/include/asm-arm26/resource.h
--- a/linux-2.6.5/include/asm-arm26/resource.h	2004-04-04 00:36:14.000000000 -0300
+++ linux-2.6.5/include/asm-arm26/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS},  \
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-cris/resource.h linux-2.6.5/include/asm-cris/resource.h
--- a/linux-2.6.5/include/asm-cris/resource.h	2004-04-04 00:37:36.000000000 -0300
+++ linux-2.6.5/include/asm-cris/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,9 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },               \
         { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},	\
+
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-h8300/resource.h linux-2.6.5/include/asm-h8300/resource.h
--- a/linux-2.6.5/include/asm-h8300/resource.h	2004-04-04 00:36:16.000000000 -0300
+++ linux-2.6.5/include/asm-h8300/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,9 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},	\
+
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-i386/resource.h linux-2.6.5/include/asm-i386/resource.h
--- a/linux-2.6.5/include/asm-i386/resource.h	2004-04-04 00:36:24.000000000 -0300
+++ linux-2.6.5/include/asm-i386/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,11 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* max number of POSIX msg queues */
+
+#define RLIM_NLIMITS	13
 
-#define RLIM_NLIMITS	11
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +43,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+	{  MAX_USER_SIGNALS,  MAX_USER_SIGNALS },	\
+	{  MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-ia64/resource.h linux-2.6.5/include/asm-ia64/resource.h
--- a/linux-2.6.5/include/asm-ia64/resource.h	2004-04-04 00:37:39.000000000 -0300
+++ linux-2.6.5/include/asm-ia64/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -23,8 +23,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -47,6 +49,9 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS}, 		\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
+
 }
 
 # endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-m68k/resource.h linux-2.6.5/include/asm-m68k/resource.h
--- a/linux-2.6.5/include/asm-m68k/resource.h	2004-04-04 00:36:14.000000000 -0300
+++ linux-2.6.5/include/asm-m68k/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-mips/resource.h linux-2.6.5/include/asm-mips/resource.h
--- a/linux-2.6.5/include/asm-mips/resource.h	2004-04-04 00:38:06.000000000 -0300
+++ linux-2.6.5/include/asm-mips/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -1,4 +1,4 @@
-/*
+	/*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -23,8 +23,10 @@
 #define RLIMIT_NPROC 8			/* max number of processes */
 #define RLIMIT_MEMLOCK 9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS 11			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 13			/* Number of limit flavors.  */
 
 #ifdef __KERNEL__
 
@@ -54,6 +56,8 @@
 	{ 0,             0             },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS},		\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-parisc/resource.h linux-2.6.5/include/asm-parisc/resource.h
--- a/linux-2.6.5/include/asm-parisc/resource.h	2004-04-04 00:37:37.000000000 -0300
+++ linux-2.6.5/include/asm-parisc/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-ppc/resource.h linux-2.6.5/include/asm-ppc/resource.h
--- a/linux-2.6.5/include/asm-ppc/resource.h	2004-04-04 00:36:57.000000000 -0300
+++ linux-2.6.5/include/asm-ppc/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -12,8 +12,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -37,6 +39,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-ppc64/resource.h linux-2.6.5/include/asm-ppc64/resource.h
--- a/linux-2.6.5/include/asm-ppc64/resource.h	2004-04-04 00:37:37.000000000 -0300
+++ linux-2.6.5/include/asm-ppc64/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -21,8 +21,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -46,6 +48,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-s390/resource.h linux-2.6.5/include/asm-s390/resource.h
--- a/linux-2.6.5/include/asm-s390/resource.h	2004-04-04 00:36:55.000000000 -0300
+++ linux-2.6.5/include/asm-s390/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -24,7 +24,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
-  
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
+
 #define RLIM_NLIMITS	11
 
 /*
@@ -48,6 +50,9 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
+
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-sh/resource.h linux-2.6.5/include/asm-sh/resource.h
--- a/linux-2.6.5/include/asm-sh/resource.h	2004-04-04 00:37:36.000000000 -0300
+++ linux-2.6.5/include/asm-sh/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 #ifdef __KERNEL__
 
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+        { MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+        { MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-sparc/resource.h linux-2.6.5/include/asm-sparc/resource.h
--- a/linux-2.6.5/include/asm-sparc/resource.h	2004-04-04 00:36:18.000000000 -0300
+++ linux-2.6.5/include/asm-sparc/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -22,8 +22,10 @@
 #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
 #define RLIMIT_AS       9               /* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -45,6 +47,9 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
+    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
+    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
+
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-sparc64/resource.h linux-2.6.5/include/asm-sparc64/resource.h
--- a/linux-2.6.5/include/asm-sparc64/resource.h	2004-04-04 00:36:15.000000000 -0300
+++ linux-2.6.5/include/asm-sparc64/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -22,8 +22,10 @@
 #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
 #define RLIMIT_AS       9               /* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -44,6 +46,8 @@
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
+    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
+    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-v850/resource.h linux-2.6.5/include/asm-v850/resource.h
--- a/linux-2.6.5/include/asm-v850/resource.h	2004-04-04 00:36:16.000000000 -0300
+++ linux-2.6.5/include/asm-v850/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/asm-x86_64/resource.h linux-2.6.5/include/asm-x86_64/resource.h
--- a/linux-2.6.5/include/asm-x86_64/resource.h	2004-04-04 00:37:37.000000000 -0300
+++ linux-2.6.5/include/asm-x86_64/resource.h	2004-04-27 08:32:46.000000000 -0300
@@ -16,8 +16,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +42,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},   	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE}, 	\
 }
 
 #endif /* __KERNEL__ */
diff -Nur --show-c-function a/linux-2.6.5/include/linux/mqueue.h linux-2.6.5/include/linux/mqueue.h
--- a/linux-2.6.5/include/linux/mqueue.h	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/include/linux/mqueue.h	2004-04-27 11:12:38.000000000 -0300
@@ -19,6 +19,10 @@
 #define _LINUX_MQUEUE_H
 
 #define MQ_PRIO_MAX 	32768
+#define DFLT_QUEUESMAX	256
+
+/* per-uid limit of kernel memory used by mqueue, in bytes */
+#define MAX_USER_MSGQUEUE	16384
 
 typedef int mqd_t;
 
diff -Nur --show-c-function a/linux-2.6.5/include/linux/msg.h linux-2.6.5/include/linux/msg.h
--- a/linux-2.6.5/include/linux/msg.h	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/include/linux/msg.h	2004-04-27 08:57:32.000000000 -0300
@@ -71,6 +71,7 @@ struct msg_msg {
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
 	void *security;
+	int sender;	/* who sent this message */
 	/* the actual message follows immediately */
 };
 
diff -Nur --show-c-function a/linux-2.6.5/include/linux/sched.h linux-2.6.5/include/linux/sched.h
--- a/linux-2.6.5/include/linux/sched.h	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/include/linux/sched.h	2004-04-27 08:32:46.000000000 -0300
@@ -278,6 +278,7 @@ struct signal_struct {
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+	atomic_t sigpending;
 };
 
 /*
@@ -307,6 +308,9 @@ struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals does this user have? */
+	/* protected by mq_lock 	*/
+	int msg_queues; 	/* How many message queues does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -Nur --show-c-function a/linux-2.6.5/include/linux/signal.h linux-2.6.5/include/linux/signal.h
--- a/linux-2.6.5/include/linux/signal.h	2004-04-04 00:36:26.000000000 -0300
+++ linux-2.6.5/include/linux/signal.h	2004-04-27 08:32:46.000000000 -0300
@@ -7,6 +7,10 @@
 #include <asm/siginfo.h>
 
 #ifdef __KERNEL__
+
+#define MAX_QUEUED_SIGNALS	4096
+#define MAX_USER_SIGNALS	(MAX_QUEUED_SIGNALS/4)
+
 /*
  * Real Time signals may be queued.
  */
diff -Nur --show-c-function a/linux-2.6.5/ipc/mqueue.c linux-2.6.5/ipc/mqueue.c
--- a/linux-2.6.5/ipc/mqueue.c	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/ipc/mqueue.c	2004-04-27 11:02:28.000000000 -0300
@@ -43,7 +43,6 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
 #define DFLT_MSGMAX 	40	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
@@ -60,6 +59,7 @@ struct mqueue_inode_info {
 	struct msg_msg **messages;
 
 	pid_t notify_owner;	/* != 0 means notification registered */
+	uid_t creator_id;	/* UID of creator, for resource accouting */
 	struct sigevent notify;
 	struct file *notify_filp;
 
@@ -110,6 +110,7 @@ static struct inode *mqueue_get_inode(st
 
 		if (S_ISREG(mode)) {
 			struct mqueue_inode_info *info;
+			struct task_struct *p = current;
 
 			inode->i_fop = &mqueue_file_operations;
 			inode->i_size = FILENT_SIZE;
@@ -124,7 +125,19 @@ static struct inode *mqueue_get_inode(st
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
 			info->attr.mq_msgsize = DFLT_MSGSIZEMAX;
+			
+	  		if (p->user->msg_queues + 
+				(DFLT_MSGMAX * sizeof(struct msg_msg *)) >=
+					p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
+				return NULL;
+
 			info->messages = kmalloc(DFLT_MSGMAX * sizeof(struct msg_msg *), GFP_KERNEL);
+			info->creator_id = current->uid;
+
+			spin_lock(&mq_lock);
+			p->user->msg_queues += (DFLT_MSGMAX * sizeof(struct msg_msg *));
+			spin_unlock(&mq_lock);
+
 			if (!info->messages) {
 				make_bad_inode(inode);
 				iput(inode);
@@ -197,22 +210,32 @@ static void mqueue_destroy_inode(struct 
 static void mqueue_delete_inode(struct inode *inode)
 {
 	struct mqueue_inode_info *info;
+	struct user_struct *user;
 	int i;
 
 	if (S_ISDIR(inode->i_mode)) {
 		clear_inode(inode);
 		return;
 	}
+
 	info = MQUEUE_I(inode);
+
+	user = find_user(info->creator_id);
+	if (!user)
+		BUG();
 	spin_lock(&info->lock);
-	for (i = 0; i < info->attr.mq_curmsgs; i++)
+	for (i = 0; i < info->attr.mq_curmsgs; i++) {
+		user->msg_queues -= info->messages[i]->m_ts;
 		free_msg(info->messages[i]);
+	}
 	kfree(info->messages);
 	spin_unlock(&info->lock);
 
 	clear_inode(inode);
 
 	spin_lock(&mq_lock);
+	user->msg_queues -= (info->attr.mq_maxmsg * 
+					sizeof(struct msg_msg *));
 	queues_count--;
 	spin_unlock(&mq_lock);
 }
@@ -431,6 +454,9 @@ static void msg_insert(struct msg_msg *p
 
 static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
 {
+	struct user_struct *user;
+	user = find_user (info->messages[info->attr.mq_curmsgs-1]->sender);
+	user->msg_queues -= info->messages[info->attr.mq_curmsgs-1]->m_ts;
 	info->qsize -= info->messages[--info->attr.mq_curmsgs]->m_ts;
 	return info->messages[info->attr.mq_curmsgs];
 }
@@ -594,6 +620,7 @@ static struct file *do_create(struct den
 	struct file *filp;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
+	struct task_struct *p = current;
 	struct msg_msg **msgs = NULL;
 	struct mq_attr attr;
 	int ret;
@@ -612,15 +639,24 @@ static struct file *do_create(struct den
 					attr.mq_msgsize > msgsize_max)
 				return ERR_PTR(-EINVAL);
 		}
+	  	if(p->user->msg_queues + (attr.mq_maxmsg * sizeof(struct msg_msg *))
+			  >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
+			return ERR_PTR(-ENOMEM);
+
 		msgs = kmalloc(attr.mq_maxmsg * sizeof(*msgs), GFP_KERNEL);
 		if (!msgs)
 			return ERR_PTR(-ENOMEM);
+
+		spin_lock(&mq_lock);
+		current->user->msg_queues += (attr.mq_maxmsg * sizeof(*msgs));
+		spin_unlock(&mq_lock);
 	} else {
 		msgs = NULL;
 	}
 
 	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
 	if (ret) {
+		/* kfree(msgs): msgs can be NULL -mt */
 		kfree(msgs);
 		return ERR_PTR(ret);
 	}
@@ -631,8 +667,15 @@ static struct file *do_create(struct den
 	if (msgs) {
 		info->attr.mq_maxmsg = attr.mq_maxmsg;
 		info->attr.mq_msgsize = attr.mq_msgsize;
+		spin_lock(&mq_lock);
+		current->user->msg_queues -= (info->attr.mq_maxmsg 
+						* sizeof (struct msg_msg *));
+		if (current->user->msg_queues < 0)
+			current->user->msg_queues = 0;	
+		spin_unlock(&mq_lock);
 		kfree(info->messages);
 		info->messages = msgs;
+		info->creator_id = current->uid;
 	}
 
 	filp = dentry_open(dentry, mqueue_mnt, oflag);
@@ -849,6 +892,10 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 		goto out_fput;
 	}
 
+	if(current->user->msg_queues + msg_len
+		  >= current->rlim[RLIMIT_MSGQUEUE].rlim_cur)
+		goto out_fput;
+
 	/* First try to allocate memory, before doing anything with
 	 * existing queues. */
 	msg_ptr = load_msg((void *)u_msg_ptr, msg_len);
@@ -858,6 +905,13 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 	}
 	msg_ptr->m_ts = msg_len;
 	msg_ptr->m_type = msg_prio;
+	msg_ptr->sender = current->uid;
+
+	spin_lock(&mq_lock);
+
+	current->user->msg_queues += msg_len;
+
+	spin_unlock(&mq_lock);
 
 	spin_lock(&info->lock);
 
@@ -870,8 +924,12 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 			wait.msg = (void *) msg_ptr;
 			wait.state = STATE_NONE;
 			ret = wq_sleep(info, SEND, timeout, &wait);
-			if (ret < 0)
+			if (ret < 0) {
 				free_msg(msg_ptr);
+				spin_lock(&mq_lock);
+				current->user->msg_queues -= msg_len;
+				spin_unlock(&mq_lock);
+			}
 		}
 	} else {
 		receiver = wq_get_first_waiter(info, RECV);
diff -Nur --show-c-function a/linux-2.6.5/kernel/signal.c linux-2.6.5/kernel/signal.c
--- a/linux-2.6.5/kernel/signal.c	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/kernel/signal.c	2004-04-27 11:05:08.000000000 -0300
@@ -31,8 +31,7 @@
 
 static kmem_cache_t *sigqueue_cachep;
 
-atomic_t nr_queued_signals;
-int max_queued_signals = 1024;
+int max_queued_signals = MAX_QUEUED_SIGNALS;
 
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
@@ -268,10 +267,11 @@ struct sigqueue *__sigqueue_alloc(void)
 {
 	struct sigqueue *q = 0;
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&current->user->signal_pending) <= 
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
-		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = 0;
@@ -284,7 +284,14 @@ static inline void __sigqueue_free(struc
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	kmem_cache_free(sigqueue_cachep, q);
-	atomic_dec(&nr_queued_signals);
+
+	/* 
+	 * Decrease per-user sigpending count. Check 
+	 * for negative value, we might have done setuid()
+	 * with pending signals.
+	 */
+	if (atomic_read(&current->user->signal_pending) > 0)
+		atomic_dec(&current->user->signal_pending);
 }
 
 static void flush_sigqueue(struct sigpending *queue)
@@ -700,11 +707,13 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&current->user->signal_pending) <=
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur) 
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
-		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
+
 		q->flags = 0;
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
diff -Nur --show-c-function a/linux-2.6.5/kernel/sysctl.c linux-2.6.5/kernel/sysctl.c
--- a/linux-2.6.5/kernel/sysctl.c	2004-04-27 09:53:24.000000000 -0300
+++ linux-2.6.5/kernel/sysctl.c	2004-04-27 11:05:48.000000000 -0300
@@ -53,7 +53,6 @@ extern int C_A_D;
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int max_threads;
-extern atomic_t nr_queued_signals;
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
@@ -419,14 +418,6 @@ static ctl_table kern_table[] = {
 	},
 #endif
 	{
-		.ctl_name	= KERN_RTSIGNR,
-		.procname	= "rtsig-nr",
-		.data		= &nr_queued_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
 		.ctl_name	= KERN_RTSIGMAX,
 		.procname	= "rtsig-max",
 		.data		= &max_queued_signals,
diff -Nur --show-c-function a/linux-2.6.5/kernel/user.c linux-2.6.5/kernel/user.c
--- a/linux-2.6.5/kernel/user.c	2004-04-04 00:36:56.000000000 -0300
+++ linux-2.6.5/kernel/user.c	2004-04-27 08:32:46.000000000 -0300
@@ -30,7 +30,9 @@ static spinlock_t uidhash_lock = SPIN_LO
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.signal_pending = ATOMIC_INIT(0),
+	.msg_queues = 0
 };
 
 /*
@@ -97,6 +99,9 @@ struct user_struct * alloc_uid(uid_t uid
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->signal_pending, 0);
+
+		new->msg_queues = 0;
 
 		/*
 		 * Before adding this, check whether we raced

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mqsend.c"


#include <sys/types.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <limits.h>
#include <stdarg.h> 
#include <errno.h>
#include <string.h>
#include <poll.h>
#include <asm/fcntl.h>

#define __NR_mq_open 277
#define __NR_mq_unlink 278
#define __NR_mq_timedsend 279
#define __NR_mq_timedreceive 280
#define __NR_mq_notify 281
#define __NR_mq_getsetattr 282

typedef int mdq_t;

struct mq_attr { 
	long mq_flags;
	long mq_maxmsg;
	long mq_msgsize;	
	long mq_curmsgs;
	long	__reserved[4];
};

static inline int __mq_open (const char *name, int oflag, mode_t mode, struct mq_attr *attr) 
{
	return syscall(__NR_mq_open, name, oflag, mode, attr);
}

static inline int __mq_timedsend(mdq_t mqdes, const char *msg_ptr, 
			size_t msglen, unsigned int msgprio,
			const struct timespec *abs_timeout) 
{ 
	return syscall( __NR_mq_timedsend, mqdes, msg_ptr, msglen, msgprio, abs_timeout);
}

static int mq_send(mdq_t des, const char *msgptr, size_t msglen, unsigned int msgprio) { 
	return __mq_timedsend(des, msgptr, msglen, msgprio, NULL);
}
mdq_t mq_open(const char *name, int oflag, ...)
{
	unsigned long mode;	
	struct mq_attr *attr;
	va_list	ap;

	va_start(ap, oflag);
	mode = va_arg(ap, unsigned long);
	attr = va_arg(ap, struct mq_attr *);
	va_end(ap);

	return __mq_open(name, oflag, mode, attr);

}

#define PRIO 1
#define QUEUE "/mnt/example_queue"

void main()  {

	mdq_t ds;
	char text[] = "Our message body!"; 

	ds = open(QUEUE, O_WRONLY|O_CREAT);
	
	if (ds == -1) {
		perror("Opening queue error\n");
		exit(1);
	}

	if (mq_send(ds, text, strlen(text), PRIO) == -1)
		perror("Sendong message error");
	else
		puts("Message sent to queue");

	return 0;
}


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mqrec.c"


#include <sys/types.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <stdio.h>
#include <limits.h>
#include <stdarg.h> 
#include <errno.h>
#include <string.h>
#include <poll.h>
#include <asm/fcntl.h>

#define __NR_mq_open 277
#define __NR_mq_unlink 278
#define __NR_mq_timedsend 279
#define __NR_mq_timedreceive 280
#define __NR_mq_notify 281
#define __NR_mq_getsetattr 282

typedef int mdq_t;

struct mq_attr { 
	long mq_flags;
	long mq_maxmsg;
	long mq_msgsize;	
	long mq_curmsgs;
	long	__reserved[4];
};

static inline int __mq_open (const char *name, int oflag, mode_t mode, struct mq_attr *attr) 
{
	return syscall(__NR_mq_open, name, oflag, mode, attr);
}

static inline int __mq_timedreceive(mdq_t des, char *msgptr, size_t msglen, 
			unsigned int *msgprio, const struct timespec *abs_timeout) 
{
	return syscall(__NR_mq_timedreceive, des, msgptr, msglen, msgprio, abs_timeout);
}

static inline int __mq_timedsend(mdq_t mqdes, const char *msg_ptr, 
			size_t msglen, unsigned int msgprio,
			const struct timespec *abs_timeout) 
{ 
	return(syscall, __NR_mq_timedsend, mqdes, msg_ptr, msglen, msgprio, abs_timeout);
}

static int mq_send(mdq_t des, const char *msgptr, size_t msglen, unsigned int msgprio) { 
	return __mq_timedsend(des, msgptr, msglen, msgprio, NULL);
}

ssize_t mq_receive(mdq_t des, char *msgptr, size_t msglen, unsigned int *msgprio) {
	return __mq_timedreceive(des, msgptr, msglen, msgprio, NULL);
}

mdq_t mq_open(const char *name, int oflag, ...)
{
	unsigned long mode;	
	struct mq_attr *attr;
	va_list	ap;

	va_start(ap, oflag);
	mode = va_arg(ap, unsigned long);
	attr = va_arg(ap, struct mq_attr *);
	va_end(ap);

	return __mq_open(name, oflag, mode, attr);

}

#define PRIO 1
#define QUEUE "/mnt/example_queue"
#define SIZE 17000

void main()  {

	mdq_t ds;
	char text[SIZE];
	unsigned int msg_prio = 1;

	ds = open(QUEUE, O_RDONLY|O_CREAT); 
	
	if (ds == -1) {
		perror("Opening queue error\n");
		exit(1);
	}

	if (mq_receive(ds, text, SIZE, &msg_prio) == -1)
		perror("Receiving message error");
	else
		printf("Message received: %s\n", text);

	return 0;
}


--DocE+STaALJfprDB--
