Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUAIO4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAIO4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:56:16 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:10368
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261872AbUAIOzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:55:14 -0500
Date: Fri, 9 Jan 2004 09:54:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFT] atp870u update
Message-ID: <Pine.LNX.4.58.0401090951420.2365@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
	This has been updated to 2.6.1-mm1 and test booted but without
hardware.

Index: linux-2.6.1-mm1/drivers/scsi/atp870u.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.1-mm1/drivers/scsi/atp870u.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 atp870u.c
--- linux-2.6.1-mm1/drivers/scsi/atp870u.c	9 Jan 2004 13:15:44 -0000	1.1.1.1
+++ linux-2.6.1-mm1/drivers/scsi/atp870u.c	9 Jan 2004 14:20:36 -0000
@@ -42,50 +42,6 @@

 static unsigned short int sync_idu;

-#define MAX_ATP		16
-
-struct atp_unit {
-	unsigned long ioport;
-	unsigned long irq;
-	unsigned long pciport;
-	unsigned char last_cmd;
-	unsigned char in_snd;
-	unsigned char in_int;
-	unsigned char quhdu;
-	unsigned char quendu;
-	unsigned char scam_on;
-	unsigned char global_map;
-	unsigned char chip_veru;
-	unsigned char host_idu;
-	int working;
-	unsigned short wide_idu;
-	unsigned short active_idu;
-	unsigned short ultra_map;
-	unsigned short async;
-	unsigned short deviceid;
-	unsigned char ata_cdbu[16];
-	unsigned char sp[16];
-	Scsi_Cmnd *querequ[qcnt];
-	struct atp_id {
-		unsigned char dirctu;
-		unsigned char devspu;
-		unsigned char devtypeu;
-		unsigned long prdaddru;
-		unsigned long tran_lenu;
-		unsigned long last_lenu;
-		unsigned char *prd_posu;
-		unsigned char *prd_tableu;
-		dma_addr_t prd_phys;
-		Scsi_Cmnd *curr_req;
-	} id[16];
-	struct Scsi_Host *host;
-	struct pci_dev *pdev;
-};
-
-static struct Scsi_Host *atp_host[MAX_ATP];
-
-static void send_s870(struct Scsi_Host *);
-
 static irqreturn_t atp870u_intr_handle(int irq, void *dev_id,
 					struct pt_regs *regs)
 {
@@ -878,7 +834,7 @@ static void tscam(struct Scsi_Host *host
 	unsigned long n;
 	unsigned short int m, assignid_map, val;
 	unsigned char mbuf[33], quintet[2];
-	struct atp_unit *dev = (struct atp_unit *)host->hostdata;
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
 	static unsigned char g2q_tab[8] = {
 		0x38, 0x31, 0x32, 0x2b, 0x34, 0x2d, 0x2e, 0x27
 	};
@@ -2253,15 +2209,31 @@ set_syn_ok:
 	}
 }

