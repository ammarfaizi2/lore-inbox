Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264267AbUDTXxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUDTXxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUDTXxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:53:43 -0400
Received: from lists.us.dell.com ([143.166.224.162]:58731 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263726AbUDTXwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:52:23 -0400
Date: Tue, 20 Apr 2004 18:50:38 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, Matt Tolentino <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add some EFI device smarts
Message-ID: <20040420235038.GB29850@lists.us.dell.com>
References: <200404201600.26207.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <200404201600.26207.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2004 at 04:00:26PM -0600, Bjorn Helgaas wrote:
> (Like much of the EFI stuff, this really isn't ia64-specific.  Maybe
> it's time to move some of it under drivers/efi?  If there's interest,
> I can look at doing that.)

Matt T. had done the work to move it under drivers/efi, though now
that there's a drivers/firmware, that's more appropraite.  It also
converted it to use sysfs instead of proc.  There was a bug in
efivars_exit() where it was removing stuff (which could sleep) while
holding a spinlock which wasn't good, but that was about the only
issue anyone had with it.

> +		/* Convert Unicode to normal chars */
> +		for (i =3D 0; i < (name_size/sizeof(name_unicode[0])); i++)
> +			name_utf8[i] =3D name_unicode[i] & 0xff;
> +		name_utf8[i] =3D 0;

I've never had a clear understanding of this.  It's not really UTF8
(else straight ASCII text could be used), but more like UCS2.  (Yeah,
I'm sure I named it wrong myself too in the rest of the file...) =20

> +
> +		if (strcmp(name_utf8, name))
> +			continue;

This ignores the fact that someone could create a variable with the
same name but a different vendor GUID, and it would return the first
one found.  Unfortunately, you need to request both pieces
specifically -=20

+int
+efi_get_variable(char *name, efi_variable_t *guid, unsigned char *data, un=
signed long *size)

and do a guidcmp() on them as well as the strcmp() on the name.

> +int __init
> +efi_uart_console_only(void)

So to be useful, efivars can't be build modular anymore, right?  Then
Kconfig needs to change as well.  It's module_init(), is that early
enough to be used?  Where is efi_uart_console_only() called from?
It's not in this patch.

> +typedef struct {
> +	u8 type;
> +	u8 sub_type;
> +	u16 length;
> +} efi_generic_dev_path_t;

No typedefs, just struct efi_generic_dev_path, and
__attribute__((packed)) please just to be safe.


Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAhbdOIavu95Lw/AkRAp3jAJ9GJpI8YrhKEeNc8pFaYZdfIitEFQCffldB
YdSmnmd++rFh0klCxsVQ/vk=
=cgLG
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
