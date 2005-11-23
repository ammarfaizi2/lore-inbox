Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVKWXUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVKWXUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVKWXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:20:14 -0500
Received: from fmr24.intel.com ([143.183.121.16]:41153 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932356AbVKWXUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:20:12 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@csn.ul.ie>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <christoph@lameter.com>
In-Reply-To: <Pine.LNX.4.58.0511231754020.7045@skynet>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <20051122213612.4adef5d0.akpm@osdl.org>
	 <1132768482.25086.16.camel@akash.sc.intel.com>
	 <Pine.LNX.4.58.0511231754020.7045@skynet>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 15:26:22 -0800
Message-Id: <1132788382.25086.109.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 23:19:24.0406 (UTC) FILETIME=[577C9960:01C5F084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Rohit Seth wrote:
> 
> > On Tue, 2005-11-22 at 21:36 -0800, Andrew Morton wrote:

> > > We need to verify that this patch actually does something useful.
> > >
> > >
> > I'm working on this.  Will let you know later today if I can come with
> > some workload easily hitting this additional logic.
> >
> 

I'm able to trigger the reduce_cpu_pcp (I'll change its name in next
update patch) logic after direct reclaim using a small test case hogging
memory and a bash loop spawning another process 1 at a time using very
little memory.

I added a single printk after the direct reclaim where we reduce the per
cpu pagelist (in my patch) just to get the order and how many iterations
do we need to service the request.  order is always 1 (coming from
alloc_thread_info for 8K stack size).

This is on i386 with 8K stack size.

if (order > 0)  {
       int i = 0;
       while (reduce_cpu_pcp()) {
            i++;
            page = get_page_from_freelist(gfp_mask, order, zonelist,
alloc_flags);
            if (page) {
                printk("Got page %d order iteration %d", order, i);
                goto got_pg;
            }
       }
}

And got about 30 of those in couple of hours:

[17179885.360000] Got page 1 order iteration 1



