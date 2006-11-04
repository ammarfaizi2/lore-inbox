Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWKDPUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWKDPUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 10:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965503AbWKDPUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 10:20:48 -0500
Received: from mail.gmx.de ([213.165.64.20]:40095 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964990AbWKDPUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 10:20:47 -0500
X-Authenticated: #5108953
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH] e1000: Fix regression: garbled stats and irq allocation during swsusp
Date: Sat, 4 Nov 2006 16:20:32 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       stable@vger.kernel.org, rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org,
       laurent.riffard@free.fr, rajesh.shah@intel.com, jeff@garzik.org,
       pavel@ucw.cz, jesse.brandeburg@intel.com,
       "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, linville@redhat.com, wtogami@redhat.com,
       dag@wieers.com, error27@gmail.com,
       e1000-list <e1000-devel@lists.sourceforge.net>
References: <454B9BED.306@intel.com>
In-Reply-To: <454B9BED.306@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3847572.sQa2RD5dXY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611041620.35712.toralf.foerster@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3847572.sQa2RD5dXY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Auke,

good news. I incorporated the changes manually b/cI couldn't apply your pat=
ch
against the latest git tree from Linux with the program patch.
The patch would solve http://bugzilla.kernel.org/show_bug.cgi?id=3D7207 :-)
Here's the diff after my edit of the file e1000_main.c:

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 8d04752..400bdee 100644
=2D-- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -4799,7 +4799,8 @@ e1000_suspend(struct pci_dev *pdev, pm_m

        if (adapter->hw.phy_type =3D=3D e1000_phy_igp_3)
                e1000_phy_powerdown_workaround(&adapter->hw);
=2D
+       e1000_free_irq(adapter);
+
        /* Release control of h/w to f/w.  If f/w is AMT enabled, this
         * would have already happened in close and is redundant. */
        e1000_release_hw_control(adapter);
@@ -4830,6 +4831,10 @@ e1000_resume(struct pci_dev *pdev)
        pci_enable_wake(pdev, PCI_D3hot, 0);
        pci_enable_wake(pdev, PCI_D3cold, 0);

+       if ((err =3D e1000_request_irq(adapter)))
+               return err;
+
+       e1000_power_up_phy(adapter);
        e1000_reset(adapter);
        E1000_WRITE_REG(&adapter->hw, WUS, ~0);



Am Friday 03 November 2006 20:43 schrieb Auke Kok:
>=20
> e1000: Fix regression: garbled stats and irq allocation during swsusp
>=20
> After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
> device showing garbled statistics and undetermined irq allocation state,
> where `ifconfig eth0 down` would display `trying to free already freed ir=
q`.
>=20
> Explicitly free and allocate irq as well as powerup the PHY during resume
> fixes.
>=20
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
>=20
> diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_mai=
n.c
> index c0269b5..32cdccb 100644
> --- a/drivers/net/e1000/e1000_main.c
> +++ b/drivers/net/e1000/e1000_main.c
> @@ -5081,6 +5081,8 @@ #endif
>   	if (adapter->hw.phy_type =3D=3D e1000_phy_igp_3)
>   		e1000_phy_powerdown_workaround(&adapter->hw);
>=20
> +	e1000_free_irq(adapter);
> +
>   	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
>   	 * would have already happened in close and is redundant. */
>   	e1000_release_hw_control(adapter);
> @@ -5111,6 +5113,10 @@ e1000_resume(struct pci_dev *pdev)
>   	pci_enable_wake(pdev, PCI_D3hot, 0);
>   	pci_enable_wake(pdev, PCI_D3cold, 0);
>=20
> +	if ((err =3D e1000_request_irq(adapter)))
> +		return err;
> +
> +	e1000_power_up_phy(adapter);
>   	e1000_reset(adapter);
>   	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
>=20
>=20

=2D-=20
MfG/Sincerely

Toralf F=F6rster
+++ I'm not subscribed to the email list, please Cc: me +++

--nextPart3847572.sQa2RD5dXY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTK/DhyrlCH22naMRAiUPAJ9mReLskYZ1Revz2xja0wJ65+2fGQCfSDa4
VAoaMkbigfLOZgKIVQMB6bI=
=F0px
-----END PGP SIGNATURE-----

--nextPart3847572.sQa2RD5dXY--
