Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSKCQSY>; Sun, 3 Nov 2002 11:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbSKCQSY>; Sun, 3 Nov 2002 11:18:24 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:58608 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262145AbSKCQSV>; Sun, 3 Nov 2002 11:18:21 -0500
From: <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alan Cox" <alan@redhat.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Date: Sun, 3 Nov 2002 17:24:22 +0100
Message-Id: <20021103162422.27845@smtp.wanadoo.fr>
In-Reply-To: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
References: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That requires code in every driver. Duplicated, hard to write, likely to
>be racey code. Thats bad.
>
>The bigger picture really should be
>
>ACPI etc	"I want to suspend to disk"
>
>PM layer
>		Suspend the non I/O tasks (btw reminds me - eh tasks and
>			all workqueues may be I/O tasks at times)
>		Complete all the block I/O queues
>		Throw out the pages we can evict
>		Write suspend image
>		
>		Jump to PM layer "power off" logic
>
>If you do it that way up then no drivers need to be hacked about.

Hrm... thanks to the miracle of having a BIOS that will deal
with the grunt work of actually shutting down the chipsets,
resuming them, etc...

This is definitely not the case on pmac and embedded. Or did I
miss something to your explanation ?

I really don't like the above as it basically bypasse the
bus ordering, which is the only sane way I see to deal with
dependencies when the drivers are actually shutting down HW

While suspend to disk may justify suspention of all non IO
tasks etc..., when doing suspend to RAM, I get very good
results (and very fast suspend/resume cycles) by letting
just about everything run and relying on implicitly beeing
suspended as a result of relying on a service/driver that
has blocked it's queue.

But doing that properly definitely involve a precise process
to be followed by driver (though most drivers can actually
implement only a simplify version of it) so that we don't
fall in a case where a driver trying to allocate memory (to
save state for example) ends up blocking for ever because
it's hung waiting for a page to be swapped out on a device
that is already asleep.

We have debated this a lot with Patrick, Greg, Pavel, ...
and at the "improvised" PM BOF during OLS, and I really
think we should do it what I think is "the right way",
even if it seems slightly more complicated driver-side.

I'm pretty sure it's not actually _that_ complicated, and
in most case, the actual functionality can be provided by
helper routines in each functional subsystem, the important
point beeing that those have to be called by the driver at
appropriate moment so that ordering stays correct.

Also, I don't like, from the design point of view, the notion
of suspending tasks to "hope" no new IO requests will get
triggered. That involve specific coloring of various kernel
threads, and can be nasty if for any reason we end up having
IOs triggered asynchronously by non-tasks (though I'm not
sure that is possible in linux today).

Also, what about a driver that, for it's own suspend operation
needs to actually trigger an IO ? The disk is a typical case
where we want to send a STANDBY command (though the queue ?
synchronously ? after waiting for the initial queue emptyness ?).

I'd add to that the problem isn't specific to BIO queues. It's
the same problem we have to deal with URB lists, 1394 request
queues, etc... as we don't have a unified model for IO queues
(and that's good that way imho).

Anyway, all this is talk, I've started playing with moving
my pmac stuff to the new model, and I intend to actually
make things work the way I want at first as a proof of concept.

Then, I volunteer writing a HOWTO explaining clearly what a
driver should do for proper PM, and I'm pretty sure that won't
be that nasty and race prone as you are afraid of ;)

Ben.


