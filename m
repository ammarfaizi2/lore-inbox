Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSG2T5n>; Mon, 29 Jul 2002 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSG2T5n>; Mon, 29 Jul 2002 15:57:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58324 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317623AbSG2T5k>; Mon, 29 Jul 2002 15:57:40 -0400
Subject: [PATCH] Linux-2.5 fix for get_pid() hang
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Jul 2002 14:57:46 -0500
Message-Id: <1027972670.7699.210.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix for the problem where get_pid will hang the machine if you
request a new pid when all available pids are in use.  This also adds
the appropriate checking for p->tgid in get_pid that was somehow
overlooked before.  This patch has been in 2.4 since 2.4.19-pre9.

Please apply.

Paul Larson
Linux Test Project
http://ltp.sourceforge.net

diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Mon Jul 29 15:15:36 2002
+++ b/kernel/fork.c	Mon Jul 29 15:15:36 2002
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -136,12 +137,13 @@
 {
 	static int next_safe = PID_MAX;
 	struct task_struct *p;
-	int pid;
+	int pid, beginpid;
 
 	if (flags & CLONE_IDLETASK)
 		return 0;
 
 	spin_lock(&lastpid_lock);
+	beginpid = last_pid;
 	if((++last_pid) & 0xffff8000) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
@@ -161,12 +163,16 @@
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
@@ -176,6 +182,11 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -677,6 +688,8 @@
 
 	copy_flags(clone_flags, p);
 	p->pid = get_pid(clone_flags);
+	if (p->pid == 0 && !(clone_flags & CLONE_IDLETASK))
+		goto bad_fork_cleanup;
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);

