Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTBQDoa>; Sun, 16 Feb 2003 22:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbTBQDoa>; Sun, 16 Feb 2003 22:44:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1177 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266645AbTBQDo3>; Sun, 16 Feb 2003 22:44:29 -0500
Date: Sun, 16 Feb 2003 19:54:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: [PATCH] fix secondary oops in sighand locking
Message-ID: <74240000.1045454047@[10.10.2.4]>
In-Reply-To: <71980000.1045449545@[10.10.2.4]>
References: <Pine.LNX.4.44.0302161620020.1609-100000@home.transmeta.com> <68480000.1045447501@[10.10.2.4]> <71980000.1045449545@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ran your patch ... but I get plenty of these now:
>> 
>> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> ...
> 
> Ah, I see what happened, I think .... the locking used to be inside
> collect_sigign_sigcatch, and you moved it out into task_sig ... but 
> there were two callers of collect_sigign_sigcatch, the other one being
> proc_pid_stat ... which now needs to have appropriate locking added to
> it as well to match the change ... I'll see if I can get something 
> together that works for that.

OK, with this small extra patch, we now survive a beating with SDET
without oops or freeze. The patch adds the locking that was removed
from collect_sigign_sigcatch to the second caller (proc_pid_stat),
as well as task_sig.

diff -urpN -X /home/fletch/.diff.exclude linus-sdet/fs/proc/array.c linus-sdet-fix/fs/proc/array.c
--- linus-sdet/fs/proc/array.c	Sun Feb 16 18:48:04 2003
+++ linus-sdet-fix/fs/proc/array.c	Sun Feb 16 18:51:34 2003
@@ -316,7 +316,12 @@ int proc_pid_stat(struct task_struct *ta
 
 	wchan = get_wchan(task);
 
-	collect_sigign_sigcatch(task, &sigign, &sigcatch);
+	sigemptyset(&sigign);
+	sigemptyset(&sigcatch);
+	read_lock(&tasklist_lock);
+	if (task->sighand)
+		collect_sigign_sigcatch(task, &sigign, &sigcatch);
+	read_unlock(&tasklist_lock);
 
 	/* scale priority and nice values from timeslices to -20..20 */
 	/* to make it look like a "normal" Unix priority/nice value  */

