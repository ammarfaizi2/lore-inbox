Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTBQDq7>; Sun, 16 Feb 2003 22:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTBQDq7>; Sun, 16 Feb 2003 22:46:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8709 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266735AbTBQDq5>; Sun, 16 Feb 2003 22:46:57 -0500
Date: Sun, 16 Feb 2003 19:53:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <71980000.1045449545@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302161951580.1424-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Martin J. Bligh wrote:
> 
> Ah, I see what happened, I think .... the locking used to be inside
> collect_sigign_sigcatch, and you moved it out into task_sig ... but 
> there were two callers of collect_sigign_sigcatch, the other one being
> proc_pid_stat

Doh.

This should fix it. 

		Linus

---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1055  -> 1.1056 
#	     fs/proc/array.c	1.43    -> 1.44   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/16	torvalds@home.transmeta.com	1.1056
# Do proper signal locking for the old-style /proc/stat too.
# --------------------------------------------
#
diff -Nru a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	Sun Feb 16 19:52:30 2003
+++ b/fs/proc/array.c	Sun Feb 16 19:52:30 2003
@@ -316,7 +316,13 @@
 
 	wchan = get_wchan(task);
 
-	collect_sigign_sigcatch(task, &sigign, &sigcatch);
+	read_lock(&tasklist_lock);
+	if (task->sighand) {
+		spin_lock_irq(&task->sighand->siglock);
+		collect_sigign_sigcatch(task, &sigign, &sigcatch);
+		spin_lock_irq(&task->sighand->siglock);
+	}
+	read_unlock(&tasklist_lock);		
 
 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */

