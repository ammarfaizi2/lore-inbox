Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVDBCHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDBCHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDBCHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:07:54 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:65469 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261664AbVDBCHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:07:33 -0500
Message-ID: <424DFE5F.2040804@yahoo.com.au>
Date: Sat, 02 Apr 2005 12:07:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: remove unnecessary sched domains
References: <20050401162039.A4320@unix-os.sc.intel.com>
In-Reply-To: <20050401162039.A4320@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Appended patch removes the unnecessary scheduler domains(containing
> only one sched group) setup during the sched-domain init.
> 
> For example on x86_64, we always have NUMA configured in. On Intel EM64T
> systems, top most sched domain will be of NUMA and with only one sched_group in
> it. 
> 
> With fork/exec balances(recent Nick's fixes in -mm tree), we always endup 
> taking wrong decisions because of this topmost domain (as it contains only 
> one group and find_idlest_group always returns NULL). We will endup loading 
> HT package completely first, letting active load balance kickin and correct it.
> 
> In general, this patch also makes sense with out recent Nick's fixes
> in -mm.
> 

Yeah, this makes sense. We may want to add some other criteria on the
removal of a domain as well (because some of the domain flags do things
that don't use groups).

I don't like so much that we'd rely on it to fix the above problem.
There are a general class of problems with the fork/exec balancing in
that it only works on the top most domain, so it may not spread load over
lower domains very well.

I was thinking we could fix that by running balance on fork/exec multiple
times from top to bottom level domains. I'll have to measure the cost of
doing that, because it may be worthwhile.

Thanks

-- 
SUSE Labs, Novell Inc.

