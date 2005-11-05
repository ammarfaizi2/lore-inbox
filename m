Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKEEvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKEEvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVKEEvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:51:50 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:49262 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbVKEEvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:51:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=WewDR4AmBC3FXJXUbEBJYX3NYhCgAyIrEgYYHuQac90ctPnKFfMt/SmaKO8UVcCFkANE7OZEVjxM6rswOJcmwabiqJjSDAxWxxiftwmGCTwEPK0+tQy+j8nE5KD1yy068p2TJlY4xow2ySvLwYiN2/MiAoeWIcjTpBYvrUHY9eY=
Message-ID: <c216304e0511042051n3b989ea3gcfb453b74864cd94@mail.gmail.com>
Date: Sat, 5 Nov 2005 10:21:48 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are not enabled
Cc: ricknu-0@student.ltu.se, netdev@vger.kernel.org, davej@suse.de,
       acme@conectiva.com.br, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20051104183043.27a2229c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28891_19004146.1131166308506"
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>
	 <4368878D.4040406@student.ltu.se>
	 <c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>
	 <436927CA.3090105@student.ltu.se>
	 <20051104182537.741be3d9.akpm@osdl.org>
	 <20051104183043.27a2229c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_28891_19004146.1131166308506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

On 11/5/05, Andrew Morton <akpm@osdl.org> wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Let's go with Ashutosh's patch then, thanks.
>
> (It was wordwrapped.  Please fix your email client)

I am attaching the patch.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

> In fact we can de-ifdef things a bit.
>
> diff -puN drivers/net/dgrs.c~dgrs-fixes-warnings-when-config_isa-and-conf=
ig_pci-are-not-enabled drivers/net/dgrs.c
> --- devel/drivers/net/dgrs.c~dgrs-fixes-warnings-when-config_isa-and-conf=
ig_pci-are-not-enabled 2005-11-04 18:26:59.000000000 -0800
> +++ devel-akpm/drivers/net/dgrs.c       2005-11-04 18:29:24.000000000 -08=
00
> @@ -1549,7 +1549,7 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
>  static int __init dgrs_init_module (void)
>  {
>         int     i;
> -       int eisacount =3D 0, pcicount =3D 0;
> +       int     cardcount =3D 0;
>
>         /*
>          *      Command line variable overrides
> @@ -1591,15 +1591,13 @@ static int __init dgrs_init_module (void
>          *      Find and configure all the cards
>          */
>  #ifdef CONFIG_EISA
> -       eisacount =3D eisa_driver_register(&dgrs_eisa_driver);
> -       if (eisacount < 0)
> -               return eisacount;
> -#endif
> -#ifdef CONFIG_PCI
> -       pcicount =3D pci_register_driver(&dgrs_pci_driver);
> -       if (pcicount)
> -               return pcicount;
> +       cardcount =3D eisa_driver_register(&dgrs_eisa_driver);
> +       if (cardcount < 0)
> +               return cardcount;
>  #endif
> +       cardcount =3D pci_register_driver(&dgrs_pci_driver);
> +       if (cardcount)
> +               return cardcount;
>         return 0;
>  }
>

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

Acked. The above patch does the trick too. Any one can be committed.

Cheers
Ashutosh

------=_Part_28891_19004146.1131166308506
Content-Type: text/plain; name=dgrs-patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dgrs-patch.txt"

diff -Naurp linux-2.6.14/drivers/net/dgrs.c linux-2.6.14-git1/drivers/net/dgrs.c
--- linux-2.6.14/drivers/net/dgrs.c	2005-10-28 05:32:08.000000000 +0530
+++ linux-2.6.14-git1/drivers/net/dgrs.c	2005-11-01 10:30:03.000000000 +0530
@@ -1549,8 +1549,12 @@ MODULE_PARM_DESC(nicmode, "Digi RightSwi
 static int __init dgrs_init_module (void)
 {
 	int	i;
-	int eisacount = 0, pcicount = 0;
-
+#ifdef CONFIG_EISA
+	int eisacount = 0;
+#endif
+#ifdef CONFIG_PCI
+	int pcicount = 0;
+#endif
 	/*
 	 *	Command line variable overrides
 	 *		debug=NNN

------=_Part_28891_19004146.1131166308506--
