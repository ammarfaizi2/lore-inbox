Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTI1Opk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTI1Opk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 10:45:40 -0400
Received: from havoc.gtf.org ([63.247.75.124]:40351 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262575AbTI1OpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 10:45:02 -0400
Date: Sun, 28 Sep 2003 10:44:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk patches] 2.6.x misc updates
Message-ID: <20030928144428.GA16477@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5

This will update the following files:

 drivers/block/cciss.c             |    2 ++
 drivers/block/ps2esdi.c           |    2 +-
 drivers/char/agp/amd64-agp.c      |    6 +++---
 drivers/ide/legacy/pdc4030.c      |   12 +++---------
 drivers/mca/mca-legacy.c          |    2 +-
 drivers/mca/mca-proc.c            |   11 ++++++++---
 drivers/net/3c523.c               |    2 +-
 drivers/net/3c527.c               |    2 +-
 drivers/net/at1700.c              |    2 +-
 drivers/net/eexpress.c            |    1 -
 drivers/net/ibmlana.c             |    2 +-
 drivers/net/ne2.c                 |    2 +-
 drivers/net/sk_mca.c              |    2 +-
 drivers/net/tokenring/madgemc.c   |    2 +-
 drivers/net/tokenring/smctr.c     |    2 +-
 drivers/net/wireless/arlan-main.c |    2 ++
 include/linux/mca-legacy.h        |    2 ++
 include/linux/mca.h               |    4 ----
 18 files changed, 30 insertions(+), 30 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/09/28 1.1381)
   [BK] "bk ignore" aic7xxx auto-generated files

<jgarzik@redhat.com> (03/09/28 1.1380)
   Misc warning fixes:
   * block/cciss: eliminate "comparison always false" warning
   * char/agp/amd64-agp: properly suffix 64-bit constants
   * ide/legacy/pdc4030: fix incomplete conversion to new IDE module API

<jgarzik@redhat.com> (03/09/28 1.1379)
   [wireless arlan] fix modular build
   
   'probe' module parameter is only used when arlan is built as a module.

<jgarzik@redhat.com> (03/09/28 1.1378)
   [MCA] don't include linux/mca-legacy.h from linux/mca.h.
   
   As the functions and definitions in linux/mca-legacy.h are deprecated,
   require that users explicitly include linux/mca-legacy.h as needed.
   
   Prior to this change, _all_ users of linux/mca.h (i.e. proper users)
   issued a warning at compile time, when the MCA legacy API was enabled.
   Now only actual users of the legacy API cause warnings, not all MCA drivers.

<jgarzik@redhat.com> (03/09/28 1.1377)
   [MCA] convert mca-proc to use not-deprecated functions

<jgarzik@redhat.com> (03/09/28 1.1376)
   [MCA] include linux/mca-legacy.h directly, to access deprecated MCA API




diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/block/cciss.c	Sun Sep 28 10:34:41 2003
@@ -636,9 +636,11 @@
 		{	
 			return -EINVAL;
 		} 
+#if 0 /* 'buf_size' member is 16-bits, and always smaller than kmalloc limit */
 		/* Check kmalloc limits */
 		if(iocommand.buf_size > 128000)
 			return -EINVAL;
