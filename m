Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269527AbUJFXTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269527AbUJFXTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJFXQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:16:11 -0400
Received: from fmr03.intel.com ([143.183.121.5]:19348 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269629AbUJFXO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:14:28 -0400
Message-Id: <200410062313.i96NDo609923@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <nickpiggin@yahoo.com.au>, <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Default cache_hot_time value back to 10ms
Date: Wed, 6 Oct 2004 16:14:06 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSr5V0gOunJ4+3qRGSPbBFTyRMu4QAEetDA
In-Reply-To: <20041006134317.03a22198.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, October 06, 2004 1:43 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> >  Secondly, let me ask the question again from the first mail thread:  this value
> >  *WAS* 10 ms for a long time, before the domain scheduler.  What's so special
> >  about domain scheduler that all the sudden this parameter get changed to 2.5?
>
> So why on earth was it switched from 10 to 2.5 in the first place?
>
> Please resend the final patch.


Here is a patch that revert default cache_hot_time value back to the equivalence
of pre-domain scheduler, which determins task's cache affinity via architecture
defined variable cache_decay_ticks.

This is a mere request that we go back to what *was* before, *NOT* as a new
scheduler tweak (Whatever tweak done for domain scheduler broke traditional/
industry recognized workload).

As a side note, I'd like to get involved on future scheduler tuning experiments,
we have fair amount of benchmark environments where we can validate things across
various kind of workload, i.e., db, java, cpu, etc.  Thanks.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

patch against 2.6.9-rc3:

--- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-06 15:10:56.000000000 -0700
+++ linux-2.6.9-rc3/kernel/sched.c	2004-10-06 15:18:51.000000000 -0700
@@ -387,7 +387,7 @@ struct sched_domain {
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
+	.cache_hot_time		= cache_decay_ticks*1000000,\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_BALANCE_NEWIDLE	\


patch against 2.6.9-rc3-mm2:

--- linux-2.6.9-rc3/include/linux/topology.h.orig	2004-10-06 15:32:48.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/topology.h	2004-10-06 15:33:25.000000000 -0700
@@ -113,7 +113,7 @@ static inline int __next_node_with_cpus(
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000/2),		\
+	.cache_hot_time		= (cache_decay_ticks*1000),\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\



