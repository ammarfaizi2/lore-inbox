Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUBFXK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266983AbUBFXK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:10:56 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:32684 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265841AbUBFXKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:10:44 -0500
Message-ID: <40241E5A.6080105@cyberone.com.au>
Date: Sat, 07 Feb 2004 10:08:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, mjbligh@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062249.i16Mn0013884@owlet.beaverton.ibm.com>
In-Reply-To: <200402062249.i16Mn0013884@owlet.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060005010505090001070603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060005010505090001070603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rick Lindsley wrote:

>    No you definitely still need the test... this is what I mean:
>    
>           if (avg_load > this_load)
>                    *imbalance = min(max_load - avg_load, avg_load - this_load);
>            else
>                    *imbalance = 0;
>
>Ah, yes, ok. I thought you were saying it would be zero because of code
>elsewhere.  Yup, that'll work.
>
>Rick
>
>

OK, I moved the rescaling too. Andrew, please apply.



--------------060005010505090001070603
Content-Type: text/plain;
 name="sched-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-fix.patch"


From: Rick Lindsley <ricklind@us.ibm.com>

In find_busiest_group(), after we exit the do/while, we select our
imbalance.  But max_load, avg_load, and this_load are all unsigned,
so min(x,y) will make a bad choice if max_load < avg_load < this_load
(that is, a choice between two negative [very large] numbers).

Unfortunately, there is a bug when max_load never gets changed from zero
(look in the loop and think what happens if the only load on the machine
is being created by cpu groups of which we are a member). And you have
a recipe for some really bogus values for imbalance.

Even if you fix the max_load == 0 bug, there will still be times when
avg_load - this_load will be negative (thus very large) and you'll make
the decision to move stuff when you shouldn't have.

This patch allows for this_load to set max_load, which if I understand
the logic properly is correct. With this patch applied, the algorithm is
*much* more conservative ... maybe *too* conservative but that's for 
another round of testing ...



 linux-2.6-npiggin/kernel/sched.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff -puN kernel/sched.c~sched-fix kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-fix	2004-02-06 20:41:27.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-02-07 09:59:48.000000000 +1100
@@ -1407,14 +1407,13 @@ find_busiest_group(struct sched_domain *
 		total_nr_cpus += nr_cpus;
 		avg_load /= nr_cpus;
 
+		if (avg_load > max_load)
+			max_load = avg_load;
+
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
@@ -1437,11 +1436,18 @@ nextgroup:
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
+	if (avg_load >= this_load) {
+		*imbalance = min(max_load - avg_load, avg_load - this_load);
+		/* Get rid of the scaling factor, rounding *up* as we divide */
+		*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1)
+						>> SCHED_LOAD_SHIFT;
+	} else
+		*imbalance = 0;
 
 	if (*imbalance == 0) {
 		if (package_idle != NOT_IDLE && domain->flags & SD_FLAG_IDLE

_

--------------060005010505090001070603--
