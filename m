Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUD2UBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUD2UBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264950AbUD2UBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:01:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:28336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264957AbUD2T6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:58:30 -0400
Date: Thu, 29 Apr 2004 12:58:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Wright <chrisw@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040429125820.O21045@build.pdx.osdl.net>
References: <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet> <408EA1DF.6050303@colorfullife.com> <20040428170932.GA14993@logos.cnet> <20040428183315.T22989@build.pdx.osdl.net> <20040429121739.GB18352@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040429121739.GB18352@logos.cnet>; from marcelo.tosatti@cyclades.com on Thu, Apr 29, 2004 at 09:17:39AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> On Wed, Apr 28, 2004 at 06:33:15PM -0700, Chris Wright wrote:
> > * Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> > > This should be OK for inclusion into -mm now, if no other comment is made.
> > 
> > This patch doesn't account for sigqueue bits properly.  The allocations
> > aren't always made in task context.  So, it's trivial to illegitimately
> > drain off the new signal_pending counter, leaving the potential for the
> > original DoS unfixed. 
> 
> How?

Take the normal loop that started the sigqueue DoS discussion (block the
signal and queue up the max amount).  In another shell (same user), just
hit ^C.  This will generate the signal in interrupt context, but
decrease the user count in task context.  This way you can drain off
your counter.

