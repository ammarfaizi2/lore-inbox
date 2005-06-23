Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVFWSwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVFWSwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVFWStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:49:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263034AbVFWSjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:39:51 -0400
Date: Thu, 23 Jun 2005 14:39:26 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: wensong@linux-vs.org, ja@ssi.bg, nhorman@redhat.com, akpm@osdl.org
Subject: [Patch] ipvs: close race conditions on ip_vs_conn_tab list modification
Message-ID: <20050623183926.GI16783@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello there-
	Patch to close a race condition in ip_vs_conn_flush.  In an smp system,
it is possible for an connection timer to expire, calling ip_vs_conn_expire
while the connection table is being flushed, before ct_write_lock_bh is
acquired.  Since the list iterator loop in ip_vs_con_flush releases and
re-acquires the spinlock (even though it doesn't re-enable softirqs), it is
possible for the expiration function to modify the connection list, while i=
t is
being traversed in ip_vs_conn_flush.  The result is that the next pointer g=
ets
set to NULL, and subsequently dereferenced, resulting in an oops.  This pat=
ch
removes the lock release and re-aquisition from the loop, closing the race
window.  Tested by myself, and those who origionally experienced the crash =
and
reported it to me, with successful results.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 ip_vs_conn.c |    2 --
 1 files changed, 2 deletions(-)

=20
--- linux-2.6.git/net/ipv4/ipvs/ip_vs_conn.c.orig	2005-06-23 13:11:00.91037=
2471 -0400
+++ linux-2.6.git/net/ipv4/ipvs/ip_vs_conn.c	2005-06-23 13:15:54.459852393 =
-0400
@@ -840,7 +838,6 @@
=20
 		list_for_each_entry(cp, &ip_vs_conn_tab[idx], c_list) {
 			atomic_inc(&cp->refcnt);
-			ct_write_unlock(idx);
=20
 			if ((ct =3D cp->control))
 				atomic_inc(&ct->refcnt);
@@ -850,7 +847,6 @@
 				IP_VS_DBG(4, "del conn template\n");
 				ip_vs_conn_expire_now(ct);
 			}
-			ct_write_lock(idx);
 		}
 		ct_write_unlock_bh(idx);
 	}
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCuwHeM+bEoZKnT6ERAizhAKCHXiISMEUtbuw3uNWa5q5VLLsEiACfQuc3
iO6vT27Cm1wggTODrRpeSzo=
=BsQ/
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
