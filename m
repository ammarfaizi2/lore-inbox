Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWEDE0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWEDE0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 00:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWEDE0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 00:26:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15823 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751064AbWEDE0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 00:26:42 -0400
Date: Thu, 4 May 2006 09:53:33 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [Patch 6/8] delay accounting usage of taskstats interface
Message-ID: <20060504042333.GA6966@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061930.GC22607@in.ibm.com> <44596362.3080207@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44596362.3080207@engr.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 07:13:54PM -0700, Jay Lan wrote:
> Balbir Singh wrote:
> >Changelog
> >
> >Fixes suggested by Jay Lan
> >- check for tidstats before taking the mutex_lock in taskstats_exit_send()
> >- add back version information for struct taskstats
> >
> ><clip>
> > 
> > struct taskstats {
> > 
> >-	/* Version 1 */
> >+	/* Delay accounting fields start
> >+	 *
> >+	 * All values, until comment "Delay accounting fields end" are
> >+	 * available only if delay accounting is enabled, even though the last
> >+	 * few fields are not delays
> >+	 *
> >+	 * xxx_count is the number of delay values recorded
> >+	 * xxx_delay_total is the corresponding cumulative delay in nanoseconds
> >+	 *
> >+	 * xxx_delay_total wraps around to zero on overflow
> >+	 * xxx_count incremented regardless of overflow
> >+	 */
> >+
> >+	/* Delay waiting for cpu, while runnable
> >+	 * count, delay_total NOT updated atomically
> >+	 */
> >+	__u64	cpu_count;
> >+	__u64	cpu_delay_total;
> >+
> >+	/* Following four fields atomically updated using task->delays->lock */
> >+
> >+	/* Delay waiting for synchronous block I/O to complete
> >+	 * does not account for delays in I/O submission
> >+	 */
> >+	__u64	blkio_count;
> >+	__u64	blkio_delay_total;
> >+
> >+	/* Delay waiting for page fault I/O (swap in only) */
> >+	__u64	swapin_count;
> >+	__u64	swapin_delay_total;
> >+
> >+	/* cpu "wall-clock" running time
> >+	 * On some architectures, value will adjust for cpu time stolen
> >+	 * from the kernel in involuntary waits due to virtualization.
> >+	 * Value is cumulative, in nanoseconds, without a corresponding count
> >+	 * and wraps around to zero silently on overflow
> >+	 */
> >+	__u64	cpu_run_real_total;
> >+
> >+	/* cpu "virtual" running time
> >+	 * Uses time intervals seen by the kernel i.e. no adjustment
> >+	 * for kernel's involuntary waits due to virtualization.
> >+	 * Value is cumulative, in nanoseconds, without a corresponding count
> >+	 * and wraps around to zero silently on overflow
> >+	 */
> >+	__u64	cpu_run_virtual_total;
> >+	/* Delay accounting fields end */
> >+	/* version 1 ends here */
> >+
> >+	/* version of taskstats */
> >+	__u64	version;
> >  
> 
> Could you place the common field "version" before any acct subsystem
> specific fields?
> 
> As a matter of fact, we do not need
> 'filler_avoids_empty_struct_warnings' in [patch 5/8] taskstats
> interface. Replacing that field with "version" would be great!

Yes, I thought about it and wanted to put it upfront. To maintain compatibility
with the previous post, I decided to add it to the end.

If putting the version right up helps the readability of taskstats.h,
I can make the changes and repost the patches again.

Thanks for your review,
Balbir

