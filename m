Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVAGJnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVAGJnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAGJnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:43:55 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:59090 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id S261332AbVAGJns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:43:48 -0500
X-Scanned: Fri, 7 Jan 2005 11:43:38 +0200 Nokia Message Protector V1.3.34 2004121512 - RELEASE
Date: Fri, 7 Jan 2005 11:41:04 +0200
From: Paul Mundt <paul.mundt@nokia.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050107094103.GA7408@pointless.research.nokia.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20050107072222.GB24441@kroah.com>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 07 Jan 2005 09:42:49.0182 (UTC) FILETIME=[3FDEB7E0:01C4F49D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2005 at 11:22:22PM -0800, Greg KH wrote:
> So it looks like you are just adding a fake "bus" driver and then
> manually adding the bus devices to the root device.  Why not just
> complete the conversion and register the real devices properly?
>=20
Can you elaborate on what you mean by registering the "real devices properl=
y"?

> We are depreciating device lists within the kernel.  The PCI device list
> will be going away sometime in the future, and we shouldn't be adding
> new ones.  Can't this just be determined from userspace instead like
> 'lspci' and 'lsusb' do?
>=20
Yes, this can be done in userspace, so that stuff can be dropped.

> > +void superhyway_create_sysfs_files(struct superhyway_device *s)
> > +{
> > +	struct device *dev =3D &s->dev;
> > +
> > +	device_create_file(dev, &dev_attr_perr_flags);
> > +	device_create_file(dev, &dev_attr_merr_flags);
> > +	device_create_file(dev, &dev_attr_mod_vers);
> > +	device_create_file(dev, &dev_attr_mod_id);
> > +	device_create_file(dev, &dev_attr_bot_mb);
> > +	device_create_file(dev, &dev_attr_top_mb);
> > +	device_create_file(dev, &dev_attr_resource);
>=20
> Can you use a default attribute list instead of manually creating the
> files individually?  Also, I don't see the code that removes these
> attributes.  Please don't rely on the sysfs function of automatically
> cleaning up the attributes when the device is removed, that might not
> work in the future.
>=20
Yes, I can use the dev_attrs for this. Thanks for pointing that out.

> > +static struct superhyway_bus superhyway_bus =3D {
> > +	.name	=3D "SuperHyway bus",
> > +};
>=20
> Please don't add sysfs directories that have spaces in them.  How about
> "superhyway_bus" instead?
>=20
Ok.

> > +	pr_info("    0x%04x (%s) control block at 0x%08lx\n",
> > +		dev->id.id, dev->pretty_name, dev->resource.start);
>=20
> Shouldn't this be a debug message?
>=20
Yes, probably. Though with the devlist in userspace I suppose it's not over=
ly
useful to have here anyways.

> > +static void __exit superhyway_bus_exit(void)
> > +{
> > +	struct superhyway_device *dev;
> > +
> > +	list_for_each_entry(dev, &superhyway_bus.devices, node) {
> > +		device_unregister(&dev->dev);
> > +		kfree(dev);
> > +	}
>=20
> Ick, not good, userspace could still have a reference on the device
> through sysfs.  Don't kfree it here, do it in the release function
> (which you need to do.)
>=20
Ok.

> Also, why have a local list of devices and not just use the list the
> driver core provides for you?
>=20
Probably because I wasn't aware that the driver core provided one. Now that=
 I
see the bus_for_each_xxx() stuff I'll drop the list and use that instead.

> > +struct superhyway_device {
> > +	struct list_head node;
> > +
> > +	char name[32];
> > +	char pretty_name[64];
>=20
> Do you need the name and pretty_name?
>=20
No, the pretty_name was only added for the devlist. I'll clean that up.

> > +struct superhyway_bus {
> > +	struct list_head devices;
> > +	struct device dev;
> > +	char name[16];
> > +};
>=20
> Is the name really necessary?
>=20
Probably not. With that and the list gone I can drop this struct entirely a=
nd
just have the root device as a struct device.

> > +/* drivers/sh/superhyway/superhyway-sysfs.c */
> > +#ifdef CONFIG_SYSFS
> > +void superhyway_create_sysfs_files(struct superhyway_device *);
> > +#else
> > +void superhyway_create_sysfs_files(struct superhyway_device *s)
> > +{
> > +	/* Nothing to do */
> > +}
> > +#endif
>=20
> Why ifdef this function?  That should not be needed.
>=20
superhyway_add_device() calls this. We don't want to assume that CONFIG_SYS=
FS
will always be enabled. I can move the ifdef in to superhyway_add_device() =
if
you think it would be cleaner. (And this is needed as we happen to have
superhyway_create_sysfs_files() defined in superhyway-sysfs.c which is only
compiled in when CONFIG_SYSFS is set, and I would rather not link this in
unconditionally).

Thanks for looking at this, I'll post a cleaned up version shortly.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB3lkvvfgmmv+NIDsRAr5CAJ4+zqXRqtneQSwZMvJtGcAUfAoUiACeKxxx
l7hT+27MTE0CVrOphrOarho=
=UDfZ
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
