Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272052AbTHBH5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 03:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTHBH5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 03:57:32 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:37639
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272052AbTHBH5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 03:57:31 -0400
Subject: [PATCH] bug in setpgid()? process groups and thread groups
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1059811048.18516.43.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 00:57:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think there's a bug in setpgid().  At present, it only allows the
thread group leader to change process groups, but it doesn't change the
other threads in the thread group to the new process group.

The result is that if a thread group leader changes process groups, all
the other threads are left in the old group - and they can't switch
groups for themselves.

Assuming that all the threads in a thread groups should also be in the
same process group, I think the correct action is for sys_setpgid to
also switch the thread's process group.

Since it seems that the non-leader threads in the thread group are not
attached to the process group, all that needs to be done is for their
pgrp fields to be updated.  Patch against 2.6.0-test2-mm2 attached.

(Why does this matter?  I'm trying to do terminal I/O in threads in a
job control environment.  No, thanks, I'm perfectly sane.)

	J

 kernel/sys.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -puN kernel/sys.c~thread-pgrp kernel/sys.c
--- local-2.6/kernel/sys.c~thread-pgrp	2003-08-02 00:33:06.340860431 -0700
+++ local-2.6-jeremy/kernel/sys.c	2003-08-02 00:38:13.929221706 -0700
@@ -987,6 +987,18 @@ ok_pgid:
 		p->pgrp = pgid;
 		attach_pid(p, PIDTYPE_PGID, pgid);
 	}
+
+	{
+		/* update all threads in thread group 
+		   to new process group */
+		struct task_struct *p;
+		struct pid *pidp;
+		struct list_head *l;
+
+		for_each_task_pid(pid, PIDTYPE_TGID, p, l, pidp)
+			p->pgrp = pgid;
+	}
+
 	err = 0;
 out:
 	/* All paths lead to here, thus we are safe. -DaveM */

_