> >  And the setuid issues still seem to be there,
> > right?
> 
> The setuid issues are not there anymore in mqueue (because of find_user(info->creator_id) at 
> mqueue_delete_inode() time. The issue is still present with signal accounting, but 
> we have a "> 0" check for that. And usually only root/CAP_SET_SUID is able to hurt himself (get 
> unaccountable values in its quota). I dont think this really matters yet. 

Yes, I only mean the signal side, not the mqueue side.  And I realize my
test is perhaps overly contrived, but it allows me to bleed off the
wrong user similar to above.  Issue is, do we care who allocates the
sigqueue structure, or who it's getting queued to?  In most cases it's
irrelevant because you have to have permission to send the signal.

> > I have a diff between your patch and what I'm testing, but it's
> > cluttered a bit by the fact that I've also merged it up to 2.6.6-rc3
> > I can send you the full patch if that's easier.
> 
> Please do so. Thanks!!

OK, here it is.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== arch/i386/kernel/init_task.c 1.9 vs edited =====
--- 1.9/arch/i386/kernel/init_task.c	Thu Mar 18 22:03:08 2004
+++ edited/arch/i386/kernel/init_task.c	Thu Apr 29 12:18:13 2004
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/fs.h>
+#include <linux/mqueue.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
===== include/asm-alpha/resource.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/resource.h	Tue Feb  5 09:39:46 2002
+++ edited/include/asm-alpha/resource.h	Thu Apr 29 12:18:13 2004
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
===== include/asm-arm/resource.h 1.1 vs edited =====
--- 1.1/include/asm-arm/resource.h	Tue Feb  5 09:39:52 2002
+++ edited/include/asm-arm/resource.h	Thu Apr 29 12:18:13 2004
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
===== include/asm-arm26/resource.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/resource.h	Wed Jun  4 04:14:10 2003
+++ edited/include/asm-arm26/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS},	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-cris/resource.h 1.1 vs edited =====
--- 1.1/include/asm-cris/resource.h	Tue Feb  5 09:56:43 2002
+++ edited/include/asm-cris/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -38,8 +40,10 @@
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },               \
-        { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-h8300/resource.h 1.1 vs edited =====
--- 1.1/include/asm-h8300/resource.h	Sun Feb 16 16:01:58 2003
+++ edited/include/asm-h8300/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-i386/resource.h 1.1 vs edited =====
--- 1.1/include/asm-i386/resource.h	Tue Feb  5 09:39:44 2002
+++ edited/include/asm-i386/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -39,7 +42,9 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS,  MAX_USER_SIGNALS },	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ia64/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ia64/resource.h	Fri Jan 23 10:52:25 2004
+++ edited/include/asm-ia64/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -47,6 +49,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 # endif /* __KERNEL__ */
===== include/asm-m68k/resource.h 1.2 vs edited =====
--- 1.2/include/asm-m68k/resource.h	Fri Nov  9 05:47:28 2001
+++ edited/include/asm-m68k/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -39,7 +41,9 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-mips/resource.h 1.3 vs edited =====
--- 1.3/include/asm-mips/resource.h	Mon Jul 28 04:57:50 2003
+++ edited/include/asm-mips/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-parisc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/resource.h	Tue Feb  5 09:39:57 2002
+++ edited/include/asm-parisc/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },	\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ppc/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/resource.h	Sun Sep 15 21:52:06 2002
+++ edited/include/asm-ppc/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-ppc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/resource.h	Thu Feb 14 04:14:36 2002
+++ edited/include/asm-ppc64/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-s390/resource.h 1.2 vs edited =====
--- 1.2/include/asm-s390/resource.h	Mon Feb  4 23:37:28 2002
+++ edited/include/asm-s390/resource.h	Thu Apr 29 12:18:13 2004
@@ -24,8 +24,10 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
-  
-#define RLIM_NLIMITS	11
+#define RLIMIT_SIGPENDING 11            /* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12              /* max number of POSIX msg queues */
+
+#define RLIM_NLIMITS	13
 
 /*
  * SuS says limits have to be unsigned.
@@ -48,6 +50,8 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sh/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sh/resource.h	Tue Feb  5 09:39:53 2002
+++ edited/include/asm-sh/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sparc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/resource.h	Tue Feb  5 09:39:47 2002
+++ edited/include/asm-sparc/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -44,7 +46,9 @@
     {INR_OPEN, INR_OPEN}, {0, 0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY}	\
+    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
+    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-sparc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc64/resource.h	Tue Feb  5 09:39:50 2002
+++ edited/include/asm-sparc64/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -43,7 +45,9 @@
     {INR_OPEN, INR_OPEN}, {0, 0},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY}	\
+    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {MAX_USER_SIGNALS, MAX_USER_SIGNALS}, \
+    {MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE},\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-v850/resource.h 1.1 vs edited =====
--- 1.1/include/asm-v850/resource.h	Fri Nov  1 08:38:12 2002
+++ edited/include/asm-v850/resource.h	Thu Apr 29 12:18:13 2004
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
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/asm-x86_64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-x86_64/resource.h	Thu Feb  7 02:55:27 2002
+++ edited/include/asm-x86_64/resource.h	Thu Apr 29 12:18:13 2004
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
@@ -39,7 +41,9 @@
 	{      INR_OPEN,     INR_OPEN  },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_USER_SIGNALS, MAX_USER_SIGNALS },		\
+	{ MAX_USER_MSGQUEUE, MAX_USER_MSGQUEUE },	\
 }
 
 #endif /* __KERNEL__ */
===== include/linux/mqueue.h 1.4 vs edited =====
--- 1.4/include/linux/mqueue.h	Mon Apr 12 10:54:17 2004
+++ edited/include/linux/mqueue.h	Thu Apr 29 12:18:13 2004
@@ -21,6 +21,10 @@
 #include <linux/types.h>
 
 #define MQ_PRIO_MAX 	32768
