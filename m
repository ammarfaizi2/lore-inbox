Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268611AbRG0Oti>; Fri, 27 Jul 2001 10:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268776AbRG0Ot3>; Fri, 27 Jul 2001 10:49:29 -0400
Received: from web13609.mail.yahoo.com ([216.136.174.9]:51716 "HELO
	web13609.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268611AbRG0OtP>; Fri, 27 Jul 2001 10:49:15 -0400
Message-ID: <20010727144921.607.qmail@web13609.mail.yahoo.com>
Date: Fri, 27 Jul 2001 07:49:21 -0700 (PDT)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: Addendum to Daniel Phillips [RFC] use-once patch
To: Daniel Phillips <phillips@bonn-fries.net>,
        Balbir Singh <balbir.singh@wipro.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: balbirs@indiatimes.com, balbir_soni@yahoo.com
In-Reply-To: <0107271638180F.00285@starship>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--- Daniel Phillips <phillips@bonn-fries.net> wrote:
> On Friday 27 July 2001 11:57, Balbir Singh wrote:
> > Addendum to Daniel Phillips [RFC] use-once patch
> > ------------------------------------------------
> >
> > A while ago, Daniel Phillips, posted his use use
> once patch. I used
> > it and found it useful. I have been thinking of
> something similar.
> > Let me describe what I have been thinking, this is
> in-line with
> > page-aging and the working set model.
> >
> > As per the working set model, we use locality of
> reference, to keep
> > constantly used pages in memory. It is for sure
> that after a period
> > of time, these pages that were being used
> constantly, would no longer
> > be required (since we would be done with that
> piece of code or data).
> > We would like to evict these pages since soon.
> >
> > To illustrate :-
> >
> > I have used a PAGE_MAX_USE principle (my own from
> what I know), which
> > states that most of the pages (**except shared
> pages**), would be
> > used for a maximum of PAGE_MAX_USE (some constant
> > 0). We look at
> > pages that are very frequently used and then after
> some number of
> > times (PAGE_MAX_USE) they have been used, we
> "victimize" them. This
> > may be wrong, since the page may be required for
> more than the number
> > of times (PAGE_MAX_USE), we think it is required.
> In that case, it
> > will be paged back in (when required) and reused
> again for
> > PAGE_MAX_USE times before being victimized again.
> >
> > Below is a small patch for proof of concept
> > -------------------------------------------
> >
> >
> > --- vmscan.c.org        Fri Jul 27 14:27:06 2001
> > +++ vmscan.c    Fri Jul 27 14:32:38 2001
> > @@ -43,10 +43,20 @@
> >
> >         /* Don't look at this pte if it's been
> accessed recently. */
> >         if (ptep_test_and_clear_young(page_table))
> {
> > -               page->age += PAGE_AGE_ADV;
> > -               if (page->age > PAGE_AGE_MAX)
> > -                       page->age = PAGE_AGE_MAX;
> > -               return;
> > +
> > +               /*
> > +                * If the page has been at
> PAGE_AGE_MAX for a while,
> > may be
> > +                * it is the best candidate for
> swapping.
> > +                */
> > +               if ((page->age > PAGE_AGE_MAX) &&
> (page_count(page)
> > <= 1)) {
> > +                       page->age =
> PAGE_AGE_START;
> > +               } else {
> > +                       page->age += PAGE_AGE_ADV;
> > +                       if (page->age >
> PAGE_AGE_MAX) {
> > +                               page->age =
> PAGE_AGE_MAX;
> > +                       }
> > +                       return;
> > +               }
> >         }
> 
> I noticed your good benchmark results below, but I'm
> having some 
> trouble understanding how this works.  How can
> page->age ever become 
> greater than PAGE_AGE_MAX?  Also, I don't see any
> reference to 
> PAGE_MAX_USE.  Comments?

PAGE_MAX_USE is just a constant which I will introduce
if I keep track of the number of times the page has
been used (this is just conceptual for now). You are
right page->age can never be greater than PAGE_AGE_MAX
(its a typo, the code should check for page->age ==
PAGE_AGE_MAX).




> 
> > System Configuration
> > =====================
> >
> > Single processor celeron system with 128 MB of
> RAM, running
> > Linux-2.4.7pre6 with Daniel's patch applied
> (running X windows at the
> > time of compilation, with GNOME).
> >
> > time for creating clean bzImage *before* patch
> > ==============================================
> >
> > real    28m40.492s
> > user    22m43.450s
> > sys     2m44.490s
> >
> >
> > time for creating clean bzImage *after* patch
> > =============================================
> >
> > real    26m37.011s
> > user    21m56.350s
> > sys     2m28.060s
> 
> Bash seems to have a built-in "time" command that
> isn't nearly as 
> useful as the GNU version, which you'd find in
> /usr/bin/time.  The GNU 
> version tells us, among other things, how many swaps
> occured.  Also, 
> check the list for Marcelo's mm statistics patch. 
> I'm not sure what 
> the integration status is on that.
> 

I will use this and get back to you, thanks for
letting me know this. I can probably ask you more
details offline.


> > The system, seemed to respond faster (or I might
> be feeling so).
> >
> > I am also planning to run some standard benchmark
> (I need to figure
> > out, which one, or you could guide me). If you
> like the idea, I will
> > post the benchmark results also to you (soon!).
> This patch is a
> > simple implementation of the idea, I could come
> out with a more
> > comprehensive solution if required.
> 
> I imagine your system is swapping during your kernel
> build due to 
> memory pressure created by gnome and X.  If you show
> the swapping 
> statistics from GNU time maybe we can suggest a more
> predictable way of 
> creating a similar load.  I always run my benchmark
> tests in text mode, 
> by the way, just to try to eliminate some variables
> and get more 
> consistent timing results.
> 
> Did you repeat your timing measurements several
> times, and did you 
> start each test with a clean reboot?
> 

Yes I repeated the tests, but I guess and know there
is more to do.

Thanks for all the advice, will follow this up and
respond with more details

    Balbir


> --
> Daniel


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
