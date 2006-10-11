Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWJKJf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWJKJf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWJKJf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:35:26 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:64458 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1750900AbWJKJfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:35:25 -0400
X-Originating-Ip: 72.57.81.197
Date: Wed, 11 Oct 2006 05:34:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on potential cleanup of semaphores?
In-Reply-To: <1160534524.13097.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610110521160.7306@localhost.localdomain>
References: <Pine.LNX.4.64.0610101025080.8855@localhost.localdomain>
 <1160534524.13097.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Steven Rostedt wrote:

>
> On Tue, 2006-10-10 at 12:00 -0400, Robert P. J. Day wrote:

> > 1) can all instances of sema_init() in the header files be simplified
> > based on the comment you can see in some of those header files?
> >
> > ========================
> > static inline void sema_init (struct semaphore *sem, int val)
> > {
> > /*
> >  *      *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
> >  *
> >  * i'd rather use the more flexible initialization above, but sadly
> >  * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
> >  */
> >         atomic_set(&sem->count, val);
> >         sem->sleepers = 0;
> >         init_waitqueue_head(&sem->wait);
> > }
> > ========================
> >
> >   one would think there's little value in retaining code that
> > accommodates something as old as GCC 2.7.2.3, but i'm not the expert
> > here.
>
> Well, I believe it's official, that we don't support GCC 2.7.2.3 anymore
> anyway.


ok, so a patch to simplify *all* of the above implementations of
sema_init() to a single call to __SEMAPHORE_INITIALIZER() would not be
out of line.  i'll resubmit my earlier one, making sure it's based on
the latest "git pull".


> >   and stepping back and looking at the bigger picture, it seems that
> > the semaphore.h files across all architectures are *almost* identical,
> > with a small number of differences, such as:
>
> All those asm statements :-)


well, ok, i worded that badly.  let me try again.  at least the
semaphore *interfaces* across all architectures seem to be almost
identical, with the exception, of course, of the inline "asm"
routines.  but (and i know this idea is not going *anywhere*) when a
routine in a header file is defined as inline and consists of a dozen
assembler statements, wouldn't it make more sense to (dons asbestos
suit here) have those routines be part of the *source* file and not
the header file?

i'm probably making more of this than it's worth but, as i was digging
around in the semaphore implementations, it struck me that there was a
lot of unnecessary duplication across the numerous semaphore.h files.
is there no reasonable way to get rid of at least *some* of that?


> > p.s.  trying to condense all of the separate semaphore.h files
> > into a single, configurable one would also solve the problem of
> > incorrect documentation in some of them that is clearly the result
> > of cut-and-paste.  but i'm interested in what the experts have to
> > say.
>
> But the meat in those files are in the down and up functions. Which
> are all pretty much drastically different.  All you would accomplish
> is some standard initialization of the structure and sema_init.


so perhaps the up and down functions represent the stuff that can be
kept in arch-specific files, while the rest of semaphore.h is
condensed to a single, cross-arch file.  it still seems like there's
lots of redundancy that can be eliminated here with very little
effort.

in defense of minimalism,
rday
