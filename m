Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSAUIsx>; Mon, 21 Jan 2002 03:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289074AbSAUIso>; Mon, 21 Jan 2002 03:48:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54543
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289053AbSAUIsh>; Mon, 21 Jan 2002 03:48:37 -0500
Date: Mon, 21 Jan 2002 00:42:30 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121090156.O27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201210031300.13727-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> On Sun, Jan 20 2002, Andre Hedrick wrote:
> > > No it's not. By your standards, that would mean that if the device is
> > > setup for 16 sector multi mode, then I could never ever issue requests
> > > less than that (without doing some crap 'toss away extra data' stuff).
> > > How else would you handle, eg, 2 sector requests with multi mode set?
> > 
> > Change the opcode in the command block to single sector, if
> > rq->current_nr_sectors != drive->multcount.
> 
> That crossed my mind too, however that's not what we've been doing in
> the past and multi mode has worked fine.

And we have not done a lot of things in the past.
Mind the fact, before you changed max-sectors from 128 to 255 != 256, he
problems maybe a direct result.  Mind the fact, it is my fault for not
telling you about the issue.

Since 128 and 256 are clearly 2,4,8,16 divisable and clean, as a result we
kind of masked the problem, but 255 is not at all the same issue.

Mind you Mark Lord did get this correct in the copy buffer issue, but the
bug introduced by 255 is the only problem I can trace to be suspect.

> > > > The effective operations your changes have created without addressing all
> > > > the variables is to terminate the command in process.  Therefore, the
> > > > decision made by you was to restrict the transfers to be process to the
> > > > count in rq->current_nr_sectors.  There is no bounds checking based on the
> > > > command executed.
> > > 
> > > I'm not stopping a request in progress. I told the drive that the
> > > request is current_nr_sectors big, so once it finishes transferring
> > > current_nr_sectors sectors it truly thinks it's really done with that
> > > request. And it is. However, I'm leaving the request on the queue (or,
> > > really, ide_end_request is not taking it off because
> > > end_that_request_first is not indicating it's complete). So I'm simply
> > > starting from scratch with the remaining data. See?
> > 
> > I know what you are doing, and I am trying to mate the requirement to use
> 
> Yes

Good we are still in agreement.

> > the hardware to what you are sending down.  The question you need to
> > answer is issuing a request for multi-sector transfers less than what the
> > device is expecting, sane and correct.  If you tell me it is correct,
> > please show me where I read something wrong in the specification.
> 
> You are saying that even when I do:
> 
> 	/* this is our request */
> 	rq->nr_sectors = 48;
> 	rq->current_nr_sectors = 8;
> 
> 	/* drive->mult_count has been programmed to 16 */

You exectute WIN_MULTREAD and it behaves based on what the device has been
programmed to do respond.

If you want 8 sectors only, by golly you had better tell it expect 8
sectors and then you can interrupt upon completion.

If it expects 16 sectors and you stop at 8, and issue a new command,
expect the device to go south.

> 	/* bla bla command setup */
> 	OUT_BYTE(rq->current_nr_sectors, IDE_NSECTOR_REG);
> 	ide_set_hander(...);
> 	OUT_BYTE(WIN_MULTREAD, IDE_COMMAND_REG);
> 
> The drive will be wanting to transfer _16_ sectors, even though I told
> it that I want _8_. This sounds very strange to me, and it means that
> 2.2/2.4 etc should have never worked in multi mode. I'll go find the
> spec now... I am just talking out of my ass.

See above.  And if the DRIVE or SPEC is wrong because we are doing it by
the book, we know where to raise a stink.

> > > > *****************************
> > > > The questions to ask "How would the host terminate a command in progress, 
> > > > since BSY=1 (or DRQ=1) at this point?   Is that done via a DEVICE_RESET or
> > > > SRST write?"
> > > 
> > > [snip]
> > > 
> > > Moot, there's no premature termination going on.
> > 
> > >From the OS/HOST side you are 100% correct.
> 
> Yep
> 
> > >From the device side, do you know that for a fact?
> 
> No
> 
> > Please read the difference in the two state-machine diagrams, the have the
> > same name phasing, but each describes which end of the cable you are on
> > and the expected behavors.
> 
> I will do so now, I think I've stated my speculation above and in
> earlier mails :-)

ERM, no ... This is a classic miscommunication event.
You have the analyzers, look for yourself.


Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

