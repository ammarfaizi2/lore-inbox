Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271555AbRHPLl7>; Thu, 16 Aug 2001 07:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271556AbRHPLlu>; Thu, 16 Aug 2001 07:41:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8454 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271555AbRHPLlg>; Thu, 16 Aug 2001 07:41:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Write drop behind logic with used-once patch
Date: Thu, 16 Aug 2001 13:48:08 +0200
X-Mailer: KMail [version 1.3]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0108160423440.27203-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108160423440.27203-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816114148Z16441-1231+1181@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 16, 2001 09:43 am, Marcelo Tosatti wrote:
> Hi Daniel,
> 
> As far as I can see, the write drop behind logic with the used-once patch
> is partly "gone" now: "check_used_once()" at generic_file_write() will set
> all "write()n" pages to have age == PAGE_AGE_START (in case those pages
> were not in cache before), which means they will be moved to the active
> list later by page_launder(), effectively causing excessive pressure on
> the current "active" pages since we have exponential page aging.
> 
> I'm I overlooking some here or my thinking is correct ?

The initial page create sets age=0 which serves as a "new" flag when the
page is on the inactive list.  When the page is actually touched the
first time it transitions from age=0 to age=START, again the age is
simply a state flag.  When the page is touched the second time it's
immediately activated, doing whatever activate does.  I didn't touch
activate.

So any generic_read/write[1] page that gets used twice never gets to the
end of the inactive queue, was that your question?

You're right on the other point, and Rik pointed it out before:
failing to clear the Referenced bit when activating gives the page a
double boost, and throws away information (we don't learn anything new
when we hit the page next time around the active scan).  So yes, this
part is subtly wrong.  To fix, move the ClearPageReferenced up 4 lines.
I mistakenly assumed that activate_page did the clear (as it should, for
the same reason as above) and over-optimized as a result.

I'd say: think about what activate_page should be doing before
changing check_use_once.

[1] Pages other than generic_read/write pages can get to the end of
the inactive queue with the Referenced bit set.  The only other place
that sets the referenced bit is touch_buffer, and there we could do
something smarter than just letting the page walk all the way down
the inactive queue.  For loads with heavy buffer usage (like dd) we
might see an artificially bloated inactive list as a result.  (I
didn't do anything about this because I couldn't detect any harmful
or beneficial effect on the test equipment I had available at the
time.  I'll check it again on this nice new VA box though:-)  Note
that if we also do unlazy activate on buffers we can lose another
test in each of page_launder and reclaim_page because all the pages
that make it to the end of the list will have their referenced bit
clear.  As you pointed out way back, the swap cache code needs to
do something more intelligent with age=0 pages.  Hmm.  Needs this
badly.

--
Daniel

