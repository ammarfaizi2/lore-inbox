Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUESApr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUESApr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUESApr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:45:47 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:8410 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263745AbUESApo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:45:44 -0400
Subject: Re: ia64 cpu hotplug patch
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040518165803.A32483@unix-os.sc.intel.com>
References: <1084923956.23158.11.camel@bach>
	 <20040518165803.A32483@unix-os.sc.intel.com>
Content-Type: text/plain
Message-Id: <1084927489.23154.26.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 10:44:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 09:58, Ashok Raj wrote:
> proc_misc.c was changed, since top() uses this to read and
> display stats. With cpuhotplug cpu_possible() represents
> the entire set of NR_CPUS, all these stats with 0 values and
> top gets all dorky about it.
> 
> Maybe the right thing would be to fix the utility instead ?
> 
> Other issue i noticied was that when we have a 4 cpu system, and you 
> remove an intermediate cpu say cpu2, top utility is dorky again. And prints
> "invalid data" in the middle of the output.
> 
> Without the fix to proc_misc, if NR_CPUS is set to 128, top lists all
> 128 cpu stats even if only 4 are present and online, since 
> for_each_cpu reprensents all of it....

OK, well if you're correlating /proc/cpuinfo (online cpus) and
/proc/stat (possible cpus), then I can understand top getting upset.

Perhaps we should only show online cpus in /proc/stat, but the totals
displayed must still include all CPUs I think.

How's this version:

Name: Fix overzealous use of online cpu iterators
Status: Trivial

The IA64 hotplug CPU merge seems to have included some core changes: in
particular the recalc_bh_state() needs to sum for all (including
offline) cpus, since we don't empty the counters on CPU down.  The
totals printed by /proc/stat (the first loop) should include offline
cpus, too (apparently printing out the per-cpu lines for offline cpus
confuses top).

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


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

