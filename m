Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVASVN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVASVN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVASVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:13:29 -0500
Received: from science.horizon.com ([192.35.100.1]:59189 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261898AbVASVMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:12:51 -0500
Date: 19 Jan 2005 21:12:50 -0000
Message-ID: <20050119211250.13528.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Make pipe data structure be a circular list of pages, rather than
Cc: linux@horizon.com, lm@bitmover.com, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0501151838010.8178@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lm@bitmover.com wrote:
> You seem to have misunderstood the original proposal, it had little to do
> with file descriptors.  The idea was that different subsystems in the OS
> export pull() and push() interfaces and you use them.  The file decriptors
> are only involved if you provide them with those interfaces(which you
> would, it makes sense).  You are hung up on the pipe idea, the idea I
> see in my head is far more generic.  Anything can play and you don't
> need a pipe at all, you need 

I was fantasizing about more generality as well.  In particular, my
original fantasy allowed data to, in theory and with compatible devices,
be read from one PCI device, passed through a series of pipes, and
written to another without ever hitting main memory - only one PCI-PCI
DMA operation performed.

A slightly more common case would be zero-copy, where data gets DMAed
from the source into memory and from memory to the destination.
That's roughly Larry's pull/push model.

The direct DMA case requires buffer memory on one of the two cards.
(And would possibly be a fruitful source of hardware bugs, since I
suspect that Windows Doesn't Do That.)

Larry has the "full-page gift" optimization, which could in theory allow
data to be "renamed" straight into the page cache.  However, the page also
has to be properly aligned and not in some awkward highmem address space.
I'm not currently convinced that this would happen often enough to be
worth the extra implementation hair, but feel free to argue otherwise.

(And Larry, what's the "loan" bit for?   When is loan != !gift ?)


The big gotcha, as Larry's original paper properly points out, is handling
write errors.  We need some sort of "unpull" operation to put data back
of the destination can't accept it.  Otherwise, what do you return from
splice()?  If the source is seekable, that's easy, and a pipe isn't much
harder, but for a general character device, we need a bit of help.

The way I handle this in user-level software, to connect modules that
provide data buffering, is to split "pull" into two operations.
"Show me some buffered data" and "Consume some buffered data".
The first returns a buffer pointer (to a const buffer) and length.
(The length must be non-zero except at EOF, but may be 1 byte.)

The second advances the buffer pointer.  The advance distance must be
no more than the length returned previously, but may be less.

In typical single-threaded code, I allow not calling the advance function
or calling it multiple times, but they're typically called 1:1, and
requiring that would give you a good place to do locking.  A character
device, network stream, or the like, would acquire an exclusive lock.
A block device or file would not need to (or could make it a shared lock
or refcount).


The same technique can be used when writing data to a module that does
buffering: "Give me some bufer space" and "Okay, I filled some part of
it in."  In some devices, the latter call can fail, and the writer has
to be able to cope with that.


By allowing both of those (and, knowing that PCI writes are more efficient
than PCI reads, giving the latter preference if both are available),
you can do direct device-to-device copies on splice().


The problem with Larry's separate pull() and push() calls is that you
then need a user-visible abstraction for "pulled but not yet pushed"
data, which seems lile unnecessary abstraction violation.


The main infrastructure hassle you need to support this *universally*
is the unget() on "character devices" like pipes and network sockets.
Ideally, it would be some generic buffer front end that could be used
by the device for normal data as well as the special case.

Ooh.  Need to think.  If there's a -EIO problem on one of the file
descriptors, how does the caller know which one?  That's an argument for
separate pull and push (although the splice() library routine still
has the problem).  Any suggestions?  Does userland need to fall
back on read()/write() for a byte?
