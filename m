Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbSKSToK>; Tue, 19 Nov 2002 14:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKSToK>; Tue, 19 Nov 2002 14:44:10 -0500
Received: from host194.steeleye.com ([66.206.164.34]:21512 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267145AbSKSTna>; Tue, 19 Nov 2002 14:43:30 -0500
Message-Id: <200211191950.gAJJoKh03881@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com,
       Project MCA Team <mcalinux@acc.umu.se>,
       David Weinehall <tao@acc.umu.se>
Subject: {RFC][PATCH] MCA sysfs conversion
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-7779081380"
Date: Tue, 19 Nov 2002 13:50:20 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-7779081380
Content-Type: text/plain; charset=us-ascii

The attached patch (against 2.5.48) represents the initial migration of MCA to 
sysfs.  What I've done is to keep the old API (in terms of slots), but migrate 
the underlying functionality to use sysfs struct devices.

I've kept all the proc functions pretty much the same (except that if there's 
no card present, no /proc/mca/slot<n> file is created).

I've also quietly begun implementing support for machines with more than one 
MCA bus.

The next patch set will be to add support for a newer MCA API and to migrate 
certain drivers to using it.

Comments welcome.

James


--==_Exmh_-7779081380
Content-Type: text/plain ; name="mca-sysfs.diff"; charset=us-ascii
Content-Description: mca-sysfs.diff
Content-Disposition: attachment; filename="mca-sysfs.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.842   -> 1.843  
#	 include/linux/mca.h	1.1     -> 1.2    
#	arch/i386/kernel/mca.c	1.9     -> 1.10   
#	    drivers/Makefile	1.23    -> 1.24   
#	               (new)	        -> 1.1     drivers/mca/mca-legacy.c
#	               (new)	        -> 1.1     drivers/mca/mca-proc.c
#	               (new)	        -> 1.1     drivers/mca/Makefile
#	               (new)	        -> 1.1     drivers/mca/mca-bus.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/19	jejb@mulgrave.(none)	1.843
# MCA sysfs changes
# 
# These changes make MCA use sysfs.  They export the identical api
# to the previous MCA functions, but now everything operates in
# terms of sysfs struct devices.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/mca.c b/arch/i386/kernel/mca.c
--- a/arch/i386/kernel/mca.c	Tue Nov 19 13:38:51 2002
+++ b/arch/i386/kernel/mca.c	Tue Nov 19 13:38:51 2002
@@ -54,54 +54,7 @@
 #include <linux/init.h>
 #include <asm/arch_hooks.h>
 
-/* This structure holds MCA information. Each (plug-in) adapter has
- * eight POS registers. Then the machine may have integrated video and
- * SCSI subsystems, which also have eight POS registers.
- * Finally, the motherboard (planar) has got POS-registers.
- * Other miscellaneous information follows.
- */
-
-typedef enum {
-	MCA_ADAPTER_NORMAL = 0,
-	MCA_ADAPTER_NONE = 1,
-	MCA_ADAPTER_DISABLED = 2,
-	MCA_ADAPTER_ERROR = 3
-} MCA_AdapterStatus;
-
-struct MCA_adapter {
-	MCA_AdapterStatus status;	/* is there a valid adapter? */
-	int id;				/* adapter id value */
-	unsigned char pos[8];		/* POS registers */
-	int driver_loaded;		/* is there a driver installed? */
-					/* 0 - No, 1 - Yes */
-	char name[48];			/* adapter-name provided by driver */
-	char procname[8];		/* name of /proc/mca file */
-	MCA_ProcFn procfn;		/* /proc info callback */
-	void* dev;			/* device/context info for callback */
-};
-
-struct MCA_info {
-	/* one for each of the 8 possible slots, plus one for integrated SCSI
-	 * and one for integrated video.
-	 */
-
-	struct MCA_adapter slot[MCA_NUMADAPTERS];
-
-	/* two potential addresses for integrated SCSI adapter - this will
-	 * track which one we think it is.
-	 */
-
-	unsigned char which_scsi;
-};
-
-/* The mca_info structure pointer. If MCA bus is present, the function
- * mca_probe() is invoked. The function puts motherboard, then all
- * adapters into setup mode, allocates and fills an MCA_info structure,
- * and points this pointer to the structure. Otherwise the pointer
- * is set to zero.
- */
-
-static struct MCA_info* mca_info = NULL;
+static unsigned char which_scsi = 0;
 
 /*
  * Motherboard register spinlock. Untested on SMP at the moment, but
@@ -109,33 +62,17 @@
  *
  * Yes - Alan
  */
-static spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
-
-/* MCA registers */
-
-#define MCA_MOTHERBOARD_SETUP_REG	0x94
-#define MCA_ADAPTER_SETUP_REG		0x96
-#define MCA_POS_REG(n)			(0x100+(n))
-
-#define MCA_ENABLED	0x01	/* POS 2, set if adapter enabled */
-
-/*--------------------------------------------------------------------*/
-
-#ifdef CONFIG_PROC_FS
-static void mca_do_proc_init(void);
-#endif
-
-/*--------------------------------------------------------------------*/
+spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
 
 /* Build the status info for the adapter */
 
