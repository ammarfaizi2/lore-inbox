Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSFFG55>; Thu, 6 Jun 2002 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSFFG54>; Thu, 6 Jun 2002 02:57:56 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:47010 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316831AbSFFG5y>; Thu, 6 Jun 2002 02:57:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: [PATCH] Futex II: Copy-from-user can fail.
Date: Thu, 06 Jun 2002 17:02:19 +1000
Message-Id: <E17FrHn-0003jK-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so AFAICT copy_from_user can fail, so shouldn't BUG.

Name: Copy-from-user FUTEX bugfix
Author: Rusty Russell
Status: Tested on 2.5.20

D: This patch handles the case where copy_from_user fails (it could
D: have been unmapped from this address space by another thread).

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.18383/kernel/futex.c linux-2.5.20.18383.updated/kernel/futex.c
--- linux-2.5.20.18383/kernel/futex.c	Sat May 25 14:35:00 2002
+++ linux-2.5.20.18383.updated/kernel/futex.c	Wed Jun  5 19:00:47 2002
@@ -155,13 +155,14 @@
 	set_current_state(TASK_INTERRUPTIBLE);
 	queue_me(head, &q, page, offset);
 
-	/* Page is pinned, can't fail */
-	if (get_user(curval, uaddr) != 0)
-		BUG();
+	/* Page is pinned, but may no longer be in this address space. */
+	if (get_user(curval, uaddr) != 0) {
+		ret = -EFAULT;
+		goto out;
+	}
 
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		set_current_state(TASK_RUNNING);
 		goto out;
 	}
 	time = schedule_timeout(time);
@@ -174,6 +175,7 @@
 		goto out;
 	}
  out:
+	set_current_state(TASK_RUNNING);
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
 		return 0;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
