Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWJEQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWJEQhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWJEQhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:37:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64008 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932163AbWJEQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:37:23 -0400
Date: Thu, 5 Oct 2006 18:37:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
Message-ID: <20061005163721.GJ16812@stusta.de>
References: <20061003001115.e898b8cb.akpm@osdl.org> <20061005083754.GA1060@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005083754.GA1060@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 10:37:54AM +0200, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > - Added Jeff's make-bogus-warnings-go-away tree to the -mm lineup, as
> >   git-gccbug.patch
> 
> Jeff: very nice! (I did this myself on a much smaller scale for the -rt 
> patch, because it's just so lethal if some serious warning gets lost in 
> the myriads of 'possible use of uninitialized' messages.)
> 
> A small suggestion: to give GCC folks a chance to actually fix this, 
> could we actively annotate these places instead of working them around?
> 
> I.e., instead of:
> 
>         long cursor = 0;
>         int error = 0;
> -       void *new_mc;
> +       void *new_mc = NULL;
>         int cpu;
>         cpumask_t old;
> 
> couldnt we do:
> 
> 	void *new_mc __GCC_WARN_BUG;
> 
> and then do something like this in gcc.h:
> 
>  #ifdef CONFIG_ELIMINATE_BOGUS_GCC_WARNINGS
>  # define __GCC_WARN_BUG = 0
>  #else
>  # define __GCC_WARN_BUG
>  #endif
> 
> this both gives an in-source incentive for GCC folks to get rid of these 
> bogus warnings (or remain shamed for eternity),

Not all of the false positives are gcc bugs.

There are cases where it's technically impossible for gcc to figure out 
that a variable is always initialized.

> and gives us the ability 
> to control the presence of these workarounds (and the eventual ability 
> to eliminate them in the future).
> 
> this would also mean we could merge your tree upstream without worrying 
> about hiding gcc bugs.

What we'd need would be some -Wno-may-be-used-uninitialized gcc option 
that turns off the "may be may be used uninitialized" warnings but not 
the "is used uninitialized" warnings.

This would:
- give us a way to silence these warnings
- allow people to see the warnings if they want to
- not increase the maintenance overhead

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

