Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281473AbRK0Qgl>; Tue, 27 Nov 2001 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0Qgc>; Tue, 27 Nov 2001 11:36:32 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:52234 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281473AbRK0QgN> convert rfc822-to-8bit; Tue, 27 Nov 2001 11:36:13 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Journaling pointless with today's hard disks?
Date: Tue, 27 Nov 2001 10:36:28 -0600
Message-ID: <hgd70us5kslnp9os92ekfu7l4sqpcpn5op@4ax.com>
In-Reply-To: <b0b50u0s566g9fusmrfs275lsjvr0dd0hu@4ax.com> <Pine.LNX.4.10.10111261323270.9208-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10111261323270.9208-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My experience is with SCSI not ATA, so adjust accordingly...


On Mon, 26 Nov 2001 13:36:06 -0800 (PST), you wrote:

>On Mon, 26 Nov 2001, Steve Brueggeman wrote:
>
Snip-out my stuff
>
>One has to go read the general purpose error logs to determine the
>location of the original platter assigned sector of the relocated LBA.
>
>Reallocation generally occurs on write to media not read, and you should
>know that point.

Actually, it has been my experience that most reallocations occur on
reads.  The reasons for this are two fold.  

1) most systems out there do an order of magnitude more reads than
writes, 
2) the amount of data read (servo/headers, sync...) for a write
operation is an order of magnitude less than it is for a read
operation (same servo/header/sync plus the whole data-field and
CRC/ECC).

Note: no media related errors can be detected while write-gate is
active.  Only servo positioning errors, and even that's not likely
with the current drives using embeded servo.

>
Snip some more of my stuff
>
>By the time an ATA device gets to generating this message, either the bad
>block list is full or all reallocation sectors are used.  Unlike SCSI
>which has to be hand held, 90% of all errors are handle by the device.
>Good or Bad -- that is how it does it.

I think what you meant is, 90% of all errors are handled silently by
the device.  I don't like silent errors.

>
>Well there is an additional problem in all of storage, that drives do
>reorder and do not always obey the host-driver.  Thus if the device is
>suffering from performance and you have disabled WB-Cache, it may elect to
>self enable.  Now you have the device returning ack to platter that may
>not be true.  Most host-drivers (all of Linux, mine include) release and
>dequeue the request once the ack has been presented.  This is dead wrong.
>If a flush cache fails I get back the starting lba of the write request,
>and if the request is dequeued -- well you know -- bye bye data!  SCSI
>will do the same, even with TCQ.  Once the sense is cleared to platter and
>the request is dequeued, and a hiccup happens -- bye bye data!
>

It is my convicted opinion that any device that automatically enables
write-caching is broken and anyone who enables write caching probably
doesn't know what they're doing.  A system simply cannot get reliable
error reporting with write caching enabled.  

Without write-caching, if you get good completion status, the data is
GURANTEED to be on the platter.  `With` write-caching, the best you
can hope for are deferred errors, but I am yet to see a system that
can properly cope with deferred errors, so at best, they're
informational only.

I once had to write some drive test software that ran with
write-caching enabled, on a drive in degraded mode.  The only option I
could come up with was to maintain a history of the last 2 X queue
depth commands sent to each device, and do a look-up for the LBA in
the deferred error for all commands in the history that had a range
that covered the LBA in error.  Unfortunately, this was under DOS and
this was not an option because the memory was too tight.  What I ended
up with was better than nothing, but still could not catch 100% of the
deferred errors.

(More snippage)

>
>Question -- are you up to fixing the low-level drivers and all the stuff
>above ?
>

Probably not, as my plate's pretty full.

Though, I would like to understand more specifically what you're
talking about...

I see the following opportunities..

1)  Read returns unrecoverable error.
	write to bad sector and re-read
		if re-read returns unrecoverable error, manually
reallocate

This should not be done automatically, since there is no easy way to
determine whether that sector is in a free list, and we are only
allowed to write to sectors in a free list.  This would best be done
by the badblocks utility, in combination with fsck.  Maybe it already
does this, I haven't looked.


2) At device initialization, and after device resets, force
write-cache to be disabled. (not very nice to those that would rather
have write cache enabled... poor souls)

3) Set the Force Unit Access bit for all write commands. (again, not
very nice to those poor souls that would rather have write cache
enabled)

4) Reordering of commands is rather unrelated to the problem at hand,
but it is a concern for anything that needs ordered transactions.  The
Linux SCSI layers only inject an ordered command every so-often to
prevent command starvation, but for ordered transactions, the SCSI
layer should probably be forcing the sending of Ordered command queue
messages with the CDB.  I'd rather hate to see every SCSI request
become an ordered command queue, since the disk drive really does know
best how to reorder it's queue of commands.  The SCSI block layer
really needs some clues from the upper layers in my opinion, about
whether a given request needs to be ordered or not.  But I digress.
This is a whole other topic.


Steve Brueggeman


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

