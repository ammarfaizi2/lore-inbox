Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUEIDe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUEIDe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 23:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUEIDe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 23:34:59 -0400
Received: from [213.133.118.2] ([213.133.118.2]:5803 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264226AbUEIDe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 23:34:28 -0400
Message-ID: <409DA6CD.2080303@shadowconnect.com>
Date: Sun, 09 May 2004 05:34:37 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Organization: Shadow Connect
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040505
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] to fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct
References: <409CC59B.3020500@shadowconnect.com> <200405081739.50871.ioe-lkml@rameria.de>
In-Reply-To: <200405081739.50871.ioe-lkml@rameria.de>
Content-Type: multipart/mixed;
 boundary="------------050509060402030100060605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050509060402030100060605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Ingo Oeser wrote:
>>the patch fixes a bug in the i2o_proc.c module, where the kernel panics, 
>>if you access /proc/i2o/iop0/lct and read more then 1024 bytes of it.
>>The problem was, that no paging was implemented by the function. This is 
>>now solved.
> What about solving this properly and using the seq_file API for this
> problem class as anywhere else in the kernel?
> Code will also get much more readable by this ;-)

Didn't know of the seq_file API. But you are right, now it looks much 
cleaner than before. Thanks for telling me!

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------050509060402030100060605
Content-Type: text/x-patch;
 name="i2o_proc-lct-access-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_proc-lct-access-bugfix.patch"

--- a/drivers/message/i2o/i2o_proc.c	2004-04-04 05:37:25.000000000 +0200
+++ b/drivers/message/i2o/i2o_proc.c	2004-05-09 05:22:56.652057832 +0200
@@ -43,6 +43,7 @@
 #include <linux/pci.h>
 #include <linux/i2o.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -64,13 +65,14 @@
 	mode_t mode;			/* mode */
 	read_proc_t *read_proc;		/* read func */
 	write_proc_t *write_proc;	/* write func */
+	struct file_operations *fops_proc;	/* file operations func */
 } i2o_proc_entry;
 
 // #define DRIVERDEBUG
 
-static int i2o_proc_read_lct(char *, char **, off_t, int, int *, void *);
-static int i2o_proc_read_hrt(char *, char **, off_t, int, int *, void *);
-static int i2o_proc_read_status(char *, char **, off_t, int, int *, void *);
+static int i2o_seq_show_lct(struct seq_file *, void *);
+static int i2o_seq_show_hrt(struct seq_file *, void *);
+static int i2o_seq_show_status(struct seq_file *, void *);
 
 static int i2o_proc_read_hw(char *, char **, off_t, int, int *, void *);
 static int i2o_proc_read_ddm_table(char *, char **, off_t, int, int *, void *);
@@ -151,20 +153,56 @@
 	0xffffffff	// All classes
 };
 
