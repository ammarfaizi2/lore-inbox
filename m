Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUCIJYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUCIJYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:24:46 -0500
Received: from holomorphy.com ([207.189.100.168]:11016 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261846AbUCIJYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:24:40 -0500
Date: Tue, 9 Mar 2004 01:24:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
Message-ID: <20040309092433.GL655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Mike Fedyk <mfedyk@matchmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au> <404D5A6F.4070300@matchmail.com> <404D5EED.80105@cyberone.com.au> <20040309070246.GI655@holomorphy.com> <404D7109.10902@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D7109.10902@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 06:23:53PM +1100, Nick Piggin wrote:
> OK. I had just noticed that the people complaining about rmap most
> are the ones using 4K page size (x86-64 uses 4K, doesn't it?). Not
> that this fact means it is OK to ignore them problem, but I thought
> maybe pgcl might solve it in a more general way.

There is something to be gained in terms of general cache and memory
footprint of non-reclamation-oriented operations. The sad thing is
that many of the arguments presented in favor of these object-based
physical-to-virtual resolution methods are largely for what I'd call
the wrong reasons. Kernel compiles are not a realistic workload. fork()
is used in real applications that are forking servers, and those are
what should be instrumented for the performance argument. Cache and
memory conservation are also legitimate concerns, which are being
expressed in ways that pollute them with the stigma of highmem.


On Tue, Mar 09, 2004 at 06:23:53PM +1100, Nick Piggin wrote:
> I wonder how much you gain with objrmap / anobjrmap on say a 64K page
> architecture?

The gains I spoke of earlier are completely in terms of implementation
mechanics and unrelated to concerns such as performance. Essentially,
ptes are expected to be of some size, and it's desirable that they
remain of those sizes and not "widened" artificially lest we incur more
fragmentation. The pte_chain -based physical-to-virtual resolution
algorithm utilized the struct page tracking a pte page, which is unique
in mainline, to shove information used by the physical-to-virtual
resolution algorithm into. This gets rather ugly when the struct page
corresponds to multiple pte pages. pte pages are already grossly
underutilized (ca. 20%) with stock 4K pte pages; jacking them up to
64KB/etc. worsens space utilization, has larger latencies associated
with bitblitting the things, and is just plain ugly to implement.

anobjrmap OTOH removes this dependency on the struct page tracking a
4K pte page. 4K (or otherwise sub-PAGE_SIZE) blocks of memory for ptes
may be freely used without incurring implementation complexity or the
other disadvantages above. The partial objrmap doesn't remove this
dependency on a unique struct page tracking a pte page, retaining it
for the cases of anonymous and nonlinearly-mapped pagecache pages.


-- wli

P.S.: The best word I could come up with for leaf radix tree nodes
	of pagetables was "pte page". This term is not meant to imply
	they are of size PAGE_SIZE.
