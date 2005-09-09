Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVIIPgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVIIPgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIIPgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:36:00 -0400
Received: from colino.net ([213.41.131.56]:23037 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S964914AbVIIPf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:35:59 -0400
Date: Fri, 9 Sep 2005 17:35:43 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix oom_kill_task
X-Mailer: Sylpheed-Claws 1.9.14cvs11 (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050909153543.2E601101D8@paperstreet.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

oom_kill_task's comment states that we should be careful about not sending 
SIGKILL to processes with SYS_CAP_RAWIO, then the code happily sends it 
anyway.

Here's a patch that fixes that.

Signed-Off-By: Colin Leroy <colin@colino.net>
--- a/mm/oom_kill.c	2005-09-09 17:29:08.000000000 +0200
+++ b/mm/oom_kill.c	2005-09-09 17:29:10.000000000 +0200
@@ -199,7 +199,12 @@ static void __oom_kill_task(task_t *p)
 	p->time_slice = HZ;
 	set_tsk_thread_flag(p, TIF_MEMDIE);
 
-	force_sig(SIGKILL, p);
+	/* This process has hardware access, be more careful. */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+		force_sig(SIGTERM, p);
+	} else {
+		force_sig(SIGKILL, p);
+	}
 }
 
 static struct mm_struct *oom_kill_task(task_t *p)
