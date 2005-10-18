Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVJRLPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJRLPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 07:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVJRLPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 07:15:37 -0400
Received: from mivlgu.ru ([81.18.140.87]:673 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1750702AbVJRLPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 07:15:36 -0400
Date: Tue, 18 Oct 2005 15:15:26 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       davej@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Message-Id: <20051018151526.5f4deef6.vsu@altlinux.ru>
In-Reply-To: <4353D905.3080400@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org>
	<Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
	<4353C42A.3000005@pobox.com>
	<Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
	<4353CF7E.1090404@pobox.com>
	<Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
	<4353D905.3080400@pobox.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__18_Oct_2005_15_15_26_+0400_7tW6A0msYV=eSU53"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__18_Oct_2005_15_15_26_+0400_7tW6A0msYV=eSU53
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 17 Oct 2005 13:01:57 -0400 Jeff Garzik wrote:

> Here's a patch for the quirk.  I'll split this off from the sata-menu 
> discussion.  Jesse, I presume this also fixes the problem for you?
> 
> 
> This change makes quirk_intel_ide_combined() dependent on the precise 
> conditions under which it is needed:
> * IDE is built in
> * IDE SATA option is not set
> * ata_piix or ahci drivers are enabled
> 
> This fixes an issue where some modular configurations would not cause 
> the quirk to be enabled.
> 
> Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

> +config SCSI_SATA_INTEL_COMBINED
> +	bool
> +	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
> +	default y

The IDE=y part seems to be incorrect - quirk_intel_ide_combined() is
needed even with modular IDE.  Without this quirk you will get one of
these configurations depending on the module load order:

1) ata_piix loads first - it grabs the whole controller, including the
PATA port; the IDE module loaded later finds nothing.

2) IDE modules are loaded first - without the quirk IDE drivers will
grab the whole controller, including the SATA part.

The binding you get with builtin IDE (ata_piix/ahci for SATA, generic
IDE driver for PATA) would be impossible to get with modular IDE without
the quirk, which does not seem to be good...

--Signature=_Tue__18_Oct_2005_15_15_26_+0400_7tW6A0msYV=eSU53
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDVNlRW82GfkQfsqIRAhnfAJ4laNMHOuC8Pp7ZKAcCgj9vRTGnDwCfXa7u
KDg4sJKLzocSQFDukFUwgd8=
=Dmwk
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Oct_2005_15_15_26_+0400_7tW6A0msYV=eSU53--
