Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSANUgm>; Mon, 14 Jan 2002 15:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSANUfV>; Mon, 14 Jan 2002 15:35:21 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1555 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289033AbSANUdv>; Mon, 14 Jan 2002 15:33:51 -0500
Message-ID: <3C433F34.9D31B6BE@zip.com.au>
Date: Mon, 14 Jan 2002 12:27:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: J Sloan <jjs@pobox.com>, Ed Sweetman <ed.sweetman@wmich.edu>,
        yodaiken@fsmlabs.com, jogi@planetzork.ping.de,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> <3C40A6BB.1090100@pobox.com>,
		<3C40A6BB.1090100@pobox.com>; from jjs@pobox.com on Sat, Jan 12, 2002 at 01:12:27PM -0800 <20020114123425.B10227@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > --- linux-2.4.18-pre3/fs/buffer.c       Fri Dec 21 11:19:14 2001
> > +++ linux-akpm/fs/buffer.c      Sat Jan 12 12:22:29 2002
> > @@ -249,12 +249,19 @@ static int wait_for_buffers(kdev_t dev,
> >         struct buffer_head * next;
> >         int nr;
> >
> > -       next = lru_list[index];
> >         nr = nr_buffers_type[index];
> > +repeat:
> > +       next = lru_list[index];
> >         while (next && --nr >= 0) {
> >                 struct buffer_head *bh = next;
> >                 next = bh->b_next_free;
> >
> > +               if (dev == NODEV && current->need_resched) {
> > +                       spin_unlock(&lru_list_lock);
> > +                       conditional_schedule();
> > +                       spin_lock(&lru_list_lock);
> > +                       goto repeat;
> > +               }
> >                 if (!buffer_locke
> > d(bh)) {
> 
> this introduces possibility of looping indefinitely, this is why I
> rejected it while I merged the mini-ll other points into -aa, if you
> want to do anything like that at the very least you should roll the head
> of the list as well or something like that.

I ended up deciding that the `NODEV' check here avoids livelocks.
Unless, of course, the scheduling pressure is so high that we can't
even run a few statements.  I which case the interrupt load will be so 
high that the machine stops anyway.  Possibly it needs to check `refile'
as well.

A technique I frequently use in the full-ll patch is to only reschedule
after we've executed the loop (say) 16 times before dropping out.  This
assures that forward progress is made.  There's a test mode in the full
ll patch - in this mode, it *always* assumes that need_resched is true.
If the patch runs OK in this mode without livelocking, we know that it
can't livelock.

Anyway, I'll revisit this.  It is a "must fix".  wait_for_buffers() is
possibly the worst cause of latency in the kernel.  The usual scenario
is where kupdate has written 10,000 buffers and then sleeps.  Next time
it wakes, it has 10,000 clean, unlocked buffers to move from BUF_LOCKED
onto BUF_CLEAN.  It does this with lru_list_lock held.

-
