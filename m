Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965528AbWIRIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965528AbWIRIFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965532AbWIRIFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:05:48 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:31410 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965528AbWIRIFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:05:46 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Om Narasimhan" <om.turyx@gmail.com>
Subject: Re: acpi kmalloc to kzalloc conversion and a memory leak fix.
Date: Mon, 18 Sep 2006 10:05:18 +0200
User-Agent: KMail/1.9.4
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6b4e42d10609171754m3361c805teda7fae032f8e756@mail.gmail.com>
In-Reply-To: <6b4e42d10609171754m3361c805teda7fae032f8e756@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart44573444.J4FjkBNa0n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181005.19033.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart44573444.J4FjkBNa0n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Om Narasimhan wrote:
> Hi,
> I had submitted this patch sometime earlier. Submitting again after
> fixing a bug in the patch.
> I have not subscribed to linux-acpi. please CC me in replies.

Please add a description here what you do in your patch. Especially if you'=
re=20
going to fix a bug it would be good if you shortly describe where it was an=
d=20
how it was wrong, e.g. "foo() was freeing struct bar on error, but nobody=20
ever cared for the children of bar".

> Signed Off by : Om Narasimhan <om.turyx@gmail.com>
>
> --
>
>  drivers/acpi/ac.c              |    4 +---
>  drivers/acpi/acpi_memhotplug.c |   14 ++++----------
>  drivers/acpi/asus_acpi.c       |    3 +--
>  drivers/acpi/battery.c         |   13 +++----------
>  drivers/acpi/bus.c             |    3 +--
>  drivers/acpi/button.c          |    4 +---
>  drivers/acpi/container.c       |    4 +---
>  drivers/acpi/ec.c              |   20 +++++---------------
>  drivers/acpi/fan.c             |    3 +--
>  drivers/acpi/i2c_ec.c          |    8 ++------
>  drivers/acpi/osl.c             |    2 +-
>  drivers/acpi/pci_bind.c        |   21 +++++----------------
>  drivers/acpi/pci_irq.c         |   16 +++-------------
>  drivers/acpi/pci_link.c        |    6 ++----
>  drivers/acpi/pci_root.c        |    3 +--
>  drivers/acpi/power.c           |    4 +---
>  drivers/acpi/processor_core.c  |    4 +---
>  drivers/acpi/sbs.c             |    4 +---
>  drivers/acpi/thermal.c         |   13 +++----------
>  drivers/acpi/utils.c           |    2 --
>  20 files changed, 38 insertions(+), 113 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 11abc7b..0d05d36 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -221,11 +221,9 @@ static int acpi_ac_add(struct acpi_devic
>  	if (!device)
>  		return -EINVAL;
>
> -	ac =3D kmalloc(sizeof(struct acpi_ac), GFP_KERNEL);
> +	ac =3D kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
>  	if (!ac)
>  		return -ENOMEM;
> -	memset(ac, 0, sizeof(struct acpi_ac));
> -
>  	ac->device =3D device;
>  	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
> diff --git a/drivers/acpi/acpi_memhotplug.c
> b/drivers/acpi/acpi_memhotplug.c index 1dda370..4b1a77d 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -292,7 +292,6 @@ static int acpi_memory_disable_device(st
>  	int result;
>  	struct acpi_memory_info *info, *n;
>
> -
>  	/*
>  	 * Ask the VM to offline this memory range.
>  	 * Note: Assume that this function returns zero on success

Depends on the maintainer, but usually it is preferred to do whitespace=20
cleanups in their own patch. Now I have to dig through >600 lines of patch =
to=20
find the bug you fixed. I would have split this one into 3 seperate pieces:=
=20
whitespace, k[mz]alloc and the bug fix. This depends on the whishes of the=
=20
maintainer, but usually this makes tracking of changes much easier as the=20
first two can later be ignored more or less if someones trying to nail down=
 a=20
change in behaviour to a specific patch.

> @@ -418,14 +412,14 @@ static int acpi_memory_device_add(struct
>  static int acpi_memory_device_remove(struct acpi_device *device, int typ=
e)
>  {
>  	struct acpi_memory_device *mem_device =3D NULL;
> -
> +	struct acpi_memory_info *info, *n;
>
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> -
>  	mem_device =3D (struct acpi_memory_device *)acpi_driver_data(device);
> +	list_for_each_entry_safe(info, n, &mem_device->res_list, list)
> +		kfree(info);
>  	kfree(mem_device);
> -
>  	return 0;
>  }

This has nothing to do with your patch, but isn't this check here a bit=20
superfluous? Also the check in acpi_memory_device_add() to check for device=
?=20
These functions should never be called if device is NULL. If it is this is =
a=20
bug and it's better to BUG() or just oops here instead of hiding this bug.=
=20
Also acpi_memory_device_remove() should never be called if=20
acpi_memory_device_add() fails. But if this succeeded=20
acpi_driver_data(device) will always be valid. If it is deleted later by=20
anyone else this is also a bug and shouldn't be "ignored" silently. Opinion=
s?

> @@ -277,15 +274,12 @@ int acpi_pci_unbind(struct acpi_device *
>  	char *pathname =3D NULL;
>  	struct acpi_buffer buffer =3D { 0, NULL };
>
> -
>  	if (!device || !device->parent)
>  		return -EINVAL;
>
> -	pathname =3D (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	pathname =3D (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>  	if (!pathname)
>  		return -ENOMEM;
> -	memset(pathname, 0, ACPI_PATHNAME_MAX);
> -
>  	buffer.length =3D ACPI_PATHNAME_MAX;
>  	buffer.pointer =3D pathname;
>  	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);

This btw. is an example where I would also do a whitespace change in a "rea=
l"=20
patch. It doesn't matter here as this area is touched anyway. Not 100%=20
correct, but who is? :)

> @@ -332,11 +326,9 @@ acpi_pci_bind_root(struct acpi_device *d
>  	struct acpi_buffer buffer =3D { 0, NULL };
>
>
> -	pathname =3D (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	pathname =3D (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>  	if (!pathname)
>  		return -ENOMEM;
> -	memset(pathname, 0, ACPI_PATHNAME_MAX);
> -
>  	buffer.length =3D ACPI_PATHNAME_MAX;
>  	buffer.pointer =3D pathname;
>

Kill that cast. kzalloc() returns void* which is assignement compatible wit=
h=20
any pointer.

> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index feda034..b64c50a 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -85,21 +85,14 @@ acpi_pci_irq_add_entry(acpi_handle handl
>  {
>  	struct acpi_prt_entry *entry =3D NULL;
>
> -
> -	if (!prt)
> -		return -EINVAL;
> -
> -	entry =3D kmalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
> +	entry =3D kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
>  	if (!entry)
>  		return -ENOMEM;
> -	memset(entry, 0, sizeof(struct acpi_prt_entry));
> -
>  	entry->id.segment =3D segment;
>  	entry->id.bus =3D bus;
>  	entry->id.device =3D (prt->address >> 16) & 0xFFFF;
>  	entry->id.function =3D prt->address & 0xFFFF;
>  	entry->pin =3D prt->pin;
> -
>  	/*
>  	 * Type 1: Dynamic
>  	 * ---------------

You are changing the way how this code works here as you removed the check =
for=20
prt. Another good example why to split up this patch as this might sometime=
=20
really byte someone (haven't checked the code).

> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 5753d06..bdb0353 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -902,13 +902,11 @@ acpi_thermal_write_trip_points(struct fi
>  	int i =3D 0;
>
>
> -	limit_string =3D kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
> +	limit_string =3D kzalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
>  	if (!limit_string)
>  		return -ENOMEM;
>
> -	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
> -
> -	active =3D kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
> +	active =3D kzalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
>  	if (!active) {
>  		kfree(limit_string);
>  		return -ENOMEM;

*looking in the file*

Eeks, what's that?

       if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {

What about

       if (!tz || (count >=3D ACPI_THERMAL_MAX_LIMIT_STR_LEN)) {


Eike

--nextPart44573444.J4FjkBNa0n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDlM/XKSJPmm5/E4RAhVvAJ4zmScdhW+QY3RBNOM/HTb4uJy8YQCfXHvu
A0CfQbbaqZjk8Ces2um2DaQ=
=LGsG
-----END PGP SIGNATURE-----

--nextPart44573444.J4FjkBNa0n--
