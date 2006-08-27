Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWH0OB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWH0OB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 10:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWH0OB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 10:01:26 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:40888 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932105AbWH0OBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 10:01:25 -0400
Date: Sun, 27 Aug 2006 22:25:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] select_bad_process: cleanup 'releasing' check
Message-ID: <20060827182538.GA1779@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "select_bad_process: kill a bogus PF_DEAD/TASK_DEAD check"

No logic changes, but imho easier to read.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/mm/oom_kill.c~	2006-08-27 20:56:23.000000000 +0400
+++ 2.6.18-rc4/mm/oom_kill.c	2006-08-27 21:58:32.000000000 +0400
@@ -205,7 +205,6 @@ static struct task_struct *select_bad_pr
 	do_posix_clock_monotonic_gettime(&uptime);
 	do_each_thread(g, p) {
 		unsigned long points;
-		int releasing;
 
 		/*
 		 * skip kernel threads and tasks which have already released
@@ -227,16 +226,15 @@ static struct task_struct *select_bad_pr
 		 * the process of exiting and releasing its resources.
 		 * Otherwise we could get an OOM deadlock.
 		 */
-		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
-						p->flags & PF_EXITING;
-		if (releasing) {
-			if (p->flags & PF_EXITING && p == current) {
-				chosen = p;
-				*ppoints = ULONG_MAX;
-				break;
-			}
-			return ERR_PTR(-1UL);
-		}
+		if ((p->flags & PF_EXITING) && p == current) {
+			chosen = p;
+			*ppoints = ULONG_MAX;
+			break;
+		}
+		if ((p->flags & PF_EXITING) ||
+				test_tsk_thread_flag(p, TIF_MEMDIE))
+			return ERR_PTR(-1UL);
+
 		if (p->oomkilladj == OOM_DISABLE)
 			continue;
 
@@ -246,6 +244,7 @@ static struct task_struct *select_bad_pr
 			*ppoints = points;
 		}
 	} while_each_thread(g, p);
+
 	return chosen;
 }
 

