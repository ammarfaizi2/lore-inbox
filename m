Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTKIQsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTKIQsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:48:46 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:17797 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262652AbTKIQso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:48:44 -0500
Date: Sun, 09 Nov 2003 08:48:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Davide Libenzi <davidel@xmailserver.org>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-ID: <124780000.1068396507@[10.10.2.4]>
In-Reply-To: <200311100259.18883.kernel@kolivas.org>
References: <Pine.LNX.4.44.0311090747110.12198-100000@bigblue.dev.mdolabs.com> <200311100259.18883.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I ran it on the 16-way - no difference in performance. If the code is
>> > correct as was before (and I agree, it seems it was), perhaps it's just
>> > in need of a big fat comment to explain the confusion? ;-)
>> 
>> Ingo already dropped a fat comment ;) This is the relevant part:
>> 
>>  * We fend off statistical fluctuations in runqueue lengths by
>>  * saving the runqueue length during the previous load-balancing
>>  * operation and using the smaller one the current and saved lengths.
> 
> Well that was the comment that led me to make that patch. 
> 
> After discussion with mbligh it seems the confusion coming from me seeing
> ->prev_cpu_load
> as the load for that runqueue the last time we balanced; whereas it's actually 
> the load of the last runqueue checked during the balancing. 

Personally, I think the following makes the code more readable - if
several of us can't easily see what the code is doing, I think it's
a problem. I'm sure it makes me the very personification of Evil to 
suggest such a thing, but I don't care ;-) 

diff -urpN -X /home/fletch/.diff.exclude virgin/kernel/sched.c fbq_readable/kernel/sched.c
--- virgin/kernel/sched.c	Tue Sep  2 09:55:57 2003
+++ fbq_readable/kernel/sched.c	Sun Nov  9 08:44:39 2003
@@ -902,6 +902,14 @@ static inline unsigned int double_lock_b
 	return nr_running;
 }
 
+/* 
+ * macro to make the code more readable - this_rq->prev_cpu_load[i]
+ * is our local cached value of i's prev cpu_load. However, putting
+ * this_rq->prev_cpu_load into the code makes it read like it's the
+ * prev_cpu_load of this_cpu, which makes it confusing to read
+ */
+#define prev_cpu_load_cache(cpu) (this_rq->prev_cpu_load[cpu])
+
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
@@ -932,10 +940,10 @@ static inline runqueue_t *find_busiest_q
 	 * that case we are less picky about moving a task across CPUs and
 	 * take what can be taken.
 	 */
-	if (idle || (this_rq->nr_running > this_rq->prev_cpu_load[this_cpu]))
+	if (idle || (this_rq->nr_running > prev_cpu_load_cache(this_cpu)))
 		nr_running = this_rq->nr_running;
 	else
-		nr_running = this_rq->prev_cpu_load[this_cpu];
+		nr_running = prev_cpu_load_cache(this_cpu);
 
 	busiest = NULL;
 	max_load = 1;
@@ -944,11 +952,11 @@ static inline runqueue_t *find_busiest_q
 			continue;
 
 		rq_src = cpu_rq(i);
-		if (idle || (rq_src->nr_running < this_rq->prev_cpu_load[i]))
+		if (idle || (rq_src->nr_running < prev_cpu_load_cache(i)))
 			load = rq_src->nr_running;
 		else
-			load = this_rq->prev_cpu_load[i];
-		this_rq->prev_cpu_load[i] = rq_src->nr_running;
+			load = prev_cpu_load_cache(i);
+		prev_cpu_load_cache(i) = rq_src->nr_running;
 
 		if ((load > max_load) && (rq_src != this_rq)) {
 			busiest = rq_src;

