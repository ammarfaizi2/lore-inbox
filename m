Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSANFhi>; Mon, 14 Jan 2002 00:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSANFhT>; Mon, 14 Jan 2002 00:37:19 -0500
Received: from alb-66-24-180-102.nycap.rr.com ([66.24.180.102]:14722 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S288794AbSANFhN>; Mon, 14 Jan 2002 00:37:13 -0500
Date: Mon, 14 Jan 2002 00:37:08 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] oom_kill() race?
Message-ID: <20020114053708.GA32597@mp3revolution.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux incandescent 2.4.10-ac12 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In oom_kill(), is there any chance the task_struct can be unmapped
between being returned from select_bad_process() (where the tasklist
is locked) and where it walks the tasklist again, looking for threads?

If so, the following patch (against 2.4.17) will clean that up; if not,
ignore this.


-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oom_fix.diff"

diff -urN linux.pristine/mm/oom_kill.c linux/mm/oom_kill.c
--- linux.pristine/mm/oom_kill.c	Mon Jan 14 05:51:13 2002
+++ linux/mm/oom_kill.c	Mon Jan 14 05:49:07 2002
@@ -110,8 +110,7 @@
 
 /*
  * Simple selection loop. We chose the process with the highest
- * number of 'points'. We need the locks to make sure that the
- * list of task structs doesn't change while we look the other way.
+ * number of 'points'. We expect the caller will lock the tasklist.
  *
  * (not docbooked, we don't want this one cluttering up the manual)
  */
@@ -121,7 +120,6 @@
 	struct task_struct *p = NULL;
 	struct task_struct *chosen = NULL;
 
-	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		if (p->pid) {
			int points = badness(p);
@@ -131,7 +129,6 @@
 			}
 		}
 	}
-	read_unlock(&tasklist_lock);
 	return chosen;
 }
 
@@ -170,14 +167,16 @@
  */
 static void oom_kill(void)
 {
-	struct task_struct *p = select_bad_process(), *q;
+	struct task_struct *p, *q;
+	
+	read_lock(&tasklist_lock);
+	p = select_bad_process();
 
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
 
 	/* kill all processes that share the ->mm (i.e. all threads) */
-	read_lock(&tasklist_lock);
 	for_each_task(q) {
 		if(q->mm == p->mm) oom_kill_task(q);
 	}

--KsGdsel6WgEHnImy--
