Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWJFXBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWJFXBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWJFXBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:01:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:16075 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1422723AbWJFXBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:01:21 -0400
X-Sasl-enc: PKwv7ArVa7OkV1K/0wqTO5zqyrEgx+P0dCNR0KSZu/2G 1160175681
Message-ID: <4526E0AC.9070105@imap.cc>
Date: Sat, 07 Oct 2006 01:03:08 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: mingo@elte.hu
Subject: v2.6.19-rc1 regression: printk missing klogd wakeup
References: <72sfz-wa-1@gated-at.bofh.it>
In-Reply-To: <72sfz-wa-1@gated-at.bofh.it>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig988FC63E2C514997B72C7FE2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig988FC63E2C514997B72C7FE2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Unsurprisingly, v2.6.19-rc1 still contains the problem I reported
for v2.6.18-rc1 under the subject "Linux v2.6.18-rc1: printk delays"
and later (unfortunately not before it made it into v2.6.18) tracked
down through bisecting to

[a0f1ccfd8d37457a6d8a9e01acebeefcdfcc306e] lockdep: do not recurse in pri=
ntk

Problem description:
> While X is running, output from printk() appears in syslog (eg.
> /var/log/messages) only after a key is pressed on the system keyboard,
> even though it is visible with dmesg immediately.
(from lkml message <450BF1CC.2070309@imap.cc> - see that message
for further details)

The problem did not exist in 2.6.17, so I think it qualifies as a
regression.

The following naive patch fixes the problem for me, without any
apparent ill effects (ie. the menace of lockup never manifested
itself):

--- a/kernel/printk.c   2006-10-07 00:51:09.000000000 +0200
+++ b/kernel/printk.c   2006-10-07 00:51:41.000000000 +0200
@@ -826,8 +826,7 @@ void release_console_sem(void)
                 * from within the scheduler code, then do not lock
                 * up due to self-recursion:
                 */
-               if (!lockdep_internal())
-                       wake_up_interruptible(&log_wait);
+               wake_up_interruptible(&log_wait);
        }
 }
 EXPORT_SYMBOL(release_console_sem);

But I guess for a proper fix the if() condition should rather be
refined a bit than thrown out completely.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig988FC63E2C514997B72C7FE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFJuC5MdB4Whm86/kRAsSqAJsGRm+Y4fpBkZUAwApazRWK0poMVgCfchTb
zhf2dpWtCVDke2MTymCPIUg=
=B8Lx
-----END PGP SIGNATURE-----

--------------enig988FC63E2C514997B72C7FE2--
