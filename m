Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVLTPRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVLTPRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVLTPRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:17:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7382 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751096AbVLTPRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:17:44 -0500
Date: Tue, 20 Dec 2005 09:17:22 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Large thread wakeup (scheduling) delay spikes
Message-ID: <20051220151722.GA357@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted something about this back in October, but received little response.
Maybe others have run into problems with this since then.

I've noticed much less deterministic and more widely varying thread wakeup
(scheduling) delays on recent kernels.  Even with isolated processors, the
maximum delay to wakeup has gotten much longer (configured with or without
CONFIG_PREEMPT).

The maximum delay to wakeup is now more than 10x longer than it was in
2.6.13.4 and previous kernels, and that's on isolated processors (as much
as 300 usec on a 1GHz cpu), although nominal values remain largely unchanged.
The latest version I've tested is 2.6.15-rc5.

Delving into this further I discovered that this is due to the execution
time of file_free_rcu(), running from rcu_process_callbacks() in ksoftirqd.
It appears that the modification that caused this was:
	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ab2af1f5005069321c5d130f09cce577b03f43ef

By simply making the following change things return to more consistent
thread wakeup delays on isolated cpus, similiar to what we had on kernels
previous to the above mentioned mod (I know this change is incorrect,
it is just for test purposes):

fs/file_table.c
@@ -62,7 +62,7 @@
 
 static inline void file_free(struct file *f)
 {
-       call_rcu(&f->f_rcuhead, file_free_rcu);
+       kmem_cache_free(filp_cachep, f);
 }
 

I am wondering if there is some way we can return to consistently fast
and predictable scheduling of threads to be woken?  If not on the
system in general, maybe at least on certain specified processors?

Dimitri