-
-static void atp870u_init_tables(struct Scsi_Host *host)
+static void atp870u_free_tables(struct Scsi_Host *host)
 {
-	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
+	struct atp_unit *atp_dev = (struct atp_unit *)&host->hostdata;
 	int k;

 	for (k = 0; k < 16; k++) {
-		/* FIXME */
+		if (!atp_dev->id[k].prd_tableu)
+			continue;
+		pci_free_consistent(atp_dev->pdev, 1024, atp_dev->id[k].prd_tableu,
+					atp_dev->id[k].prd_phys);
+		atp_dev->id[k].prd_tableu = NULL;
+	}
+}
+
+static int atp870u_init_tables(struct Scsi_Host *host)
+{
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
+	int k, i;
+
+	for (i = k = 0; k < 16; k++) {
 		dev->id[k].prd_tableu = pci_alloc_consistent(dev->pdev, 1024, &dev->id[k].prd_phys);
+		if (!dev->id[k].prd_tableu) {
+			atp870u_free_tables(host);
+			return -ENOMEM;
+		}
 		dev->id[k].devspu = 0x20;
 		dev->id[k].devtypeu = 0;
 		dev->id[k].curr_req = NULL;
@@ -2282,293 +2254,294 @@ static void atp870u_init_tables(struct S
 		dev->id[k].curr_req = 0;
 		dev->sp[k] = 0x04;
 	}
+	return 0;
 }

 /* return non-zero on detection */
-static int atp870u_detect(Scsi_Host_Template * tpnt)
+static int atp870u_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
-	unsigned char irq, h, k, m;
+	unsigned char k, m;
 	unsigned long flags;
 	unsigned int base_io, error, tmport;
-	struct pci_dev *pdev[MAX_ATP];
-	unsigned char chip_ver[MAX_ATP], host_id;
-	unsigned short dev_id[MAX_ATP], n;
-	struct Scsi_Host *shpnt = NULL;
-	int card = 0;
-	int count = 0;
-
-	static unsigned short devid[9] = {
-		0x8081, 0x8002, 0x8010, 0x8020, 0x8030, 0x8040, 0x8050, 0x8060, 0
-	};
-
-	printk(KERN_INFO "aec671x_detect: \n");
-	tpnt->proc_name = "atp870u";
+	unsigned char host_id;
+	unsigned short n;
+	struct Scsi_Host *shpnt;
+	struct atp_unit atp_dev, *p;
+	static int count;
+
+	if (pci_enable_device(dev))
+		return -EIO;
+
+	if (pci_set_dma_mask(dev, 0xFFFFFFFFUL)) {
+		printk(KERN_ERR "atp870u: 32bit DMA mask required but not available.\n");
+		return -EIO;
+	}
+
+	memset(&atp_dev, 0, sizeof atp_dev);
+
+	/*
+	 * It's probably easier to weed out some revisions like
+	 * this than via the PCI device table
+	 */
+	if (ent->device == PCI_DEVICE_ID_ARTOP_AEC7610) {
+		error = pci_read_config_byte(dev, PCI_CLASS_REVISION, &atp_dev.chip_veru);
+		if (atp_dev.chip_veru < 2)
+			return -EIO;
+	}
+
+	switch (ent->device) {
+	case 0x8081:
+	case PCI_DEVICE_ID_ARTOP_AEC7612UW:
+	case PCI_DEVICE_ID_ARTOP_AEC7612SUW:
+		atp_dev.chip_veru = 0x04;
+	default:
+		break;
+	}
+
+	base_io = pci_resource_start(dev, 0);
+
+	if (ent->device != 0x8081) {
+		error = pci_read_config_byte(dev, 0x49, &host_id);
+		base_io &= 0xfffffff8;
+
+		printk(KERN_INFO "   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: %d "
+			"IO:%x, IRQ:%d.\n", count, base_io, dev->irq);
+
+		atp_dev.unit = count;
+		atp_dev.ioport = base_io;
+		atp_dev.pciport = base_io + 0x20;
+		atp_dev.deviceid = ent->device;
+		host_id &= 0x07;
+		atp_dev.host_idu = host_id;
+		tmport = base_io + 0x22;
+		atp_dev.scam_on = inb(tmport);
+		tmport += 0x0b;
+		atp_dev.global_map = inb(tmport++);
+		atp_dev.ultra_map = inw(tmport);
+
+		if (atp_dev.ultra_map == 0) {
+			atp_dev.scam_on = 0x00;
+			atp_dev.global_map = 0x20;
+			atp_dev.ultra_map = 0xffff;
+		}
+
+		shpnt = scsi_host_alloc(&atp870u_template, sizeof(struct atp_unit));
+		if (!shpnt)
+			return -ENOMEM;

-	for (h = 0; devid[h]; h++) {
-		struct pci_dev *dev = NULL;
+		p = (struct atp_unit *)&shpnt->hostdata;

-		while((dev = pci_find_device(0x1191, devid[h], dev))!=NULL)
-		{
-			if(pci_enable_device(dev))
-				continue;
-
-			if(pci_set_dma_mask(dev, 0xFFFFFFFFUL))
-			{
-				printk(KERN_ERR "atp870u: 32bit DMA mask required but not available.\n");
-				continue;
-			}
-			chip_ver[card] = 0;
-			dev_id[card] = devid[h];
-
-			if (devid[h] == 0x8002) {
-				error = pci_read_config_byte(dev, 0x08, &chip_ver[card]);
-				if (chip_ver[card] < 2) {
-					continue;
-				}
-			}
-			if (devid[h] == 0x8010 || devid[h] == 0x8081 || devid[h] == 0x8050) {
-				chip_ver[card] = 0x04;
-			}
-			pdev[card] = dev;
-			card++;
-			if (card == MAX_ATP)
-				break;
-		}
-	}
-	for (h = 0; h < card; h++) {
-		struct atp_unit tmp, *dev;
-
-		/* Found an atp870u/w. */
-		base_io = pci_resource_start(pdev[h], 0);
-		irq = pdev[h]->irq;
-
-		if (dev_id[h] != 0x8081) {
-			error = pci_read_config_byte(pdev[h], 0x49, &host_id);
-
-			base_io &= 0xfffffff8;
-
-			if (check_region(base_io, 0x40) != 0) {
-				return 0;
-			}
-			printk(KERN_INFO "   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: %d    IO:%x, IRQ:%d.\n", h, base_io, irq);
-
-			tmp.ioport = base_io;
-			tmp.pciport = base_io + 0x20;
-			tmp.deviceid = dev_id[h];
-			host_id &= 0x07;
-			tmp.host_idu = host_id;
-			tmp.chip_veru = chip_ver[h];
-
-			tmport = base_io + 0x22;
-			tmp.scam_on = inb(tmport);
-			tmport += 0x0b;
-			tmp.global_map = inb(tmport++);
-			tmp.ultra_map = inw(tmport);
-			if (tmp.ultra_map == 0) {
-				tmp.scam_on = 0x00;
-				tmp.global_map = 0x20;
-				tmp.ultra_map = 0xffff;
-			}
-			shpnt = scsi_register(tpnt, sizeof(struct atp_unit));
-			if (shpnt == NULL)
-				return count;
-			tmp.host = shpnt;
-			tmp.pdev = pdev[h];
-			/* Save the atp_unit data */
-			memcpy(&shpnt->hostdata, &tmp, sizeof(tmp));
-
-			atp870u_init_tables(shpnt);
-			spin_lock_irqsave(shpnt->host_lock, flags);
-			if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
-				printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
-				goto unregister;
-			}
-
-			if (chip_ver[h] > 0x07) {	/* check if atp876 chip   *//* then enable terminator */
-				tmport = base_io + 0x3e;
-				outb(0x00, tmport);
-			}
+		atp_dev.host = shpnt;
+		atp_dev.pdev = dev;
+		pci_set_drvdata(dev, p);
+		memcpy(p, &atp_dev, sizeof atp_dev);
+		if (atp870u_init_tables(shpnt) < 0)
+			goto unregister;
+
+		if (request_irq(dev->irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
+			printk(KERN_ERR "Unable to allocate IRQ%d for Acard controller.\n", dev->irq);
+			goto free_tables;
+		}

-			tmport = base_io + 0x3a;
-			k = (inb(tmport) & 0xf3) | 0x10;
-			outb(k, tmport);
-			outb((k & 0xdf), tmport);
-			mdelay(32);
-			outb(k, tmport);
-			mdelay(32);
-			tmport = base_io;
-			outb((host_id | 0x08), tmport);
-			tmport += 0x18;
-			outb(0, tmport);
-			tmport += 0x07;
-			while ((inb(tmport) & 0x80) == 0);
-			tmport -= 0x08;
-			inb(tmport);
-			tmport = base_io + 1;
-			outb(8, tmport++);
-			outb(0x7f, tmport);
-			tmport = base_io + 0x11;
-			outb(0x20, tmport);
-
-			tscam(shpnt);
-			is870(shpnt, base_io);
-			tmport = base_io + 0x3a;
-			outb((inb(tmport) & 0xef), tmport);
-			tmport++;
-			outb((inb(tmport) | 0x20), tmport);
-		} else {
-			base_io &= 0xfffffff8;
+		spin_lock_irqsave(shpnt->host_lock, flags);
+		if (atp_dev.chip_veru > 0x07) {	/* check if atp876 chip then enable terminator */
+			tmport = base_io + 0x3e;
+			outb(0x00, tmport);
+		}
+
+		tmport = base_io + 0x3a;
+		k = (inb(tmport) & 0xf3) | 0x10;
+		outb(k, tmport);
+		outb((k & 0xdf), tmport);
+		mdelay(32);
+		outb(k, tmport);
+		mdelay(32);
+		tmport = base_io;
+		outb((host_id | 0x08), tmport);
+		tmport += 0x18;
+		outb(0, tmport);
+		tmport += 0x07;
+		while ((inb(tmport) & 0x80) == 0)
+			mdelay(1);

-			if (check_region(base_io, 0x60) != 0) {
-				return 0;
-			}
-			host_id = inb(base_io + 0x39);
-			host_id >>= 0x04;
+		tmport -= 0x08;
+		inb(tmport);
+		tmport = base_io + 1;
+		outb(8, tmport++);
+		outb(0x7f, tmport);
+		tmport = base_io + 0x11;
+		outb(0x20, tmport);

-			printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra3 LVD Host Adapter: %d    IO:%x, IRQ:%d.\n", h, base_io, irq);
-			tmp.ioport = base_io + 0x40;
-			tmp.pciport = base_io + 0x28;
-			tmp.deviceid = dev_id[h];
-			tmp.host_idu = host_id;
-			tmp.chip_veru = chip_ver[h];
-
-			tmport = base_io + 0x22;
-			tmp.scam_on = inb(tmport);
-			tmport += 0x13;
-			tmp.global_map = inb(tmport);
-			tmport += 0x07;
-			tmp.ultra_map = inw(tmport);
+		tscam(shpnt);
+		is870(shpnt, base_io);
+		tmport = base_io + 0x3a;
+		outb((inb(tmport) & 0xef), tmport);
+		tmport++;
+		outb((inb(tmport) | 0x20), tmport);
+	} else {
+		base_io &= 0xfffffff8;
+		host_id = inb(base_io + 0x39);
+		host_id >>= 0x04;
+
+		printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra3 LVD Host Adapter: %d"
+			"    IO:%x, IRQ:%d.\n", count, base_io, dev->irq);
+		atp_dev.ioport = base_io + 0x40;
+		atp_dev.pciport = base_io + 0x28;
+		atp_dev.deviceid = ent->device;
+		atp_dev.host_idu = host_id;
+
+		tmport = base_io + 0x22;
+		atp_dev.scam_on = inb(tmport);
+		tmport += 0x13;
+		atp_dev.global_map = inb(tmport);
+		tmport += 0x07;
+		atp_dev.ultra_map = inw(tmport);

-			n = 0x3f09;
+		n = 0x3f09;
 next_fblk:
-			if (n >= 0x4000) {
-				goto flash_ok;
-			}
-			m = 0;
-			outw(n, base_io + 0x34);
-			n += 0x0002;
-			if (inb(base_io + 0x30) == 0xff) {
-				goto flash_ok;
-			}
-			tmp.sp[m++] = inb(base_io + 0x30);
-			tmp.sp[m++] = inb(base_io + 0x31);
-			tmp.sp[m++] = inb(base_io + 0x32);
-			tmp.sp[m++] = inb(base_io + 0x33);
-			outw(n, base_io + 0x34);
-			n += 0x0002;
-			tmp.sp[m++] = inb(base_io + 0x30);
-			tmp.sp[m++] = inb(base_io + 0x31);
-			tmp.sp[m++] = inb(base_io + 0x32);
-			tmp.sp[m++] = inb(base_io + 0x33);
-			outw(n, base_io + 0x34);
-			n += 0x0002;
-			tmp.sp[m++] = inb(base_io + 0x30);
-			tmp.sp[m++] = inb(base_io + 0x31);
-			tmp.sp[m++] = inb(base_io + 0x32);
-			tmp.sp[m++] = inb(base_io + 0x33);
-			outw(n, base_io + 0x34);
-			n += 0x0002;
-			tmp.sp[m++] = inb(base_io + 0x30);
-			tmp.sp[m++] = inb(base_io + 0x31);
-			tmp.sp[m++] = inb(base_io + 0x32);
-			tmp.sp[m++] = inb(base_io + 0x33);
-			n += 0x0018;
-			goto next_fblk;
+		if (n >= 0x4000)
+			goto flash_ok;
+
+		m = 0;
+		outw(n, base_io + 0x34);
+		n += 0x0002;
+		if (inb(base_io + 0x30) == 0xff)
+			goto flash_ok;
+
+		atp_dev.sp[m++] = inb(base_io + 0x30);
+		atp_dev.sp[m++] = inb(base_io + 0x31);
+		atp_dev.sp[m++] = inb(base_io + 0x32);
+		atp_dev.sp[m++] = inb(base_io + 0x33);
+		outw(n, base_io + 0x34);
+		n += 0x0002;
+		atp_dev.sp[m++] = inb(base_io + 0x30);
+		atp_dev.sp[m++] = inb(base_io + 0x31);
+		atp_dev.sp[m++] = inb(base_io + 0x32);
+		atp_dev.sp[m++] = inb(base_io + 0x33);
+		outw(n, base_io + 0x34);
+		n += 0x0002;
+		atp_dev.sp[m++] = inb(base_io + 0x30);
+		atp_dev.sp[m++] = inb(base_io + 0x31);
+		atp_dev.sp[m++] = inb(base_io + 0x32);
+		atp_dev.sp[m++] = inb(base_io + 0x33);
+		outw(n, base_io + 0x34);
+		n += 0x0002;
+		atp_dev.sp[m++] = inb(base_io + 0x30);
+		atp_dev.sp[m++] = inb(base_io + 0x31);
+		atp_dev.sp[m++] = inb(base_io + 0x32);
+		atp_dev.sp[m++] = inb(base_io + 0x33);
+		n += 0x0018;
+		goto next_fblk;
 flash_ok:
-			outw(0, base_io + 0x34);
-			tmp.ultra_map = 0;
-			tmp.async = 0;
-			for (k = 0; k < 16; k++) {
-				n = 1;
-				n = n << k;
-				if (tmp.sp[k] > 1) {
-					tmp.ultra_map |= n;
-				} else {
-					if (tmp.sp[k] == 0) {
-						tmp.async |= n;
-					}
-				}
-			}
-			tmp.async = ~(tmp.async);
-			outb(tmp.global_map, base_io + 0x35);
+		outw(0, base_io + 0x34);
+		atp_dev.ultra_map = 0;
+		atp_dev.async = 0;
+		for (k = 0; k < 16; k++) {
+			n = 1;
+			n = n << k;
+			if (atp_dev.sp[k] > 1) {
+				atp_dev.ultra_map |= n;
+			} else {
+				if (atp_dev.sp[k] == 0)
+					atp_dev.async |= n;
+ 			}
+	 	}
+		atp_dev.async = ~(atp_dev.async);
+		outb(atp_dev.global_map, base_io + 0x35);
+
+		shpnt = scsi_host_alloc(&atp870u_template, sizeof(struct atp_unit));
+		if (!shpnt)
+			return -ENOMEM;
+
+		p = (struct atp_unit *)&shpnt->hostdata;
+
+		atp_dev.host = shpnt;
+		atp_dev.pdev = dev;
+		pci_set_drvdata(dev, p);
+		memcpy(p, &atp_dev, sizeof atp_dev);
+		if (atp870u_init_tables(shpnt) < 0) {
+			printk(KERN_ERR "Unable to allocate tables for Acard controller\n");
+			goto unregister;
+		}
+
+		if (request_irq(dev->irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
+ 			printk(KERN_ERR "Unable to allocate IRQ%d for Acard controller.\n", dev->irq);
+			goto free_tables;
+		}
+
+		spin_lock_irqsave(shpnt->host_lock, flags);
+		tmport = base_io + 0x38;
+		k = inb(tmport) & 0x80;
+		outb(k, tmport);
+		tmport += 0x03;
+		outb(0x20, tmport);
+		mdelay(32);
+		outb(0, tmport);
+		mdelay(32);
+		tmport = base_io + 0x5b;
+		inb(tmport);
+		tmport -= 0x04;
+		inb(tmport);
+		tmport = base_io + 0x40;
+		outb((host_id | 0x08), tmport);
+		tmport += 0x18;
+		outb(0, tmport);
+		tmport += 0x07;
+		while ((inb(tmport) & 0x80) == 0)
+			mdelay(1);
+		tmport -= 0x08;
+		inb(tmport);
+		tmport = base_io + 0x41;
+		outb(8, tmport++);
+		outb(0x7f, tmport);
+		tmport = base_io + 0x51;
+		outb(0x20, tmport);

-			shpnt = scsi_register(tpnt, sizeof(struct atp_unit));
-			if (shpnt == NULL)
-				return count;
-
-			tmp.pdev = pdev[h];
-			memcpy(&shpnt->hostdata, &tmp, sizeof(tmp));
-
-			atp870u_init_tables(shpnt);
-
-			spin_lock_irqsave(shpnt->host_lock, flags);
-			if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
-				printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
-				goto unregister;
-			}
-
-			tmport = base_io + 0x38;
-			k = inb(tmport) & 0x80;
-			outb(k, tmport);
-			tmport += 0x03;
-			outb(0x20, tmport);
-			mdelay(32);
-			outb(0, tmport);
-			mdelay(32);
-			tmport = base_io + 0x5b;
-			inb(tmport);
-			tmport -= 0x04;
-			inb(tmport);
-			tmport = base_io + 0x40;
-			outb((host_id | 0x08), tmport);
-			tmport += 0x18;
-			outb(0, tmport);
-			tmport += 0x07;
-			while ((inb(tmport) & 0x80) == 0);
-			tmport -= 0x08;
-			inb(tmport);
-			tmport = base_io + 0x41;
-			outb(8, tmport++);
-			outb(0x7f, tmport);
-			tmport = base_io + 0x51;
-			outb(0x20, tmport);
-
-			tscam(shpnt);
-			is880(shpnt, base_io);
-			tmport = base_io + 0x38;
-			outb(0xb0, tmport);
-		}
+		tscam(shpnt);
+		is880(shpnt, base_io);
+		tmport = base_io + 0x38;
+		outb(0xb0, tmport);
+	}

-		dev = (struct atp_unit *)&shpnt->hostdata;
-
-		atp_host[h] = shpnt;
-		if (dev->chip_veru == 4) {
-			shpnt->max_id = 16;
-		}
-		shpnt->this_id = host_id;
-		shpnt->unique_id = base_io;
-		shpnt->io_port = base_io;
-		if (dev_id[h] == 0x8081) {
-			shpnt->n_io_port = 0x60;	/* Number of bytes of I/O space used */
-		} else {
-			shpnt->n_io_port = 0x40;	/* Number of bytes of I/O space used */
-		}
-		shpnt->irq = irq;
-		spin_unlock_irqrestore(shpnt->host_lock, flags);
-		if (dev_id[h] == 0x8081) {
-			request_region(base_io, 0x60, "atp870u");	/* Register the IO ports that we use */
-		} else {
-			request_region(base_io, 0x40, "atp870u");	/* Register the IO ports that we use */
-		}
-		count++;
-		continue;
-unregister:
-		scsi_unregister(shpnt);
-		spin_unlock_irqrestore(shpnt->host_lock, flags);
-		continue;
+	if (p->chip_veru == 4)
+		shpnt->max_id = 16;
+
+	shpnt->this_id = host_id;
+	shpnt->unique_id = base_io;
+	shpnt->io_port = base_io;
+	if (ent->device == 0x8081) {
+		shpnt->n_io_port = 0x60;	/* Number of bytes of I/O space used */
+	} else {
+		shpnt->n_io_port = 0x40;	/* Number of bytes of I/O space used */
+	}
+	shpnt->irq = dev->irq;
+	spin_unlock_irqrestore(shpnt->host_lock, flags);
+	if (ent->device == 0x8081) {
+		if (!request_region(base_io, 0x60, "atp870u"))
+			goto request_io_fail;
+	} else {
+		if (!request_region(base_io, 0x40, "atp870u"))
+			goto request_io_fail;
 	}

-	return count;
+	count++;
+	if (scsi_add_host(shpnt, &dev->dev))
+		goto scsi_add_fail;
+	scsi_scan_host(shpnt);
+	return 0;
+
+scsi_add_fail:
+	if (ent->device == 0x8081)
+		release_region(base_io, 0x60);
+	else
+		release_region(base_io, 0x40);
+request_io_fail:
+	free_irq(dev->irq, shpnt);
+free_tables:
+	atp870u_free_tables(shpnt);
+unregister:
+	scsi_host_put(shpnt);
+	return -1;
 }

 /* The abort command does not leave the device in a clean state where
@@ -2684,25 +2657,26 @@ static int atp870u_biosparam(struct scsi
 	return 0;
 }

-
-static int atp870u_release(struct Scsi_Host *pshost)
+static void atp870u_remove(struct pci_dev *pdev)
 {
-	struct atp_unit *dev = (struct atp_unit *)&pshost->hostdata;
-	int k;
+	struct atp_unit *atp_dev = pci_get_drvdata(pdev);
+	struct Scsi_Host *pshost = atp_dev->host;
+
+	scsi_remove_host(pshost);
 	free_irq(pshost->irq, pshost);
 	release_region(pshost->io_port, pshost->n_io_port);
-	scsi_unregister(pshost);
-	for (k = 0; k < 16; k++)
-		pci_free_consistent(dev->pdev, 1024, dev->id[k].prd_tableu, dev->id[k].prd_phys);
-	return 0;
+	atp870u_free_tables(pshost);
+	scsi_host_put(pshost);
+	pci_set_drvdata(pdev, NULL);
 }

 MODULE_LICENSE("GPL");

-static Scsi_Host_Template driver_template = {
+static Scsi_Host_Template atp870u_template = {
+	.module			= THIS_MODULE,
+	.name			= "atp870u",
+	.proc_name		= "atp870u",
 	.proc_info		= atp870u_proc_info,
-	.detect			= atp870u_detect,
-	.release		= atp870u_release,
 	.info			= atp870u_info,
 	.queuecommand		= atp870u_queuecommand,
 	.eh_abort_handler	= atp870u_abort,
@@ -2713,4 +2687,39 @@ static Scsi_Host_Template driver_templat
 	.cmd_per_lun		= ATP870U_CMDLUN,
 	.use_clustering		= ENABLE_CLUSTERING,
 };
-#include "scsi_module.c"
+
+static struct pci_device_id atp870u_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, 0x8081)			  },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7610)    },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7612UW)  },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7612U)   },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7612S)   },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7612D)	  },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_AEC7612SUW) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_8060)	  },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, atp870u_id_table);
+
+static struct pci_driver atp870u_driver = {
+	.id_table	= atp870u_id_table,
+	.name		= "atp870u",
+	.probe		= atp870u_probe,
+	.remove		= __devexit_p(atp870u_remove),
+};
+
+static int __init atp870u_init(void)
+{
+	pci_register_driver(&atp870u_driver);
+	return 0;
+}
+
+static void __exit atp870u_exit(void)
+{
+	pci_unregister_driver(&atp870u_driver);
+}
+
+module_init(atp870u_init);
+module_exit(atp870u_exit);
+
Index: linux-2.6.1-mm1/drivers/scsi/atp870u.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.1-mm1/drivers/scsi/atp870u.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 atp870u.h
--- linux-2.6.1-mm1/drivers/scsi/atp870u.h	9 Jan 2004 13:15:44 -0000	1.1.1.1
+++ linux-2.6.1-mm1/drivers/scsi/atp870u.h	9 Jan 2004 13:55:15 -0000
@@ -1,4 +1,5 @@
 #ifndef _ATP870U_H
+#define _ATP870U_H

 /* $Id: atp870u.h,v 1.1.1.1 2004/01/09 13:15:44 zwane Exp $

@@ -22,20 +23,57 @@

 /* I/O Port */

