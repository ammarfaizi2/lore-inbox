Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWEaN3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWEaN3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEaN3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:29:48 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:34177 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965014AbWEaN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:29:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YGT5hQnYTpY7tSSlxTeafKtiHwjJiJ1eMOnmPQOPtalsrcc8HeBu9TAxASW9jC3Rz7xIP6MJGhYfjygD+HEDx2xMR7Bpt83XmZimLl7kQzwTb+DnbS/1wn8kOqVaEXaEi3ElobvWTc9/BIjCKGaLqkWETtrV+3BQiKDqprPiXoE=  ;
Message-ID: <447D9A41.8040601@yahoo.com.au>
Date: Wed, 31 May 2006 23:29:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 31 May 2006, Nick Piggin wrote:
> 
>>The requests can only get merged if contiguous requests from the upper
>>layers come down, right?
> 
> 
> It has nothing to do with merging. It has to do with IO patterns.
> 
> Seeking.
> 
> Seeking is damn expensive - much more so than command issue. People forget 
> that sometimes.

OK, I didn't forget that it is expensive, but I didn't make the
connection that this is what you were arguing for.

I would be surprised if plugging made a big difference to seeking:
1. the queue will be plugged only if there are no other requests (so,
    nothing else to seek to).
2. if the queue was plugged and we submitted one small request,
    another request to somewhere else on the drive that comes in can
    itself unplug the queue and cause seeking.

as-iosched is good at cutting down seeks because it doesn't "unplug"
in situation #2.

Now having a mechanism for a task to batch up requests might be a
good idea. Eg.

plug();
submit reads
unplug();
wait for page

I'd think this would give us the benefits of corse grained (per-queue)
plugging and more (e.g. it works when the request queue isn't empty).
And it would be simpler because the unplug point is explicit and doesn't
need to be kicked by lock_page or wait_on_page

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