-static void mca_configure_adapter_status(int slot) {
-	mca_info->slot[slot].status = MCA_ADAPTER_NONE;
+static void mca_configure_adapter_status(struct mca_device *mca_dev) {
+	mca_dev->status = MCA_ADAPTER_NONE;
 
-	mca_info->slot[slot].id = mca_info->slot[slot].pos[0]
-		+ (mca_info->slot[slot].pos[1] << 8);
+	mca_dev->pos_id = mca_dev->pos[0]
+		+ (mca_dev->pos[1] << 8);
 
-	if(!mca_info->slot[slot].id && slot < MCA_MAX_SLOT_NR) {
+	if(!mca_dev->pos_id && mca_dev->slot < MCA_MAX_SLOT_NR) {
 
 		/* id = 0x0000 usually indicates hardware failure,
 		 * however, ZP Gu (zpg@castle.net> reports that his 9556
@@ -145,10 +82,10 @@
 		 * however, this code will stay.
 		 */
 
-		mca_info->slot[slot].status = MCA_ADAPTER_ERROR;
+		mca_dev->status = MCA_ADAPTER_ERROR;
 
 		return;
-	} else if(mca_info->slot[slot].id != 0xffff) {
+	} else if(mca_dev->pos_id != 0xffff) {
 
 		/* 0xffff usually indicates that there's no adapter,
 		 * however, some integrated adapters may have 0xffff as
@@ -157,26 +94,26 @@
 		 * and possibly also the 95 ULTIMEDIA.
 		 */
 
-		mca_info->slot[slot].status = MCA_ADAPTER_NORMAL;
+		mca_dev->status = MCA_ADAPTER_NORMAL;
 	}
 
-	if((mca_info->slot[slot].id == 0xffff ||
-	   mca_info->slot[slot].id == 0x0000) && slot >= MCA_MAX_SLOT_NR) {
+	if((mca_dev->pos_id == 0xffff ||
+	    mca_dev->pos_id == 0x0000) && mca_dev->slot >= MCA_MAX_SLOT_NR) {
 		int j;
 
 		for(j = 2; j < 8; j++) {
-			if(mca_info->slot[slot].pos[j] != 0xff) {
-				mca_info->slot[slot].status = MCA_ADAPTER_NORMAL;
+			if(mca_dev->pos[j] != 0xff) {
+				mca_dev->status = MCA_ADAPTER_NORMAL;
 				break;
 			}
 		}
 	}
 
-	if(!(mca_info->slot[slot].pos[2] & MCA_ENABLED)) {
+	if(!(mca_dev->pos[2] & MCA_ENABLED)) {
 
 		/* enabled bit is in POS 2 */
 
-		mca_info->slot[slot].status = MCA_ADAPTER_DISABLED;
+		mca_dev->status = MCA_ADAPTER_DISABLED;
 	}
 } /* mca_configure_adapter_status */
 
@@ -194,9 +131,41 @@
 
 #define MCA_STANDARD_RESOURCES	(sizeof(mca_standard_resources)/sizeof(struct 
resource))
 
-int __init mca_init(void)
+/**
+ *	mca_read_pos - read the POS registers into a memory buffer
+ *
+ *	Returns 1 if a card actually exists (i.e. the pos isn't
+ *	all 0xff) or 0 otherwise
+ */
+static int mca_read_and_store_pos(unsigned char *pos) {
+	int j;
+	int found = 0;
+
+	for(j=0; j<8; j++) {
+		if((pos[j] = inb_p(MCA_POS_REG(j))) != 0xff) {
+			/* 0xff all across means no device. 0x00 means
+			 * something's broken, but a device is
+			 * probably there.  However, if you get 0x00
+			 * from a motherboard register it won't matter
+			 * what we find.  For the record, on the
+			 * 57SLC, the integrated SCSI adapter has
+			 * 0xffff for the adapter ID, but nonzero for
+			 * other registers.  */
+
+			found = 1;
+		}
+	}
+	return found;
+}
+
+
+static int __init mca_init(void)
 {
 	unsigned int i, j;
+	struct mca_device *mca_dev;
+	unsigned char pos[8];
+	short mca_builtin_scsi_ports[] = {0xf7, 0xfd, 0x00};
+	struct mca_bus *bus;
 
 	/* WARNING: Be careful when making changes here. Putting an adapter
 	 * and the motherboard simultaneously into setup mode may result in
@@ -209,17 +178,23 @@
 
 	if(!MCA_bus)
 		return -ENODEV;
-	printk(KERN_INFO "Micro Channel bus detected.\n");
 
-	/* Allocate MCA_info structure (at address divisible by 8) */
-
-	mca_info = (struct MCA_info *)kmalloc(sizeof(struct MCA_info), GFP_KERNEL);
+	printk(KERN_INFO "Micro Channel bus detected.\n");
 
-	if(mca_info == NULL) {
-		printk(KERN_ERR "Failed to allocate memory for mca_info!");
-		return -ENOMEM;
+	if(mca_system_init()) {
+		printk(KERN_ERR "MCA bus system initialisation failed\n");
+		return -ENODEV;
 	}
-	memset(mca_info, 0, sizeof(struct MCA_info));
+
+	/* All MCA systems have at least a primary bus */
+	bus = mca_attach_bus(MCA_PRIMARY_BUS);
+	bus->default_dma_mask = 0xffffffffLL;
+
+	/* get the motherboard device */
+	mca_dev = kmalloc(sizeof(struct mca_device), GFP_KERNEL);
+	if(unlikely(!mca_dev))
+		goto out_nomem;
+	memset(mca_dev, 0, sizeof(struct mca_device));
 
 	/*
 	 * We do not expect many MCA interrupts during initialization,
@@ -233,23 +208,35 @@
 
 	/* Read motherboard POS registers */
 
-	outb_p(0x7f, MCA_MOTHERBOARD_SETUP_REG);
-	mca_info->slot[MCA_MOTHERBOARD].name[0] = 0;
-	for(j=0; j<8; j++) {
-		mca_info->slot[MCA_MOTHERBOARD].pos[j] = inb_p(MCA_POS_REG(j));
-	}
-	mca_configure_adapter_status(MCA_MOTHERBOARD);
+	mca_dev->pos_register = 0x7f;
+	outb_p(mca_dev->pos_register, MCA_MOTHERBOARD_SETUP_REG);
+	mca_dev->dev.name[0] = 0;
+	mca_read_and_store_pos(mca_dev->pos);
+	mca_configure_adapter_status(mca_dev);
+	/* fake POS and slot for a motherboard */
+	mca_dev->pos_id = MCA_MOTHERBOARD_POS;
+	mca_dev->slot = MCA_MOTHERBOARD;
+	mca_register_device(MCA_PRIMARY_BUS, mca_dev);
+
+	mca_dev = kmalloc(sizeof(struct mca_device), GFP_ATOMIC);
+	if(unlikely(!mca_dev))
+		goto out_unlock_nomem;
+	memset(mca_dev, 0, sizeof(struct mca_device));
+
 
 	/* Put motherboard into video setup mode, read integrated video
 	 * POS registers, and turn motherboard setup off.
 	 */
 
-	outb_p(0xdf, MCA_MOTHERBOARD_SETUP_REG);
-	mca_info->slot[MCA_INTEGVIDEO].name[0] = 0;
-	for(j=0; j<8; j++) {
-		mca_info->slot[MCA_INTEGVIDEO].pos[j] = inb_p(MCA_POS_REG(j));
-	}
-	mca_configure_adapter_status(MCA_INTEGVIDEO);
+	mca_dev->pos_register = 0xdf;
+	outb_p(mca_dev->pos_register, MCA_MOTHERBOARD_SETUP_REG);
+	mca_dev->dev.name[0] = 0;
+	mca_read_and_store_pos(mca_dev->pos);
+	mca_configure_adapter_status(mca_dev);
+	/* fake POS and slot for the integrated video */
+	mca_dev->pos_id = MCA_INTEGVIDEO_POS;
+	mca_dev->slot = MCA_INTEGVIDEO;
+	mca_register_device(MCA_PRIMARY_BUS, mca_dev);
 
 	/* Put motherboard into scsi setup mode, read integrated scsi
 	 * POS registers, and turn motherboard setup off.
@@ -263,33 +250,28 @@
 	 * machine.
 	 */
 
-	outb_p(0xf7, MCA_MOTHERBOARD_SETUP_REG);
-	mca_info->slot[MCA_INTEGSCSI].name[0] = 0;
-	for(j=0; j<8; j++) {
-		if((mca_info->slot[MCA_INTEGSCSI].pos[j] = inb_p(MCA_POS_REG(j))) != 0xff)
-		{
-			/* 0xff all across means no device. 0x00 means
-			 * something's broken, but a device is probably there.
-			 * However, if you get 0x00 from a motherboard
-			 * register it won't matter what we find.  For the
-			 * record, on the 57SLC, the integrated SCSI
-			 * adapter has 0xffff for the adapter ID, but
-			 * nonzero for other registers.
-			 */
-
-			mca_info->which_scsi = 0xf7;
-		}
-	}
-	if(!mca_info->which_scsi) {
-
-		/* Didn't find it at 0xf7, try somewhere else... */
-		mca_info->which_scsi = 0xfd;
-
-		outb_p(0xfd, MCA_MOTHERBOARD_SETUP_REG);
-		for(j=0; j<8; j++)
-			mca_info->slot[MCA_INTEGSCSI].pos[j] = inb_p(MCA_POS_REG(j));
+	for(i = 0; (which_scsi = mca_builtin_scsi_ports[i]) != 0; i++) {
+		outb_p(which_scsi, MCA_MOTHERBOARD_SETUP_REG);
+		if(mca_read_and_store_pos(pos))
+			break;
+	}
+	if(which_scsi) {
+		/* found a scsi card */
+		mca_dev = kmalloc(sizeof(struct mca_device), GFP_ATOMIC);
+		if(unlikely(!mca_dev))
+			goto out_unlock_nomem;
+		memset(mca_dev, 0, sizeof(struct mca_device));
+
+		for(j = 0; j < 8; j++)
+			mca_dev->pos[j] = pos[j];
+
+		mca_configure_adapter_status(mca_dev);
+		/* fake POS and slot for integrated SCSI controller */
+		mca_dev->pos_id = MCA_INTEGSCSI_POS;
+		mca_dev->slot = MCA_INTEGSCSI;
+		mca_dev->pos_register = which_scsi;
+		mca_register_device(MCA_PRIMARY_BUS, mca_dev);
 	}
-	mca_configure_adapter_status(MCA_INTEGSCSI);
 
 	/* Turn off motherboard setup */
 
@@ -301,12 +283,22 @@
 
 	for(i=0; i<MCA_MAX_SLOT_NR; i++) {
 		outb_p(0x8|(i&0xf), MCA_ADAPTER_SETUP_REG);
-		for(j=0; j<8; j++) {
-			mca_info->slot[i].pos[j]=inb_p(MCA_POS_REG(j));
-		}
-		mca_info->slot[i].name[0] = 0;
-		mca_info->slot[i].driver_loaded = 0;
-		mca_configure_adapter_status(i);
+		if(!mca_read_and_store_pos(pos))
+			continue;
+
+		mca_dev = kmalloc(sizeof(struct mca_device), GFP_ATOMIC);
+		if(unlikely(!mca_dev))
+			goto out_unlock_nomem;
+		memset(mca_dev, 0, sizeof(struct mca_device));
+
+		for(j=0; j<8; j++)
+			mca_dev->pos[j]=pos[j];
+
+		mca_dev->driver_loaded = 0;
+		mca_dev->slot = i;
+		mca_dev->pos_register = 0;
+		mca_configure_adapter_status(mca_dev);
+		mca_register_device(MCA_PRIMARY_BUS, mca_dev);
 	}
 	outb_p(0, MCA_ADAPTER_SETUP_REG);
 
@@ -316,11 +308,15 @@
 	for (i = 0; i < MCA_STANDARD_RESOURCES; i++)
 		request_resource(&ioport_resource, mca_standard_resources + i);
 
-#ifdef CONFIG_PROC_FS
 	mca_do_proc_init();
-#endif
 
 	return 0;
+
+ out_unlock_nomem:
+	spin_unlock_irq(&mca_lock);
+ out_nomem:
+	printk(KERN_EMERG "Failed memory allocation in MCA setup!\n");
+	return -ENOMEM;
 }
 
 subsys_initcall(mca_init);
@@ -329,18 +325,22 @@
 
 static void mca_handle_nmi_slot(int slot, int check_flag)
 {
-	if(slot < MCA_MAX_SLOT_NR) {
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev) {
+		printk(KERN_CRIT "NMI: caused by unknown slot %d\n", slot);
+	} else if(slot < MCA_MAX_SLOT_NR) {
 		printk(KERN_CRIT "NMI: caused by MCA adapter in slot %d (%s)\n", slot+1,
-			mca_info->slot[slot].name);
+			mca_dev->dev.name);
 	} else if(slot == MCA_INTEGSCSI) {
 		printk(KERN_CRIT "NMI: caused by MCA integrated SCSI adapter (%s)\n",
-			mca_info->slot[slot].name);
+			mca_dev->dev.name);
 	} else if(slot == MCA_INTEGVIDEO) {
 		printk(KERN_CRIT "NMI: caused by MCA integrated video adapter (%s)\n",
-			mca_info->slot[slot].name);
+			mca_dev->dev.name);
 	} else if(slot == MCA_MOTHERBOARD) {
 		printk(KERN_CRIT "NMI: caused by motherboard (%s)\n",
-			mca_info->slot[slot].name);
+			mca_dev->dev.name);
 	}
 
 	/* More info available in POS 6 and 7? */
@@ -383,603 +383,3 @@
 	}
 	mca_nmi_hook();
 } /* mca_handle_nmi */
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_find_adapter - scan for adapters
- *	@id:	MCA identification to search for
- *	@start:	starting slot
- *
- *	Search the MCA configuration for adapters matching the 16bit
- *	ID given. The first time it should be called with start as zero
- *	and then further calls made passing the return value of the
- *	previous call until %MCA_NOTFOUND is returned.
- *
- *	Disabled adapters are not reported.
- */
-
-int mca_find_adapter(int id, int start)
-{
-	if(mca_info == NULL || id == 0xffff) {
-		return MCA_NOTFOUND;
-	}
-
-	for(; start >= 0 && start < MCA_NUMADAPTERS; start++) {
-
-		/* Not sure about this. There's no point in returning
-		 * adapters that aren't enabled, since they can't actually
-		 * be used. However, they might be needed for statistical
-		 * purposes or something... But if that is the case, the
-		 * user is free to write a routine that manually iterates
-		 * through the adapters.
-		 */
-
-		if(mca_info->slot[start].status == MCA_ADAPTER_DISABLED) {
-			continue;
-		}
-
-		if(id == mca_info->slot[start].id) {
-			return start;
-		}
-	}
-
-	return MCA_NOTFOUND;
-} /* mca_find_adapter() */
-
-EXPORT_SYMBOL(mca_find_adapter);
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_find_unused_adapter - scan for unused adapters
- *	@id:	MCA identification to search for
- *	@start:	starting slot
- *
- *	Search the MCA configuration for adapters matching the 16bit
- *	ID given. The first time it should be called with start as zero
- *	and then further calls made passing the return value of the
- *	previous call until %MCA_NOTFOUND is returned.
- *
- *	Adapters that have been claimed by drivers and those that
- *	are disabled are not reported. This function thus allows a driver
- *	to scan for further cards when some may already be driven.
- */
-
-int mca_find_unused_adapter(int id, int start)
-{
-	if(mca_info == NULL || id == 0xffff) {
-		return MCA_NOTFOUND;
-	}
-
-	for(; start >= 0 && start < MCA_NUMADAPTERS; start++) {
-
-		/* not sure about this. There's no point in returning
-		 * adapters that aren't enabled, since they can't actually
-		 * be used. However, they might be needed for statistical
-		 * purposes or something... But if that is the case, the
-		 * user is free to write a routine that manually iterates
-		 * through the adapters.
-		 */
-
-		if(mca_info->slot[start].status == MCA_ADAPTER_DISABLED ||
-		   mca_info->slot[start].driver_loaded) {
-			continue;
-		}
-
-		if(id == mca_info->slot[start].id) {
-			return start;
-		}
-	}
-
-	return MCA_NOTFOUND;
-} /* mca_find_unused_adapter() */
-
-EXPORT_SYMBOL(mca_find_unused_adapter);
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_read_stored_pos - read POS register from boot data
- *	@slot: slot number to read from
- *	@reg:  register to read from
- *
- *	Fetch a POS value that was stored at boot time by the kernel
- *	when it scanned the MCA space. The register value is returned.
- *	Missing or invalid registers report 0.
- */
-
-unsigned char mca_read_stored_pos(int slot, int reg)
-{
-	if(slot < 0 || slot >= MCA_NUMADAPTERS || mca_info == NULL) return 0;
-	if(reg < 0 || reg >= 8) return 0;
-	return mca_info->slot[slot].pos[reg];
-} /* mca_read_stored_pos() */
-
-EXPORT_SYMBOL(mca_read_stored_pos);
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_read_pos - read POS register from card
- *	@slot: slot number to read from
- *	@reg:  register to read from
- *
- *	Fetch a POS value directly from the hardware to obtain the
- *	current value. This is much slower than mca_read_stored_pos and
- *	may not be invoked from interrupt context. It handles the
- *	deep magic required for onboard devices transparently.
- */
-
-unsigned char mca_read_pos(int slot, int reg)
-{
-	unsigned int byte = 0;
-	unsigned long flags;
-
-	if(slot < 0 || slot >= MCA_NUMADAPTERS || mca_info == NULL) return 0;
-	if(reg < 0 || reg >= 8) return 0;
-
-	spin_lock_irqsave(&mca_lock, flags);
-
-	/* Make sure motherboard setup is off */
-
-	outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-
-	/* Read in the appropriate register */
-
-	if(slot == MCA_INTEGSCSI && mca_info->which_scsi) {
-
-		/* Disable adapter setup, enable motherboard setup */
-
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-		outb_p(mca_info->which_scsi, MCA_MOTHERBOARD_SETUP_REG);
-
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-	} else if(slot == MCA_INTEGVIDEO) {
-
-		/* Disable adapter setup, enable motherboard setup */
-
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-		outb_p(0xdf, MCA_MOTHERBOARD_SETUP_REG);
-
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-	} else if(slot == MCA_MOTHERBOARD) {
-
-		/* Disable adapter setup, enable motherboard setup */
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-		outb_p(0x7f, MCA_MOTHERBOARD_SETUP_REG);
-
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-	} else if(slot < MCA_MAX_SLOT_NR) {
-
-		/* Make sure motherboard setup is off */
-
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-
-		/* Read the appropriate register */
-
-		outb_p(0x8|(slot&0xf), MCA_ADAPTER_SETUP_REG);
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-	}
-
-	/* Make sure the stored values are consistent, while we're here */
-
-	mca_info->slot[slot].pos[reg] = byte;
-
-	spin_unlock_irqrestore(&mca_lock, flags);
-
-	return byte;
-} /* mca_read_pos() */
-
-EXPORT_SYMBOL(mca_read_pos);
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_write_pos - read POS register from card
- *	@slot: slot number to read from
- *	@reg:  register to read from
- *	@byte: byte to write to the POS registers
- *
- *	Store a POS value directly from the hardware. You should not
- *	normally need to use this function and should have a very good
- *	knowledge of MCA bus before you do so. Doing this wrongly can
- *	damage the hardware.
- *
- *	This function may not be used from interrupt context.
- *
- *	Note that this a technically a Bad Thing, as IBM tech stuff says
- *	you should only set POS values through their utilities.
- *	However, some devices such as the 3c523 recommend that you write
- *	back some data to make sure the configuration is consistent.
- *	I'd say that IBM is right, but I like my drivers to work.
- *
- *	This function can't do checks to see if multiple devices end up
- *	with the same resources, so you might see magic smoke if someone
- *	screws up.
- */
-
-void mca_write_pos(int slot, int reg, unsigned char byte)
-{
-	unsigned long flags;
-
-	if(slot < 0 || slot >= MCA_MAX_SLOT_NR)
-		return;
-	if(reg < 0 || reg >= 8)
-		return;
-	if(mca_info == NULL)
-		return;
-
-	spin_lock_irqsave(&mca_lock, flags);
-
-	/* Make sure motherboard setup is off */
-
-	outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-
-	/* Read in the appropriate register */
-
-	outb_p(0x8|(slot&0xf), MCA_ADAPTER_SETUP_REG);
-	outb_p(byte, MCA_POS_REG(reg));
-	outb_p(0, MCA_ADAPTER_SETUP_REG);
-
-	spin_unlock_irqrestore(&mca_lock, flags);
-
-	/* Update the global register list, while we have the byte */
-
-	mca_info->slot[slot].pos[reg] = byte;
-} /* mca_write_pos() */
-
-EXPORT_SYMBOL(mca_write_pos);
-
-/*--------------------------------------------------------------------*/
-
-/**
- *	mca_set_adapter_name - Set the description of the card
- *	@slot: slot to name
- *	@name: text string for the namen
- *
- *	This function sets the name reported via /proc for this
- *	adapter slot. This is for user information only. Setting a
- *	name deletes any previous name.
- */
-
-void mca_set_adapter_name(int slot, char* name)
-{
-	if(mca_info == NULL) return;
-
-	if(slot >= 0 && slot < MCA_NUMADAPTERS) {
-		if(name != NULL) {
-			strncpy(mca_info->slot[slot].name, name,
-				sizeof(mca_info->slot[slot].name)-1);
-			mca_info->slot[slot].name[
-				sizeof(mca_info->slot[slot].name)-1] = 0;
-		} else {
-			mca_info->slot[slot].name[0] = 0;
-		}
-	}
-}
-
-EXPORT_SYMBOL(mca_set_adapter_name);
-
-/**
- *	mca_set_adapter_procfn - Set the /proc callback
- *	@slot: slot to configure
- *	@procfn: callback function to call for /proc
- *	@dev: device information passed to the callback
- *
- *	This sets up an information callback for /proc/mca/slot?.  The
- *	function is called with the buffer, slot, and device pointer (or
- *	some equally informative context information, or nothing, if you
- *	prefer), and is expected to put useful information into the
- *	buffer.  The adapter name, ID, and POS registers get printed
- *	before this is called though, so don't do it again.
- *
- *	This should be called with a %NULL @procfn when a module
- *	unregisters, thus preventing kernel crashes and other such
- *	nastiness.
- */
-
-void mca_set_adapter_procfn(int slot, MCA_ProcFn procfn, void* dev)
-{
-	if(mca_info == NULL) return;
-
-	if(slot >= 0 && slot < MCA_NUMADAPTERS) {
-		mca_info->slot[slot].procfn = procfn;
-		mca_info->slot[slot].dev = dev;
-	}
-}
-
-EXPORT_SYMBOL(mca_set_adapter_procfn);
-
-/**
- *	mca_is_adapter_used - check if claimed by driver
- *	@slot:	slot to check
- *
- *	Returns 1 if the slot has been claimed by a driver
- */
-
-int mca_is_adapter_used(int slot)
-{
-	return mca_info->slot[slot].driver_loaded;
-}
-
-EXPORT_SYMBOL(mca_is_adapter_used);
-
-/**
- *	mca_mark_as_used - claim an MCA device
- *	@slot:	slot to claim
- *	FIXME:  should we make this threadsafe
- *
- *	Claim an MCA slot for a device driver. If the
- *	slot is already taken the function returns 1,
- *	if it is not taken it is claimed and 0 is
- *	returned.
- */
-
-int mca_mark_as_used(int slot)
-{
-	if(mca_info->slot[slot].driver_loaded) return 1;
-	mca_info->slot[slot].driver_loaded = 1;
-	return 0;
-}
-
-EXPORT_SYMBOL(mca_mark_as_used);
-
-/**
- *	mca_mark_as_unused - release an MCA device
- *	@slot:	slot to claim
- *
- *	Release the slot for other drives to use.
- */
-
-void mca_mark_as_unused(int slot)
-{
-	mca_info->slot[slot].driver_loaded = 0;
-}
-
-EXPORT_SYMBOL(mca_mark_as_unused);
-
-/**
- *	mca_get_adapter_name - get the adapter description
- *	@slot:	slot to query
- *
- *	Return the adapter description if set. If it has not been
- *	set or the slot is out range then return NULL.
- */
-
-char *mca_get_adapter_name(int slot)
-{
-	if(mca_info == NULL) return 0;
-
-	if(slot >= 0 && slot < MCA_NUMADAPTERS) {
-		return mca_info->slot[slot].name;
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL(mca_get_adapter_name);
-
-/**
- *	mca_isadapter - check if the slot holds an adapter
- *	@slot:	slot to query
- *
- *	Returns zero if the slot does not hold an adapter, non zero if
- *	it does.
- */
-
-int mca_isadapter(int slot)
-{
-	if(mca_info == NULL) return 0;
-
-	if(slot >= 0 && slot < MCA_NUMADAPTERS) {
-		return ((mca_info->slot[slot].status == MCA_ADAPTER_NORMAL)
-			|| (mca_info->slot[slot].status == MCA_ADAPTER_DISABLED));
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL(mca_isadapter);
-
-
-/**
- *	mca_isadapter - check if the slot holds an adapter
- *	@slot:	slot to query
- *
- *	Returns a non zero value if the slot holds an enabled adapter
- *	and zero for any other case.
- */
-
-int mca_isenabled(int slot)
-{
-	if(mca_info == NULL) return 0;
-
-	if(slot >= 0 && slot < MCA_NUMADAPTERS) {
-		return (mca_info->slot[slot].status == MCA_ADAPTER_NORMAL);
-	}
-
-	return 0;
-}
-
-EXPORT_SYMBOL(mca_isenabled);
-
-/*--------------------------------------------------------------------*/
-
-#ifdef CONFIG_PROC_FS
-
-int get_mca_info(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int i, j, len = 0;
-
-	if(MCA_bus && mca_info != NULL) {
-		/* Format POS registers of eight MCA slots */
-
-		for(i=0; i<MCA_MAX_SLOT_NR; i++) {
-			len += sprintf(page+len, "Slot %d: ", i+1);
-			for(j=0; j<8; j++)
-				len += sprintf(page+len, "%02x ", mca_info->slot[i].pos[j]);
-			len += sprintf(page+len, " %s\n", mca_info->slot[i].name);
-		}
-
-		/* Format POS registers of integrated video subsystem */
-
-		len += sprintf(page+len, "Video : ");
-		for(j=0; j<8; j++)
-			len += sprintf(page+len, "%02x ", mca_info->slot[MCA_INTEGVIDEO].pos[j]);
-		len += sprintf(page+len, " %s\n", mca_info->slot[MCA_INTEGVIDEO].name);
-
-		/* Format POS registers of integrated SCSI subsystem */
-
-		len += sprintf(page+len, "SCSI  : ");
-		for(j=0; j<8; j++)
-			len += sprintf(page+len, "%02x ", mca_info->slot[MCA_INTEGSCSI].pos[j]);
-		len += sprintf(page+len, " %s\n", mca_info->slot[MCA_INTEGSCSI].name);
-
-		/* Format POS registers of motherboard */
-
-		len += sprintf(page+len, "Planar: ");
-		for(j=0; j<8; j++)
-			len += sprintf(page+len, "%02x ", mca_info->slot[MCA_MOTHERBOARD].pos[j]);
-		len += sprintf(page+len, " %s\n", mca_info->slot[MCA_MOTHERBOARD].name);
-	} else {
-		/* Leave it empty if MCA not detected - this should *never*
-		 * happen!
-		 */
-	}
-
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
-
-/*--------------------------------------------------------------------*/
-
-static int mca_default_procfn(char* buf, struct MCA_adapter *p)
-{
-	int len = 0, i;
-	int slot = p - mca_info->slot;
-
-	/* Print out the basic information */
-
-	if(slot < MCA_MAX_SLOT_NR) {
-		len += sprintf(buf+len, "Slot: %d\n", slot+1);
-	} else if(slot == MCA_INTEGSCSI) {
-		len += sprintf(buf+len, "Integrated SCSI Adapter\n");
-	} else if(slot == MCA_INTEGVIDEO) {
-		len += sprintf(buf+len, "Integrated Video Adapter\n");
-	} else if(slot == MCA_MOTHERBOARD) {
-		len += sprintf(buf+len, "Motherboard\n");
-	}
-	if(p->name[0]) {
-
-		/* Drivers might register a name without /proc handler... */
-
-		len += sprintf(buf+len, "Adapter Name: %s\n",
-			p->name);
-	} else {
-		len += sprintf(buf+len, "Adapter Name: Unknown\n");
-	}
-	len += sprintf(buf+len, "Id: %02x%02x\n",
-		p->pos[1], p->pos[0]);
-	len += sprintf(buf+len, "Enabled: %s\nPOS: ",
-		mca_isenabled(slot) ? "Yes" : "No");
-	for(i=0; i<8; i++) {
-		len += sprintf(buf+len, "%02x ", p->pos[i]);
-	}
-	len += sprintf(buf+len, "\nDriver Installed: %s",
-		mca_is_adapter_used(slot) ? "Yes" : "No");
-	buf[len++] = '\n';
-	buf[len] = 0;
-
-	return len;
-} /* mca_default_procfn() */
-
-static int get_mca_machine_info(char* page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = 0;
-
-	len += sprintf(page+len, "Model Id: 0x%x\n", machine_id);
-	len += sprintf(page+len, "Submodel Id: 0x%x\n", machine_submodel_id);
-	len += sprintf(page+len, "BIOS Revision: 0x%x\n", BIOS_revision);
-
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-}
-
-static int mca_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	struct MCA_adapter *p = (struct MCA_adapter *)data;
-	int len = 0;
-
-	/* Get the standard info */
-
-	len = mca_default_procfn(page, p);
-
-	/* Do any device-specific processing, if there is any */
-
-	if(p->procfn) {
-		len += p->procfn(page+len, p-mca_info->slot, p->dev);
-	}
-	if (len <= off+count) *eof = 1;
-	*start = page + off;
-	len -= off;
-	if (len>count) len = count;
-	if (len<0) len = 0;
-	return len;
-} /* mca_read_proc() */
-
-/*--------------------------------------------------------------------*/
-
-void __init mca_do_proc_init(void)
-{
-	int i;
-	struct proc_dir_entry *proc_mca;
-	struct proc_dir_entry* node = NULL;
-	struct MCA_adapter *p;
-
-	if(mca_info == NULL) return;	/* Should never happen */
-
-	proc_mca = proc_mkdir("mca", &proc_root);
-	create_proc_read_entry("pos",0,proc_mca,get_mca_info,NULL);
-	create_proc_read_entry("machine",0,proc_mca,get_mca_machine_info,NULL);
-
-	/* Initialize /proc/mca entries for existing adapters */
-
-	for(i = 0; i < MCA_NUMADAPTERS; i++) {
-		p = &mca_info->slot[i];
-		p->procfn = 0;
-
-		if(i < MCA_MAX_SLOT_NR) sprintf(p->procname,"slot%d", i+1);
-		else if(i == MCA_INTEGVIDEO) sprintf(p->procname,"video");
-		else if(i == MCA_INTEGSCSI) sprintf(p->procname,"scsi");
-		else if(i == MCA_MOTHERBOARD) sprintf(p->procname,"planar");
-
-		if(!mca_isadapter(i)) continue;
-
-		node = create_proc_read_entry(p->procname, 0, proc_mca,
-						mca_read_proc, (void *)p);
-
-		if(node == NULL) {
-			printk("Failed to allocate memory for MCA proc-entries!");
-			return;
-		}
-	}
-
-} /* mca_do_proc_init() */
-
-#endif
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	Tue Nov 19 13:38:51 2002
+++ b/drivers/Makefile	Tue Nov 19 13:38:51 2002
@@ -42,5 +42,6 @@
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_MCA)		+= mca/
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/mca/Makefile b/drivers/mca/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/Makefile	Tue Nov 19 13:38:51 2002
@@ -0,0 +1,9 @@
+# Makefile for the Linux MCA bus support
+
+obj-y	:= mca-bus.o mca-legacy.o
+
+obj-$(CONFIG_PROC_FS)	+= mca-proc.o
+
+export-objs	:= mca-bus.o mca-legacy.o mca-proc.o
+
+include $(TOPDIR)/Rules.make
diff -Nru a/drivers/mca/mca-bus.c b/drivers/mca/mca-bus.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/mca-bus.c	Tue Nov 19 13:38:51 2002
@@ -0,0 +1,191 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/*
+ * MCA bus support functions for sysfs.
+ *
+ * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**----------------------------------------------------------------------------
-
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**----------------------------------------------------------------------------
-
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/mca.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <asm/io.h>
+
+/* Very few machines have more than one MCA bus.  However, there are
+ * those that do (Voyager 35xx/5xxx), so we do it this way for future
+ * expansion.  None that I know have more than 2 */
+struct mca_bus *mca_root_busses[MAX_MCA_BUSSES];
+
+#define MCA_DEVINFO(i,s) { .pos = i, .name = s }
+
+struct mca_device_info {
+	short pos_id;		/* the 2 byte pos id for this card */
+	char name[DEVICE_NAME_SIZE];
+};
+
+static int mca_bus_match (struct device *dev, struct device_driver *drv)
+{
+	struct mca_device *mca_dev = to_mca_device (dev);
+	struct mca_driver *mca_drv = to_mca_driver (drv);
+	const short *mca_ids = mca_drv->id_table;
+
+	if (!mca_ids)
+		return 0;
+
+	while (*mca_ids) {
+		if (*mca_ids == mca_dev->pos_id)
+			return 1;
+
+		mca_ids++;
+	}
+
+	return 0;
+}
+
+struct bus_type mca_bus_type = {
+	.name  = "MCA",
+	.match = mca_bus_match,
+};
+EXPORT_SYMBOL (mca_bus_type);
+
+int mca_driver_register (struct mca_driver *mca_drv)
+{
+	int r;
+	
+	mca_drv->driver.bus = &mca_bus_type;
+	if ((r = driver_register (&mca_drv->driver)) < 0)
+		return r;
+
+	return 1;
+}
+
+void mca_driver_unregister (struct mca_driver *mca_drv)
+{
+	bus_remove_driver (&mca_drv->driver);
+	driver_unregister (&mca_drv->driver);
+}
+
+
+static ssize_t mca_show_pos_id(struct device *dev, char *buf, size_t count,
+			       loff_t off)
+{
+	/* four digits, \n and trailing \0 */
+	char mybuf[6];
+	struct mca_device *mca_dev = to_mca_device(dev);
+	int len;
+
+	if(mca_dev->pos_id < MCA_DUMMY_POS_START)
+		len = sprintf(mybuf, "%04x\n", mca_dev->pos_id);
+	else
+		len = sprintf(mybuf, "none\n");
+
+	len++;
+	if(len > off) {
+		len = min((size_t)(len - off), count);
+		memcpy(buf + off, mybuf + off, len);
+	} else {
+		len = 0;
+	}
+	return len;
+}
+static ssize_t mca_show_pos(struct device *dev, char *buf, size_t count,
+			    loff_t off)
+{
+	/* enough for 8 two byte hex chars plus space and new line */
+	char mybuf[26];
+	int j, len=0;
+	struct mca_device *mca_dev = to_mca_device(dev);
+
+	for(j=0; j<8; j++)
+		len += sprintf(mybuf+len, "%02x ", mca_dev->pos[j]);
+	/* change last trailing space to new line */
+	mybuf[len-1] = '\n';
+	len++;
+	if(len > off) {
+		len = min((size_t)(len - off), count);
+		memcpy(buf + off, mybuf + off, len);
+	} else {
+		len = 0;
+	}
+	return len;
+}
+
+static DEVICE_ATTR(id, S_IRUGO, mca_show_pos_id, NULL);
+static DEVICE_ATTR(pos, S_IRUGO, mca_show_pos, NULL);
+
+int __init mca_register_device (int bus, struct mca_device *mca_dev)
+{
+	struct mca_bus *mca_bus = mca_root_busses[bus];
+
+	mca_dev->dev.parent = &mca_bus->dev;
+	mca_dev->dev.bus = &mca_bus_type;
+	sprintf (mca_dev->dev.bus_id, "%02d:%02X", bus, mca_dev->slot);
+	mca_dev->dma_mask = mca_bus->default_dma_mask;
+	/* FIXME: uncomment this when we get a global idea of where
+	 * dma_mask goes */
+	//mca_dev->dev.dma_mask = &mca_dev->dma_mask;
+
+	if (device_register(&mca_dev->dev))
+		return 0;
+
+	device_create_file(&mca_dev->dev, &dev_attr_id);
+	device_create_file(&mca_dev->dev, &dev_attr_pos);
+
+	return 1;
+}
+
+/* */
+struct mca_bus * __devinit mca_attach_bus(int bus)
+{
+	struct mca_bus *mca_bus;
+
+	if (unlikely(mca_root_busses[bus] != NULL)) {
+		/* This should never happen, but just in case */
+		printk(KERN_EMERG "MCA tried to add already existing bus %d\n",
+		       bus);
+		dump_stack();
+		return NULL;
+	}
+
+	mca_bus = kmalloc(sizeof(struct mca_bus), GFP_KERNEL);
+	if (!mca_bus)
+		return NULL;
+	memset(mca_bus, 0, sizeof(struct mca_bus));
+	sprintf(mca_bus->dev.bus_id,"mca%d",bus);
+	sprintf(mca_bus->dev.name,"Host %s MCA Bridge", bus ? "Secondary" : 
"Primary");
+	device_register(&mca_bus->dev);
+
+	mca_root_busses[bus] = mca_bus;
+
+	return mca_bus;
+}
+
+int __init mca_system_init (void)
+{
+	return bus_register(&mca_bus_type);
+}
+
+EXPORT_SYMBOL (mca_driver_register);
+EXPORT_SYMBOL (mca_driver_unregister);
diff -Nru a/drivers/mca/mca-legacy.c b/drivers/mca/mca-legacy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/mca-legacy.c	Tue Nov 19 13:38:51 2002
@@ -0,0 +1,457 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/*
+ * MCA bus support functions for legacy (2.4) API.
+ *
+ * Legacy API means the API that operates in terms of MCA slot number
+ *
+ * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**----------------------------------------------------------------------------
-
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**----------------------------------------------------------------------------
-
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mca.h>
+#include <asm/io.h>
+
+/* NOTE: This structure is stack allocated */
+struct mca_find_adapter_info {
+	int			id;
+	int			slot;
+	struct mca_device	*mca_dev;
+};
+
+/* The purpose of this iterator is to loop over all the devices and
+ * find the one with the smallest slot number that's just greater than
+ * or equal to the required slot with a matching id */
+static int mca_find_adapter_callback(struct device *dev, void *data)
+{
+	struct mca_find_adapter_info *info = data;
+	struct mca_device *mca_dev = to_mca_device(dev);
+
+	if(mca_dev->pos_id != info->id)
+		return 0;
+
+	if(mca_dev->slot < info->slot)
+		return 0;
+
+	if(!info->mca_dev || info->mca_dev->slot >= mca_dev->slot)
+		info->mca_dev = mca_dev;
+
+	return 0;
+}
+
+/**
+ *	mca_find_adapter - scan for adapters
+ *	@id:	MCA identification to search for
+ *	@start:	starting slot
+ *
+ *	Search the MCA configuration for adapters matching the 16bit
+ *	ID given. The first time it should be called with start as zero
+ *	and then further calls made passing the return value of the
+ *	previous call until %MCA_NOTFOUND is returned.
+ *
+ *	Disabled adapters are not reported.
+ */
+
+int mca_find_adapter(int id, int start)
+{
+	struct mca_find_adapter_info info;
+
+	if(id == 0xffff)
+		return MCA_NOTFOUND;
+
+	info.slot = start;
+	info.id = id;
+	info.mca_dev = NULL;
+
+	for(;;) {
+		bus_for_each_dev(&mca_bus_type, &info, mca_find_adapter_callback);
+
+		if(info.mca_dev == NULL)
+			return MCA_NOTFOUND;
+
+		if(info.mca_dev->status != MCA_ADAPTER_DISABLED)
+			break;
+
+		/* OK, found adapter but it was disabled.  Go around
+		 * again, excluding the slot we just found */
+
+		info.slot = info.mca_dev->slot + 1;
+		info.mca_dev = NULL;
+	}
+		
+	return info.mca_dev->slot;
+}
+EXPORT_SYMBOL(mca_find_adapter);
+
+/*--------------------------------------------------------------------*/
+
+/**
+ *	mca_find_unused_adapter - scan for unused adapters
+ *	@id:	MCA identification to search for
+ *	@start:	starting slot
+ *
+ *	Search the MCA configuration for adapters matching the 16bit
+ *	ID given. The first time it should be called with start as zero
+ *	and then further calls made passing the return value of the
+ *	previous call until %MCA_NOTFOUND is returned.
+ *
+ *	Adapters that have been claimed by drivers and those that
+ *	are disabled are not reported. This function thus allows a driver
+ *	to scan for further cards when some may already be driven.
+ */
+
+int mca_find_unused_adapter(int id, int start)
+{
+	struct mca_find_adapter_info info = { 0 };
+
+	if(id == 0xffff)
+		return MCA_NOTFOUND;
+
+	info.slot = start;
+	info.id = id;
+	info.mca_dev = NULL;
+
+	for(;;) {
+		bus_for_each_dev(&mca_bus_type, &info, mca_find_adapter_callback);
+
+		if(info.mca_dev == NULL)
+			return MCA_NOTFOUND;
+
+		if(info.mca_dev->status != MCA_ADAPTER_DISABLED
+		   && !info.mca_dev->driver_loaded)
+			break;
+
+		/* OK, found adapter but it was disabled or already in
+		 * use.  Go around again, excluding the slot we just
+		 * found */
+
+		info.slot = info.mca_dev->slot + 1;
+		info.mca_dev = NULL;
+	}
+		
+	return info.mca_dev->slot;
+}
+EXPORT_SYMBOL(mca_find_unused_adapter);
+
+/* NOTE: stack allocated structure */
+struct mca_find_device_by_slot_info {
+	int			slot;
+	struct mca_device 	*mca_dev;
+};
+
+static int mca_find_device_by_slot_callback(struct device *dev, void *data)
+{
+	struct mca_find_device_by_slot_info *info = data;
+	struct mca_device *mca_dev = to_mca_device(dev);
+
+	if(mca_dev->slot == info->slot)
+		info->mca_dev = mca_dev;
+
+	return 0;
+}
+
+struct mca_device *mca_find_device_by_slot(int slot)
+{
+	struct mca_find_device_by_slot_info info;
+
+	info.slot = slot;
+	info.mca_dev = NULL;
+
+	bus_for_each_dev(&mca_bus_type, &info, mca_find_device_by_slot_callback);
+
+	return info.mca_dev;
+}
+EXPORT_SYMBOL(mca_find_device_by_slot);
+
+/**
+ *	mca_read_stored_pos - read POS register from boot data
+ *	@slot: slot number to read from
+ *	@reg:  register to read from
+ *
+ *	Fetch a POS value that was stored at boot time by the kernel
+ *	when it scanned the MCA space. The register value is returned.
+ *	Missing or invalid registers report 0.
+ */
+unsigned char mca_read_stored_pos(int slot, int reg)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return 0;
+
+	if(reg < 0 || reg >= 8)
+		return 0;
+
+	return mca_dev->pos[reg];
+}
+EXPORT_SYMBOL(mca_read_stored_pos);
+
+
+/**
+ *	mca_read_pos - read POS register from card
+ *	@slot: slot number to read from
+ *	@reg:  register to read from
+ *
+ *	Fetch a POS value directly from the hardware to obtain the
+ *	current value. This is much slower than mca_read_stored_pos and
+ *	may not be invoked from interrupt context. It handles the
+ *	deep magic required for onboard devices transparently.
+ */
+
+unsigned char mca_read_pos(int slot, int reg)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+	char byte;
+	unsigned long flags;
+
+	if(!mca_dev)
+		return 0;
+
+	if(reg < 0 || reg >= 8)
+		return 0;
+
+	spin_lock_irqsave(&mca_lock, flags);
+	if(mca_dev->pos_register) {
+		/* Disable adapter setup, enable motherboard setup */
+
+		outb_p(0, MCA_ADAPTER_SETUP_REG);
+		outb_p(mca_dev->pos_register, MCA_MOTHERBOARD_SETUP_REG);
+
+		byte = inb_p(MCA_POS_REG(reg));
+		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+	} else {
+
+		/* Make sure motherboard setup is off */
+
+		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+
+		/* Read the appropriate register */
+
+		outb_p(0x8|(mca_dev->slot & 0xf), MCA_ADAPTER_SETUP_REG);
+		byte = inb_p(MCA_POS_REG(reg));
+		outb_p(0, MCA_ADAPTER_SETUP_REG);
+	}
+	spin_unlock_irqrestore(&mca_lock, flags);
+	mca_dev->pos[reg] = byte;
+
+	return byte;
+}
+EXPORT_SYMBOL(mca_read_pos);
+
+		
+/**
+ *	mca_write_pos - read POS register from card
+ *	@slot: slot number to read from
+ *	@reg:  register to read from
+ *	@byte: byte to write to the POS registers
+ *
+ *	Store a POS value directly from the hardware. You should not
+ *	normally need to use this function and should have a very good
+ *	knowledge of MCA bus before you do so. Doing this wrongly can
+ *	damage the hardware.
+ *
+ *	This function may not be used from interrupt context.
+ *
+ *	Note that this a technically a Bad Thing, as IBM tech stuff says
+ *	you should only set POS values through their utilities.
+ *	However, some devices such as the 3c523 recommend that you write
+ *	back some data to make sure the configuration is consistent.
+ *	I'd say that IBM is right, but I like my drivers to work.
+ *
+ *	This function can't do checks to see if multiple devices end up
+ *	with the same resources, so you might see magic smoke if someone
+ *	screws up.
+ */
+
+void mca_write_pos(int slot, int reg, unsigned char byte)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+	unsigned long flags;
+
+	if(!mca_dev)
+		return;
+
+	if(reg < 0 || reg >= 8)
+		return;
+
+	spin_lock_irqsave(&mca_lock, flags);
+
+	/* Make sure motherboard setup is off */
+
+	outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+
+	/* Read in the appropriate register */
+
+	outb_p(0x8|(slot&0xf), MCA_ADAPTER_SETUP_REG);
+	outb_p(byte, MCA_POS_REG(reg));
+	outb_p(0, MCA_ADAPTER_SETUP_REG);
+
+	spin_unlock_irqrestore(&mca_lock, flags);
+
+	/* Update the global register list, while we have the byte */
+
+	mca_dev->pos[reg] = byte;
+}
+EXPORT_SYMBOL(mca_write_pos);
+
+/**
+ *	mca_set_adapter_name - Set the description of the card
+ *	@slot: slot to name
+ *	@name: text string for the namen
+ *
+ *	This function sets the name reported via /proc for this
+ *	adapter slot. This is for user information only. Setting a
+ *	name deletes any previous name.
+ */
+
+void mca_set_adapter_name(int slot, char* name)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return;
+
+	strncpy(mca_dev->dev.name, name, sizeof(mca_dev->dev.name));
+	mca_dev->dev.name[sizeof(mca_dev->dev.name) - 1] = '\0';
+}
+EXPORT_SYMBOL(mca_set_adapter_name);
+
+/**
+ *	mca_get_adapter_name - get the adapter description
+ *	@slot:	slot to query
+ *
+ *	Return the adapter description if set. If it has not been
+ *	set or the slot is out range then return NULL.
+ */
+
+char *mca_get_adapter_name(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return NULL;
+
+	return mca_dev->dev.name;
+}
+EXPORT_SYMBOL(mca_get_adapter_name);
+
+/**
+ *	mca_is_adapter_used - check if claimed by driver
+ *	@slot:	slot to check
+ *
+ *	Returns 1 if the slot has been claimed by a driver
+ */
+
+int mca_is_adapter_used(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return 0;
+
+	return mca_dev->driver_loaded;
+}
+EXPORT_SYMBOL(mca_is_adapter_used);
+
+/**
+ *	mca_mark_as_used - claim an MCA device
+ *	@slot:	slot to claim
+ *	FIXME:  should we make this threadsafe
+ *
+ *	Claim an MCA slot for a device driver. If the
+ *	slot is already taken the function returns 1,
+ *	if it is not taken it is claimed and 0 is
+ *	returned.
+ */
+
+int mca_mark_as_used(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		/* FIXME: this is actually a severe error */
+		return 1;
+
+	if(mca_dev->driver_loaded)
+		return 1;
+
+	mca_dev->driver_loaded = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(mca_mark_as_used);
+
+/**
+ *	mca_mark_as_unused - release an MCA device
+ *	@slot:	slot to claim
+ *
+ *	Release the slot for other drives to use.
+ */
+
+void mca_mark_as_unused(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return;
+
+	mca_dev->driver_loaded = 0;
+}
+EXPORT_SYMBOL(mca_mark_as_unused);
+
+/**
+ *	mca_isadapter - check if the slot holds an adapter
+ *	@slot:	slot to query
+ *
+ *	Returns zero if the slot does not hold an adapter, non zero if
+ *	it does.
+ */
+
+int mca_isadapter(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return 0;
+
+	return mca_dev->status == MCA_ADAPTER_NORMAL
+		|| mca_dev->status == MCA_ADAPTER_DISABLED;
+}
+EXPORT_SYMBOL(mca_isadapter);
+
+/**
+ *	mca_isenabled - check if the slot holds an enabled adapter
+ *	@slot:	slot to query
+ *
+ *	Returns a non zero value if the slot holds an enabled adapter
+ *	and zero for any other case.
+ */
+
+int mca_isenabled(int slot)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return 0;
+
+	return mca_dev->status == MCA_ADAPTER_NORMAL;
+}
diff -Nru a/drivers/mca/mca-proc.c b/drivers/mca/mca-proc.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/mca-proc.c	Tue Nov 19 13:38:51 2002
@@ -0,0 +1,244 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/*
+ * MCA bus support functions for the proc fs.
+ *
+ * NOTE: this code *requires* the legacy MCA api.
+ *
+ * Legacy API means the API that operates in terms of MCA slot number
+ *
+ * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**----------------------------------------------------------------------------
-
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**----------------------------------------------------------------------------
-
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/mca.h>
+
+static int get_mca_info_helper(struct mca_device *mca_dev, char *page, int 
len)
+{
+	int j;
+
+	for(j=0; j<8; j++)
+		len += sprintf(page+len, "%02x ",
+			       mca_dev ? mca_dev->pos[j] : 0xff);
+	len += sprintf(page+len, " %s\n", mca_dev ? mca_dev->dev.name : "");
+	return len;
+}
+
+int get_mca_info(char *page, char **start, off_t off,
+		 int count, int *eof, void *data)
+{
+	int i, len = 0;
+
+	if(MCA_bus) {
+		struct mca_device *mca_dev;
+		/* Format POS registers of eight MCA slots */
+
+		for(i=0; i<MCA_MAX_SLOT_NR; i++) {
+			mca_dev = mca_find_device_by_slot(i);
+
+			len += sprintf(page+len, "Slot %d: ", i+1);
+			len = get_mca_info_helper(mca_dev, page, len);
+		}
+
+		/* Format POS registers of integrated video subsystem */
+
+		mca_dev = mca_find_device_by_slot(MCA_INTEGVIDEO);
+		len += sprintf(page+len, "Video : ");
+		len = get_mca_info_helper(mca_dev, page, len);
+
+		/* Format POS registers of integrated SCSI subsystem */
+
+		mca_dev = mca_find_device_by_slot(MCA_INTEGSCSI);
+		len += sprintf(page+len, "SCSI  : ");
+		len = get_mca_info_helper(mca_dev, page, len);
+
+		/* Format POS registers of motherboard */
+
+		mca_dev = mca_find_device_by_slot(MCA_MOTHERBOARD);
+		len += sprintf(page+len, "Planar: ");
+		len = get_mca_info_helper(mca_dev, page, len);
+	} else {
+		/* Leave it empty if MCA not detected - this should *never*
+		 * happen!
+		 */
+	}
+
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+/*--------------------------------------------------------------------*/
+
+static int mca_default_procfn(char* buf, struct mca_device *mca_dev)
+{
+	int len = 0, i;
+	int slot = mca_dev->slot;
+
+	/* Print out the basic information */
+
+	if(slot < MCA_MAX_SLOT_NR) {
+		len += sprintf(buf+len, "Slot: %d\n", slot+1);
+	} else if(slot == MCA_INTEGSCSI) {
+		len += sprintf(buf+len, "Integrated SCSI Adapter\n");
+	} else if(slot == MCA_INTEGVIDEO) {
+		len += sprintf(buf+len, "Integrated Video Adapter\n");
+	} else if(slot == MCA_MOTHERBOARD) {
+		len += sprintf(buf+len, "Motherboard\n");
+	}
+	if(mca_dev->dev.name[0]) {
+
+		/* Drivers might register a name without /proc handler... */
+
+		len += sprintf(buf+len, "Adapter Name: %s\n",
+			       mca_dev->dev.name);
+	} else {
+		len += sprintf(buf+len, "Adapter Name: Unknown\n");
+	}
+	len += sprintf(buf+len, "Id: %02x%02x\n",
+		mca_dev->pos[1], mca_dev->pos[0]);
+	len += sprintf(buf+len, "Enabled: %s\nPOS: ",
+		mca_isenabled(slot) ? "Yes" : "No");
+	for(i=0; i<8; i++) {
+		len += sprintf(buf+len, "%02x ", mca_dev->pos[i]);
+	}
+	len += sprintf(buf+len, "\nDriver Installed: %s",
+		mca_is_adapter_used(slot) ? "Yes" : "No");
+	buf[len++] = '\n';
+	buf[len] = 0;
+
+	return len;
+} /* mca_default_procfn() */
+
+static int get_mca_machine_info(char* page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int len = 0;
+
+	len += sprintf(page+len, "Model Id: 0x%x\n", machine_id);
+	len += sprintf(page+len, "Submodel Id: 0x%x\n", machine_submodel_id);
+	len += sprintf(page+len, "BIOS Revision: 0x%x\n", BIOS_revision);
+
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+static int mca_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	struct mca_device *mca_dev = (struct mca_device *)data;
+	int len = 0;
+
+	/* Get the standard info */
+
+	len = mca_default_procfn(page, mca_dev);
+
+	/* Do any device-specific processing, if there is any */
+
+	if(mca_dev->procfn) {
+		len += mca_dev->procfn(page+len, mca_dev->slot,
+				       mca_dev->proc_dev);
+	}
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+} /* mca_read_proc() */
+
+/*--------------------------------------------------------------------*/
+
+void __init mca_do_proc_init(void)
+{
+	int i;
+	struct proc_dir_entry *proc_mca;
+	struct proc_dir_entry* node = NULL;
+	struct mca_device *mca_dev;
+
+	proc_mca = proc_mkdir("mca", &proc_root);
+	create_proc_read_entry("pos",0,proc_mca,get_mca_info,NULL);
+	create_proc_read_entry("machine",0,proc_mca,get_mca_machine_info,NULL);
+
+	/* Initialize /proc/mca entries for existing adapters */
+
+	for(i = 0; i < MCA_NUMADAPTERS; i++) {
+		mca_dev = mca_find_device_by_slot(i);
+		if(!mca_dev)
+			continue;
+
+		mca_dev->procfn = NULL;
+
+		if(i < MCA_MAX_SLOT_NR) sprintf(mca_dev->procname,"slot%d", i+1);
+		else if(i == MCA_INTEGVIDEO) sprintf(mca_dev->procname,"video");
+		else if(i == MCA_INTEGSCSI) sprintf(mca_dev->procname,"scsi");
+		else if(i == MCA_MOTHERBOARD) sprintf(mca_dev->procname,"planar");
+
+		if(!mca_isadapter(i)) continue;
+
+		node = create_proc_read_entry(mca_dev->procname, 0, proc_mca,
+					      mca_read_proc, (void *)mca_dev);
+
+		if(node == NULL) {
+			printk("Failed to allocate memory for MCA proc-entries!");
+			return;
+		}
+	}
+
+} /* mca_do_proc_init() */
+
+/**
+ *	mca_set_adapter_procfn - Set the /proc callback
+ *	@slot: slot to configure
+ *	@procfn: callback function to call for /proc
+ *	@dev: device information passed to the callback
+ *
+ *	This sets up an information callback for /proc/mca/slot?.  The
+ *	function is called with the buffer, slot, and device pointer (or
+ *	some equally informative context information, or nothing, if you
+ *	prefer), and is expected to put useful information into the
+ *	buffer.  The adapter name, ID, and POS registers get printed
+ *	before this is called though, so don't do it again.
+ *
+ *	This should be called with a %NULL @procfn when a module
+ *	unregisters, thus preventing kernel crashes and other such
+ *	nastiness.
+ */
+
+void mca_set_adapter_procfn(int slot, MCA_ProcFn procfn, void* proc_dev)
+{
+	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+
+	if(!mca_dev)
+		return;
+
+	mca_dev->procfn = procfn;
+	mca_dev->proc_dev = proc_dev;
+}
+EXPORT_SYMBOL(mca_set_adapter_procfn);
diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Tue Nov 19 13:38:51 2002
+++ b/include/linux/mca.h	Tue Nov 19 13:38:51 2002
@@ -6,6 +6,11 @@
 #ifndef _LINUX_MCA_H
 #define _LINUX_MCA_H
 
