Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316376AbSEOL5i>; Wed, 15 May 2002 07:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316377AbSEOL5h>; Wed, 15 May 2002 07:57:37 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:4174 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S316376AbSEOL5g>; Wed, 15 May 2002 07:57:36 -0400
Message-ID: <3CE24CB9.8DFC5821@ukaea.org.uk>
Date: Wed, 15 May 2002 12:55:37 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com> <200205151138.g4FBcGY13110@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 15 May 2002 07:32, Martin Dalecki wrote:
> > >> Yes thinking about it longer and longer I tend to the same conclusion,
> > >> that we just shouldn't have per device queue but per channel queues
> > >> instead.
> 
> IMHO logically request queue is a separate entity for each disk.
> IDE can have 2 devices on one cable (or more: think about
> buggy cmd640 like chipset as a weird IDE with four disks
> on a channel since we can talk to one disk only at a time).

Actually, since Martin pointed out the hardsect stuff, I'm inclined to
think per-device queues but with a per-channel busy flag are the best
idea.  Or perhaps I should call it a per-channel "Don't touch the cable"
flag.  See below.

> It is a _spin_ lock.
> Does this mean you will spin on it while IDE request for other disk
> is processed?

No.  An SMP machine will spin on it only while the queue-handling code
is active.  During the pause while the disk fetches the sectors from the
media, no problem.

> Somebody enlighten me: can IDE mix reqests and completion like this:

I'll try (!)  Treat my words with caution ;-)

> host ----read reqest---> master
> host ----read reqest---> slave  (is this possible?)

No, in general.  Not unless you're using tagged command queueing.  This
is because the master won't have performed a bus-release on any normal
R/W command.  Once you are using TCQ it's OK though (tricky but OK).

You can (and must) safely "touch the cable" in between TCQ commands in
the right circumstances.  You are therefore touching the cable while the
hwgroup is busy, hence my suggestion that the flag we use to prevent
touching the cable during DMA should be named something other than busy.

Neil
