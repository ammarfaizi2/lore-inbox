Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVDFTDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVDFTDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVDFTDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:03:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30423 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262284AbVDFTDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:03:46 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112811732.3377.41.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <1112781070.1981.34.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112806429.5396.15.camel@localhost.localdomain>
	 <1112811732.3377.41.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 06 Apr 2005 12:03:43 -0700
Message-Id: <1112814223.5396.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 19:22 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, 2005-04-06 at 17:53, Mingming Cao wrote:
> 
> > > Possible, but not necessarily nice.  If you've got a nearly-full disk,
> > > most bits will be already allocated.  As you scan the bitmaps, it may
> > > take quite a while to find a free bit; do you really want to (a) lock
> > > the whole block group with a temporary window just to do the scan, or
> > > (b) keep allocating multiple smaller windows until you finally find a
> > > free bit?  The former is bad for concurrency if you have multiple tasks
> > > trying to allocate nearby on disk --- you'll force them into different
> > > block groups.  The latter is high overhead.
> 
> > I am not quite understand what you mean about (a).  In this proposal, we
> > will drop the lock before the scan. 
> 
> s/lock/reserve/.  
> 
> > And for (b), maybe I did not make myself clear: I am not proposing to
> > keeping allocating multiple smaller windows until finally find a free
> > bit. I mean, we book the window(just link the node into the tree) before
> > we drop the lock, if there is no free bit inside that window, we will go
> > back search for another window(call find_next_reserveable_window()),
> > inside it, we will remove the temporary window we just created and find
> > next window. SO we only have one temporary window at a time. 
> 
> And that's the problem.  Either we create small temporary windows, in
> which case we may end up thrashing through vast numbers of them before
> we find a bit that's available --- very expensive as the disk gets full
> --- or we use large windows but get worse layout when there are parallel
> allocators going on.
> 

Ah... I see your points. (a) is certainly not a good option. (b) is not
very nice, but not necessary that bad when the disk is really full: We
are not only scanning the bitmap within the reserved window range,
instead, scanning the bitmap start from the reserved window start block
to the last block of the group, to find the next free bit; So in the
case the group is really full, we could reduce the # of small windows to
to try.

Mingming


