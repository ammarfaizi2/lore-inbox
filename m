Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVKXDCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVKXDCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKXDCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:02:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:52359 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932396AbVKXDCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:02:53 -0500
Date: Wed, 23 Nov 2005 19:02:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
Cc: akpm@osdl.org, clameter@engr.sgi.com, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, steiner@sgi.com,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
Message-Id: <20051123190237.3ba62bf0.pj@sgi.com>
In-Reply-To: <1132779605.25086.69.camel@akash.sc.intel.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	<Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	<1132775194.25086.54.camel@akash.sc.intel.com>
	<20051123115545.69087adf.akpm@osdl.org>
	<1132779605.25086.69.camel@akash.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit wrote:
> I thought Nick et.al came up with some of the constant values like batch
> size to tackle the page coloring issue specifically. 

I think this came about on a linux-ia64 thread started by Jack Steiner:

  http://www.gelato.unsw.edu.au/archives/linux-ia64/0504/13668.html
  Subject: per_cpu_pagesets degrades MPI performance
  From: Jack Steiner <steiner_at_sgi.com>
  Date: 2005-04-05 05:28:27

Jack reported that per_cpu_pagesets were degrading some MPI benchmarks due
to adverse page coloring.  Nick responded, recommending a non-power of two
batch size.  Jack found that this helped nicely.  This thread trails off,
but seems to be the origins of the 2**n-1 batch size in:

	mm/page_alloc.c:zone_batchsize()
	 * Clamp the batch to a 2^n - 1 value. Having a power ...
        batch = (1 << fls(batch + batch/2)) - 1;

I don't see here evidence that "per_cpu_pagelist is ... one single main
reason the coloring effect is drastically reduced in 2.6 (over 2.4)
based kernels."  Rather in this case anyway a batch size not a power of
two was apparently needed to keep per_cpu_pagesets from hurting
performance due to page coloring affects on some workloads.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
