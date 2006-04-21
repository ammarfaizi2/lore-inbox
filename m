Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWDUVit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWDUVit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWDUVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:38:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16653 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964800AbWDUVis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:38:48 -0400
Date: Fri, 21 Apr 2006 23:38:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kfree(NULL)
Message-ID: <20060421213846.GK19754@stusta.de>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com> <Pine.LNX.4.61.0604211643350.31515@yvahk01.tjqt.qr> <20060421192217.GI19754@stusta.de> <200604211330.30657.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604211330.30657.vernux@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:30:30PM -0700, Vernon Mauery wrote:
> On Friday 21 April 2006 12:22, you wrote:
> > On Fri, Apr 21, 2006 at 05:07:45PM +0200, Jan Engelhardt wrote:
> > > >> Maybe kfree should really be a wrapper around __kfree which does the
> > > >> real work.  Then kfree could be a inlined function or a #define that
> > > >> does the NULL pointer check.
> > > >
> > > >NULL pointer check in kfree saves lot of small code fragments in
> > > > callers. It is one of many reasons why kfree does it.
> > > >Making kfree inline wrapper eliminates this save.
> > >
> > > How about
> > >
> > > slab.h:
> > > #ifndef CONFIG_OPTIMIZING_FOR_SIZE
> > > static inline void kfree(const void *p) {
> > >     if(p != NULL)
> > >         __kfree(p);
> > > }
> > > #else
> > > extern void kfree(const void *);
> > > #endif
> > >
> > > slab.c:
> > > #ifdef CONFIG_OPTIMIZING_FOR_SIZE
> > > void kfree(const void *p) {
> > >     if(p != NUILL)
> > >         _kfree(p);
> > > }
> > > #endif
> > >
> > > That way, you get your time saving with -O2 and your space saving with
> > > -Os.
> >
> > What makes you confident that the static inline version gives a time
> > saving?
> 
> A static inline wrapper would mean that it wouldn't have to make a function 
> call just to check if the pointer is NULL.  A simple NULL check is faster 
> than a function call and then a simple NULL check.  In other words, there 
> would be no pushing and popping the stack.  In almost all cases, replacing an 
> inline function with a non-inline function means a trade-off between speed 
> and size.

It's not that simple - inline's make the code bigger causing more cache 
misses and therefore also having a negative impact on performance.

This is the reason why e.g. the gcc -O3 option usually results in 
_worse_ performance than the -O2 option.

> --Vernon

cu
Adrian

BTW: Don't strip the Cc when replying to linux-kernel.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

