Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSINNhU>; Sat, 14 Sep 2002 09:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSINNhU>; Sat, 14 Sep 2002 09:37:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:11511 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316768AbSINNhS>;
	Sat, 14 Sep 2002 09:37:18 -0400
Message-ID: <3D83405A.42B44825@digeo.com>
Date: Sat, 14 Sep 2002 06:57:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Rik van Riel <riel@conectiva.com.br>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
References: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com> <3D825E43.FDB41C7F@digeo.com> <20020914100549.GB816@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2002 13:42:03.0598 (UTC) FILETIME=[824C46E0:01C25BF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > > Allocating memory is pain because I have to free it afterwards. Yep I
> > > > have such code, but it is ugly. try_to_free_pages() really seems like
> > > > cleaner solution to me... if you only tell me how to fix it :-).
> > >
> > > "Fixing" the VM just so it behaves the way swsuspend wants is
> > > out. If swsuspend relies on all other subsystems playing nicely,
> > > I think it should be removed from the kernel.
> > >
> >
> > Yup.  Martin Bligh is cooking up a multi-page allocation API, so when that's
> > in place, swsusp need only do:
> >
> >       LIST_HEAD(foo);
> >       alloc_many_pages(&foo, nr_pages, __GFP_HIGHMEM|__GFP_WAIT);
> >       free_many_pages(&foo);
> >
> > So I suggest you do something local for the while, plan to use that later.
> >
> > (Actually, the implementation would probably have a heart attack if you
> > asked for 100,000 pages so you may need to sit in a loop there;
> > we'll see).
> 
> If nr_pages is > than number of pages really freable will it return
> NULL or stall the calling process forever?

Good point.  In current Linus tree, it could be oom-killed.  Later,
lack of __GFP_FS will prevent that.  But it could loop forever.
I guess you'll need to drop the __GFP_WAIT and yield yourself, let
kswapd free the next batch of pages.

We need to do something more robust than this.  I'll cook something up.
