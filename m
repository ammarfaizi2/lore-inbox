Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUC3HD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUC3HD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:03:58 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:63867 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263284AbUC3HD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:03:56 -0500
Message-ID: <40691BCE.2010302@yahoo.com.au>
Date: Tue, 30 Mar 2004 17:03:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: mingo@elte.hu, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com>	<20040325154011.GB30175@wotan.suse.de>	<20040325190944.GB12383@elte.hu>	<20040325162121.5942df4f.ak@suse.de>	<20040325193913.GA14024@elte.hu>	<20040325203032.GA15663@elte.hu>	<20040329084531.GB29458@wotan.suse.de>	<4068066C.507@yahoo.com.au>	<20040329080150.4b8fd8ef.ak@suse.de>	<20040329114635.GA30093@elte.hu>	<20040329221434.4602e062.ak@suse.de>	<4068B692.9020307@yahoo.com.au> <20040330083450.368eafc6.ak@suse.de>
In-Reply-To: <20040330083450.368eafc6.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tue, 30 Mar 2004 09:51:46 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
> 
>>So both -mm5 and Ingo's sched.patch are much worse than
>>what 2.4 and 2.6 get?
> 
> 
> Yes (2.6 vanilla and 2.4-aa at that, i haven't tested 2.4-vanilla) 
> 
> Ingo's sched.patch makes it a bit better (from 1x CPU to 1.5-1.7xCPU), but still
> much worse than the max of 3.7x-4x CPU bandwidth.
> 

So it is very likely to be a case of the threads running too
long on one CPU before being balanced off, and faulting in
most of their working memory from one node, right?

I think it is impossible for the scheduler to correctly
identify this and implement the behaviour that OpenMP wants
without causing regressions on more general workloads
(Assuming this is the problem).

We are not going to go back to the wild balancing that
numasched does (I have some benchmarks where sched-domains
reduces cross node task movement by several orders of
magnitude). So the other option is to do balance on clone
across NUMA nodes, and make it very sensitive to imbalance.
Or probably better to make it easy to balance off to an idle
CPU, but much more difficult to balance off to a busy CPU.

I suspect this would still be a regression for other tests
though where thread creation is more frequent, threads share
working set more often, or the number of threads > the number
of CPUs.
