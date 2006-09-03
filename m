Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWICSoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWICSoA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWICSoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 14:44:00 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:56999 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932100AbWICSn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 14:43:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=U9Ct5Cjdo0hXCDXlQO56n6OO6ViT9zVmy1nn32NEahkdi+V6dV0zGqr4d3KH+2tXOyAFeqfS35PNU6pZprtHPaNXCNcqLFIZXdnLk15mtDJZAy0CmKWVZoIFeTzp52wMBdSpFQYECyTYnYCOkVYtZIMUdljeS6LsdMefGfKd6iw=
Message-ID: <44FA71E4.70408@gmail.com>
Date: Sun, 03 Sep 2006 15:10:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5
References: <6353.1156778652@ocs10w.ocs.com.au>
In-Reply-To: <6353.1156778652@ocs10w.ocs.com.au>
Content-Type: multipart/mixed;
 boundary="------------070106030601050400050009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070106030601050400050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Keith Owens.

Sorry about late respond.  I'm quite occupied with personal stuff these 
days.

Keith Owens wrote:
>>> (2) I have seen the same intermittent bug on ICH7 SATA but
>>>     PIIX_FLAG_IGNORE_PCS is only set for ich5 and i6300esb_sata.  It
>>>     probably needs to be set for ich7 as well.
>> No, ICH7 up to this point has been believed to have well-behaving PCS. 
>> If you report PCS problem, you'll be the first.  Also, note that ICH7 
>> suffers from ghost device probing problem if PCS is not honored exactly. 
>>  Are you sure it's the same problem?
> 
> It definitely looks like it.  Stock 2.6.18-rc5 plus this patch to
> activate ata_debug from boot until just after probing drives.
[--snip--]
> <3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0
> <3>piix_sata_present_mask: ata1: LEAVE, pcs=0x15 present_mask=0x3
> <3>piix_sata_present_mask: ata1: ENTER, pcs=0x0 base=0
> <3>piix_sata_present_mask: ata1: LEAVE, pcs=0x0 present_mask=0x3
> <3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0
> <3>piix_sata_present_mask: ata1: LEAVE, pcs=0x15 present_mask=0x3
> <3>piix_sata_present_mask: ata1: ENTER, pcs=0x0 base=0
> <3>piix_sata_present_mask: ata1: LEAVE, pcs=0x0 present_mask=0x3
> <3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0

Yeah, it definitely looks like it.  Does the kernel print a message 
which looks like the following before those debug messages?

"updating PCS from 0x0 to 0x5"

> Note the pcs=0x0 values.  Adding PIIX_FLAG_IGNORE_PCS to
> ich6m_sata_ahci gets past the failure to detect pcs, with no sign of
> any ghost devices.  BTW, dropping down to 2.6.17 with the same config
> has no problem detecting the disk, even without PIIX_FLAG_IGNORE_PCS on
> ich6m_sata_ahci.

BTW, you can set PIIX_FLAG_IGNORE_PCS by using force_pcs=1 module 
parameter now.

> lspci extract, this is an ICH7M.
> 
> 00:1f.0 Class 0601: 8086:27b9 (rev 02)
> 	Subsystem: 1033:832c
> 	Flags: bus master, medium devsel, latency 0
> 	Capabilities: [e0] Vendor Specific Information
> 
> 00:1f.2 Class 0101: 8086:27c4 (rev 02) (prog-if 80)
> 	Subsystem: 1033:832c
> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at 18b0 [size=16]
> 	Capabilities: [70] Power Management version 2
> 
> 00:1f.3 Class 0c05: 8086:27da (rev 02)
> 	Subsystem: 1033:832c
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at 18c0 [size=32]
> 

Hmm... Can you try the attached patch and see what happens?  ATM, I'm on 
the road and can't test the patch, so it's only compile-tested.  This 
patch basically reverts some of the effects of the following commit and 
makes PCS update a little bit more aggressive iff necessary.

ea35d29e2fa8b3d766a2ce8fbcce599dce8d2734
[libata] ata_piix: Consolidate PCS register writing

If this works for you ich7m, can you please test this on your formerly 
problematic ich5 with force_pcs=2 specified?  I initially thought that 
the ich5 problem was caused by exact PCS map change and thus added 
IGNORE_PCS as workaround but if the same problem occurs on ich7 and is 
fixed by the attached patch, it's due to conservative PCS update change 
and thus the original IGNORE_PCS fix on ich5 might not be necessary.

