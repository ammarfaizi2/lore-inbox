Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317930AbSFNPRR>; Fri, 14 Jun 2002 11:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSFNPRQ>; Fri, 14 Jun 2002 11:17:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4753 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317930AbSFNPRP>;
	Fri, 14 Jun 2002 11:17:15 -0400
Date: Fri, 14 Jun 2002 17:17:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020614151703.GB1120@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14 2002, Martin Dalecki wrote:
> Thu Jun 13 22:59:54 CEST 2002 ide-clean-91
> 
> - Realize that the only place where ata_do_taskfile gets used is ide-disk.c
>   move it and its "friends' over there.

Ehm, isn't that a bit odd? The typical "I'm not looking at the
interface, if only one person is currently using it then heck lets move
it" Martin approach (refer to prep_rq_fn cdb builder as well)

The above is just a minor thing, the reason I'm mailing is really:

- current 2.5 bk deadlocks reading partition info off disk. Again a
  locking problem I suppose, to be honest I just got very tired when
  seeing it happen and didn't want to spend tim looking into it.

I thought IDE locking couldn't get worse than 2.4, but I think you are
well into doing just that. What exactly are you plans with the channel
locks? Right now, to me, it seems you are extending the use of them to
the point where they would be used to serialize the entire request
operation start? Heck, ide-cd is even holding the channel lock when
outputting the cdb now.

- ata_end_request(). why didn't you just remove the last argument to
  __ata_end_request() instead just changing the comment saying why we
  pass nr_secs == 0 in from some sites?

- what's the reasoning behind moving the active request into the
  ata_device?! we are serializing requests for ata_device's on the
  ata_channel anyways, which is why it made sense to have the active
  request there.

And finally a small plea for more testing. Do you even test before
blindly sending patches off to Linus?! Sometimes just watching how
quickly these big patches appears makes it impossible that they have
gotten any kind of testing other than the 'hey it compiles', which I
think it just way too little for something that could possible screw
peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
currently. The success ratio of posted over working patches is too big.

-- 
Jens Axboe