+#define DFLT_QUEUESMAX	256
+
+/* per-uid limit of kernel memory used by mqueue, in bytes */
+#define MAX_USER_MSGQUEUE	819200
 
 struct mq_attr {
 	long	mq_flags;	/* message queue flags			*/
===== include/linux/sched.h 1.197 vs edited =====
--- 1.197/include/linux/sched.h	Mon Apr 26 22:07:44 2004
+++ edited/include/linux/sched.h	Thu Apr 29 12:18:13 2004
@@ -282,6 +282,7 @@
 	int leader;
 
 	struct tty_struct *tty; /* NULL if no tty */
+	atomic_t sigpending;
 };
 
 /*
@@ -311,6 +312,9 @@
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals does this user have? */
+	/* protected by mq_lock 	*/
+	int msg_queues; 	/* How many message queues does this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
===== include/linux/signal.h 1.15 vs edited =====
--- 1.15/include/linux/signal.h	Thu Jan 15 12:40:33 2004
+++ edited/include/linux/signal.h	Thu Apr 29 12:21:37 2004
@@ -7,6 +7,9 @@
 #include <asm/siginfo.h>
 
 #ifdef __KERNEL__
+
+#define MAX_USER_SIGNALS	1024
+
 /*
  * Real Time signals may be queued.
  */
===== ipc/mqueue.c 1.9 vs edited =====
--- 1.9/ipc/mqueue.c	Sat Apr 17 11:19:31 2004
+++ edited/ipc/mqueue.c	Thu Apr 29 12:18:13 2004
@@ -43,10 +43,9 @@
 #define CTL_MSGSIZEMAX 	4
 
 /* default values */
-#define DFLT_QUEUESMAX	64	/* max number of message queues */
-#define DFLT_MSGMAX 	40	/* max number of messages in each queue */
+#define DFLT_MSGMAX 	10	/* max number of messages in each queue */
 #define HARD_MSGMAX 	(131072/sizeof(void*))
-#define DFLT_MSGSIZEMAX 16384	/* max message size */
+#define DFLT_MSGSIZEMAX 8192	/* max message size */
 
 #define NOTIFY_COOKIE_LEN	32
 
@@ -67,6 +66,7 @@
 
 	struct sigevent notify;
 	pid_t notify_owner;
+ 	uid_t creator_id;	/* UID of creator, for resource accouting */
 	struct sock *notify_sock;
 	struct sk_buff *notify_cookie;
 
@@ -113,6 +113,7 @@
 
 		if (S_ISREG(mode)) {
 			struct mqueue_inode_info *info;
+			struct task_struct *p = current;
 
 			inode->i_fop = &mqueue_file_operations;
 			inode->i_size = FILENT_SIZE;
@@ -127,7 +128,20 @@
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
 			info->attr.mq_msgsize = DFLT_MSGSIZEMAX;
+
+	  		if (p->user->msg_queues + 
+				(DFLT_MSGMAX * sizeof(struct msg_msg *) +
+				(DFLT_MSGMAX * DFLT_MSGSIZEMAX)) >=
+					p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
+				return NULL;
+
 			info->messages = kmalloc(DFLT_MSGMAX * sizeof(struct msg_msg *), GFP_KERNEL);
+			info->creator_id = current->uid;
+
+			spin_lock(&mq_lock);
+			p->user->msg_queues += (DFLT_MSGMAX * sizeof(struct msg_msg *) + (DFLT_MSGMAX * DFLT_MSGSIZEMAX));
+			spin_unlock(&mq_lock);
+
 			if (!info->messages) {
 				make_bad_inode(inode);
 				iput(inode);
@@ -200,22 +214,32 @@
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
 	for (i = 0; i < info->attr.mq_curmsgs; i++)
 		free_msg(info->messages[i]);
+
 	kfree(info->messages);
 	spin_unlock(&info->lock);
 
 	clear_inode(inode);
 
 	spin_lock(&mq_lock);
+	user->msg_queues -= (info->attr.mq_maxmsg * 
+					sizeof(struct msg_msg *) +
+				(info->attr.mq_maxmsg * info->attr.mq_msgsize));
 	queues_count--;
 	spin_unlock(&mq_lock);
 }
@@ -535,6 +559,7 @@
 	struct file *filp;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
+	struct task_struct *p = current;
 	struct msg_msg **msgs = NULL;
 	struct mq_attr attr;
 	int ret;
@@ -553,15 +578,26 @@
 					attr.mq_msgsize > msgsize_max)
 				return ERR_PTR(-EINVAL);
 		}
