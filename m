Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSK0UII>; Wed, 27 Nov 2002 15:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSK0UII>; Wed, 27 Nov 2002 15:08:08 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:64399 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S263246AbSK0UIH>; Wed, 27 Nov 2002 15:08:07 -0500
Message-Id: <200211272015.gARKFHwF006320@localhost.localdomain>
Date: Wed, 27 Nov 2002 15:15:17 -0500
From: Georg Nikodym <georgn@somanetworks.com>
To: Linux/ARM Kernel List <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab labels
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.JXwq5O4(RNa,GD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.JXwq5O4(RNa,GD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

In the 2.4.18-2.4.19 timeframe:

	http://linux.bkbits.net:8080/linux-2.4/cset@1.536

brcl (Ben LaHaise, I think) pushed in a change to mm/slab.c which
(amongst other things) adds the following code:

...
	name = cachep->name; 
===>	{
===>	char tmp; 
===>	if (__get_user(tmp, name)) 
===>		name = "broken"; 
===>	}       

	seq_printf(m, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
		name, active_objs, num_objs, cachep->objsize,
		active_slabs, num_slabs, (1<<cachep->gfporder));
...

to s_show() (the stuff that gets called when somebody cat's /proc/slabinfo)

Trouble is that on my ARM platform, the __get_user() call always fails
and all the slabinfo entries are labelled "broken".

For my purposes, ifdef'ing the offending block out will likely be
sufficient (and safe?) but I'd like to know:

1. Is the ARM __get_user() broken?
2. Could I be doing something else broken that is confusing __get_user()?
3. What was/is the intent of the test?  Or stated differently, why on earth
   would cachep->name be a user address?

-g

--=.JXwq5O4(RNa,GD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE95SfVoJNnikTddkMRAkc2AJ0VasIWLsTqmoB7dZIgNDNoijx9fwCeNWzj
5Vs+tzLPHbAN6p5nJKzvu3E=
=IZT5
-----END PGP SIGNATURE-----

--=.JXwq5O4(RNa,GD--