+#endif
 		if(iocommand.buf_size > 0)
 		{
 			buff =  kmalloc(iocommand.buf_size, GFP_KERNEL);
diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Sun Sep 28 10:34:40 2003
+++ b/drivers/block/ps2esdi.c	Sun Sep 28 10:34:40 2003
@@ -39,7 +39,7 @@
 #include <linux/genhd.h>
 #include <linux/ps2esdi.h>
 #include <linux/blkdev.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -Nru a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
--- a/drivers/char/agp/amd64-agp.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/char/agp/amd64-agp.c	Sun Sep 28 10:34:41 2003
@@ -91,9 +91,9 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		tmp = agp_bridge->driver->mask_memory(mem->memory[i], mem->type);
 
-		BUG_ON(tmp & 0xffffff0000000ffc);
-		pte = (tmp & 0x000000ff00000000) >> 28;
-		pte |=(tmp & 0x00000000fffff000);
+		BUG_ON(tmp & 0xffffff0000000ffcULL);
+		pte = (tmp & 0x000000ff00000000ULL) >> 28;
+		pte |=(tmp & 0x00000000fffff000ULL);
 		pte |= GPTE_VALID | GPTE_COHERENT;
 
 		agp_bridge->gatt_table[j] = pte;
diff -Nru a/drivers/ide/legacy/pdc4030.c b/drivers/ide/legacy/pdc4030.c
--- a/drivers/ide/legacy/pdc4030.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/ide/legacy/pdc4030.c	Sun Sep 28 10:34:41 2003
@@ -304,22 +304,16 @@
 
 #ifndef MODULE
 	if (enable_promise_support == 0)
-		return;
+		return 0;
 #endif
 
 	for (index = 0; index < MAX_HWIFS; index++) {
 		hwif = &ide_hwifs[index];
-		if (hwif->chipset == ide_unknown && detect_pdc4030(hwif)) {
-#ifndef MODULE
-			setup_pdc4030(hwif);
-#else
+		if (hwif->chipset == ide_unknown && detect_pdc4030(hwif))
 			return setup_pdc4030(hwif);
-#endif
-		}
 	}
-#ifdef MODULE
+
 	return 0;
-#endif
 }
 
 static void __exit release_pdc4030(ide_hwif_t *hwif, ide_hwif_t *mate)
diff -Nru a/drivers/mca/mca-legacy.c b/drivers/mca/mca-legacy.c
--- a/drivers/mca/mca-legacy.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/mca/mca-legacy.c	Sun Sep 28 10:34:41 2003
@@ -28,7 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <asm/io.h>
 
 /* NOTE: This structure is stack allocated */
diff -Nru a/drivers/mca/mca-proc.c b/drivers/mca/mca-proc.c
--- a/drivers/mca/mca-proc.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/mca/mca-proc.c	Sun Sep 28 10:34:41 2003
@@ -120,12 +120,13 @@
 	len += sprintf(buf+len, "Id: %02x%02x\n",
 		mca_dev->pos[1], mca_dev->pos[0]);
 	len += sprintf(buf+len, "Enabled: %s\nPOS: ",
-		mca_isenabled(slot) ? "Yes" : "No");
+		mca_device_status(mca_dev) == MCA_ADAPTER_NORMAL ?
+			"Yes" : "No");
 	for(i=0; i<8; i++) {
 		len += sprintf(buf+len, "%02x ", mca_dev->pos[i]);
 	}
 	len += sprintf(buf+len, "\nDriver Installed: %s",
-		mca_is_adapter_used(slot) ? "Yes" : "No");
+		mca_device_claimed(mca_dev) ? "Yes" : "No");
 	buf[len++] = '\n';
 	buf[len] = 0;
 
