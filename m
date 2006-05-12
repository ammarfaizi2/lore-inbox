Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWELIcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWELIcA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWELIcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:32:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12418 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751086AbWELIcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:32:00 -0400
Date: Fri, 12 May 2006 04:31:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Silly bitmap size accounting fix
Message-ID: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

While explaining to a colleague why you defined BITMAP_SIZE in sched.c to:

#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))

and not

#define BITMAP_SIZE ((((MAX_PRIO)/8)+sizeof(long))/sizeof(long))

It dawned on me that the MAX_PRIO+1 should really be just MAX_PRIO.

Priorities go from 0 to MAX_PRIO-1 so you only need to store MAX_PRIO
bits. As you probably know since you define the array in the run queue to
only queue[MAX_PRIO] and not [MAX_PRIO+1].

So on a normal system where long is 4 bytes we get:

MAX_PRIO = 140
sizeof(long) = 4
((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long)) = 5

And with the new fix:

((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long)) = 5

So the result is the same, and hence the "Silly" part in the subject.

But although this change really has no affect on the kernel, it is still
a correctness issue, and readability issue.  The +1+7 confuses people,
especially when the +1 is not needed.

Not to mention, for those that change the kernel to use their own priority
settings, it might waste one extra word (althought this is actually not
that big of a deal).

So for correctness and readability, I'm submitting this patch.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
+++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-12 04:02:39.000000000 -0400
@@ -192,7 +192,7 @@ static inline unsigned int task_timeslic
  * These are the runqueue data structures:
  */

-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
+#define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))

 typedef struct runqueue runqueue_t;

