Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWEDCNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWEDCNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 22:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWEDCNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 22:13:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51929 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750842AbWEDCNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 22:13:53 -0400
Message-ID: <44596362.3080207@engr.sgi.com>
Date: Wed, 03 May 2006 19:13:54 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [Patch 6/8] delay accounting usage of taskstats interface
References: <20060502061930.GC22607@in.ibm.com>
In-Reply-To: <20060502061930.GC22607@in.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>Changelog
>
>Fixes suggested by Jay Lan
>- check for tidstats before taking the mutex_lock in taskstats_exit_send()
>- add back version information for struct taskstats
>
><clip>
> 
> struct taskstats {
> 
>-	/* Version 1 */
>+	/* Delay accounting fields start
>+	 *
>+	 * All values, until comment "Delay accounting fields end" are
>+	 * available only if delay accounting is enabled, even though the last
>+	 * few fields are not delays
>+	 *
>+	 * xxx_count is the number of delay values recorded
>+	 * xxx_delay_total is the corresponding cumulative delay in nanoseconds
>+	 *
>+	 * xxx_delay_total wraps around to zero on overflow
>+	 * xxx_count incremented regardless of overflow
>+	 */
>+
>+	/* Delay waiting for cpu, while runnable
>+	 * count, delay_total NOT updated atomically
>+	 */
>+	__u64	cpu_count;
>+	__u64	cpu_delay_total;
>+
>+	/* Following four fields atomically updated using task->delays->lock */
>+
>+	/* Delay waiting for synchronous block I/O to complete
>+	 * does not account for delays in I/O submission
>+	 */
>+	__u64	blkio_count;
>+	__u64	blkio_delay_total;
>+
>+	/* Delay waiting for page fault I/O (swap in only) */
>+	__u64	swapin_count;
>+	__u64	swapin_delay_total;
>+
>+	/* cpu "wall-clock" running time
>+	 * On some architectures, value will adjust for cpu time stolen
>+	 * from the kernel in involuntary waits due to virtualization.
>+	 * Value is cumulative, in nanoseconds, without a corresponding count
>+	 * and wraps around to zero silently on overflow
>+	 */
>+	__u64	cpu_run_real_total;
>+
>+	/* cpu "virtual" running time
>+	 * Uses time intervals seen by the kernel i.e. no adjustment
>+	 * for kernel's involuntary waits due to virtualization.
>+	 * Value is cumulative, in nanoseconds, without a corresponding count
>+	 * and wraps around to zero silently on overflow
>+	 */
>+	__u64	cpu_run_virtual_total;
>+	/* Delay accounting fields end */
>+	/* version 1 ends here */
>+
>+	/* version of taskstats */
>+	__u64	version;
>  

Could you place the common field "version" before any acct subsystem
specific fields?

As a matter of fact, we do not need
'filler_avoids_empty_struct_warnings' in [patch 5/8] taskstats
interface. Replacing that field with "version" would be great!

Thanks,
 - jay


> 
>-	int filler_avoids_empty_struct_warnings;
> };
> 
> 
>  

