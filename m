Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWGRWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWGRWUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGRWUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:20:45 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:28810 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S932217AbWGRWUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:20:44 -0400
From: Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>
To: linux-kernel@vger.kernel.org
Subject: procfs and privacy and a few other questions
Date: Wed, 19 Jul 2006 00:20:20 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1373391.mTC9tMPlO8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607190020.29684.Wolfgang.Draxinger@campus.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1373391.mTC9tMPlO8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Today I friend and me got a bit curious about the default permissions=20
of inodes in the procfs. By default they allow everybody to read the=20
procfs of foreign processes. Some people might see this as a lack of=20
privacy, since everybody logged in into the system can see the=20
command line of their processes, indicating the tasks they're doing=20
or worse, disclose actual data.

The question was if there were a way to prevent other people see the=20
processes (or at least their command line arguments) with "ps aux" et=20
al. The other question is of course if such a prevention would make=20
sense at all. I argued, that at least those foreign processes should=20
be visible that are parents of the process attempting to gather that=20
information.

A quick "chmod -R og-rx /proc/*" showed, that this does the job for=20
the currently running processes, but I doubt, that this is a sane=20
solution.

Since there is no umask mount option for procfs there must be a=20
sensefull reason for the "everybody may read others proc data"=20
policy.

####

Another question, also on procfs is, where exactly does the race=20
condition of the recently reported privilege escalation exploit does=20
take place. In the few days I was experimenting a bit with the code,=20
trying to inject non a.out formats, and eventually the Mono framework=20
or the WINE wrapper could allow to inject code through a BINFMT_MISC=20
handler, but I'm not through on this. Gladly the thing is fixed, but=20
given the fact that there seem to be still a lot of servers on which=20
even the sys_prctl exploit isn't fixed yet I'm a bit precarious about=20
the whole situation.

####

Next question: I'm currently working on a binary format that is=20
explicitly designed for the use in modularized, object oriented=20
programs, kinda bit like CLI/.Net/Mono. The big difference is, that=20
is focuses on normal "unmanaged" code. To use this format I had to=20
write a wrapper - of course - that loads the modules, dereferences=20
symbols and so on, you know the drill. However the module systems=20
allows for extension of the loader mechanism, through a second level=20
loader that is used for the major work in the whole system. However=20
this second level loader must be bootstrapped by the wrapper upon=20
program start - just like the Linux kernel gets bootstrapped. This=20
results in 2 disjunct versions of the loader code being present in=20
the running binary, of which the initial loader only takes away=20
resources. My idea was, that the initial loader could somehow=20
construct a fully functional binary in memory and then somehow=20
replace its process code with the in memory binary. I wonder if there=20
is such a possibility with the Linux kernel. Best thing I found so=20
far was fexecve.

####

And last but not least: I wrote a little, no tiny is the better word, =20
device driver for some gamma scintillation counter ADC hardware (GKH=20
may remember me, writing him an email on the stable driver ABI issue,=20
in which I mentioned this driver). That driver is simpler than SKULL=20
in "Linux Device Drivers" and it has proven stable so far (20=20
computers running 24/7 and putting data through the guts of the=20
driver with a rate of up to 100k counts per second (each count=20
triggers the IRQ and the IMHO a bit crude locking scheme). So far the=20
systems are running stable and required no reboot since March=20
(they're not connected to the internet and no foreign users have=20
access to them, so no need to patch security issues).

Yet I'm concern that it might break something or I made something=20
deliberately wrong, heck the last time I wrote kernel code was back=20
in 2.4.1 times, I micht be a bit out of practice.

Is there the chance, that somebody might check the code for proper=20
Linux coding style, not (just) in the way of source formatting but=20
the splitting up of the source files, the use of include files (e.g.=20
I put all IOCTL constants in a separate file with no source=20
dependencies and can be included from both Linux kernel code and user=20
space code without requiring includes "from the other world") and of=20
course the way I'm doing things. I know that the locking scheme is=20
very crude, but I'm quite sure, that the worst that can happen (if=20
the spinlock mechanism is bugfree) is, that one sample might be read=20
to small if a read from userspace is preempted by IRQ, and this read=20
will increment exactly this sample; the probability for this is very=20
small though: (2^12)^-2. However the samples are a histogram, and on=20
the next readout (about 1/50sek later) the correct value will be=20
there again. Accepting this little glitch saved me from implementing=20
a lot of infrastructure (workqueues, dynamic ringbuffers - there=20
might come in up to 100k IRQs per second, each only delivering one=20
single data word to be fetched with inw). I'm just a bit uneasy on=20
the whole thing.

####

Phew, I think that's it, I hope, that I'm not disturbing the kernel=20
guys too much from their great work and that they might find a few=20
moments to awnser me. Though I'm subscribed to the daily LKML digest=20
I'd be gladfull if awnsers could also be CCed to my PM.

Thanks, and happy coding

Wolfgang Draxinger

--nextPart1373391.mTC9tMPlO8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEvV6tBfWmRR/TvT4RArbpAKCYsShEKkb+kbPbdpjEyUi7g6c00QCfdAev
Yix9Vn/s//R3MWCaBoy2KkY=
=Vrea
-----END PGP SIGNATURE-----

--nextPart1373391.mTC9tMPlO8--
