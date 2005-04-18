Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVDRSBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVDRSBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVDRSBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:01:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52677 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262092AbVDRSBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:01:10 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1113597161.3899.80.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113597161.3899.80.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113847223.14961.141.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 18 Apr 2005 19:00:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-04-15 at 21:32, Mingming Cao wrote:

> Sorry for the delaying. I was not in office these days.
No problem.


> > > Also I am concerned about the possible
> > > starvation on writers.
> > In what way?
> I was worried about the rw lock case.:)

OK, so we're both on the same track here. :-)

> > Note that there _is_ some additional complexity here.  It's not entirely
> > free.  Specifically, if we have other tasks waiting on our provisional
> > window, then we need to be very careful about the life expectancy of the
> > wait queues involved, so that if the first task fixes its window and
> > then deletes it before the waiters have woken up, they don't get
> > confused by the provisional window vanishing while being waited for.

> This approach(provisional window) sounds interesting to me, but it's a
> little more complicated than I thought:(

Yep.  Once you have other tasks waiting on your window while it's not
locked, object lifetime becomes a much bigger problem.

> alloc_new_reservation()
> retry:
> lock the tree
> 	search for a new space start from the given startblock
> 	found a new space
> 	if the new space is not a "provisional window" 

I was thinking rather that we _start_ with the window, and _then_ look
for new space.

So we'd start with:

if we already have a window, 
	mark it provisional; 
else,
	do
		search for a new window;
		if the immediately preceding window is provisional, 
			wait for that window;
			continue;
		allocate the window and mark it provisional;
		break

At this point we have a provisional window, and we know that nobody else
is going to allocate either in it, or in the empty space following it
(because if they tried to, they'd bump into our own provisional window
as their predecessor and would wait for us.)  So even if the window
doesn't occupy the _whole_ unreserved area, we can still keep searching
without fear of multiple tasks trying to do so in the same space at the
same time.

--Stephen

