Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289021AbSAUDmC>; Sun, 20 Jan 2002 22:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSAUDlx>; Sun, 20 Jan 2002 22:41:53 -0500
Received: from dsl-213-023-038-205.arcor-ip.net ([213.23.38.205]:27526 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289021AbSAUDlg>;
	Sun, 20 Jan 2002 22:41:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman),
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Linux 2.4.18pre3-ac1
Date: Mon, 21 Jan 2002 04:46:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Adam Kropelin <akropel1@rochester.rr.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201140409260.32617-100000@imladris.surriel.com> <m1y9j1pf6r.fsf@frodo.biederman.org>
In-Reply-To: <m1y9j1pf6r.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SVPU-0001dp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 08:25 am, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> > On 13 Jan 2002, Eric W. Biederman wrote:
> > > Rik while you are looking at your reverse mapping code, I would like
> > > to call to your attention the at least trippling of times for fork.
> > 
> > Dave McCracken has measured this on his system, it seems to vary
> > from between 10% for bash to 400% for a process with 10 MB of memory.
> 
> O.k. That sounds about like what I was expecting.
>
[...]
> > > Just my 2 cents so we don't forget the caveats of the reverse map
> > > approach.
> > 
> > The main way we can speed up fork easily is by not copying the
> > page tables at all at fork time but filling them in later at page
> > fault time. While this might look like it's just moving the overhead
> > from one place to another, but for the typical fork()+exec() case it
> > means (1) we don't copy the page tables at fork time (2) we don't
> > need to free them at exec time (3) after the exec, the parent can
> > just take back the complete page tables without having to take COW
> > faults on all its pages.
> 
> Which is definitely a win.  Perhaps we could even have paged page tables
> at that point.

Yes, it's possible but it's of secondary importance.  The first, essential
goal has to be to eliminate the rmap fork overhead so that rmap becomes
a 'never worse and often better' solution.  It's for this reason that I
developed an algorithm a few weeks ago to do lazy page table instantiation
efficiently, which is what Rik is referring to.  I'm not quite ready to
post details yet, since I haven't tried it, and frankly, I'm learning about
Unix memory management as I go, so there may well be a gaping hole I've
missed.  Hopefully we'll know in a few days, and I'll post the full
writeup.

The way I see it, the purpose of lazy page table instantiation is to
overcome objections to the reverse pte mapping vm technique that have
been expressed in the past, namely the slowdown in dup_mmap inside fork.
I.e., if rmap slows down fork then Linus and Davem are going to
veto it, as they've done in the past, because they feel that the
as-yet-unproven advantages of physically-based vm scanning doesn't
outweigh the easily measurable fork overhead.  Personally, I think
that's debatable, but by eliminating the overhead we eliminate the
objection, and as far as I know, it's the only serious objection.

--
Daniel
