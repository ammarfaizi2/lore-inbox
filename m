Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSAUHhw>; Mon, 21 Jan 2002 02:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSAUHhm>; Mon, 21 Jan 2002 02:37:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16649 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288949AbSAUHhZ>;
	Mon, 21 Jan 2002 02:37:25 -0500
Date: Mon, 21 Jan 2002 08:36:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121083653.N27835@suse.de>
In-Reply-To: <20020120114850.J27835@suse.de> <Pine.LNX.4.10.10201201717570.12376-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201201717570.12376-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20 2002, Andre Hedrick wrote:
> > Even if the drive is programmed for 16 sectors in multi mode, it still
> > must honor lower transfer sizes. The fix I did was not to limit this,
> > but rather to only setup transfers for the amount of sectors in the
> > first chunk. This is indeed necessary now that we do not have a copy of
> > the request to fool around with.
> > 
> > > Basically as the Block maintainer, you pointed out I am restricted to 4k
> > > chunking in PIO.  You decided, in the interest of the block glue layer
> > > into the driver, to force early end request per Linus's requirements to
> > > return back every 4k completed to block regardless of the size of the
> > > total data requested.
> > 
> > Correct. The solution I did (which was one of the two I suggested) is
> > still the cleanest, IMHO.
> > 
> > > For the above two condition to be properly satisfied, I have to adjust
> > > and apply one driver policy make the driver behave and give the desired
> > > results.  We should note this will conform with future IDEMA proposals
> > > being submitted to the T committees.
> > 
> > I still don't see a description of why this would cause a lost
> > interrupt. What is the flaw in my theory and/or code?
> 
> We issue a setmultimode command and the driver defaults to maximum or 16
> sectors in most cases.  This means the drive is expecting 16 sectors, and

Correct so far.

> your design is to issue only 8 sectors or less.  The issuing of 8 sectors
> or less in the sector_count, while the device is expecting 16 is a setup
> for problems.

No it's not. By your standards, that would mean that if the device is
setup for 16 sector multi mode, then I could never ever issue requests
less than that (without doing some crap 'toss away extra data' stuff).
How else would you handle, eg, 2 sector requests with multi mode set?

> The effective operations your changes have created without addressing all
> the variables is to terminate the command in process.  Therefore, the
> decision made by you was to restrict the transfers to be process to the
> count in rq->current_nr_sectors.  There is no bounds checking based on the
> command executed.

I'm not stopping a request in progress. I told the drive that the
request is current_nr_sectors big, so once it finishes transferring
current_nr_sectors sectors it truly thinks it's really done with that
request. And it is. However, I'm leaving the request on the queue (or,
really, ide_end_request is not taking it off because
end_that_request_first is not indicating it's complete). So I'm simply
starting from scratch with the remaining data. See?

> *****************************
> The questions to ask "How would the host terminate a command in progress, 
> since BSY=1 (or DRQ=1) at this point?   Is that done via a DEVICE_RESET or
> SRST write?"

[snip]

Moot, there's no premature termination going on.

-- 
Jens Axboe

