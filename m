Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWDNAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWDNAcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWDNAcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:32:43 -0400
Received: from mga05.intel.com ([192.55.52.89]:60943 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S965002AbWDNAcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:32:42 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23778657:sNHT212326954"
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23778649:sNHT19729675"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23778646:sNHT20387108"
Date: Thu, 13 Apr 2006 17:31:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: smpnice: issues with finding busiest queue 
Message-ID: <20060413173104.B15723@unix-os.sc.intel.com>
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au> <20060411185709.A2401@unix-os.sc.intel.com> <443C8AEC.9010309@bigpond.net.au> <443D95DF.2090807@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443D95DF.2090807@bigpond.net.au>; from pwil3058@bigpond.net.au on Thu, Apr 13, 2006 at 10:05:51AM +1000
X-OriginalArrivalTime: 14 Apr 2006 00:32:41.0048 (UTC) FILETIME=[F055AD80:01C65F5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 10:05:51AM +1000, Peter Williams wrote:
> 
> There be dragons here :-(.
> 

At more places in this part of the world (smpnice) :)

We need to relook at find_busiest_queue()... With the current weighted
calculations, it doesn't always make sense to look at the highest weighted
runqueue in the busy group..

for example on a DP with HT system, how does the load balance behave with
Package-0 containing one high priority and one low priority, Package-1
containing one low priority(with other thread being idle)..

Package-1 thinks that it need to take the low priority thread from Package-0.
And find_busiest_queue() returns the cpu thread with highest priority task..
And ultimately(with help of active load balance) we move high priority
task to Package-1. And same continues with Package-0 now, moving high priority
task from package-1 to package-0..

Even without the presence of active load balance, load balance will fail
to balance(having two low priority tasks on one package, and high
priority task on another package) the above scenario....

We probably need to use imbalance(and more factors) to determine the busiest 
queue in the group.....

thanks,
suresh
