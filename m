Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVAFFTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVAFFTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVAFFTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:19:44 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:63143 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262730AbVAFFTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:19:41 -0500
Message-ID: <41DCCA68.3020100@yahoo.com.au>
Date: Thu, 06 Jan 2005 16:19:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org> <20050106051707.GP4597@dualathlon.random>
In-Reply-To: <20050106051707.GP4597@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jan 05, 2005 at 09:05:39PM -0800, Andrew Morton wrote:
> 
>>Andrea Arcangeli <andrea@suse.de> wrote:
>>
>>>The fix is very simple and it is to call wait_on_page_writeback on one
>>> of the pages under writeback.
>>
>>eek, no.  That was causing waits of five seconds or more.  Fixing this
>>caused the single greatest improvement in page allocator latency in early
>>2.5.  We're totally at the mercy of the elevator algorithm this way.
>>
>>If we're to improve things in there we want to wait on _any_ eligible page
>>becoming reclaimable, not on a particular page.
> 
> 
> I told you one way to fix it. I didn't guarantee it was the most
> efficient one.
> 
> I sure agree waiting on any page to complete writeback is going to fix
> it too. Exactly because this page was a "random" page anyway.
> 
> Still my point is that this is a bug, and I prefer to be slow and safe
> like 2.4, than fast and unreliable like 2.6.
> 
> The slight improvement you suggested of waiting on _any_ random
> PG_writeback to go away (instead of one particular one as I did in 2.4)
> is going to fix the write throttling equally too as well as the 2.4
> logic, but without introducing slowdown that 2.4 had.
> 
> It's easy to demonstrate: exactly because the page we pick is random
> anyway, we can pick the first random one that has seen PG_writeback
> transitioning from 1 to 0. The guarantee we get is the same in terms of
> safety of the write throttling, but we also guarantee the best possible
> latency this way. And the HZ/x hacks to avoid deadlocks will magically
> go away too.
> 

This is practically what blk_congestion_wait does when the queue
isn't congested though, isn't it?
