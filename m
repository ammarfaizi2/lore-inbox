Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUBVVNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 16:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUBVVNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 16:13:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:30370 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261753AbUBVVNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 16:13:21 -0500
Date: Mon, 23 Feb 2004 02:43:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       cw@f00f.org, mfedyk@matchmail.com, linux-kernel@vger.kernel.org,
       Maneesh Soni <maneesh@in.ibm.com>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222211313.GA17892@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040221221553.01b1b71c.akpm@osdl.org> <38800000.1077466122@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38800000.1077466122@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 08:08:43AM -0800, Martin J. Bligh wrote:
> I still don't understand the rationale behind the way we currently do it - 
> perhaps I'm just being particularly dense. If we have 10,000 pages full of
> dcache, and start going through shooting entries by when they were LRU wrt
> the entries, not the dcache itself, then (assuming random access to dcache),
> we'll evenly shoot the same number of entries from each dcache page without
> actually freeing any pages at all, just trashing the cache.
> 
> Now I'm aware access isn't really random, which probably saves our arse.
> But then some of the entries will be locked too, which only makes things
> worse (we free a bunch of entries from that page, but the page itself
> still isn't freeable). So it still seems likely to me that we'll blow 
> away at least half of the dcache entries before we free any significant 
> number of pages at all. That seems insane to me. Moreover, the more times 
> we shrink & fill, the worse the layout will get (less grouping of "recently 
> used entries" into the same page).

Do you have a quick test to demonstrate this ? That would be useful.

> Moreover, it seems rather expensive to do a write operation for each 
> dentry to maintain the LRU list over entries. But maybe we don't do that
> anymore with dcache RCU - I lost track of what that does ;-( So doing it
> on the page LRU basis still makes a damned sight more sense to me. Don't
> we want semantics like "once used vs twice used" preference treatment 
> for dentries, etc anyway?

Dcache-RCU hasn't changed the dentry freeing to slab much, it is still
LRU. Given a CPU, dentries are still returned to the slab
in dcache LRU order.

I have always wondered about how useful the global dcache LRU 
mechanism is. This adds another reason for us to go experiment
with it.

Thanks
Dipankar
