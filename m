Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755189AbWKMQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbWKMQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbWKMQ1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:27:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:55489 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1755189AbWKMQ1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:27:11 -0500
Message-ID: <1163435230.45589cde18e04@imp4-g19.free.fr>
Date: Mon, 13 Nov 2006 17:27:10 +0100
From: Remi <remi.colinet@free.fr>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
References: <1163425477.455876c5637f6@imp4-g19.free.fr> <200611131452.13234.cova@ferrara.linux.it> <1163431218.45588d325eddf@imp4-g19.free.fr> <200611131654.27187.cova@ferrara.linux.it>
In-Reply-To: <200611131654.27187.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Fabio Coatti <cova@ferrara.linux.it>:

> Alle 16:20, lunedì 13 novembre 2006, Remi ha scritto:
> > Selon Fabio Coatti <cova@ferrara.linux.it>:
> > > > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > > > Kernel panic - not syncing: Attempted to kill init!
> > > >
> > > > I disabled most options in my .config file just keeping ata_piix
> > > > enabled. 2.6.19-rc5 still boots fine but 2.6.19-rc-mm1 gives the same
> > > > previous message.
> > >
> > > It seems exactly the same problem that is hitting me:
> > >
> > > http://lkml.org/lkml/2006/11/13/37
> > >
> > > If some patch comes out, I'll be willing to try it asap ;)
> >
> > You are getting the same message
> >
> > ata_piix 0000:00:1f.2: MAP [ P0 P1 IDE IDE ]
> > ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
> > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > ata_piix: probe of 0000:00:1f.2 failed with error -16
> >
> > But, your drives are driven by the sata_sil driver, which seems to be ok.
> > See your partition tables displayed below.
>
> Not exactly: my fault to not including previous mails, but basically I've two
> different devices: one driven by sata_sil, the other by piix.
> cfr: http://lkml.org/lkml/2006/11/12/20
> In this dmesg, the kernel finds only the second device, and assigns the
> name "sda"; of course the right drive (the real "sda" on my system) is not
> detected so the kernel is searching the "/" filesystem where it cannot be
> found.
>
> here the relevant part of lspci output:
>
> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev
> 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: ABIT Computer Corp. Unknown device 1014
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 17
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at f000 [size=16]

ok,

Could you try the following patch which solved the problemn on my laptop?

--- linux-2.6.19-rc5-mm1/drivers/ata/libata-sff.c	2006-11-12 13:08:19.000000000
+0100
+++ w1/drivers/ata/libata-sff.c	2006-11-13 18:32:18.000000000 +0100
@@ -1021,13 +1021,13 @@
 #endif
 	}

-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc) {
-		disable_dev_on_err = 0;
-		goto err_out;
-	}
-
-	if (legacy_mode) {
+	if (!legacy_mode) {
+		rc = pci_request_regions(pdev, DRV_NAME);
+		if (rc) {
+			disable_dev_on_err = 0;
+			goto err_out;
+		}
+	} else {
 		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
 			res.start = ATA_PRIMARY_CMD;
Remi
