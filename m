Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUBVQLj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUBVQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:11:38 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:24240 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261684AbUBVQI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:08:58 -0500
Date: Sun, 22 Feb 2004 08:08:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: cw@f00f.org, mfedyk@matchmail.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: Large slab cache in 2.6.1
Message-ID: <38800000.1077466122@[10.10.2.4]>
In-Reply-To: <20040221221553.01b1b71c.akpm@osdl.org>
References: <4037FCDA.4060501@matchmail.com><20040222023638.GA13840@dingdong.cryptoapps.com><Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org><20040222031113.GB13840@dingdong.cryptoapps.com><Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040221221553.01b1b71c.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Saturday, February 21, 2004 22:15:53 -0800):

> Linus Torvalds <torvalds@osdl.org> wrote:
>> 
>> What happened to the experiment of having slab pages on the (in)active
>>  lists and letting them be free'd that way? Didn't somebody already do 
>>  that? Ed Tomlinson and Craig Kulesa?
> 
> That was Ed.  Because we cannot reclaim slab pages direct from the LRU it
> turned out that putting slab pages onto the LRU was merely an extremely
> complicated way of making the VFS cache scanning rate porportional to the
> pagecache scanning rate.  So we ended up doing just that, without putting
> the slab pages on the LRU.

I still don't understand the rationale behind the way we currently do it - 
perhaps I'm just being particularly dense. If we have 10,000 pages full of
dcache, and start going through shooting entries by when they were LRU wrt
the entries, not the dcache itself, then (assuming random access to dcache),
we'll evenly shoot the same number of entries from each dcache page without
actually freeing any pages at all, just trashing the cache.

Now I'm aware access isn't really random, which probably saves our arse.
But then some of the entries will be locked too, which only makes things
worse (we free a bunch of entries from that page, but the page itself
still isn't freeable). So it still seems likely to me that we'll blow 
away at least half of the dcache entries before we free any significant 
number of pages at all. That seems insane to me. Moreover, the more times 
we shrink & fill, the worse the layout will get (less grouping of "recently 
used entries" into the same page).

Moreover, it seems rather expensive to do a write operation for each 
dentry to maintain the LRU list over entries. But maybe we don't do that
anymore with dcache RCU - I lost track of what that does ;-( So doing it
on the page LRU basis still makes a damned sight more sense to me. Don't
we want semantics like "once used vs twice used" preference treatment 
for dentries, etc anyway?

If someone has the patience to explain exactly why I'm crazy (on this topic,
not in general) I'd appreciate it ;-)

M.

