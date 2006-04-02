Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDBHfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDBHfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 03:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWDBHfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 03:35:23 -0400
Received: from mga06.intel.com ([134.134.136.21]:30354 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750786AbWDBHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 03:35:23 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,154,1141632000"; 
   d="scan'208"; a="18165370:sNHT17007879"
Date: Sat, 1 Apr 2006 23:35:13 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, suresh.b.siddha@intel.com,
       Dinakar Guniguntala <dino@in.ibm.com>, pj@sgi.com, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures dynamically
Message-ID: <20060401233512.B8662@unix-os.sc.intel.com>
References: <20060401185644.GC25971@in.ibm.com> <442F2B52.6000205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <442F2B52.6000205@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sun, Apr 02, 2006 at 11:39:30AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 11:39:30AM +1000, Nick Piggin wrote:
> 
> Srivatsa Vaddagiri wrote:
> >  /*
> > @@ -6113,6 +6125,10 @@ next_sg:
> >  static int build_sched_domains(const cpumask_t *cpu_map)
> >  {
> >  	int i;
> > +	struct sched_group *sched_group_phys = NULL;
> > +#ifdef CONFIG_SCHED_MC
> > +	struct sched_group *sched_group_core = NULL;
> > +#endif
> >  #ifdef CONFIG_NUMA
> >  	struct sched_group **sched_group_nodes = NULL;
> >  	struct sched_group *sched_group_allnodes = NULL;
> > @@ -6171,6 +6187,18 @@ static int build_sched_domains(const cpu
> >  		cpus_and(sd->span, sd->span, *cpu_map);
> >  #endif
> >  
> > +		if (!sched_group_phys) {
> > +			sched_group_phys
> > +				= kmalloc(sizeof(struct sched_group) * NR_CPUS,
> > +					  GFP_KERNEL);
> > +			if (!sched_group_phys) {
> > +				printk (KERN_WARNING "Can not alloc phys sched"
> > +						     "group\n");
> > +				goto error;
> > +			}
> > +			sched_group_phys_bycpu[i] = sched_group_phys;
> > +		}
> 
> Doesn't the last assignment have to be outside the if statement?
> 
> Hmm.. this design seems like the best way to go for now. Suresh?

Only thing I see in this is, even if there are very few cpus in the
exclusive cpuset, we end up allocating NR_CPUS groups and waste memory.

thanks,
suresh
