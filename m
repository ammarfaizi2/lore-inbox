Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDEFlz>; Thu, 5 Apr 2001 01:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDEFlq>; Thu, 5 Apr 2001 01:41:46 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:45205 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S132555AbRDEFlb>; Thu, 5 Apr 2001 01:41:31 -0400
Date: Wed, 04 Apr 2001 22:41:44 -0700
From: Scott Maxwell <maxwell@ScottMaxwell.org>
Subject: [PATCH] SysV IPC, kernel 2.4.3
To: linux-kernel@vger.kernel.org
Cc: manfreds@colorfullife.com
Message-id: <3ACC0598.5154A28E@ScottMaxwell.org>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.12-20 i686)
Content-type: multipart/mixed; boundary="------------2D0317700118835235F0F8CA"
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2D0317700118835235F0F8CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch contains several small bug fixes and micro-optimizations
for SysV IPC code in the 2.4.3 kernel.  Summary:

	* testmsg(): "return expr;" beats "if (expr) return 1; ... return 0;"
	* pipelined_send() was setting q_lspid instead of q_lrpid.
	* sys_msgrcv() had redundant found_msg assignments.
	* freeundos() had unused parameter (sma).
	* ipc_alloc(): Kernel oops if initial allocation failed.

I'm having unrelated problems getting 2.4.3 to work with my test
hardware, so I have tested these changes under 2.4.1 only.  They work
fine for me under 2.4.1, though.  Please email me if you see any
problems or if Netscape mail mangles this post (I haven't tried this
before).  Thanks.

-- 
-------------------------+--------------------------------------------
R H L U  Scott Maxwell:  | ``Life results from the non-random survival
E A I X     maxwell@     |   of randomly varying replicators.''
D T N 6 ScottMaxwell.org |     -- Richard Dawkins
--------------2D0317700118835235F0F8CA
Content-Type: text/plain; charset=us-ascii;
 name="ipc-microfixes-2.4.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipc-microfixes-2.4.3.patch"

diff -urN linux-2.4.3/ipc/msg.c linux/ipc/msg.c
--- linux-2.4.3/ipc/msg.c	Mon Feb 19 10:18:18 2001
+++ linux/ipc/msg.c	Wed Apr  4 00:38:21 2001
@@ -582,17 +582,11 @@
 		case SEARCH_ANY:
 			return 1;
 		case SEARCH_LESSEQUAL:
-			if(msg->m_type <=type)
-				return 1;
-			break;
+			return msg->m_type <=type;
 		case SEARCH_EQUAL:
-			if(msg->m_type == type)
-				return 1;
-			break;
+			return msg->m_type == type;
 		case SEARCH_NOTEQUAL:
-			if(msg->m_type != type)
-				return 1;
-			break;
+			return msg->m_type != type;
 	}
 	return 0;
 }
@@ -613,7 +607,8 @@
 				wake_up_process(msr->r_tsk);
 			} else {
 				msr->r_msg = msg;
-				msq->q_lspid = msr->r_tsk->pid;
+				/* Was q_lspid; surely, this was the intent. */
+				msq->q_lrpid = msr->r_tsk->pid;
 				msq->q_rtime = CURRENT_TIME;
 				wake_up_process(msr->r_tsk);
 				return 1;
@@ -753,10 +748,8 @@
 		if(testmsg(msg,msgtyp,mode)) {
 			found_msg = msg;
 			if(mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
-				found_msg=msg;
 				msgtyp=msg->m_type-1;
 			} else {
-				found_msg=msg;
 				break;
 			}
 		}
diff -urN linux-2.4.3/ipc/sem.c linux/ipc/sem.c
--- linux-2.4.3/ipc/sem.c	Mon Feb 19 10:18:18 2001
+++ linux/ipc/sem.c	Mon Apr  2 20:51:37 2001
@@ -775,7 +775,7 @@
 	}
 }
 
-static struct sem_undo* freeundos(struct sem_array *sma, struct sem_undo* un)
+static struct sem_undo* freeundos(struct sem_undo* un)
 {
 	struct sem_undo* u;
 	struct sem_undo** up;
@@ -878,7 +878,7 @@
 			if(un->semid==semid)
 				break;
 			if(un->semid==-1)
-				un=freeundos(sma,un);
+				un=freeundos(un);
 			 else
 				un=un->proc_next;
 		}
diff -urN linux-2.4.3/ipc/util.c linux/ipc/util.c
--- linux-2.4.3/ipc/util.c	Mon Feb 19 10:18:18 2001
+++ linux/ipc/util.c	Mon Apr  2 20:39:55 2001
@@ -75,7 +75,8 @@
 		ids->size = 0;
 	}
 	ids->ary = SPIN_LOCK_UNLOCKED;
-	for(i=0;i<size;i++)
+	/* Was looping i=[0..size], causing kernel panic if alloc failed. */
+	for(i=0;i<ids->size;i++)
 		ids->entries[i].p = NULL;
 }
 

--------------2D0317700118835235F0F8CA--

