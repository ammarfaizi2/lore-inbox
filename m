Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUFPQNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUFPQNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUFPQMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:12:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:28551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264098AbUFPQMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:12:36 -0400
Date: Wed, 16 Jun 2004 09:12:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7] kill(2), killpg(2) wrongly fail with EPERM
In-Reply-To: <40D07A1A.6828.1C33C7E@localhost>
Message-ID: <Pine.LNX.4.58.0406160910020.27252@ppc970.osdl.org>
References: <40D07A1A.6828.1C33C7E@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jun 2004, Michael Kerrisk wrote:
> 
> The following patch for 2.6.7 fixes the problem.  Please apply.

How about this imho nicer version instead? It results in the main loop
being just:

        success = 0;
        retval = -ESRCH;
        for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
                int err = group_send_sig_info(sig, info, p);
                success |= !err;
                retval = err;  
        }
        return success ? 0 : retval;

which seems sensible. If _any_ group-send succeeded, we want to return 
success (ie this is not a EPERM vs everything else issue).

Does this work for you?

		Linus

-----
===== kernel/signal.c 1.120 vs edited =====
--- 1.120/kernel/signal.c	Wed Jun  9 01:46:51 2004
+++ edited/kernel/signal.c	Wed Jun 16 09:09:51 2004
@@ -1071,23 +1071,19 @@
 	struct task_struct *p;
 	struct list_head *l;
 	struct pid *pid;
-	int retval;
-	int found;
+	int retval, success;
 
 	if (pgrp <= 0)
 		return -EINVAL;
 
-	found = 0;
-	retval = 0;
+	success = 0;
+	retval = -ESRCH;
 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
-		int err;
-
-		found = 1;
-		err = group_send_sig_info(sig, info, p);
-		if (!retval)
-			retval = err;
+		int err = group_send_sig_info(sig, info, p);
+		success |= !err;
+		retval = err;
 	}
-	return found ? retval : -ESRCH;
+	return success ? 0 : retval;
 }
 
 int
