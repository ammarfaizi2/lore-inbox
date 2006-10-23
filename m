Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751839AbWJWI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbWJWI47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWJWI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:56:59 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:44765 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751839AbWJWI46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:56:58 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/5] Char: sx, convert to pci probing
Date: Mon, 23 Oct 2006 10:56:46 +0200
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@bitwizard.nl, support@specialix.co.uk
References: <651531477799512100@wsc.cz>
In-Reply-To: <651531477799512100@wsc.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3381071.43Zgq6DPTb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610231056.47011.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3381071.43Zgq6DPTb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jiri Slaby wrote:
> sx, convert to pci probing
>
> convert old pci code to pci probing.
>
> Cc: <R.E.Wolff@BitWizard.nl>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>
> ---
> commit 56b6b52313a48cbda4c84bd35252337063269d88
> tree 1f32778374ad0eb5d2671cc94674753d1198dbff
> parent d8e4a1a052b460b07936030bc99d8d9fe2b4bbf9
> author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200
> committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200
>
>  drivers/char/sx.c |  183
> ++++++++++++++++++++++++++++++----------------------- 1 files changed, 105
> insertions(+), 78 deletions(-)
>
> diff --git a/drivers/char/sx.c b/drivers/char/sx.c
> index cf08be7..9b800bd 100644
> --- a/drivers/char/sx.c
> +++ b/drivers/char/sx.c
> @@ -246,14 +246,6 @@ #ifndef PCI_DEVICE_ID_SPECIALIX_SX_XIO_I
>  #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
>  #endif
>
> -#ifdef CONFIG_PCI
> -static struct pci_device_id sx_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
> PCI_ANY_ID, PCI_ANY_ID }, -	{ 0 }
> -};
> -MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
> -#endif /* CONFIG_PCI */
> -
>  /* Configurable options:
>     (Don't be too sure that it'll work if you toggle them) */
>
> @@ -2373,7 +2365,6 @@ static void __exit sx_release_drivers(vo
>  	func_exit();
>  }
>
> -#ifdef CONFIG_PCI
>   /********************************************************
>   * Setting bit 17 in the CNTRL register of the PLX 9050  *
>   * chip forces a retry on writes while a read is pending.*
> @@ -2404,22 +2395,112 @@ #define CNTRL_REG_GOODVALUE     0x182600
>  	}
>  	iounmap(rebase);
>  }
> -#endif
>
> +static int __devinit sx_pci_probe(struct pci_dev *pdev,
> +	const struct pci_device_id *ent)
> +{
> +	struct sx_board *board;
> +	unsigned int i;
> +	int retval = -EIO;
> +
> +	for (i = 0; i < SX_NBOARDS; i++)
> +		if (!(boards[i].flags & SX_BOARD_PRESENT))
> +			break;
> +
> +	if (i == SX_NBOARDS)
> +		goto err;
> +
> +	retval = pci_enable_device(pdev);
> +	if (retval)
> +		goto err;
> +
> +	board = &boards[i];

I'm rather sure you need some type of locking here.

> +
> +	board->flags &= ~SX_BOARD_TYPE;
> +	board->flags |= (pdev->subsystem_vendor == 0x200) ? SX_PCI_BOARD :
> +				SX_CFPCI_BOARD;
> +
> +	/* CF boards use base address 3.... */
> +	if (IS_CF_BOARD (board))
> +		board->hw_base = pci_resource_start(pdev, 3);
> +	else
> +		board->hw_base = pci_resource_start(pdev, 2);
> +	board->base2 =
> +	board->base = ioremap(board->hw_base, WINDOW_LEN (board));
> +	if (!board->base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		goto err;
> +	}

pci_iomap() or something?

> +
> +	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
> +	if (IS_CF_BOARD (board))
> +		board->base += 0x18000;
> +
> +	board->irq = pdev->irq;

Is this extra copy of the IRQ number needed?


> @@ -2585,6 +2611,7 @@ static void __exit sx_exit (void)
>  	struct sx_board *board;
>
>  	func_enter();
> +	pci_unregister_driver(&sx_pcidriver);
>  	for (i = 0; i < SX_NBOARDS; i++) {
>  		board = &boards[i];
>  		if (board->flags & SX_BOARD_INITIALIZED) {

Locking?

--nextPart3381071.43Zgq6DPTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFPIPOXKSJPmm5/E4RApuUAKCU6zEEW1gMgAxT/7LoFssLbVA7cwCfRMsj
NVx5/SexmwrT+we35RmaJeY=
=yL8M
-----END PGP SIGNATURE-----

--nextPart3381071.43Zgq6DPTb--
