Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTEZUnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTEZUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:43:17 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:32518 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262231AbTEZUnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:43:16 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305261339340.13489-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305261339340.13489-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 May 2003 16:56:24 -0400
Message-Id: <1053982586.2298.214.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 16:45, Linus Torvalds wrote:
> 
> On 26 May 2003, James Bottomley wrote:
> > 
> > > I'd hate for SATA to pick up these kinds of mistakes from the SCSI layer.
> > 
> > The elevator is based on linear head movements.
> 
> Historically, yes.
> 
> But we've been moving more and more towards a latency-based elevator, or
> at least one that takes latency into account. Which is exactly why you'd
> like to leave unfinished requests on the queue, because otherwise your
> queue doesn't really show what is really going on.
> 
> In particular, while the higher layers don't actually _do_ this yet, from 
> a latency standpoint the right thing to do when some request seems to get 
> starved is to refuse to feed more tagged requeusts to the device until the 
> starved request has finished. 

OK, number seven on the list was going to be thinking about tracking
timeouts at the block layer.

Tag starvation handling is a property of each individual SCSI HBA (and I
know it shouldn't be).  Some do a good job, some don't.  However, it's
implicitly also handled in the SCSI error handler because on timeout we
quiesce the device (which finally causes the starved tag to execute).  I
have thought about doing it properly in the error handler, but it's a
radical divergence---you basically need to begin to throttle the queue,
but wait to see if your starved tag gets serviced and then increase the
feed again (as opposed to our current quiesce then handle model).

> As I mentioned, Andrew actually had some really bad latency numbers to
> prove that this is a real issue. SCSI with more than 4 tags or so results 
> in potentially _major_ starvation, because the disks themselves are not 
> even trying to avoid it.

Tag starvation isn't really a problem for the majority of modern SCSI
drives (big iron vendors yelled and kicked about this a while ago).  You
can still find some of the older drives that do have these issues (I
keep several for the purposes of exciting the error handling).

> Also, even aside from the starvation issue with unfair disks, just from a
> "linear head movement" standpoint, you really want to sort the queue
> according to what is going on _now_ in the disk. If the disk eats the
> requests immediately (but doesn't execute them immediately), the sorting
> has nothing to go on, and you get tons of back-and-forth movements.

Most scsi discs have a non linear geometry anyway, so "head scheduling"
is pretty useless to them.  All SCSI really wants is I/O consolidation. 
i.e. we'd like to use fewer larger sized requests.

James


