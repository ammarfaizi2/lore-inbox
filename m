Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265855AbUFDQPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbUFDQPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbUFDQPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:15:47 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23279 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265847AbUFDQPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:15:32 -0400
Date: Fri, 4 Jun 2004 09:23:16 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604092316.3ab91e36.pj@sgi.com>
In-Reply-To: <20040604113252.GA21007@holomorphy.com>
References: <20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604093712.GU21007@holomorphy.com>
	<16576.17673.548349.36588@alkaid.it.uu.se>
	<20040604095929.GX21007@holomorphy.com>
	<16576.23059.490262.610771@alkaid.it.uu.se>
	<20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Some interface is needed to export NR_CPUS 

Well ... technically ... such an interface already exists.
However the word "interface" might be too kind a description.

/*
 * Ugly hack to get size of cpumask - keep calling sched_getaffinity
 * with masks of increasing size until it stops complaining -EINVAL
 * that the mask is too small.  Determines size of kernel cpumask,
 * in number of bytes.  Size will always be some multiple of the
 * size of an unsigned long.  Since it's ok to be too big, and since
 * kernel NR_CPUS is usually a power of two, just try each power
 * of two, until one works.  Contrary to the man page, a successful
 * sched_getaffinity() returns a positive number (the sizeof(cpumask_t),
 * to be exact), not zero.  Consider any return >= 0 to mean success.
 */

#include <errno.h>
extern int errno;

int cpumasksz()
{
	int nbytes;
	unsigned long *mask = 0;

	for (nbytes = sizeof(unsigned long); nbytes < 10000; nbytes *= 2) {
		int r;
		mask = (unsigned long *)realloc(mask, nbytes);
		if (mask == 0)
			return -ENOMEM;
		errno = 0;
		r = sched_getaffinity(0, nbytes, mask);
		if (r < 0 && errno == EINVAL)
			continue;
		if (r >= 0)
			break;
		return -errno;
	}
	free(mask);
	return nbytes;
}



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
