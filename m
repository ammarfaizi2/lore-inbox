Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSDQRdP>; Wed, 17 Apr 2002 13:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSDQRdP>; Wed, 17 Apr 2002 13:33:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:50988 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311025AbSDQRdM>; Wed, 17 Apr 2002 13:33:12 -0400
Date: Wed, 17 Apr 2002 19:32:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Message-ID: <20020417193246.E14322@dualathlon.random>
In-Reply-To: <rxxadshj1rh.fsf@synapse.t30.physik.tu-muenchen.de> <20020416165358.E29747@dualathlon.random> <rxxk7r6tkh6.fsf@synapse.t30.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 05:26:13PM +0200, Moritz Franosch wrote:
> 
> 
> > > The problem is that writing to a DVD-RAM, ZIP or MO device almost
> > > totally blocks reading from a _different_ device. Here is some data.
> > > 
> > > nr bench read       write      2.4.18  2.4.19-rc5  expected factor
> > > 1  dd    30GB HDD   DVD-RAM    278     490         60       8.2
> > > 2  dd    120GB HDD  DVD-RAM    197     438         32       14
> > > 3  dd    30GB HDD   ZIP        158     239         60       4.0
> > > 4  dd    120GB HDD  ZIP        142     249         32       7.8
> > > 5  dd    30GB HDD   120GB HDD   87      89         60       1.5
> > > 6  dd    120GB HDD  30GB HDD    66      69         32       2.2
> > > 7  cp    30GB HDD   120GB HDD   97      77         60       1.3
> > > 8  cp    120GB HDD  30GB HDD    78      65         50       1.3
> 
> Should be -pre5, sorry.

Never mind, that was clear :).

> 
> > The reason hd is faster is because new algorithm is much better than the
> > previous mainline code. Now the reason the DVDRAM hangs the machine
> > more, that's probably because more ram can be marked dirty with those
> > new changes (beneficial for some workload, but it stalls much more the
> > fast hd, if there's one very slow blkdev in the system). You can try
> > decrasing the percent of vm dirty in the system with:
> > 
> > 	echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush
> 
> With the bdflush-parameters above, I get
> 
> nr bench read       write      2.4.19-pre5  expected factor
> 9  dd    30GB HDD   DVD-RAM    208/0/6      60       3.5
> 10 dd    120GB HDD  DVD-RAM    39/0/6       32       1.2
> 11 dd    30GB HDD   ZIP        66/0/10      60       1.1
> 12 dd    120GB HDD  ZIP        85/0/7       32       2.7
> 
> Numbers in the column 2.4.19-pre5 are total time / user time / system
> time in seconds.
> 
> Performance is much better with the new parameters. Also, with the new
> parameters, the system can read from HDD almost steadily while writing
> to DVD. This should much increase responsiveness.

Good. As said that's a mere workaround at the moment, something generic
and possibly autotuning is a bit more complex, and still a research
item (I see it more as a 2.5 thing, because the slow reads during DVD
etc.. isn't really a regression).

> In cases 9 and 12 where performance is bad, both tested drives are on
> the same IDE controller. Should that matter?

yes very much so, I should had asked you about it, I was assuming it
wasn't bound by hardware limitations. IDE isn't able to submit commands
in parallel to both hosts on the same IDE controller, so you will get
much slower performance doing I/O on the master and slave of the same
ide channel. So if your "expected" doesn't count the IDe channel
collisions then it sounds good.

> > Right fix is different but not suitable for 2.4.
> 
> I'm looking forward to the definitive solution.

Right you are.

> Thank you very much,

You're welcome.

Andrea
