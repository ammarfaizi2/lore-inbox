Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289510AbSAOMUl>; Tue, 15 Jan 2002 07:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSAOMUW>; Tue, 15 Jan 2002 07:20:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:63605 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289510AbSAOMUO>; Tue, 15 Jan 2002 07:20:14 -0500
Date: Tue, 15 Jan 2002 13:20:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020115132026.F22791@athlon.random>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk> <20020112133122.I1482@inspiron.school.suse.de> <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk>; from jlbec@evilplan.org on Tue, Jan 15, 2002 at 03:21:26AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 03:21:26AM +0000, Joel Becker wrote:
> On Sat, Jan 12, 2002 at 01:31:22PM +0100, Andrea Arcangeli wrote:
> > On Wed, Jan 09, 2002 at 07:56:07PM +0000, Joel Becker wrote:
> > > min(I/O alignment, s_blocksize) is used as the effective
> > > blocksize.  eg:
> > > 
> > > I/O alignment	s_blocksize	final blocksize
> > > 8192		4096		4096
> > > 4096		4096		4096
> > > 512		4096		512
> > 
> > this falls in the same risky category of the vary-I/O patch from Badari
> > (check the discussion on l-k) for rawio, so to make it safe it also will
> 
> 	How so?  All I/O is at the computed blocksize.  In every
> request, the size of each I/O in the kiovec is the same.  The

in the kiovec yes, but in the same request queue there will be also the
concurrent requests from the filesystem, and they will have different
b_size, see Jens's mail about different b_size merged in the same
request.

actually we could also forbid merging at the ll_rw_block layer if b_size
is not equal, maybe that's the simpler solution to that problem after
all, merging between kiovec I/O and buffered I/O probably doesn't
matter.

> computation is done upon entrance to generic_file_direct_IO, and it is
> kept that way.  You don't have bh[0]->b_size = 512; bh[1]->b_size =
> 4096;
> 	Hmm, maybe you mean things like that rumoured 3-ware issue.  I
> dunno.  I do know that this code seems to work just fine with ide,
> aha7xxx, and the qlogic driver.  Certain software really wants to use
> O_DIRECT, and they align I/O on 512byte boundaries.  So any scheme that
> fails this when it doesn't have to is a problem.
> 
> > aligned I/O, but still large I/O) So I suggest you to check Badari's
> > stuff and the thread on l-k and to make a new patch incremental with his
> 
> 	I've added myself to that thread as well.
> 
> Joel
> 
> -- 
> 
> "Vote early and vote often." 
>         - Al Capone
> 
> 			http://www.jlbec.org/
> 			jlbec@evilplan.org


Andrea
