Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSLIWZR>; Mon, 9 Dec 2002 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLIWX3>; Mon, 9 Dec 2002 17:23:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:8079 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266308AbSLIWXT>;
	Mon, 9 Dec 2002 17:23:19 -0500
Message-ID: <3DF4EE8E.2339BD8F@digeo.com>
Date: Mon, 09 Dec 2002 11:27:10 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kingsley Cheung <kingsley@aurema.com>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL PATCH 2.4.20] madvise_willneed makes bad limit comparison
References: <20021209150426.D12270@aurema.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 19:27:10.0930 (UTC) FILETIME=[F85AE320:01C29FB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung wrote:
> 
> Hi,
> 
> 'madvise_willneed' makes an incorrect rss limit comparison.  It
> directly compares rlim[RLIMIT_RSS].rlim_cur to rss. The former is in
> bytes, whereas the latter is in pages.  The fix for this is trivial.
> 

It's surely a bug, but looking at the code, one does ask "what
on earth is it trying to do"?

1) -EIO is not a recognised (or appropriate) return value.

2) If the MADV_WILLNEED call fails, all the user needs to do is to
   use a smaller chunk, and walk across the file using that chunk
   size!  The only system-protecting limit here is the request queue
   size.

3) We don't know that the application will try to map all that readahead
   at the same time anyway.  And if it does, the rlimits will catch it.

Linus used "half the size of the inactive list" in sys_readahead. That's
probably as good as anything else.  I'd suggest that we just share
that bit of code in madvise.

hmm.  Also the new readahead code will allocate all that memory up-front
before putting it under I/O.   I'll fix up do_page_cache_readahead()
for that.


> [As an aside, one question is whether this limit check is needed at
> all.  Most rss limit enforcement implementations that I've seen are
> 'soft', whereas this would give the limit 'hard' semantics.  Do we
> really want 'hard' limit semantics?]
> 

I agree that failing with an error is inappropriate.

We should limit the readahead according to machine size, disk bandwidth,
free memory availability, shoe size, etc.  And once that's done then
it _has_ to return success.  Otherwise the application would see
different results depending on system size and activity.

It is just "advice".
