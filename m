Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUGLMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUGLMVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266809AbUGLMVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:21:41 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:46979 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266805AbUGLMVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:21:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: watchdog infrastructure
Date: Mon, 12 Jul 2004 14:20:45 +0200
User-Agent: KMail/1.6.2
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
References: <200407011923.45226.arnd@arndb.de> <20040712081939.GJ5726@infomag.infomag.iguana.be> <20040712082313.GW12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040712082313.GW12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hIo8Au5eJdzPgJo";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121420.50190.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hIo8Au5eJdzPgJo
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 12. Juli 2004 10:23, viro@parcelfarce.linux.theplanet.co.uk wrot=
e:
> On Mon, Jul 12, 2004 at 10:19:39AM +0200, Wim Van Sebroeck wrote:
> > > - You need to get the module reference count before calling any
> > > =A0 watchdog operation, the best place for this is probably the
> > > =A0 open() fop.
>=20
> Huh? =A0Just set ->owner in file_operations and be done with that.
>=20
Yes, that would work. However, I don't feel comfortable with setting
fops->owner to anything else than THIS_MODULE. In particular, this
causes problems when multiple watchdog drivers register with the
watchdog base module.

The sequence I had in mind was:

chrdev_open()
   try_module_get(fops->owner)
   watchdog_open()
      try_module_get(wdops->owner)
      wdops->start()


vfs_write
   watchdog_write()
      wdops->keepalive()

=2E..

fput()
   watchdog_release()
       wdops->stop()
       module_put(wdops->owner)
   module_put(fops->owner)

This would practically do the same for the watchdog layer that we already
do for inside vfs for the file_operations.

	Arnd <><

--Boundary-02=_hIo8Au5eJdzPgJo
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8oIh5t5GS2LDRf4RAl5MAKCa+xpN4/DjqiXQ1yzEgpOfLq+wnACdFX+4
j+L3P2Qn+vRFivr7By3KmxU=
=SHCw
-----END PGP SIGNATURE-----

--Boundary-02=_hIo8Au5eJdzPgJo--
