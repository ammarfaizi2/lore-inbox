Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUJLXae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUJLXae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUJLXae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:30:34 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:5640 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S268065AbUJLXab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:30:31 -0400
Message-ID: <416C6915.9080201@hp.com>
Date: Tue, 12 Oct 2004 16:30:29 -0700
From: John Byrne <john.l.byrne@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Still a mm bug in the fork error path
Content-Type: multipart/mixed;
 boundary="------------010307040407050709010207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307040407050709010207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


About a month ago, the thread "[no patch] broken use of mm_release / 
activate_mm" ("http://marc.theaimsgroup.com/?t=109510277700003&r=1&w=2") 
ended up with the following patch being applied to fork.c:

@@ -1104,9 +1146,7 @@
  bad_fork_cleanup_namespace:
  	exit_namespace(p);
  bad_fork_cleanup_mm:
-	exit_mm(p);
-	if (p->active_mm)
-		mmdrop(p->active_mm);
+	mmput(p->mm);
  bad_fork_cleanup_signal:
  	exit_signal(p);
  bad_fork_cleanup_sighand:

However, the new code will panic if the thread being forked is a process 
with a NULL mm. It looks very unlikely to be hit in the real world, but 
it is possible. (My modified kernel makes it much more likely which is 
how I found it.) The attached patch is against 2.6.9-rc4. This time for 
sure!

John Byrne







--------------010307040407050709010207
Content-Type: text/x-patch;
 name="fork.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fork.patch"

diff -Nar -U4 linux-2.6.9-rc4/kernel/fork.c new/kernel/fork.c
--- linux-2.6.9-rc4/kernel/fork.c	2004-10-12 16:18:03.661895647 -0700
+++ new/kernel/fork.c	2004-10-12 15:59:14.287779998 -0700
@@ -1145,9 +1145,10 @@
 
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_mm:
-	mmput(p->mm);
+	if (p->mm)
+		mmput(p->mm);
 bad_fork_cleanup_signal:
 	exit_signal(p);
 bad_fork_cleanup_sighand:
 	exit_sighand(p);

--------------010307040407050709010207--
