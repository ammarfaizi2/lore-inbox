Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSIXIxf>; Tue, 24 Sep 2002 04:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSIXIxf>; Tue, 24 Sep 2002 04:53:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9136 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261616AbSIXIxe>;
	Tue, 24 Sep 2002 04:53:34 -0400
Date: Tue, 24 Sep 2002 11:06:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [patch] pgrp-fix-2.5.38-A2
Message-ID: <Pine.LNX.4.44.0209241059480.12690-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against BK-curr, fixes the emacs bug reported by
Andries. It should probably also fix other, terminal handling related
weirdnesses introduced by the new PID handling code in 2.5.38.

the bug was in the session_of_pgrp() function, if no proper session is
found in the process group then we must take the session ID from the
process that has pgrp PID (which does not necesserily have to be part of
the pgrp). The fallback code is only triggered when no process in the
process group has a valid session - besides being faster, this also
matches the old implementation.

[ hey, who needs a POSIX conformance testsuite when we have emacs! ;) ]

	Ingo

--- linux/kernel/exit.c.orig	Tue Sep 24 10:29:09 2002
+++ linux/kernel/exit.c	Tue Sep 24 10:58:40 2002
@@ -131,9 +131,14 @@
 	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid)
 		if (p->session > 0) {
 			sid = p->session;
-			break;
+			goto out;
 		}
+	p = find_task_by_pid(pgrp);
+	if (p)
+		sid = p->session;
+out:
 	read_unlock(&tasklist_lock);
+	
 	return sid;
 }
 