@@ -189,6 +190,7 @@
 	/* Initialize /proc/mca entries for existing adapters */
 
 	for(i = 0; i < MCA_NUMADAPTERS; i++) {
+		enum MCA_AdapterStatus status;
 		mca_dev = mca_find_device_by_slot(i);
 		if(!mca_dev)
 			continue;
@@ -200,7 +202,10 @@
 		else if(i == MCA_INTEGSCSI) sprintf(mca_dev->procname,"scsi");
 		else if(i == MCA_MOTHERBOARD) sprintf(mca_dev->procname,"planar");
 
-		if(!mca_isadapter(i)) continue;
+		status = mca_device_status(mca_dev);
+		if (status != MCA_ADAPTER_NORMAL &&
+		    status != MCA_ADAPTER_DISABLED)
+			continue;
 
 		node = create_proc_read_entry(mca_dev->procname, 0, proc_mca,
 					      mca_read_proc, (void *)mca_dev);
diff -Nru a/drivers/net/3c523.c b/drivers/net/3c523.c
--- a/drivers/net/3c523.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/3c523.c	Sun Sep 28 10:34:41 2003
@@ -102,7 +102,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/ethtool.h>
 
 #include <asm/uaccess.h>
diff -Nru a/drivers/net/3c527.c b/drivers/net/3c527.c
--- a/drivers/net/3c527.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/3c527.c	Sun Sep 28 10:34:41 2003
@@ -92,7 +92,7 @@
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
 #include <linux/skbuff.h>
diff -Nru a/drivers/net/at1700.c b/drivers/net/at1700.c
--- a/drivers/net/at1700.c	Sun Sep 28 10:34:40 2003
+++ b/drivers/net/at1700.c	Sun Sep 28 10:34:40 2003
@@ -43,7 +43,7 @@
 #include <linux/errno.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff -Nru a/drivers/net/eexpress.c b/drivers/net/eexpress.c
--- a/drivers/net/eexpress.c	Sun Sep 28 10:34:40 2003
+++ b/drivers/net/eexpress.c	Sun Sep 28 10:34:40 2003
@@ -113,7 +113,6 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
-#include <linux/mca.h>
 #include <linux/mca-legacy.h>
 #include <linux/spinlock.h>
 
diff -Nru a/drivers/net/ibmlana.c b/drivers/net/ibmlana.c
--- a/drivers/net/ibmlana.c	Sun Sep 28 10:34:40 2003
+++ b/drivers/net/ibmlana.c	Sun Sep 28 10:34:40 2003
@@ -82,7 +82,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/time.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff -Nru a/drivers/net/ne2.c b/drivers/net/ne2.c
--- a/drivers/net/ne2.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/ne2.c	Sun Sep 28 10:34:41 2003
@@ -70,7 +70,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
diff -Nru a/drivers/net/sk_mca.c b/drivers/net/sk_mca.c
--- a/drivers/net/sk_mca.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/sk_mca.c	Sun Sep 28 10:34:41 2003
@@ -89,7 +89,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/time.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/version.h>
diff -Nru a/drivers/net/tokenring/madgemc.c b/drivers/net/tokenring/madgemc.c
--- a/drivers/net/tokenring/madgemc.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/tokenring/madgemc.c	Sun Sep 28 10:34:41 2003
@@ -20,7 +20,7 @@
 static const char version[] = "madgemc.c: v0.91 23/01/2000 by Adam Fritzler\n";
 
 #include <linux/module.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
diff -Nru a/drivers/net/tokenring/smctr.c b/drivers/net/tokenring/smctr.c
--- a/drivers/net/tokenring/smctr.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/tokenring/smctr.c	Sun Sep 28 10:34:41 2003
@@ -43,7 +43,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff -Nru a/drivers/net/wireless/arlan-main.c b/drivers/net/wireless/arlan-main.c
--- a/drivers/net/wireless/arlan-main.c	Sun Sep 28 10:34:41 2003
+++ b/drivers/net/wireless/arlan-main.c	Sun Sep 28 10:34:41 2003
@@ -1881,6 +1881,8 @@
 
 #ifdef  MODULE
 
+static int probe = probeUNKNOWN;
+
 static int __init arlan_find_devices(void)
 {
 	int m;
diff -Nru a/include/linux/mca-legacy.h b/include/linux/mca-legacy.h
--- a/include/linux/mca-legacy.h	Sun Sep 28 10:34:41 2003
+++ b/include/linux/mca-legacy.h	Sun Sep 28 10:34:41 2003
@@ -7,6 +7,8 @@
 #ifndef _LINUX_MCA_LEGACY_H
 #define _LINUX_MCA_LEGACY_H
 
+#include <linux/mca.h>
+
 #warning "MCA legacy - please move your driver to the new sysfs api"
 
 /* MCA_NOTFOUND is an error condition.  The other two indicate
diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Sun Sep 28 10:34:40 2003
+++ b/include/linux/mca.h	Sun Sep 28 10:34:40 2003
@@ -136,10 +136,6 @@
 /* WARNING: only called by the boot time device setup */
 extern int mca_register_device(int bus, struct mca_device *mca_dev);
 
-#ifdef CONFIG_MCA_LEGACY
-#include <linux/mca-legacy.h>
-#endif
-
 #ifdef CONFIG_MCA_PROC_FS
 extern void mca_do_proc_init(void);
 extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
