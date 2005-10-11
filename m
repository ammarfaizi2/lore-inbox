Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVJKWAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVJKWAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVJKWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:00:46 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:25304 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751192AbVJKWAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:00:45 -0400
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange>
	<m3slvtzf72.fsf@telia.com>
	<Pine.LNX.4.60.0509252026290.3089@poirot.grange>
	<m34q873ccc.fsf@telia.com>
	<Pine.LNX.4.60.0509262122450.4031@poirot.grange>
	<m3slvr1ugx.fsf@telia.com>
	<Pine.LNX.4.60.0509262358020.6722@poirot.grange>
	<m3hdc4ucrt.fsf@telia.com>
	<Pine.LNX.4.60.0509292116260.11615@poirot.grange>
	<m3k6gw86f0.fsf@telia.com>
	<Pine.LNX.4.60.0510092304550.14767@poirot.grange>
	<m3psqewe30.fsf@telia.com>
	<Pine.LNX.4.60.0510112325410.19291@poirot.grange>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Oct 2005 23:58:57 +0200
In-Reply-To: <Pine.LNX.4.60.0510112325410.19291@poirot.grange>
Message-ID: <m37jcjiula.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Sun, 9 Oct 2005, Peter Osterlund wrote:
> 
> > In that case, this patch should also work. Does it?
> > 
> > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > index d4b9c17..cb6bda9 100644
> > --- a/drivers/block/pktcdvd.c
> > +++ b/drivers/block/pktcdvd.c
> > @@ -538,7 +538,7 @@ static void pkt_iosched_process_queue(st
> >  			spin_unlock(&pd->iosched.lock);
> >  			if (bio && (bio->bi_sector == pd->iosched.last_write))
> >  				need_write_seek = 0;
> > -			if (need_write_seek && reads_queued) {
> > +			if (!writes_queued && reads_queued) {
> >  				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
> >  					VPRINTK("pktcdvd: write, waiting\n");
> >  					break;
> 
> Well, I've had this patch (to 2.6.13) failing once, whereas I still 
> haven't been able to reproduce the error with your previous patch. What 
> now? A bit worrying is that test results are not 100% deterministic now... 
> Which means, until recently my standard test (copy about 150M co the 
> CD-RW && sync) produced always consistent results, now I've seen a couple 
> of times the same driver version either failing or succeeding...

My current theory is that there is something wrong with the firmware
or hardware in your drive, and different I/O patterns have different
probabilities of triggering this problem.

Maybe you could use Jens' IO tracing patch to identify the sequence of
commands that make the drive fail. See subject "[PATCH] Block device
io tracing" posted by Jens earlier today.

If the problem is always caused by some well defined sequence of
commands, it might be possible to implement a workaround in the
pktcdvd driver.

> BTW, Peter, I still get errors from mails to you:
> 
> <petero2@telia.com>:
> 81.228.8.84_does_not_like_recipient./Remote_host_said:_553_RCPT_TO:<petero2@telia.com>_refused/G
> iving_up_on_81.228.8.84./

It seems like my ISPs mail server doesn't want to talk to your mail
server. I have no idea why. I did get mails from you earlier.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
