Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRLMKU0>; Thu, 13 Dec 2001 05:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282378AbRLMKUR>; Thu, 13 Dec 2001 05:20:17 -0500
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:5190 "EHLO
	porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
	id <S282190AbRLMKUK>; Thu, 13 Dec 2001 05:20:10 -0500
Message-Id: <200112131020.fBDAK3g14078@porsta.cs.Helsinki.FI>
Content-Type: text/plain; charset=US-ASCII
From: Pasi Sarolahti <sarolaht@cs.Helsinki.FI>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
Date: Thu, 13 Dec 2001 12:19:56 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Mika wrote:
> Looks like there are still problems after applying your quick patch.
> Back at the lab we observed a case where the FIN-ACK packet is dropped
> and Linux fails to retransmit it. See the attached dump for the details
> (Linux is 10.0.5.11). The action ends there, with Linux timing out to
> CLOSED state and the remote stuck in FIN-WAIT-2.

I think following might happen: When the receiver gets FIN and acks it, it
should be in CLOSE_WAIT or LAST_ACK state depending on the situation,
right? In tcp_rcv_state_process() the receiver calls ack_snd_check, which
has the following test:

            if (!tcp_ack_scheduled(tp)) {
		/* We sent a data segment already. */
		return;
	}
	__tcp_ack_snd_check(sk, 1);

I think in this situation it may be possible that ack_scheduled is false,
which would mean that the receiver never acks the further FIN segments if
the first FIN-ack is lost. Maybe something like the following might work,
although it looks pretty ugly :-)

       if (!tcp_ack_scheduled(tp) &&
                                      (sk->state == TCP_ESTABLISHED ||
                                       sk->state == TCP_FIN_WAIT1)) {
                /* We sent a data segment already. */
                return;
        }

(Btw, I'm not on the lkml, so I would like to be cc'd of the further
discussion on this thread)

- - Pasi

- -- 
http://www.cs.helsinki.fi/u/sarolaht/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GIDRoNa7NH1G2csRAvoLAKC5JbdYF524KMGKOG7X7jObLIkifgCffIbG
tA/Cr4FqSeWhEArt/mPlHGY=
=KD8M
-----END PGP SIGNATURE-----
