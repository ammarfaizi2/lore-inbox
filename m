Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754705AbWKMO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbWKMO7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbWKMO7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:59:14 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:37863 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1754705AbWKMO7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:59:13 -0500
Message-ID: <1163429952.455888400b260@imp4-g19.free.fr>
Date: Mon, 13 Nov 2006 15:59:12 +0100
From: Remi <remi.colinet@free.fr>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
References: <1163425477.455876c5637f6@imp4-g19.free.fr> <20061113141400.12ff22be@localhost.localdomain>
In-Reply-To: <20061113141400.12ff22be@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 13 Nov 2006 14:44:37 +0100
> Remi <remi.colinet@free.fr> wrote:
>
> >
> > => Step 4 : then the libata tries to allocate once more the same ressources
> and
> > fails.
> >
> > [<f00e3eed>] ata_pci_init_one+0xad/0x423 [libata]
> >  [<f001f9c1>] piix_init_one+0x4b7/0x4d4 [ata_piix]
>
> ata_pci_init_one should have followed the legacy_mode path at this point,

So, doing the following change in drivers/ata/libata-sff.c, function
ata_pci_init_one should fix the problem.

-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		disable_dev_on_err = 0;
-		goto err_out;
-	}
-
-	if (legacy_mode) {
-		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {


+	if (!legacy_mode) {
+		rc = pci_request_regions(pdev, DRV_NAME);
+		if (rc) {
+			disable_dev_on_err = 0;
+			goto err_out;
+		}
+	else {
+		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {

Going to try it.
But the ioport map is going stay a little bit ugly.

> and the legacy mode path should not be trying to request the legacy
> regions the quirk code already reserved.
>
> I suspect the code should only do the pci_request_regions() call if the
> device on if (!legacy_mode), and the legacy code should
> pci_request_region(pdev, 4, ...);
>

Actually, it seems to be exactly what the code does in the legacy mode.

Thanks,
Remi





