Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWHBH0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWHBH0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWHBH0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:26:11 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:63458 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751325AbWHBH0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:26:09 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Handle X" <xhandle@gmail.com>
Subject: Re: cleanup, fix for potential crash of hotkey.c
Date: Wed, 2 Aug 2006 09:28:41 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
References: <6de39a910608012309l519c4642va349734e275cc4fd@mail.gmail.com>
In-Reply-To: <6de39a910608012309l519c4642va349734e275cc4fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1542595.rMYeGLVyBR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608020928.46612.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1542595.rMYeGLVyBR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Handle X wrote:
> Hi,
> While going through the code, I found out some memory leaks and
> potential crashes in drivers/acpi/hotkey.c Please find the patch to
> fix them.

> Please let me know your comments.

>  static char *format_result(union acpi_object *object)
>  {
> -	char *buf =3D NULL;
> -
> -	buf =3D (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
> -	if (buf)
> -		memset(buf, 0, RESULT_STR_LEN);
> -	else
> -		goto do_fail;
> +	char *buf;
>
> +	buf =3D (char *)kzalloc(RESULT_STR_LEN, GFP_KERNEL);

no cast here

> @@ -486,98 +490,106 @@ static void free_hotkey_device(union acp
>
>  static void free_hotkey_buffer(union acpi_hotkey *key)
>  {
> -	kfree(key->event_hotkey.action_method);
> +	if (key && key->event_hotkey.action_method)
> +		kfree(key->event_hotkey.action_method);
>  }
>
>  static void free_poll_hotkey_buffer(union acpi_hotkey *key)
>  {
> -	kfree(key->poll_hotkey.action_method);
> -	kfree(key->poll_hotkey.poll_method);
> -	kfree(key->poll_hotkey.poll_result);
> +	if (!key)
> +		return;
> +	if (key->poll_hotkey.action_method)
> +		kfree(key->poll_hotkey.action_method);
> +	if (key->poll_hotkey.poll_method)
> +		kfree(key->poll_hotkey.poll_method);
> +	if (key->poll_hotkey.poll_result)
> +		kfree(key->poll_hotkey.poll_result);
>  }

No, this is the wrong way around. kfree() works fine on NULL, it just retur=
ns.=20
While your change to check if key is valid makes sense the rest does not.

Anyway it's possibly better to not check for key anyway. I don't know the A=
CPI=20
code, so things may be a bit different, but in PCI Hotplug code we removed=
=20
many of this checks completely. These functions might not be called with a=
=20
NULL pointer anyway, so we'll get a nice bug if someone is doing it. This w=
ay=20
the bug is hidden and might lead to more obscure behaviour.

> +	for (i =3D 0; i < LAST_CONF_ENTRY; i++) {
> +		tmp1 =3D strchr(tmp, ':');
> +		if (!tmp1) {
> +			goto do_fail;
> +		}
> +		count =3D tmp1 - tmp;
> +		config_entry[i]=3D (char *)kzalloc(count + 1, GFP_KERNEL);

again no cast here

> +		if (!config_entry[i])
> +			goto handle_failure;
> +		strncpy(config_entry[i], tmp, count);
> +		tmp =3D tmp1 + 1;
> +	}
> +	if (sscanf(tmp, "%d:%d", internal_event_num, external_event_num) <=3D 0)
> +		goto handle_failure;
> +	if (!IS_OTHERS(*internal_event_num)) {
> +		return 6;
> +	}
> +handle_failure:
> +	while (i-- > 0) {
> +		kfree (config_entry[i]);
> +	}

braces unneeded, please remove the space after kfree

> @@ -736,50 +718,33 @@ static ssize_t hotkey_write_config(struc
>  				   size_t count, loff_t * data)
>  {
>  	char *config_record =3D NULL;
> -	char *bus_handle =3D NULL;
> -	char *bus_method =3D NULL;
> -	char *action_handle =3D NULL;
> -	char *method =3D NULL;
> +	char *config_entry[LAST_CONF_ENTRY];
>  	int cmd, internal_event_num, external_event_num;
>  	int ret =3D 0;
> -	union acpi_hotkey *key =3D NULL;
> -
> +	union acpi_hotkey *key =3D kzalloc(sizeof(union acpi_hotkey), GFP_KERNE=
L);
>
> -	config_record =3D (char *)kmalloc(count + 1, GFP_KERNEL);
> +	if (!key) {
> +		return -ENOMEM;
> +	}
> +	config_record =3D (char *)kzalloc(count + 1, GFP_KERNEL);

again no cast

>  	if (!config_record)
> +		kfree (key);

space

>  		return -ENOMEM;
>
>  	if (copy_from_user(config_record, buffer, count)) {
>  		kfree(config_record);
> +		kfree (key);

space

> @@ -923,10 +885,9 @@ static ssize_t hotkey_execute_aml_method
>  	union acpi_hotkey *key;
>
>
> -	arg =3D (char *)kmalloc(count + 1, GFP_KERNEL);
> +	arg =3D (char *)kzalloc(count + 1, GFP_KERNEL);

cast

Eike

--nextPart1542595.rMYeGLVyBR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE0FQuXKSJPmm5/E4RAii0AJ46T9AMoW/qj73Fep71lkhsZItukgCfRF59
Na6qPlwtZtNy985sQYs8ll8=
=CvS1
-----END PGP SIGNATURE-----

--nextPart1542595.rMYeGLVyBR--
