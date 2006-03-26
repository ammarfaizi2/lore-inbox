Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWCZS0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCZS0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCZS0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:26:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:37513 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932105AbWCZS0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:26:16 -0500
X-Authenticated: #2308221
Date: Sun, 26 Mar 2006 20:26:07 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: alsa-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: nm256: register strangeness related to lockups
Message-ID: <20060326182607.GB11408@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi folks,

in the process of analyzing the frequent crashes during the snd-nm256
module insertion I stumbled across the following register values
(reading 32bit words at a time in a loop with pcitweak):

--- nm256-crashes-sometimes	2006-03-26 15:27:32.873773008 +0200
+++ nm256-never-crashed-so-far	2006-03-26 15:27:42.669283864 +0200
@@ -5,7 +5,7 @@
 0x00000000
 0x00000000
 0x20010100
-0x22a0c0c0
+0xa2a0c0c0
 0xfef0fd00
 0xf9f0f800
 0x00000000

This would be in word #7 (starting from 0), 0010 0010 vs. 1010 0010. I
tried to write back the "safer" values to the chip, but reading them
back sometimes showed that the write had failed, probably due to the
registers being locked.

I'd very much like to do the "correction" in the driver itself, and
maybe have it tested on other laptops as well - I have only a Dell
Latitude CPiA (NM2200) for that purpose, and no other incarnation of the
neomagic chip at hand. Also, for starters it would be very interesting
to see similar dumps on other machines, to see if the difference between
working and hardlocking is the same.


Some lspci output for reference:

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 20)
01:00.1 Multimedia audio controller: Neomagic Corporation NM2200 [MagicMedia 256AV Audio] (rev 20)


01:00.0 0300: 10c8:0005 (rev 20)
	Subsystem: 1028:0088
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f9000000 (32-bit, prefetchable) [size=16M]
	Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
	Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
00: c8 10 05 00 07 00 90 02 20 00 00 03 00 20 80 00
10: 08 00 00 f9 00 00 c0 fd 00 00 b0 fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 0401: 10c8:8005 (rev 20)
	Subsystem: 1028:0088
	Flags: medium devsel, IRQ 5
	Memory at f8c00000 (32-bit, prefetchable) [size=4M]
	Memory at fda00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
00: c8 10 05 80 02 00 90 02 20 00 01 04 00 00 80 00
10: 08 00 c0 f8 00 00 a0 fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


(was taken while actually playing sound - guess I should take a dump
every time I am about to insert the module and look for differences...)

I am currently stuck here, so any hint would be appreciated : )


Kind regards,
Chris

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCbcvV2m8MprmeOlAQI6dg/9GLjRRBF0psnExBeNowdwI0sIEZwlWnmS
FZoTeAr3AuA88kGl58bF0tD8z0GQfTrKPv+ajTNOYU1or0B0kfvXhTGX5i/E3CLT
o8qQelDRhnUHScCLMT9I8o4P/90qaab0TcQHntY9ZpoDG4G7wWqgo8aFV26IQ8gn
Y4dSGXf5CxgifypRx3Y/fNRXmwxJkaPKNFwihI9iwssRmhlqg6NDT2DH6ryyDtfv
Ls1vswVI5YufFkCgl+Zzxk2ENoLjPu3r46SkzrCtVenug2I4wcByw43DJCU6oFD7
t1Am759qZGxHHTViVDFH9Tkyc0JEl11r83cIOTH6nt8tcSYOXCCUcEa9xMphsyrB
iuOckGVUnjfn04F1mUXA71/b4wLyZFTTCyBbfnj9jJaExrDE64veKImWB41vc/YL
zBWXS3cKw4ARhoOKFuDiuRA6N377yRxGR5qJLTxhr3rS9cDEzxYDm5W0d+7DBLX5
foIjUojRbOQfURxvvcHm4PGtJc1JLS+STS+d1TE+wykmS03BBH3TzXi1BgF4JCwp
UyN36zlZzVZ9iUpWMLRgcdLsXtDc0t8EUbjAmRaB8NR0VgxYWtcFCirGkcs7jzDM
OwY7lyTkfJm39yK6GUXPE4TxhXtipY1nZgzM710eZN4xnTzRDqQKvT36VCL9LSbZ
qqTejSijlqg=
=W8pr
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

