Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSIEP76>; Thu, 5 Sep 2002 11:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSIEP76>; Thu, 5 Sep 2002 11:59:58 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:46252 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317694AbSIEP74>; Thu, 5 Sep 2002 11:59:56 -0400
Message-ID: <20020905160431.1671.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 5 Sep 2002 18:04:31 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
Subject: Re: [RFC] Alternative raceless page free
References: <3D644C70.6D100EA5@zip.com.au> <E17moT6-00064X-00@starship> <20020905123413.21580.qmail@thales.mathematik.uni-ulm.de> <E17myRo-00068H-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17myRo-00068H-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 05:21:31PM +0200, Daniel Phillips wrote:
> On Thursday 05 September 2002 14:34, Christian Ehrhardt wrote:
> > @@ -455,7 +458,7 @@
> >                         } else {
> >                                 /* failed to drop the buffers so stop here */
> >                                 UnlockPage(page);
> > -                               page_cache_release(page);
> > +                               put_page(page);
> > 
> >                                 spin_lock(&pagemap_lru_lock);
> >                                 continue;
> > 
> > looks a bit suspicious. put_page is not allowed if the page is still
> > on the lru and there is no other reference to it. As we don't hold any
> > locks between UnlockPage and put_page there is no formal guarantee that
> > the above condition is met. I don't have another path that could race
> > with this one though and chances are that there actually is none.
> 
> The corresponding get_page is just above, you must have overlooked it.

See it. The scenario im thinking about is:

CPU1                                CPU2
pick page from lru
Lock it
get_page
try_to_release_buffers fails
UnlockPage
/* Window here */
                                     Pick page form lru
				     page_cache_get
				     Lock it 
				     actually free the buffers
				     UnlockPage
				     page_cache_release
					doesn't remove the page from
					the lru because CPU 1 holds
					a reference
put_page dropps last reference
but doenn't remove the page from
the lru because it is put_page
and not page_cache release.
---> Page gets freed while it is still on the lru. If the lru cache
     holds a reference that's a non issue.

CPU1 is the path in shrink_cache.
I admit that I don't have a real path that does what CPU2 does in
this scenario but doing what CPU2 does should be perfectly legal.

> Besides that, we have a promise that the page still has buffers, worth

Not after UnlockPage.

> another count, and the page will never be freed here.  That's fragile
> though, and this particular piece of code can no doubt be considerably
> simplified, while improving robustness and efficiency at the same time.
> But that goes beyond the scope of this patch.

Well yes ;-) There's funny things going on like accessing a page
after page_cache_release...

    regards   Christian

-- 
THAT'S ALL FOLKS!
