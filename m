Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbQLRWrD>; Mon, 18 Dec 2000 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLRWqx>; Mon, 18 Dec 2000 17:46:53 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:57329 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130111AbQLRWqi>; Mon, 18 Dec 2000 17:46:38 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012182215.eBIMFsb14852@webber.adilger.net>
Subject: Re: /dev/random: really secure?
In-Reply-To: <200012182133.QAA02136@tsx-prime.MIT.EDU> "from Theodore Y. Ts'o
 at Dec 18, 2000 04:33:13 pm"
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Mon, 18 Dec 2000 15:15:54 -0700 (MST)
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        David Schwartz <davids@webmaster.com>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> >  A potential weakness.  The entropy estimator can be manipulated by
> >  feeding data which looks random to the estimator, but which is in fact
> >  not random at all.

Ted Ts'o replied:
> Yes, absolutely.  That's why you have to be careful before you make
> changes to the kernel code to feed additional data to the estimator.
> *Usually* relying on interrupt timing is safe, but not always.  For
> example, an adversary can observe, and in some cases control the
> arrivial of network packets which control the network card's interrupt
> timings.  Is it enough to be able to predict with cpu-counter
> resolution the inputs to the /dev/random pool?  Maybe; it depends on how
> paranoid you are.

I think that for the case of dedicated firewall/IPSec machines, it
_should_ be possible to generate some entropy from network packets,
because this may be the only place where they get any activity (no
keyboard/mouse/disk).  Given the fact we are dealing with a router,
there shouldn't be any way one person can control all of the network
traffic to/through/from the router, and if they can you probably have
another security problem entirely.

Maybe a hook into the ipchains/netfilter code to allow selecting only
traffic from certain interfaces, and discarding "repeat" source and/or
destination addresses or packets arriving less than X ticks apart, just
like we discard repeated keystrokes.  The larger X is, the harder it is
to estimate the low-order bits on the timers when a packet arrives.

This would allow you to say "eth0 is my internal network and I'm not
trying to hack my own system, so use IP traffic on that interface to add
entropy to the pool, but not packets that are on port 6699/21/23 or reply
packets".  It would probably just be a matter of adding a new flag to a
filter rule to say "use packets that match this rule for entropy", and
then it is up to the user to determine what is safe to use.  The fact
that it is user configurable makes it even harder for a cracker to know
what affects the entropy pool.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