-#define MAX_CDB 12
-#define MAX_SENSE 14
+#define MAX_CDB		12
+#define MAX_SENSE	14
+#define qcnt		32
+#define ATP870U_SCATTER 128
+#define ATP870U_CMDLUN 	1
+
+struct atp_unit {
+	unsigned long ioport;
+	unsigned long pciport;
+	unsigned char last_cmd;
+	unsigned char in_snd;
+	unsigned char in_int;
+	unsigned char quhdu;
+	unsigned char quendu;
+	unsigned char scam_on;
+	unsigned char global_map;
+	unsigned char chip_veru;
+	unsigned char host_idu;
+	volatile int working;
+	unsigned short wide_idu;
+	unsigned short active_idu;
+	unsigned short ultra_map;
+	unsigned short async;
+	unsigned short deviceid;
+	unsigned char ata_cdbu[16];
+	unsigned char sp[16];
+	Scsi_Cmnd *querequ[qcnt];
+	struct atp_id {
+		unsigned char dirctu;
+		unsigned char devspu;
+		unsigned char devtypeu;
+		unsigned long prdaddru;
+		unsigned long tran_lenu;
+		unsigned long last_lenu;
+		unsigned char *prd_posu;
+		unsigned char *prd_tableu;
+		dma_addr_t prd_phys;
+		Scsi_Cmnd *curr_req;
+	} id[16];
+	struct Scsi_Host *host;
+	struct pci_dev *pdev;
+	unsigned int unit;
+};

-static int atp870u_detect(Scsi_Host_Template *);
 static int atp870u_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 static int atp870u_abort(Scsi_Cmnd *);
 static int atp870u_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
-static int atp870u_release(struct Scsi_Host *);
-
-#define qcnt		32
-#define ATP870U_SCATTER 128
-#define ATP870U_CMDLUN 1
+static void send_s870(struct Scsi_Host *);

 extern const char *atp870u_info(struct Scsi_Host *);
+static Scsi_Host_Template atp870u_template;

 #endif
