Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSJXM0L>; Thu, 24 Oct 2002 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSJXM0L>; Thu, 24 Oct 2002 08:26:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38393 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265423AbSJXM0K>;
	Thu, 24 Oct 2002 08:26:10 -0400
Date: Thu, 24 Oct 2002 18:08:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021024180809.D11418@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com> <3DB7AC97.D31A3CB2@digeo.com> <20021024171528.D5311@in.ibm.com> <20021024114740.78FD37CD3@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024114740.78FD37CD3@oscar.casa.dyndns.org>; from tomlins@cam.org on Thu, Oct 24, 2002 at 12:01:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 12:01:31PM +0000, Ed Tomlinson wrote:
> Maneesh Soni wrote:
> >> Oh.  It was in -mm3 too.  But something went wrong with the
> >> dcache shrinking there.
> > 
> > Backing out larger-cpu-masks.patch fixes this in -mm3 so, -mm4 should not
> > give this problem. Basically callbacks are not getting processed due to
> > incorrect rcu_cpu_mask.
> 
> Would this affect UP systems?  Had the dentry leak on a UP box with 512m 
> memory.  About 400m ended up in unfreeable dentries...

It does affect UP systems.

A quick look at /proc/rcu in a leaky system indicated that somehow
despite having a batch of RCUs, they are not getting started.

 /* Fake initialization required by compiler */
@@ -106,10 +106,11 @@ static void rcu_start_batch(long newbatc
 		rcu_ctrlblk.maxbatch = newbatch;
 	}
 	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
-	    (rcu_ctrlblk.rcu_cpu_mask != 0)) {
+	    (find_first_bit(rcu_ctrlblk.rcu_cpu_mask, NR_CPUS) != NR_CPUS)) {
 		return;
 	}
-	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+	memcpy(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map,
+	       sizeof(rcu_ctrlblk.rcu_cpu_mask));
 }

Either find_first_bit() is not returning NR_CPUS when the bitmask has no
bit set or memcpy is not working on the UP version of cpu_online_map. Will
dig a little bit more.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
