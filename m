Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVLOAvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVLOAvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVLOAvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:51:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:48563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965121AbVLOAvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:51:37 -0500
Date: Wed, 14 Dec 2005 16:51:21 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.14.4
Message-ID: <20051215005121.GC4148@kroah.com>
References: <20051215005041.GB4148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215005041.GB4148@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 6e34293..f00339c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 14
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Affluent Albatross
 
 # *DOCUMENTATION*
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c6db591..681eb19 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1111,7 +1111,7 @@ acpi_add_single_object(struct acpi_devic
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	result = acpi_bus_find_driver(device);
+	acpi_bus_find_driver(device);
 
       end:
 	if (!result)
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 486b6e1..7bb1f1a 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -1016,10 +1016,11 @@ static int cciss_ioctl(struct inode *ino
 				status = -ENOMEM;
 				goto cleanup1;
 			}
-			if (ioc->Request.Type.Direction == XFER_WRITE &&
-				copy_from_user(buff[sg_used], data_ptr, sz)) {
+			if (ioc->Request.Type.Direction == XFER_WRITE) {
+				if (copy_from_user(buff[sg_used], data_ptr, sz)) {
 					status = -ENOMEM;
-					goto cleanup1;			
+					goto cleanup1;
+				}
 			} else {
 				memset(buff[sg_used], 0, sz);
 			}
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index a9fb12c..5396897 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -242,13 +242,27 @@ static int serverworks_fetch_size(void)
  */
 static void serverworks_tlbflush(struct agp_memory *temp)
 {
+	unsigned long timeout;
+
 	writeb(1, serverworks_private.registers+SVWRKS_POSTFLUSH);
-	while (readb(serverworks_private.registers+SVWRKS_POSTFLUSH) == 1)
+	timeout = jiffies + 3*HZ;
+	while (readb(serverworks_private.registers+SVWRKS_POSTFLUSH) == 1) {
 		cpu_relax();
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR PFX "TLB post flush took more than 3 seconds\n");
+			break;
+		}
+	}
 
 	writel(1, serverworks_private.registers+SVWRKS_DIRFLUSH);
-	while(readl(serverworks_private.registers+SVWRKS_DIRFLUSH) == 1)
+	timeout = jiffies + 3*HZ;
+	while (readl(serverworks_private.registers+SVWRKS_DIRFLUSH) == 1) {
 		cpu_relax();
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR PFX "TLB Dir flush took more than 3 seconds\n");
+			break;
+		}
+	}
 }
 
 static int serverworks_configure(void)
diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index 6c4b3f9..f3c3aaf 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -99,7 +99,9 @@ struct smm_regs {
 
 static inline char *i8k_get_dmi_data(int field)
 {
-	return dmi_get_system_info(field) ? : "N/A";
+	char *dmi_data = dmi_get_system_info(field);
+
+	return dmi_data && *dmi_data ? dmi_data : "?";
 }
 
 /*
@@ -396,7 +398,7 @@ static int i8k_proc_show(struct seq_file
 	return seq_printf(seq, "%s %s %s %d %d %d %d %d %d %d\n",
 			  I8K_PROC_FMT,
 			  bios_version,
-			  dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
+			  i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
 			  cpu_temp,
 			  left_fan, right_fan, left_speed, right_speed,
 			  ac_power, fn_key);
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 1d44f69..24011e7 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -80,6 +80,9 @@ do_kdsk_ioctl(int cmd, struct kbentry __
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
 
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
 	switch (cmd) {
 	case KDGKBENT:
 		key_map = key_maps[s];
@@ -192,6 +195,9 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
 	int i, j, k;
 	int ret;
 
+	if (!capable(CAP_SYS_TTY_CONFIG))
+		perm = 0;
+
 	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
 	if (!kbs) {
 		ret = -ENOMEM;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 29c22fc..f53658b 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2038,11 +2038,9 @@ static int idefloppy_ioctl(struct inode 
 	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	int err;
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
-	if (err != -EINVAL)
-		return err;
 
 	switch (cmd) {
 	case CDROMEJECT:
@@ -2094,7 +2092,7 @@ static int idefloppy_ioctl(struct inode 
 	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
 		return idefloppy_get_format_progress(drive, argp);
 	}
- 	return -EINVAL;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }
 
 static int idefloppy_media_changed(struct gendisk *disk)
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index a14ca87..96855fc 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -356,9 +356,9 @@ error4:
 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 	kfree(reg_req);
 error3:
-	kfree(mad_agent_priv);
-error2:
 	ib_dereg_mr(mad_agent_priv->agent.mr);
+error2:
+	kfree(mad_agent_priv);
 error1:
 	return ret;
 }
diff --git a/drivers/media/dvb/ttpci/Kconfig b/drivers/media/dvb/ttpci/Kconfig
index d8bf658..fa5034a 100644
--- a/drivers/media/dvb/ttpci/Kconfig
+++ b/drivers/media/dvb/ttpci/Kconfig
@@ -81,6 +81,7 @@ config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
 	depends on DVB_CORE && PCI
 	select VIDEO_SAA7146
+	select DVB_STV0297
 	select DVB_STV0299
 	select DVB_TDA1004X
 	help
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 4da91d5..7aa8566 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -567,6 +567,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -711,6 +712,7 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index acc7a43..3a85d41 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -972,7 +972,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER,
+		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887_PORT2_ACTIVE,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 3,
diff --git a/drivers/message/i2o/pci.c b/drivers/message/i2o/pci.c
index 66c03e8..81ef306 100644
--- a/drivers/message/i2o/pci.c
+++ b/drivers/message/i2o/pci.c
@@ -421,8 +421,8 @@ static int __devinit i2o_pci_probe(struc
 	i2o_pci_free(c);
 
       free_controller:
-	i2o_iop_free(c);
 	put_device(c->device.parent);
+	i2o_iop_free(c);
 
       disable:
 	pci_disable_device(pdev);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f264ff1..519b4a9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1604,35 +1604,27 @@ static int bond_sethwaddr(struct net_dev
 	(NETIF_F_SG|NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM)
 
 /* 
- * Compute the features available to the bonding device by 
- * intersection of all of the slave devices' BOND_INTERSECT_FEATURES.
- * Call this after attaching or detaching a slave to update the 
- * bond's features.
+ * Compute the common dev->feature set available to all slaves.  Some
+ * feature bits are managed elsewhere, so preserve feature bits set on
+ * master device that are not part of the examined set.
  */
 static int bond_compute_features(struct bonding *bond)
 {
-	int i;
+	unsigned long features = BOND_INTERSECT_FEATURES;
 	struct slave *slave;
 	struct net_device *bond_dev = bond->dev;
-	int features = bond->bond_features;
+	int i;
 
-	bond_for_each_slave(bond, slave, i) {
-		struct net_device * slave_dev = slave->dev;
-		if (i == 0) {
-			features |= BOND_INTERSECT_FEATURES;
-		}
-		features &=
-			~(~slave_dev->features & BOND_INTERSECT_FEATURES);
-	}
+	bond_for_each_slave(bond, slave, i)
+		features &= (slave->dev->features & BOND_INTERSECT_FEATURES);
 
-	/* turn off NETIF_F_SG if we need a csum and h/w can't do it */
 	if ((features & NETIF_F_SG) && 
-		!(features & (NETIF_F_IP_CSUM |
-			      NETIF_F_NO_CSUM |
-			      NETIF_F_HW_CSUM))) {
+	    !(features & (NETIF_F_IP_CSUM |
+			  NETIF_F_NO_CSUM |
+			  NETIF_F_HW_CSUM)))
 		features &= ~NETIF_F_SG;
-	}
 
+	features |= (bond_dev->features & ~BOND_INTERSECT_FEATURES);
 	bond_dev->features = features;
 
 	return 0;
@@ -4508,8 +4500,6 @@ static int __init bond_init(struct net_d
 			       NETIF_F_HW_VLAN_RX |
 			       NETIF_F_HW_VLAN_FILTER);
 
-	bond->bond_features = bond_dev->features;
-
 #ifdef CONFIG_PROC_FS
 	bond_create_proc_entry(bond);
 #endif
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
index bbf9da8..1433e91 100644
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -40,8 +40,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"2.6.4"
-#define DRV_RELDATE	"September 26, 2005"
+#define DRV_VERSION	"2.6.5"
+#define DRV_RELDATE	"November 4, 2005"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
@@ -211,9 +211,6 @@ struct bonding {
 	struct   bond_params params;
 	struct   list_head vlan_list;
 	struct   vlan_group *vlgrp;
-	/* the features the bonding device supports, independently 
-	 * of any slaves */
-	int	 bond_features; 
 };
 
 /**
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index a713015..7d9898f 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1382,6 +1382,7 @@ static int __init init_i82365(void)
     if (sockets == 0) {
 	printk("not found.\n");
 	platform_device_unregister(&i82365_device);
+	release_region(i365_base, 2);
 	driver_unregister(&i82365_driver);
 	return -ENODEV;
     }
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 7235f94..8a603ea 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -816,7 +816,7 @@ static int adpt_hba_reset(adpt_hba* pHba
 static void adpt_i2o_sys_shutdown(void)
 {
 	adpt_hba *pHba, *pNext;
-	struct adpt_i2o_post_wait_data *p1, *p2;
+	struct adpt_i2o_post_wait_data *p1, *old;
 
 	 printk(KERN_INFO"Shutting down Adaptec I2O controllers.\n");
 	 printk(KERN_INFO"   This could take a few minutes if there are many devices attached\n");
@@ -830,13 +830,14 @@ static void adpt_i2o_sys_shutdown(void)
 	}
 
 	/* Remove any timedout entries from the wait queue.  */
-	p2 = NULL;
 //	spin_lock_irqsave(&adpt_post_wait_lock, flags);
 	/* Nothing should be outstanding at this point so just
 	 * free them 
 	 */
-	for(p1 = adpt_post_wait_queue; p1; p2 = p1, p1 = p2->next) {
-		kfree(p1);
+	for(p1 = adpt_post_wait_queue; p1;) {
+		old = p1;
+		p1 = p1->next;
+		kfree(old);
 	}
 //	spin_unlock_irqrestore(&adpt_post_wait_lock, flags);
 	adpt_post_wait_queue = NULL;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e5b0199..f9e9973 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3916,8 +3916,6 @@ static void ata_host_init(struct ata_por
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
 
-	scsi_assign_lock(host, &host_set->lock);
-
 	ap->flags = ATA_FLAG_PORT_DISABLED;
 	ap->id = host->unique_id;
 	ap->host = host;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 104fd9a..112317e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -39,6 +39,7 @@
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include <asm/uaccess.h>
 
@@ -1565,8 +1566,12 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	struct ata_port *ap;
 	struct ata_device *dev;
 	struct scsi_device *scsidev = cmd->device;
+	struct Scsi_Host *shost = scsidev->host;
 
-	ap = (struct ata_port *) &scsidev->host->hostdata[0];
+	ap = (struct ata_port *) &shost->hostdata[0];
+
+	spin_unlock(shost->host_lock);
+	spin_lock(&ap->host_set->lock);
 
 	ata_scsi_dump_cdb(ap, cmd);
 
@@ -1589,6 +1594,8 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
 out_unlock:
+	spin_unlock(&ap->host_set->lock);
+	spin_lock(shost->host_lock);
 	return 0;
 }
 
diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index c84e148..e697dd7 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -327,6 +327,18 @@ static inline void mts_urb_abort(struct 
 	usb_kill_urb( desc->urb );
 }
 
+static int mts_slave_alloc (struct scsi_device *s)
+{
+	s->inquiry_len = 0x24;
+	return 0;
+}
+
+static int mts_slave_configure (struct scsi_device *s)
+{
+	blk_queue_dma_alignment(s->request_queue, (512 - 1));
+	return 0;
+}
+
 static int mts_scsi_abort (Scsi_Cmnd *srb)
 {
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
@@ -411,7 +423,7 @@ static void mts_transfer_done( struct ur
 	MTS_INT_INIT();
 
 	context->srb->result &= MTS_SCSI_ERR_MASK;
-	context->srb->result |= (unsigned)context->status<<1;
+	context->srb->result |= (unsigned)(*context->scsi_status)<<1;
 
 	mts_transfer_cleanup(transfer);
 
@@ -427,7 +439,7 @@ static void mts_get_status( struct urb *
 	mts_int_submit_urb(transfer,
 			   usb_rcvbulkpipe(context->instance->usb_dev,
 					   context->instance->ep_response),
-			   &context->status,
+			   context->scsi_status,
 			   1,
 			   mts_transfer_done );
 }
@@ -481,7 +493,7 @@ static void mts_command_done( struct urb
 					   context->data_pipe,
 					   context->data,
 					   context->data_length,
-					   context->srb->use_sg ? mts_do_sg : mts_data_done);
+					   context->srb->use_sg > 1 ? mts_do_sg : mts_data_done);
 		} else {
 			mts_get_status(transfer);
 		}
@@ -627,7 +639,6 @@ int mts_scsi_queuecommand( Scsi_Cmnd *sr
 			callback(srb);
 
 	}
-
 out:
 	return err;
 }
@@ -645,6 +656,9 @@ static Scsi_Host_Template mts_scsi_host_
 	.cmd_per_lun =		1,
 	.use_clustering =	1,
 	.emulated =		1,
+	.slave_alloc =		mts_slave_alloc,
+	.slave_configure =	mts_slave_configure,
+	.max_sectors=		256, /* 128 K */
 };
 
 struct vendor_product
