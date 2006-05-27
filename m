Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWE0J7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWE0J7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 05:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWE0J7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 05:59:52 -0400
Received: from mail.gmx.net ([213.165.64.21]:16597 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750736AbWE0J7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 05:59:52 -0400
X-Authenticated: #2308221
Date: Sat, 27 May 2006 11:59:40 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: tracking Fn key events
Message-ID: <20060527095939.GA10105@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi all,

could it be possible to track the Fn key on laptops in a generic way, so
I might notify a driver to read back register values, ie. on key
release? I'd like to do this in the driver itself, because the issues at
hand are very specific to the NeoMagic framebuffer driver implementation
and its interaction with the hardware.

The clean alternative of course would be sysfs attributes, but so far I
could not find ways to tap Fn key events from user space. OTOH, it seems
strange to me that one might need some sort of daemon running to render
a display driver functional. So here lies my dilemma in the first place:
the beast should be self-contained IMHO, but more than a sh*tload of
hacks in the end.


This is what I intend to achieve: the neofb driver has issues with
reading and writing to registers, such as the backlight status bits.

Until I made the driver re-read the register values in question, the
thing used to restore previous display configuration (combination of
internal/external) upon unblanking the display through the usual console
blanking mechanisms. Now the driver stores the values read during screen
blanking, avoiding the reset to whichever configuration was active
during neofb initialization.

Now the following problem arises: once I shut the LID, the hardware or
firmware turns off the backlight, which is somewhat sensible. A few
minutes later, the console code decides it is time to blank the screen,
reading back the (now bogus) values. Once the LID is re-opened, the
display comes back to life, but after the first key stroke the console
is "un-blanked" and the backlight set to "off". The problem can be
solved by shutting and opening the LID once more, abusing whatever
mechanism is designed into the hardware/firmware combo.

The quick and dirty fix I tried was to use acpid for handling LID events
such that it should disable/enable console blanking via setterm calls.
Needless to say, this did not work out as expected and would be not
quite acceptable if the driver is expected to be self-contained.

My favourite solution would be wiretapping the Fn key, sending the neofb
driver an event whenever it is _released_. After a minimal timeout, the
register values should have changed underneath and neofb could read back
the values, thus properly accounting for any changes therein.

Any hints appreciated!

Kind regards,
Chris

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHgjCl2m8MprmeOlAQIABg/+PS4D04Nn/4a6y94TUeZkvfYPyLJX3OXI
V01P3lV70Nks3JJAW/EJnD+RpI1HaO1mLhrxCBR82lum85XWP5mTdBqSQtYI/YNV
0ns9OdLQlioXm+0egInTQdLq6MHzJ+4iLpzwLV7N9pvnuJASXfGIF/7bj7iVVeUj
2rnB1VEh+X3jkTOnLZlNRM4Zyuai1t1jqF/BZ0cXvEV09dNlRMyodDnYJIo3ih5T
BeG6eZYnvnOreDFEmKMTYtzFDEqAUk71EAWppXAsnpkQR0LjuvmBGS+2u+5CY0qf
Ql1iSUyDRKCIvSlZC+qCxwAjz259hBAZT7GiyJrqZZk/gYFoo+WKpQD4qGTm4fNv
O1U7CKlySgMUCcLaQ5PPOkPj+eDXhKG90jiFSNpDFLCh/osKMK30JmjtF8mofDlv
4kN5G1/q+Nr+I8T822+gQ2l6xzV7Zzc436+t75WhMl+ywNrbg+sUd5KNY6fHaikB
p9FbjtaG3dCRqllt0VUC0BrIcpLQiGPDxcNwlgB2F+Hs7Y1e6YB6/vaqQgJ3Kcdh
0520bDvBeA6vRFhg7a+C8bWPeyiGt7Qv5AGTUEj5/24aSmYyefxEM0BN1gFM2lJn
oskLNyUfNBsfvgKToB81mXoqImlq6G+l9EzFA453fnAmQmsNiD+7ORlOxNtUZolI
v4ailpbPjqw=
=iqyw
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

