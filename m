Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVHYQzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVHYQzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHYQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:55:49 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:58271 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751196AbVHYQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:55:48 -0400
Date: Thu, 25 Aug 2005 18:55:50 +0200
From: Harald Welte <laforge@netfilter.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: oops in 2.6.13-rc6-git12 in tcp/netfilter routines
Message-ID: <20050825165550.GC4442@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Alessandro Suardi <alessandro.suardi@gmail.com>, netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netfilter-devel@lists.netfilter.org
References: <5a4c581d05082506395fa984ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KLINyTCByxgMLuN/"
Content-Disposition: inline
In-Reply-To: <5a4c581d05082506395fa984ae@mail.gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KLINyTCByxgMLuN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2005 at 03:39:02PM +0200, Alessandro Suardi wrote:
> Howdy, and excuse me for crossposting - feel free to zap CC to
>  unrelated, if any, mailing lists.
>=20
>   just gave PeerGuardian a spin on my eDonkey home box and
>   said box didn't last half a day before oopsing in netlink/nf/tcp
>   related routines (or so it seems to my untrained eye).

Yes, it indeed could be that there is some fishy interaction between the
tcp stack and ip_queue causing the oops.=20

> K7800, 256MB RAM, uptodate FC3 running 2.6.13-rc6-git12,
>  doing nothing but running MetaMachine's eDonkey 1.4.3 QT gui.
> PeerGuardian is the 1.5 beta version available from methlabs.org.

Is it true that PeerGuardian is a proprietary application?  I'm not
going to debug this problem using a proprietary ip_queue program, sorry.

If you can produce a testcase with open source userspace ip_queue code,
I could look into reproducing the problem locally and debugging the
problem more thoroughly.

While it definitely is a kernel bug (whatever userspace sends should not
crash the kernel), it might be something that specifically [only]
PeerGuardian does to the packet.  Something that ip_queue doesn't check
(but should check) on packet reinjection and therefore upsets the TCP stack.

Also helpful would be the output of an "strace -f -x -s65535 -e
trace=3Dsendmsg" on the PeerGuardian (daemon?) process.


> [<c0103714>] die+0xe4/0x170
> [<c010381f>] do_trap+0x7f/0xc0
> [<c0103b33>] do_invalid_op+0xa3/0xb0
> [<c0102faf>] error_code+0x4f/0x54
> [<c02eb05b>] kfree_skbmem+0xb/0x20
> [<c02eb0cf>] __kfree_skb+0x5f/0xf0

ok, so something down the chain from kfree_skb() results in an invalid
operation? looks more like some compiler problem, bad memory or memory
corruption to me.  Try to reproduce the problem without PG.

> [<c031304a>] tcp_clean_rtx_queue+0x16a/0x470
> [<c0313746>] tcp_ack+0xf6/0x360
> [<c0315d57>] tcp_rcv_established+0x277/0x7a0
> [<c031eba0>] tcp_v4_do_rcv+0xf0/0x110
> [<c031f2a0>] tcp_v4_rcv+0x6e0/0x820
> [<c0305594>] ip_local_deliver_finish+0x84/0x160

so something in the tcp stack ends up doing tcp_clean_rtx_queue()

> [<c02fbe4a>] nf_reinject+0x13a/0x1c0
> [<c033f0d8>] ipq_issue_verdict+0x28/0x40
> [<c033f968>] ipq_set_verdict+0x48/0x70

ip_queue reinjects a packet via nf_reinject()

> [<c033fa79>] ipq_receive_peer+0x39/0x50
> [<c033fc72>] ipq_receive_sk+0x172/0x190

ip_queue receives and ipq verdict msg packet from netlink

> [<c02fffa5>] netlink_data_ready+0x35/0x60
> [<c02ff4a4>] netlink_sendskb+0x24/0x60
> [<c02ff657>] netlink_unicast+0x127/0x160
> [<c02ffcc4>] netlink_sendmsg+0x204/0x2b0
> [<c02e6dc0>] sock_sendmsg+0xb0/0xe0
> [<c02e83f4>] sys_sendmsg+0x134/0x240
> [<c02e88e4>] sys_socketcall+0x224/0x230
> [<c0102d3b>] sysenter_past_esp+0x54/0x75

process sendmsg()s on the netlink socket.
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--KLINyTCByxgMLuN/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDfgWXaXGVTD0i/8RAlKWAKCLPpvWL8TMiA/7tYlD1ETKeUQZtACgnfKI
2/nlXN2NSODp8oF33ZBm7pw=
=cPuj
-----END PGP SIGNATURE-----

--KLINyTCByxgMLuN/--
