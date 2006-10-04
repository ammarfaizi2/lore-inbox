Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWJDVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWJDVcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWJDVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:32:52 -0400
Received: from mga05.intel.com ([192.55.52.89]:50599 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751150AbWJDVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:32:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="141694637:sNHT20820401"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
In-Reply-To: <20061004103408.1a38b8ad.akpm@osdl.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <4522FB04.1080001@goop.org>
	 <1159919263.8035.65.camel@localhost.localdomain>
	 <45233B1E.3010100@goop.org>
	 <1159968095.8035.76.camel@localhost.localdomain>
	 <20061004093025.ab235eaa.akpm@osdl.org>
	 <1159978929.8035.109.camel@localhost.localdomain>
	 <20061004103408.1a38b8ad.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel
Date: Wed, 04 Oct 2006 13:43:52 -0700
Message-Id: <1159994632.8035.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 10:34 -0700, Andrew Morton wrote:

> 
> I wonder if we just got unlucky and that particular benchmark with that
> particular kernel build just happens to reach the cache system's
> associativity threshold, and this one extra cacheline took it over the
> edge.  Or something.
> 

I took a look at the "L2 cache lines evicted" data from emon.  It
increases by 17 million per cpu core during the 20 second tbench run
with the WARN_ON_ONCE patch, along with 11 million increase in "L2 cache
miss".  So perhaps the __warn_once variable got evicted. No theory at
least point on how it got evicted.

Also did an experiment to locate the callsite causing cache miss with
the original WARN_ON_ONCE patch. I turned off WARN_ON_ONCE one by one in
kernel/softirq.c where almost all call for WARN_ON_ONCE originated.  I
found that with each turnoff of WARN_ON_ONCE, the L2 cache miss go down
by 1 to 2 million, L2 cache line eviction goes down by 2 to 3 million.

One particular WARN_ON_ONCE in local_bh_enable contributed the most: 6
million L2 cache miss and 10 million L2 cache line evictions.  That
particular WARN_ON_ONCE also has the most effect on tbench throughput
(accounting for 70% of the tbench throughput reduction).


-- Code snippet --
void local_bh_enable(void)
{
#ifdef CONFIG_TRACE_IRQFLAGS
        unsigned long flags;

        WARN_ON_ONCE(in_irq());
#endif
        WARN_ON_ONCE(irqs_disabled());  <------- most degradation here.
					      CONFIG_TRACE_IRQFLAGS off

#ifdef CONFIG_TRACE_IRQFLAGS
        local_irq_save(flags);
#endif
        /*

Thanks.

Tim
