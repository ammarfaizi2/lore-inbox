Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULIS2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULIS2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 13:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbULIS2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 13:28:38 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:33201 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261578AbULIS2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 13:28:05 -0500
Message-ID: <41B898F8.6060500@colorfullife.com>
Date: Thu, 09 Dec 2004 19:27:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Kerrisk <mtk-lkml@gmx.net>, alan@redhat.com,
       michael.kerrisk@gmx.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix missing wakeup in ipc/sem
References: <25686.1102607983@www38.gmx.net>
In-Reply-To: <25686.1102607983@www38.gmx.net>
Content-Type: multipart/mixed;
 boundary="------------000404020804010404040007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404020804010404040007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

My patch that removed the spin_lock calls from the tail of
sys_semtimedop introduced a bug:
Before my patch was merged, every operation that altered an array called
update_queue. That call woke up threads that were waiting until a
semaphore value becomes 0. I've accidentially removed that call.

The attached patch fixes that by modifying update_queue: the function
now loops internally and wakes up all threads. The patch also removes
update_queue calls from the error path of sys_semtimedop: failed
operations do not modify the array, no need to rescan the list of
waiting threads.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>




--------------000404020804010404040007
Content-Type: text/plain;
 name="patch-ipcsem-wakeupfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipcsem-wakeupfix"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 10
//  EXTRAVERSION =-rc2-mm4
--- 2.6/include/linux/sem.h	2004-12-05 16:20:31.000000000 +0100
+++ build-2.6/include/linux/sem.h	2004-12-09 18:39:58.000000000 +0100
@@ -109,6 +109,7 @@ struct sem_queue {
 	int			id;	 /* internal sem id */
 	struct sembuf *		sops;	 /* array of pending operations */
 	int			nsops;	 /* number of operations */
+	int			alter;   /* does the operation alter the array? */
 };
 
 /* Each task has a list of undo requests. They are executed automatically
--- 2.6/ipc/sem.c	2004-12-05 16:21:39.000000000 +0100
+++ build-2.6/ipc/sem.c	2004-12-09 19:13:19.000000000 +0100
@@ -358,8 +358,22 @@ static void update_queue (struct sem_arr
 		if (error <= 0) {
 			struct sem_queue *n;
 			remove_from_queue(sma,q);
-			n = q->next;
 			q->status = IN_WAKEUP;
+			/*
+			 * Continue scanning. The next operation
+			 * that must be checked depends on the type of the
+			 * completed operation:
+			 * - if the operation modified the array, then
+			 *   restart from the head of the queue and
+			 *   check for threads that might be waiting
+			 *   for semaphore values to become 0.
+			 * - if the operation didn't modify the array,
+			 *   then just continue.
+			 */
+			if (q->alter)
+				n = sma->sem_pending;
+			else
+				n = q->next;
 			wake_up_process(q->sleeper);
 			/* hands-off: q will disappear immediately after
 			 * writing q->status.
@@ -1119,8 +1133,11 @@ retry_undos:
 		goto out_unlock_free;
 
 	error = try_atomic_semop (sma, sops, nsops, un, current->tgid);
-	if (error <= 0)
-		goto update;
+	if (error <= 0) {
+		if (alter && error == 0)
+			update_queue (sma);
+		goto out_unlock_free;
+	}
 
 	/* We need to sleep on this operation, so we put the current
 	 * task into the pending queue and go to sleep.
@@ -1132,6 +1149,7 @@ retry_undos:
 	queue.undo = un;
 	queue.pid = current->tgid;
 	queue.id = semid;
+	queue.alter = alter;
 	if (alter)
 		append_to_queue(sma ,&queue);
 	else
@@ -1183,9 +1201,6 @@ retry_undos:
 	remove_from_queue(sma,&queue);
 	goto out_unlock_free;
 
-update:
-	if (alter)
-		update_queue (sma);
 out_unlock_free:
 	sem_unlock(sma);
 out_free:

--------------000404020804010404040007--
