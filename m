Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUGPF64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUGPF64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGPF64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:58:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42489 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266163AbUGPF6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:58:54 -0400
Date: Fri, 16 Jul 2004 11:08:35 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040716053835.GA1257@obelix.in.ibm.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714045640.GB1220@obelix.in.ibm.com> <20040714081737.N1973@build.pdx.osdl.net> <200407151022.53084.jbarnes@engr.sgi.com> <20040715161054.GB3957@in.ibm.com> <20040715093408.A1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715093408.A1924@build.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 09:34:08AM -0700, Chris Wright wrote:
> * Dipankar Sarma (dipankar@in.ibm.com) wrote:
> > On Thu, Jul 15, 2004 at 10:22:53AM -0400, Jesse Barnes wrote:
> > > On Wednesday, July 14, 2004 11:17 am, Chris Wright wrote:
> > ... 
> > Chris raises an interesting issue. There are two ways we can benefit from
> > lock-free lookup - avoidance of atomic ops in lock acquisition/release
> > and avoidance of contention. The latter can also be provided by
> > rwlocks in read-mostly situations like this, but rwlock still has
> > two atomic ops for acquisition/release. So, in another
> > thread, I have suggested looking into the contention angle. IIUC,
> > tiobench is threaded and shares fd table. 
> 
> Given the read heavy assumption that RCU makes (supported by your
> benchmarks), I believe that the comparison with RCU vs. current scheme
> is unfair.  Better comparison is against rwlock_t, which may give a
> similar improvement w/out the added complexity.  But, I haven't a patch
> nor a benchmark, so it's all handwavy at this point.

It would be a good datapoint to experiment with rwlock.
But note that on x86 (my testbed right now)
1. read_lock + read_unlock + atomic_inc will be 3 (bus locking) atomic ops
2. spin_lock + spin_unlock + atomic_inc will be 2 atomic ops 
   (x86 spin_unlock is just a move)
3. rcu_read_lock, rcu_read_unlock + cmpxchg is just one atomic op,
added to it the cs is small in fget, fget_light....

IIRC, the files_struct.file_lock was a rwlock sometime back.  
(it still is in 2.4 i think) I am not sure why it was changed to spinlocks.  
I will try to dig through the archives, but if someone can quickly 
fill in that would be nice.

Thanks,
Kiran
