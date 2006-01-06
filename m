Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWAFQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWAFQEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWAFQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:04:20 -0500
Received: from melchior.nerv-un.net ([216.179.125.34]:1805 "EHLO nerv-un.net")
	by vger.kernel.org with ESMTP id S1751027AbWAFQET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:04:19 -0500
Date: Fri, 6 Jan 2006 11:04:16 -0500
From: Mike Kershaw <dragorn@kismetwireless.net>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Message-ID: <20060106160415.GJ5878@DRD1812.marist.edu>
Reply-To: Mike Kershaw <dragorn@kismetwireless.net>
References: <1136541243.4037.18.camel@localhost> <200601061200.59376.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
In-Reply-To: <200601061200.59376.mbuesch@freenet.de>
Organization: Kismet Wireless
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> So, now we asked: How would a sane UI look like. We had a few points:
> * The interface needs to support some kind of "master" interface to
> configure the hardware, 80211 parameters and
> to actually configure and setup the
> * Virtual interfaces.
> Data is transferred only though the virtual interfaces, which could
> be an AP interface, a STA interface in INFRA or Ad-Hoc mode, etc... .
> Configuration is done though the master interface.

Two things to inject, from my own little corner of userspace: =20

1.  Monitor mode formatting. =20

I ported over the BSD radiotap packet header system, it's in the Intel
and I beleive some versions of the Devicescape stacks.  Using these
would be a very good thing for userspace.  If for some reason it isn't
used, then we (userspace tool people) need something equivalent.  I like
radiotap primarily because:
 * Dynamic per-packet stats.  Drivers provide what their firmware is
   capable of providing per frame.  The more info provided the better.
 * Expandable headers.  New per-frame stats can be added into the RT
   headers without changing linktype, breaking existing apps, etc.
 * Format indicators.  Is the 4 byte FCS tacked onto the end of the
   frame in rfmon?  If we don't know this in userspace, we can't do
   802.11 validation, wep decoding, and other important stuff.
   Userspace shouldn't have to know which driver is being used, this
   ought to be in the frame headers.

Radiotap provides all of those and is already supported by tcpdump,
ethereal, kismet, etc.

2. RFMon is weird/breaks interfaces
The other gotcha with rfmon is it often breaks a cards ability to
associate (though less often with new cards).  Even if it doesn't,
whatever tool put it into rfmon is likely to want to take control of the
channel hopping, which will interfere with the associations of other
virtual interfaces.

Currently single-interface cards (ethX, whatever) thrown into rfmon just
plain break, it a pretty obvious way.  The linktype changes, traffic
stops, and users more or less understand this is going to be the
behavior.  Once virtual interfaces come into play, it may cause some
confusion if you can make virtual interfaces that do sta, adhoc, ap all
at once without conflicting, and suddenly bringing up an rfmon
interfaces causes them all to break.

I don't know if the solution to this is a warning, marking non-rfmon
virtual interfaces down, or just saying "they'll figure it out", but I
figured it's worth considering at an early stage.

-m

--=20
Mike Kershaw/Dragorn <dragorn@kismetwireless.net>
GPG Fingerprint: 3546 89DF 3C9D ED80 3381  A661 D7B2 8822 738B BDB1

<>!*''#                 Waka waka bang splat tick tick hash
^@`$$-                  Caret at back-tick dollar dollar dash,
!*'$_                   Bang splat tick dollar under-score,
%*<>#4                  Percent splat waka waka number four,
&)../                   Ampersand right-paren dot dot slash,
|{~~SYSTEM HALTED       Vertical-bar curly-bracket tilde tilde CRASH.


--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDvpT/17KIInOLvbERAv3EAJ4/DV2aWjtQW5te+YCSvbGGRsiKmwCePsf3
nWUzqkbc2nSLyRf/oxkvSFQ=
=v21E
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
