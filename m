Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSGGRLM>; Sun, 7 Jul 2002 13:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSGGRLL>; Sun, 7 Jul 2002 13:11:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48300 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316210AbSGGRLJ>; Sun, 7 Jul 2002 13:11:09 -0400
Date: Sun, 7 Jul 2002 19:13:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide__sti usage
In-Reply-To: <Pine.LNX.4.44.0207071253190.1441-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.SOL.4.30.0207071859330.1945-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Jul 2002, Zwane Mwaikambo wrote:

> Hi Bart, Martin
> 	I'm seeing a number of deadlocks, most of them due to ide__sti
> enabling interrupts in a critical section which needs to be protected
> against interrupts too.

I'm seeing blue sky ;-)
Which IDE patch?

> Another dangerous scenario is the following, from here the usage of
> ide__sti becomes questionable.
>
> queue_commands() {
> 	ide__sti();
> 	start_request();
> }
> ...
> start_request() {
> 	spin_unlock_irq();
> 	frob_ide();

Whats that?

> 	spin_lock_irq();
> }
>
> and also;
>
> if (ch->unmask)
> 	ide__sti();	/* local CPU only */
>
> /* service this interrupt, may set handler for next interrupt */
> startstop = handler(drive, drive->rq);
> spin_lock_irq(ch->lock);
>
> If someone can explain to me what ide__sti really is trying to achieve
> i'd greatly appreciate it.

ide_sti() its just __sti() (except atari).
Note that ide_do_request() is called under spin_lock_irqsave(ch->lock,
flags). We have to unlock or we will get deadlock - imagine we are holding
lock and we get irq (shared irq, unexpected one) and we try to lock in
ata_irq_request() -> deadlock.

Also for most code in start_request() we dont need lock, we need it only
for calling block layer helpers, changing/reading IDE_BUSY bit and
ch->handler, timer and drive->rq.

Also we cannot disable interrupts, because we wont know when drive is
interrupting us, missed irqs.

Please also read my previous mails to Alex...

Regards
--
Bartlomiej

> Regards,
> 	Zwane Mwaikambo
>
> --
> function.linuxpower.ca
>

