Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266074AbUFPCik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUFPCik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUFPCik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:38:40 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:14201 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266074AbUFPCid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:38:33 -0400
Message-ID: <40CFB2A1.8070104@yahoo.com.au>
Date: Wed, 16 Jun 2004 12:38:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nuno Monteiro <nuno@itsari.org>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       David Howells <dhowells@redhat.com>
Subject: Re: [2.4] build error with latest BK
References: <20040615164848.GA8276@hobbes.itsari.int>
In-Reply-To: <20040615164848.GA8276@hobbes.itsari.int>
Content-Type: multipart/mixed;
 boundary="------------020103020802060401070103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103020802060401070103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nuno Monteiro wrote:
> 
> Hi all,
> 
> 
> Just pulled latest bk of 2.4 and it appears to be broken. The recent  
> rwsem race fixes seem to be the culprit (see  
> http://linux.bkbits.net:8080/linux-2.4/cset@40cee86dCLGhZc1lEOWZV6K7FysQlw?nav=index.html| 
> ChangeSet@-1d). Reversing it fixes the problem.
> 

Sorry, that was stupid of me.

Does the attached patch look acceptable? In particular, should
task_lock be used in this manner? (ie. to guarantee the task doesn't
go away).


--------------020103020802060401070103
Content-Type: text/x-patch;
 name="rwsem24-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem24-fix.patch"

--- linux-2.4/lib/rwsem.c.orig	2004-06-16 12:26:52.000000000 +1000
+++ linux-2.4/lib/rwsem.c	2004-06-16 12:33:28.000000000 +1000
@@ -61,10 +61,10 @@ static inline struct rw_semaphore *__rws
 
 	list_del(&waiter->list);
 	tsk = waiter->task;
-	mb();
+	task_lock(tsk);		/* task_lock is an implicit memory barrier */
 	waiter->task = NULL;
 	wake_up_process(tsk);
-	put_task_struct(tsk);
+	task_unlock(tsk);
 	goto out;
 
 	/* grant an infinite number of read locks to the readers at the front of the queue
@@ -93,10 +93,10 @@ static inline struct rw_semaphore *__rws
 		waiter = list_entry(next,struct rwsem_waiter,list);
 		next = waiter->list.next;
 		tsk = waiter->task;
-		mb();
+		task_lock(tsk);
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		task_unlock(tsk);
 	}
 
 	sem->wait_list.next = next;
@@ -128,7 +128,6 @@ static inline struct rw_semaphore *rwsem
 	/* set up my own style of waitqueue */
 	spin_lock(&sem->wait_lock);
 	waiter->task = tsk;
-	get_task_struct(tsk);
 
 	list_add_tail(&waiter->list,&sem->wait_list);
 
--- linux-2.4/lib/rwsem-spinlock.c.orig	2004-06-16 12:33:40.000000000 +1000
+++ linux-2.4/lib/rwsem-spinlock.c	2004-06-16 12:34:39.000000000 +1000
@@ -66,10 +66,10 @@ static inline struct rw_semaphore *__rws
 		sem->activity = -1;
 		list_del(&waiter->list);
 		tsk = waiter->task;
-		mb();
+		task_lock(tsk);			/* implicit memory barrier */
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		task_unlock(tsk);
 		goto out;
 	}
 
@@ -78,10 +78,10 @@ static inline struct rw_semaphore *__rws
 	do {
 		list_del(&waiter->list);
 		tsk = waiter->task;
-		mb();
+		task_lock(tsk);
 		waiter->task = NULL;
 		wake_up_process(tsk);
-		put_task_struct(tsk);
+		task_unlock(tsk);
 		woken++;
 		if (list_empty(&sem->wait_list))
 			break;
@@ -108,10 +108,10 @@ static inline struct rw_semaphore *__rws
 	list_del(&waiter->list);
 
 	tsk = waiter->task;
-	mb();
+	task_lock(tsk);
 	waiter->task = NULL;
 	wake_up_process(tsk);
-	put_task_struct(tsk);
+	task_unlock(tsk);
 	return sem;
 }
 
@@ -140,7 +140,6 @@ void __down_read(struct rw_semaphore *se
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
 	waiter.flags = RWSEM_WAITING_FOR_READ;
-	get_task_struct(tsk);
 
 	list_add_tail(&waiter.list,&sem->wait_list);
 
@@ -209,7 +208,6 @@ void __down_write(struct rw_semaphore *s
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
 	waiter.flags = RWSEM_WAITING_FOR_WRITE;
-	get_task_struct(tsk);
 
 	list_add_tail(&waiter.list,&sem->wait_list);
 

--------------020103020802060401070103--
