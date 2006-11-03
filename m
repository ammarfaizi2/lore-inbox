Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWKCWzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWKCWzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKCWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:55:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:9189 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752549AbWKCWzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:55:06 -0500
Subject: Re: [PATCH 0/9] Task Watchers v2: Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, jes@sgi.com, lse-tech@lists.sourceforge.net,
       sekharan@us.ibm.com, hch@lst.de, viro@zeniv.linux.org.uk,
       sgrubb@redhat.com, linux-audit@redhat.com, akpm@osdl.org
In-Reply-To: <20061103005747.60bfbd87.pj@sgi.com>
References: <20061103042257.274316000@us.ibm.com>
	 <20061103005747.60bfbd87.pj@sgi.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Fri, 03 Nov 2006 14:55:02 -0800
Message-Id: <1162594502.12419.316.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 00:57 -0800, Paul Jackson wrote:
> Matt wrote:
> > Task watchers is primarily useful to existing kernel code as a means of making
> > the code in fork and exit more readable.
> 
> I don't get it.  The benchmark data isn't explained in plain English

Sorry, there were no units in the per-patch fork and clone data. Units
there are in tasks created per second. The kernbench units are in place
and should be fairly self-explanatory I think.

Here's what I did:

Measure the time it takes to fork N times. Retry 100 times. Try
different N. Try clone instead of fork to see how different the results
can be.

Then run kernbench.

Do the above after applying each patch. Then compare to the previous
patch (or unpatched source).

Run statistics on the numbers.

> what it means, that I could find, so I am just guessing.  But looking
> at the last (17500) column of the fork results, after applying patch
> 1/9, I see a number of 18565, and looking at that same column in patch
> 9/9, I see a number of 18142.
> 
> I guess that means a drop of (18565 - 18142 / 18565) == 2% in the fork
> rate, to make the code "more readable".

	Well, it's a worst-case scenario. Without the patches I've seen the
fork rate intermittently (once every 300 samples) drop to 16k forks/sec
-- a much bigger drop than 2%. I also ran the tests on Andrew's hotfix
patches for rc2-mm2 and got similar differences even though the patches
don't change the fork path. And finally, don't forget to compare that to
the error -- about +/-1.6%. So on an absolute worst-case workload we
could have a drop anywhere from 0.4 to 3.6%.

	To get a better idea of the normal impact of these patches I think you
have to look at benchmarks more like kernbench since it's not comprised
entirely of fork calls. There the measurements are easily within the
error margins with or without the patches.

	Unfortunately the differences I get always seem to be right around the
size of the error. I can't seem to get a benchmark to have an error of
1% or less. I'm open to suggestions of different benchmarks or how to
obtain tighter bounds on the measurements (e.g. /proc knobs to fiddle
with).

> And I'm not even sure it makes it more readable.  Looks to me like another
> layer of apparatus, which is one more thing to figure out before a reader
> understands what is going on.

	It's nice to see a module's init function with the rest of the module
and not cluttering up the kernel's module loading code. The use,
benefits, disadvantages, and even the implementation of task watchers
are similar. I could rename it (task_init(), task_exit(), etc.) to make
the similarity more apparent.

> I'd gladly put in a few long days to improve the fork rate 2%, and I am
> grateful to those who have already done so - whoever they are.

I'm open to suggestions on how to improve the performance. :)

> Somewhere I must have missed the memo explaining why this patch is a
> good idea - sorry.

	Well, it should make things look cleaner. It's also intended to be
useful in new code like containers and resource management -- pieces
many people don't want to pay attention to in those paths.

Cheers,
	-Matt Helsley

