Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUBHEFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 23:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUBHEFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 23:05:49 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:3290 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262040AbUBHEFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 23:05:45 -0500
Message-ID: <4025B572.9040904@cyberone.com.au>
Date: Sun, 08 Feb 2004 15:05:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme> <40258F21.30209@cyberone.com.au> <20040208014141.GX19011@krispykreme> <4025AB00.3030601@cyberone.com.au> <20040208035721.GY19011@krispykreme>
In-Reply-To: <20040208035721.GY19011@krispykreme>
Content-Type: multipart/mixed;
 boundary="------------020408040408050702060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020408040408050702060402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Anton Blanchard wrote:

> 
>Hi,
>
>  
>
>>Yeah its because you have a lot of cpus, so the average is still
>>small. You also need something like
>>
>>if (*imbalance == 0 && max_load - this_load > SCHED_LOAD_SCALE)
>>   *imbalance = 1;
>>    
>>
>
>OK I'll give that a try.
>  
>
>  
>

Can you try this patch instead pretty please ;)

Thanks



--------------020408040408050702060402
Content-Type: text/plain;
 name="rollup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rollup.patch"

 linux-2.6-npiggin/kernel/sched.c |   52 ++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 20 deletions(-)

diff -puN kernel/sched.c~rollup kernel/sched.c
--- linux-2.6/kernel/sched.c~rollup	2004-02-08 15:03:53.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-02-08 15:03:53.000000000 +1100
@@ -1405,16 +1405,28 @@ find_busiest_group(struct sched_domain *
 
 		total_load += avg_load;
 		total_nr_cpus += nr_cpus;
-		avg_load /= nr_cpus;
+
+		/*
+		 * Load is cumulative over SD_FLAG_IDLE domains, but
+		 * spread over !SD_FLAG_IDLE domains. For example, 2
+		 * processes running on an SMT CPU puts a load of 2 on
+		 * that CPU, however 2 processes running on 2 CPUs puts
+		 * a load of 1 on that domain.
+		 *
+		 * This should be configurable so as SMT siblings become
+		 * more powerful, they can "spread" more load - for example,
+		 * the above case might only count as a load of 1.7.
+		 */
+		if (!(domain->flags & SD_FLAG_IDLE))
+			avg_load /= nr_cpus;
+
+		if (avg_load > max_load)
+			max_load = avg_load;
 
 		if (local_group) {
 			this_load = avg_load;
-			goto nextgroup;
-		}
-
-		if (avg_load >= max_load) {
+		} else if (avg_load >= max_load) {
 			busiest = group;
-			max_load = avg_load;
 			busiest_nr_cpus = nr_cpus;
 		}
 nextgroup:
@@ -1424,8 +1436,10 @@ nextgroup:
 	if (!busiest)
 		goto out_balanced;
 
-	avg_load = total_load / total_nr_cpus;
-	if (idle == NOT_IDLE && this_load >= avg_load)
+	if (!(domain->flags & SD_FLAG_IDLE))
+		avg_load = total_load / total_nr_cpus;
+
+	if (this_load >= avg_load)
 		goto out_balanced;
 
 	if (idle == NOT_IDLE && 100*max_load <= domain->imbalance_pct*this_load)
@@ -1437,20 +1451,18 @@ nextgroup:
 	 * reduce the max loaded cpu below the average load, as either of these
 	 * actions would just result in more rebalancing later, and ping-pong
 	 * tasks around. Thus we look for the minimum possible imbalance.
+	 * Negative imbalances (*we* are more loaded than anyone else) will
+	 * be counted as no imbalance for these purposes -- we can't fix that
+	 * by pulling tasks to us.  Be careful of negative numbers as they'll
+	 * appear as very large values with unsigned longs.
 	 */
-	*imbalance = min(max_load - avg_load, avg_load - this_load);
-
-	/* Get rid of the scaling factor now, rounding *up* as we divide */
-	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
-
-	if (*imbalance == 0) {
-		if (package_idle != NOT_IDLE && domain->flags & SD_FLAG_IDLE
-			&& max_load * busiest_nr_cpus > (3*SCHED_LOAD_SCALE/2))
-			*imbalance = 1;
-		else
-			busiest = NULL;
-	}
+	*imbalance = min(max_load - avg_load, avg_load - this_load) / 2;
+	/* Get rid of the scaling factor, rounding *up* as we divide */
+	*imbalance = (*imbalance + SCHED_LOAD_SCALE-1)
+					>> SCHED_LOAD_SHIFT;
 
+	if (*imbalance == 0 && (max_load - this_load) > SCHED_LOAD_SCALE)
+		*imbalance = 1;
 	return busiest;
 
 out_balanced:

_

--------------020408040408050702060402--
