Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUBFSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUBFSdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:33:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22673 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265695AbUBFSdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:33:53 -0500
Date: Fri, 06 Feb 2004 10:33:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Rick Lindsley <ricklind@us.ibm.com>
cc: piggin@cyberone.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <205640000.1076092410@flay>
In-Reply-To: <20040206103010.GI19011@krispykreme>
References: <200402060924.i169OWx30517@owlet.beaverton.ibm.com> <20040206103010.GI19011@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch allows for this_load to set max_load, which if I understand
>> the logic properly is correct.  It then adds a check to imbalance to make
>> sure a negative number hasn't been coerced into a large positive number.
>> With this patch applied, the algorithm is *much* more conservative ...
>> maybe *too* conservative but that's for another round of testing ...
> 
> Good stuff, I just gave the patch a spin and things seem a little
> calmer. However Im still seeing a lot of balancing going on within a
> node.
> 
> Setup:
> 
> 2 threads per cpu.
> 2 nodes of 16 threads each.
> 
> I ran a single "yes > /dev/null"
> 
> And it looks like that process is bouncing around the entire node.
> Below is a 2 second average.

OK, what happens if you apply this ... does it fix it?
(not saying this is the correct solution, just debug)

M.

diff -purN -X /home/mbligh/.diff.exclude mm1/kernel/sched.c mm1-schedfix/kernel/sched.c
--- mm1/kernel/sched.c	2004-02-06 10:28:55.000000000 -0800
+++ mm1-schedfix/kernel/sched.c	2004-02-06 10:32:04.000000000 -0800
@@ -1440,15 +1440,11 @@ nextgroup:
 	 */
 	*imbalance = min(max_load - avg_load, avg_load - this_load);
 
-	/* Get rid of the scaling factor now, rounding *up* as we divide */
-	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
+	/* Get rid of the scaling factor now */
+	*imbalance = *imbalance >> SCHED_LOAD_SHIFT;
 
 	if (*imbalance == 0) {
-		if (package_idle != NOT_IDLE && domain->flags & SD_FLAG_IDLE
-			&& max_load * busiest_nr_cpus > (3*SCHED_LOAD_SCALE/2))
-			*imbalance = 1;
-		else
-			busiest = NULL;
+		busiest = NULL;
 	}
 
 	return busiest;