+/* FIXME: This shouldn't happen, but we need everything that previously
+ * included mca.h to compile.  Take it out later when the MCA #includes
+ * are sorted out */
+#include <linux/device.h>
+
 /* The detection of MCA bus is done in the real mode (using BIOS).
  * The information is exported to the protected code, where this
  * variable is set to one in case MCA bus was detected.
@@ -19,6 +24,13 @@
  */
 #define MCA_MAX_SLOT_NR  8
 
+/* Most machines have only one MCA bus.  The only multiple bus machines
+ * I know have at most two */
+#define MAX_MCA_BUSSES 2
+
+#define MCA_PRIMARY_BUS		0
+#define MCA_SECONDARY_BUS	1
+
 /* MCA_NOTFOUND is an error condition.  The other two indicate
  * motherboard POS registers contain the adapter.  They might be
  * returned by the mca_find_adapter() function, and can be used as
@@ -35,6 +47,20 @@
 #define MCA_INTEGVIDEO	(MCA_MAX_SLOT_NR+1)
 #define MCA_MOTHERBOARD (MCA_MAX_SLOT_NR+2)
 
+#define MCA_DUMMY_POS_START	0x10000
+#define MCA_INTEGSCSI_POS	(MCA_DUMMY_POS_START+1)
+#define MCA_INTEGVIDEO_POS	(MCA_DUMMY_POS_START+2)
+#define MCA_MOTHERBOARD_POS	(MCA_DUMMY_POS_START+3)
+
+
+/* MCA registers */
+
+#define MCA_MOTHERBOARD_SETUP_REG	0x94
+#define MCA_ADAPTER_SETUP_REG		0x96
+#define MCA_POS_REG(n)			(0x100+(n))
+
+#define MCA_ENABLED	0x01	/* POS 2, set if adapter enabled */
+
 /* Max number of adapters, including both slots and various integrated
  * things.
  */
