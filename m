Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTEAETr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTEAETr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:19:47 -0400
Received: from holomorphy.com ([66.224.33.161]:60375 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262294AbTEAETq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:19:46 -0400
Date: Wed, 30 Apr 2003 21:32:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501043203.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030429155731.07811707.akpm@digeo.com> <20030430031914.GC8978@holomorphy.com> <20030429214537.7c6a6aaf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429214537.7c6a6aaf.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> With that in addition to the OOM killer locking patch I posted and
>> another to completely eliminate mm-less processes from consideration
>> 64GB ia32 (with, of course, my oversized out-of-tree patch) recovers
>> from OOM instead of deadlocking after a mass-killing with swap online.

On Tue, Apr 29, 2003 at 09:45:37PM -0700, Andrew Morton wrote:
> Wanna send patch?

out_of_memory() needs to check to be sure ZONE_NORMAL isn't exhausted.
In order to avoid potential regressions on non-highmem systems, make
the check (#ifdef-lessly) conditional on highmem support.

vs. current bk (which has the locking for oom's operational variables)

diff -prauN linux-2.5.68-9/mm/oom_kill.c oom-2.5.68-2/mm/oom_kill.c
--- linux-2.5.68-9/mm/oom_kill.c        Wed Apr 23 03:15:53 2003
+++ oom-2.5.68-2/mm/oom_kill.c  Wed Apr 30 21:06:48 2003
@@ -16,6 +16,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/bootmem.h> /* for max_pfn and max_low_pfn */
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
@@ -217,9 +218,10 @@
 	unsigned long now, since;
 
 	/*
-	 * Enough swap space left?  Not OOM.
+	 * Enough swap space and ZONE_NORMAL left? Not OOM.
 	 */
-	if (nr_swap_pages > 0)
+	if (nr_swap_pages > 0 &&
+			(max_pfn == max_low_pfn || nr_free_buffer_pages() > 0))
 		return;
 
 	spin_lock(&oom_lock);
