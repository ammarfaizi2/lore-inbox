Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUENKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUENKdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUENKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:33:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2288 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264192AbUENKc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:32:59 -0400
Date: Fri, 14 May 2004 16:03:23 +0530
From: Raghavan <raghav@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, dipankar@in.ibm.com, torvalds@osdl.org,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040514103322.GA6474@in.ibm.com>
Reply-To: raghav@in.ibm.com
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com> <20040511132205.4b55292a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511132205.4b55292a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following is the output of dcachebench run on the 4 kernels:

Environment - 2-way P4 Xeon 2.4MHz SMP box with 4.5GB RAM.
Tests were run for 10 iterations to calculate the milliseconds/iteration
and then mean and deviation were calculated.


Kernel version              Mean              Standard Deviation
---------------             ----              ------------------

2.6.6-rc3(baseline)         10578             221

2.6.6                       10280             110

2.6.6-bk                    10862             30

2.6.6-mm1                   10626             36

To find out if the huge performance dip between the 2.6.6
and 2.6.6-bk is because of the hash changes, I removed the hash patch
from 2.6.6-bk and applied it to 2.6.6.

2.6.6-bk with old hash      10685             34

2.6.6 with new hash         10496             125

Looks like the new hashing function has brought down the performance.
Also some code outside dcache.c and inode.c seems to have pushed down
the performance in 2.6.6-bk.

Raghav



On Tue, May 11, 2004 at 01:22:05PM -0700, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> > We can see this happening in the following numbers taken using dcachebench*
> > gathered on 2-way P4 Xeon 2.4MHz SMP box with 4.5GB RAM. The benchmark was run
> > with the following parameters and averaged over 10 runs.
> > ./dcachebench -p 32 -b testdir
> > 
> > 		Average	microseconds/iterations 	Std. Deviation
> > 		(lesser is better)
> > 2.6.6		10204					161.5
> > 2.6.6-mm1	10571					51.5
> > 
> 
> Well..  this could be anything.  If the hash is any good -mm shouldn't be
> doing significantly more locked operations.  (I think - didn't check very
> closely).
> 
> Also the inode and dentry hash algorithms were changed in -mm.  You can
> evaluate the effect of that by comparing 2.6.6 with current Linus -bk.
> 
> If we compare 2.6.6-bk with 2.6.6-mm1 and see a slowdown on SMP and no
> slowdown on UP then yup, it might be due to additional locking.
> 
> But we should evaluate the hash changes separately.
> 
> Summary:
> 
> 2.6.6-rc3:	baseline
> 2.6.6:		dentry size+alignment changes
> 2.6.6-bk: 	dentry size+alignment changes, hash changes
> 2.6.6-mm1:	dentry size+alignment changes, hash changes, lots of other stuff.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
