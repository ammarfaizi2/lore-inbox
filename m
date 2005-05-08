Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVEHMpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVEHMpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVEHMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:45:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:29162 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262858AbVEHMpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:45:40 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: suse-amd64@suse.com, linux-kernel@vger.kernel.org
Subject: False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Sun, 8 May 2005 14:45:20 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2020310.ZEz7mpIodj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505081445.26663.bernd.paysan@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2020310.ZEz7mpIodj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've recently set up a dual Opteron RAID server (AMD-8000-based Tyan=20
Thunder K8S Pro SCSI board, 2 246 Opterons, stepping 10). Kernel is a=20
modified 2.6.11.4-20a from SuSE 9.3 (SMP version, sure). The Opterons=20
are capable of changing the CPU frequency (between 1GHz and 2GHz).

The system clock runs (on average) about twice as fast as it should be.=20
A closer observation revealed that the clock jumps forward by about=20
10-30 seconds every 10-30 seconds (plus other oddities, including=20
backward clock jumps). The timer interrupts are distributed roughly=20
evenly among the two CPUs, but looking at the timer interrupt number=20
(grep timer /proc/interrupts) revealed that for about 10-30 seconds,=20
one CPU gets the interrupt, and then the other CPU gets them; the=20
transition causes the system clock to advance.

A quick look at timer_interrupt shows what I suspect is the culprit:=20
Each CPU keeps track of the last TSC at a timer interrupt, and adds the=20
"lost" ticks to jiffies when perceived necessary. If there's only a=20
single jiffies, but two vxtime.last_tsc, it can't work.

A quick workaround would be to ditch the handling of the "lost" jiffies.=20
I still anticipate to have annoying time skews by do_gettimeoffset()=20
(that's what explains the other oddities - if I do gettimeofday() on=20
the CPU that isn't getting interrupts, I'll going to add the "lost"=20
jiffies, too). A proposed fix would be to *also* store the last jiffies=20
value in the vxtime variable, and verify if it's really *this* CPU that=20
did miss the timer interrupts. This local "last-stored-jiffies" can=20
help do_gettimeoffset() to calculate the local time good enough on both=20
CPUs.

What I can't believe is that I'm the only one who has this problem.

<rant>I know the timer system on an Intel or AMD system is broken by=20
design, because there should be a single constant-clocked atomically=20
read-only system-wide timer. But this is no excuse for that ;-).</rant>

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--nextPart2020310.ZEz7mpIodj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCfgnmi4ILt2cAfDARAov4AKC/SiGoxYsOarWw1M9F4LfU6Yz5lgCgleXf
SwaaYgcimNJRoszjgvon+yU=
=lPco
-----END PGP SIGNATURE-----

--nextPart2020310.ZEz7mpIodj--
