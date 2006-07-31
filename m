Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWGaEgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWGaEgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWGaEgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:36:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:29089 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751468AbWGaEgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:36:16 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 14:36:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.35001.745409.144623@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 010 of 11] knfsd: make rpc threads pools numa aware
In-Reply-To: message from Andrew Morton on Sunday July 30
References: <20060731103458.29040.patches@notabene>
	<1060731004234.29291@suse.de>
	<20060730211454.ccf803f3.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday July 30, akpm@osdl.org wrote:
> On Mon, 31 Jul 2006 10:42:34 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > +static int
> > +svc_pool_map_init_percpu(struct svc_pool_map *m)
> > +{
> > +	unsigned int maxpools = num_possible_cpus();
> > +	unsigned int pidx = 0;
> > +	unsigned int cpu;
> > +	int err;
> > +
> > +	err = svc_pool_map_alloc_arrays(m, maxpools);
> > +	if (err)
> > +		return err;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		BUG_ON(pidx > maxpools);
> > +		m->to_pool[cpu] = pidx;
> > +		m->pool_to[pidx] = cpu;
> > +		pidx++;
> > +	}
> 
> That isn't right - it assumes that cpu_possible_map is not sparse.  If it
> is sparse, we allocate undersized pools and then overindex them.

I don't think so.

At this point we are largely counting the number of online cpus
(in pidx (pool index) - this is returned). The two-way mapping
to_pool and pool_to provides a mapping between the possible-sparse cpu
list and a dense list of pool indexes.

If further cpus come on line they will be automatically included in
pool-0. (as to_pool[n] will still be zero).

Does that make it at all clearer?

Thanks,
NeilBrown
