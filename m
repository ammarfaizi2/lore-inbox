Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263031AbUDTOPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUDTOPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUDTOPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:15:00 -0400
Received: from mail.cyclades.com ([64.186.161.6]:48612 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S263028AbUDTOML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:12:11 -0400
Date: Tue, 20 Apr 2004 11:13:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: akpm@osdl.org, drepper@redhat.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040420141319.GB13259@logos.cnet>
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419224940.GY31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:49:40PM -0400, Jakub Jelinek wrote:
> On Mon, Apr 19, 2004 at 06:28:10PM -0300, Marcelo Tosatti wrote:
> > Andrew, 
> > 
> > Here goes the signal pending & POSIX mqueue's per-uid limit patch. 
> > 
> > Initialization has been moved to include/asm-i386/resource.h, as you suggested.
> > 
> > The global mqueue limit has been increased to 256 (64 per user), and the global 
> > signal pending limit to 4096 (1024 per user).
> > 
> > This has been well tested.
> > 
> > If you are OK with it for inclusion (-mm) I'll generate the arch-dependant
> > changes for the other architectures.
> > 
> > Comments are welcome.
> 
> I wonder if it is a good idea to base mqueue limitation on the number of
> message queues and not take into account how big they are.
> 64 message queues with 1 byte msgsize and 1 maxmsg is certainly quite
> harmless and the system could have even more queues for such a user,
> while 64 message queues with 16K msgsize (current default) and 40 maxmsg
> (also default) eats ~ 40M of kernel memory.

Indeed, it seems more correct to account for something else than "nr of message queues".

Memory occupied sounds better, yeap?

I'm sending the patch anyway, we can use the same RLIMIT_MSGQUEUE and user->msg_queues later 
on with another meaning. 

Here it goes the update version, Andrew:

diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/arch/i386/kernel/init_task.c linux-2.6.6-rc1-mm1/arch/i386/kernel/init_task.c
--- linux-2.6.6-rc1-mm1.orig/arch/i386/kernel/init_task.c	2004-04-20 09:53:30.542659216 -0300
+++ linux-2.6.6-rc1-mm1/arch/i386/kernel/init_task.c	2004-04-20 09:59:46.330530776 -0300
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-alpha/resource.h linux-2.6.6-rc1-mm1/include/asm-alpha/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-alpha/resource.h	2004-04-20 09:53:22.648859256 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-alpha/resource.h	2004-04-20 10:22:29.435307352 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-arm/resource.h linux-2.6.6-rc1-mm1/include/asm-arm/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-arm/resource.h	2004-04-20 09:53:21.870977512 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-arm/resource.h	2004-04-20 10:23:34.019489064 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-arm26/resource.h linux-2.6.6-rc1-mm1/include/asm-arm26/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-arm26/resource.h	2004-04-20 09:53:25.795380912 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-arm26/resource.h	2004-04-20 10:24:14.266370608 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-cris/resource.h linux-2.6.6-rc1-mm1/include/asm-cris/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-cris/resource.h	2004-04-20 09:53:25.351448400 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-cris/resource.h	2004-04-20 10:32:05.784688928 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-h8300/resource.h linux-2.6.6-rc1-mm1/include/asm-h8300/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-h8300/resource.h	2004-04-20 09:53:24.789533824 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-h8300/resource.h	2004-04-20 10:32:51.974666984 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-i386/resource.h linux-2.6.6-rc1-mm1/include/asm-i386/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-i386/resource.h	2004-04-20 09:53:23.662705128 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-i386/resource.h	2004-04-20 09:59:46.360526216 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-ia64/resource.h linux-2.6.6-rc1-mm1/include/asm-ia64/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-ia64/resource.h	2004-04-20 09:53:17.076706352 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-ia64/resource.h	2004-04-20 10:34:15.530964496 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-m68k/resource.h linux-2.6.6-rc1-mm1/include/asm-m68k/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-m68k/resource.h	2004-04-20 09:53:19.214381376 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-m68k/resource.h	2004-04-20 10:35:09.442768656 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-mips/resource.h linux-2.6.6-rc1-mm1/include/asm-mips/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-mips/resource.h	2004-04-20 09:53:14.563088480 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-mips/resource.h	2004-04-20 10:35:51.914312000 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-parisc/resource.h linux-2.6.6-rc1-mm1/include/asm-parisc/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-parisc/resource.h	2004-04-20 09:53:12.274436408 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-parisc/resource.h	2004-04-20 10:36:19.905056760 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-ppc/resource.h linux-2.6.6-rc1-mm1/include/asm-ppc/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-ppc/resource.h	2004-04-20 09:53:18.942422720 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-ppc/resource.h	2004-04-20 10:38:08.781505024 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-ppc64/resource.h linux-2.6.6-rc1-mm1/include/asm-ppc64/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-ppc64/resource.h	2004-04-20 09:53:12.590388376 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-ppc64/resource.h	2004-04-20 10:38:54.790510592 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-s390/resource.h linux-2.6.6-rc1-mm1/include/asm-s390/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-s390/resource.h	2004-04-20 09:53:24.491579120 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-s390/resource.h	2004-04-20 10:39:45.573790360 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-sh/resource.h linux-2.6.6-rc1-mm1/include/asm-sh/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-sh/resource.h	2004-04-20 09:53:26.883215536 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-sh/resource.h	2004-04-20 10:41:58.536576944 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-sparc/resource.h linux-2.6.6-rc1-mm1/include/asm-sparc/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-sparc/resource.h	2004-04-20 09:53:22.190928872 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-sparc/resource.h	2004-04-20 10:42:39.531344792 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-sparc64/resource.h linux-2.6.6-rc1-mm1/include/asm-sparc64/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-sparc64/resource.h	2004-04-20 09:53:25.468430616 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-sparc64/resource.h	2004-04-20 10:43:35.636815464 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-v850/resource.h linux-2.6.6-rc1-mm1/include/asm-v850/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-v850/resource.h	2004-04-20 09:53:26.010348232 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-v850/resource.h	2004-04-20 10:44:20.850941872 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/asm-x86_64/resource.h linux-2.6.6-rc1-mm1/include/asm-x86_64/resource.h
--- linux-2.6.6-rc1-mm1.orig/include/asm-x86_64/resource.h	2004-04-20 09:53:17.252679600 -0300
+++ linux-2.6.6-rc1-mm1/include/asm-x86_64/resource.h	2004-04-20 10:44:56.474526264 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/linux/mqueue.h linux-2.6.6-rc1-mm1/include/linux/mqueue.h
--- linux-2.6.6-rc1-mm1.orig/include/linux/mqueue.h	2004-04-20 09:53:18.864434576 -0300
+++ linux-2.6.6-rc1-mm1/include/linux/mqueue.h	2004-04-20 09:59:46.360526216 -0300
@@ -21,6 +21,8 @@
 #include <linux/types.h>
 
 #define MQ_PRIO_MAX 	32768
+#define DFLT_QUEUESMAX	256
+#define MAX_USER_MSGQUEUE	(DFLT_QUEUESMAX / 4)
 
 struct mq_attr {
 	long	mq_flags;	/* message queue flags			*/
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/linux/sched.h linux-2.6.6-rc1-mm1/include/linux/sched.h
--- linux-2.6.6-rc1-mm1.orig/include/linux/sched.h	2004-04-20 09:53:17.856587792 -0300
+++ linux-2.6.6-rc1-mm1/include/linux/sched.h	2004-04-20 09:59:46.362525912 -0300
@@ -294,6 +294,7 @@ struct signal_struct {
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+	atomic_t sigpending;
 };
 
 /*
@@ -323,6 +324,9 @@ struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals does this user have? */
+	/* protected by mq_lock 	*/
+	int msg_queues; 	/* How many message queues does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/include/linux/signal.h linux-2.6.6-rc1-mm1/include/linux/signal.h
--- linux-2.6.6-rc1-mm1.orig/include/linux/signal.h	2004-04-20 09:53:17.925577304 -0300
+++ linux-2.6.6-rc1-mm1/include/linux/signal.h	2004-04-20 09:59:46.375523936 -0300
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
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/ipc/mqueue.c linux-2.6.6-rc1-mm1/ipc/mqueue.c
--- linux-2.6.6-rc1-mm1.orig/ipc/mqueue.c	2004-04-20 09:54:27.403015128 -0300
+++ linux-2.6.6-rc1-mm1/ipc/mqueue.c	2004-04-20 09:59:46.376523784 -0300
@@ -43,7 +43,6 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
 #define DFLT_MSGMAX 	40	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
 #define DFLT_MSGSIZEMAX 16384	/* max message size */
@@ -217,6 +216,14 @@ static void mqueue_delete_inode(struct i
 
 	spin_lock(&mq_lock);
 	queues_count--;
+
+	/* 
+	 * If we create mqueues, then "setuid()", and destroy 
+	 * mqueues later on (with the new uid), msg_queues 
+	 * can get negative.
+	 */
+	if (current->user->msg_queues > 0)
+		current->user->msg_queues--;
 	spin_unlock(&mq_lock);
 }
 
@@ -225,13 +232,18 @@ static int mqueue_create(struct inode *d
 {
 	struct inode *inode;
 	int error;
+	struct task_struct *p = current;
 
 	spin_lock(&mq_lock);
-	if (queues_count >= queues_max && !capable(CAP_SYS_RESOURCE)) {
+	if (!capable(CAP_SYS_RESOURCE) && (queues_count >= queues_max || 
+	  p->user->msg_queues >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)) {
 		error = -ENOSPC;
 		goto out_lock;
 	}
+
+
 	queues_count++;
+	p->user->msg_queues++;
 	spin_unlock(&mq_lock);
 
 	inode = mqueue_get_inode(dir->i_sb, mode);
@@ -239,6 +251,7 @@ static int mqueue_create(struct inode *d
 		error = -ENOMEM;
 		spin_lock(&mq_lock);
 		queues_count--;
+		p->user->msg_queues--;
 		goto out_lock;
 	}
 
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/kernel/signal.c linux-2.6.6-rc1-mm1/kernel/signal.c
--- linux-2.6.6-rc1-mm1.orig/kernel/signal.c	2004-04-20 09:54:26.747114840 -0300
+++ linux-2.6.6-rc1-mm1/kernel/signal.c	2004-04-20 09:59:46.378523480 -0300
@@ -32,7 +32,7 @@
 static kmem_cache_t *sigqueue_cachep;
 
 atomic_t nr_queued_signals;
-int max_queued_signals = 1024;
+int max_queued_signals = MAX_QUEUED_SIGNALS;
 
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
@@ -268,10 +268,13 @@ struct sigqueue *__sigqueue_alloc(void)
 {
 	struct sigqueue *q = 0;
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&nr_queued_signals) < max_queued_signals &&
+	    atomic_read(&current->user->signal_pending) <= 
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
 		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = 0;
@@ -285,6 +288,14 @@ static inline void __sigqueue_free(struc
 		return;
 	kmem_cache_free(sigqueue_cachep, q);
 	atomic_dec(&nr_queued_signals);
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
@@ -701,11 +712,15 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&nr_queued_signals) < max_queued_signals &&
+		atomic_read(&current->user->signal_pending) <=
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur) 
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
 		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
+
 		q->flags = 0;
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
diff -Nur --show-c-function linux-2.6.6-rc1-mm1.orig/kernel/user.c linux-2.6.6-rc1-mm1/kernel/user.c
--- linux-2.6.6-rc1-mm1.orig/kernel/user.c	2004-04-20 09:54:26.716119552 -0300
+++ linux-2.6.6-rc1-mm1/kernel/user.c	2004-04-20 09:59:46.379523328 -0300
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




