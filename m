Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVKUSC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVKUSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKUSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:02:27 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:6074 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932416AbVKUSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:02:26 -0500
Date: Mon, 21 Nov 2005 19:02:24 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14] bug in inet_connection_sock.c -> lowest port always skipped
Message-ID: <20051121180224.GY32512@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Nov 22 11:39:23 CET 2005
X-Message-Flag: Want to extend your PGP web-of-trust? Coordinate a key-signing
	at www.biglumber.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

There seems to be a small bug in inet_connection_sock.c: the lowest port
set using sysctl (taken from 'sysctl_local_port_range') is always
skipped in the first iteration.
In inet_csk_get_port one can find this:
                if (hashinfo->port_rover < low)
                        rover = low;
                else
                        rover = hashinfo->port_rover;
                do {
                        rover++;
As you can see the first statement is a ++ causing the first port to
always be skipped.
Patch fixing this follows below.

Signed off: Folkert van Heusden <folkert@vanheusden.com>

diff -uNbB inet_connection_sock.c.org inet_connection_sock.c
- --- inet_connection_sock.c.org  2005-11-21 18:52:24.000000000 +0100
+++ inet_connection_sock.c      2005-11-21 18:53:43.000000000 +0100
@@ -86,7 +86,6 @@
                else
                        rover = hashinfo->port_rover;
                do {
- -                       rover++;
                        if (rover > high)
                                rover = low;
                        head = &hashinfo->bhash[inet_bhashfn(rover, hashinfo->bhash_size)];
@@ -97,6 +96,7 @@
                        break;
                next:
                        spin_unlock(&head->lock);
+                       rover++;
                } while (--remaining > 0);
                hashinfo->port_rover = rover;
                spin_unlock(&hashinfo->portalloc_lock);


Folkert van Heusden

- -- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
- ----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
- ----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkOCC7A8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuqb0AniaoetnQ
NwtInW+Af7nEsTxXCraBAJ9xU15UVTg3RIewulXU2kFLr9viFQ==
=bJdc
-----END PGP SIGNATURE-----