+	  	if(p->user->msg_queues+ ((attr.mq_maxmsg * sizeof(struct msg_msg *)
+				+ (attr.mq_maxmsg * attr.mq_msgsize)))
+			  >= p->rlim[RLIMIT_MSGQUEUE].rlim_cur)
+			return ERR_PTR(-ENOMEM);
+
 		msgs = kmalloc(attr.mq_maxmsg * sizeof(*msgs), GFP_KERNEL);
 		if (!msgs)
 			return ERR_PTR(-ENOMEM);
+
+		spin_lock(&mq_lock);
+		current->user->msg_queues += (attr.mq_maxmsg * sizeof(*msgs) +
+					(attr.mq_maxmsg * attr.mq_msgsize));
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
@@ -572,8 +608,17 @@
 	if (msgs) {
 		info->attr.mq_maxmsg = attr.mq_maxmsg;
 		info->attr.mq_msgsize = attr.mq_msgsize;
+		spin_lock(&mq_lock);
+		current->user->msg_queues -= (info->attr.mq_maxmsg 
+						* sizeof (struct msg_msg *) +
+						(info->attr.mq_maxmsg * 
+						info->attr.mq_msgsize));
+		if (current->user->msg_queues < 0)
+			current->user->msg_queues = 0;	
+		spin_unlock(&mq_lock);
 		kfree(info->messages);
 		info->messages = msgs;
+		info->creator_id = current->uid;
 	}
 
 	filp = dentry_open(dentry, mqueue_mnt, oflag);
===== kernel/signal.c 1.114 vs edited =====
--- 1.114/kernel/signal.c	Mon Apr 19 16:49:52 2004
+++ edited/kernel/signal.c	Thu Apr 29 12:52:30 2004
@@ -31,9 +31,6 @@
 
 static kmem_cache_t *sigqueue_cachep;
 
-atomic_t nr_queued_signals;
-int max_queued_signals = 1024;
-
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
  * or to the process as a whole (Linux thread group).  How the signal
@@ -264,14 +261,15 @@
 	return sig;
 }
 
-struct sigqueue *__sigqueue_alloc(void)
+static struct sigqueue *__sigqueue_alloc(void)
 {
 	struct sigqueue *q = 0;
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&current->user->signal_pending) < 
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
-		atomic_inc(&nr_queued_signals);
+		atomic_inc(&current->user->signal_pending);
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = 0;
@@ -279,15 +277,22 @@
 	return(q);
 }
 
-static inline void __sigqueue_free(struct sigqueue *q)
+static inline void __sigqueue_free(struct task_struct *t, struct sigqueue *q)
 {
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
+	if (atomic_read(&t->user->signal_pending) > 0)
+		atomic_dec(&t->user->signal_pending);
 }
 
-static void flush_sigqueue(struct sigpending *queue)
+static void flush_sigqueue(struct task_struct *t, struct sigpending *queue)
 {
 	struct sigqueue *q;
 
@@ -295,7 +300,7 @@
 	while (!list_empty(&queue->list)) {
 		q = list_entry(queue->list.next, struct sigqueue , list);
 		list_del_init(&q->list);
-		__sigqueue_free(q);
+		__sigqueue_free(t, q);
 	}
 }
 
@@ -310,8 +315,8 @@
 
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	clear_tsk_thread_flag(t,TIF_SIGPENDING);
-	flush_sigqueue(&t->pending);
-	flush_sigqueue(&t->signal->shared_pending);
+	flush_sigqueue(t, &t->pending);
+	flush_sigqueue(t, &t->signal->shared_pending);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 }
 
@@ -353,7 +358,7 @@
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
 		spin_unlock(&sighand->siglock);
