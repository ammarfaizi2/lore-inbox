Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274618AbRITT2B>; Thu, 20 Sep 2001 15:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274619AbRITT1v>; Thu, 20 Sep 2001 15:27:51 -0400
Received: from waste.org ([209.173.204.2]:24659 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S274618AbRITT1k>;
	Thu, 20 Sep 2001 15:27:40 -0400
Date: Thu, 20 Sep 2001 14:29:12 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Stephan von Krawczynski <skraw@ithnet.com>, <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: [PATCH] fix page aging (2.4.9-ac12)
In-Reply-To: <20010920154806.75d7da23.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.30.0109201417180.5622-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Stephan von Krawczynski wrote:

> On Thu, 20 Sep 2001 15:32:26 +0200 Daniel Phillips <phillips@bonn-fries.net>
> wrote:
>
> > > Perhaps the following would be better, just in case anyone sets
> > > PAGE_AGE_DECL to something other than 1.
> > >
> > >     static inline void age_page_down(struct page *page)
> > >     {
> > > 	unsigned long age = page->age;
> > > 	if (age > PAGE_AGE_DECL)
> > > 		age -= PAGE_AGE_DECL;
> > > 	else
> > > 		age = 0;
> > > 	page->age = age;
> > >     }
> >
> >
> >      static inline void age_page_down(struct page *page)
> >      {
> >  	page->age = max((int) (age - PAGE_AGE_DECL), 0);
> >      }
> >
> > ;-)
>
> Aehm, Daniel. Just for a hint of what I know about C:
>
> IF age is unsigned long (like declared above) and PAGE_AGE_DECL is a define,
> then age-PAGE_AGE_DECL is of type unsigned long, which means it will not go
> below 0 but instead be huge positive, so your cast (int) before will not do any
> good, and you will not end up with 0 but somewhere above the clouds.

Bzzt. Conversion from unsigned to signed where the value won't fit is
implementation defined. In practice it's done by truncation which in the
case of twos-complement arithmetic means it becomes negative again, and it
all works. More problematic is when age is just above 2^31 and suddenly
becomes zero - not likely to show up though.

A better paradigm:

 age = max(age, PAGE_AGE_DECL) - PAGE_AGE_DECL;
 age -= min(age, PAGE_AGE_DECL);

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

