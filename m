Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTKXJhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKXJhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:37:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12536 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263693AbTKXJhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:37:18 -0500
Date: Mon, 24 Nov 2003 15:12:49 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test9-mm3 - AIO test results
Message-ID: <20031124094249.GA11349@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031112233002.436f5d0c.akpm@osdl.org> <1068761038.1805.35.camel@ibm-c.pdx.osdl.net> <20031117052518.GA11184@in.ibm.com> <1069118109.1842.31.camel@ibm-c.pdx.osdl.net> <1069119433.1842.43.camel@ibm-c.pdx.osdl.net> <20031118115520.GA4291@in.ibm.com> <1069199273.1906.14.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069199273.1906.14.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 03:47:53PM -0800, Daniel McNeil wrote:
> Suparna,
> 
> I was unable to reproduce the hang in io_submit() without your patch.
> I ran aiocp with 1k i/o size constantly for 2 hours and it never hung.
> 
> I re-ran with your patch with both as-iosched and deadline and both
> hung in io_submit().  aiocp would run a few times, but I put the
> aiocp in a while loop and it hung on the 1st or 2nd time.  It
> did get most of the way through copying the file before hanging.
> This is on a 2-proc to ide disks running ext3.
> 

Found one race ... not sure if its the one causing the hangs
you see. The attached patch is not a complete fix (there is one
other race to close), but it would be interesting to see if 
this makes any difference for you.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

------------------------------------------------------
Don't access dio fields if its possible that the dio could 
already have been freed asynchronously during i/o completion.
Fixme: This still leaves a window between decrement of
bio_count and accessing dio->waiter during i/o completion 
wherein the dio could get freed by the submission path.


--- pure-mm3/fs/direct-io.c	2003-11-24 13:00:33.000000000 +0530
+++ linux-2.6.0-test9-mm3/fs/direct-io.c	2003-11-24 14:15:30.000000000 +0530
@@ -994,14 +995,17 @@
 	 * reflect the number of to-be-processed BIOs.
 	 */
 	if (dio->is_async) {
-		if (ret == 0)
-			ret = dio->result;
-		if (ret > 0 && dio->result < dio->size && rw == WRITE) {
+		int should_wait = 0;
+
+		if (dio->result < dio->size && rw == WRITE) {
 			dio->waiter = current;
+			should_wait = 1;
 		}
+		if (ret == 0)
+			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_queues();
-		if (dio->waiter) {
+		if (should_wait) {
 			/*
 			 * Wait for already issued I/O to drain out and
 			 * release its references to user-space pages
@@ -1013,7 +1017,7 @@
 				set_current_state(TASK_UNINTERRUPTIBLE);
 			}
 			set_current_state(TASK_RUNNING);
-			dio->waiter = NULL;
+			kfree(dio);
 		}
 	} else {
 		finished_one_bio(dio);
