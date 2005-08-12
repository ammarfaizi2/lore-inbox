Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVHLWOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVHLWOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVHLWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 18:14:39 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:43161 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S1751302AbVHLWOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 18:14:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Daniel Phillips <phillips@arcor.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Sat, 13 Aug 2005 00:20:10 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Pavel Machek <pavel@suse.cz>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <200508111236.25576.rjw@sisk.pl> <200508130556.11215.phillips@arcor.de>
In-Reply-To: <200508130556.11215.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508130020.11864.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 12 of August 2005 21:56, Daniel Phillips wrote:
> On Thursday 11 August 2005 20:36, Rafael J. Wysocki wrote:
> > > >> > Swsusp is the main "is valid ram" user I have in mind here. It
> > > >> > wants to know whether or not it should save and restore the
> > > >> > memory of a given `struct page`.
> > > >>
> > > >> Why can't it follow the rmap chain?
> > > >
> > > > It is walking physical memory, not memory managment chains. I need
> > > > something like:
> > >
> > > Can you not use page_is_ram(pfn) ?
> >
> > IMHO it would be inefficient.
> >
> > There obviously are some non-RAM pages that should not be saved and there
> > are some that are not worthy of saving, although they are RAM (eg because
> > they never change), but this is very archtecture-dependent.  The arch code
> > should mark them as PageNosave for swsusp, and that's enough.
> 
> I still don't see why you can't lift your flags up into the VMA.  The rmap 
> mechanism is there precisely to let you get from the physical page to the 
> users and user data, including VMAs.

I'm not sure if I understand the issue, but swsusp works on a different level.
It only needs to figure out which physical pages, as represented by struct page
objects, should be saved to swap before suspend.  We browse all zones (once)
and create a list of page frames that should be saved on the basis of the contents
of the struct page objects alone.  IMHO if we needed to use any additional
mechanisms here, it would be less efficient than just checking the page flags.

> I am also not sure why you are talking about efficiency here.  Did you measure 
> the impact on suspend performance?

I should have said "not enough".  The problem is that there may be some page
frames corresponding to RAM (eg such that page_is_ram(pfn) is non-zero) which
for some reason should not be saved on given architecture and we need a
mechanism allowing us to identify them.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
