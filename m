Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSDEKNs>; Fri, 5 Apr 2002 05:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDEKNj>; Fri, 5 Apr 2002 05:13:39 -0500
Received: from stingr.net ([212.193.32.15]:1443 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S312447AbSDEKNf>;
	Fri, 5 Apr 2002 05:13:35 -0500
Date: Fri, 5 Apr 2002 14:13:26 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        corryk@us.ibm.com, joyg@us.ibm.com
Subject: EVMS o(1) compatibility fixes & set_tast_state cleanups
Message-ID: <20020405101326.GB10208@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	corryk@us.ibm.com, joyg@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 things.

1 - to make evms work with o(1) scheduler. replace ->nice assigmnemnts with
set_user_nice
2 - ->state assignments with set_{task,current}_state.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.231   -> 1.232  
#	drivers/evms/md_core.c	1.1     -> 1.2    
#	drivers/evms/ldev_mgr.c	1.1     -> 1.2    
#	 drivers/evms/evms.c	1.1     -> 1.2    
#	drivers/evms/md_raid5.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	stingray@stingr.net	1.232
# o(1) adoption
# --------------------------------------------
#
diff -Nru a/drivers/evms/evms.c b/drivers/evms/evms.c
--- a/drivers/evms/evms.c	Fri Apr  5 14:05:49 2002
+++ b/drivers/evms/evms.c	Fri Apr  5 14:05:49 2002
@@ -1301,7 +1301,7 @@
 	thread->tsk = current;
 
 	current->policy = SCHED_OTHER;
-	current->nice = -20;
+	set_user_nice(current, -20);
 	unlock_kernel();
 	
 	complete(thread->event);
@@ -1310,11 +1310,11 @@
 		DECLARE_WAITQUEUE(wait, current);
 
 		add_wait_queue(&thread->wqueue, &wait);
-		set_task_state(current, TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!test_bit(EVMS_THREAD_WAKEUP, &thread->flags)) {
 			schedule();
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&thread->wqueue, &wait);
 		clear_bit(EVMS_THREAD_WAKEUP, &thread->flags);
 
diff -Nru a/drivers/evms/ldev_mgr.c b/drivers/evms/ldev_mgr.c
--- a/drivers/evms/ldev_mgr.c	Fri Apr  5 14:05:49 2002
+++ b/drivers/evms/ldev_mgr.c	Fri Apr  5 14:05:49 2002
@@ -796,7 +796,7 @@
                         break;
                 schedule();
         } while (atomic_read(&bh_cb->blks_allocated));
-        tsk->state = TASK_RUNNING;
+        set_task_state(tsk, TASK_RUNNING);
         remove_wait_queue(&bh_cb->cb_wait, &wait);
 }
 
diff -Nru a/drivers/evms/md_core.c b/drivers/evms/md_core.c
--- a/drivers/evms/md_core.c	Fri Apr  5 14:05:49 2002
+++ b/drivers/evms/md_core.c	Fri Apr  5 14:05:49 2002
@@ -2677,7 +2677,7 @@
 	/*
 	 * Resync has low priority.
 	 */
-	current->nice = 19;
+	set_user_nice(current, 19);
 
 	is_mddev_idle(mddev); /* this also initializes IO event counters */
 	for (m = 0; m < SYNC_MARKS; m++) {
@@ -2756,16 +2756,16 @@
 		currspeed = (j-mddev->resync_mark_cnt)/2/((jiffies-mddev->resync_mark)/HZ +1) +1;
 
 		if (currspeed > sysctl_speed_limit_min) {
-			current->nice = 19;
+			set_user_nice(current, 19);
 
 			if ((currspeed > sysctl_speed_limit_max) ||
 					!is_mddev_idle(mddev)) {
-				current->state = TASK_INTERRUPTIBLE;
+				set_current_state(TASK_INTERRUPTIBLE);
 				md_schedule_timeout(HZ/4);
 				goto repeat;
 			}
 		} else
-			current->nice = -20;
+			set_user_nice(current, -20);
 	}
 	LOG_DEFAULT("md%d: sync done.\n",mdidx(mddev));
 	err = 0;
diff -Nru a/drivers/evms/md_raid5.c b/drivers/evms/md_raid5.c
--- a/drivers/evms/md_raid5.c	Fri Apr  5 14:05:49 2002
+++ b/drivers/evms/md_raid5.c	Fri Apr  5 14:05:49 2002
@@ -1262,7 +1262,7 @@
                         break;
                 schedule();
         } while (atomic_read(&bh_cb->blks_allocated));
-        tsk->state = TASK_RUNNING;
+        set_task_state(tsk, TASK_RUNNING);
         remove_wait_queue(&bh_cb->cb_wait, &wait);
 }
 


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
