Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUDOWai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUDOWai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:30:38 -0400
Received: from mail.cyclades.com ([64.186.161.6]:26788 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261568AbUDOWaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:30:25 -0400
Date: Thu, 15 Apr 2004 18:46:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-ID: <20040415214632.GA4402@logos.cnet>
References: <407A2DAC.3080802@redhat.com> <20040415145350.GF2085@logos.cnet> <20040415122411.0bcb9195.akpm@osdl.org> <20040415195430.GB3568@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415195430.GB3568@logos.cnet>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 04:54:30PM -0300, Marcelo Tosatti wrote:
> On Thu, Apr 15, 2004 at 12:24:11PM -0700, Andrew Morton wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > >
> > > On Sun, Apr 11, 2004 at 10:48:28PM -0700, Ulrich Drepper wrote:
> > >  > Something has to change in the way message queues are created.
> > >  > Currently it is possible for an unprivileged user to exhaust all mq
> > >  > slots so that only root can create a few more.  Any other unprivileged
> > >  > user has no change to create anything.
> > >  > 
> > >  > I think it is necessary to create a per-user limit instead of a
> > >  > system-wide limit.
> > > 
> > >  Actually, there is no infrastructure to account for per-UID limits right now AFAICS 
> > >  (please someone correct me) at ALL. We need to account and limit for per-user
> > > 
> > >  - pending signals
> > >  - message queues
> > 
> > The stuff in kernel/user.c may be sufficient for this.
> 
> Oh, sweat! I'll try adding a "atomic_t signal_pending" to "user_struct" 
> to be checked at send_signal(), and then go for message queue limiting.

So here goes the signal pending limitation. The default value is "max_signals/2", 
which I think is good enough.

I'll go see the message queue limits tomorrow.

This adds a new "RLIMIT_SIGPENDING" limit, which is used to limit
per-uid pending signals. Currently an unpriviledged user can queue 
more than maximum of allowed signals and cause overall system 
malfunction.


diff -Nur linux-2.6.5.org/include/asm-alpha/resource.h linux-2.6.5/include/asm-alpha/resource.h
--- linux-2.6.5.org/include/asm-alpha/resource.h	2004-04-15 11:13:28.000000000 -0300
+++ linux-2.6.5/include/asm-alpha/resource.h	2004-04-15 18:19:34.543837360 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_NPROC	8		/* max number of processes */
 #define RLIMIT_MEMLOCK	9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_SIGPENDING	 11	/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
diff -Nur linux-2.6.5.org/include/asm-arm/resource.h linux-2.6.5/include/asm-arm/resource.h
--- linux-2.6.5.org/include/asm-arm/resource.h	2004-04-15 11:13:27.000000000 -0300
+++ linux-2.6.5/include/asm-arm/resource.h	2004-04-15 18:03:27.731815128 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING        11     /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-arm26/resource.h linux-2.6.5/include/asm-arm26/resource.h
--- linux-2.6.5.org/include/asm-arm26/resource.h	2004-04-15 11:13:30.000000000 -0300
+++ linux-2.6.5/include/asm-arm26/resource.h	2004-04-15 18:00:33.386319672 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING	11	/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-cris/resource.h linux-2.6.5/include/asm-cris/resource.h
--- linux-2.6.5.org/include/asm-cris/resource.h	2004-04-15 11:13:29.000000000 -0300
+++ linux-2.6.5/include/asm-cris/resource.h	2004-04-15 18:03:40.023946440 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS   10              /* maximum file locks held */
+#define RLIMIT_SIGPENDING        11     /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-h8300/resource.h linux-2.6.5/include/asm-h8300/resource.h
--- linux-2.6.5.org/include/asm-h8300/resource.h	2004-04-15 11:13:29.000000000 -0300
+++ linux-2.6.5/include/asm-h8300/resource.h	2004-04-15 18:03:46.904900376 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING        11     /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-i386/resource.h linux-2.6.5/include/asm-i386/resource.h
--- linux-2.6.5.org/include/asm-i386/resource.h	2004-04-15 11:13:28.000000000 -0300
+++ linux-2.6.5/include/asm-i386/resource.h	2004-04-15 18:04:01.836630408 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-ia64/resource.h linux-2.6.5/include/asm-ia64/resource.h
--- linux-2.6.5.org/include/asm-ia64/resource.h	2004-04-15 11:13:23.000000000 -0300
+++ linux-2.6.5/include/asm-ia64/resource.h	2004-04-15 18:04:09.232506064 -0300
@@ -23,8 +23,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING        11     /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-m68k/resource.h linux-2.6.5/include/asm-m68k/resource.h
--- linux-2.6.5.org/include/asm-m68k/resource.h	2004-04-15 11:13:25.000000000 -0300
+++ linux-2.6.5/include/asm-m68k/resource.h	2004-04-15 18:04:17.941182144 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING        11     /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-mips/resource.h linux-2.6.5/include/asm-mips/resource.h
--- linux-2.6.5.org/include/asm-mips/resource.h	2004-04-15 11:13:21.000000000 -0300
+++ linux-2.6.5/include/asm-mips/resource.h	2004-04-15 18:05:04.764063984 -0300
@@ -23,8 +23,9 @@
 #define RLIMIT_NPROC 8			/* max number of processes */
 #define RLIMIT_MEMLOCK 9		/* max locked-in-memory address space */
 #define RLIMIT_LOCKS 10			/* maximum file locks held */
+#define RLIMIT_SIGPENDING	11 	/* max number of pending signals */
 
-#define RLIM_NLIMITS 11			/* Number of limit flavors.  */
+#define RLIM_NLIMITS 12			/* Number of limit flavors.  */
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-parisc/resource.h linux-2.6.5/include/asm-parisc/resource.h
--- linux-2.6.5.org/include/asm-parisc/resource.h	2004-04-15 11:13:19.000000000 -0300
+++ linux-2.6.5/include/asm-parisc/resource.h	2004-04-15 18:05:20.939604928 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-ppc/resource.h linux-2.6.5/include/asm-ppc/resource.h
--- linux-2.6.5.org/include/asm-ppc/resource.h	2004-04-15 11:13:25.000000000 -0300
+++ linux-2.6.5/include/asm-ppc/resource.h	2004-04-15 18:05:30.876094352 -0300
@@ -12,8 +12,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-ppc64/resource.h linux-2.6.5/include/asm-ppc64/resource.h
--- linux-2.6.5.org/include/asm-ppc64/resource.h	2004-04-15 11:13:20.000000000 -0300
+++ linux-2.6.5/include/asm-ppc64/resource.h	2004-04-15 18:05:39.288815424 -0300
@@ -21,8 +21,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit(?) */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-s390/resource.h linux-2.6.5/include/asm-s390/resource.h
--- linux-2.6.5.org/include/asm-s390/resource.h	2004-04-15 11:13:29.000000000 -0300
+++ linux-2.6.5/include/asm-s390/resource.h	2004-04-15 18:05:48.191462016 -0300
@@ -24,8 +24,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
-  
-#define RLIM_NLIMITS	11
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
+
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-sh/resource.h linux-2.6.5/include/asm-sh/resource.h
--- linux-2.6.5.org/include/asm-sh/resource.h	2004-04-15 11:13:30.000000000 -0300
+++ linux-2.6.5/include/asm-sh/resource.h	2004-04-15 18:05:56.156251184 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 #ifdef __KERNEL__
 
diff -Nur linux-2.6.5.org/include/asm-sparc/resource.h linux-2.6.5/include/asm-sparc/resource.h
--- linux-2.6.5.org/include/asm-sparc/resource.h	2004-04-15 11:13:27.000000000 -0300
+++ linux-2.6.5/include/asm-sparc/resource.h	2004-04-15 18:06:03.934068776 -0300
@@ -22,8 +22,9 @@
 #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
 #define RLIMIT_AS       9               /* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-sparc64/resource.h linux-2.6.5/include/asm-sparc64/resource.h
--- linux-2.6.5.org/include/asm-sparc64/resource.h	2004-04-15 11:13:29.000000000 -0300
+++ linux-2.6.5/include/asm-sparc64/resource.h	2004-04-15 18:06:12.013840464 -0300
@@ -22,8 +22,9 @@
 #define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space */
 #define RLIMIT_AS       9               /* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-v850/resource.h linux-2.6.5/include/asm-v850/resource.h
--- linux-2.6.5.org/include/asm-v850/resource.h	2004-04-15 11:13:30.000000000 -0300
+++ linux-2.6.5/include/asm-v850/resource.h	2004-04-15 18:06:26.557629472 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/asm-x86_64/resource.h linux-2.6.5/include/asm-x86_64/resource.h
--- linux-2.6.5.org/include/asm-x86_64/resource.h	2004-04-15 11:13:23.000000000 -0300
+++ linux-2.6.5/include/asm-x86_64/resource.h	2004-04-15 18:06:38.944746344 -0300
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING       11      /* max number of pending signals */
 
-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12
 
 /*
  * SuS says limits have to be unsigned.
diff -Nur linux-2.6.5.org/include/linux/sched.h linux-2.6.5/include/linux/sched.h
--- linux-2.6.5.org/include/linux/sched.h	2004-04-15 11:13:23.000000000 -0300
+++ linux-2.6.5/include/linux/sched.h	2004-04-15 16:36:22.000000000 -0300
@@ -296,6 +296,7 @@
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t files;		/* How many open files does this user have? */
+	atomic_t signal_pending; /* How many pending signals this user have? */
 
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
diff -Nur linux-2.6.5.org/kernel/signal.c linux-2.6.5/kernel/signal.c
--- linux-2.6.5.org/kernel/signal.c	2004-04-15 11:14:05.000000000 -0300
+++ linux-2.6.5/kernel/signal.c	2004-04-15 17:52:49.000000000 -0300
@@ -268,10 +268,13 @@
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
@@ -285,6 +288,7 @@
 		return;
 	kmem_cache_free(sigqueue_cachep, q);
 	atomic_dec(&nr_queued_signals);
+	atomic_dec(&current->user->signal_pending);
 }
 
 static void flush_sigqueue(struct sigpending *queue)
@@ -699,11 +703,14 @@
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
 		q->flags = 0;
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
@@ -2552,5 +2559,8 @@
 				  0, NULL, NULL);
 	if (!sigqueue_cachep)
 		panic("signals_init(): cannot create sigqueue SLAB cache");
+
+        init_task.rlim[RLIMIT_SIGPENDING].rlim_cur = max_queued_signals/2;
+        init_task.rlim[RLIMIT_SIGPENDING].rlim_max = max_queued_signals/2;
 }
 
diff -Nur linux-2.6.5.org/kernel/user.c linux-2.6.5/kernel/user.c
--- linux-2.6.5.org/kernel/user.c	2004-04-15 11:14:05.000000000 -0300
+++ linux-2.6.5/kernel/user.c	2004-04-15 18:20:03.379453680 -0300
@@ -30,7 +30,8 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
-	.files		= ATOMIC_INIT(0)
+	.files		= ATOMIC_INIT(0),
+	.signal_pending = ATOMIC_INIT(0)
 };
 
 /*
