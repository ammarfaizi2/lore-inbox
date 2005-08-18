Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVHREtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVHREtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 00:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVHREtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 00:49:20 -0400
Received: from relay.rost.ru ([80.254.111.11]:37548 "EHLO smtp.rost.ru")
	by vger.kernel.org with ESMTP id S1751345AbVHREtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 00:49:19 -0400
Date: Thu, 18 Aug 2005 08:49:14 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] 2.6.13-rc5-mm1, driver for IBM Automatic Server Restart watchdog
Message-ID: <20050818044914.GB27780@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <11236699751680@donpac.ru> <11236699783884@donpac.ru> <20050817131415.3bd1d5af.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20050817131415.3bd1d5af.akpm@osdl.org>
X-Uname: Linux 2.6.13-rc5-mm1-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 229, 08 17, 2005 at 01:14:15PM -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> >=20
> > This patch adds driver for IBM Automatic Server Restart watchdog hardwa=
re
> > found in some IBM eServer xSeries machines. This driver is based on the=
 ugly
> > driver provided by IBM. Driver was tested on IBM eServer 226.
> >=20
> > ...
> > +
> > +	case ASMTYPE_JASPER:
> > +		type =3D "Jaspers ";
> > +
> > +		/* FIXME: need to use pci_config_lock here, but it's not exported */
>=20
> That's gregkh material.
>=20
> > +
> > +/*		spin_lock_irqsave(&pci_config_lock, flags);*/
> > +
> > +		/* Select the SuperIO chip in the PCI I/O port register */
> > +		outl(0x8000f858, 0xcf8);
> > +
> > +		/*=20
> > +		 * Read the base address for the SuperIO chip.
> > +		 * Only the lower 16 bits are valid, but the address is word=20
> > +		 * aligned so the last bit must be masked off.
> > +		 */
> > +		asr_base =3D inl(0xcfc) & 0xfffe;
> > +
> > +/*		spin_unlock_irqrestore(&pci_config_lock, flags);*/
> >
> > ...
> >
> > +static int asr_ioctl(struct inode *inode, struct file *file,
> > +		     unsigned int cmd, unsigned long arg)
> > +{
> > +	static const struct watchdog_info ident =3D {
> > +		.options =3D	WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> > +				WDIOF_MAGICCLOSE,
> > +		.identity =3D	"IBM ASR"
> > +	};
> > +	void __user *argp =3D (void __user *)arg;
> > +	int __user *p =3D argp;
> > +	int heartbeat;
> > +
> > +	switch (cmd) {
> > +		case WDIOC_GETSUPPORT:
> > +			return copy_to_user(argp, &ident, sizeof(ident)) ?=20
> > +				-EFAULT : 0;
> > +
> > +		case WDIOC_GETSTATUS:
> > +		case WDIOC_GETBOOTSTATUS:
> > +			return put_user(0, p);
> > +
> > +		case WDIOC_KEEPALIVE:
> > +			asr_toggle();
> > +			return 0;
> > +
> > +
> > +		case WDIOC_SETTIMEOUT:
> > +			if (get_user(heartbeat, p))
> > +				return -EFAULT;
> > +			/* Fall */
> > +
> > +		case WDIOC_GETTIMEOUT:
> > +			heartbeat =3D 256;
> > +			return put_user(heartbeat, p);
>=20
> Something very wrong is happening with WDIOC_SETTIMEOUT and
> WDIOC_GETTIMEOUT.  They're both no-ops and the effect of WDIOC_SETTIMEOUT
> is immidiately overwritten.

Hardware has fixed timeout value, so WDIOC_SETTIMEOUT is noop and WDIOC_GET=
TIMEOUT
always returns 256.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBBNKR2OTnxNuAyMRAsmrAKCJ40CBH6ApFBNlKVcaEN6En992MwCfbIhQ
2ett6929VTO+2rrIQrQZ+HA=
=Af7n
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
