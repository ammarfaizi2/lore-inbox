Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRDIETF>; Mon, 9 Apr 2001 00:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbRDIESz>; Mon, 9 Apr 2001 00:18:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132684AbRDIESk>; Mon, 9 Apr 2001 00:18:40 -0400
Date: Sun, 8 Apr 2001 21:18:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Ben LaHaise <bcrl@redhat.com>, David Howells <dhowells@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <Pine.LNX.4.31.0104081841440.7671-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0104082030080.7830-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "down_writer_failed()" case was wrong:

On Sun, 8 Apr 2001, Linus Torvalds wrote:
>
> 	__down_write_failed(sem)
> 	{
> 	....
> 			/*
> 			 * Ignore other pending writers: but if there is
> 			 * are pending readers or a write holder we should
> 			 * sleep
> 			 */
> 			if (value & 0xc0007fff) {
	....

The "value & 0xc0007ffff" test is wrong, because it's actually always true
for some normal contention case (multiple pending writers waiting for a
reader to release the lock). Because even if there is no write lock
holder, other pending writers (and we're one) will have caused the high
bits to be set, so the above would end up causing us to think that we
can't get the lock even if there is no real lock holder.

The comment is right, though. It's just the test that is simplistic and
wrong.

The pending readers part is correct, and obvious enough:

	(value & 0x7fff) != 0

implies that there are readers. In which case we should try again. Simple
enough.

The pending writers part is slightly more subtle: we know that there is at
least _one_ pending writer, namely us. It turns out that we must check the
two high bits, and the logic is:

 - 11: only pending writers, no write lock holder (if we had a write lock
       holder, he would have set the bits to 11, but a pending writer
       would have borrowed from the lower bit, so you'd get bit pattern
       10).
 - 10: we have a real lock holder, and the pending writers borrowed from
       the low lock bit when they did the "subl 0x8000" to mark off
       contention.
 - 01: must not happen. BUG.
 - 00: we had a real write lock holder, but he released the lock and
       cleared both bits.

So the "si there a write lock holder" test basically becomes

	(value & 0xc0000000) == 0x80000000

and the full test should be

	if ((value & 0x7fff) || ((value & 0xc0000000) == 0x80000000) {
		spin_unlock();
		schedule();
		spin_lock();
		continue;
	}

which might be rewritten some simpler way. I'm too lazy to think about it
even more.

For similar reasons, the "newvalue" calculation was subtly bogus: we must
make sure that we maintain the correct logic for the two upper bits in the
presense of _other_ pending writers. We can't just do the unconditional
binary "or" operation to set the two upper bits, because then we'd break
the above rules if there are other pending writers. So the newvalue
calculation should be something along the lines of

	/* Undo _our_ contention marker */
	newvalue = value + 0x8000;

	/* Get rid of stale writer lock bits */
	newvalue &= 0x3fffffff;

	/*
	 * If there were no other pending writers (newvalue == 0), we set
	 * both high bits, otherwise we only set bit 31.
	 * (see above on the "borrow bit being clear" logic).
	 */
	if (!newvalue)
		newvalue = 0xc0000000;
	newvalue |= 0x80000000;

And THEN I think the algorithm in the email I'm following up to should
actually really work.

Does anybody find any other details I missed?

And no, I have not yet actually _tested_ any of this. But all my code
works on the first try (or, in this case, second try if you want to be a
stickler for details).

No wonder we didn't get this right first time through. It's not really all
that horribly complicated, but the _details_ kill you.

		Linus