-		flush_sigqueue(&sig->shared_pending);
+		flush_sigqueue(tsk, &sig->shared_pending);
 	} else {
 		/*
 		 * If there is any task waiting for the group exit
@@ -370,7 +375,7 @@
 		sig = NULL;	/* Marker for below.  */
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
-	flush_sigqueue(&tsk->pending);
+	flush_sigqueue(tsk, &tsk->pending);
 	if (sig) {
 		/*
 		 * We are cleaning up the signal_struct here.  We delayed
@@ -451,7 +456,8 @@
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 }
 
-static inline int collect_signal(int sig, struct sigpending *list, siginfo_t *info)
+static inline int collect_signal(int sig, struct task_struct *tsk,
+				struct sigpending *list, siginfo_t *info)
 {
 	struct sigqueue *q, *first = 0;
 	int still_pending = 0;
@@ -475,7 +481,7 @@
 	if (first) {
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-		__sigqueue_free(first);
+		__sigqueue_free(tsk, first);
 		if (!still_pending)
 			sigdelset(&list->signal, sig);
 	} else {
@@ -494,8 +500,8 @@
 	return 1;
 }
 
-static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			siginfo_t *info)
+static int __dequeue_signal(struct task_struct *tsk, struct sigpending *pending,
+			sigset_t *mask, siginfo_t *info)
 {
 	int sig = 0;
 
@@ -510,7 +516,7 @@
 			}
 		}
 
-		if (!collect_signal(sig, pending, info))
+		if (!collect_signal(sig, tsk, pending, info))
 			sig = 0;
 				
 	}
@@ -527,9 +533,9 @@
  */
 int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
 {
-	int signr = __dequeue_signal(&tsk->pending, mask, info);
+	int signr = __dequeue_signal(tsk, &tsk->pending, mask, info);
 	if (!signr)
-		signr = __dequeue_signal(&tsk->signal->shared_pending,
+		signr = __dequeue_signal(tsk, &tsk->signal->shared_pending,
 					 mask, info);
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
@@ -576,7 +582,8 @@
  *
  * All callers must be holding the siglock.
  */
-static int rm_from_queue(unsigned long mask, struct sigpending *s)
+static int rm_from_queue(unsigned long mask, struct task_struct *t,
+			struct sigpending *s)
 {
 	struct sigqueue *q, *n;
 
@@ -588,7 +595,7 @@
 		if (q->info.si_signo < SIGRTMIN &&
 		    (mask & sigmask(q->info.si_signo))) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			__sigqueue_free(t, q);
 		}
 	}
 	return 1;
@@ -634,10 +641,10 @@
 		/*
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
-		rm_from_queue(sigmask(SIGCONT), &p->signal->shared_pending);
+		rm_from_queue(sigmask(SIGCONT), p, &p->signal->shared_pending);
 		t = p;
 		do {
-			rm_from_queue(sigmask(SIGCONT), &t->pending);
+			rm_from_queue(sigmask(SIGCONT), t, &t->pending);
 			t = next_thread(t);
 		} while (t != p);
 	} else if (sig == SIGCONT) {
@@ -666,11 +673,11 @@
 					p->group_leader,
 					p->group_leader->real_parent);
 		}
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
+		rm_from_queue(SIG_KERNEL_STOP_MASK, p, &p->signal->shared_pending);
 		t = p;
 		do {
 			unsigned int state;
-			rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
+			rm_from_queue(SIG_KERNEL_STOP_MASK, t, &t->pending);
 			
 			/*
 			 * If there is a handler for SIGCONT, we must make
@@ -698,7 +705,8 @@
 	}
 }
 
-static int send_signal(int sig, struct siginfo *info, struct sigpending *signals)
+static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
+			struct sigpending *signals)
 {
 	struct sigqueue * q = NULL;
 	int ret = 0;
@@ -718,11 +726,13 @@
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&t->user->signal_pending) <
+			t->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
-		atomic_inc(&nr_queued_signals);
+		atomic_inc(&t->user->signal_pending);
+
 		q->flags = 0;
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
@@ -797,7 +807,7 @@
 	if (LEGACY_QUEUE(&t->pending, sig))
 		goto out;
 
-	ret = send_signal(sig, info, &t->pending);
+	ret = send_signal(sig, info, t, &t->pending);
 	if (!ret && !sigismember(&t->blocked, sig))
 		signal_wake_up(t, sig == SIGKILL);
 out:
@@ -937,8 +947,8 @@
 		 * unchanged from the death state, e.g. which thread had
 		 * the core-dump signal unblocked.
 		 */
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
+		rm_from_queue(SIG_KERNEL_STOP_MASK, t, &t->pending);
+		rm_from_queue(SIG_KERNEL_STOP_MASK, p, &p->signal->shared_pending);
 		p->signal->group_stop_count = 0;
 		p->signal->group_exit_task = t;
 		t = p;
@@ -998,7 +1008,7 @@
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
 	 */
-	ret = send_signal(sig, info, &p->signal->shared_pending);
+	ret = send_signal(sig, info, p, &p->signal->shared_pending);
 	if (unlikely(ret))
 		return ret;
 
@@ -1037,7 +1047,7 @@
 			t->exit_signal = -1;
 
 		sigaddset(&t->pending.signal, SIGKILL);
-		rm_from_queue(SIG_KERNEL_STOP_MASK, &t->pending);
+		rm_from_queue(SIG_KERNEL_STOP_MASK, t, &t->pending);
 		signal_wake_up(t, 1);
 	}
 }
@@ -1290,7 +1300,7 @@
 		read_unlock(&tasklist_lock);
 	}
 	q->flags &= ~SIGQUEUE_PREALLOC;
