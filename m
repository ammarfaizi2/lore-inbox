Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030177AbWLAIzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030177AbWLAIzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWLAIzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:55:20 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9709 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030177AbWLAIzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:55:19 -0500
Date: Fri, 1 Dec 2006 09:55:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061201085502.GA29060@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org> <20061130042807.GA4855@in.ibm.com> <20061130063512.GA19492@in.ibm.com> <20061130082934.GB29609@elte.hu> <20061201014313.GA25074@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201014313.GA25074@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> Consider a case where we have three locks A, B and C.
> We have very clear locking rule inside the kernel that lock A *should*
> be acquired before acquiring either lock B or lock C.
> 
> At runtime lockdep detects the two dependency chains,
> A --> B --> C
> 
> and
> 
> A --> C --> B.
> 
> Does lockdep issue a circular dependency warning for this ? 
> It's quite clear from the locking rule that we cannot have a
> circular deadlock, since A acts as a mutex for B->C / C->B callpath.
> 
> Just curious :-) [ Well, I might encounter such a scenario in an attempt
> 		   to make cpufreq cpu-hotplug safe! ]

yes, lockdep will warn about this. Will you /ever/ have a B->C or C->B 
dependency without A being taken first?

if not then my suggestion would be to just lump 'B' and 'C' into a 
single lock - or to get rid of them altogether. There's little reason to 
keep them separate. /If/ you want to keep them separate (because they 
protect different data structures) then it's the cleanest design to have 
an ordering between them. The taking of 'A' might go away anytime - such 
a construct is really, really fragile and is only asking for trouble.

	Ingo
