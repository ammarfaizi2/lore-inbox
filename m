Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289085AbSAUHxK>; Mon, 21 Jan 2002 02:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSAUHwu>; Mon, 21 Jan 2002 02:52:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51215
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289085AbSAUHwj>; Mon, 21 Jan 2002 02:52:39 -0500
Date: Sun, 20 Jan 2002 23:46:23 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121083653.N27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201202338470.13650-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> On Sun, Jan 20 2002, Andre Hedrick wrote:
> > > Even if the drive is programmed for 16 sectors in multi mode, it still
> > > must honor lower transfer sizes. The fix I did was not to limit this,
> > > but rather to only setup transfers for the amount of sectors in the
> > > first chunk. This is indeed necessary now that we do not have a copy of
> > > the request to fool around with.
> > > 
> > > > Basically as the Block maintainer, you pointed out I am restricted to 4k
> > > > chunking in PIO.  You decided, in the interest of the block glue layer
> > > > into the driver, to force early end request per Linus's requirements to
> > > > return back every 4k completed to block regardless of the size of the
> > > > total data requested.
> > > 
> > > Correct. The solution I did (which was one of the two I suggested) is
> > > still the cleanest, IMHO.
> > > 
> > > > For the above two condition to be properly satisfied, I have to adjust
> > > > and apply one driver policy make the driver behave and give the desired
> > > > results.  We should note this will conform with future IDEMA proposals
> > > > being submitted to the T committees.
> > > 
> > > I still don't see a description of why this would cause a lost
> > > interrupt. What is the flaw in my theory and/or code?
> > 
> > We issue a setmultimode command and the driver defaults to maximum or 16
> > sectors in most cases.  This means the drive is expecting 16 sectors, and
> 
> Correct so far.
> 
> > your design is to issue only 8 sectors or less.  The issuing of 8 sectors
> > or less in the sector_count, while the device is expecting 16 is a setup
> > for problems.
> 
> No it's not. By your standards, that would mean that if the device is
> setup for 16 sector multi mode, then I could never ever issue requests
> less than that (without doing some crap 'toss away extra data' stuff).
> How else would you handle, eg, 2 sector requests with multi mode set?

Change the opcode in the command block to single sector, if
rq->current_nr_sectors != drive->multcount.

> > The effective operations your changes have created without addressing all
> > the variables is to terminate the command in process.  Therefore, the
> > decision made by you was to restrict the transfers to be process to the
> > count in rq->current_nr_sectors.  There is no bounds checking based on the
> > command executed.
> 
> I'm not stopping a request in progress. I told the drive that the
> request is current_nr_sectors big, so once it finishes transferring
> current_nr_sectors sectors it truly thinks it's really done with that
> request. And it is. However, I'm leaving the request on the queue (or,
> really, ide_end_request is not taking it off because
> end_that_request_first is not indicating it's complete). So I'm simply
> starting from scratch with the remaining data. See?

I know what you are doing, and I am trying to mate the requirement to use
the hardware to what you are sending down.  The question you need to
answer is issuing a request for multi-sector transfers less than what the
device is expecting, sane and correct.  If you tell me it is correct,
please show me where I read something wrong in the specification.

> > *****************************
> > The questions to ask "How would the host terminate a command in progress, 
> > since BSY=1 (or DRQ=1) at this point?   Is that done via a DEVICE_RESET or
> > SRST write?"
> 
> [snip]
> 
> Moot, there's no premature termination going on.

>From the OS/HOST side you are 100% correct.
>From the device side, do you know that for a fact?
Please read the difference in the two state-machine diagrams, the have the
same name phasing, but each describes which end of the cable you are on
and the expected behavors.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

