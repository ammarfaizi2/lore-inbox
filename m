Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265856AbUFDQAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUFDQAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUFDP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:58:19 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63394 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265856AbUFDPy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:54:56 -0400
Date: Fri, 4 Jun 2004 09:03:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604090314.56d64f4d.pj@sgi.com>
In-Reply-To: <16576.16748.771295.988065@alkaid.it.uu.se>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael writes:
> Case in point: the perfctr kernel extension needs to communicate ...

Nice example.  Thank-you.

Yes - doing that 1-bit at a time in a per-cpu loop would be ugly.

We should leave cpus_addr() around, at least until such time as the
cpumask ADT provided routines to support exactly what you are doing -
copying up masks to user space as length specified arrays of uint.

==

Aside - be careful here not to get the two halves of 64 bit longs,
on 64 bit big endian machines, backwards.

>From the depths of my email archives (Joe Korty might recognize this)
comes the following snippet of code and commentary, never put to use,
which ponders the handling of such masks:

+/*
+ * Bitops apply to arrays of unsigned long.  This is almost
+ * the same as an array of unsigned ints, except on 64 bit big
+ * endian architectures, in which the two 32-bit int halves of
+ * each long are reversed (big 32-bit halfword first, naturally).
+ *
+ * Use this BIT32X (for "BITop 32-bit indeX") macro to index the
+ * i-th word of a bit mask declared as an array of 32 bit words.
+ *
+ * Usage example accessing 32-bit words in mask[] in order,
+ * smallest first:
+ *    u32 mask[MASKLENGTH];
+ *    int i;
+ *    for (i = 0; i < MASKLENGTH; i++)
+ *        ... mask[BIT32X(i)] ...
+ */
+#ifndef BIT32X
+#include <asm/byteorder.h>
+#if BITS_PER_LONG == 64 && defined(__BIG_ENDIAN)
+#define BIT32X(i) ((i)^1)
+#elif BITS_PER_LONG == 32 || defined(__LITTLE_ENDIAN)
+#define BIT32X(i) (i)
+#endif
+#endif


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
