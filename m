Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUH2Bbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUH2Bbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 21:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUH2Bba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 21:31:30 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:18289 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267509AbUH2Baz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 21:30:55 -0400
Message-ID: <413131A0.4070100@yahoo.com.au>
Date: Sun, 29 Aug 2004 11:30:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Ram Pai <linuxram@us.ibm.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
References: <Pine.LNX.4.44.0408281519300.4593-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0408281519300.4593-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sat, 28 Aug 2004, Nick Piggin wrote:
> 
>>Ahh, yep - Hugh just forgot to also move the "nr" calculation
>>into the ->readpage path, so it hits twice on the fast path.
> 
> 
> Yes, your patch is better than mine.
> 
> 
>>What's more, it looks like mine handles the corner case of reading off the
>>end of a non-PAGE_SIZE file (but within the same page). I think yours will
>>drop through and do the ->readpage, while mine doesn't...?
> 
> 
> It's a common case, not a corner case: a short read to end of file,
> then app does another read which returns 0 for the end of file: that
> wouldn't normally fall through to readpage in Ram's case, but would
> do unnecessary page_cache_readahead (won't do much) and find_get_page.
> 

Ahh, yeah I guess that would be the more common case. I was just
thinking of just randomly reading past the end of the file - in
that case it *would* fall through to ->readpage if the page wasn't
in cache.

But anyway, I think we agree my (our) version should cover that.

> 
>>I agree. We'll leave it to someone else to decide, then ;)
> 
> 
> I vote for Nick's patch.
> 

OK - maybe that can go for a spin in the next -mm. Andrew did you
get it?

> I do have one reservation on do_generic_mapping_read,
> common to all these versions, unrelated to the current issue.
> 
> I'm surprised to notice that you're careful to re-i_size_read
> after readpage, but otherwise rely on the initial i_size_read.
> We could go around this loop many many times, faulting user pages
> in actor, rescheduling away: the old (e.g. 2.4 or 2.6.0) code was
> deficient after readpage, but at least it reassessed i_size each
> time around the loop.  I guess if the file is truncated meanwhile,
> the common case would be for a find_get_page to fail, and then the
> situation be corrected after readpage; perhaps it's more likely to
> show up as read returning too little on a large file being steadily
> appended.  Maybe you already ruled these cases out as not worth the
> overhead of handling, but it does surprise me that the old code was
> safer in this respect.
> 

Yeah I guess it is a case of doing the minimum that is really
needed.

Although considering page_cache_readahead call can do an i_size_read,
it might be nicer to probably change the interface to have it passed down
instead
