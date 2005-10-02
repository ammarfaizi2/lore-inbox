Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVJBT7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVJBT7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 15:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVJBT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 15:59:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:39070 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751061AbVJBT7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 15:59:48 -0400
Date: Sun, 2 Oct 2005 16:55:30 -0300
From: Marcelo <marcelo.tosatti@cyclades.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Marcelo <marcelo.tosatti@cyclades.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, "Theodore Ts'o" <tytso@mit.edu>,
       dipankar@in.ibm.com, viro@ftp.linux.org.uk
Subject: Re: dentry_cache using up all my zone normal memory
Message-ID: <20051002195530.GA9865@xeon.cnet>
References: <433189B5.3030308@nortel.com> <433DB64B.70405@nortel.com> <20051001232211.GA21518@xeon.cnet> <433F7877.1060707@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433F7877.1060707@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 12:04:39AM -0600, Christopher Friesen wrote:
> Marcelo wrote:
> 
> >How can this be reproduced? (point to a URL if you already explained
> >that in detail).
> 
> I mentioned this earlier in the thread.  I'm running 2.6.14-rc4 on a 
> pentium-M based atca blade with a bit over 3GB of memory.  When I run 
> the "rename14" test from LTP with /tmp mounted on tmpfs, the system runs 
> out of zone normal memory and the OOM killer starts killing processes.
> 
> If I have /tmp mounted nfs, the problem doesn't occur.  If I use the 
> boot args to limit the memory to 896MB the problem doesn't occur.  If I 
> run the testcase on a dual Xeon with multiple gigs of memory, the 
> problem doesn't occur.
> 
> >Someone else on the thread said you had zillions of file descriptors
> >open?
> 
> This does not appear to be the case.  The testcase has two threads.
> 
> thread 1 loops doing the following:
> fd = creat("./rename14", 0666);
> unlink("./rename14");
> close(fd);
> 
> thread 2 loops doing:
> rename("./rename14", "./rename14xyz");
> 
> >Need to figure out they can't be freed. The kernel is surely trying it
> >(also a problem if it is not trying). How does the "slabs_scanned" field
> >of /proc/vmstats looks like?
> 
> That's something I haven't checked...will have to get back to you.
> 
> >Bharata maintains a patch to record additional statistics, haven't 
> >you tried it already?
> 
> Already tried.  You should be able to find results earlier in this thread.

Sorry, the problem is queueing of large amounts of RCU callbacks in a
short period of time, as already discussed.

Since ksoftirq is running (as can be seen from the dumps you sent), I
_guess_ that the grace period has happened already, and ksoftirq is
attempting to execute the RCU callbacks.

An important fact that causes the direct reclaim throttling to fail is
the complete lack of pagecache pages on both DMA and normal zones (zero
on both).

Can you try this hack (might need to include linux/interrupt.h and
linux/rcupdate.h)

--- mm/vmscan.c.orig    2005-10-02 16:10:05.000000000 -0300
+++ mm/vmscan.c 2005-10-02 16:27:25.000000000 -0300
@@ -953,6 +953,12 @@ int try_to_free_pages(struct zone **zone
                sc.swap_cluster_max = SWAP_CLUSTER_MAX;
                shrink_caches(zones, &sc);
                shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
+               /* throttle RCU deletion of SLAB objects if in trouble */
+               if (priority < DEF_PRIORITY/2) {
+                       synchronize_rcu();
+                       if (local_softirq_pending())
+                               do_softirq();
+               }
                if (reclaim_state) {
                        sc.nr_reclaimed += reclaim_state->reclaimed_slab;
                        reclaim_state->reclaimed_slab = 0;



