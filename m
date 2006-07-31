Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWGaEmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWGaEmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGaEmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:42:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37777 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751470AbWGaEmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:42:54 -0400
Subject: Re: [NFS] [PATCH 010 of 11] knfsd: make rpc threads pools numa
	aware
From: Greg Banks <gnb@melbourne.sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <17613.35001.745409.144623@cse.unsw.edu.au>
References: <20060731103458.29040.patches@notabene>
	 <1060731004234.29291@suse.de> <20060730211454.ccf803f3.akpm@osdl.org>
	 <17613.35001.745409.144623@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154320957.21040.1836.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 31 Jul 2006 14:42:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 14:36, Neil Brown wrote:
> On Sunday July 30, akpm@osdl.org wrote:
> > On Mon, 31 Jul 2006 10:42:34 +1000
> > NeilBrown <neilb@suse.de> wrote:
> > 
> > > +static int
> > > +svc_pool_map_init_percpu(struct svc_pool_map *m)
> > > +{
> > > +	unsigned int maxpools = num_possible_cpus();
> > > +	unsigned int pidx = 0;
> > > +	unsigned int cpu;
> > > +	int err;
> > > +
> > > +	err = svc_pool_map_alloc_arrays(m, maxpools);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	for_each_online_cpu(cpu) {
> > > +		BUG_ON(pidx > maxpools);
> > > +		m->to_pool[cpu] = pidx;
> > > +		m->pool_to[pidx] = cpu;
> > > +		pidx++;
> > > +	}
> > 
> > That isn't right - it assumes that cpu_possible_map is not sparse.  If it
> > is sparse, we allocate undersized pools and then overindex them.
> 
> I don't think so.
> 
> At this point we are largely counting the number of online cpus
> (in pidx (pool index) - this is returned). The two-way mapping
> to_pool and pool_to provides a mapping between the possible-sparse cpu
> list and a dense list of pool indexes.
> 
> If further cpus come on line they will be automatically included in
> pool-0. (as to_pool[n] will still be zero).
> 
> Does that make it at all clearer?

Umm, I think Andrew's right, num_possible_cpus() should be NR_CPUS.
If there's a value of `cpu' > num_possible_cpus(), which would happen
if the cpu numbers weren't contiguous, then m->to_pool[] will be
overflowed.  My bad, I didn't even consider the case of non-contiguous
CPU numbers and none of the machines available for testing had that
property.


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


