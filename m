Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbULAWSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbULAWSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbULAWSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:18:52 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:30106 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261424AbULAWSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:18:48 -0500
From: pmeda@akamai.com
Date: Wed, 1 Dec 2004 15:21:22 -0800
Message-Id: <200412012321.PAA30853@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [PATCH] sys_set/getpriority PRIO_USER semantics fix and optimisation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This change brings the semantics equivalent to 2.4 and also to what
the man page says; Also optimises by avoiding unneeded lookup in uid
cache, when who is same as the current->uid.

sys_set/getpriority is rewritten in 2.5/2.6, perhaps while transitioning
to the pid maps.  It has now semantical bug, when uid is zero.  Note
that akpm also fixed refcount leak and locking in the new functions
in changeset http://linus.bkbits.net:8080/linux-2.5/cset@1.1608.10.84

 sys.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions, 14 deletions


Signed-off-by: pmeda@akamai.com


--- linux-2.6.9-1/kernel/sys.c	Wed Dec  1 20:46:50 2004
+++ linux-2.6.9-2/kernel/sys.c	Wed Dec  1 21:47:36 2004
@@ -341,19 +341,18 @@
 			} while_each_task_pid(who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
-			if (!who)
-				user = current->user;
-			else
-				user = find_user(who);
-
-			if (!user)
-				goto out_unlock;
+			user = current->user;
+			if (!who)
+				who = current->uid;
+			else 
+				if ((who != current->uid) && !(user = find_user(who)))
+					goto out_unlock;	/* No processes for this user */
 
 			do_each_thread(g, p)
 				if (p->uid == who)
 					error = set_one_prio(p, niceval, error);
 			while_each_thread(g, p);
-			if (who)
+			if (who != current->uid)
 				free_uid(user);		/* For find_user() */
 			break;
 	}
@@ -400,13 +399,12 @@
 			} while_each_task_pid(who, PIDTYPE_PGID, p);
 			break;
 		case PRIO_USER:
+			user = current->user;
 			if (!who)
-				user = current->user;
+				who = current->uid;
 			else
-				user = find_user(who);
-
-			if (!user)
-				goto out_unlock;
+				if ((who != current->uid) && !(user = find_user(who)))
+					goto out_unlock;	/* No processes for this user */
 
 			do_each_thread(g, p)
 				if (p->uid == who) {
@@ -415,7 +413,7 @@
 						retval = niceval;
 				}
 			while_each_thread(g, p);
-			if (who)
+			if (who != current->uid)
 				free_uid(user);		/* for find_user() */
 			break;
 	}
