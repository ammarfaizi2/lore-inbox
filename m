Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbULMGgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbULMGgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 01:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbULMGgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 01:36:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:5033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262207AbULMGgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 01:36:01 -0500
Date: Sun, 12 Dec 2004 22:32:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: paulmck@us.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, shaohua.li@intel.com, len.brown@intel.com
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Message-Id: <20041212223249.65635f9a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412122317380.16940@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>
	<20041206111634.44d6d29c.sfr@canb.auug.org.au>
	<20041205232007.7edc4a78.akpm@osdl.org>
	<Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
	<20041206160405.GB1271@us.ibm.com>
	<Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
	<20041206192243.GC1435@us.ibm.com>
	<Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
	<20041212221327.375fa4d0.akpm@osdl.org>
	<Pine.LNX.4.61.0412122317380.16940@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> The idle thread is special in the sense that it can't get migrated so the 
>  cached values of smp_processor_id are fine.

duh, knew that.

We can use the cached value throughout, no?

--- 25/arch/i386/kernel/process.c~remove-rcu-abuse-in-cpu_idle-warning-fix	2004-12-12 22:30:10.200626944 -0800
+++ 25-akpm/arch/i386/kernel/process.c	2004-12-12 22:31:22.417648288 -0800
@@ -146,7 +146,7 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
-	int cpu = smp_processor_id();
+	int cpu = _smp_processor_id();
 
 	/* endless idle loop with no priority at all */
 	while (1) {
@@ -161,7 +161,7 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 
-			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+			irq_stat[cpu].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
_

