Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbUKSUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUKSUCz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUKSUAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:00:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:2227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261574AbUKST7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:59:16 -0500
Date: Fri, 19 Nov 2004 11:59:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Christoph Lameter wrote:
> 
> Note that I have posted two other approaches of dealing with the rss problem:

You could also make "rss" be a _signed_ integer per-thread.

When unmapping a page, you decrement one of the threads that shares the mm 
(doesn't matter which - which is why the per-thread rss may go negative), 
and when mapping a page you increment it.

Then, anybody who actually wants a global rss can just iterate over
threads and add it all up. If you do it under the mmap_sem, it's stable,
and if you do it outside the mmap_sem it's imprecise but stable in the
long term (ie errors never _accumulate_, like the non-atomic case will 
do).

Does anybody care enough? Maybe, maybe not. It certainly sounds a hell of 
a lot better than the periodic scan.

		Linus
