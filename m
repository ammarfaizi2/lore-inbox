Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWALIwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWALIwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWALIwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:52:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59116 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030328AbWALIwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:52:02 -0500
Date: Thu, 12 Jan 2006 09:51:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, linux-kernel@vger.kernel.org, sct@redhat.com, mingo@elte.hu
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Message-ID: <20060112085147.GB1670@elf.ucw.cz>
References: <200601112126.59796.ak@suse.de> <20060111124617.5e7e1eaa.akpm@osdl.org> <1137012917.2929.78.camel@laptopd505.fenrus.org> <20060111130728.579ab429.akpm@osdl.org> <1137014875.2929.81.camel@laptopd505.fenrus.org> <20060111224013.GA8277@elf.ucw.cz> <9a8748490601111447s25ee4f68vace2077eae05b6ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601111447s25ee4f68vace2077eae05b6ae@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 11-01-06 23:47:53, Jesper Juhl wrote:
> On 1/11/06, Pavel Machek <pavel@suse.cz> wrote:
> > On St 11-01-06 22:27:55, Arjan van de Ven wrote:
> > > > We expect the lock to be held on entry.  Hence we expect mutex_trylock()
> > > > to return zero.
> > >
> > > you are correct, and the x86-64 mutex.h is buggy
> > >
> > > --- linux-2.6.15/include/asm-x86_64/mutex.h.org       2006-01-11 22:25:37.000000000 +0100
> > > +++ linux-2.6.15/include/asm-x86_64/mutex.h   2006-01-11 22:25:43.000000000 +0100
> > > @@ -104,7 +104,7 @@
> > >  static inline int
> > >  __mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> > >  {
> > > -     if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
> > > +     if (likely(atomic_cmpxchg(count, 1, 0) == 1))
> > >               return 1;
> > >       else
> > >               return 0;
> > >
> > > changes the asm to be the correct one for me.
> > > This is odd/evil though..
....
> > +++ b/kernel/sched.c
> > @@ -367,7 +367,7 @@ repeat_lock_task:
> >         local_irq_save(*flags);
> >         rq = task_rq(p);
> >         spin_lock(&rq->lock);
> > -       if (unlikely(rq != task_rq(p))) {
> > +       if unlikely(rq != task_rq(p)) {
> 
> This is confusing to read. Why not keep the parenthesis around
> (unlikely(...)) ?  Yes, it's an extra set of parenthesis that are not
> strictly needed now that you've added them to the likely/unlikely
> macros, but they don't do any harm either and make the code less
> surprising to read...   I know that I at least think *BUG* at once

Read the email from the start, there's very nice example why the extra
()'s are evil in mutex_fast_trylock.

								Pavel
-- 
Thanks, Sharp!
