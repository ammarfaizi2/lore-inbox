Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVBADwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVBADwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVBADwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:52:30 -0500
Received: from gateway.ottawa.transgaming.com ([209.217.80.34]:999 "HELO
	ottawa.transgaming.com") by vger.kernel.org with SMTP
	id S261524AbVBADwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:52:24 -0500
Subject: PATCH: SysV semaphore race vs SIGSTOP
From: Ove Kaaven <ovek@transgaming.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1106952950.15901.47.camel@renegade>
References: <1106952950.15901.47.camel@renegade>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: TransGaming Technologies Inc
Date: Mon, 31 Jan 2005 22:52:22 -0500
Message-Id: <1107229942.2371.13.camel@renegade>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I mentioned in an earlier mail, there is a race when SIGSTOP-ing a
process waiting for a SysV semaphore, where if a process holding a
semaphore suspends another process waiting on the semaphore and then
releases the semaphore, the suspended process might still get the
semaphore, resulting in a deadlock. My sample test program is at
http://www.ping.uio.no/~ovehk/sembug.c

Now I've written a patch for this which seems to work for me. It is
against 2.4.27, but the semaphore code doesn't seem to change often. And
please Cc me on any questions or comments, since I'm not subscribed.
Here is the patch:

--- ipc/sem.c.original	2005-01-31 18:17:17.000000000 -0500
+++ ipc/sem.c	2005-01-31 18:17:34.000000000 -0500
@@ -307,6 +307,18 @@
 	return result;
 }
 
+static int is_stopping(struct task_struct *t)
+{
+	if (t->state == TASK_STOPPED) {
+		/* shouldn't happen */
+		return 1;
+	}
+	if (sigismember(&t->pending.signal, SIGSTOP)) {
+		return 1;
+	}
+	return 0;
+}
+
 /* Go through the pending queue for the indicated semaphore
  * looking for tasks that can be completed.
  */
@@ -961,6 +973,12 @@
 			error = -EIDRM;
 			goto out_free;
 		}
+
+		if (is_stopping(current))
+			/* Could either EINTR out or continue.
+			 * Currently I've chosen to continue */
+			continue;
+
 		/*
 		 * If queue.status == 1 we where woken up and
 		 * have to retry else we simply return.

