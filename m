Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVAELd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVAELd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAELd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:33:27 -0500
Received: from grendel.firewall.com ([66.28.58.176]:3469 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262342AbVAELcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:32:45 -0500
Date: Wed, 5 Jan 2005 12:32:44 +0100
From: Marek Habersack <grendel@caudium.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050105113244.GB7751@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050104195636.GA23034@beowulf.thanes.org> <20050104220313.GD7048@alpha.home.local> <20050104230733.GE5592@beowulf.thanes.org> <20050105052841.GA24263@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20050105052841.GA24263@alpha.home.local>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2005 at 06:28:41AM +0100, Willy Tarreau scribbled:
> Hi,
Hello,

> On Wed, Jan 05, 2005 at 12:07:33AM +0100, Marek Habersack wrote:
> > Interestingly enough, the machine with the highest load average is the
> > one generating 4Mbit/s and the one with 24Mbit/s has the smallest load
> > average value.
>=20
> This is common with multi-process servers like apache if the link is
> saturated, because data takes more time to reach the client, so you have
> a higher concurrency.
The link isn't saturated - we have a 200Mbit/s margin atm. It's not a
bandwidth problem, that's certain.

> > The latter also suffers from the biggest loadavg increase.=20
> > All of the virtual machines have iptables accounting chains for each
> > configured IP (there are between 62 IP numbers on one and 32 on the oth=
er).
> > The virtual boxes have two 80GB SATA drives raided with softraid. The
> > non-virtual box has a single IDE drive, no raid.
>=20
> > (virtual #2, the 24Mbit/s one)
> > # vmstat
> > procs -----------memory---------- ---swap-- -----io---- --system------c=
pu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us s=
y id wa
> >  5  3 172448  13084   1208 304048    4    4    90    50  109   117 19  =
8 73 0
>=20
> I don't like something : with 73% idle, you have 5 processes in the rq. I=
 think
> this machine writes logs synchronously to disks, or stores SSL sessions o=
n a
the only synchronously written logs are auth.log and mail.err, SSL is there
indeed, but the site is hardly ever accessed (as of a while ago, the box has
a load of 0.75, pushing out 14Mbit/s. With 2.4.28 last week it was around
10.0 in the same conditions).

> real disk and waits for writes. A tmpfs would be a great help.
The only thigs writing to disk on regular basis (except for syslog and
apache for logs) are the php session files, one tdb database for traffic
data and mysql (which might be using fsync - can that be the cause of the
i/o slowness?). But, in any case, the machine behaves well under kernels
other than 2.4.28.

> You can try to trace the processes activity with :
>=20
> # strace -Te write <process pid>
> It will display the time elapsed in each write() syscall, you'll find the
> fds in /proc/<pid>/fd. You may notice big times on logs or ssl sessions.
nope... the times are in the range 0.000008 to 0.000045...
=20
> > (the non-virtual)
> > # vmstat
> > procs -----------memory---------- ---swap-- -----io---- --system------c=
pu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us s=
y id wa
> > 60  0  70300 115960      0 369244    0    0    79    32   90    45 73  =
7 21 0
>=20
> Same note for this one, although it does more user space work (php? ssl?).
poorly written perl scripts

> It's possible that some change in 2.4.28 touches the I/O subsystem and
> increases your wait I/O time in this particular application.
> (...)=20
Any clues as to where too look? I examined the 2.4.28 changelog and saw
nothing that would suggest such change, but then I'm not a kernel hacker, I
might have easily missed something important.

> > One other interesting thing to note is that we have one
> > other box with the similar configuration to the virtuals (also a virtual
> > host) but it runs 2.4.28 with SMP+HT enabled - no load problems there at
> > all.
>=20
> So, to contradict myself, have you tried enabling HT on other boxes which
> suffer from the load ?
Yep, only one box boots fine with HT enabled (out of the ones with
problems), the others just freeze (we thought it could have been the machine
BIOS, but updating it didn't help)

> > Let me know if you need more info,
>=20
> You have send fairly enough info right now. Other than I/O work, I have no
> idea. You may want to play with /proc/sys/vm/{bdflush,max-readahead} and
> others to see if it changes things.
At this point I think we're gonna run them under the older kernels and wait
for 2.4.29 to see whether the problem still exists there. If it does, we'll
try 2.6 on the machines and if that doesn't help, we'll do some more testing
with 2.4.28 - we have our hands tied, since they are production machines and
we cannot let them run with such degraded performance for too long...

> If your load is bursty, it might help to reduce the ratio of dirty blocks
> before flushing (first field in bdflush), because although writes will
> start more often, they will take fewer time.
what about nfract_sync? Does it make sense to make it smaller as well? I've
also decreased age_buffer to 15s
=20
> I already have solved similar problems by disabling keep-alive to decrease
> the number of processes.
Disabling keep-alive is a routine here... :) But, that is unlikely to be the
cause since it's evidently a kernel thing.

Well, I'll see what good the bdflush changes do to the machines when they
run under the "good" kernel and we'll schedule for some testing with 2.4.28
at some point.

thanks for your help, it's greately appreciated!

best regards,

marek

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFB29Bcq3909GIf5uoRAjBuAJ0ZDxmsOvq1A7MiMUgBHnvKIahdZwCWPfAp
oNes/ZhXI1flGvJT1GYfCw==
=ezTc
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
