Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVCLDbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVCLDbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCLDbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:31:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44989 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261700AbVCLDa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:30:58 -0500
Date: Fri, 11 Mar 2005 19:30:10 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Prefaulting
In-Reply-To: <20050311172228.773cf03d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503111913560.24817@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
 <20050311172228.773cf03d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Andrew Morton wrote:

> > Results that show the impact of this patch are available at
> > http://oss.sgi.com/projects/page_fault_performance/
>
> There are a lot of numbers there.  Was there an executive summary?

You are right there is none for prefaulting. What all of these patches
(prezero,atomic pte, prefault) have in common is that they improve
performance for large number crunching applications but there is barely
any improvement for kernel compiles and/or LMBench. The best I can do is
insure that they do no harm. These issues are likely to become more
pressing as memory sizes and appplication sizes grow.

> >From a quick peek it seems that the patch makes negligible difference for a
> kernel compilation when prefaulting 1-2 pages and slows the workload down
> quite a lot when prefaulting up to 16 pages.

Yes. Prefaulting up to 16 pages slows the kernel compile down by
5% due to overallocating pages.

> And for the uniprocessor "200 Megabyte allocation without prezeroing.
> Single thread." workload it appears that the prefault patch slowed it down
> by 4x.

You likely compared the prezeroing performance with the prefaulting
performance. Prezeroing yields a fourfold improvement gain:

 Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
200  3    1   1    0.00s      0.02s   0.00s3756674.275 3712403.061
200  3    1   1    0.00s      0.03s   0.00s3488295.668 3501888.597
200  3    1   1    0.00s      0.03s   0.00s3407159.305 3420844.913

You need to compare the performance without any patches to the performance
with the prefault patch. There is even a slight performance win in the
uniprocessor case:

w/o any patch:

 Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
200  3    1   1    0.01s      0.15s   0.01s846860.493 848882.424
200  3    1   1    0.01s      0.16s   0.01s827724.160 830841.482
200  3    1   1    0.00s      0.16s   0.01s827724.160 827364.176

w/prefault patch

200 MB allocation

 Mb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
200  3    1   1    0.02s      0.48s   0.05s860119.275 859918.989
200  3    1   1    0.02s      0.46s   0.04s886129.730 886551.621
200  3    1   1    0.01s      0.47s   0.04s887920.166 886855.775

> Am I misreading the results?  If not, it's a bit disappointing.

Yes. The prefault patch actually improves UP performance of the
Microbenchmark slightly.
