Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319603AbSIML3o>; Fri, 13 Sep 2002 07:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319604AbSIML3o>; Fri, 13 Sep 2002 07:29:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5885 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319603AbSIML3n>;
	Fri, 13 Sep 2002 07:29:43 -0400
Date: Fri, 13 Sep 2002 17:09:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: akpm@digeo.com
Cc: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
Message-ID: <20020913170943.A11038@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D80EE1D.34AF4FF2@digeo.com> Andrew Morton wrote:
> Rick Lindsley wrote:
>> Regardless of which route we go, can you suggest a good exercise to
>> demonstrate the advantage of per-cpu counters?  It seems intuitive to
>> me, but I'm much more comfortable when I have numbers to back me up.

> I don't think this is enough to justify a new subsystem like
> statctr_t (struct statctr, please).

statctr_t was originally used to hide the fact that in UP kernels
it reduces to unsigned long. But I think that was not necessary -

#ifdef CONFIG_SMP
struct statctr {
	unsigned long ctr;
};
#else
struct statctr {
	unsigned long *ctr;
};
#endif

struct disk_stats {
	....
	....
	struct statctr nr_reads;
};

I would presume that for UP kernels,

static inline void statctr_inc(struct statctr *stctr)
{
	(stctr->ctr)++;
}

statctr_inc(&disk_stats.nr_reads) would generate the same code
as diskstats.nr_reads++; We will verify this and remove statctr_t.

I think justifying statctrs based on numbers from one single usage will
likely be difficult. Our measurements (e.g. net_device_stats and
cache event profiling with kernprof) showed that while cache misses
in those routines are reduced significantly, it isn't enough to make
an impact in the benchmark throughput. We need to adopt statctrs
in many subsystems. Perhaps that will show some benefits specially
on higher-end hardware (16CPU+).

Since we are beginning to run linux on such hardware, why not adopt a simple
framework now ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
