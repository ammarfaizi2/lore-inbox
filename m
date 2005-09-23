Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVIWCgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVIWCgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 22:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVIWCgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 22:36:12 -0400
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:41349 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751226AbVIWCgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 22:36:12 -0400
Date: Thu, 22 Sep 2005 19:36:11 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: Fawad Lateef <fawadlateef@gmail.com>, Ustyugov Roman <dr_unique@ymg.ru>,
       liyu <liyu@ccoss.com.cn>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
In-Reply-To: <20050921093007.GA11144@x30.random>
Message-ID: <Pine.LNX.4.58.0509221931230.27735@shell2.speakeasy.net>
References: <43311071.8070706@ccoss.com.cn> <200509211200.06274.dr_unique@ymg.ru>
 <1e62d13705092102012f0a5c9c@mail.gmail.com> <20050921093007.GA11144@x30.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Andrea Arcangeli wrote:

> On Wed, Sep 21, 2005 at 02:01:11PM +0500, Fawad Lateef wrote:
> > On 9/21/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
> > > > Hi, All.
> > > >
> > > >     I found there are use double operator ! continuously sometimes in
> > > > kernel.
> > > > e.g:
> > > >
> > > >     static inline int is_page_cache_freeable(struct page *page)
> > > >     {
> > > >         return page_count(page) - !!PagePrivate(page) == 2;
> > > >     }
> > > >
> > > >     Who would like tell me why write like above?
> > >
> > > For example,
> > >
> > >         int test = 5;
> > >         !test will be  0,  !!test will be 1.
> > >
> > > This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.
> > >
> > > Am I right?
> >
> > Yes, but what abt the above case/example ??? PagePrivate is defined as
> > test_bit and test_bit will return 0 or 1 only ...... So y there is (
> > !! )  ??
>
> Note that gcc should optimize it away as long as the asm*/bitops is
> doing "return something != 0" like most archs do.
>
> Most of the time test_bit retval is checked against zero only, here it's
> one of the few cases where it's required to be 1 or 0. If you audit all
> archs then you can as well remove the !! from above.

After scanning through some of the archs, it seems that the !! is really
necessary in that case. Here's why:

PagePrivate() is just a macro wrapper around test_bit(). On i386, in
include/asm-i386/bitops.h, test_bit() may end up calling
variable_test_bit(). This inline function uses two assembly instructions
to compute the desired result, which end up returning '-1', not '1', in
the case that the bit is set.

(Hopefully this mail gets archived away and saves someone else the work
of digging through the archs.)

> Thanks!

-Vadim Lobanov
