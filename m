Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTL2Lx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 06:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTL2Lx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 06:53:56 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:39043 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262765AbTL2Lxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 06:53:53 -0500
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA8308C898@bgsmsx402.gar.corp.intel.com>
References: <6B09584CC3D2124DB45C3B592414FA8308C898@bgsmsx402.gar.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XxQYphHaDNH0hLU6mjvi"
Organization: Red Hat, Inc.
Message-Id: <1072698818.5223.21.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Dec 2003 12:53:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XxQYphHaDNH0hLU6mjvi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> diff -Naur linux-2.6_src/drivers/acpi/tables.c
> linux-2.6_pciexpress/drivers/acpi/tables.c
> --- linux-2.6_src/drivers/acpi/tables.c	2003-11-27 17:48:39.000000000
> +0530
> +++ linux-2.6_pciexpress/drivers/acpi/tables.c	2003-12-24
> 18:34:38.048354440 +0530
> @@ -58,6 +58,9 @@
>  	[ACPI_SSDT]		=3D "SSDT",
>  	[ACPI_SPMI]		=3D "SPMI",
>  	[ACPI_HPET]		=3D "HPET",
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	[ACPI_MCFG]		=3D "MCFG",
> +#endif

why this ifdef ?
>  #define PCI_CFG_SPACE_SIZE 256
> =20
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +#define PCI_CFG_SPACE_EXP_SIZE 4096
> +#endif

or this one

> @@ -34,12 +46,22 @@
>  		new =3D file->f_pos + off;
>  		break;
>  	case 2:
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +		if (is_pci_express_dev)
> +			new =3D PCI_CFG_SPACE_EXP_SIZE + off;
> +		else
> +#endif /*CONFIG_PCI_EXP_ENHANCED*/

this really looks like you want a dummy is_pci_express_dev (which is
forced 0) instead of all these ifdefs
> diff -Naur linux-2.6_src/include/linux/acpi.h
> linux-2.6_pciexpress/include/linux/acpi.h
> --- linux-2.6_src/include/linux/acpi.h	2003-11-27 17:47:18.000000000
> +0530
> +++ linux-2.6_pciexpress/include/linux/acpi.h	2003-12-24
> 18:34:21.000000000 +0530
> @@ -317,6 +317,15 @@
>  	char				ec_id[0];
>  } __attribute__ ((packed));
> =20
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +struct acpi_table_mcfg {
> +	struct acpi_table_header 	header;
> +	u8	reserved[8];
> +	u64	base_address;
> +} __attribute__ ((packed));
> +#endif

why an ifdef around a struct definition ???

>  enum acpi_table_id {
> @@ -338,6 +347,9 @@
>  	ACPI_SSDT,
>  	ACPI_SPMI,
>  	ACPI_HPET,
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +	ACPI_MCFG,
> +#endif
>  	ACPI_TABLE_COUNT
>  };

.... or an enum....



--=-XxQYphHaDNH0hLU6mjvi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8BXCxULwo51rQBIRAqZ6AJ48bTrpv74QU8C6WF643582VdK0GgCeOCPM
K/w21QckGYMBROIU1dxQpBo=
=pb5F
-----END PGP SIGNATURE-----

--=-XxQYphHaDNH0hLU6mjvi--
