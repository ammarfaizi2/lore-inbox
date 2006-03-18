Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWCRFis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWCRFis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWCRFis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:38:48 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:23465 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751865AbWCRFir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:38:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6wlmDKvzpnAH8jc5FLrw/XswhlJvzY5XvZ5ZCq3WaaDLzWltigyZp7M8/Y+31nzTXARWZoThOR4+Zuo7VE2gA2FY9E+E5gI1Owh4Y6YpaF6VoO1nu8JUPlU8GdYTiHD3EpLe3BOuzE09QmTp6Z0VMxmNKYgSlUZJpmbliRd5mIo=  ;
Message-ID: <441B9CE2.2050204@yahoo.com.au>
Date: Sat, 18 Mar 2006 16:38:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
References: <20060317145709.GA4296@sgi.com>	<20060317145912.GA13207@elte.hu>	<20060317152611.GA4449@sgi.com>	<20060317171538.3826eb41.akpm@osdl.org>	<441B6BD3.2030807@yahoo.com.au>	<20060317183742.10431ba2.akpm@osdl.org>	<441B7489.1090403@yahoo.com.au> <20060317211315.55457f22.akpm@osdl.org>
In-Reply-To: <20060317211315.55457f22.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>>>Is there a need? Do they (except calc_load) use multiple values at
>>>>the same time?
>>>
>>>
>>>Don't know.  It might happen in the future.  And the additional cost is
>>>practically zero.
>>>
>>
>>Unless it happens to hit another cacheline (cachelines for all other
>>CPUs but our own will most likely be invalid on this cpu). In which
>>case the cost could double quite easily.
>>
> 
> 
> That would be an inefficient implementation.  Let's not implement it
> inefficiently.
> 

Unconditionally adding up n fields in the runqueue versus 1 field?
It is inevitable that they will cross cacheline boundaries on some
CPU architectures and with some per-cpu implementations isn't it?

> 
>>I think it might be better to leave it for the moment. If something comes
>>up we can always take a look at it then (it isn't particularly tricky code).
> 
> 
> What we're seeing here is a proliferation of little functions, all of which
> do the same thing, some of them in different ways.
> 

Of course they should be made consistent where it makes sense.

> Take a look at (for example) nr_iowait.  We forget to spill the count out
> of the departing CPU's runqueue and hence we have to sum it across all

I don't think a departing runqueue should have any iowaiters on it, should it?

> possible CPUs and we don't bother accounting for the possibility of the sum
> going negative because we happen to dink with the runqueue of a
> now-possibly-downed CPU.  It's inefficient and it's inconsistent and some
> of it is, or will become incorrect.  The other counters there probably have
> various combinations of these problems but I can't be bothered checking
> them all because they're all implemented differently.
> 

Maybe (they're also used in different ways, and with different races to
be careful of so in some respects that is inevitable). But that doesn't
mean we should introduce this new get_sched_stats thing.

> Better to do them all in the one place and do them all the same way.  I'd
> suggest a cacheline-aligned struct of local_t's which can be queried into a
> struct of ulongs.
> 

Now common scheduler operations have to access the runqueue cacheilnes
and this disjoint "stats" structure cacheline, so basic operations will
get slower. Not to mention that all but one are protected by the runqueue
lock, so local_t isn't needed for the rest of them.

> That query should only look at online CPUs, which becomes rather necessary
> if we're to allocate runqueues only for online CPUs (desirable - the thing
> is huge).
> 

Sure, those consistency and efficiency changes should be made now, with
the current structure.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
