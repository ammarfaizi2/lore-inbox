Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSEOLij>; Wed, 15 May 2002 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316374AbSEOLii>; Wed, 15 May 2002 07:38:38 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:51018 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S313628AbSEOLii>; Wed, 15 May 2002 07:38:38 -0400
Message-ID: <3CE2488C.AF2AFB9A@ukaea.org.uk>
Date: Wed, 15 May 2002 12:37:48 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com> <3CE13943.FBD5B1D6@ukaea.org.uk> <20020514163241.GR17509@suse.de> <3CE13F99.5BDED3DF@ukaea.org.uk> <20020514165113.GT17509@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 14 2002, Neil Conway wrote:
> > > To really serialize operations the queue _must_ be shared with whoever
> > > requires serialiation.
> > Why will this help?  The hardware can still be doing DMA on hda while
> > the queue's request_fn is called quite legitimately for a hdb request -
> > and the IDE code MUST impose the serialization here to avoid hitting the
> > cable with commands destined for hdb. (For example, by waiting for
> > !channel->busy.)
>
> Current IDE code leaves a request on the list until it has completed
> (this is ignoring TCQ of course), so there's no way that you could start
> serving a second request before the first one completes.

I didn't understand why this was the case, so I've been reading source
code (and sleeping for a few minutes too ;-)).  Wow, is it hard for a
newbie to follow - if I didn't know better I'd swear the kernel was
obfuscated.

I _think_ I now understand what's going on here: you guys already know
this stuff but perhaps others can learn from my slog through the code
(?) (and/or spot the dumb mistakes).  (I did notice what could be a
potential problem too, skip to the end if you want to find it.)

On a "totally" idle system, if a process decides to read from a file,
the sequence appears to be (with minor simplifications for clarity):

sys_read(), file->fops->read(), usually then into generic_file_read(),
page_cache_readahead(), and then the important one:
do_page_cache_readahead().  This does a couple of seriously important
things.  (The name implies it's only used for readahead but the comments
show this isn't the case (if one reads them!)).

Firstly, do_page_cache_readahead() invokes the call chain:
a_ops->readpage(), block_read_full_page(), submit_bh(), submit_bio(),
generic_make_request() (this one finds the right queue for the I/O) and
down into __make_request_fcn(q,bio).  This routine is also key: it adds
requests to the device queue, and a little more: if the queue is empty
it "plugs" the device (before adding the request),  ("plugging" the
device refers to preventing I/O while a request queue is populated), and
also queues a task to the tq_disk task-queue which will unplug the
device at some later time.  The "unplug" routine is central: see below.

Control returns to do_page_cache_readahead() after the call to
readpage().  It then calls run_task_queue(&tq_disk), thus starting the
call chain: generic_unplug_device(),..., q->request_fn().  This is the
end of the line for the block-layer: request_fn() is part of the device
code - for IDE it's do_ide_request().

So this call to request_fn()/do_ide_request() is the first time the IDE
code is really involved in the loop.

The key bit to notice here is that request_fn() is only called if the
device was plugged.  This in turn only happens (well almost, see below)
if the queue was empty.  Thus one concludes that if do_ide_request() is
busy servicing requests and thus the queue is non-empty, the block layer
will never again call do_ide_request(); it will be allowed to get on
with things in its own time.

This I believe, is what you meant Jens when you said "so there's no way
that you could start serving a second request before the first one
completes".  Am I right so far?

Now a possible fly in the ointment: __make_request_fcn() will actually
plug a non-empty queue if BIO_RW_BARRIER is set.  This appears right now
to be impossible because I can't find any code in the entire kernel that
uses bio_barrier() or any similar construct.  But if it's a work in
progress and this bit is set one day, then it seems to me that the block
layer could plug a non-empty queue, and then subsequently any call to
run_task_queue(&tq_disk) would call the block-device's request_fn(). 
This would violate the assumption that request_fn() is never called
twice without the queue emptying in between.  The current IDE code would
survive this because it checks for hwgroup->busy.

Anyway, IFF the BARRIER stuff is not an issue, then I guess the
block-layer really can do all the serialization we need if we set things
up right.  I now probably have to retract my assertions that we vitally
need hwgroup->busy (or equiv) because there really does appear to be no
route into request_fn() from the block layer other than if the queue was
empty...  In the real world though, as you suggested, it's probably
worth having.

all the best,
Neil

PS: Errors and Omissions Expected.