@@ -782,6 +796,10 @@ static int mts_usb_probe(struct usb_inte
 	if (!new_desc->urb)
 		goto out_kfree;
 
+	new_desc->context.scsi_status = kmalloc(1, GFP_KERNEL);
+	if (!new_desc->context.scsi_status)
+		goto out_kfree2;
+
 	new_desc->usb_dev = dev;
 	new_desc->usb_intf = intf;
 	init_MUTEX(&new_desc->lock);
@@ -818,6 +836,8 @@ static int mts_usb_probe(struct usb_inte
 	usb_set_intfdata(intf, new_desc);
 	return 0;
 
+ out_kfree2:
+	kfree(new_desc->context.scsi_status);
  out_free_urb:
 	usb_free_urb(new_desc->urb);
  out_kfree:
@@ -837,6 +857,7 @@ static void mts_usb_disconnect (struct u
 
 	scsi_host_put(desc->host);
 	usb_free_urb(desc->urb);
+	kfree(desc->context.scsi_status);
 	kfree(desc);
 }
 
@@ -857,5 +878,3 @@ module_exit(microtek_drv_exit);
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
-
-
diff --git a/drivers/usb/image/microtek.h b/drivers/usb/image/microtek.h
index 3271deb..926d4bd 100644
--- a/drivers/usb/image/microtek.h
+++ b/drivers/usb/image/microtek.h
@@ -22,7 +22,7 @@ struct mts_transfer_context
 	int data_pipe;
 	int fragment;
 
-	u8 status; /* status returned from ep_response after command completion */
+	u8 *scsi_status; /* status returned from ep_response after command completion */
 };
 
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 3f9c64b..a7bfacf 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -243,7 +243,7 @@ listxattr(struct dentry *d, char __user 
 		error = d->d_inode->i_op->listxattr(d, klist, size);
 	} else {
 		error = security_inode_listsecurity(d->d_inode, klist, size);
-		if (size && error >= size)
+		if (size && error > size)
 			error = -ERANGE;
 	}
 	if (error > 0) {
diff --git a/include/linux/cciss_ioctl.h b/include/linux/cciss_ioctl.h
index 424d5e6..6e27f42 100644
--- a/include/linux/cciss_ioctl.h
+++ b/include/linux/cciss_ioctl.h
@@ -10,8 +10,8 @@
 typedef struct _cciss_pci_info_struct
 {
 	unsigned char 	bus;
-	unsigned short	domain;
 	unsigned char 	dev_fn;
+	unsigned short	domain;
 	__u32 		board_id;
 } cciss_pci_info_struct; 
 
diff --git a/kernel/audit.c b/kernel/audit.c
index aefa73a..ddf97e6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -291,8 +291,10 @@ int kauditd_thread(void *dummy)
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&kauditd_wait, &wait);
 
-			if (!skb_queue_len(&audit_skb_queue))
+			if (!skb_queue_len(&audit_skb_queue)) {
+				try_to_freeze();
 				schedule();
+			}
 
 			__set_current_state(TASK_RUNNING);
 			remove_wait_queue(&kauditd_wait, &wait);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index fcfc456..260165f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -238,7 +238,8 @@ int access_process_vm(struct task_struct
 		if (write) {
 			copy_to_user_page(vma, page, addr,
 					  maddr + offset, buf, bytes);
-			set_page_dirty_lock(page);
+			if (!PageCompound(page))
+				set_page_dirty_lock(page);
 		} else {
 			copy_from_user_page(vma, page, addr,
 					    buf, maddr + offset, bytes);
diff --git a/mm/truncate.c b/mm/truncate.c
index 60c8764..0dff870 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -291,8 +291,8 @@ int invalidate_inode_pages2_range(struct
 					 * Zap the rest of the file in one hit.
 					 */
 					unmap_mapping_range(mapping,
-					    page_index << PAGE_CACHE_SHIFT,
-					    (end - page_index + 1)
+					   (loff_t)page_index<<PAGE_CACHE_SHIFT,
+					   (loff_t)(end - page_index + 1)
 							<< PAGE_CACHE_SHIFT,
 					    0);
 					did_range_unmap = 1;
@@ -301,7 +301,7 @@ int invalidate_inode_pages2_range(struct
 					 * Just zap this page
 					 */
 					unmap_mapping_range(mapping,
-					  page_index << PAGE_CACHE_SHIFT,
+					  (loff_t)page_index<<PAGE_CACHE_SHIFT,
 					  PAGE_CACHE_SIZE, 0);
 				}
 			}
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index defcf6a..975abe2 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -366,6 +366,7 @@ int br_add_if(struct net_bridge *br, str
 
 		spin_lock_bh(&br->lock);
 		br_stp_recalculate_bridge_id(br);
+		br_features_recompute(br);
 		if ((br->dev->flags & IFF_UP) 
 		    && (dev->flags & IFF_UP) && netif_carrier_ok(dev))
 			br_stp_enable_port(p);
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index e61bc71..bc6f0a3 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -545,12 +545,16 @@ static void nl_fib_input(struct sock *sk
 	struct sk_buff *skb = NULL;
         struct nlmsghdr *nlh = NULL;
 	struct fib_result_nl *frn;
-	int err;
 	u32 pid;     
 	struct fib_table *tb;
 	
-	skb = skb_recv_datagram(sk, 0, 0, &err);
+	skb = skb_dequeue(&sk->sk_receive_queue);
 	nlh = (struct nlmsghdr *)skb->data;
+	if (skb->len < NLMSG_SPACE(0) || skb->len < nlh->nlmsg_len ||
+	    nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*frn))) {
+		kfree_skb(skb);
+		return;
+	}
 	
 	frn = (struct fib_result_nl *) NLMSG_DATA(nlh);
 	tb = fib_get_table(frn->tb_id_in);
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 5c55a3b..229bced 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -62,6 +62,7 @@ static int buffer_top[SNDRV_CARDS] = {[0
 static int use_cache[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0}; /* disabled */
 static int vaio_hack[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0}; /* disabled */
 static int reset_workaround[SNDRV_CARDS];
+static int reset_workaround_2[SNDRV_CARDS];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
@@ -83,6 +84,8 @@ module_param_array(vaio_hack, bool, NULL
 MODULE_PARM_DESC(vaio_hack, "Enable workaround for Sony VAIO notebooks.");
 module_param_array(reset_workaround, bool, NULL, 0444);
 MODULE_PARM_DESC(reset_workaround, "Enable AC97 RESET workaround for some laptops.");
+module_param_array(reset_workaround_2, bool, NULL, 0444);
+MODULE_PARM_DESC(reset_workaround_2, "Enable extended AC97 RESET workaround for some other laptops.");
 
 /*
  * hw definitions
@@ -226,6 +229,7 @@ struct snd_nm256 {
 	unsigned int coeffs_current: 1;	/* coeff. table is loaded? */
 	unsigned int use_cache: 1;	/* use one big coef. table */
 	unsigned int reset_workaround: 1; /* Workaround for some laptops to avoid freeze */
+	unsigned int reset_workaround_2: 1; /* Extended workaround for some other laptops to avoid freeze */
 
 	int mixer_base;			/* register offset of ac97 mixer */
 	int mixer_status_offset;	/* offset of mixer status reg. */
@@ -1199,8 +1203,11 @@ snd_nm256_ac97_reset(ac97_t *ac97)
 		/* Dell latitude LS will lock up by this */
 		snd_nm256_writeb(chip, 0x6cc, 0x87);
 	}
-	snd_nm256_writeb(chip, 0x6cc, 0x80);
-	snd_nm256_writeb(chip, 0x6cc, 0x0);
+	if (! chip->reset_workaround_2) {
+		/* Dell latitude CSx will lock up by this */
+		snd_nm256_writeb(chip, 0x6cc, 0x80);
+		snd_nm256_writeb(chip, 0x6cc, 0x0);
+	}
 }
 
 /* create an ac97 mixer interface */
@@ -1542,7 +1549,7 @@ struct nm256_quirk {
 	int type;
 };
 
-enum { NM_BLACKLISTED, NM_RESET_WORKAROUND };
+enum { NM_BLACKLISTED, NM_RESET_WORKAROUND, NM_RESET_WORKAROUND_2 };
 
 static struct nm256_quirk nm256_quirks[] __devinitdata = {
 	/* HP omnibook 4150 has cs4232 codec internally */
@@ -1551,6 +1558,8 @@ static struct nm256_quirk nm256_quirks[]
 	{ .vendor = 0x104d, .device = 0x8041, .type = NM_RESET_WORKAROUND },
 	/* Dell Latitude LS */
 	{ .vendor = 0x1028, .device = 0x0080, .type = NM_RESET_WORKAROUND },
+	/* Dell Latitude CSx */
+	{ .vendor = 0x1028, .device = 0x0091, .type = NM_RESET_WORKAROUND_2 },
 	{ } /* terminator */
 };
 
@@ -1582,6 +1591,9 @@ static int __devinit snd_nm256_probe(str
 			case NM_BLACKLISTED:
 				printk(KERN_INFO "nm256: The device is blacklisted.  Loading stopped\n");
 				return -ENODEV;
+			case NM_RESET_WORKAROUND_2:
+				reset_workaround_2[dev] = 1;
+				/* Fall-through */
 			case NM_RESET_WORKAROUND:
 				reset_workaround[dev] = 1;
 				break;
@@ -1638,6 +1650,11 @@ static int __devinit snd_nm256_probe(str
 		chip->reset_workaround = 1;
 	}
 
+	if (reset_workaround_2[dev]) {
+		snd_printdd(KERN_INFO "nm256: reset_workaround_2 activated\n");
+		chip->reset_workaround_2 = 1;
+	}
+
 	if ((err = snd_nm256_pcm(chip, 0)) < 0 ||
 	    (err = snd_nm256_mixer(chip)) < 0) {
 		snd_card_free(card);
