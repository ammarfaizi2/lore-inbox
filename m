Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRCWLUl>; Fri, 23 Mar 2001 06:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCWLUK>; Fri, 23 Mar 2001 06:20:10 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39944 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130531AbRCWLUE>; Fri, 23 Mar 2001 06:20:04 -0500
Date: Fri, 23 Mar 2001 06:35:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.3-pre6/mm/vmalloc.c could return with
 init_mm.page_table_lock held
In-Reply-To: <20010323023149.A250@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0103230634320.5947-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Adam J. Richter wrote:

> 	[Sorry for posting three messages to linux-kernel about this.
> Each time I was pretty sure I was done for the night.  Anyhow, I
> hope this proposed patch makes up for it.]
> 
> 	In linux-2.4.3-pre6, a call to vmalloc can result in a call to
> pte_alloc without the appropriate page_table_lock being held.  Here is
> the call graph, from my post of about half an hour ago:
> 
>         vmalloc
>         __vmalloc
>         vmalloc_area_pages
>         alloc_area_pmd
>         pte_alloc ...which assumes (here incorrectly) that
>                 mm->page_table_lock is held, and sometimes releases
>                 and reacquires mm->page_table_lock.
> 
> 	Not only does pte_alloc expect mm->page_table_lock 
> to be held when it is called, but it also sometimes releases and
> reacquires it.  vmalloc did not release this lock either, of course.
> So, the next attempt to acquire the same mm->page_table_lock spin lock
> hangs.
> 
> 	The symptom that I had noticed was the agpgart.o module hanging
> at module initialization, but it is a much more general problem, and
> could explain all sorts of hangs in 2.4.3-pre6.
> 
> 	Anyhow, with this patch, agpgart.o loads just fine and the
> kernel seems to have suffered no negative side effects.  I am
> not confident in exactly where I chose to put the spin_lock and
> spin_unlock calls, so I would recommend a careful examination of
> this patch before integrating.

There is no need to hold mm->page_table_lock for vmalloced memory.

I guess a better solution is to make the vmalloc codepath use
"pte_alloc_vmalloc" (or something like that) which would be a
spinlock-free version of pte_alloc (like the old one).

