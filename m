Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSJUWNd>; Mon, 21 Oct 2002 18:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJUWNd>; Mon, 21 Oct 2002 18:13:33 -0400
Received: from cpe-66-1-217-65.fl.sprintbbd.net ([66.1.217.65]:63244 "EHLO
	chef.linux-wlan.com") by vger.kernel.org with ESMTP
	id <S261714AbSJUWNa>; Mon, 21 Oct 2002 18:13:30 -0400
Date: Mon, 21 Oct 2002 18:19:36 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] New ARPHRD types
Message-ID: <20021021221936.GA32390@linux-wlan.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch for include/linux/if_arp.h, which adds two new=20
ARPHRD types, ARPHRD_IEEE80211_FULL and ARPHRD_IEEE80211_CAPTURE.

This patch is against 2.4.20-pre8, but it should also go into 2.5.x as
well, assuming I'm not flamed into oblivion..

A bit of explanation.  First, _FULL:

IEEE 802.11 has a variable "hardware" header length, 24 bytes for most
frames but 30 bytes for others.  This poses a problem if you want to
expose a native 802.11 netdev interface to the OS, as =20
netdev->hardhdr_len et.al. aren't variable.

But wait, isn't there already ARPHRD_IEEE80211? Yes, but unfortunately,
common usage of this type assumes 24-byte headers.  So if we break this
assumption, we break backwards compatibility with existing apps.
Remember this is intended for a native 802.11 netdev, and plenty of
stuff uses PF_PACKET sockets on these interfaces expecting packets to
come and go a certian way.  For Rx frames we can play games with the
skb->mac.raw pointer, but this won't do for Tx frames.

Onto the _CAPTURE type.

(See http://www.shaftnet.org/~pizza/software/capturefrm.txt for the
 longwinded version including the header format)

"The original header format for 'monitor mode' or capturing frames was
 a considerable hack.  The document covers a redesign of that format."

That "considerable hack" is ARPHRD_IEEE80211_PRISM, which has since come
to be used by many other drivers in lieu of a better way to do things.=20
Unfortunately, there is no version field in the old format, so for the
sake of making a clean break we'd like to get a new ARP type defined for
it.

This new header is non-hardware specific and has many more useful
fields, as well as the removal of a lot of cruft.  And there's now
version and length fields, so we can expand on this format cleanly in
the future and not bother you guys with new ARPHRD types.  :)

=2E..

Nothing in the wild is currently using either of these types, but that
will change RSN.. and I can't push patches to libpcap&ethereal until the
ARP types are in the kernel and therefore fixed.  :)

 - Pizza
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
715-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="newarp.patch"
Content-Transfer-Encoding: quoted-printable

--- /usr/src/linux/include/linux/if_arp.h	Mon Oct 14 14:16:29 2002
+++ if_arp.h	Mon Oct 21 17:47:29 2002
@@ -83,6 +83,8 @@
 #define ARPHRD_IEEE802_TR 800		/* Magic type ident for TR	*/
 #define ARPHRD_IEEE80211 801		/* IEEE 802.11			*/
 #define ARPHRD_IEEE80211_PRISM 802	/* IEEE 802.11 + Prism2 header  */
+#define ARPHRD_IEEE80211_FULL  803	/* IEEE 802.11 w/ fixed headerlen */
+#define ARPHRD_IEEE80211_CAPTURE 804	/* IEEE 802.11 w/ new capture header =
*/
=20
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
=20

--+HP7ph2BbKc20aGI--

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tH14gW9b/nAvdc4RAt9JAJ9SgYQNsAffnEwWpNsonJnhSRgxJwCdFPDc
huBzJHY+E0CozccWH89IAc4=
=w16p
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
