Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbSJBSik>; Wed, 2 Oct 2002 14:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbSJBSik>; Wed, 2 Oct 2002 14:38:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27592 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262543AbSJBSii>;
	Wed, 2 Oct 2002 14:38:38 -0400
Message-ID: <3D9B3DC4.4030209@us.ibm.com>
Date: Wed, 02 Oct 2002 11:41:08 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [rfc][patch] kernel/sched.c oddness?
Content-Type: multipart/mixed;
 boundary="------------070604020301040103000008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070604020301040103000008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This snippet of code appears wrong...  Either that, or the accompanying 
comment is wrong?

from kernel/sched.c::find_busiest_queue():

| 
*imbalance = (max_load - nr_running) / 2;
|
| 
/* It needs an at least ~25% imbalance to trigger balancing. */
| 
if (!idle && (*imbalance < (max_load + 3)/4)) {
| 
	busiest = NULL;
| 
	goto out;
| 
}

The comment says 25% imbalance, but the code is really checking for a 
~50% imbalance.  The attatched patch moves the division by two to the 
pull_task function where the imbalance number is actually used.  This 
patch makes the code match the comment, and divides the imbalance by two 
where it is needed.

Please let me know if I've misinterpreted what this code is supposed to 
be doing, -or- if we really want the comment to match the current code.

Cheers!

-Matt

--------------070604020301040103000008
Content-Type: text/plain;
 name="sched_cleanup-2.5.40.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_cleanup-2.5.40.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.40-vanilla/kernel/sched.c linux-2.5.40-sched_cleanup/kernel/sched.c
--- linux-2.5.40-vanilla/kernel/sched.c	Tue Oct  1 00:07:35 2002
+++ linux-2.5.40-sched_cleanup/kernel/sched.c	Wed Oct  2 11:22:41 2002
@@ -689,7 +689,7 @@
 	if (likely(!busiest))
 		goto out;
 
-	*imbalance = (max_load - nr_running) / 2;
+	*imbalance = (max_load - nr_running);
 
 	/* It needs an at least ~25% imbalance to trigger balancing. */
 	if (!idle && (*imbalance < (max_load + 3)/4)) {
@@ -746,6 +746,11 @@
 	task_t *tmp;
 
 	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	/*
+	 * We only want to steal a number of tasks equal to 1/2 the imbalance,
+ 	 * otherwise, we'll just shift the imbalance to the new queue.
+	 */
+	imbalance >>= 1;
 	if (!busiest)
 		goto out;
 

--------------070604020301040103000008--

