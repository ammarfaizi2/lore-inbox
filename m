Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWI2T6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWI2T6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWI2T6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:58:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422688AbWI2T6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:58:46 -0400
Message-ID: <451D7C02.2090907@redhat.com>
Date: Fri, 29 Sep 2006 16:03:14 -0400
From: Larry Woodman <lwoodman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040301
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: oom kill oddness.
Content-Type: multipart/mixed;
 boundary="------------010606060904020809010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606060904020809010901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>So I have two boxes that are very similar.
>Both have 2GB of RAM & 1GB of swap space.
>One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.
>
>The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
>without incident. (Although it takes ~4 minutes longer than a -j2)
>
>The faster box goes absolutely nuts, oomkilling everything in sight,
>until eventually after about 10 minutes, the box locks up dead,
>and won't even respond to pings.
>
>Oh, the only other difference - the slower box has 1 disk, whereas the
>faster box has two in RAID0.   I'm not surprised that stuff is getting
>oom-killed given the pathological scenario, but the fact that the
>box never recovered at all is a little odd.  Does md lack some means
>of dealing with low memory scenarios ?
>
>	Dave
>
Dave, this has been a problem since the out_of_memory() function was 
changed
between 2.6.10 and 2.6.11.  Before this change out_of_memory() required 
multiple
calls within 5 seconds before actually OOM killed a process.  After the 
change(in 2.6.11)
a single call to out_of_memory() results in OOM killing a process.  The 
following patch
allows the 2.6.18 system to run under much more memory pressure before 
it OOM kills.




--------------010606060904020809010901
Content-Type: text/plain;
 name="oomkill.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oomkill.patch"

--- linux-2.6.18.noarch/mm/oom_kill.c.orig
+++ linux-2.6.18.noarch/mm/oom_kill.c
@@ -306,6 +306,69 @@ static int oom_kill_process(struct task_
 	return oom_kill_task(p, message);
 }
 
+int should_oom_kill(void)
+{
+	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long first, last, count, lastkill;
+	unsigned long now, since;
+	int ret = 0;
+
+	spin_lock(&oom_lock);
+	now = jiffies;
+	since = now - last;
+	last = now;
+
+	/*
+	 * If it's been a long time since last failure,
+	 * we're not oom.
+	 */
+	if (since > 5*HZ)
+		goto reset;
+
+	/*
+	 * If we haven't tried for at least one second,
+	 * we're not really oom.
+	 */
+	since = now - first;
+	if (since < HZ)
+		goto out_unlock;
+
+	/*
+	 * If we have gotten only a few failures,
+	 * we're not really oom.
+	 */
+	if (++count < 10)
+		goto out_unlock;
+
+	/*
+	 * If we just killed a process, wait a while
+	 * to give that task a chance to exit. This
+	 * avoids killing multiple processes needlessly.
+	 */
+	since = now - lastkill;
+	if (since < HZ*5)
+		goto out_unlock;
+
+	/*
+	 * Ok, really out of memory. Kill something.
+	 */
+	lastkill = now;
+	ret = 1;
+
+reset:
+/*
+ * We dropped the lock above, so check to be sure the variable
+ * first only ever increases to prevent false OOM's.
+ */
+	if (time_after(now, first))
+		first = now;
+	count = 0;
+
+out_unlock:
+	spin_unlock(&oom_lock);
+	return ret;
+}
+
 /**
  * out_of_memory - kill the "best" process when we run out of memory
  *
@@ -326,6 +389,9 @@ void out_of_memory(struct zonelist *zone
 		show_mem();
 	}
 
+	if (!should_oom_kill())
+		return;
+
 	cpuset_lock();
 	read_lock(&tasklist_lock);
 
--- linux-2.6.18.noarch/mm/vmscan.c.orig
+++ linux-2.6.18.noarch/mm/vmscan.c
@@ -999,10 +999,8 @@ unsigned long try_to_free_pages(struct z
 			reclaim_state->reclaimed_slab = 0;
 		}
 		total_scanned += sc.nr_scanned;
-		if (nr_reclaimed >= sc.swap_cluster_max) {
-			ret = 1;
+		if (nr_reclaimed >= sc.swap_cluster_max)
 			goto out;
-		}
 
 		/*
 		 * Try to write back as many pages as we just scanned.  This
@@ -1030,6 +1028,8 @@ out:
 
 		zone->prev_priority = zone->temp_priority;
 	}
+	if (nr_reclaimed)
+		ret = 1;
 	return ret;
 }
 

--------------010606060904020809010901--