-	__sigqueue_free(q);
+	__sigqueue_free(current, q);
 }
 
 int
@@ -2328,9 +2338,9 @@
 			*k = *act;
 			sigdelsetmask(&k->sa.sa_mask,
 				      sigmask(SIGKILL) | sigmask(SIGSTOP));
-			rm_from_queue(sigmask(sig), &t->signal->shared_pending);
+			rm_from_queue(sigmask(sig), t, &t->signal->shared_pending);
 			do {
-				rm_from_queue(sigmask(sig), &t->pending);
+				rm_from_queue(sigmask(sig), t, &t->pending);
 				recalc_sigpending_tsk(t);
 				t = next_thread(t);
 			} while (t != current);
===== kernel/sysctl.c 1.71 vs edited =====
--- 1.71/kernel/sysctl.c	Mon Apr 26 22:07:43 2004
+++ edited/kernel/sysctl.c	Thu Apr 29 12:22:25 2004
@@ -53,8 +53,6 @@
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int max_threads;
-extern atomic_t nr_queued_signals;
-extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern char core_pattern[];
@@ -429,22 +427,6 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-	{
-		.ctl_name	= KERN_RTSIGNR,
-		.procname	= "rtsig-nr",
-		.data		= &nr_queued_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.ctl_name	= KERN_RTSIGMAX,
-		.procname	= "rtsig-max",
-		.data		= &max_queued_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
 #ifdef CONFIG_SYSVIPC
 	{
 		.ctl_name	= KERN_SHMMAX,
===== kernel/user.c 1.8 vs edited =====
--- 1.8/kernel/user.c	Fri Aug  1 03:02:22 2003
+++ edited/kernel/user.c	Thu Apr 29 12:18:13 2004
@@ -30,7 +30,9 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.signal_pending = ATOMIC_INIT(0),
+	.msg_queues	= 0
 };
 
 /*
@@ -97,6 +99,9 @@
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
 		atomic_set(&new->files, 0);
+		atomic_set(&new->signal_pending, 0);
+
+		new->msg_queues = 0;
 
 		/*
 		 * Before adding this, check whether we raced
