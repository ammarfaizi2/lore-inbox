Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWEaAWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWEaAWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWEaAWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:22:04 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:29274 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932542AbWEaAWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:22:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DD7gKw7ZBpjbbjP/SyOag7lkyDxCiti3hNGAP2lt7kEdfKFQYOmKN1rJSkQYtglKihyVmv3jezRqGOsm+3q4qcsLSuijkWTcpJsAKy1aGsJ4IKWoOh8FImaoZEuGi2W9z5Ogu+S88cLfZQ4R7wCN6SMnxnwzFfoRr0gNglChfTs=  ;
Message-ID: <447CE1A3.60507@yahoo.com.au>
Date: Wed, 31 May 2006 10:21:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD9CE.2020505@yahoo.com.au> <Pine.LNX.4.64.0605301911480.10355@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605301911480.10355@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 30 May 2006, Nick Piggin wrote:
> 
>>But for 2.6.17, how's this?
> 
> 
> It was a great emperor's-clothes-like discovery.  But we've survived
> for so many years without noticing, does it have to be fixed right
> now for 2.6.17?  (I bet I'd be insisting yes if I'd found it.)

It's up to Linus and Andrew I guess. I don't see why not, but I
don't much care one way or the other. But thanks having a quick
look at it, we may want it for the Suse kernel.

> 
> The thing I don't like about your lock_page_nosync (reasonable as
> it is) is that the one case you're using it, set_page_dirty_nolock,
> would be so much happier not to have to lock the page in the first
> place - it's only doing _that_ to stabilize page->mapping, and the
> lock_page forbids it from being called from anywhere that can't
> sleep, which is often just where we want to call it from.  Neil's
> suggestion, using a spin_lock against the mapping changing, would
> help there; but seems like more work than I'd want to get into.

But making PG_lock a spinning lock is completely unrelated to the
bug at hand.

> 
> So, although I think lock_page_nosync fixes the bug (at least in
> that one place we've identified there's likely to be such a bug),
> it seems to be aiming at the wrong target.  I'm pacing and thinking,
> doubt I'll come up with anything better, please don't hold breath.

It is the correct target. I know all about your set_page_dirty_lock
problems, but they aren't what I'm trying to fix.

AFAIKS, you could also make set_page_dirty_lock non sleeping quite
easily by making inode slabs RCU freed.

What places want to use set_page_dirty_lock without sleeping?
The only place in drivers/ apart from sg/st that SetPageDirty are
rd.c and via_dmablit.c, both of which look OK, if a bit crufty.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
