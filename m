Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbRFBSkp>; Sat, 2 Jun 2001 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbRFBSke>; Sat, 2 Jun 2001 14:40:34 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:6017 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S262658AbRFBSkW>; Sat, 2 Jun 2001 14:40:22 -0400
Date: Sat, 2 Jun 2001 11:40:13 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] 2.4.5 tulip receive slowdown, possibly highmem related
Message-ID: <Pine.LNX.4.33.0106021001360.16093-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm having a small problem with the tulip driver in 2.4.5 and have
gathered some data on the problem, so I thought I should report:

Intermittently the tulip ethernet interface in one of my machines becomes
very slow, e.g. the ping times to it on the idle local 100BaseT network
jump from 150us to about 300ms.  Executing "ifdown ; ifup" on the
interface resolves the problem until the next time it occurs.  Using
tcpdump on the machine and on another node on the local net (with ntpd
synchronized clocks) shows that the delay occurs while receiving. lspci
identifies the interface as: "Ethernet controller: Lite-On Communications
Inc LNE100TX (rev 20)".

I actually have two machines with similar configurations, but only one
shows the problem:

mf2 (problem): VIA Apollo Pro, PIII-733 x 2,   1GB RAM, LNE100TX rev 20
mf3 (OK):      Intel 440BX,    PIII-700 x 2, 512MB RAM, LNE100TX rev 21

Both machines have the same kernel configuration.

Below is the output of "tulip-diag -aaf -ee -mm".  Specifically, I provide
a unified diff, where the old version is after the problem has occured,
before I reset the interface with "ifdown ; ifup", and the new version is
after I reset the interface.

As the problem is intermittent, I don't have a deterministic way to
trigger it, but it often occurs if I transfer "a lot" through the
interface.  Based on the tulip-diag output, I thought it might be highmem
related, so I tried booting mf2 with mem=896M.  In this configuration, I
have been unable to trigger it, although that is not definitive.

I should disclose that I am presently running MOSIX-1.0.3 on these
machines and that all of the data comes from this MOSIX kernel.  However,
I have experienced this slowdown problem since early 2.4, when I was not
running MOSIX, and I have confirmed that the slowdown problem does occur
under plain 2.4.5 with mem=1G.

I'd be happy to provide any additional information or test any patches.

Cheers,
Wayne


[whitney@mf1 whitney]$ diff -u --unified=1000 /tmp/tulip.diag.{bad,good}.3
--- /tmp/tulip.diag.bad.3	Sat Jun  2 10:00:53 2001
+++ /tmp/tulip.diag.good.3	Sat Jun  2 10:00:53 2001
@@ -1,35 +1,35 @@
 tulip-diag.c:v2.07 3/31/2001 Donald Becker (becker@scyld.com)
  http://www.scyld.com/diag/index.html
 Index #1: Found a Lite-On 82c168 PNIC adapter at 0xb800.
 Lite-On 82c168 PNIC chip registers at 0xb800:
- 0x00: 00008000 01ff0001 10450008 37879000 37879200 026e0010 810c2202 0001fbef
- 0x40: 00000000 00003d8a 37879270 3405685c 00000020 00000000 00000000 10000001
+ 0x00: 00008000 01ff0000 10450008 37879000 37879200 02660010 810c2202 0001fbef
+ 0x40: 00000000 00000000 37879200 378178c0 00000020 00000000 00000000 10000001
  Extended registers:
- 80: 00000000 00000000 00000000 00000000 f0022646 f0022646 00000082 00000082
- a0: 609645e1 609645e1 378790d0 378790d0 3756b054 3756b054 0201f978 0201f978
+ 80: 00000000 00000000 00000000 00000000 f0022646 f0022646 000000bf 000000bf
+ a0: 609645e1 609645e1 378790c0 378790c0 1f168810 1f168810 0201f978 0201f978
  c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  Port selection is MII, full-duplex.
  Transmit started, Receive started, full-duplex.
-  The Rx process state is 'Transferring Rx frame into memory'.
+  The Rx process state is 'Waiting for packets'.
   The Tx process state is 'Idle'.
   The transmit threshold is 128.
  A simplifed EEPROM data table was found.
  The EEPROM does not contain transceiver control information.
 EEPROM contents (64 words):
 0x00:  00c0 f02d 3d8a f002 2646 00f1 0000 a035
 0x08:  0000 0000 0000 0000 0000 0000 0000 0000
 0x10:  0000 0000 0000 0000 0000 0000 0000 0000
 0x18:  0000 0000 0000 0000 0000 0000 0000 0000
 0x20:  0000 0000 0000 0000 0000 0000 0000 0000
 0x28:  0000 0000 0000 0000 0000 0000 0000 0000
 0x30:  0000 0000 0000 0000 0000 0000 0000 0000
 0x38:  0000 0000 0000 0000 0000 0000 0030 0000
  ID block CRC 0xef (vs. 00).
   Full contents CRC 0x7ee5 (read as 0x0000).
  MII PHY found at address 1, status 0x782d.
  MII PHY #1 transceiver registers:
    1100 782d 0302 d008 01e1 45e1 0005 2001
    0000 0000 0000 0000 0000 0000 0000 0000
-   0000 0001 0000 0002 0000 4096 0000 8062
+   0000 0001 0000 0000 0000 003c 0000 8062
    0000 04a1 0000 0000 0039 0000 0000 0000.


