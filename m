Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265889AbUFDSNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUFDSNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265903AbUFDSNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:13:04 -0400
Received: from holomorphy.com ([207.189.100.168]:47015 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265889AbUFDSMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:12:50 -0400
Date: Fri, 4 Jun 2004 11:12:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604181233.GF21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <16576.16748.771295.988065@alkaid.it.uu.se> <20040604093712.GU21007@holomorphy.com> <16576.17673.548349.36588@alkaid.it.uu.se> <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604104756.472fd542.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/* William Lee Irwin III:
>> I'm thoroughly disgusted.

On Fri, Jun 04, 2004 at 10:47:56AM -0700, Paul Jackson wrote:
> Yup ... LOL.  One sick piece of code.
> I didn't return the actual return from sched_getaffinity() because (1)
> it's ok to estimate the mask size too high, and (2) given that the man
> page and kernel don't agree on the return value of sched_getaffinity(),
> I figured that the less I relied on it, the longer my user code would
> continue functioning in a useful manner.  As always, the key to robust
> code (code that withstands the perils of time) is minimizing risky
> assumptions.

Even the following returns 32 on UP. _SC_NPROCESSOR_CONF is
unimplementable. NR_CPUS serves as an upper bound on the number of cpus
that may at some time be simultaneously present in the future. Without
any way to reliably determine this, luserspace is fscked.

*/


#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <limits.h>
#include <sys/syscall.h>

static int getaffinity(pid_t, size_t, unsigned long *);
static int detect_nr_cpus(void);

int main(void)
{
	printf("%d\n", detect_nr_cpus());
	return 0;
}

static int detect_nr_cpus(void)
{
	unsigned long *cpus = malloc(sizeof(long));
	size_t upper, middle, lower = sizeof(long);

	for (upper = lower; getaffinity(0, upper, cpus) < 0; upper *= 2) {
		if (!realloc(cpus, 2*upper))
			return -ENOMEM;
	}
	while (lower < upper) {
		middle = (lower + upper)/2;
		if (!realloc(cpus, middle))
			return -ENOMEM;
		if (getaffinity(0, middle, cpus) < 0)
			lower = middle;
		else
			upper = middle;
	}
	return CHAR_BIT*upper;
}

static int getaffinity(pid_t pid, size_t size, unsigned long *cpus)
{
	return syscall(__NR_sched_getaffinity, pid, size, cpus);
}
