Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314705AbSEVVue>; Wed, 22 May 2002 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSEVVud>; Wed, 22 May 2002 17:50:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42912 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314705AbSEVVuc>;
	Wed, 22 May 2002 17:50:32 -0400
Subject: [PATCH] 2.4.19-pre8 get_pid() hang fix again
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 May 2002 16:46:50 -0500
Message-Id: <1022104010.3429.20.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, I originally submitted this patch against 2.4.18-rc2 and I
noticed that it has not been picked up yet.  I've repatched it against
2.4.19-pre8 and retested it.  This is to fix the problem where if you
run out of available pids, get_pid will cause a hang as it loops forever
through the tasks to try to find an available pid that doesn't exist.

Thanks,
Paul Larson

--- linux-2.4.19-pre8/kernel/fork.c	Mon May 20 10:55:14 2002
+++ linux-getpid/kernel/fork.c	Wed May 22 16:07:29 2002
@@ -21,6 +21,7 @@
 #include <linux/completion.h>
 #include <linux/namespace.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -86,12 +87,13 @@
 {
 	static int next_safe = PID_MAX;
 	struct task_struct *p;
-	int pid;
+	int pid, beginpid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
+	beginpid = last_pid;
 	if((++last_pid) & 0xffff8000) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
@@ -111,12 +113,16 @@
 						last_pid = 300;
 					next_safe = PID_MAX;
 				}
+				if(unlikely(last_pid == beginpid))
+					goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
 				next_safe = p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
+			if(p->tgid > last_pid && next_safe > p->tgid)
+				next_safe = p->tgid;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}
@@ -126,6 +132,11 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -624,6 +635,8 @@
 
 	copy_flags(clone_flags, p);
 	p->pid = get_pid(clone_flags);
+	if (p->pid == 0 && current->pid != 0)
+		goto bad_fork_cleanup;
 
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;



