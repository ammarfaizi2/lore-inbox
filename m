Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316374AbSEOLn3>; Wed, 15 May 2002 07:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316375AbSEOLn2>; Wed, 15 May 2002 07:43:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50700 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316374AbSEOLn0>; Wed, 15 May 2002 07:43:26 -0400
Message-Id: <200205151138.g4FBcGY13110@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.15 IDE 61
Date: Wed, 15 May 2002 14:40:51 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2002 07:32, Martin Dalecki wrote:
> >> Yes thinking about it longer and longer I tend to the same conclusion,
> >> that we just shouldn't have per device queue but per channel queues
> >> instead.

IMHO logically request queue is a separate entity for each disk.
IDE can have 2 devices on one cable (or more: think about
buggy cmd640 like chipset as a weird IDE with four disks
on a channel since we can talk to one disk only at a time).

This fact is a hardware limitation which can be hidden,
IDE code should arbitrare access to IDE channel.
But why mix up queues?

> >> The only problem here is the fact that some device properties
> >> are attached to the queue right now. Like for example sector size and
> >> friends.

This is naturally happening with one queue per disk.

> > Hi Martin,
> > instead of having per channel queue, you could have per device queue,
> > but use the same lock for both, i.e. don't make the lock part of "struct
> > queue" (or whatever it is called) but instead make the address of the
> > lock be attached to "struct queue".

> In 63 we have:
> 	blk_init_queue(q, do_ide_request, drive->channel->lock);
> struct ata_channel {
> 	struct device	dev;		/* device handle */
> 	int		unit;		/* channel number */
>
> 	/* This lock is used to serialize requests on the same device queue or
> 	 * between differen queues sharing the same irq line.
> 	 */
> 	spinlock_t *lock;
>
> + The whole glory of lock sharing for IRQ sharing and serialization.

It is a _spin_ lock.
Does this mean you will spin on it while IDE request for other disk
is processed?

Somebody enlighten me: can IDE mix reqests and completion like this:

host ----read reqest---> master
host ----read reqest---> slave  (is this possible?)
host <---interrupt------ master
host ----okay,send it--> master
host <---data----------- master
host <---data----------- master (do slave has to wait until end here?)
host <---data----------- master
host <---that's all----- master
host <---interrupt------ slave
	(can host issue another read for master here?)
host ----okay,send it--> slave
host <---data----------- slave

Please comment what is allowed and what is not.
I suspect we are in IDE chipset bugs land here.

Does current IDE code (as Martin sees it) utilize this fully but
does not push IDE over limit?

Hm, seems like IDE code needs to remember set of ATA capabilities
(i.e. what should be serialized and what can be safely intermixed
in time) for each controller in order to run full speed on good chips
yet don't croak on buggy ones.
--
vda
