Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272582AbRIPRXn>; Sun, 16 Sep 2001 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272586AbRIPRXe>; Sun, 16 Sep 2001 13:23:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35450 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272582AbRIPRXV>; Sun, 16 Sep 2001 13:23:21 -0400
Date: Sun, 16 Sep 2001 19:23:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010916192316.A13248@athlon.random>
In-Reply-To: <20010910210607.C715@athlon.random> <Pine.LNX.4.33L.0109161359040.9536-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109161359040.9536-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, Sep 16, 2001 at 02:00:10PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 02:00:10PM -0300, Rik van Riel wrote:
> On Mon, 10 Sep 2001, Andrea Arcangeli wrote:
> 
> > > My problem with this appropech is just that we use kernel threads for
> > > more and more stuff - always creating new ones.  I think at some point
> > > they will sum up badly.
> >
> > They almost only costs memory. I also don't like unnecessary kernel
> > threads but I can see usefulness for this one, OTOH as you said the
> > latency of the wait_for_rcu isn't very critical but usually I prefer to
> > save cycles with memory where I can and where it's even cleaner to do so.
> 
> I can't quite remember if it was Linus or Larry who said:
> 
> "Threads are for people who don't understand state machines"
> 
> 
> If you cannot make your code clean without adding another
> thread, it's probably a bad sign ;)

Ask yourself why libaio in glibc uses threads. When there's no async-io
hook you have no choice. Adding the hook is an advantage if you're going
to use it during production, much better than
rescheduling/creating/destroying various threads during production, but
if you only need to register the hook once per day you'd waste time all
the production time checking if somebody is registered in the hook.

So while the "Threads are for people who don't understand state
machines" argument works for the userspace fileservers, it really
doesn't apply to the rcu slow path where we don't want to hurt the
schedule fast path with an hook.

However the issue with keventd and the fact we can get away with a
single per-cpu counter increase in the scheduler fast path made us to
think it's cleaner to just spend such cycle for each schedule rather
than having yet another 8k per cpu wasted and longer taskslists (a
local cpu increase is cheaper than a conditional jump).

Andrea
