Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267807AbTBVAis>; Fri, 21 Feb 2003 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBVAis>; Fri, 21 Feb 2003 19:38:48 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5783 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267807AbTBVAir>; Fri, 21 Feb 2003 19:38:47 -0500
Message-Id: <200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN 
In-Reply-To: Your message of "Fri, 21 Feb 2003 16:47:02 PST."
             <1045874822.25411.3.camel@rth.ninka.net> 
From: Valdis.Kletnieks@vt.edu
References: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk>
            <1045874822.25411.3.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1431001719P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Feb 2003 19:48:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1431001719P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 Feb 2003 16:47:02 PST, "David S. Miller" said:

> How do you know this is the reason for the lost SYN?  What if other
> things caused the SYN to be dropped by some intermediate site?

To be honest, we don't know.  On the other hand, there's 3 basic
classes of failure modes:

1) Somebody's routing table or dead link says you can't get here.  So
it doesn't matter if you retry without ECN, you *still* won't get
there.

2) Temporary queueing congestion causes your *first* SYN to be dropped
on the floor.  So if you send a second without ECN, you really can't
tell if it worked because of the second SYN working Just Because, or
because ECN was turned off.  On the other hand, you get the same
connection as if you had done ECN-off to begin with (just 1 transmit
later).

3) You can improve things by looking at the value of tcp_syn_retries,
and only turning off ECN for the N'th attempt.  This way, you're
looking at these major cases:

3A) The N-1 packets were all dropped because of an ECN problem, and
you have a good chance of the Nth packet actually working. You win
(since you get at least a "standard" TCP connection w/o ECN).

3B) The Nth packet gets munched by congestion even though it WOULD
have worked without ECN.  You would have lost anyhow.

3C) You *could* have the case where ECN was actually OK but the first
N-1 got lost by congestion/etc. You probably deserved to lose, but got
lucky instead.  You don't get ECN (which would help at THAT high
congestion rate), but hopefully packet loss rates will keep the window
WAY down anyhow so you can't make things much worse.

> All the workarounds for ECN blackholes violate the protocol and
> cause more problems than they solve.

At least the workarounds for this aren't as painful as trying to
do PMTU Discovery through a router that refuses to pass ICMP Frag Needed. ;)
 
> That is why we refuse to implement them, and this is why the ECN
> RFCs mark the "suggested workarounds" as optional not required to
> implement.

Well.. I really didn't want it to be a mandatory change - I was
looking for an optional way to do it.

I'll cook up some shell ad-crockery that does the iptables thing and
maybe looks at tcp_syn_retries, and will post back with the outcome...

/Valdis

--==_Exmh_1431001719P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+VsjtcC3lWbTT17ARAsswAKDK39hqOEHjcUNHGmnl2F/mbPsGRwCfcM8z
s3oYGMGoaJsTj0s9O7d+oFk=
=515K
-----END PGP SIGNATURE-----

--==_Exmh_1431001719P--
