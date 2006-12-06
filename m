Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937295AbWLFTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937295AbWLFTTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937336AbWLFTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:19:40 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:8645 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937330AbWLFTTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:19:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=NyQPfKP/JZvQDy3OZ72Q93Q/9YBhob5yqM6b7aSw3FxZwnNcR7JEem+3eL7VU4Td72Kdx0bWrR0o87RXv90NZNgU9Epqiz402fxZCvlAMMxSrNmQ1OOWYsdSPXw4AFgGjDDLav3nWA838gTiMKwW7lqk0YlqBHBRgXYWCQ1xG6g=
Subject: Re: -mm merge plans for 2.6.20
From: Conke Hu <conke.hu@gmail.com>
Reply-To: conke.hu@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20061204214114.433485fc.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <4574FC0A.8090607@garzik.org>  <20061204214114.433485fc.akpm@osdl.org>
Content-Type: text/plain
Organization: ZJU
Date: Thu, 07 Dec 2006 03:19:40 +0800
Message-Id: <1165432780.21881.20.camel@linux-qmhe.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 21:41 -0800, Andrew Morton wrote:
> On Mon, 04 Dec 2006 23:56:42 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > Andrew Morton wrote:
> > > via-pata-controller-xfer-fixes.patch
> > > via-pata-controller-xfer-fixes-fix.patch
> > 
> > Tejun's 3d3cca37559e3ab2b574eda11ed5207ccdb8980a has been ack'd by the 
> > reporter as fixing things, so these two shouldn't be needed.
> 
> OK thanks, I dropped it.
> 
> > 
> > > libata_resume_fix.patch
> > 
> > I thought this was resolved long ago?  Are there still open reports that 
> > this solves, where upstream doesn't work?
> 
> Heck, I don't know.
> 
> > 
> > > ahci-ati-sb600-sata-support-for-various-modes.patch
> > 
> > With the PCI quirk, I thought ATI was finally sorted?
> 
> Was it?  I don't know that either.
> 
> I'll drop these too.
> -

Hi Jeff, Andrew
    The following patch is ATI's final solution. It was ACKed by Alan.
    Jeff, you're the maintainer of libata, but this patch is based on
pci/quirks.c, so I don't know who will apply this patch? You or somebody
else?
    Andrew, could you please drop ATI's previous patch and add this one
in next -mm patch? The previous patch I sent
(ahci-ati-sb600-sata-support-for-various-modes.patch) is not as good as
this one :)


Best regards,
Conke @AMD/ATI


[------------------PATCH------------------]

--- linux-2.6.19-rc6-git4/drivers/pci/quirks.c.orig     2006-11-23
19:45:49.000000000 +0800
+++ linux-2.6.19-rc6-git4/drivers/pci/quirks.c  2006-11-23
19:34:23.000000000 +0800
@@ -795,6 +795,25 @@ static void __init quirk_mediagx_master(
       }
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,
PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
+
+#if defined(CONFIG_SATA_AHCI) || defined(CONFIG_SATA_AHCI_MODULE)
+static void __devinit quirk_sb600_sata(struct pci_dev *pdev)
+{
+       /* set sb600 sata to ahci mode */
+       if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+               u8 tmp;
+
+               pci_read_config_byte(pdev, 0x40, &tmp);
+               pci_write_config_byte(pdev, 0x40, tmp|1);
+               pci_write_config_byte(pdev, 0x9, 1);
+               pci_write_config_byte(pdev, 0xa, 6);
+               pci_write_config_byte(pdev, 0x40, tmp);
+
+               pdev->class = 0x010601;
+       }
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI,
PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_sb600_sata);
+#endif

 /*
 * As per PCI spec, ignore base address registers 0-3 of the IDE
controllers

