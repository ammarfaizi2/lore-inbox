Return-Path: <linux-kernel-owner+w=401wt.eu-S964904AbWL1Dam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWL1Dam (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWL1Dal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:30:41 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:4250 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964902AbWL1Dak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:30:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type;
        b=ipSGsDCGJjzG2ccZNJiQA04qguF7fkgssNrM3lTIFG8Z0SrUwDxBjPjizLdRp4r/87QQ93ynX/FVWw8/z+yhvXJEqa9ywZrBzve/7Jn138tHI83lro/DpYhJRoT3Tr89j155vQwfFBEpXqZHyk2y6+z8W/7FFxRJlOymJPe5M2A=
Message-ID: <45933A53.1090702@gmail.com>
Date: Thu, 28 Dec 2006 12:30:27 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Andrew Lyon <andrew.lyon@gmail.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
In-Reply-To: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------040406010202020601080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406010202020601080905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Lyon wrote:
> Hi,
> 
> My system is gigabyte ds3 motherboard with onboard SATA JMicron
> 20360/20363 AHCI Controller (rev 02), drive connected is WDC
> WD740ADFD-00 20.0, I am running 2.6.18.6 32 bit, under heavy i/o I get
> the following messaegs:
> 
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x0)
> 
> Is this condition dangerous?

Not usually.  Might indicate something is going wrong in some really
rare cases.  I think vendors are getting NCQ right these days.  Maybe
it's time to remove that printk.

> I plan to upgrade to 2.6.19 soon as I have problems with a sata dvd
> writer but I have to wait for a driver that I need to catch up, this
> system cannot be down for long as it runs mythtv.

Can you apply the attached patch and report what the kernel says?
Please include full dmesg.

Thanks.

-- 
tejun

--------------040406010202020601080905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b517d24..13f5853 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1162,10 +1162,21 @@ static void ahci_host_intr(struct ata_port *ap)
 	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS))
 		return;
 
-	if (ata_ratelimit())
+	if (ata_ratelimit()) {
+		struct ahci_port_priv *pp = ap->private_data;
+		const u32 *f = pp->rx_fis + 0x58;
+
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
-				"(irq_stat 0x%x active_tag %d sactive 0x%x)\n",
+				"(irq_stat 0x%x active_tag 0x%x sactive 0x%x)\n",
 				status, ap->active_tag, ap->sactive);
+		if (status & PORT_IRQ_SDB_FIS) {
+			ata_port_printk(ap, KERN_INFO, "issue=0x%x SAct=0x%x "
+					"SDB_FIS=%08x:%08x\n",
+					readl(port_mmio + PORT_CMD_ISSUE),
+					readl(port_mmio + PORT_SCR_ACT),
+					f[0], f[1]);
+		}
+	}
 }
 
 static void ahci_irq_clear(struct ata_port *ap)

--------------040406010202020601080905--
