Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274501AbRITOD5>; Thu, 20 Sep 2001 10:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274502AbRITODr>; Thu, 20 Sep 2001 10:03:47 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:32865 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S274501AbRITODg>; Thu, 20 Sep 2001 10:03:36 -0400
Date: Thu, 20 Sep 2001 17:03:49 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: [PATCH] fix page aging (2.4.9-ac12)
Message-ID: <20010920170349.E22640@niksula.cs.hut.fi>
In-Reply-To: <20010920154806.75d7da23.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010920154806.75d7da23.skraw@ithnet.com>; from skraw@ithnet.com on Thu, Sep 20, 2001 at 03:48:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 03:48:06PM +0200, you [Stephan von Krawczynski] claimed:
> On Thu, 20 Sep 2001 15:32:26 +0200 Daniel Phillips <phillips@bonn-fries.net>
> wrote:
> 
> >      static inline void age_page_down(struct page *page)
> >      {
> >  	page->age = max((int) (age - PAGE_AGE_DECL), 0);
> >      }
> 
> Aehm, Daniel. Just for a hint of what I know about C:
> 
> IF age is unsigned long (like declared above) and PAGE_AGE_DECL is a define,
> then age-PAGE_AGE_DECL is of type unsigned long, which means it will not go
> below 0 but instead be huge positive, so your cast (int) before will not do any
> good, and you will not end up with 0 but somewhere above the clouds.
> So you just made Linus' max/min/cast point of view _very_ clear, I guess it was
> something like "people don't really think about using max/min and related
> problems".

age - PAGE_AGE_DECL may be a 2^32-1 or so, but when you cast it back to int,
it is at most 2^31 again. It rolls over, so you get the sign bit back.
Witness:

vherva@linux:/home/vherva>cat n.c
#define FOUR 4
void main()
{
   unsigned three = 3;
   printf("%u\n", three - FOUR);
   printf("%i\n", (int)(three - FOUR));
   printf("%i\n", (int)three - (int)FOUR);
}

vherva@linux:/home/vherva>./a.out
4294967295
-1
-1

Perhaps a lucky incidence, but it works as Daniel wrote it. (At least on
32-bit architecture.)

I agree that Rik's variant is much more readable.


-- v --

v@iki.fi
