Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVDFSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVDFSWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVDFSWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 14:22:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262274AbVDFSWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 14:22:35 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112806429.5396.15.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <1112781070.1981.34.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112806429.5396.15.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112811732.3377.41.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Apr 2005 19:22:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 17:53, Mingming Cao wrote:

> > Possible, but not necessarily nice.  If you've got a nearly-full disk,
> > most bits will be already allocated.  As you scan the bitmaps, it may
> > take quite a while to find a free bit; do you really want to (a) lock
> > the whole block group with a temporary window just to do the scan, or
> > (b) keep allocating multiple smaller windows until you finally find a
> > free bit?  The former is bad for concurrency if you have multiple tasks
> > trying to allocate nearby on disk --- you'll force them into different
> > block groups.  The latter is high overhead.

> I am not quite understand what you mean about (a).  In this proposal, we
> will drop the lock before the scan. 

s/lock/reserve/.  

> And for (b), maybe I did not make myself clear: I am not proposing to
> keeping allocating multiple smaller windows until finally find a free
> bit. I mean, we book the window(just link the node into the tree) before
> we drop the lock, if there is no free bit inside that window, we will go
> back search for another window(call find_next_reserveable_window()),
> inside it, we will remove the temporary window we just created and find
> next window. SO we only have one temporary window at a time. 

And that's the problem.  Either we create small temporary windows, in
which case we may end up thrashing through vast numbers of them before
we find a bit that's available --- very expensive as the disk gets full
--- or we use large windows but get worse layout when there are parallel
allocators going on.

--Stephen

