Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTGGPEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbTGGPEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:04:10 -0400
Received: from newmail.somanetworks.com ([216.126.67.42]:10136 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S265006AbTGGPEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:04:07 -0400
Date: Mon, 7 Jul 2003 11:18:30 -0400
From: Georg Nikodym <georgn@somanetworks.com>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: possible bug in sbp2/ieee1394_transactions on 2.5.74
Message-Id: <20030707111830.026ad0ad.georgn@somanetworks.com>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: #EE>^U0b8z^y>O0BZ>JJMGXyyxSP?<W-(g1&Yh;2p1'N6AeM]{Zfu(v>Uhe8ptGua4P}`QZ
 m%yb7CYwN^TiGQcP&mncyDrjAtLh7cB|m{$C,ww;yaYi*YvQllxb*vet
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.u051x.QVnSe0Gh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.u051x.QVnSe0Gh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

So I've finally got around to taking the 2.5 plunge (ieee1394
support and reported problems therewith scared me off).

Anyway, I've enabled spin-lock debugging and my messages file is filling
with things like:

Jul  4 22:29:55 keller kernel: Call Trace:
Jul  4 22:29:55 keller kernel:  [__might_sleep+99/112] __might_sleep+0x63/0x70
Jul  4 22:29:55 keller kernel:  [hpsb_get_tlabel+87/452] hpsb_get_tlabel+0x57/0x1c4
Jul  4 22:29:55 keller kernel:  [hpsb_make_writepacket+119/236] hpsb_make_writepacket+0x77/0xec
Jul  4 22:29:55 keller kernel:  [sbp2util_allocate_write_packet+40/84] sbp2util_allocate_write_packet+0x28/0x54
Jul  4 22:29:55 keller kernel:  [sbp2_link_orb_command+80/364] sbp2_link_orb_command+0x50/0x16c
Jul  4 22:29:55 keller kernel:  [sbp2_send_command+194/208] sbp2_send_command+0xc2/0xd0
...

on every access to my FW drive.  Seems to be a result of the:

	down(&tp->count);

in drivers/ieee1394/ieee1394_transactions.c:hpsb_get_tlabel()

For my purposes it's adequate to simply turn off the spin-lock
debugging.

As an aside, if this is a real bug in sbp2, then I'm thinking that Dave
Miller's line of reasoning about mailing lists being superior to bug
databases is flawed.  I've reported this issue once, I've worked around
it and will not be reporting it again (at least until my machine breaks
and I trace the breakage to this particular issue).  Moreover, I won't
be reporting any problems elsewhere in the system that could be caught
by spin-lock debugging.  So while I too detest dealing with bugzilla and
I feel a certain affinity for Miller's position, I can't help but feel
that the status quo is sub-optimal.

-g

--=.u051x.QVnSe0Gh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CY9QoJNnikTddkMRArKQAJ0SNJx2vnIgKyyicJIhE9notMqtDgCgmMjH
eQyvS8uuHIHqakP2hzFyiJc=
=3vHB
-----END PGP SIGNATURE-----

--=.u051x.QVnSe0Gh--
