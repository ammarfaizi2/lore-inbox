Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311934AbSCOFhk>; Fri, 15 Mar 2002 00:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311939AbSCOFha>; Fri, 15 Mar 2002 00:37:30 -0500
Received: from [202.135.142.194] ([202.135.142.194]:33291 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311934AbSCOFhS>; Fri, 15 Mar 2002 00:37:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: [PATCH] Re: futex and timeouts 
In-Reply-To: Your message of "Thu, 14 Mar 2002 10:19:48 CDT."
             <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> 
Date: Fri, 15 Mar 2002 16:39:50 +1100
Message-Id: <E16lkRS-0001HN-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> you write:
> 3) I think one of us is misunderstanding (its probably me)
> 
> What I was proposing was a relative wall clock time, vs application virtual 
> time. 
> 
> interface would be to always specify in futex how long to wait (relative) and
> not until when to wait (absolute).

Yep, sorry, my mistake.  I suggest make it a relative "struct timespec
*" (more futureproof that timeval).  It would make sense to split the
interface into futex_down and futex_up syuscalls, since futex_up
doesn't need a timeout arg, but I haven't for the moment.

(Untested) patch below,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.7-pre1/kernel/futex.c working-2.5.7-pre1-futex-timeout/kernel/futex.c
--- linux-2.5.7-pre1/kernel/futex.c	Wed Mar 13 13:30:39 2002
+++ working-2.5.7-pre1-futex-timeout/kernel/futex.c	Fri Mar 15 16:37:14 2002
@@ -32,6 +32,7 @@
 #include <linux/fs.h>
 #include <linux/futex.h>
 #include <linux/highmem.h>
+#include <linux/time.h>
 #include <asm/atomic.h>
 
 /* These mutexes are a very simple counter: the winner is the one who
@@ -146,10 +147,19 @@
 }
 
 /* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
-static int futex_down(struct list_head *head, struct page *page, int offset)
+static int futex_down(struct list_head *head, struct page *page, int offset,
+		      struct timespec *utime)
 {
 	int retval = 0;
 	struct futex_q q;
+	unsigned long time = MAX_SCHEDULE_TIMEOUT;
+
+	if (utime) {
+		struct timespec t;
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		time = timespec_to_jiffies(&t) + 1;
+	}
 
 	current->state = TASK_INTERRUPTIBLE;
 	queue_me(head, &q, page, offset);
@@ -159,13 +169,17 @@
 			retval = -EINTR;
 			break;
 		}
-		schedule();
+		time = schedule_timeout(time);
+		if (time == 0) {
+			retval = -ETIMEDOUT;
+			break;
+		}
 		current->state = TASK_INTERRUPTIBLE;
 	}
 	current->state = TASK_RUNNING;
 	unqueue_me(&q);
-	/* If we were signalled, we might have just been woken: we
-	   must wake another one.  Otherwise we need to wake someone
+	/* If we were signalled, or timed out, we might have just been woken:
+	   we must wake another one.  Otherwise we need to wake someone
 	   else (if they are waiting) so they drop the count below 0,
 	   and when we "up" in userspace, we know there is a
 	   waiter. */
@@ -185,7 +199,7 @@
 	return 0;
 }
 
-asmlinkage int sys_futex(void *uaddr, int op)
+asmlinkage int sys_futex_down(void *uaddr, int op, struct timespec *utime)
 {
 	int ret;
 	unsigned long pos_in_page;
@@ -210,7 +224,7 @@
 		ret = futex_up(head, page, pos_in_page);
 		break;
 	case FUTEX_DOWN:
-		ret = futex_down(head, page, pos_in_page);
+		ret = futex_down(head, page, pos_in_page, utime);
 		break;
 	/* Add other lock types here... */
 	default:
