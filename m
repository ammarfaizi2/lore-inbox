Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDZGEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDZGEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 02:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDZGEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 02:04:47 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:42200 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750702AbWDZGEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 02:04:47 -0400
From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
To: pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] Re: [patch] pciehp: dont call pci_enable_dev
Date: Wed, 26 Apr 2006 08:04:14 +0200
User-Agent: KMail/1.9.1
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       Arjan van de Ven <arjan@infradead.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <1145919059.6478.29.camel@whizzy> <1145945819.3114.0.camel@laptopd505.fenrus.org> <1146002437.6478.43.camel@whizzy>
In-Reply-To: <1146002437.6478.43.camel@whizzy>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1198302.aQXvYFEW2h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604260804.20178@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1198302.aQXvYFEW2h
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 26. April 2006 00:00 schrieb Kristen Accardi:
>On Tue, 2006-04-25 at 08:16 +0200, Arjan van de Ven wrote:
>> On Mon, 2006-04-24 at 15:50 -0700, Kristen Accardi wrote:
>> > Don't call pci_enable_device from pciehp because the pcie port service
>> > driver already does this.
>>
>> hmmmm shouldn't pci_enable_device on a previously enabled device just
>> succeed? Sounds more than logical to me to make it that way at least...
>
>I can't think of any reason why not.  Something like this what you had
>in mind perhaps?
>
>---
> drivers/pci/pci.c |   14 +++++++++-----
> 1 files changed, 9 insertions(+), 5 deletions(-)
>
>--- 2.6-git-pcie.orig/drivers/pci/pci.c
>+++ 2.6-git-pcie/drivers/pci/pci.c
>@@ -504,11 +504,15 @@ pci_enable_device_bars(struct pci_dev *d
> int
> pci_enable_device(struct pci_dev *dev)
> {
>-	int err =3D pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
>-	if (err)
>-		return err;
>-	pci_fixup_device(pci_fixup_enable, dev);
>-	dev->is_enabled =3D 1;
>+	int err;
>+
>+	if (!dev->is_enabled) {
>+		err =3D pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
>+		if (err)
>+			return err;
>+		pci_fixup_device(pci_fixup_enable, dev);
>+		dev->is_enabled =3D 1;
>+	}
> 	return 0;
> }

What about

if (dev->is_enabled)
	return 0;

and leaving the rest as it is? This would save one level of identation.=20
Opinions?

Eike

--nextPart1198302.aQXvYFEW2h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBETw1kXKSJPmm5/E4RAkO2AKCR5P3n9uh+JMdwMjShBSBl7Ii29gCgkop6
soubmUf02y80fH1ZnKdcX+A=
=1p8Z
-----END PGP SIGNATURE-----

--nextPart1198302.aQXvYFEW2h--
