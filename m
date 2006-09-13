Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWIMNhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWIMNhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWIMNhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:37:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:34348 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWIMNhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:37:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FR82o/oHq27TcIMdQJxzFJwSp2URtkyCdLHma+YMnZUeFsQIQjWnT+2XLVVySajoPmTzHanwznCqJoIO4BE7CNiRAz5NwlueO5+9p097wwricbqOVxygK+R8m5d6Kea9xvv0unbDQ4nAtws+4Rsijf8SiuL3/SvGxPkuBhJXAGE=
Date: Wed, 13 Sep 2006 22:37:43 +0900
From: Tejun Heo <htejun@gmail.com>
To: "Nelson A. de Oliveira" <naoliv@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: PROBLEM: (libata) cdrom drive not detected in -mm series
Message-ID: <20060913133743.GF21866@htj.dyndns.org>
References: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com> <450664C7.3000105@gmail.com> <9bfa9ae0609120430g7d557c8ds3fe802e1ddfffb27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfa9ae0609120430g7d557c8ds3fe802e1ddfffb27@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Alan to this thread]

The whole thread can be read from

http://thread.gmane.org/gmane.linux.kernel/445543/focus=445669

On Tue, Sep 12, 2006 at 08:30:50AM -0300, Nelson A. de Oliveira wrote:
> Hi!
> 
> On 9/12/06, Tejun Heo <htejun@gmail.com> wrote:
> >Nelson A. de Oliveira wrote:
> >> My USB CD-ROM drive (that is detected as a SCSI drive) is not being
> >> detected on the -mm series of the Kernel.
> >
> >s/USB/SATA/, I presume.
> 
> Yes, sorry!
> 
> >[--snip--]
> >-ata2.00: ATAPI, max UDMA/33
> >-ata2.00: configured for UDMA/33
> >-  Vendor: HL-DT-ST  Model: CDRW/DVD GCC4244  Rev: B101
> >-  Type:   CD-ROM                             ANSI SCSI revision: 05
> >
> >Argh... yet another PCS problem.  With whole -mm applied, does adding
> >kernel parameter 'ata_piix.force_pcs=1' make any difference?
> 
> No. Tried with latest 2.6.18-rc6-mm2 and still not detected.
> 
> >Please provide the following info.
> >
> >* the result of 'lspci -nvvv'
> >
> >* dmesg output with the attached patch applied (on top of -mm).
> 
> Applied the patch and sending the output of lspci and dmesg.

It seems that we screwed up while making two combined ports handled by
single host.  irq2 for the second port is added but other than that
the second port shared everything w/ the first port including port
flags, port ops and transfer masks.  In your case, this resulted in
the PATA ports handled as SATA ports resulting in misdetection.  I
missed this because combined on my mobo puts IDE port first, so SATA
ports doesn't get PCS check which works in most cases.

Can you verify whether the following patch fixes your problem?

Jeff, this doesn't affect upstream-fixes, so this isn't a showstopper
for 2.6.18.  The only left one is Keith's case but he's on road and
won't be able to test proposed fix till 18th.  I'll try to reproduce
it here.

Thanks.

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c93154..bb66a12 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5269,11 +5269,19 @@ void ata_port_init(struct ata_port *ap, 
 	ap->host = host;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->pio_mask = ent->pio_mask;
-	ap->mwdma_mask = ent->mwdma_mask;
-	ap->udma_mask = ent->udma_mask;
-	ap->flags |= ent->port_flags;
-	ap->ops = ent->port_ops;
+	if (port_no == 1 && ent->pinfo2) {
+		ap->pio_mask = ent->pinfo2->pio_mask;
+		ap->mwdma_mask = ent->pinfo2->mwdma_mask;
+		ap->udma_mask = ent->pinfo2->udma_mask;
+		ap->flags |= ent->pinfo2->flags;
+		ap->ops = ent->pinfo2->port_ops;
+	} else {
+		ap->pio_mask = ent->pio_mask;
+		ap->mwdma_mask = ent->mwdma_mask;
+		ap->udma_mask = ent->udma_mask;
+		ap->flags |= ent->port_flags;
+		ap->ops = ent->port_ops;
+	}
 	ap->hw_sata_spd_limit = UINT_MAX;
 	ap->active_tag = ATA_TAG_POISON;
 	ap->last_ctl = 0xFF;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7605028..e72ed8d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -858,6 +858,7 @@ ata_pci_init_native_mode(struct pci_dev 
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
+		probe_ent->pinfo2 = port[1];
 		p++;
 	}
 
@@ -907,6 +908,7 @@ static struct ata_probe_ent *ata_pci_ini
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 		}
 		ata_std_ports(&probe_ent->port[1]);
+		probe_ent->pinfo2 = port[1];
 	} else
 		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8715305..ff67e75 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -361,6 +361,14 @@ struct ata_probe_ent {
 	unsigned long		_host_flags;
 	void __iomem		*mmio_base;
 	void			*private_data;
+
+	/* port_info for the secondary port.  Together with irq2, it's
+	 * used to implement non-uniform secondary port.  Currently,
+	 * the only user is ata_piix combined mode.  This workaround
+	 * will be removed together with ata_probe_ent when init model
+	 * is updated.
+	 */
+	const struct ata_port_info *pinfo2;
 };
 
 struct ata_host {
