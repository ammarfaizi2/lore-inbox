Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTDUSkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTDUSin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:38:43 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:36047 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261876AbTDUShv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:37:51 -0400
Message-ID: <3EA43D4D.7030507@colorfullife.com>
Date: Mon, 21 Apr 2003 20:49:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: nr_threads locking
References: <3EA3F153.3000106@colorfullife.com> <20030421112858.35e2d7b5.akpm@digeo.com>
In-Reply-To: <20030421112858.35e2d7b5.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------000500040405080100050907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000500040405080100050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>It would be possible, yes.
>
>But thread creation is a "rare" event compared to pagefaults and syscalls. 
>An atomic_t will be OK there.
>  
>
Actually, the code is correct. The documentation it bogus. lock_kernel() 
never achieved any protection: the copy_xy() functions can sleep.

What about the attached docu update?

--
    Manfred

--------------000500040405080100050907
Content-Type: text/plain;
 name="patch-nrthreads"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-nrthreads"

--- 2.5/kernel/fork.c	2003-04-20 11:19:14.000000000 +0200
+++ build-2.5/kernel/fork.c	2003-04-21 20:44:37.000000000 +0200
@@ -43,7 +43,9 @@
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
 extern void exit_semundo(struct task_struct *tsk);
 
-/* The idle threads do not count.. */
+/* The idle threads do not count..
+ * Protected by write_lock_irq(&tasklist_lock)
+ */
 int nr_threads;
 
 int max_threads;
@@ -792,9 +794,9 @@
 	atomic_inc(&p->user->processes);
 
 	/*
-	 * Counter increases are protected by
-	 * the kernel lock so nr_threads can't
-	 * increase under us (but it may decrease).
+	 * If multiple threads are within copy_process(), then this check
+	 * triggers too late. This doesn't hurt, the check is only there
+	 * to stop root fork bombs.
 	 */
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;

--------------000500040405080100050907--

