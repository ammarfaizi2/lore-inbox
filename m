Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTFKAHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTFKAHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:07:41 -0400
Received: from mail.casabyte.com ([209.63.254.226]:16140 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262569AbTFKAFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:05:53 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "P. Benie" <pjb1008@eng.cam.ac.uk>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <mfedyk@matchmail.com>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Tue, 10 Jun 2003 17:19:13 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGMECPCPAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.HPX.4.33L.0306042133330.21092-100000@punch.eng.cam.ac.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(A quick food-for-thought note here...)

I hate to bring it up, but I am fairly certain that this argument is
part-and-parcel of the original AT&T "STREAMS"  (as opposed to "Streams" or
"streams", talk about namespace pollution 8-)interface.

Basically most devices (particularly character and network devices) were
implemented as a pair of queues of messages (one upstream one downstream)
and a writer would compose his entire text into a message (a linked list of
message buffers) which could be atomically placed on the write queue without
any consideration for device internal buffering.

[Between the "head" of the file handle and the actual driver you could
interpose translators and such by forming chains of queues, but that isn't
germane here.]

In such a usage, the writeability of a device is predicated on the
availability of a message buffer from some pool and some (in AT&T's case
some "lame-ass slightly less than Linux'es idea of a") kernel thread does
the pumping from the list to the device logic itself.

Without some sort of "above the driver but below the write" dynamic
buffering you almost inevitably get into a squeeze-the-balloon bug shuffling
situation.  The three bugs already mentioned here are write-interleaving,
odd blocking, and busy waiting.

Basically the peek-ahead on writeability is the relatively simple test: "is
there a free buffer in the pool of any size?" (because writeability is "can
accept at least one character.") and the anti-interleaving warrant is set at
multiples of "smallest buffer pool entry size".

The important thing is that the only lock contention window takes place for
the predictable time of putting the filled buffer onto or getting it off of
the queue (linked list pointer juggling time).

So why did I bring it up?

It seems to me that this can't really be fixed unilaterally at the driver
level without putting in a heck of a lot of scaffolding (e.g. evil STREAMS
8-).

The specific fix, however, might be easy at a fairly high level (line
discipline level?) with a fairly straight-forward linked list of buffers
thing.  With a fixed (or variable sized for that matter) pool of buffers,
the poll() could become a simple look-aside for a buffer well before the
branching internal logic/locking is otherwise referenced.  A
false-positive/race on the poll-to-get-buffer branch remains possible, but
unlikely to loop.

Basically you would be buying the correction in several ways:

1) raise the granularity.  With the warrant for an atomic write raised to
"one buffer" you increase the likely hood that any one operation will get in
and get out all at once.

2) add an insulating layer.  With the buffers rotating in and out via
pointer juggling, a very-short (spinlock) duration locking behavior is
placed between the fast world of the calling processes and the slow world of
serial I/O (and its analogues)

3) dynamic buffering.  Since the writes are called with reasonably sleepable
user context (e.g. enough latitude to do a memory allocate) "extra buffers"
are "always available" (though at the far end of this is a nasty DOR attack
8-) if circumstances or tuning makes such allocation desirable.

4) look aside used to determine write space availability.  (really a "2a"
thought) the list and pool of buffers approach would net you a look-aside
for the question of "can I write" so there is no contention between what the
driver is actually doing and the applicability of the question itself.

5) POSIX (et al) is (if I recall) silent about the size and nature of the
write buffer for a tty device.

uh... but it's just a thought... 8-)

Rob.


P. Benie wrote:

> On Wed, 4 Jun 2003, Linus Torvalds wrote:

> > On Wed, 4 Jun 2003, P. Benie wrote:
> > > The problem isn't to do with large writes. It's to do with any
sequence of
> > > writes that fills up the receive buffer, which is only 4K for N_TTY.
If
> > > the receiving program is suspended, the buffer will fill sooner or
later.
> >
> > Well, even then we could just drop the "write_atomic" lock.
> >
> > The thing is, I don't know what the tty atomicity guarantees are. I know
> > what they are for pipes (quite reasonable), but tty's?

> We don't have a PIPE_BUF-style atomicity guarantee, even though this would
> be quite useful. This lock is only used to prevent simultaneous writes
> from being interleaved. I've always assumed that when writes shouldn't be
> interleaved, but I can't quote a source for that.

