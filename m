Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUIHOSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUIHOSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUIHOSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:18:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:30141 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269157AbUIHOQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:16:40 -0400
Message-ID: <413F1518.7050608@sgi.com>
Date: Wed, 08 Sep 2004 09:20:08 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet>
In-Reply-To: <20040907212051.GC3492@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------090209060903040403020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090209060903040403020800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Marcelo Tosatti wrote:

> 
> Andrew, dirty_ratio and dirty_background_ratio (as low as 5% each) did not significantly 
> affect the amount of swapped out data, only a small effect on _how soon_ anonymous 
> memory was swapped out.
> 

I looked at the get_dirty_limits() code and for the test cases I was running,
we have mapped > 90% of memory.  So what will happen is that dirty_ratio will 
be thresholded at 5%, and background_ratio will be 1%.  Changing values in 
/proc won't modify this at all (well, you could force background_ratio to 0%.)

It seems to me that the 5% number in there is more or less arbitrary.  If we 
are on a big memory Altix (4 TB), 5% of memory would be 200 GB. That is a lot 
of page cache.

It seems get_dirty_limits() would be a lot simpler (and automatically scale as 
memory is mapped) if the limits were interpreted as being in terms of the 
amount of unmapped memory.  A patch that implements this idea is attached.
(Andrew -- if it comes to that I can submit this patch inline -- this is just 
for talking at the moment).

I'll run a few of the tests with this modified kernel and see if they are any 
different.

> And finally, Ray, the difference you see between 2.6.6 and 2.6.7 can be explained, 
> as noted by others in this thread, to vmscan.c changes (page replacement/scanning policy
> changes were made).

Yep.  I can probably live with those minor differences though.  I would be 
happier if the system didn't swap anything at all for low values of 
swappiness, though.

> 
> Will continue with more tests tomorrow.
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

--------------090209060903040403020800
Content-Type: text/plain;
 name="dirty-limits-in-terms-of-unmapped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dirty-limits-in-terms-of-unmapped.patch"

Index: linux-2.6.9-rc1-mm3-kdb/mm/page-writeback.c
===================================================================
--- linux-2.6.9-rc1-mm3-kdb.orig/mm/page-writeback.c	2004-09-03 10:18:57.000000000 -0700
+++ linux-2.6.9-rc1-mm3-kdb/mm/page-writeback.c	2004-09-07 14:46:24.000000000 -0700
@@ -135,32 +135,19 @@
 static void
 get_dirty_limits(struct writeback_state *wbs, long *pbackground, long *pdirty)
 {
-	int background_ratio;		/* Percentages */
-	int dirty_ratio;
-	int unmapped_ratio;
+	int unmapped;
 	long background;
 	long dirty;
 	struct task_struct *tsk;
 
 	get_writeback_state(wbs);
 
-	unmapped_ratio = 100 - (wbs->nr_mapped * 100) / total_pages;
 
-	dirty_ratio = vm_dirty_ratio;
-	if (dirty_ratio > unmapped_ratio / 2)
-		dirty_ratio = unmapped_ratio / 2;
+	unmapped = total_pages - wbs->nr_mapped;
 
-	if (dirty_ratio < 5)
-		dirty_ratio = 5;
+	background = (dirty_background_ratio * unmapped) / 100;
+	dirty      = (vm_dirty_ratio * unmapped) / 100;
 
-	/*
-	 * Keep the ratio between dirty_ratio and background_ratio roughly
-	 * what the sysctls are after dirty_ratio has been scaled (above).
-	 */
-	background_ratio = dirty_background_ratio * dirty_ratio/vm_dirty_ratio;
-
-	background = (background_ratio * total_pages) / 100;
-	dirty = (dirty_ratio * total_pages) / 100;
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;

--------------090209060903040403020800--

