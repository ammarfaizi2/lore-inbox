Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWGAJzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWGAJzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGAJzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:55:44 -0400
Received: from lug-owl.de ([195.71.106.12]:42434 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S964849AbWGAJzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:55:43 -0400
Date: Sat, 1 Jul 2006 11:55:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Congjun Yang <congjuny@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard raw mode
Message-ID: <20060701095541.GO26883@lug-owl.de>
Mail-Followup-To: Congjun Yang <congjuny@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20060701050023.31696.qmail@web32009.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d5xRKMqY7hkGAt+u"
Content-Disposition: inline
In-Reply-To: <20060701050023.31696.qmail@web32009.mail.mud.yahoo.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d5xRKMqY7hkGAt+u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-30 22:00:23 -0700, Congjun Yang <congjuny@yahoo.com> wrote:
> The keyboard worked fine with kernel 2.4.7. If I put
> the keyboard in raw mode, I can receive the sequence
> "1d 9d 9d". A simple test can be done with "showkey
> -s". However, newer kernels seem to treat the second
> break code as a hardware error, which in my case it's
> not, and simply discard it.

This is because the whole user input handling was reworked in the mean
time.

For keyboards, things are like this:

  * A low-level port driver implements a serial endpoint. For PCs,
    this are the keyboard and aux channel of the keyboard controller
    i8240. These are called serio ports.
  * Protocol drivers can be hooked up to these serio ports and
    communicate with the actual hardware. This is eg. a driver for AT
    keyboards or a PS2 mouse.
  * All protocol drivers (eg. the atkbd driver) will *never* ever
    stuff the raw I/O anywhere. They interpret the stream and push
    commonly used values into Linux's Input API. That is, if you press
    the "A" button on *any* keyboard, all drivers will issue a KEY_A
    event and never ever tell about the specific raw keycodes
    received.
  * If you talk to the old /dev/psaux interface, of if you use the raw
    mode for keyboard reading, then the formerly issued KEY_A event is
    translated back to the raw sequence. Of course, non-recognized
    events (like two break codes) cannot be emulated, so this doesn't
    work at all.

> While it's necessary to have a work around for certain
> hardwares that tender to produce such errors, but why
> would the fix be done at "raw" level? In raw mode, I
> would expect to receive whatever is generated from the
> keyboard, including possibly errors. If I decide to
> put the keyboard in raw mode, I assume the
> responsibility of handling raw data.

There's no direct raw level anymore; it's the result of emulation
these days.

There are two solutions:

  * Throw away the atkbd driver. That means there's no more a
    "keyboard" from the system point of view. Write a small daemon
    that uses the serio_raw driver to get the raw I/O coming from the
    keyboard and make it interpret it. Don't forget to also do atkbd's
    work and parse the "normal" keyboard I/O, too, and issue the KEY_A
    (and all the other) events to the kernel using the uinput driver.
  * Write a filter driver for your keyboard. (Actually, write two.)
    I've done that some time ago, with some luck you'll find it. If
    not, that's probably lost (was just a test:-)
    Such a driver is both, a protocol driver and a serio driver. As a
    protocol driver, it accesses a serio port and relays the read data
    to a second driver (which should in your case parse the MSR data
    and relay it to some userland applications). Anything that's not
    specific to the POS functions (non-standard beeps, MSC, barcode
    scanner, background light, LCD display, ...) should be given back
    to the first driver, which (serio half) also registers a new serio
    port to be useable by atkbd.

I'm not sure what the best variant is. The first one is a bit easier
to implement, but if you fsck up your daemon, you no longer have a
keyboard:-)  The second one is a bit harder to implement, but you can
reuse the atkbd driver. As I said, that was already written once and
proved to work.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--d5xRKMqY7hkGAt+u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEpkadHb1edYOZ4bsRAuPFAJ43K13Rsx2kLM/VhuxU26wL5FYGLgCeLdX4
A3SQ5/kab6+mrRS5MM8aXUQ=
=FicK
-----END PGP SIGNATURE-----

--d5xRKMqY7hkGAt+u--
