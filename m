Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVAOXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVAOXmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVAOXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:42:20 -0500
Received: from science.horizon.com ([192.35.100.1]:21292 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262363AbVAOXmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:42:05 -0500
Date: 15 Jan 2005 23:42:04 -0000
Message-ID: <20050115234204.20123.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Make pipe data structure be a circular list of pages, rather
Cc: ioe-lkml@axxeo.de, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The beauty of Linus's scheme is that direct hardware-to-hardware
copying is possible, without inventing new kernel interfaces.

Take a step way back to general software design, and consider a
unidirectional communications channel between a data producer and a
data consumer.

The data producer can be passive (produce data in response to read()
operations), or active (produce data spontaneously and go looking for
a place to put it).

Likewise, the data consumer can be passive (consume data when provided
by a write() operation), or active (in which case underflow is a
possibility).

An active producer can just call a passive consumer, and vice versa.  This
is the easiest way to pass data between two chunks of code, particularly
in the same address space.  But deciding which part will be active and
which part will be passive is an important early design decision.

An active producer can be connected to an active consumer with a passive
buffer structure.  This is what a Unix pipe is.  To make this work reliably,
you need some way to block the consumer when the pipe is empty and
some way to block the producer if the pipe is too full.

Finally, a passive producer can be connected to a passive consumer via
an active "pump" process that reads from the producer and writes to the
consumer.

A pipeline with multiple "pump" processes and multiple pipe buffers
connecting them is somewhat wasteful, but not necessarilty too bad.


Now, Unix tradition is that user processes are active and the kernel (and
all its files and devices devices) is passive.  Thus, the user process
makes read() and write() calls and the kernel does as directed.  Even though
some devices (particularly sound cards) might be better modelled as active,
changing that basic kernel assumption would be a massive change that would
have way too many consequences to consider right now.

(For an example of the complexity of not having a process involved, look at
network routing.)

This is fundamentally why the splice() call requires the process to actually
move the buffers around.  You could imagine it just creating some sort of
in-kernel "background pump" to do the transfer, which could be optimized
away in the case of pipe-to-pipe splices, but it's important that there
always be a process (with a killable pid) "in charge" of the copying.

Otherwise, consider a splice() between /dev/zero and /dev/null.  That call
is basically going to spin in the kernel forever.  You need a way to stop it.
Anything other than kill() would be sufficiently un-Unix-like to require
careful justification.


Thus, Linus's scheme always keeps the splice() process "in the loop".
"Ah," you say, "but doesn't that introduce extraneous data copies?"

No, it doesn't, and there's the clever bit.  Instead of passing the *bytes*
through the pipe, he's passing a description of *where to find the bytes*.

And in some cases (notably splice() and tee()), that description can
be forwarded directly from one device or pipe to another without ever
looking at the bytes themselves.  Then, when you get to a part where
the description isn't good enough and you need the bytes themselves,
you can find them and copy them.

Basically, it's lazy evaluation of the bytes.  Rather than passing around
the bytes, you pass around a promise to generate some bytes.  It's like
the difference between cash and a cheque.  As Linus noted, you can start
a disk I/O and pass around a reference to the target page before the I/O
is complete.  The wait for I/O can be deferred until the bytes are needed.


What you need is a generalization of a "struct page".  It need not refer
to system RAM.  It need not be kmap-able.  The only thing you absolutely
need is the ability to copy it to a low memory bounce buffer.

But, if you're lucky, the data consumer can consume the data directly
from the source, and we have zero-copy I/O.


The big requirement is a way to define various kinds of "pages" and define
methods for copying between them.  Normally, we do this with an ops vector,
but because "struct page" is so numerous, and the number of types is so
small, perhaps a (Lisp-style) few-bit "tag" could be used rather than a
(C++-style) operations vector pointer.  It could be as simple as a single
bit which allows the reinterpretation of some existing fields, or declares
the "struct page" to have additional fields which describe its I/O
features, non-standard size, or whatever.

Further, for each *pair* of page types, there are several ways to perform
the final copy from producer to consumer.

- There may be a special way for this particular (source, destination)
  pair.
- It may be possible to map the destination into some address space that
  the source can write directly (e.g. DMA).
- It may be possible to map the source into some address space that the
  destination can read directly (e.g. DMA).
- If all else fails, it may be necessary to allocate a bounce buffer
  accesible to both source and destination and copy the data.

Because of the advantages of PCI writes, I assume that having the source
initiate the DMA is preferable, so the above are listed in decreasing
order of preference.

The obvious thing to me is for there to be a way to extract the following
information from the source and destination:
"I am already mapped in the following address spaces"
"I can be mapped into the following address spaces"
"I can read from/write to the following address spaces"

Only the third list is required to be non-empty.

Note that various kinds of "low memory" count as separate "address spaces"
for this purpose.

Then some generic code can look for the cheapest way to get the data from
the source to the destination.  Mapping one and passing the address to
the other's read/write routine if possible, or allocating a bounce
buffer and using a read followed by a write.

Questions for those who know odd machines and big iron better:

- Are there any cases where a (source,dest) specific routine could
  do better than this "map one and access it from the other" scheme?
  I.e. do we need to support the n^2 case?
- Now many different kinds of "address spaces" do we need to deal with?
  Low kernel memory (below 1G), below 4G (32-bit DMA), and high memory
  are the obvious ones.  And below 16M for legacy DMA, I assume.
  x86 machines have I/O space as well.
  But what about machines with multiple PCI buses?  Can you DMA from one
  to the other, or is each one an "address space" that can have intra-bus
  DMA but needs a main-memory bounce buffer to cross buses?
  Can this be handled by a "PCI bus number" that must match, or are there
  cases where there are more intricate hierarchies of mutual accessibility?

  (A similar case is a copy from a process' address space.  Normally,
  simgle-copy pipes require a kmap in one of the processes.  But if
  the copying code can notice that source and dest both have the same
  mm structure, a direct copy becomes possible.)
