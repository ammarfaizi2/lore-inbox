Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbRIYWs1>; Tue, 25 Sep 2001 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274677AbRIYWsS>; Tue, 25 Sep 2001 18:48:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47631 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274675AbRIYWsF>; Tue, 25 Sep 2001 18:48:05 -0400
Date: Tue, 25 Sep 2001 18:25:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        Jacek =?iso-8859-1?Q?=5Biso-8859-2=5D_Pop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
In-Reply-To: <20010926000922.I8350@athlon.random>
Message-ID: <Pine.LNX.4.21.0109251823550.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Sep 2001, Andrea Arcangeli wrote:

> On Mon, Sep 24, 2001 at 09:38:24AM -0300, Marcelo Tosatti wrote:
> > --- linux.orig/mm/vmscan.c	Mon Sep 24 10:36:40 2001
> > +++ linux/mm/vmscan.c	Mon Sep 24 10:54:01 2001
> > @@ -567,6 +567,9 @@
> >  		if (nr_pages <= 0)
> >  			return 1;
> >  
> > +		if (nr_pages < SWAP_CLUSTER_MAX)
> > +			ret |= 1;
> > +
> 
> too much permissive (vm-tweaks-1 does something similar but not that
> permissive)

Andrea,

Does vm-tweaks-1 fixes the current problem we're seeing? 

Also, we have to make sure _all_ progress accounting is being done
correctly (i/dcache, etc). I'll make sure that happens as soon as the OOM
problem is gone.

> >  		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
> >  	} while (--priority);
> >  
> > --- linux.orig/mm/page_alloc.c	Mon Sep 24 10:36:40 2001
> > +++ linux/mm/page_alloc.c	Mon Sep 24 10:44:12 2001
> > @@ -400,7 +400,7 @@
> >  			if (!z)
> >  				break;
> >  
> > -			if (zone_free_pages(z, order) > z->pages_high) {
> > +			if (zone_free_pages(z, order) > z->pages_min) {
> 
> that breaks oom detection.

Why? 

