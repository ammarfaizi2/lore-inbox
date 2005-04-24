Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVDXQKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVDXQKt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 12:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVDXQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 12:10:49 -0400
Received: from mf01.sitadelle.com ([212.94.174.80]:41789 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S262348AbVDXQK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 12:10:29 -0400
Message-ID: <426BC4D5.50401@tremplin-utc.net>
Date: Sun, 24 Apr 2005 18:09:57 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small load-balancer clean-up in move_tasks()
Content-Type: multipart/mixed;
 boundary="------------030605070704030609060109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605070704030609060109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here is a small clean-up which changes some goto's into loops for 
move_tasks(). It makes the code a bit easier to read (the two loops are 
explicit now) and it also reduces the number of lines. I've checked the 
patch on x86 and IA-64 (with 4 processors).

Concerning the size of the binary, on x86, depending on the options, it 
can be one instruction (4 bytes) bigger to one instruction smaller. On 
IA-64, it suprisingly saves 4 instructions (64 bytes) most of the time.

This patch was done for 2.6.12-rc1 but should apply against 2.6.12-rc3 
cleanly. It's quite trivial and makes the clode cleaner, please apply.

Eric Piel

--

Small clean-up of move_tasks(). Converts the goto's into two eplicit loops.

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>

--------------030605070704030609060109
Content-Type: text/x-patch;
 name="sched-remove-goto-move-tasks-2.6.12-rc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-remove-goto-move-tasks-2.6.12-rc1.patch"

--- linux-2.6.12-rc1/kernel/sched.c.bak	2005-04-03 00:21:07.000000000 +0200
+++ linux-2.6.12-rc1/kernel/sched.c	2005-04-03 01:08:28.000000000 +0200
@@ -1695,50 +1695,37 @@ static int move_tasks(runqueue_t *this_r
 
 new_array:
 	/* Start searching at priority 0: */
-	idx = 0;
-skip_bitmap:
-	if (!idx)
-		idx = sched_find_first_bit(array->bitmap);
-	else
-		idx = find_next_bit(array->bitmap, MAX_PRIO, idx);
-	if (idx >= MAX_PRIO) {
-		if (array == busiest->expired && busiest->active->nr_active) {
-			array = busiest->active;
-			dst_array = this_rq->active;
-			goto new_array;
-		}
-		goto out;
-	}
-
-	head = array->queue + idx;
-	curr = head->prev;
-skip_queue:
-	tmp = list_entry(curr, task_t, run_list);
-
-	curr = curr->prev;
-
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle)) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
-	}
+	for (idx = sched_find_first_bit(array->bitmap);
+	     idx < MAX_PRIO;
+	     idx = find_next_bit(array->bitmap, MAX_PRIO, idx + 1)) {
+		head = array->queue + idx;
+		for (curr = head->prev;
+		     curr != head; ) {
+			tmp = list_entry(curr, task_t, run_list);
+
+			curr = curr->prev;
+			
+			if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle))
+				continue;
 
 #ifdef CONFIG_SCHEDSTATS
-	if (task_hot(tmp, busiest->timestamp_last_tick, sd))
-		schedstat_inc(sd, lb_hot_gained[idle]);
+			if (task_hot(tmp, busiest->timestamp_last_tick, sd))
+				schedstat_inc(sd, lb_hot_gained[idle]);
 #endif
 
-	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
-	pulled++;
+			pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
+			pulled++;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
-		if (curr != head)
-			goto skip_queue;
-		idx++;
-		goto skip_bitmap;
+			/* We only want to steal up to the prescribed number of tasks. */
+			if (pulled >= max_nr_move) 
+				goto out;
+		}
 	}
+	if (array == busiest->expired && busiest->active->nr_active) {
+		array = busiest->active;
+		dst_array = this_rq->active;
+		goto new_array;
+ 	}
 out:
 	/*
 	 * Right now, this is the only place pull_task() is called,

--------------030605070704030609060109--
