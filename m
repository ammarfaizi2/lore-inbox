Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHDFnP>; Sat, 4 Aug 2001 01:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269805AbRHDFnE>; Sat, 4 Aug 2001 01:43:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37394 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269804AbRHDFmu>; Sat, 4 Aug 2001 01:42:50 -0400
Date: Sat, 4 Aug 2001 01:13:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Jeremy Linton <jlinton@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: Free memory starvation in a zone?
In-Reply-To: <Pine.LNX.4.33.0108040724320.873-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0108040109560.9719-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Mike Galbraith wrote:

> On Fri, 3 Aug 2001, Marcelo Tosatti wrote:
> 
> > On Fri, 3 Aug 2001, Jeremy Linton wrote:
> >
> > > In kreclaimd() there is a nice loop that looks like
> > >
> > >  for(i = 0; i < MAX_NR_ZONES; i++) {
> > >     zone_t *zone = pgdat->node_zones + i;
> > >     if (!zone->size)
> > >         continue;
> > >
> > >     while (zone->free_pages < zone->pages_low) {
> > >         struct page * page;
> > >         page = reclaim_page(zone);
> > >         if (!page)
> > >             break;
> > >         __free_page(page);
> > >     }
> > > }
> > >
> > > I was playing around with the page age algorithm when i noticed that it
> > > appears that the machine will get into a state where the inner loop _NEVER_
> > > exits the current zone because applications running in that zone are eating
> > > the memory as fast as it is being freed up.
> >
> > Normal allocations are going to block giving a chance for kreclaimd to run
> > (and remember, the loop and the freeing routines are really fast).
> >
> > Are you sure you're seeing kreclaimd looping too much here ?
> >
> > I've never seen that, and if I did I would get really really
> > concerned: we rely on kreclaimd to avoid atomic allocations from failing
> > in a fragile way.
> 
> Snippet from one of Dirk's logs.
> 
>   PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
>     3     1 root      20     0    0    0     0   0 RW   58.8  0.0   2:41 kswapd
>  1494  1421 novatest  15 2009M 640M 1.3G 51476  0M R N  40.8 34.5   6:26 ceqsim
>  1751  1747 root      14  1048    4 1044   824  55 R    28.0  0.0   0:02 top
>     4     1 root      14     0    0    0     0   0 SW   27.1  0.0   1:06 krecla

The problem is if we have kreclaimd not able to satisfy all zones needs. 

CPU usage does not mean zone freemem starvation.


