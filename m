Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRARTng>; Thu, 18 Jan 2001 14:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132594AbRARTn0>; Thu, 18 Jan 2001 14:43:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43859 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132508AbRARTnS>; Thu, 18 Jan 2001 14:43:18 -0500
Date: Thu, 18 Jan 2001 20:38:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rick Jones <raj@cup.hp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118203802.D28276@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101181411530.823-100000@elte.hu> <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101180826370.18072-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 18, 2001 at 08:49:38AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 08:49:38AM -0800, Linus Torvalds wrote:
> state. However, the fact is that you _need_ the persistency of a socket
> option if you want to take advantage of external programs etc getting good
> behaviour without having to know that they are talking to a socket. 

I'm all for TCP_CORK but it has the disavantage of two syscalls for doing the
flush of the outgoing queue to the network. And one of those two syscalls is
spurious. Certainly it makes perfect sense that the uncork flushes the outgoing
queue, but I think we should have a way to flush it without exiting the cork-mode.
I believe most software only needs to SIOCPUSH after sending the data and just
before waiting the reply.

A new ioctl on the socket should be able to do that (and ioctl looks ligther
than a setsockopt, ok ignoring actually the VFS is grabbing the big lock
until we relase it in sock_ioctl, ugly, but I feel good ignoring this fact as
it will gets fixed eventually and this is userspace API that will stay longer).

[ I ignored the ioctl #define mess so it can't compile ]

diff -urN -X /home/andrea/bin/dontdiff 2.4.1pre8/net/ipv4/tcp.c SIOCPUSH/net/ipv4/tcp.c
--- 2.4.1pre8/net/ipv4/tcp.c	Wed Jan 17 04:02:38 2001
+++ SIOCPUSH/net/ipv4/tcp.c	Thu Jan 18 19:10:14 2001
@@ -671,6 +671,11 @@
 		else
 			answ = tp->write_seq - tp->snd_una;
 		break;
+	case SIOCPUSH:
+		lock_sock(sk);
+		__tcp_push_pending_frames(sk, tp, tcp_current_mss(sk), 1);
+		release_sock(sk);
+		break;
 	default:
 		return(-ENOIOCTLCMD);
 	};

The SIOCPUSH makes sense and it "may" be useful also when not using TCP_CORK
(only with nagle algorithm): it allows the sender to push into the network the
last frame of the message into the wire without waiting the not yet
acknowledged data to be acknowledged (and without having to disable the nagle
algorithm on the socket to achieve that).

SIOCPUSH is a noop if the user set TCP_NODELAY in the socket options indeed.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
