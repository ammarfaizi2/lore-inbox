Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTIWNlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbTIWNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:41:36 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:45024 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263365AbTIWNl1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:41:27 -0400
Date: Tue, 23 Sep 2003 21:47:23 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Maneesh Soni <maneesh@in.ibm.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] autofs4 deadlock during expire - kernel 2.6
Message-ID: <Pine.LNX.4.44.0309232125010.2341-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed that a deadlock can occur in the autofs4 module in the 2.6 
kernel and RedHat kernels with the O(1) scheduler patch. The easiest way 
to reproduce it is with an autofs-4.0.0 tree mount with at least 10 mounts 
within a Nautilus desktop environment with the module debug flag set. 
Perhaps this is because of the longish amount of time spent in the expire 
state.

The scenario:

1) An expire locates an expirable dentry and signals the user space 
daemon to umount it.
2) During the umount operation Nautilus notices and scans entries in the 
directory tree triggering a revalidate/lookup.
3) autofs4 places the requesting process on the umount wait queue. 
4) At completion of the expire both process are released from the wait 
queue.
5) If the lookup gets a quantum first deadlock occurs and expiration stops 
leaving an autofs mount that is permanently busy.

The following patch fixes this by ensuring that the expire gets a lookin 
before the revalidate/lookup continues.

The problem of the remount that this causes remains and I an not sure how 
to deal with that at this stage.

Comments and suggestions please.

Is this acceptable for inclusion in the kernel?
If so what should I do to make this happen?

diff -Nur autofs4-2.6.orig/fs/autofs4/autofs_i.h autofs4-2.6.deadlock/fs/autofs4/autofs_i.h
--- autofs4-2.6.orig/fs/autofs4/autofs_i.h	2003-09-09 03:50:14.000000000 +0800
+++ autofs4-2.6.deadlock/fs/autofs4/autofs_i.h	2003-09-22 22:48:11.000000000 +0800
@@ -82,6 +82,7 @@
 	char *name;
 	/* This is for status reporting upon return */
 	int status;
+	struct task_struct *owner;
 	int wait_ctr;
 };
 
diff -Nur autofs4-2.6.orig/fs/autofs4/waitq.c autofs4-2.6.deadlock/fs/autofs4/waitq.c
--- autofs4-2.6.orig/fs/autofs4/waitq.c	2003-09-09 03:50:31.000000000 +0800
+++ autofs4-2.6.deadlock/fs/autofs4/waitq.c	2003-09-23 00:02:29.209789432 +0800
@@ -206,6 +206,11 @@
 
 		interruptible_sleep_on(&wq->queue);
 
+		if (waitqueue_active(&wq->queue) && current != wq->owner) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(wq->wait_ctr * (HZ/10));
+		}
+
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

