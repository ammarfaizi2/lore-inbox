Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135173AbRARU2P>; Thu, 18 Jan 2001 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135341AbRARU1z>; Thu, 18 Jan 2001 15:27:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35930 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135173AbRARU1p>; Thu, 18 Jan 2001 15:27:45 -0500
Date: Thu, 18 Jan 2001 21:24:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118212441.E28276@athlon.random>
In-Reply-To: <20010118203802.D28276@athlon.random> <Pine.LNX.4.30.0101182041240.1009-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101182041240.1009-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 08:43:47PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 08:43:47PM +0100, Ingo Molnar wrote:
> 
> On Thu, 18 Jan 2001, Andrea Arcangeli wrote:
> 
> > I'm all for TCP_CORK but it has the disavantage of two syscalls for
> > doing the flush of the outgoing queue to the network. And one of those
> > two syscalls is spurious. [...]
> 
> i believe a network-conscious application should use MSG_MORE - that has
> no system-call overhead.

Agreed. However since TCP_CORK logic is more generic than MSG_MORE and so it
still makes sense for some usage I think it worth to optimize the TCP_CORK
logic too and this new functionality _may_ be useful not just for TCP_CORK.

> > +	case SIOCPUSH:
> > +		lock_sock(sk);
> > +		__tcp_push_pending_frames(sk, tp, tcp_current_mss(sk), 1);
> > +		release_sock(sk);
> > +		break;
> 
> i believe it should rather be a new setsockopt TCP_CORK value (or a new
> setsockopt constant), not an ioctl. Eg. a value of 2 to TCP_CORK could
> mean 'force packet boundary now if possible, and dont touch TCP_CORK
> state'.

Doing PUSH from setsockopt(TCP_CORK) looked obviously wrong because it isn't
setting any socket state, and also because the SIOCPUSH has nothing specific
with TCP_CORK, as said it can be useful also to flush the last fragment of data
pending in the send queue without having to wait all the unacknowledged data to
be acknowledged from the receiver when TCP_NODELAY isn't set.

Changing the semantics of setsockopt(TCP_CORK, 2) would also break backwards
compatibility with all 2.[24].x kernels out there.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
