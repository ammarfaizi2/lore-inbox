Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUFDSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUFDSjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUFDSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:39:12 -0400
Received: from holomorphy.com ([207.189.100.168]:59815 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265920AbUFDSid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:38:33 -0400
Date: Fri, 4 Jun 2004 11:38:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604183815.GI21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, pj@sgi.com, mikpe@csd.uu.se,
	nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
	hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
	manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
References: <16576.17673.548349.36588@alkaid.it.uu.se> <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <20040604112730.534cca55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604112730.534cca55.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> _SC_NPROCESSOR_CONF is
>>  unimplementable. NR_CPUS serves as an upper bound on the number of cpus
>>  that may at some time be simultaneously present in the future.

On Fri, Jun 04, 2004 at 11:27:30AM -0700, Andrew Morton wrote:
> NR_CPUS is arguably the correct thing when it comes to copying per-cpu info
> to and from userspace.
> Sometimes userspace wants to know NR_CPUS.  Sometimes it wants to know the
> index of the max possible CPU.  Sometimes, perhaps the index of the max
> online CPU.  Sometimes the max index of the CPUs upon which this task is
> eligible to run.  Sometimes (lame) userspace may want to know, at compile
> time, the maximum number of CPUs which a Linux kernel will ever support.
> It's not completely trivial.
> Which of the above is _SC_NPROCESSOR_CONF supposed to return?

_SC_NPROCESSORS_CONF looks like a glibc extension, and if so it's
somewhat arbitrary. It's not documented in the manpage or the header's
comments. I presumed it was the largest number of cpus that could be
simultaneously online in the running kernel instance (which is NR_CPUS
in current kernels). If it's a standard it's likely to be very poorly-
defined. These things differ as the implementations start varying e.g.
for very sparse cpuid spaces, but not anything we handle now.

I'd have to write more stuff to try to find the rest of these things.
I'm not sure all of them are implementable.

And the luserspace code needs the following atop all that:

--- nr_cpus.c.orig2	2004-06-04 11:23:28.130800560 -0700
+++ nr_cpus.c	2004-06-04 11:27:12.785647832 -0700
@@ -10,28 +10,35 @@
 
 int main(void)
 {
+	int cpus = detect_nr_cpus();
 	printf("%d\n", detect_nr_cpus());
-	return 0;
+	return cpus <= 0;
 }
 
 static int detect_nr_cpus(void)
 {
 	unsigned long *cpus = malloc(sizeof(long));
 	size_t upper, middle, lower = sizeof(long);
+	int ret = -ENOMEM;
 
+	if (!cpus)
+		return -ENOMEM;
 	for (upper = lower; getaffinity(0, upper, cpus) < 0; upper *= 2) {
 		if (!realloc(cpus, 2*upper))
-			return -ENOMEM;
+			goto out;
 	}
 	while (lower < upper - 1) {
 		middle = (lower + upper)/2;
 		if (!realloc(cpus, middle))
-			return -ENOMEM;
+			goto out;
 		if (getaffinity(0, middle, cpus) < 0)
 			lower = middle;
 		else
 			upper = middle;
 	}
+	ret = CHAR_BIT*upper;
+out:
+	free(cpus);
 	return CHAR_BIT*upper;
 }
 
