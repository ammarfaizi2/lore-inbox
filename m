Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWGCUkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWGCUkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWGCUkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:40:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:336 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751104AbWGCUkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:40:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=delzKbkYNcZuqpkbUTAsBrpvgoJCxeOajXj5fekKwmzp3i0pPfZYC/kDXX/nzLHfmBJbtaTi6bPzgARpH+3FQVkcvSW9Jwk4I8YJmzgfBPVT5lfuwicX8fEzIurEr/S+phaUauaI8wCf5/DnWxSnREm9PmjXN4AdEN9DSQ2oZ7Q=
Date: Mon, 3 Jul 2006 16:39:58 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems porting asus_acpi to LED subsystem
Message-ID: <20060703203958.GA8093@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Summary:

I'm trying to link asus_acpi into the LED subsystem.  My set_brightness
callback evaluates an ACPI method to set the LED state.  It works fine
manually changing the brightness, but when the callback is called by a
timer (using the timer or ide-disk triggers), it eventually causes an
Oops.  I can post my code or the Oops if it would help.  I'm new at
kernel coding, and I'm not on the list, so please CC me on any reply.
Sorry if this isn't appropriate on the list.

Long version:

I have an Asus laptop with two LED's that are supported by the asus_acpi
driver, and I'm trying to link the asus_acpi driver's LED features
(currently available only with a /proc interface) into the new LED
subsystem.

I tried to do this, by registering two LED devices with the LED
subsystem when the asus_acpi device is created.  This works, and the LED
devices show up in /sys/class/leds/.  I can change the brightness by
hand, by writing /sys/class/leds/asus:mail/brightness.  But if I try to
set the trigger to something that uses a timer, like ide-disk or timer,
it eventually causes an Oops.  I will try to capture the actual text of
the message, but the last one involved a stack of acpi_* functions,
followed by a couple of timer functions, the last being schedule_timer.

I haven't written any kernel code before, and I can't figure out what
I'm doing wrong.  The two functions that I created as the brightness_set
methods for the LED devices are essentially identical to the two used by
asus_acpi itself for the /proc interface.  All I can guess is that
either the ACPI methods are taking too long to run and the timer is
firing a new event while the old one is still running (but I don't
believe it is this, because timer_function in ledtrig-timer only
restarts the timer after it changes the LED value), or that the timer is
going off while the kernel is accessing something else with ACPI, and
things are getting corrupted.  Is there a way to schedule the ACPI call
that changes the LED state so it doesn't happen until it's "safe", or is
there some lock I should be acquiring before I change the LED state?

Alternatively, should the led timer trigger be more careful about when
it calls the LED set_brightness methods?  I don't know if there is a
convention for the context of that call--is it my responsibility to
ensure I'm not fiddling with ACPI stuff, or is it the timer's
responsibility to call my set_brightness method at a "good time"?

I'm sorry for posting to LKML with an issue like this, since I should
probably be able to figure it out myself, but I'm new at this and eager
to get this working.  I can post my code somewhere if anyone wants to
look at it.  (It's only about 20 lines added to asus_acpi.c.)

I'm not subscribed to the list, so I'd appreciate a CC on any reply.
I'll also keep an eye on the archives, just in case.

Thanks,

Thomas Tuttle

--=20
Thomas Tuttle (thinkinginbinary@gmail.com)
A List Apart: For people who make websites. alistapart.com
aim/y!m:thinkinginbinary; icq:198113263; jabber:thinkinginbinary@jabber.org
msn: thinkinginbinary@hotmail.com; pgp: 0xAF5112C6

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEqYCe/UG6u69REsYRAuDXAJ9gTMGtmfaBGi+oYPqaVqO5B0ogfQCgidML
6hPv9unsata2eFpzOPYYvUU=
=POQj
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
