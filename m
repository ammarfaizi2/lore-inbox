Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUHJXpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUHJXpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUHJXpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:45:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31136 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267826AbUHJXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:44:56 -0400
Date: Tue, 10 Aug 2004 16:43:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040810164324.2b546539.pj@sgi.com>
In-Reply-To: <2558220000.1092062986@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<250840000.1091738840@flay>
	<20040809010106.70e74f4b.pj@sgi.com>
	<2558220000.1092062986@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> OK, that [removal of prefix char fluff^Wstuff] looks a lot more palletable ;-)

Good.


> it looks like you're only parsing on the read-side to me

I couldn't parse this comment, but hopefully I'll answer this below ...


> I can't see any [bitmap_scnlistprintf] callers,

The first caller of the bitmap list format stuff is the next patch - the
cpuset patch.

The bitmap list printing call stack for cpumasks is:

	kernel/cpuset.c:		cpuset_common_file_read()
	kernel/cpuset.c:		cpuset_sprintf_cpulist()
	include/linux/cpumask.h:	__cpulist_scnprintf()
	lib/bitmap.c:			bitmap_scnlistprintf()

Similarly for nodemasks.

That's why the very first two lines of the bitmap list patch comment
state:

	A bitmap print and parse format that provides lists of ranges of
	numbers, to be first used for by cpusets (next patch).

;).

> do we really need both cpumask_parse and __cpumask_parse in front of
> bitmap_parse?

Yes.  Look through cpumask.h and nodemask.h.  You will see this use of
a #define macro wrapping a static inline macro repeatedly.  The #define
macro is needed to implement the implied call-by-reference convention,
and the static inline is needed to add some type checking.

Note that while the C syntax for using these cpu and node mask operators
_looks_ like it is passing the mask by value at the point marked "<==",
which would copy a possibly multiple word mask on the stack, in the
code:

	static int cpuset_sprintf_cpulist(char *page, struct cpuset *cs)
	{
        	cpumask_t mask;
		...
        	return cpulist_scnprintf(page, PAGE_SIZE, mask);	/* <== */
	}

this code is _really_ passing a pointer (unsigned long *) on the stack
to the actual implementing code, in lib/bitmap.c:bitmap_scnlistprintf().

The key ingredient that the #define macro adds is the '&' char, turning
normal C call-by-value conventions into an implied call-by-reference.

This somewhat un-C-like calling convention (more like Pascal call by
reference) existed for cpumasks before I came on the scene, with my
various cleanups of the bitmap and cpumask code over the last 10 months.
I found the convention pleasing enough, if odd, so I preserved it, for
most of the cpumask calls, and now (thanks to Matthew Dobson) the
nodemask calls as well.

In summary, the #define macros are needed in cpumask.h and nodemask.h to
alter the usual C call-by-value conventions, and the static inline
macros are needed to provide some static type checking of the arguments.

... at least I hope that was your question.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
