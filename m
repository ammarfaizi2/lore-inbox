Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271665AbRHQOmD>; Fri, 17 Aug 2001 10:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271650AbRHQOlx>; Fri, 17 Aug 2001 10:41:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39951 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269350AbRHQOlo>; Fri, 17 Aug 2001 10:41:44 -0400
Date: Fri, 17 Aug 2001 10:13:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Write drop behind logic with used-once patch
In-Reply-To: <20010816114148Z16441-1231+1181@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108171009560.29744-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Aug 2001, Daniel Phillips wrote:

> On August 16, 2001 09:43 am, Marcelo Tosatti wrote:
> > Hi Daniel,
> > 
> > As far as I can see, the write drop behind logic with the used-once patch
> > is partly "gone" now: "check_used_once()" at generic_file_write() will set
> > all "write()n" pages to have age == PAGE_AGE_START (in case those pages
> > were not in cache before), which means they will be moved to the active
> > list later by page_launder(), effectively causing excessive pressure on
> > the current "active" pages since we have exponential page aging.
> > 
> > I'm I overlooking some here or my thinking is correct ?
> 
> The initial page create sets age=0 which serves as a "new" flag when the
> page is on the inactive list.  When the page is actually touched the
> first time it transitions from age=0 to age=START, again the age is
> simply a state flag.  When the page is touched the second time it's
> immediately activated, doing whatever activate does.  I didn't touch
> activate.
> 
> So any generic_read/write[1] page that gets used twice never gets to the
> end of the inactive queue, was that your question?

Yes.

I'm afraid the new page_launder() logic will block tasks (kswapd mainly,
of course) on writeout of those "deactivated" pages (which are potentially
"young").

