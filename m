Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUCATn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCATn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:43:28 -0500
Received: from 68-184-155-122.cpe.ga.charter.com ([68.184.155.122]:62884 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261411AbUCATnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:43:20 -0500
Date: Mon, 1 Mar 2004 14:43:18 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with Tulip and 3Com
Message-ID: <20040301194318.GE14688@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I sent this to the Tulip-bug =E6mail list but I haven't gotten any replies
yet.  This is affecting production machines so I'm having to expand my
search for information:


I'm running a number of servers with DLINK Quad port network cards which use
the tulip driver as well as a 3c905C.  Since kernel 2.4.21 I've had a probl=
em
with what appears to be eth2.  Once the machine is up and running for some
period of time which is greater than 5 mins but less than 48 hours the mach=
ine
generates alot of errors:

NETDEV WATCHDOG: eth2: transmit timed out
NETDEV WATCHDOG: eth2: transmit timed out
NETDEV WATCHDOG: eth2: transmit timed out
NETDEV WATCHDOG: eth2: transmit timed out
NETDEV WATCHDOG: eth2: transmit timed out


root@server1:~# grep eth /var/log/dmesg
eth0: Digital DS21143 Tulip rev 65 at 0x2000, 00:80:C8:CD:38:95, IRQ 17.
eth1: Digital DS21143 Tulip rev 65 at 0x2080, 00:80:C8:CD:38:96, IRQ 18.
eth2: Digital DS21143 Tulip rev 65 at 0x2400, 00:80:C8:CD:38:97, IRQ 19.
eth3: Digital DS21143 Tulip rev 65 at 0x2480, 00:80:C8:CD:38:98, IRQ 16.
root@server1:~# grep -i 3com /var/log/dmesg
03:08.0: 3Com PCI 3c905C Tornado at 0x3000. Vers LK1.1.18-ac

One thing we noticed was that the 3Com is also at IRQ19 with eth2:

eth2      Link encap:Ethernet  HWaddr 00:80:C8:CD:38:97
          inet addr:69.25.0.87  Bcast:69.25.0.127  Mask:255.255.255.192
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:110307 errors:1 dropped:2391 overruns:0 frame:0
          TX packets:876 errors:144 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:119398948 (113.8 MiB)  TX bytes:155474 (151.8 KiB)
          Interrupt:19 Base address:0x2400


eth4      Link encap:Ethernet  HWaddr 00:E0:81:23:56:7A
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:19 Base address:0x3000



We found the tulip diag program which gives some errors on Index 3:
  The Rx process state is 'Suspended -- no Rx buffers'.
 Interrupt sources are pending!  CSR5 is f06981c7.

(Full output at the bottom of the email)


At this point eth0,eth1, and eth2 are up and online.  A co-worker did an
ifup on eth4, ifdown eth2 ifup eth2 and the machine panic'd.  =DEere is a
stack dump:

root@server1:/proc# ifconfig eth4 up
root@server1:/proc# ifconfig eth2 down
root@server1:/proc# ifconfig eth2 up

11:21:42 server1 kernel: Unable to handle kernel NULL pointer dereference a=
t virtual address 00000000
11:21:42 server1 kernel: printing eip:
11:21:42 server1 kernel: c011ff33
11:21:42 server1 kernel: *pde =3D 00000000
11:21:42 server1 kernel: Oops: 0000
11:21:42 server1 kernel: CPU: 1
11:21:42 server1 kernel: EIP: 0010:[timer_bh+527/1020] Not tainted
11:21:42 server1 kernel: EFLAGS: 00010086
11:21:42 server1 kernel: eax: c0583484 ebx: c0583294 ecx: c0583484 edx: 000=
00000
11:21:42 server1 kernel: esi: c04c5e74 edi: c0583260 ebp: 00000000 esp: c1c=
17ef0
11:21:42 server1 kernel: ds: 0018 es: 0018 ss: 0018
11:21:42 server1 kernel: Process swapper (pid: 0.  stackpage=3Dc1c17000)
11:21:42 server1 kernel: Stack: c05827e0 00000020 00000000 c05826e0 000b060=
0 00000000 000b0600 00000004
11:21:42 server1 kernel: 00000001 c1c17f14 c1c17f14 c011c30c c011c1f3 00000=
000 c056d580 00000001
11:21:42 server1 kernel: fffffffe c05826e8 c011bf7d c056d580 c05826e0 c056b=
000 00000000 c1c17f70
11:21:42 server1 kernel: Call Trace: [bh_action+68/124] [tasklet_hi_action+=
103/160] [do_softirq+125/220] [do_IRQ+226/244] [amd76x_smp_idle+0/196]
11:21:42 server1 kernel: [amd76x_smp_idle+0/196] [amd76x_smp_idle+8/196] [c=
pu_idle+62/84] [release_console_sem+147/152] [printk+294/320]
11:21:42 server1 kernel: Code: 8b 02 89 48 04 89 01 89 51 04 89 0a 89 f1 39=
 d9 0f 85 37 ff
11:21:42 server1 kernel: <0>Kernel panic: Aiee. killing interrupt handler!


If we can get the machine online (it's in another city) I'll try and run
this through the ksymoops.

Any ideas?
  Robert


tulip-diag.c:v2.18 11/12/2003 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0x2000.
 * A potential Tulip chip has been found, but it appears to be active.
 * Either shutdown the network, or use the '-f' flag to see all values.
Digital DS21143 Tulip chip registers at 0x2000:
 0x00: f8a08000 ffffffff ffffffff 37e7e000 37e7e200 f0660000 b20e2202
fbfffbff
 Port selection is MII, full-duplex.
 Transmit started, Receive started.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 128.
  The NWay status register is 000000c6.
Index #2: Found a Digital DS21143 Tulip adapter at 0x2080.
 * A potential Tulip chip has been found, but it appears to be active.
 * Either shutdown the network, or use the '-f' flag to see all values.
Digital DS21143 Tulip chip registers at 0x2080:
 0x00: f8a08000 ffffffff ffffffff 37e7b000 37e7b200 f0660000 b20e2202
fbfffbff
 Port selection is MII, full-duplex.
 Transmit started, Receive started.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 128.
  The NWay status register is 000000c6.
Index #3: Found a Digital DS21143 Tulip adapter at 0x2400.
 * A potential Tulip chip has been found, but it appears to be active.
 * Either shutdown the network, or use the '-f' flag to see all values.
Digital DS21143 Tulip chip registers at 0x2400:
 0x00: f8a08000 ffffffff ffffffff 37e7a000 37e7a200 f06981c7 b20e2202
fbfffbff
 Port selection is MII, full-duplex.
 Transmit started, Receive started.
  The Rx process state is 'Suspended -- no Rx buffers'.
  The Tx process state is 'Idle'.
  The transmit threshold is 128.
 Interrupt sources are pending!  CSR5 is f06981c7.
   Tx done indication.
   Tx complete indication.
   Tx out of buffers indication.
   Rx Done indication.
   Receiver out of buffers indication.
   Receiver stopped indication.
  The NWay status register is 000000c6.
Index #4: Found a Digital DS21143 Tulip adapter at 0x2480.
Digital DS21143 Tulip chip registers at 0x2480:
 0x00: f8000000 ffffffff ffffffff bef7ffff f4bfffff f0000000 b20e0000
f3fe0000
 0x40: e0000000 fffd83ff ffffffff 00000000 000000c6 ffff0000 fff80000
8ff0c000
 Port selection is MII, half-duplex.
 Transmit stopped, Receive stopped.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 128.
  The NWay status register is 000000c6.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 1186, device 1112.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:80:C8:CD:38:98.
EEPROM transceiver/media description table.
Leaf node at offset 30, default media type 0800 (Autosense).
 1 transceiver description blocks:
  Media MII, block type 3, length 13.
   MII interface PHY 0 (media type 11).
   21143 MII initialization sequence is 0 words:.
   21143 MII reset sequence is 0 words:.
    Media capabilities are 7800, advertising 01e1.
    Full-duplex map 5000, Threshold map 1800.
    No MII interrupt.
 MII PHY found at address 1, status 0x7849.
 MII PHY #1 transceiver registers:
   1000 7849 2000 5c10 01e1 0000 0004 2001
   0000 0000 0000 0000 0000 0000 0000 0000
   0200 0000 0000 0000 0000 0000 0020 0000
   0000 0001 002b 0100 0006 0f00 0000 0000.
  Internal autonegotiation state is 'Autonegotiation disabled'.




:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.





--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQ5JW8+1vMONE2jsRAnmgAKCjM9KRQT+Vo6o0yrYInHRpQ788NQCcDVfM
1JAOQLJLLvHINPn3tjf0YK0=
=tLaa
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