+static int i2o_seq_open_hrt(struct inode *inode, struct file *file)
+{
+	return single_open(file, i2o_seq_show_hrt, PDE(inode)->data);
+};
+
+struct file_operations i2o_seq_fops_hrt = {
+	.open	= i2o_seq_open_hrt,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
+static int i2o_seq_open_lct(struct inode *inode, struct file *file)
+{
+	return single_open(file, i2o_seq_show_lct, PDE(inode)->data);
+};
+
+struct file_operations i2o_seq_fops_lct = {
+	.open	= i2o_seq_open_lct,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
+static int i2o_seq_open_status(struct inode *inode, struct file *file)
+{
+	return single_open(file, i2o_seq_show_status, PDE(inode)->data);
+};
+
+struct file_operations i2o_seq_fops_status = {
+	.open	= i2o_seq_open_status,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
 /*
  * IOP specific entries...write field just in case someone 
  * ever wants one.
  */
 static i2o_proc_entry generic_iop_entries[] = 
 {
-	{"hrt", S_IFREG|S_IRUGO, i2o_proc_read_hrt, NULL},
-	{"lct", S_IFREG|S_IRUGO, i2o_proc_read_lct, NULL},
-	{"status", S_IFREG|S_IRUGO, i2o_proc_read_status, NULL},
-	{"hw", S_IFREG|S_IRUGO, i2o_proc_read_hw, NULL},
-	{"ddm_table", S_IFREG|S_IRUGO, i2o_proc_read_ddm_table, NULL},
-	{"driver_store", S_IFREG|S_IRUGO, i2o_proc_read_driver_store, NULL},
-	{"drivers_stored", S_IFREG|S_IRUGO, i2o_proc_read_drivers_stored, NULL},
-	{NULL, 0, NULL, NULL}
+	{"hrt", S_IFREG|S_IRUGO, NULL, NULL, &i2o_seq_fops_hrt},
+	{"lct", S_IFREG|S_IRUGO, NULL, NULL, &i2o_seq_fops_lct},
+	{"status", S_IFREG|S_IRUGO, NULL, NULL, &i2o_seq_fops_status},
+	{"hw", S_IFREG|S_IRUGO, i2o_proc_read_hw, NULL, NULL},
+	{"ddm_table", S_IFREG|S_IRUGO, i2o_proc_read_ddm_table, NULL, NULL},
+	{"driver_store", S_IFREG|S_IRUGO, i2o_proc_read_driver_store, NULL, NULL},
+	{"drivers_stored", S_IFREG|S_IRUGO, i2o_proc_read_drivers_stored, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 /*
@@ -172,18 +210,18 @@
  */
 static i2o_proc_entry generic_dev_entries[] = 
 {
-	{"groups", S_IFREG|S_IRUGO, i2o_proc_read_groups, NULL},
-	{"phys_dev", S_IFREG|S_IRUGO, i2o_proc_read_phys_device, NULL},
-	{"claimed", S_IFREG|S_IRUGO, i2o_proc_read_claimed, NULL},
-	{"users", S_IFREG|S_IRUGO, i2o_proc_read_users, NULL},
-	{"priv_msgs", S_IFREG|S_IRUGO, i2o_proc_read_priv_msgs, NULL},
-	{"authorized_users", S_IFREG|S_IRUGO, i2o_proc_read_authorized_users, NULL},
-	{"dev_identity", S_IFREG|S_IRUGO, i2o_proc_read_dev_identity, NULL},
-	{"ddm_identity", S_IFREG|S_IRUGO, i2o_proc_read_ddm_identity, NULL},
-	{"user_info", S_IFREG|S_IRUGO, i2o_proc_read_uinfo, NULL},
-	{"sgl_limits", S_IFREG|S_IRUGO, i2o_proc_read_sgl_limits, NULL},
-	{"sensors", S_IFREG|S_IRUGO, i2o_proc_read_sensors, NULL},
-	{NULL, 0, NULL, NULL}
+	{"groups", S_IFREG|S_IRUGO, i2o_proc_read_groups, NULL, NULL},
+	{"phys_dev", S_IFREG|S_IRUGO, i2o_proc_read_phys_device, NULL, NULL},
+	{"claimed", S_IFREG|S_IRUGO, i2o_proc_read_claimed, NULL, NULL},
+	{"users", S_IFREG|S_IRUGO, i2o_proc_read_users, NULL, NULL},
+	{"priv_msgs", S_IFREG|S_IRUGO, i2o_proc_read_priv_msgs, NULL, NULL},
+	{"authorized_users", S_IFREG|S_IRUGO, i2o_proc_read_authorized_users, NULL, NULL},
+	{"dev_identity", S_IFREG|S_IRUGO, i2o_proc_read_dev_identity, NULL, NULL},
+	{"ddm_identity", S_IFREG|S_IRUGO, i2o_proc_read_ddm_identity, NULL, NULL},
+	{"user_info", S_IFREG|S_IRUGO, i2o_proc_read_uinfo, NULL, NULL},
+	{"sgl_limits", S_IFREG|S_IRUGO, i2o_proc_read_sgl_limits, NULL, NULL},
+	{"sensors", S_IFREG|S_IRUGO, i2o_proc_read_sensors, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 /*
@@ -191,7 +229,7 @@
  */
 static i2o_proc_entry rbs_dev_entries[] = 
 {
-	{"dev_name", S_IFREG|S_IRUGO, i2o_proc_read_dev_name, NULL},
+	{"dev_name", S_IFREG|S_IRUGO, i2o_proc_read_dev_name, NULL, NULL},
 	{NULL, 0, NULL, NULL}
 };
 
@@ -223,21 +261,21 @@
  */
 static i2o_proc_entry lan_entries[] = 
 {
-	{"lan_dev_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_dev_info, NULL},
-	{"lan_mac_addr", S_IFREG|S_IRUGO, i2o_proc_read_lan_mac_addr, NULL},
+	{"lan_dev_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_dev_info, NULL, NULL},
+	{"lan_mac_addr", S_IFREG|S_IRUGO, i2o_proc_read_lan_mac_addr, NULL, NULL},
 	{"lan_mcast_addr", S_IFREG|S_IRUGO|S_IWUSR,
-	 i2o_proc_read_lan_mcast_addr, NULL},
+	 i2o_proc_read_lan_mcast_addr, NULL, NULL},
 	{"lan_batch_ctrl", S_IFREG|S_IRUGO|S_IWUSR,
-	 i2o_proc_read_lan_batch_control, NULL},
-	{"lan_operation", S_IFREG|S_IRUGO, i2o_proc_read_lan_operation, NULL},
+	 i2o_proc_read_lan_batch_control, NULL, NULL},
+	{"lan_operation", S_IFREG|S_IRUGO, i2o_proc_read_lan_operation, NULL, NULL},
 	{"lan_media_operation", S_IFREG|S_IRUGO,
-	 i2o_proc_read_lan_media_operation, NULL},
-	{"lan_alt_addr", S_IFREG|S_IRUGO, i2o_proc_read_lan_alt_addr, NULL},
-	{"lan_tx_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_tx_info, NULL},
-	{"lan_rx_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_rx_info, NULL},
+	 i2o_proc_read_lan_media_operation, NULL, NULL},
+	{"lan_alt_addr", S_IFREG|S_IRUGO, i2o_proc_read_lan_alt_addr, NULL, NULL},
+	{"lan_tx_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_tx_info, NULL, NULL},
+	{"lan_rx_info", S_IFREG|S_IRUGO, i2o_proc_read_lan_rx_info, NULL, NULL},
 
-	{"lan_hist_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_hist_stats, NULL},
-	{NULL, 0, NULL, NULL}
+	{"lan_hist_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_hist_stats, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 /*
@@ -246,20 +284,20 @@
  */
 static i2o_proc_entry lan_eth_entries[] = 
 {
-	{"lan_eth_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_eth_stats, NULL},
-	{NULL, 0, NULL, NULL}
+	{"lan_eth_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_eth_stats, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 static i2o_proc_entry lan_tr_entries[] = 
 {
-	{"lan_tr_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_tr_stats, NULL},
-	{NULL, 0, NULL, NULL}
+	{"lan_tr_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_tr_stats, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 static i2o_proc_entry lan_fddi_entries[] = 
 {
-	{"lan_fddi_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_fddi_stats, NULL},
-	{NULL, 0, NULL, NULL}
+	{"lan_fddi_stats", S_IFREG|S_IRUGO, i2o_proc_read_lan_fddi_stats, NULL, NULL},
+	{NULL, 0, NULL, NULL, NULL}
 };
 
 
@@ -300,116 +338,98 @@
 
 static spinlock_t i2o_proc_lock = SPIN_LOCK_UNLOCKED;
 
-int i2o_proc_read_hrt(char *buf, char **start, off_t offset, int count, 
-		      int *eof, void *data)
+int i2o_seq_show_hrt(struct seq_file *seq, void *v)
 {
-	struct i2o_controller *c = (struct i2o_controller *)data;
+	struct i2o_controller *c = (struct i2o_controller *)seq->private;
 	i2o_hrt *hrt = (i2o_hrt *)c->hrt;
 	u32 bus;
-	int len, i;
-
-	spin_lock(&i2o_proc_lock);
-
-	len = 0;
+	int i;
 
 	if(hrt->hrt_version)
 	{
-		len += sprintf(buf+len, 
-			       "HRT table for controller is too new a version.\n");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		seq_printf(seq, "HRT table for controller is too new a version.\n");
+		return 0;
 	}
 
-	if((hrt->num_entries * hrt->entry_len + 8) > 2048) {
-		printk(KERN_WARNING "i2o_proc: HRT does not fit into buffer\n");
-		len += sprintf(buf+len,
-			       "HRT table too big to fit in buffer.\n");
-		spin_unlock(&i2o_proc_lock);
-		return len;
-	}
-	
-	len += sprintf(buf+len, "HRT has %d entries of %d bytes each.\n",
+	seq_printf(seq, "HRT has %d entries of %d bytes each.\n",
 		       hrt->num_entries, hrt->entry_len << 2);
 
-	for(i = 0; i < hrt->num_entries && len < count; i++)
+	for(i = 0; i < hrt->num_entries; i++)
 	{
-		len += sprintf(buf+len, "Entry %d:\n", i);
-		len += sprintf(buf+len, "   Adapter ID: %0#10x\n", 
+		seq_printf(seq, "Entry %d:\n", i);
+		seq_printf(seq, "   Adapter ID: %0#10x\n", 
 					hrt->hrt_entry[i].adapter_id);
-		len += sprintf(buf+len, "   Controlling tid: %0#6x\n",
+		seq_printf(seq, "   Controlling tid: %0#6x\n",
 					hrt->hrt_entry[i].parent_tid);
 
 		if(hrt->hrt_entry[i].bus_type != 0x80)
 		{
 			bus = hrt->hrt_entry[i].bus_type;
-			len += sprintf(buf+len, "   %s Information\n", bus_strings[bus]);
+			seq_printf(seq, "   %s Information\n", bus_strings[bus]);
 
 			switch(bus)
 			{
 				case I2O_BUS_LOCAL:
-					len += sprintf(buf+len, "     IOBase: %0#6x,",
+					seq_printf(seq, "     IOBase: %0#6x,",
 								hrt->hrt_entry[i].bus.local_bus.LbBaseIOPort);
-					len += sprintf(buf+len, " MemoryBase: %0#10x\n",
+					seq_printf(seq, " MemoryBase: %0#10x\n",
 								hrt->hrt_entry[i].bus.local_bus.LbBaseMemoryAddress);
 					break;
 
 				case I2O_BUS_ISA:
-					len += sprintf(buf+len, "     IOBase: %0#6x,",
+					seq_printf(seq, "     IOBase: %0#6x,",
 								hrt->hrt_entry[i].bus.isa_bus.IsaBaseIOPort);
-					len += sprintf(buf+len, " MemoryBase: %0#10x,",
+					seq_printf(seq, " MemoryBase: %0#10x,",
 								hrt->hrt_entry[i].bus.isa_bus.IsaBaseMemoryAddress);
-					len += sprintf(buf+len, " CSN: %0#4x,",
+					seq_printf(seq, " CSN: %0#4x,",
 								hrt->hrt_entry[i].bus.isa_bus.CSN);
 					break;
 
 				case I2O_BUS_EISA:
-					len += sprintf(buf+len, "     IOBase: %0#6x,",
+					seq_printf(seq, "     IOBase: %0#6x,",
 								hrt->hrt_entry[i].bus.eisa_bus.EisaBaseIOPort);
-					len += sprintf(buf+len, " MemoryBase: %0#10x,",
+					seq_printf(seq, " MemoryBase: %0#10x,",
 								hrt->hrt_entry[i].bus.eisa_bus.EisaBaseMemoryAddress);
-					len += sprintf(buf+len, " Slot: %0#4x,",
+					seq_printf(seq, " Slot: %0#4x,",
 								hrt->hrt_entry[i].bus.eisa_bus.EisaSlotNumber);
 					break;
 			 
 				case I2O_BUS_MCA:
-					len += sprintf(buf+len, "     IOBase: %0#6x,",
+					seq_printf(seq, "     IOBase: %0#6x,",
 								hrt->hrt_entry[i].bus.mca_bus.McaBaseIOPort);
-					len += sprintf(buf+len, " MemoryBase: %0#10x,",
+					seq_printf(seq, " MemoryBase: %0#10x,",
 								hrt->hrt_entry[i].bus.mca_bus.McaBaseMemoryAddress);
-					len += sprintf(buf+len, " Slot: %0#4x,",
+					seq_printf(seq, " Slot: %0#4x,",
 								hrt->hrt_entry[i].bus.mca_bus.McaSlotNumber);
 					break;
 
 				case I2O_BUS_PCI:
-					len += sprintf(buf+len, "     Bus: %0#4x",
+					seq_printf(seq, "     Bus: %0#4x",
 								hrt->hrt_entry[i].bus.pci_bus.PciBusNumber);
-					len += sprintf(buf+len, " Dev: %0#4x",
+					seq_printf(seq, " Dev: %0#4x",
 								hrt->hrt_entry[i].bus.pci_bus.PciDeviceNumber);
-					len += sprintf(buf+len, " Func: %0#4x",
+					seq_printf(seq, " Func: %0#4x",
 								hrt->hrt_entry[i].bus.pci_bus.PciFunctionNumber);
-					len += sprintf(buf+len, " Vendor: %0#6x",
+					seq_printf(seq, " Vendor: %0#6x",
 								hrt->hrt_entry[i].bus.pci_bus.PciVendorID);
-					len += sprintf(buf+len, " Device: %0#6x\n",
+					seq_printf(seq, " Device: %0#6x\n",
 								hrt->hrt_entry[i].bus.pci_bus.PciDeviceID);
 					break;
 
 				default:
-					len += sprintf(buf+len, "      Unsupported Bus Type\n");
+					seq_printf(seq, "      Unsupported Bus Type\n");
 			}
 		}
 		else
-			len += sprintf(buf+len, "   Unknown Bus Type\n");
+			seq_printf(seq, "   Unknown Bus Type\n");
 	}
-
-	spin_unlock(&i2o_proc_lock);
 	
-	return len;
+	return 0;
 }
 
-int i2o_proc_read_lct(char *buf, char **start, off_t offset, int len,
-	int *eof, void *data)
+int i2o_seq_show_lct(struct seq_file *seq, void *v)
 {
-	struct i2o_controller *c = (struct i2o_controller*)data;
+	struct i2o_controller *c = (struct i2o_controller*)seq->private;
 	i2o_lct *lct = (i2o_lct *)c->lct;
 	int entries;
 	int i;
@@ -422,23 +442,19 @@
 		"Fibre Channel Bus"
 	};
 
-	spin_lock(&i2o_proc_lock);
-	len = 0;
-
 	entries = (lct->table_size - 3)/9;
 
-	len += sprintf(buf, "LCT contains %d %s\n", entries,
+	seq_printf(seq, "LCT contains %d %s\n", entries,
 						entries == 1 ? "entry" : "entries");
 	if(lct->boot_tid)	
-		len += sprintf(buf+len, "Boot Device @ ID %d\n", lct->boot_tid);
+		seq_printf(seq, "Boot Device @ ID %d\n", lct->boot_tid);
 
-	len += 
-		sprintf(buf+len, "Current Change Indicator: %#10x\n", lct->change_ind);
+	seq_printf(seq, "Current Change Indicator: %#10x\n", lct->change_ind);
 
 	for(i = 0; i < entries; i++)
 	{
-		len += sprintf(buf+len, "Entry %d\n", i);
-		len += sprintf(buf+len, "  Class, SubClass  : %s", i2o_get_class_name(lct->lct_entry[i].class_id));
+		seq_printf(seq, "Entry %d\n", i);
+		seq_printf(seq, "  Class, SubClass  : %s", i2o_get_class_name(lct->lct_entry[i].class_id));
 	
 		/*
 		 *	Classes which we'll print subclass info for
@@ -449,23 +465,23 @@
 				switch(lct->lct_entry[i].sub_class)
 				{
 					case 0x00:
-						len += sprintf(buf+len, ", Direct-Access Read/Write");
+						seq_printf(seq, ", Direct-Access Read/Write");
 						break;
 
 					case 0x04:
-						len += sprintf(buf+len, ", WORM Drive");
+						seq_printf(seq, ", WORM Drive");
 						break;
 	
 					case 0x05:
-						len += sprintf(buf+len, ", CD-ROM Drive");
+						seq_printf(seq, ", CD-ROM Drive");
 						break;
 
 					case 0x07:
-						len += sprintf(buf+len, ", Optical Memory Device");
+						seq_printf(seq, ", Optical Memory Device");
 						break;
 
 					default:
-						len += sprintf(buf+len, ", Unknown (0x%02x)",
+						seq_printf(seq, ", Unknown (0x%02x)",
 							       lct->lct_entry[i].sub_class);
 						break;
 				}
@@ -475,27 +491,27 @@
 				switch(lct->lct_entry[i].sub_class & 0xFF)
 				{
 					case 0x30:
-						len += sprintf(buf+len, ", Ethernet");
+						seq_printf(seq, ", Ethernet");
 						break;
 
 					case 0x40:
-						len += sprintf(buf+len, ", 100base VG");
+						seq_printf(seq, ", 100base VG");
 						break;
 
 					case 0x50:
-						len += sprintf(buf+len, ", IEEE 802.5/Token-Ring");
+						seq_printf(seq, ", IEEE 802.5/Token-Ring");
 						break;
 
 					case 0x60:
-						len += sprintf(buf+len, ", ANSI X3T9.5 FDDI");
+						seq_printf(seq, ", ANSI X3T9.5 FDDI");
 						break;
 		
 					case 0x70:
-						len += sprintf(buf+len, ", Fibre Channel");
+						seq_printf(seq, ", Fibre Channel");
 						break;
 
 					default:
-						len += sprintf(buf+len, ", Unknown Sub-Class (0x%02x)",
+						seq_printf(seq, ", Unknown Sub-Class (0x%02x)",
 							       lct->lct_entry[i].sub_class & 0xFF);
 						break;
 				}
@@ -503,27 +519,27 @@
 
 			case I2O_CLASS_SCSI_PERIPHERAL:
 				if(lct->lct_entry[i].sub_class < SCSI_TABLE_SIZE)
-					len += sprintf(buf+len, ", %s", 
+					seq_printf(seq, ", %s", 
 								scsi_devices[lct->lct_entry[i].sub_class]);
 				else
-					len += sprintf(buf+len, ", Unknown Device Type");
+					seq_printf(seq, ", Unknown Device Type");
 				break;
 
 			case I2O_CLASS_BUS_ADAPTER_PORT:
 				if(lct->lct_entry[i].sub_class < BUS_TABLE_SIZE)
-					len += sprintf(buf+len, ", %s", 
+					seq_printf(seq, ", %s", 
 								bus_ports[lct->lct_entry[i].sub_class]);
 				else
-					len += sprintf(buf+len, ", Unknown Bus Type");
+					seq_printf(seq, ", Unknown Bus Type");
 				break;
 		}
-		len += sprintf(buf+len, "\n");
+		seq_printf(seq, "\n");
 		
-		len += sprintf(buf+len, "  Local TID        : 0x%03x\n", lct->lct_entry[i].tid);
-		len += sprintf(buf+len, "  User TID         : 0x%03x\n", lct->lct_entry[i].user_tid);
-		len += sprintf(buf+len, "  Parent TID       : 0x%03x\n", 
+		seq_printf(seq, "  Local TID        : 0x%03x\n", lct->lct_entry[i].tid);
+		seq_printf(seq, "  User TID         : 0x%03x\n", lct->lct_entry[i].user_tid);
+		seq_printf(seq, "  Parent TID       : 0x%03x\n", 
 					lct->lct_entry[i].parent_tid);
-		len += sprintf(buf+len, "  Identity Tag     : 0x%x%x%x%x%x%x%x%x\n",
+		seq_printf(seq, "  Identity Tag     : 0x%x%x%x%x%x%x%x%x\n",
 					lct->lct_entry[i].identity_tag[0],
 					lct->lct_entry[i].identity_tag[1],
 					lct->lct_entry[i].identity_tag[2],
@@ -532,214 +548,207 @@
 					lct->lct_entry[i].identity_tag[5],
 					lct->lct_entry[i].identity_tag[6],
 					lct->lct_entry[i].identity_tag[7]);
-		len += sprintf(buf+len, "  Change Indicator : %0#10x\n", 
+		seq_printf(seq, "  Change Indicator : %0#10x\n", 
 				lct->lct_entry[i].change_ind);
-		len += sprintf(buf+len, "  Event Capab Mask : %0#10x\n", 
+		seq_printf(seq, "  Event Capab Mask : %0#10x\n", 
 				lct->lct_entry[i].device_flags);
 	}
 
-	spin_unlock(&i2o_proc_lock);
-	return len;
+	return 0;
 }
 
-int i2o_proc_read_status(char *buf, char **start, off_t offset, int len, 
-			 int *eof, void *data)
+int i2o_seq_show_status(struct seq_file *seq, void *v)
 {
-	struct i2o_controller *c = (struct i2o_controller*)data;
+	struct i2o_controller *c = (struct i2o_controller*)seq->private;
 	char prodstr[25];
 	int version;
 	
-	spin_lock(&i2o_proc_lock);
-	len = 0;
-
 	i2o_status_get(c); // reread the status block
 
-	len += sprintf(buf+len,"Organization ID        : %0#6x\n", 
+	seq_printf(seq, "Organization ID        : %0#6x\n", 
 				c->status_block->org_id);
 
 	version = c->status_block->i2o_version;
 	
 /* FIXME for Spec 2.0
 	if (version == 0x02) {
-		len += sprintf(buf+len,"Lowest I2O version supported: ");
+		seq_printf(seq, "Lowest I2O version supported: ");
 		switch(workspace[2]) {
 			case 0x00:
-				len += sprintf(buf+len,"1.0\n");
+				seq_printf(seq, "1.0\n");
 				break;
 			case 0x01:
-				len += sprintf(buf+len,"1.5\n");
+				seq_printf(seq, "1.5\n");
 				break;
 			case 0x02:
-				len += sprintf(buf+len,"2.0\n");
+				seq_printf(seq, "2.0\n");
 				break;
 		}
 
-		len += sprintf(buf+len, "Highest I2O version supported: ");
+		seq_printf(seq, "Highest I2O version supported: ");
 		switch(workspace[3]) {
 			case 0x00:
-				len += sprintf(buf+len,"1.0\n");
+				seq_printf(seq, "1.0\n");
 				break;
 			case 0x01:
-				len += sprintf(buf+len,"1.5\n");
+				seq_printf(seq, "1.5\n");
 				break;
 			case 0x02:
-				len += sprintf(buf+len,"2.0\n");
+				seq_printf(seq, "2.0\n");
 				break;
 		}
 	}
 */
-	len += sprintf(buf+len,"IOP ID                 : %0#5x\n", 
+	seq_printf(seq, "IOP ID                 : %0#5x\n", 
 				c->status_block->iop_id);
-	len += sprintf(buf+len,"Host Unit ID           : %0#6x\n",
+	seq_printf(seq, "Host Unit ID           : %0#6x\n",
 				c->status_block->host_unit_id);
-	len += sprintf(buf+len,"Segment Number         : %0#5x\n",
+	seq_printf(seq, "Segment Number         : %0#5x\n",
 				c->status_block->segment_number);
 
-	len += sprintf(buf+len, "I2O version            : ");
+	seq_printf(seq, "I2O version            : ");
 	switch (version) {
 		case 0x00:
-			len += sprintf(buf+len,"1.0\n");
+			seq_printf(seq, "1.0\n");
 			break;
 		case 0x01:
-			len += sprintf(buf+len,"1.5\n");
+			seq_printf(seq, "1.5\n");
 			break;
 		case 0x02:
-			len += sprintf(buf+len,"2.0\n");
+			seq_printf(seq, "2.0\n");
 			break;
 		default:
-			len += sprintf(buf+len,"Unknown version\n");
+			seq_printf(seq, "Unknown version\n");
 	}
 
-	len += sprintf(buf+len, "IOP State              : ");
+	seq_printf(seq, "IOP State              : ");
 	switch (c->status_block->iop_state) {
 		case 0x01:
-			len += sprintf(buf+len,"INIT\n");
+			seq_printf(seq, "INIT\n");
 			break;
 
 		case 0x02:
-			len += sprintf(buf+len,"RESET\n");
+			seq_printf(seq, "RESET\n");
 			break;
 
 		case 0x04:
-			len += sprintf(buf+len,"HOLD\n");
+			seq_printf(seq, "HOLD\n");
 			break;
 
 		case 0x05:
-			len += sprintf(buf+len,"READY\n");
+			seq_printf(seq, "READY\n");
 			break;
 
 		case 0x08:
-			len += sprintf(buf+len,"OPERATIONAL\n");
+			seq_printf(seq, "OPERATIONAL\n");
 			break;
 
 		case 0x10:
-			len += sprintf(buf+len,"FAILED\n");
+			seq_printf(seq, "FAILED\n");
 			break;
 
 		case 0x11:
-			len += sprintf(buf+len,"FAULTED\n");
+			seq_printf(seq, "FAULTED\n");
 			break;
 
 		default:
-			len += sprintf(buf+len,"Unknown\n");
+			seq_printf(seq, "Unknown\n");
 			break;
 	}
 
-	len += sprintf(buf+len,"Messenger Type         : ");
+	seq_printf(seq, "Messenger Type         : ");
 	switch (c->status_block->msg_type) { 
 		case 0x00:
-			len += sprintf(buf+len,"Memory mapped\n");
+			seq_printf(seq, "Memory mapped\n");
 			break;
 		case 0x01:
-			len += sprintf(buf+len,"Memory mapped only\n");
+			seq_printf(seq, "Memory mapped only\n");
 			break;
 		case 0x02:
-			len += sprintf(buf+len,"Remote only\n");
+			seq_printf(seq,"Remote only\n");
 			break;
 		case 0x03:
-			len += sprintf(buf+len,"Memory mapped and remote\n");
+			seq_printf(seq, "Memory mapped and remote\n");
 			break;
 		default:
-			len += sprintf(buf+len,"Unknown\n");
+			seq_printf(seq, "Unknown\n");
 	}
 
-	len += sprintf(buf+len,"Inbound Frame Size     : %d bytes\n", 
+	seq_printf(seq, "Inbound Frame Size     : %d bytes\n", 
 				c->status_block->inbound_frame_size<<2);
-	len += sprintf(buf+len,"Max Inbound Frames     : %d\n", 
+	seq_printf(seq, "Max Inbound Frames     : %d\n", 
 				c->status_block->max_inbound_frames);
-	len += sprintf(buf+len,"Current Inbound Frames : %d\n", 
+	seq_printf(seq, "Current Inbound Frames : %d\n", 
 				c->status_block->cur_inbound_frames);
-	len += sprintf(buf+len,"Max Outbound Frames    : %d\n", 
+	seq_printf(seq, "Max Outbound Frames    : %d\n", 
 				c->status_block->max_outbound_frames);
 
 	/* Spec doesn't say if NULL terminated or not... */
 	memcpy(prodstr, c->status_block->product_id, 24);
 	prodstr[24] = '\0';
-	len += sprintf(buf+len,"Product ID             : %s\n", prodstr);
-	len += sprintf(buf+len,"Expected LCT Size      : %d bytes\n", 
+	seq_printf(seq, "Product ID             : %s\n", prodstr);
+	seq_printf(seq, "Expected LCT Size      : %d bytes\n", 
 				c->status_block->expected_lct_size);
 
-	len += sprintf(buf+len,"IOP Capabilities\n");
-	len += sprintf(buf+len,"    Context Field Size Support : ");
+	seq_printf(seq, "IOP Capabilities\n");
+	seq_printf(seq, "    Context Field Size Support : ");
 	switch (c->status_block->iop_capabilities & 0x0000003) {
 		case 0:
-			len += sprintf(buf+len,"Supports only 32-bit context fields\n");
+			seq_printf(seq, "Supports only 32-bit context fields\n");
 			break;
 		case 1:
-			len += sprintf(buf+len,"Supports only 64-bit context fields\n");
+			seq_printf(seq, "Supports only 64-bit context fields\n");
 			break;
 		case 2:
-			len += sprintf(buf+len,"Supports 32-bit and 64-bit context fields, "
+			seq_printf(seq, "Supports 32-bit and 64-bit context fields, "
 						"but not concurrently\n");
 			break;
 		case 3:
-			len += sprintf(buf+len,"Supports 32-bit and 64-bit context fields "
+			seq_printf(seq, "Supports 32-bit and 64-bit context fields "
 						"concurrently\n");
 			break;
 		default:
-			len += sprintf(buf+len,"0x%08x\n",c->status_block->iop_capabilities);
+			seq_printf(seq, "0x%08x\n",c->status_block->iop_capabilities);
 	}
-	len += sprintf(buf+len,"    Current Context Field Size : ");
+	seq_printf(seq, "    Current Context Field Size : ");
 	switch (c->status_block->iop_capabilities & 0x0000000C) {
 		case 0:
-			len += sprintf(buf+len,"not configured\n");
+			seq_printf(seq, "not configured\n");
 			break;
 		case 4:
-			len += sprintf(buf+len,"Supports only 32-bit context fields\n");
+			seq_printf(seq, "Supports only 32-bit context fields\n");
 			break;
 		case 8:
-			len += sprintf(buf+len,"Supports only 64-bit context fields\n");
+			seq_printf(seq, "Supports only 64-bit context fields\n");
 			break;
 		case 12:
-			len += sprintf(buf+len,"Supports both 32-bit or 64-bit context fields "
+			seq_printf(seq, "Supports both 32-bit or 64-bit context fields "
 						"concurrently\n");
 			break;
 		default:
-			len += sprintf(buf+len,"\n");
+			seq_printf(seq, "\n");
 	}
-	len += sprintf(buf+len,"    Inbound Peer Support       : %s\n",
+	seq_printf(seq, "    Inbound Peer Support       : %s\n",
 			(c->status_block->iop_capabilities & 0x00000010) ? "Supported" : "Not supported");
-	len += sprintf(buf+len,"    Outbound Peer Support      : %s\n",
+	seq_printf(seq, "    Outbound Peer Support      : %s\n",
 			(c->status_block->iop_capabilities & 0x00000020) ? "Supported" : "Not supported");
-	len += sprintf(buf+len,"    Peer to Peer Support       : %s\n",
+	seq_printf(seq, "    Peer to Peer Support       : %s\n",
 			(c->status_block->iop_capabilities & 0x00000040) ? "Supported" : "Not supported");
 
-	len += sprintf(buf+len, "Desired private memory size   : %d kB\n", 
+	seq_printf(seq, "Desired private memory size   : %d kB\n", 
 				c->status_block->desired_mem_size>>10);
-	len += sprintf(buf+len, "Allocated private memory size : %d kB\n", 
+	seq_printf(seq, "Allocated private memory size : %d kB\n", 
 				c->status_block->current_mem_size>>10);
-	len += sprintf(buf+len, "Private memory base address   : %0#10x\n", 
+	seq_printf(seq, "Private memory base address   : %0#10x\n", 
 				c->status_block->current_mem_base);
-	len += sprintf(buf+len, "Desired private I/O size      : %d kB\n", 
+	seq_printf(seq, "Desired private I/O size      : %d kB\n", 
 				c->status_block->desired_io_size>>10);
-	len += sprintf(buf+len, "Allocated private I/O size    : %d kB\n", 
+	seq_printf(seq, "Allocated private I/O size    : %d kB\n", 
 				c->status_block->current_io_size>>10);
-	len += sprintf(buf+len, "Private I/O base address      : %0#10x\n", 
+	seq_printf(seq, "Private I/O base address      : %0#10x\n", 
 				c->status_block->current_io_base);
 
-	spin_unlock(&i2o_proc_lock);
-
-	return len;
+	return 0;
 }
 
 int i2o_proc_read_hw(char *buf, char **start, off_t offset, int len, 
@@ -3146,6 +3155,9 @@
 		ent->data = data;
 		ent->read_proc = pentry->read_proc;
 		ent->write_proc = pentry->write_proc;
+		if(pentry->fops_proc)
+			ent->proc_fops = pentry->fops_proc;
+
 		ent->nlink = 1;
 
 		pentry++;
@@ -3266,7 +3278,6 @@
 		sprintf(buff, "iop%d", pctrl->unit);
 
 		i2o_proc_remove_entries(generic_iop_entries, pctrl->proc_entry);
-
 		remove_proc_entry(buff, parent);
 		pctrl->proc_entry = NULL;
 	}
@@ -3306,8 +3317,8 @@
 					break;
 				}
 			}
-			remove_proc_entry(dev_id, dev->controller->proc_entry);
 		}
+		remove_proc_entry(dev_id, dev->controller->proc_entry);
 	}
 }
 	

--------------050509060402030100060605--
