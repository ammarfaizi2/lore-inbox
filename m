Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289093AbSAUIC3>; Mon, 21 Jan 2002 03:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAUICT>; Mon, 21 Jan 2002 03:02:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54025 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289093AbSAUICH>;
	Mon, 21 Jan 2002 03:02:07 -0500
Date: Mon, 21 Jan 2002 09:01:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121090156.O27835@suse.de>
In-Reply-To: <20020121083653.N27835@suse.de> <Pine.LNX.4.10.10201202338470.13650-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201202338470.13650-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20 2002, Andre Hedrick wrote:
> > No it's not. By your standards, that would mean that if the device is
> > setup for 16 sector multi mode, then I could never ever issue requests
> > less than that (without doing some crap 'toss away extra data' stuff).
> > How else would you handle, eg, 2 sector requests with multi mode set?
> 
> Change the opcode in the command block to single sector, if
> rq->current_nr_sectors != drive->multcount.

That crossed my mind too, however that's not what we've been doing in
the past and multi mode has worked fine.

> > > The effective operations your changes have created without addressing all
> > > the variables is to terminate the command in process.  Therefore, the
> > > decision made by you was to restrict the transfers to be process to the
> > > count in rq->current_nr_sectors.  There is no bounds checking based on the
> > > command executed.
> > 
> > I'm not stopping a request in progress. I told the drive that the
> > request is current_nr_sectors big, so once it finishes transferring
> > current_nr_sectors sectors it truly thinks it's really done with that
> > request. And it is. However, I'm leaving the request on the queue (or,
> > really, ide_end_request is not taking it off because
> > end_that_request_first is not indicating it's complete). So I'm simply
> > starting from scratch with the remaining data. See?
> 
> I know what you are doing, and I am trying to mate the requirement to use

Yes

> the hardware to what you are sending down.  The question you need to
> answer is issuing a request for multi-sector transfers less than what the
> device is expecting, sane and correct.  If you tell me it is correct,
> please show me where I read something wrong in the specification.

You are saying that even when I do:

	/* this is our request */
	rq->nr_sectors = 48;
	rq->current_nr_sectors = 8;

	/* drive->mult_count has been programmed to 16 */

	/* bla bla command setup */
	OUT_BYTE(rq->current_nr_sectors, IDE_NSECTOR_REG);
	ide_set_hander(...);
	OUT_BYTE(WIN_MULTREAD, IDE_COMMAND_REG);

The drive will be wanting to transfer _16_ sectors, even though I told
it that I want _8_. This sounds very strange to me, and it means that
2.2/2.4 etc should have never worked in multi mode. I'll go find the
spec now... I am just talking out of my ass.

> > > *****************************
> > > The questions to ask "How would the host terminate a command in progress, 
> > > since BSY=1 (or DRQ=1) at this point?   Is that done via a DEVICE_RESET or
> > > SRST write?"
> > 
> > [snip]
> > 
> > Moot, there's no premature termination going on.
> 
> >From the OS/HOST side you are 100% correct.

Yep

> >From the device side, do you know that for a fact?

No

> Please read the difference in the two state-machine diagrams, the have the
> same name phasing, but each describes which end of the cable you are on
> and the expected behavors.

I will do so now, I think I've stated my speculation above and in
earlier mails :-)

-- 
Jens Axboe

