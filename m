Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbUKTBPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbUKTBPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbUKTBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:08:41 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:7049 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263067AbUKTBH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:07:57 -0500
Message-ID: <419E98E7.1080402@yahoo.com.au>
Date: Sat, 20 Nov 2004 12:07:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com>  <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com>  <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 19 Nov 2004, Christoph Lameter wrote:
> 
>>Note that I have posted two other approaches of dealing with the rss problem:
> 
> 
> You could also make "rss" be a _signed_ integer per-thread.
> 
> When unmapping a page, you decrement one of the threads that shares the mm 
> (doesn't matter which - which is why the per-thread rss may go negative), 
> and when mapping a page you increment it.
> 
> Then, anybody who actually wants a global rss can just iterate over
> threads and add it all up. If you do it under the mmap_sem, it's stable,
> and if you do it outside the mmap_sem it's imprecise but stable in the
> long term (ie errors never _accumulate_, like the non-atomic case will 
> do).
> 
> Does anybody care enough? Maybe, maybe not. It certainly sounds a hell of 
> a lot better than the periodic scan.
> 

I think this sounds like it might be a good idea. I prefer it to having
the unbounded error of sloppy rss (as improbable as it may be in practice).

The per thread rss may wrap (maybe not 64-bit counters), but even so,
the summation over all threads should still end up being correct I
think.
