Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbREZXWR>; Sat, 26 May 2001 19:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbREZXVr>; Sat, 26 May 2001 19:21:47 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262581AbREZW6z>;
	Sat, 26 May 2001 18:58:55 -0400
Date: Sat, 26 May 2001 18:04:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526180413.E9634@athlon.random>
In-Reply-To: <20010526173051.B9634@athlon.random> <Pine.LNX.4.21.0105261250160.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261250160.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 12:51:38PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 12:51:38PM -0300, Rik van Riel wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > > > -	/* 
> > > > -	 * Set our state for sleeping, then check again for buffer heads.
> > > > -	 * This ensures we won't miss a wake_up from an interrupt.
> > > > -	 */
> > > > -	wait_event(buffer_wait, nr_unused_buffer_heads >= MAX_BUF_PER_PAGE);
> > > > +	current->policy |= SCHED_YIELD;
> > > > +	__set_current_state(TASK_RUNNING);
> > > > +	schedule();
> > > >  	goto try_again;
> > > >  }
> 
> I'm still curious ... is it _really_ needed to busy-spin here?

As said we cannot wait_event, because those reserved bh will be released
only by the VM if there is memory pressure. If we sleep in wait_event
while I/O is in progress on the reserved bh and a big chunk of memory is
released under us, then those reserved bh may never get released and we
will hang in wait_event until there's memory pressure again, so unless
we implement another logic we need to somehow poll there and to try to
allocate again later. We should enter that path very seldom so I'm not
very concerned about the performance during the polling loop.

Andrea
