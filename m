Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267477AbUHTRf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267477AbUHTRf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268408AbUHTRf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:35:28 -0400
Received: from holomorphy.com ([207.189.100.168]:62921 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267477AbUHTRfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:35:17 -0400
Date: Fri, 20 Aug 2004 10:35:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
Message-ID: <20040820173511.GI11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <200408191216.33667.jbarnes@engr.sgi.com> <20040819230315.GE11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819230315.GE11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 04:03:15PM -0700, William Lee Irwin III wrote:
> Not tremendously intelligent, as concurrent readers of /proc/profile
> can render each other's results gibberish, however, this should
> mitigate some of the cacheline bouncing of prof_buffer.
> Some kind of proper IO should be possible given sufficient effort, but
> I gave up immediately when my first attempt didn't work, and this
> should be enough for getting /proc/profile to stop bouncing madly for
> users that can tolerate the concurrent IO constraint. I suppose that
> in principle one could hackishly guard collation and copying of
> prof_buffer with a semaphore in the per-cpu case. I'll work on fixing
> this eventually.
> Use perpcu_profile on the kernel command line to activate the feature.

This fixes the degenerate collate_per_cpu_profiles() behavior jbarnes
saw with this patch alone.


Index: mm2-2.6.8.1/kernel/profile.c
===================================================================
--- mm2-2.6.8.1.orig/kernel/profile.c	2004-08-19 15:11:40.000000000 -0700
+++ mm2-2.6.8.1/kernel/profile.c	2004-08-20 09:32:08.986630798 -0700
@@ -251,16 +251,15 @@
 
 static void collate_per_cpu_profiles(void)
 {
-	unsigned long i;
+	int cpu;
 
-	for (i = 0; i < prof_len; ++i)  {
-		int cpu;
+	memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
+	for_each_online_cpu(cpu) {
+		unsigned long i;
+		atomic_t *buf per_cpu(cpu_prof_buffer, cpu);
 
-		atomic_set(&prof_buffer[i], 0);
-		for_each_online_cpu(cpu) {
-			atomic_t *buf = per_cpu(cpu_prof_buffer, cpu);
-			atomic_add(atomic_read(&buf[i]), &prof_buffer[i]);
-		}
+		for (i = 0; i < prof_len; ++i)
+			prof_buffer[i].counter += atomic_read(&buf[i]);
 	}
 }
 
