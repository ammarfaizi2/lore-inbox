Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFNRYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFNRYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFNRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:24:23 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:19903 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261241AbVFNRYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:24:03 -0400
Message-ID: <42AF12A8.4060007@colorfullife.com>
Date: Tue, 14 Jun 2005 19:23:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jim Grisanzio <jim.grisanzio@sun.com>
Subject: [PATCH] optimization for sys_semtimedop() (was: Opening Day for OpenSolaris)
Content-Type: multipart/mixed;
 boundary="------------050800060201010709060705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050800060201010709060705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

semtimedop() performs a semaphore operation and if the operation cannot 
be performed immediately, then the function blocks until the timeout 
expires.
The current Linux implementation loads the timeout immediately, even if 
the operation doesn't block.
As explained in the OpenSolaris sources, this is not needed. The 
attached patch changes the Linux code.

The patch is trivial, but not tested. It shrinks the .text size by 32 
bytes on x86.

--
    Manfred

--------------050800060201010709060705
Content-Type: text/plain;
 name="patch-ipcsem-latetimeout"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipcsem-latetimeout"

--- 2.6/ipc/sem.c	2005-06-14 19:01:23.000000000 +0200
+++ build-2.6/ipc/sem.c	2005-06-14 19:00:32.000000000 +0200
@@ -1056,13 +1056,12 @@
 	struct sem_undo *un;
 	int undos = 0, alter = 0, max;
 	struct sem_queue queue;
-	unsigned long jiffies_left = 0;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
 	if (nsops > sc_semopm)
 		return -E2BIG;
-	if(nsops > SEMOPM_FAST) {
+	if (nsops > SEMOPM_FAST) {
 		sops = kmalloc(sizeof(*sops)*nsops,GFP_KERNEL);
 		if(sops==NULL)
 			return -ENOMEM;
@@ -1071,19 +1070,6 @@
 		error=-EFAULT;
 		goto out_free;
 	}
-	if (timeout) {
-		struct timespec _timeout;
-		if (copy_from_user(&_timeout, timeout, sizeof(*timeout))) {
-			error = -EFAULT;
-			goto out_free;
-		}
-		if (_timeout.tv_sec < 0 || _timeout.tv_nsec < 0 ||
-			_timeout.tv_nsec >= 1000000000L) {
-			error = -EINVAL;
-			goto out_free;
-		}
-		jiffies_left = timespec_to_jiffies(&_timeout);
-	}
 	max = 0;
 	for (sop = sops; sop < sops + nsops; sop++) {
 		if (sop->sem_num >= max)
@@ -1160,21 +1146,66 @@
 	current->state = TASK_INTERRUPTIBLE;
 	sem_unlock(sma);
 
-	if (timeout)
-		jiffies_left = schedule_timeout(jiffies_left);
-	else
+	if (timeout) {
+		/*
+		 * Neat trick mentioned in the OpenSolaris source
+		 * (but not implemented by them):
+		 * There is no need to load the timeout early, its sufficient
+		 * to load the timeout when we are about to block.
+		 * Unfortunately that makes error handling tricky:
+		 * Our request is already alive and another cpu
+		 * could fulfill it while we try to handle the error condition.
+		 * Solution: Behave as if a signal woke us up immediately
+		 * and replace the error code at the end.
+		 */
+		struct timespec _timeout;
+		if (copy_from_user(&_timeout, timeout, sizeof(*timeout))) {
+			error = -EFAULT;
+		} else if (_timeout.tv_sec < 0 || _timeout.tv_nsec < 0 ||
+			_timeout.tv_nsec >= 1000000000L) {
+			error = -EINVAL;
+		} else {
+			unsigned long jiffies_left;
+			jiffies_left = timespec_to_jiffies(&_timeout);
+			jiffies_left = schedule_timeout(jiffies_left);
+			if (jiffies_left)
+				error = -EAGAIN;
+			else
+				error = -EINTR;
+		}
+	} else {
 		schedule();
-
-	error = queue.status;
-	while(unlikely(error == IN_WAKEUP)) {
-		cpu_relax();
-		error = queue.status;
+		error = -EINTR;
 	}
 
-	if (error != -EINTR) {
-		/* fast path: update_queue already obtained all requested
-		 * resources */
-		goto out_free;
+	/*
+	 * lockless fast path:
+	 * If queue.status != -EINTR we were woken up by another semop().
+	 * But then update_queue removed us from the queue already,
+	 * we can/must exit immediately without trying to acquire the
+	 * semaphore lock.
+	 * There is no need for memory barriers: We only read
+	 * a single integer and use it as the return code. Thus
+	 * we use barrier() and copy the status code into a local
+	 * variable.
+	 */
+	{
+		int tmp;
+
+		tmp = queue.status;
+		while(unlikely(tmp == IN_WAKEUP)) {
+			cpu_relax();
+			tmp = queue.status;
+			barrier();
+		}
+		barrier();
+
+		if (tmp != -EINTR) {
+			/* fast path: update_queue already obtained all requested
+			 * resources */
+			error = tmp;
+			goto out_free;
+		}
 	}
 
 	sma = sem_lock(semid);
@@ -1185,22 +1216,16 @@
 		goto out_free;
 	}
 
-	/*
-	 * If queue.status != -EINTR we are woken up by another process
-	 */
-	error = queue.status;
-	if (error != -EINTR) {
-		goto out_unlock_free;
+	if (queue.status == -EINTR) {
+		/*
+		 * If an interrupt occurred we have to clean up the queue
+		 * ourself.
+		 */
+		remove_from_queue(sma,&queue);
+	} else {
+		error = queue.status;
 	}
 
-	/*
-	 * If an interrupt occurred we have to clean up the queue
-	 */
-	if (timeout && jiffies_left == 0)
-		error = -EAGAIN;
-	remove_from_queue(sma,&queue);
-	goto out_unlock_free;
-
 out_unlock_free:
 	sem_unlock(sma);
 out_free:

--------------050800060201010709060705--
