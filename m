Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWJEVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWJEVPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWJEVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:15:47 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:7314 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932201AbWJEVPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:15:45 -0400
Date: Thu, 5 Oct 2006 17:15:44 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-ID: <20061005211543.GA18539@ele.uri.edu>
Mail-Followup-To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 [Linux 2.6.18 sparc64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's a pair of unaligned accesses I found playing with the eth1394 driver:

Kernel unaligned access at TPC[102c8190] ether1394_tx+0xf8/0x600 [eth1394]
Kernel unaligned access at TPC[10162c8c] ether1394_data_handler+0x914/0x100=
0 [eth1394]

The first one I seem to be able to fix by adding a get_unaligned() at
lines 1679-1680 of eth1394.c around eth->h_dest; the second one seems to
be triggered by this code:

(gdb) list *ether1394_data_handler+0x914
0xc94 is in ether1394_data_handler (drivers/ieee1394/eth1394.c:1264).
1259        priv->stats.rx_dropped++;
1260        dev_kfree_skb_any(skb);
1261        goto bad_proto;
1262     }
1263 =20
1264     if (netif_rx(skb) =3D=3D NET_RX_DROP) {
1265        priv->stats.rx_errors++;
1266        priv->stats.rx_dropped++;
1267        goto bad_proto;
1268     }

Unaligned accesses caused by netif_rx seem to have happened before on
mips long ago (according to google). I suspect nobody has ever tried
eth1394 on sparc64 ;-)

eth1394 seems to work fine otherwise, I can plug a firewire hdd and a
laptop with firewire into the sparc and everything works OK. I get
~13MB/sec network throughput from laptop -> sparc (the sparc's CPU is
hitting 100% system time), I suspect it would be a lot faster with the
alignment problem fixed.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFJXX/LYBaX8VDLLURAjRAAKDBM2GaPLb7SLcrDhuEnWsyns5BvQCgmTKF
izn/QuiwNtm17P92bILrU0Y=
=JB9E
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
