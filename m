Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSAUJFq>; Mon, 21 Jan 2002 04:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289097AbSAUJFi>; Mon, 21 Jan 2002 04:05:38 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56591
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289096AbSAUJFc>; Mon, 21 Jan 2002 04:05:32 -0500
Date: Mon, 21 Jan 2002 00:59:25 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121100042.P27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201210058480.13727-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Jens Axboe wrote:

> 
> (have read up on mult now)
> 
> On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > On Sun, Jan 20 2002, Andre Hedrick wrote:
> > > > > No it's not. By your standards, that would mean that if the device is
> > > > > setup for 16 sector multi mode, then I could never ever issue requests
> > > > > less than that (without doing some crap 'toss away extra data' stuff).
> > > > > How else would you handle, eg, 2 sector requests with multi mode set?
> > > > 
> > > > Change the opcode in the command block to single sector, if
> > > > rq->current_nr_sectors != drive->multcount.
> > > 
> > > That crossed my mind too, however that's not what we've been doing in
> > > the past and multi mode has worked fine.
> > 
> > And we have not done a lot of things in the past.
> > Mind the fact, before you changed max-sectors from 128 to 255 != 256, he
> > problems maybe a direct result.  Mind the fact, it is my fault for not
> > telling you about the issue.
> > 
> > Since 128 and 256 are clearly 2,4,8,16 divisable and clean, as a result we
> > kind of masked the problem, but 255 is not at all the same issue.
> 
> But, eg, 24 sectors is not and we would still be starting a multi
> read/write for that...
> 
> > Mind you Mark Lord did get this correct in the copy buffer issue, but the
> > bug introduced by 255 is the only problem I can trace to be suspect.
> 
> 255 is effectively 248 (256 - 8), however that is still not correct when
> modulo a 16 multi sector setting.
> 
> > > > the hardware to what you are sending down.  The question you need to
> > > > answer is issuing a request for multi-sector transfers less than what the
> > > > device is expecting, sane and correct.  If you tell me it is correct,
> > > > please show me where I read something wrong in the specification.
> > > 
> > > You are saying that even when I do:
> > > 
> > > 	/* this is our request */
> > > 	rq->nr_sectors = 48;
> > > 	rq->current_nr_sectors = 8;
> > > 
> > > 	/* drive->mult_count has been programmed to 16 */
> > 
> > You exectute WIN_MULTREAD and it behaves based on what the device has been
> > programmed to do respond.
> > 
> > If you want 8 sectors only, by golly you had better tell it expect 8
> > sectors and then you can interrupt upon completion.
> > 
> > If it expects 16 sectors and you stop at 8, and issue a new command,
> > expect the device to go south.
> 
> This really sucks, it means we cannot safely use multi mode for a
> variety of request sizes. I agree with your earlier comment. Here's what
> I think we should be doing: when requesting multi mode, limit to 8
> sectors like in your patch. This is by far the most commen multiple,
> that's why. When starting a request, use WIN_MULT* only for cases where
> (rq->nr_sectors % drive->mult_count) == 0. If that doesn't hold, simply
> use WIN_READ or WIN_WRITE.
> 
> Applied the 2.5.3-pre2 sched SMP fix, booting -pre2 and then hacking up
> a patch.

Why I have already done it, just take and apply.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

