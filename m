Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293740AbSCMMDN>; Wed, 13 Mar 2002 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310140AbSCMMDD>; Wed, 13 Mar 2002 07:03:03 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:19333 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S293740AbSCMMC5>; Wed, 13 Mar 2002 07:02:57 -0500
Date: Wed, 13 Mar 2002 12:05:09 +0000
From: Malcolm Beattie <mbeattie@clueful.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: bert hubert <ahu@ds9a.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ide filters / 'ide dump' / 'bio dump'
Message-ID: <20020313120509.A11043@clueful.co.uk>
In-Reply-To: <E16kcTV-0002ar-00@the-village.bc.nu> <3C8D6CA4.8060604@mandrakesoft.com> <20020313091422.A23422@outpost.ds9a.nl> <3C8F25BE.9040000@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8F25BE.9040000@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 13, 2002 at 05:11:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> bert hubert wrote:
> 
> ># biodump /dev/hda
> >09:09:33.023 READ block 12345 [10 blocks]
> >09:09:33.024 READ block 12355 [10 blocks]
> >09:09:33.025 READ block 12365 [10 blocks]
> >09:09:34.000 WRITE block 12345 [1 block]
> >
> 
> 
> Definitely an interesting idea...   With this new stuff Linus talked 
> about in his proposal and what I'm thinking about, it shouldn't be too 
> hard to do.

I wrote a basic version of that (reqlog) a couple of years ago (with
the writing of the rw/block/size info inline in the kernel rather than
via a nice separate filter). The use I put it to was for migrating
block devices live (i.e. while being read/written) without having to
quiesce the readers/writers except for a few seconds at the end. The
idea is that you set up (as an ordinary userland process) a bitmap
in memory for all the blocks on the device. You start with them all
marked dirty. You then do two loops concurrently (select() or threads):
    while (1) {
        read next block/size touched
        mark corresponding bits dirty in bitmap
    }
and
    while (1) {
        while (find_next_dirty_bit_in_bitmap()) {
		mark bit clean
		read corresponding block from device
		send blocknumber, blockdata to remote peer
	}
        go back to start of bitmap
    }

The remote peer is a daemon which just reads the (blocknumber,data)
pairs and writes the data to the snapshot-to-be device at its end.
Eventually, the bitmap gets mostly clean and the migrating process
has "caught up" and is just siphoning newly dirtied data off to the
remote end in real time. At that point, you quiesce the writing
applications nicely for a few seconds (database, serving daemons or
whatever is writing to the device) and let the migrator clean the
bitmap fully (the last few blocks) and at that point you have a
point-in-time safe snapshot at the remote end.

With filters available (presumably as modules) for the bio stuff,
this will become possible without having to patch the kernel (I think
I submitted the reqlog and bufflink patches for inclusion but
didn't care enough to keep trying).

See
    http://www.clueful.co.uk/mbeattie/linux-kernel.html#reqlog
and bmigrate and bufflink on the same page for the "old" way. It's
basic stuff and new APIs mean a rewrite will be much easier but I
thought you may be interested in another application of such logging.


--Malcolm
        
-- 
Malcolm Beattie <mbeattie@clueful.co.uk>
Linux Technical Consultant
IBM EMEA Enterprise Server Group...
...from home, speaking only for myself
