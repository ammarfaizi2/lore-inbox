Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUFPTca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUFPTca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUFPTca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:32:30 -0400
Received: from smtpin.eastlink.ca ([24.222.0.18]:5150 "EHLO smtpin.eastlink.ca")
	by vger.kernel.org with ESMTP id S264635AbUFPTcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:32:25 -0400
Date: Wed, 16 Jun 2004 16:28:26 -0300
From: Peter Cordes <peter@cordes.ca>
Subject: x86-64: double timer interrupts in recent 2.4.x
To: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Message-id: <20040616192826.GD14043@cordes.ca>
MIME-version: 1.0
Content-type: multipart/signed; boundary=cNdxnHkX5QqsyA0e;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 Nobody replied to this message on debian-amd64@lists.d.o, or
discuss@x86-64.org.  Hopefully I've found the right places to send this this
time around.  Actually, Roland Fehrenbacher saw my message in a list archive
and mailed me to confirm that he saw the same double-speed clock problem on
two different machines, so it's not just Tyan S2880 boards.  He suggested I
mail Andi and lkml, so here goes.  (I haven't tested again with anything mo=
re
recent than 2.4.27-pre2, so if this is fixed, sorry.)

-----

 I just noticed that on my Opteron cluster, the nodes that are running 64bit
kernels have their clocks ticking at double speed.  This happens with
Linux 2.4.26, and 2.4.27-pre2, compiled with gcc 3.3.3 (Debian 20040401) in=
 a
Debian pure64 chroot. Linux 2.4.25, compiled on Debian Woody + bi-arch gcc
3.3.2 20030908, does _not_ have the problem.  The config options were pretty
much the same for all kernels, and all the kernels are plain vanilla flavour
=66rom www.ca.kernel.org.

 If I run ntpdate to set the clock, then 10 seconds later it will be 10
seconds fast.  Running date(1), the system time advances 20 seconds in 10
seconds of real time.  (I haven't done anything weird with adjtimex(8).)
time sleep 10 takes 5 seconds, but bash reports its real time as 10 seconds.
The timer interrupt counter is increasing at a rate of 200/real second, so
it seems like the system is getting timer interrupts twice as fast as it
should.  (With 2.4.25, it is 100/sec, same as HZ).

 Linux says it is using the PIT and TSC timers.  I have HPET enabled in my
Linux config, but I guess Tyan's S2880 mobo doesn't have one.  This is a
dual-Opteron 240 machine, BTW.

 i386 Linux on the same machines has no problems with timekeeping.  (But I
haven't tested versions later than 2.4.25 in legacy mode.)

 I spent some time poking around the timer code that increments xtime, but I
guess the fact that the timer irqs are coming at double speed indicates that
the problem lies elsewhere.  Maybe the code that sets up the timer?

$ uname -a
Linux node6.cs.dal.ca 2.4.26 #2 SMP Fri May 14 14:46:42 ADT 2004 x86_64 x86=
_64 x86_64 GNU/Linux
$ cat /proc/interrupts
           CPU0       CPU1
  0:    4415908          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 14:      17861          1    IO-APIC-edge  ide0
 19:          0          0   IO-APIC-level  usb-ohci, usb-ohci
 24:     563942          0   IO-APIC-level  eth0
 25:     564331          0   IO-APIC-level  eth1
NMI:      19097      19097
LOC:    2211090    2211095
ERR:          0
MIS:          0

 Only CPU0 is getting the timer interrupt, but at least we know it's not
that both CPUs are getting the timer interrupt.  (Both CPUs get 100 LOC:
(local APIC) interrupts/sec, but that happens on the non-buggy 2.4.25, too.)

 Thanks for any help,
=20
 I'm not subscribed to the lkml, so please CC me on any followups.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQC1AwUBQNCfWgWkmhLkWuRTAQIqOQUAhIeh6XEtih1Ny6wDkCGYNr5AO3GaOOoz
czuwyDw48d3pRzKN8oicEG8iWgN0RfK+XGd1pR2DKxvluUJAVowHNpT+4fxDH+5i
RSrhU9DD5+4GtslETb8mXnkUsLDdLA825LxAHxUeBUoKGUiK+PSfdzGpf7JFfVG8
bFXyT9qxrFKtLhCJdovkBR993R6GwN7J/p4rNwVWutEX68oMHlDzdQ==
=bRn9
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
