Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUJOQCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUJOQCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUJOQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:02:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14803 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268097AbUJOQB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:01:58 -0400
Subject: Re: [Ext2-devel] Ext3 -mm reservations code: is this fix really
	correct?
From: mingming cao <cmm@us.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1097846833.1968.88.camel@sisko.scot.redhat.com>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097856114.4591.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Oct 2004 09:01:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 06:27, Stephen C. Tweedie wrote:
> Hi,
> 
> In ext3-reservations-window-allocation-fix.patch from -mm, we try to
> make sure that we always search for a new reservation from the goal
> forwards, not just from the previous window forwards.  I'm assuming this
> is done to optimise random writes.
> 
> I'm still not convinced we get it right.  In alloc_new_reservation(), we
> do:
> 
> 		if ((my_rsv->rsv_start <= group_end_block) &&
> 				(my_rsv->rsv_end > group_end_block))
> 			return -1;
> 
> We get into alloc_new_reservation in the first place either when the
> goal is outside the window, or we could not allocate inside the window.
> 
> Now, in the latter case, the check is correct --- if the window spans
> two block groups and we couldn't allocate in the first block group, then
> we should continue in the next one.
> 
> But what if the goal was in the current block group, but was *prior* to
> the window?  The goal is outside the window, yet the above check may
> still be true, and we'll incorrectly decide to avoid the current block
> group entirely.
> 
> I think we need an "&& start_block >= my_rsv->rsv_start" to deal with
> this.
> 

You are right. I think at the beginning we were decide the honor the the
reservation window if the goal is out of the window. Considering the
goal is selected with good reason, we agreed that we should try honor
the goal block all the time.But we missed this case apparently.

> If we get past that test --- the reservation window is all entirely
> inside one group --- then we have the following chunk in
> xt3-reservations-window-allocation-fix.patch:
> 
> -		/* remember where we are before we discard the old one */
> -		if (my_rsv->rsv_end + 1 > start_block)
> -			start_block = my_rsv->rsv_end + 1;
> -		search_head = my_rsv;
> +		search_head = search_reserve_window(&my_rsv->rsv_node, start_block);
> 
> which I'm assuming is trying to pin the search start to the goal block. 
> But that's wrong --- search_reserve_window does a downwards-traversing
> tree search, and needs to be given the root of the tree in order to find
> a given block.  Giving it the current reservation node as the search
> start point is not going to allow it to find the right node in all
> cases.
> 
> Have I misunderstood something?
> 
You are correct, again:) We should do a search_reserve_window() from the
root.

I will post a fix for these two soon.

Mingming

