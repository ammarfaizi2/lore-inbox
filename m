Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUFPPHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUFPPHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUFPPHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:07:24 -0400
Received: from [213.13.117.218] ([213.13.117.218]:46027 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S264048AbUFPPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:07:07 -0400
Date: Wed, 16 Jun 2004 16:07:03 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [2.4] build error with latest BK [fixed patch]
Message-ID: <20040616150703.GC2969@hobbes.itsari.int>
References: <40CFB2A1.8070104@yahoo.com.au> <20040615164848.GA8276@hobbes.itsari.int> <3473.1087374022@redhat.com> <40D00828.8020303@yahoo.com.au> <16592.3188.448186.438659@alkaid.it.uu.se> <40D00D1F.8070109@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40D00D1F.8070109@yahoo.com.au> (from nickpiggin@yahoo.com.au on Wed, Jun 16, 2004 at 10:04:31 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.16 10:04, Nick Piggin wrote:
> Just simply replace put_task_struct with free_task_struct.

Sorry, only sent half of the patch the first time around. Here it is, 
with the second hunk touching rwsem-spinlock.c.

This applies on top of what's currently in BK, and fixes the problems for 
me -- it is compiled and boot tested, running for the last 20 minutes. 
Also, linux/mm.h is needed because of free_pages().

I don't have any arch around here that actually needs rwsem-spinlock.c so 
that part is untested, although it should be ok.

Marcelo, please apply.



--- linux-2.4-BK/lib/rwsem.c~fix-rwsem-race-fix	2004-06-16 14:14:02.000000000 +0100
+++ linux-2.4-BK/lib/rwsem.c	2004-06-16 14:14:28.000000000 +0100
@@ -5,6 +5,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
@@ -64,7 +65,7 @@ static inline struct rw_semaphore *__rws
 	mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
-	put_task_struct(tsk);
+	free_task_struct(tsk);
 	goto out;
 
 	/* grant an infinite number of read locks to the readers at the front of the queue
@@ -96,7 +97,7 @@ static inline struct rw_semaphore *__rws
 		mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		free_task_struct(tsk);
 	}
 
 	sem->wait_list.next = next;
--- linux-2.4-BK/lib/rwsem-spinlock.c~fix-rwsem-race-fix	2004-06-16 15:47:26.982774224 +0100
+++ linux-2.4-BK/lib/rwsem-spinlock.c	2004-06-16 15:51:17.522726824 +0100
@@ -9,6 +9,7 @@
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
@@ -69,7 +70,7 @@ static inline struct rw_semaphore *__rws
 		mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		free_task_struct(tsk);
 		goto out;
 	}
 
@@ -81,7 +82,7 @@ static inline struct rw_semaphore *__rws
 		mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		free_task_struct(tsk);
 		woken++;
 		if (list_empty(&sem->wait_list))
 			break;
@@ -111,7 +112,7 @@ static inline struct rw_semaphore *__rws
 	mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
-	put_task_struct(tsk);
+	free_task_struct(tsk);
 	return sem;
 }
 


