Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263734AbUERXqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUERXqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUERXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:46:48 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:46989 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263734AbUERXqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:46:46 -0400
Subject: Re: ia64 cpu hotplug patch
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040518181214.GR2151@krispykreme>
References: <20040515191217.GB24541@krispykreme>
	 <1084867279.20916.61.camel@bach> <20040518010856.24f116f7.akpm@osdl.org>
	 <20040518181214.GR2151@krispykreme>
Content-Type: text/plain
Message-Id: <1084923956.23158.11.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 09:45:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 04:12, Anton Blanchard wrote:
>  > Gack, Rusty, I wish you had less SMTP latency.  I'm not sure what
> > this is about.  If it pertains to some patch which I'm carrying, someone
> > tell me what one ;)
> 
> One of the ia64 hotplug patches that got merged. It seems they got itchy
> fingers and changed a few more things than they should have.

Precisely.  This applies against Linus' kernel:

Name: Fix overzealous use of online cpu iterators
Status: Trivial

The IA64 hotplug CPU merge seems to have included some core changes: in
particular the recalc_bh_state() needs to sum for all (including
offline) cpus, since we don't empty the counters on CPU down.  I don't
know that anyone cares about the accuracy of the /proc/stat when CPUs go
down, but certainly the totals printed (the first loop) should include
offline cpus.

diff -Nru a/fs/buffer.c b/fs/buffer.c
--- b/fs/buffer.c	Fri May 14 19:00:11 2004
+++ a/fs/buffer.c	Thu Apr 22 16:20:51 2004
@@ -3019,7 +2966,7 @@
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for_each_online_cpu(i)
+	for_each_cpu(i)
 		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- b/fs/proc/proc_misc.c	Fri May 14 23:11:58 2004
+++ a/fs/proc/proc_misc.c	Tue Mar 23 02:05:27 2004
@@ -368,7 +368,7 @@
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_online_cpu(i) {
+	for_each_cpu(i) {
 		int j;
 
 		user += kstat_cpu(i).cpustat.user;
@@ -390,7 +390,7 @@
 		(unsigned long long)jiffies_64_to_clock_t(iowait),
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
-	for_each_online_cpu(i) {
+	for_each_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kstat_cpu(i).cpustat.user;



-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