@@ -78,7 +104,6 @@
  * nastiness.
  */
 typedef int (*MCA_ProcFn)(char* buf, int slot, void* dev);
-extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
 
 /* These routines actually mess with the hardware POS registers.  They
  * temporarily disable the device (and interrupts), so make sure you know
@@ -101,5 +126,75 @@
  * fancy stuff to figure out what might have generated a NMI.
  */
 extern void mca_handle_nmi(void);
+
+enum MCA_AdapterStatus {
+	MCA_ADAPTER_NORMAL = 0,
+	MCA_ADAPTER_NONE = 1,
+	MCA_ADAPTER_DISABLED = 2,
+	MCA_ADAPTER_ERROR = 3
+};
+
+struct mca_bus {
+	u64			default_dma_mask;
+	int			number;
+	struct device		dev;
+};
+#define to_mca_bus(mdev) container_of(mdev, struct mca_bus, dev)
+
+struct mca_device {
+	u64			dma_mask;
+	int			pos_id;
+	int			slot;
+
+	/* is there a driver installed? 0 - No, 1 - Yes */
+	int			driver_loaded;
+	/* POS registers */
+	unsigned char		pos[8];
+	/* if a pseudo adapter of the motherboard, this is the motherboard
+	 * register value to use for setup cycles */
+	short			pos_register;
+	
+	enum MCA_AdapterStatus	status;
+#ifdef CONFIG_PROC_FS
+	/* name of the proc/mca file */
+	char			procname[8];
+	/* /proc info callback */
+	MCA_ProcFn		procfn;
+	/* device/context info for proc callback */
+	void			*proc_dev;
+#endif
+	struct device		dev;
+};
+#define to_mca_device(mdev) container_of(mdev, struct mca_device, dev)
+
+struct mca_driver {
+	const short		*id_table;
+	struct device_driver	driver;
+};
+#define to_mca_driver(mdriver) container_of(mdriver, struct mca_driver, 
driver)
+
+extern int mca_driver_register(struct mca_driver *);
+extern int mca_register_device(int bus, struct mca_device *);
+extern struct mca_device *mca_find_device_by_slot(int slot);
+extern int mca_system_init(void);
+extern struct mca_bus *mca_attach_bus(int);
+
+
+extern spinlock_t mca_lock;
+
+extern struct bus_type mca_bus_type;
+
+#ifdef CONFIG_PROC_FS
+extern void mca_do_proc_init(void);
+extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
+#else
+static inline void mca_do_proc_init(void)
+{
+}
+
+static inline void mca_set_adapter_procfn(int slot, MCA_ProcFn *fn, void* dev)
+{
+}
+#endif
 
 #endif /* _LINUX_MCA_H */

--==_Exmh_-7779081380--




