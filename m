Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWIISD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWIISD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIISD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:03:28 -0400
Received: from master.altlinux.org ([62.118.250.235]:27408 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751344AbWIISD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:03:28 -0400
Date: Sat, 9 Sep 2006 22:02:56 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Samuel Tardieu <sam@rfc1149.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-Id: <20060909220256.d4486a4f.vsu@altlinux.ru>
In-Reply-To: <1157815525.6877.43.camel@localhost.localdomain>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
	<1157815525.6877.43.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__9_Sep_2006_22_02_56_+0400_NSXKHhk/DXANwO_i"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__9_Sep_2006_22_02_56_+0400_NSXKHhk/DXANwO_i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 09 Sep 2006 16:25:25 +0100 Alan Cox wrote:

> Ar Mer, 2006-09-06 am 12:29 +0200, ysgrifennodd Samuel Tardieu:
> > +static unsigned char
> > +w83697hg_get_reg(unsigned char reg)
> > +{
> > +	outb_p(reg, W83697HG_EFIR);
> > +	return inb_p(W83697HG_EFDR);
> > +}
>=20
> No kernel level locking anywhere in the driver. Yet you could have two
> people accessing it at once.

Actually the situation is worse.  This driver pokes at SuperIO
configuration registers, which are shared by all logical devices of the
SuperIO chip.  There are other drivers which touch these registers -
e.g., drivers/hwmon/w83627hf.c handles the hardware monitor part of this
chip; many other hwmon drivers handle other SuperIO devices.  Hardware
monitor drivers access the SuperIO config during initialization and do
not request that port region, therefore loading hwmon drivers when
w83697hf_wdt is loaded can lead to conflicts.

More places which seem to touch SuperIO config:

  - drivers/parport/parport_pc.c
  - drivers/net/irda/nsc-ircc.c
  - drivers/net/irda/smsc-ircc2.c
  - drivers/net/irda/via-ircc.h

I can find at least two attempts to fix the SuperIO problem:

  - a SuperIO subsystem proposed by Evgeniy Polyakov (cc'd);

  - a simple SuperIO locks coordinator proposed by Jim Cromie (also
    cc'd; http://thread.gmane.org/gmane.linux.drivers.sensors/10052 -
    can't find actual patches).

However, the mainline kernel still does not have anything for proper
SuperIO access locking.

--Signature=_Sat__9_Sep_2006_22_02_56_+0400_NSXKHhk/DXANwO_i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFAwHVW82GfkQfsqIRAmjJAKCGt1QmZCyHuGgS34pcGoFX9hx7TQCfTVho
XCLl+OWLAfxQZuEe6QI3E3c=
=HcGX
-----END PGP SIGNATURE-----

--Signature=_Sat__9_Sep_2006_22_02_56_+0400_NSXKHhk/DXANwO_i--
