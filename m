Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbRASPbG>; Fri, 19 Jan 2001 10:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRASPa5>; Fri, 19 Jan 2001 10:30:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8486 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132450AbRASPau>; Fri, 19 Jan 2001 10:30:50 -0500
Date: Fri, 19 Jan 2001 16:25:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010119162552.D3447@athlon.random>
In-Reply-To: <20010118231651.L28276@athlon.random> <Pine.LNX.4.30.0101182317420.3437-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101182317420.3437-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 11:18:48PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 11:18:48PM +0100, Ingo Molnar wrote:
> 
> On Thu, 18 Jan 2001, Andrea Arcangeli wrote:
> 
> > This is a possible slow (but userspace based) implementation of SIOCPUSH:
> 
> of course this is what i meant. Lets stop wasting time on this, ok?

We were both wrong. Not even my pseudocode was equivalent to SIOCPUSH 8). Infact
this example 1):

	val = 1
	setsockopt(TCP_CORK, &val)

	sendfile()
	sendfile()
	write()
	write()
	whatever()
	
	val = 0
	setsockopt(TCP_CORK, &val)

is _not_ equivalent to this example 2):

	val = 1
	setsockopt(TCP_CORK, &val)

	sendfile()
	sendfile()
	write()
	write()
	whatever()
	
	val = 0
	setsockopt(TCP_CORK, &val)
	ioctl(SIOCPUSH)

We were wrong because the "uncork" doesn't do what we all expected from it.

The "uncork" won't push the last skb on the wire if there is not acknowledged
data in the write_queue and the payload of the last skb in the write_queue
isn't large MSS. This because the `uncork' will only re-evaluate the
write_queue in function of the _nagle_ algorithm, quite correctly because the
"uncork" will move frok "cork" to "nagle" (not from "cork" to "nodelay").

Infact this below ugly 3) is finally equivalent to 2) and that's what we
all expected from 1):

	val = 1
	setsockopt(TCP_CORK, &val)

	sendfile()
	sendfile()
	write()
	write()
	whatever()
	
	val = 0
	setsockopt(TCP_CORK, &val)
	val = 1
	setsockopt(TCP_NODELAY, &val)
	val = 0
	setsockopt(TCP_NODELAY, &val)

The uncork didn't do what we all expected but I don't consider it a bug in the
uncork itself because reprocessing the write queue with nagle makes perfect
sense (the socket effectively is in nalge mode, not in nodelay mode), and with
SIOCPUSH we don't need to hack the uncork semantics to avoid having to enter
nodelay mode just to push the last skb in the writequeue into the wire, so
there's no pratical problem (the socket will remain corked or nagled all the
time anyways).

So in short I just wanted to clarify that the "uncorking" doesn't "push" the
write_queue into the wire ASAP as SIOCPUSH does, but it only ensures that the
queued data will arrive to the other end "eventually". SIOCPUSH is instead the
right way to notify the stack it doesn't worth to wait for new outgoing packets
caming from usersapce.

However my implementation of SIOCPUSH of yesterday isn't completly right yet,
my one works fine only if we can send the last fragment immediatly (our cwnd
and receiver advertised window may forbid that).

The right way to implement the SIOCPUSH is to add a flag into the `struct
tcp_opt' tp->push. It works this way: tp->push is set by SIOCPUSH if something
is left in the write_queue after re-evaluating the write_queue in nodelay mode as
my patch just does.  Then the checks on the write queue triggered by the
incoming acks will also check tp->push and they will consider tp->nonagle set
as 1 (nodelay) if tp->push is set. The first send on the socket that arrives
from userspace will clear tp->push. Then SIOCPUSH will work fine with the
semantics we expect.

I'm too busy with other stuff to spend more time than this on the TCP stack
right now, so if somebody of the TCP folks wants to reimplement SIOCPUSH
correctly (as described above) I'm fine. If you can wait I will do that myself
in a few weeks.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
