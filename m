Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269802AbRHDFfN>; Sat, 4 Aug 2001 01:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269803AbRHDFex>; Sat, 4 Aug 2001 01:34:53 -0400
Received: from www.wen-online.de ([212.223.88.39]:52229 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S269802AbRHDFer>;
	Sat, 4 Aug 2001 01:34:47 -0400
Date: Sat, 4 Aug 2001 07:34:24 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jeremy Linton <jlinton@interactivesi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Free memory starvation in a zone?
In-Reply-To: <Pine.LNX.4.21.0108031923390.8951-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108040724320.873-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Marcelo Tosatti wrote:

> On Fri, 3 Aug 2001, Jeremy Linton wrote:
>
> > In kreclaimd() there is a nice loop that looks like
> >
> >  for(i = 0; i < MAX_NR_ZONES; i++) {
> >     zone_t *zone = pgdat->node_zones + i;
> >     if (!zone->size)
> >         continue;
> >
> >     while (zone->free_pages < zone->pages_low) {
> >         struct page * page;
> >         page = reclaim_page(zone);
> >         if (!page)
> >             break;
> >         __free_page(page);
> >     }
> > }
> >
> > I was playing around with the page age algorithm when i noticed that it
> > appears that the machine will get into a state where the inner loop _NEVER_
> > exits the current zone because applications running in that zone are eating
> > the memory as fast as it is being freed up.
>
> Normal allocations are going to block giving a chance for kreclaimd to run
> (and remember, the loop and the freeing routines are really fast).
>
> Are you sure you're seeing kreclaimd looping too much here ?
>
> I've never seen that, and if I did I would get really really
> concerned: we rely on kreclaimd to avoid atomic allocations from failing
> in a fragile way.

Snippet from one of Dirk's logs.

  PID  PPID USER     PRI  SIZE SWAP  RSS SHARE   D STAT %CPU %MEM   TIME COMMA
    3     1 root      20     0    0    0     0   0 RW   58.8  0.0   2:41 kswapd
 1494  1421 novatest  15 2009M 640M 1.3G 51476  0M R N  40.8 34.5   6:26 ceqsim
 1751  1747 root      14  1048    4 1044   824  55 R    28.0  0.0   0:02 top
    4     1 root      14     0    0    0     0   0 SW   27.1  0.0   1:06 krecla

	-Mike