Sorry this PCS business causes you and other people so much trouble.  It 
just doesn't work quite as ata_piix developers expect.

Thanks.

-- 
tejun

--------------070106030601050400050009
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 2d20caf..46f7c9b 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -553,15 +553,42 @@ static unsigned int piix_sata_present_ma
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct piix_host_priv *hpriv = ap->host_set->private_data;
+	const struct piix_map_db *map_db = hpriv->map_db;
 	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
 	unsigned int present_mask = 0;
 	int port, i;
-	u16 pcs;
+	u16 pcs, new_pcs;
 
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
 	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
+	new_pcs = pcs | map_db->port_enable;
+
+	if (pcs != new_pcs) {
+		u16 old_pcs = pcs;
+
+		for (i = 0; i < 10; i++) {
+			pci_write_config_word(pdev, ICH5_PCS, new_pcs);
+			msleep(150);
+			pci_read_config_word(pdev, ICH5_PCS, &pcs);
+
+			new_pcs = pcs | map_db->port_enable;
+			if (pcs == new_pcs)
+				break;
+		}
+
+		if (pcs == new_pcs)
+			ata_port_printk(ap, KERN_INFO, "updated PCS from "
+					"0x%x to 0x%x (%d tries)\n",
+					old_pcs, pcs, i);
+		else
+			ata_port_printk(ap, KERN_WARNING,
+					"failed to update PCS after %d tries, "
+					"old=0x%x cur=0x%x new=0x%x\n",
+					i, old_pcs, pcs, new_pcs);
+	}
+
 	for (i = 0; i < 2; i++) {
 		port = map[base + i];
 		if (port < 0)
@@ -816,35 +843,6 @@ static int __devinit piix_check_450nx_er
 	return no_piix_dma;
 }
 
-static void __devinit piix_init_pcs(struct pci_dev *pdev,
-				    struct ata_port_info *pinfo,
-				    const struct piix_map_db *map_db)
-{
-	u16 pcs, new_pcs;
-
-	pci_read_config_word(pdev, ICH5_PCS, &pcs);
-
-	new_pcs = pcs | map_db->port_enable;
-
-	if (new_pcs != pcs) {
-		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
-		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
-		msleep(150);
-	}
-
-	if (force_pcs == 1) {
-		dev_printk(KERN_INFO, &pdev->dev,
-			   "force ignoring PCS (0x%x)\n", new_pcs);
-		pinfo[0].host_flags |= PIIX_FLAG_IGNORE_PCS;
-		pinfo[1].host_flags |= PIIX_FLAG_IGNORE_PCS;
-	} else if (force_pcs == 2) {
-		dev_printk(KERN_INFO, &pdev->dev,
-			   "force honoring PCS (0x%x)\n", new_pcs);
-		pinfo[0].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
-		pinfo[1].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
-	}
-}
-
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 					 struct ata_port_info *pinfo,
 					 const struct piix_map_db *map_db)
@@ -893,6 +891,17 @@ static void __devinit piix_init_sata_map
 
 	hpriv->map = map;
 	hpriv->map_db = map_db;
+
+	/* handle force_pcs module parameter */
+	if (force_pcs == 1) {
+		dev_printk(KERN_INFO, &pdev->dev, "force ignoring PCS\n");
+		pinfo[0].host_flags |= PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags |= PIIX_FLAG_IGNORE_PCS;
+	} else if (force_pcs == 2) {
+		dev_printk(KERN_INFO, &pdev->dev, "force honoring PCS\n");
+		pinfo[0].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+		pinfo[1].host_flags &= ~PIIX_FLAG_IGNORE_PCS;
+	}
 }
 
 /**
@@ -948,12 +957,9 @@ static int piix_init_one (struct pci_dev
 	}
 
 	/* Initialize SATA map */
-	if (host_flags & ATA_FLAG_SATA) {
+	if (host_flags & ATA_FLAG_SATA)
 		piix_init_sata_map(pdev, port_info,
 				   piix_map_db_table[ent->driver_data]);
-		piix_init_pcs(pdev, port_info,
-			      piix_map_db_table[ent->driver_data]);
-	}
 
 	/* On ICH5, some BIOSen disable the interrupt using the
 	 * PCI_COMMAND_INTX_DISABLE bit added in PCI 2.3.

--------------070106030601050400050009--


-- 
VGER BF report: U 0.5
