Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310413AbSCLFJX>; Tue, 12 Mar 2002 00:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310412AbSCLFJM>; Tue, 12 Mar 2002 00:09:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:265 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310403AbSCLFJB>; Tue, 12 Mar 2002 00:09:01 -0500
Date: Mon, 11 Mar 2002 21:08:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020312044953.GB18857@codepoet.org>
Message-ID: <Pine.LNX.4.33.0203112051550.1547-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Erik Andersen wrote:
>
> Essentially, if I understand what you are saying,  you are
> looking for a uniform low-level mass-storage layer that does all
> the normal low-level drive access stuff.

Well, yes and no.

It's not really low-level - it's at the same level as the current
"ll_rw_block()" in that it doesn't per se know any real details of any
drivers - it is nothing but a "build this request" layer (with a way of
getting the data back, of course).

So from a driver perspective (or even driver subsystem like IDE or SCSI)
it's actually a high-level request generator.

Now, let me say outright that I have a very specific reason why I'd like
this thing to be done at this level - which really has nothing to do with
Jeff's wishes to create a IDE command parser.

The reason I want to see stuff done _above_ the level of the request queue
is that I really count on the "struct request" as being the abstraction
layer that the current block driver interfaces so sadly lack.

Right now, block drivers are not very well abstracted at all: and this is
a large part of the reason for why we even _have_ things like the SCSI
midlevel layer or the IDE layer in the first place. But both the SCSI
layer and the IDE layer are just fairly messy - with no good way to share
code (no common interfaces) and with very inflexible setups (just look at
how hard it is to do a high-performance SCSI driver, because if you do a
SCSI driver at all you have to do all the interface crap that comes with
the job).

I'm really hoping that some day, if the _only_ interface to the block
driver is "struct request", you can write truly interchangable block
drivers - the same way you can write truly independent network drivers
today. None of this "IDE vs SCSI midlevel layer" crap.

Yes, "struct request" is slightly more complex than just being handed a
packet to send out, but I think that is unavoidable - block devices just
_are_ more complex than sending out a packet on a network. So while it's
not a really simple interface, at least it is a clear border between
drivers. And a SCSI driver would be nothing more than a driver that
accepts at least a subset of the kinds of requests that some scsi module
can push to it.

None of this complex function call interface with common complex
structures that are imposed by hundreds of different drivers that each
have slightly different issues. Just a queue.

"Everything is a stream of bytes" - except in this case the stream just
happens to have enough structure that you can re-order the packets and try
to sort them while they haven't been committed yet.

		Linus

