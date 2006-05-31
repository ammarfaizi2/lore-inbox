Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWEaQMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWEaQMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWEaQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:12:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751634AbWEaQMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:12:37 -0400
Date: Wed, 31 May 2006 09:12:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605310903310.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au>
 <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au>
 <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 May 2006, Linus Torvalds wrote:
> 
> In other words, we actually want to unplug at lock_page(), BUT ONLY IF IT 
> NEEDS OT WAIT, which is by no means all of them. So it's more than just 
> "add an unplug at lock_page()" it's literally "add an unplug at any 
> lock-page that blocks".

Btw, don't get me wrong. In the read case, every time we do a lock_page(), 
we might as well unplug unconditionally, because we effectively know we're 
going to wait (we just checked that it's not up-to-date). Sure, there's a 
race window, but we don't care - the window is very small, and in the end, 
unplugging isn't a correctness issue as long as you do it at least as 
often as required (ie unplugging too much is ok and at worst just makes 
for bad performance - so a very unlikely race that causes _extra_ 
unplugging is fine as long as it's unlikely. forgetting to unplug is bad).

In the write case, lock_page() may or may not need an unplug. In those 
cases, it needs unplugging if it was locked before, but obviously not if 
it wasn't.

In the "random case" where we use the page lock not because we want to 
start IO on it, but because we need to make sure that page->mapping 
doesn't change, we don't really care about the IO, but we do need to 
unplug just to make sure that the IO will complete. 

And I suspect your objection to unplugging is not really about unplugging 
itself. It's literally about the fact that we use the same page lock for 
IO and for the ->mapping thing, isn't it?

IOW, you don't actually dislike plugging itself, you dislike it due to the 
effects of a totally unrelated locking issue, namely that we use the same 
lock for two totally independent things. If the ->mapping thing were to 
use a PG_map_lock that didn't affect plugging one way or the other, you 
wouldn't have any issues with unplugging, would you?

And I think _that_ is what really gets us to the problem. 

			Linus
