Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWIGHM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWIGHM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 03:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWIGHM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 03:12:28 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:53189 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750709AbWIGHM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 03:12:26 -0400
Date: Thu, 7 Sep 2006 11:10:57 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chase Venters <chase.venters@clientec.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take16 1/4] kevent: Core files.
Message-ID: <20060907071057.GB31716@2ka.mipt.ru>
References: <1157543723488@2ka.mipt.ru> <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse> <20060906140330.GA24057@2ka.mipt.ru> <Pine.LNX.4.64.0609060907560.18512@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609060907560.18512@turbotaz.ourhouse>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 07 Sep 2006 11:10:59 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 09:23:56AM -0500, Chase Venters (chase.venters@clientec.com) wrote:
> On Wed, 6 Sep 2006, Evgeniy Polyakov wrote:
> >>>+struct kevent_user
> >>>+{
> >>
> >>These structure names get a little dicey (kevent, kevent_user, ukevent,
> >>mukevent)... might there be slightly different names that could be
> >>selected to better distinguish the purpose of each?
> >
> >Like what?
> >ukevent means userspace_kevent, but ukevent is much smaller.
> >mukevent is mapped userspace kevent, mukevent is again much smaller.
> >
> 
> Hmm, well, kevent_user and ukevent are perhaps the only ones I'm concerned 
> about. What about calling kevent_user a kevent_queue, kevent_fd or 
> kevent_set?

kevent_user is kernel side representation of, guess what? Yes, kevent
user :)

> >I decided to use queue length for mmaped buffer, using size of the
> >mmapped buffer as queue length is possible too.
> >But in any case it is very broken behaviour to introduce any kind of
> >overflow and special marking for that - rt signals already have it, no
> >need to create additional headache.
> >
> 
> Hmm. The concern here is pinned memory, is it not? I'm trying to think of 
> the best way to avoid compile-time limits. select() has a rather 
> (infamous) compile-time limit of 1,024 thanks to libc (and thanks to the 
> bit vector, a glass ceiling). Now, you'd be a fool to use select() on that 
> many
> fd's in modern code meant to run on modern UNIXes. But kevent is a new 
> system, the grand unified event loop all of us userspace programmers have 
> been begging for since many years ago. Glass ceilings tend to hurt when 
> you run into them :)
> 
> Using the size of the memory mapped buffer as queue length sounds like a 
> sane simplification.

Pinned memory is not the _main_ issue in a real world application - only
if it is some kind of a DoS or really broken behaviour where tons of
event queues are going to be created (like many epoll control
descriptors).
Memory mapped buffer actually can even not exist, if application is not
going to use mmap interface.

> >>>+static int kevent_user_ring_init(struct kevent_user *u)
> >>>+{
> >>>+	int pnum;
> >>>+
> >>>+	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) +
> >>>sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
> >>
> >>This calculation works with the current constants, but it comes up a page
> >>short if, say, KEVENT_MAX_EVENTS were 4095. It also looks incorrect
> >>visually since the 'sizeof(unsigned int)' is only factored in once (rather
> >>than once per page). I suggest a static / inline __max_kevent_pages()
> >>function that either does:
> >>
> >>return KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE + 1;
> >>
> >>or
> >>
> >>int pnum = KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE;
> >>if (KEVENT_MAX_EVENTS % KEVENTS_ON_PAGE)
> >>	pnum++;
> >>return pnum;
> >>
> >>Both should be optimized away by the compiler and will give correct
> >>answers regardless of the constant values.
> >
> >Above pnum calculation aligns number of mukevents to pages size with
> >appropriate check for (unsigned int), although it is not stated in that
> >comment (more clear commant can be found around KEVENTS_ON_PAGE).
> >You propose esentially the same calcualtion in the seconds case, while
> >first one requires additional page in some cases.
> >
> 
> You are right about my first suggestion sometimes coming up a page extra. 
> What I'm worried about is that the current ALIGN() based calculation comes 
> up a page short if KEVENT_MAX_EVENTS is certain values (say 4095). This is 
> because the "unsigned int index" is inside kevent_mring for every page, 
> though the ALIGN() calculation just factors in room for one of them. In 
> these boundary cases (KEVENT_MAX_EVENTS == 4095), your calculation thinks 
> it can fit one last mukevent on a page because it didn't factor in room 
> for "unsigned int index" at the start of every page; rather just for one 
> page. In this case, the modulus should always come up non-zero, giving us 
> the extra required page.

Comment about KEVENTS_ON_PAGE celarly says what must be taken into
account when size is calculated, but you are right, I should use there
better macros, which should take sizeof(struct kevent_mring).
I will update it.

> >It is unused, but I'm still waiting on comments if we need
> >kevent_get_events() at all - some people wanted to completely eliminate
> >that function in favour of total mmap domination.
> >
> 
> Interesting idea. It would certainly simplify the interface.

Only for those who really wants to use additional mmap interface.

> >
> >I have no strong opinion on how to behave in this situation.
> >kevent can panic, can free cache, can go to infinite loop or screw up
> >the hard drive. Everything is (almost) the same.
> >
> 
> Obviously it's not a huge deal :)
> 
> If kevent is to screw up the hard drive, though, we must put in an 
> exception for it to avoid my music directory.

Care to send a patch for kernel command line? :)


-- 
	Evgeniy Polyakov
