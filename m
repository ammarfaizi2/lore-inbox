Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVC2B7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVC2B7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVC2B7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:59:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37513 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262145AbVC2B7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:59:48 -0500
Date: Mon, 28 Mar 2005 17:58:30 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
cc: davidm@hpl.hp.com, Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <20050327171220.GA18506@muc.de>
Message-ID: <Pine.LNX.4.58.0503281752280.7580@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
 <20050318192808.GB38053@muc.de> <16963.2075.713737.485070@napali.hpl.hp.com>
 <20050327171220.GA18506@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Andi Kleen wrote:

> > Clearly, if the CPU that's clearing the page is likely to use that
> > same page soon after, it'd be useful to use temporal stores.
>
> That is always the case in the current code (without Christophers
> pre cleaning daemon). The page fault handler clears and user space
> is guaranteed to need at least one cacheline from the fresh page
> because it just did a page fault on it. With non temporal stores
> you guarantee at least one hard cache miss directly after
> the return to user space.

It is not the case that *all* the cachelines of a page are going to be
used right after zeroing. For the page fault case it is only guaranteed that
*one* cacheline will be used. In the PTE/PMD/PUD page allocation cases it
is likely that only a single cacheline is used.

There are some cases in the code (apart from the fault handler)
where zeroed pages are allocated with no guarantee of use (f.e. the
allocations for buffers for shared memory or pipes).

> I suspect even with precleaning the average time from cleaning to use will be
> quite short.

If the time is short then hot cleaning is the right way to go and then
prezeroing is of no benefit. Prezeroing can only be of benefit if there is
sufficient time between the zeroing and the use of the data. It must be
sufficiently long to cause the the cachelines to no longer be in
in the caches. Then the loading of these cachelines may be avoided which
yields the performance benefit.
