Return-Path: <linux-kernel-owner+w=401wt.eu-S1754143AbWLXGzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbWLXGzy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 01:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbWLXGzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 01:55:54 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35434 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbWLXGzx (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 01:55:53 -0500
Message-Id: <200612240655.kBO6tngs031080@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: John Richard Moser <nigelenki@comcast.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: evading ulimits
In-Reply-To: Your message of "Sat, 23 Dec 2006 19:42:10 EST."
             <458DCCE2.3060605@comcast.net>
From: Valdis.Kletnieks@vt.edu
References: <458C4CEF.3090505@comcast.net> <Pine.LNX.4.61.0612240111250.20280@yvahk01.tjqt.qr>
            <458DCCE2.3060605@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166943349_22903P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Dec 2006 01:55:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166943349_22903P
Content-Type: text/plain; charset=us-ascii

On Sat, 23 Dec 2006 19:42:10 EST, John Richard Moser said:
> 
> 
> Jan Engelhardt wrote:
> >> I've set up some stuff on my box where /etc/security/limits.conf
> >> contains the following:
> >>
> >> @users          soft    nproc           3072
> >> @users          hard    nproc           4096
> >>
> >> I'm in group users, and a simple fork bomb is easily quashed by this:
> >>
> >> bluefox@icebox:~$ :(){ :|:; };:
> >> bash: fork: Resource temporarily unavailable
> >> Terminated
> >>
> >> Oddly enough, trying this again and again yields the same results; but,
> >> I can kill the box (eventually; about 1 minute in I managed to `/exec
> >> killall -9 bash` from x-chat, since I couldn't get a new shell open)
> >> with the below:
> > 
> > Note that trying to kill all shells is a race between killing them all firs
t
> > and them spawning new ones everytime. To stop fork bombs, use killall -STOP
> > first, then kill them.
> > 
> 
> Yes I know; the point, though, is that they should die automatically
> when the process count hits 4096.  They do with the first fork bomb;
> they keep growing with the second, well past what they should.

This may be another timing issue - note that in the first case, you have :|:
which forks off 2 processes with a pipe in between.  If the head process fails,
the second probably won't get started by the shell *either*.  In the second
case, you launch *3*, and it's possible that the head process will start and
live long enough to re-fork before a later one in the pipe gets killed.

Does the behavior change if you use 4095 or 4097 rather than 4096?  I'm
willing to bet that your system exhibits semi-predictable behavior regarding
the order the processes get created, and *which* process gets killed makes
a difference regarding how fast the process tree gets pruned.

Do you have any good evidence that the second version manages to create much
more than 4096 processes, rather than just being more exuberant about doing so?
I'm guessing that in fact, in both cases the number of processes ends up
pseudorandomly oscillating in the 4090-4906 range, but the exact order of
operations makes the rate and impact different in the two cases.

--==_Exmh_1166943349_22903P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFjiR1cC3lWbTT17ARAufJAKDZKCJ4JN5ykGAwOEBCrWMr5Lq/MACgxXro
Ymw5tNtKn2fxZHbcVQewmPg=
=HcGr
-----END PGP SIGNATURE-----

--==_Exmh_1166943349_22903P--
