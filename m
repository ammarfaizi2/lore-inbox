Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRLQL6V>; Mon, 17 Dec 2001 06:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285098AbRLQL6M>; Mon, 17 Dec 2001 06:58:12 -0500
Received: from [195.157.147.30] ([195.157.147.30]:64011 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S278428AbRLQL6I>; Mon, 17 Dec 2001 06:58:08 -0500
Date: Mon, 17 Dec 2001 11:53:44 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Chris Wright <chris@wirex.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
Message-ID: <20011217115344.C14112@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	Chris Wright <chris@wirex.com>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
In-Reply-To: <UTC200112141734.RAA20953.aeb@cwi.nl> <Pine.LNX.4.33.0112141224200.2957-100000@penguin.transmeta.com> <20011217013445.A30669@figure1.int.wirex.com> <01121712412100.02022@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01121712412100.02022@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Dec 17, 2001 at 12:41:21PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 12:41:21PM -0200, vda wrote:
> On Monday 17 December 2001 07:34, Chris Wright wrote:
> > * Linus Torvalds (torvalds@transmeta.com) wrote:
> > > On Fri, 14 Dec 2001 Andries.Brouwer@cwi.nl wrote:
> > > > The new POSIX 1003.1-2001 is explicit about what kill(-1,sig)
> > > > is supposed to do. Maybe we should follow it.
> > >
> > > Well, we should definitely not do it in 2.4.x, at least not until proven
> > > that no real applications break.
> > >
> > > But I applied it to 2.5.x, let's see who (if anybody) hollers.
> >
> > I had to back this change out of 2.5.1 in order to get a sane shutdown.
> > killall5 -15 is commiting suicide ;-(
> 
> Hmm. Looking at killall5 source I see
> 
> kill(-1, STOP);
> for(each proc with p.sid!=my_sid) kill(proc, sig);
> kill(-1, CONT);
> 
> I guess STOP will stop killall5 too? Not good indeed.
> 
> We have two choices: either back it out or find a sane way to implement 
> killall5 with new kill -1 behaviour.

Couldn't it just do:

sigset_t new;
sigset_t savemask;
sigfillset (&new);
sigprocmask (SIG_BLOCK, &new, &savemask);

kill(-1, STOP);
for(each proc with p.sid!=my_sid) kill(proc, sig);
kill(-1, CONT);

sigprocmask (SIG_SETMASK, &savemask, (sigset_t *) 0);

... in other words, block signals, do the killing, then unblock?

Sean
