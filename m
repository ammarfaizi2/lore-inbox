Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUHXXir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUHXXir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUHXXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:38:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11720 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269109AbUHXXg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:36:27 -0400
Subject: [PATCH] HVCS hotplug fixes
From: Ryan Arnold <rsa@us.ibm.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Content-Type: multipart/mixed; boundary="=-21oibpQIck6QPsBdmyvJ"
Organization: IBM
Message-Id: <1093390649.3402.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 18:37:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-21oibpQIck6QPsBdmyvJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew and Jeff,

Here is an HVCS (drivers/char/hvcs.c) patch which fixes the hvcs driver
problems with hotplugged vty-server adapters.  The current driver
handles the adapter index assignment improperly so after a number of
device removals and insertions the driver could no longer map a
tty->index to a vty-server properly and tty_open() attempts would fail. 
This patch solves this problem by always assigning the lowest available
index to the new adapters and returning an index to the list when the
adapter is removed.

changelog:
drivers/char/hvcs.c
-----------------------------------------------------------------------
-Added hvcs_index_list to manage the lowest available index.

-Added four helper functions to manage the list, which include the
creation and destruction of the list, the get'ing of the lowest index,
and the returning of an index.

-Moved free_irq() outside of the hvcs_final_close() function in order to
get it out of the spinlock.

-Rearranged hvcs_close() to accomodate the previous change.

-Removed local CLC_LENGTH define and used HVCS_CLC_LENGTH from
arch/ppc64/hvcserver.h instead.

-Cleaned up some printks and did some house keeping on the changelog.

Documentation/powerpc/hvcs.txt
-----------------------------------------------------------------------
-Added information on sysfs 'index' attribute added in previous hvcs
patch.

-Added Q & A section on how to find the proper dev node for a newly
added adapter.


I think this is the last of the HVCS patches for a while, as all of my
oustanding issues have been dealt with.

Ryan S. Arnold
IBM Linux Technology Center

--=-21oibpQIck6QPsBdmyvJ
Content-Disposition: attachment; filename=hvcs_index_draft2.patch
Content-Type: text/x-patch; name=hvcs_index_draft2.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Signed-off-by: Ryan S. Arnold <rsa@us.ibm.com>

--- linux-2.6.8.1/drivers/char/hvcs.c	Tue Aug 24 15:30:35 2004
+++ hvcs_patch1_lkml_linux-2.6.8.1/drivers/char/hvcs.c	Tue Aug 24 17:29:17 2004
@@ -88,30 +88,6 @@
 #include <asm/vio.h>
 
 /*
- * 1.0.0 -> 1.1.0 Added kernel_thread scheduling methodology to driver to
- * replace wait_task constructs.
- *
- * 1.1.0 -> 1.2.0 Moved pi_buff initialization out of arch code into driver code
- * and added locking to share this buffer between hvcs_struct instances.  This
- * is because the page_size kmalloc can't be done with a spin_lock held.
- *
- * Also added sysfs attribute to manually disconnect the vty-server from the vty
- * due to stupid firmware behavior when opening the connection then sending data
- * then then quickly closing the connection would cause data loss on the
- * receiving side.  This required some reordering of the termination code.
- *
- * Fixed the hangup scenario and fixed memory leaks on module_exit.
- *
- * 1.2.0 -> 1.3.0 Moved from manual kernel thread creation & execution to
- * kthread construct which replaced in-kernel IPC for thread termination with
- * kthread_stop and kthread_should_stop.  Explicit wait_queue handling was
- * removed because kthread handles this.  Minor bug fix to postpone partner_info
- * clearing on hvcs_close until adapter removal to preserve context data for
- * printk on partner connection free.  Added lock to protect hvcs_structs so
- * that hvcs_struct instances aren't added or removed during list traversal.
- * Cleaned up comment style, added spaces after commas, and broke function
- * declaration lines to be under 80 columns.
- *
  * 1.3.0 -> 1.3.1 In hvcs_open memset(..,0x00,..) instead of memset(..,0x3F,00).
  * Removed braces around single statements following conditionals.  Removed '=
  * 0' after static int declarations since these default to zero.  Removed
@@ -123,17 +99,28 @@
  * SPIN_LOCK_UNLOCKED at declaration time rather than in hvcs_module_init().
  * Added spin_lock around list_del() in destroy_hvcs_struct() to protect the
  * list traversals from a deletion.  Removed '= NULL' from pointer declaration
- * statements since they are initialized NULL by default.  In hvcs_probe()
- * changed kmalloc(sizeof(*hvcsd),...) to kmalloc(sizeof(struct
- * hvcs_struct),...) because otherwise allocation would only be the size of a
- * pointer.  Removed wmb() instances from hvcs_try_write().  They probably
- * aren't needed with locking in place.  Added check and cleanup for
- * hvcs_pi_buff = kmalloc() in hvcs_module_init().  Exposed hvcs_struct.index
- * via a sysfs attribute so that the coupling between /dev/hvcs* and a
- * vty-server can be automatically determined.  Moved kobject_put() in hvcs_open
- * outside of the spin_unlock_irqrestore().
+ * statements since they are initialized NULL by default.  Removed wmb()
+ * instances from hvcs_try_write().  They probably aren't needed with locking in
+ * place.  Added check and cleanup for hvcs_pi_buff = kmalloc() in
+ * hvcs_module_init().  Exposed hvcs_struct.index via a sysfs attribute so that
+ * the coupling between /dev/hvcs* and a vty-server can be automatically
+ * determined.  Moved kobject_put() in hvcs_open outside of the
+ * spin_unlock_irqrestore().
+ *
+ * 1.3.1 -> 1.3.2 Changed method for determining hvcs_struct->index and had it
+ * align with how the tty layer always assigns the lowest index available.  This
+ * change resulted in a list of ints that denotes which indexes are available.
+ * Device additions and removals use the new hvcs_get_index() and
+ * hvcs_return_index() helper functions.  The list is created with
+ * hvsc_alloc_index_list() and it is destroyed with hvcs_free_index_list().
+ * Without these fixes hotplug vty-server adapter support goes crazy with this
+ * driver if the user removes a vty-server adapter.  Moved free_irq() outside of
+ * the hvcs_final_close() function in order to get it out of the spinlock.
+ * Rearranged hvcs_close().  Cleaned up some printks and did some housekeeping
+ * on the changelog.  Removed local CLC_LENGTH and used HVCS_CLC_LENGTH from
+ * arch/ppc64/hvcserver.h.
  */
-#define HVCS_DRIVER_VERSION "1.3.1"
+#define HVCS_DRIVER_VERSION "1.3.2"
 
 MODULE_AUTHOR("Ryan S. Arnold <rsa@us.ibm.com>");
 MODULE_DESCRIPTION("IBM hvcs (Hypervisor Virtual Console Server) Driver");
@@ -159,9 +146,9 @@
 
 /*
  * We let Linux assign us a major number and we start the minors at zero.  There
- * is no intuitive mapping between minor number and the target partition.  The
- * mapping of minor number is related to the order the vty-servers are exposed
- * to this driver via the hvcs_probe function.
+ * is no intuitive mapping between minor number and the target vty-server
+ * adapter except that each new vty-server adapter is always assigned to the
+ * smallest minor number available.
  */
 #define HVCS_MINOR_START	0
 
@@ -173,9 +160,6 @@
  */
 #define __ALIGNED__	__attribute__((__aligned__(8)))
 
-/* Converged location code string length + 1 null terminator */
-#define CLC_LENGTH		80
-
 /*
  * How much data can firmware send with each hvc_put_chars()?  Maybe this
  * should be moved into an architecture specific area.
@@ -220,14 +204,25 @@
 static struct tty_driver *hvcs_tty_driver;
 
 /*
- * This is used to associate a vty-server, as it is exposed to this driver, with
- * a preallocated tty_struct.index.  The dev node and hvcs index numbers are not
- * re-used after device removal otherwise removing and adding a new one would
- * link a /dev/hvcs* entry to a different vty-server than it did before the
- * removal.  Incidentally, a newly exposed vty-server will always map to an
- * incrementally higher /dev/hvcs* entry than the last exposed vty-server.
+ * In order to be somewhat sane this driver always associates the hvcs_struct
+ * index element with the numerically equal tty->index.  This means that a
+ * hotplugged vty-server adapter will always map to the lowest index valued
+ * device node.  If vty-servers were hotplug removed from the system and then
+ * new ones added the new vty-server may have the largest slot number of all
+ * the vty-server adapters in the partition but it may have the lowest dev node
+ * index of all the adapters due to the hole left by the hotplug removed
+ * adapter.  There are a set of functions provided to get the lowest index for
+ * a new device as well as return the index to the list.  This list is allocated
+ * with a number of elements equal to the number of device nodes requested when
+ * the module was inserted.
  */
-static int hvcs_struct_count = -1;
+static int *hvcs_index_list;
+
+/*
+ * How large is the list?  This is kept for traversal since the list is
+ * dynamically created.
+ */
+static int hvcs_index_count;
 
 /*
  * Used by the khvcsd to pick up I/O operations when the kernel_thread is
@@ -235,7 +230,10 @@
  */
 static int hvcs_kicked;
 
-/* Used the the kthread construct for task operations */
+/*
+ * Use by the kthread construct for task operations like waking the sleeping
+ * thread and stopping the kthread.
+ */
 static struct task_struct *hvcs_task;
 
 /*
@@ -244,6 +242,7 @@
  */
 static unsigned long *hvcs_pi_buff;
 
+/* Only allow one hvcs_struct to use the hvcs_pi_buff at a time. */
 static spinlock_t hvcs_pi_lock = SPIN_LOCK_UNLOCKED;
 
 /* One vty-server per hvcs_struct */
@@ -286,7 +285,7 @@
 	int connected; /* is the vty-server currently connected to a vty? */
 	uint32_t p_unit_address; /* partner unit address */
 	uint32_t p_partition_ID; /* partner partition ID */
-	char p_location_code[CLC_LENGTH];
+	char p_location_code[HVCS_CLC_LENGTH + 1]; /* CLC + Null Term */
 	struct list_head next; /* list management */
 	struct vio_dev *vdev;
 };
@@ -522,6 +521,19 @@
 };
 MODULE_DEVICE_TABLE(vio, hvcs_driver_table);
 
+static void hvcs_return_index(int index)
+{
+	/* Paranoia check */
+	if (!hvcs_index_list)
+		return;
+	if (index < 0 || index >= hvcs_index_count)
+		return;
+	if (hvcs_index_list[index] == -1)
+		return;
+	else
+		hvcs_index_list[index] = -1;
+}
+
 /* callback when the kboject ref count reaches zero */
 static void destroy_hvcs_struct(struct kobject *kobj)
 {
@@ -551,7 +563,8 @@
 
 	hvcsd->p_unit_address = 0;
 	hvcsd->p_partition_ID = 0;
-	memset(&hvcsd->p_location_code[0], 0x00, CLC_LENGTH);
+	hvcs_return_index(hvcsd->index);
+	memset(&hvcsd->p_location_code[0], 0x00, HVCS_CLC_LENGTH + 1);
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	spin_unlock(&hvcs_structs_lock);
@@ -561,11 +574,13 @@
 	kfree(hvcsd);
 }
 
-/* This function must be called with hvcsd->lock held. */
+/*
+ * This function must be called with hvcsd->lock held.  Do not free the irq in
+ * this function since it is called with the spinlock held.
+ */
 static void hvcs_final_close(struct hvcs_struct *hvcsd)
 {
 	vio_disable_interrupts(hvcsd->vdev);
-	free_irq(hvcsd->vdev->irq, hvcsd);
 
 	hvcsd->todo_mask = 0;
 
@@ -585,18 +600,43 @@
 	.release = destroy_hvcs_struct,
 };
 
+static int hvcs_get_index(void)
+{
+	int i;
+	/* Paranoia check */
+	if (!hvcs_index_list) {
+		printk(KERN_ERR "HVCS: hvcs_index_list NOT valid!.\n");
+		return -EFAULT;
+	}
+	/* Find the numerically lowest first free index. */
+	for(i = 0; i < hvcs_index_count; i++) {
+		if (hvcs_index_list[i] == -1) {
+			hvcs_index_list[i] = 0;
+			return i;
+		}
+	}
+	return -1;
+}
+
 static int __devinit hvcs_probe(
 	struct vio_dev *dev,
 	const struct vio_device_id *id)
 {
 	struct hvcs_struct *hvcsd;
+	int index;
 
 	if (!dev || !id) {
 		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
 		return -EPERM;
 	}
 
-	hvcsd = kmalloc(sizeof(struct hvcs_struct), GFP_KERNEL);
+	/* early to avoid cleanup on failure */
+	index = hvcs_get_index();
+	if (index < 0) {
+		return -EFAULT;
+	}
+
+	hvcsd = kmalloc(sizeof(*hvcsd), GFP_KERNEL);
 	if (!hvcsd)
 		return -ENODEV;
 
@@ -612,7 +652,9 @@
 	hvcsd->vdev = dev;
 	dev->dev.driver_data = hvcsd;
 
-	hvcsd->index = ++hvcs_struct_count;
+	hvcsd->index = index;
+
+	/* hvcsd->index = ++hvcs_struct_count; */
 	hvcsd->chars_in_buffer = 0;
 	hvcsd->todo_mask = 0;
 	hvcsd->connected = 0;
@@ -641,7 +683,7 @@
 
 	hvcs_create_device_attrs(hvcsd);
 
-	printk(KERN_INFO "HVCS: Added vty-server@%X.\n", dev->unit_address);
+	printk(KERN_INFO "HVCS: vty-server@%X added to the vio bus.\n", dev->unit_address);
 
 	/*
 	 * DON'T enable interrupts here because there is no user to receive the
@@ -650,6 +692,8 @@
 	return 0;
 }
 
+
+
 static int __devexit hvcs_remove(struct vio_dev *dev)
 {
 	struct hvcs_struct *hvcsd = dev->dev.driver_data;
@@ -704,8 +748,8 @@
 	hvcsd->p_unit_address = pi->unit_address;
 	hvcsd->p_partition_ID  = pi->partition_ID;
 	clclength = strlen(&pi->location_code[0]);
-	if (clclength > CLC_LENGTH - 1)
-		clclength = CLC_LENGTH - 1;
+	if (clclength > HVCS_CLC_LENGTH)
+		clclength = HVCS_CLC_LENGTH;
 
 	/* copy the null-term char too */
 	strncpy(&hvcsd->p_location_code[0],
@@ -946,7 +990,8 @@
 	 * This function increments the kobject index.
 	 */
 	if (!(hvcsd = hvcs_get_by_index(tty->index))) {
-		printk(KERN_WARNING "HVCS: open failed, no index.\n");
+		printk(KERN_WARNING "HVCS: open failed, no device associated"
+				" with tty->index %d.\n", tty->index);
 		return -ENODEV;
 	}
 
@@ -984,7 +1029,7 @@
 
 	/*
 	 * This must be done outside of the spinlock because it requests irqs
-	 * and will grab the spinlcok and free the connection if it fails.
+	 * and will grab the spinlock and free the connection if it fails.
 	 */
 	if (((rc = hvcs_enable_device(hvcsd, unit_address, irq, vdev)))) {
 		kobject_put(&hvcsd->kobj);
@@ -1012,7 +1057,7 @@
 open_success:
 	hvcs_kick();
 
-	printk(KERN_INFO "HVCS: vty-server@%X opened.\n",
+	printk(KERN_INFO "HVCS: vty-server@%X connection opened.\n",
 		hvcsd->vdev->unit_address );
 
 	return 0;
@@ -1022,7 +1067,7 @@
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	kobject_put(&hvcsd->kobj);
 
-	printk(KERN_WARNING "HVCS: HVCS partner connect failed.\n");
+	printk(KERN_WARNING "HVCS: partner connect failed.\n");
 	return retval;
 }
 
@@ -1031,6 +1076,7 @@
 	struct hvcs_struct *hvcsd;
 	unsigned long flags;
 	struct kobject *kobjp;
+	int irq = NO_IRQ;
 
 	/*
 	 * Is someone trying to close the file associated with this device after
@@ -1050,6 +1096,7 @@
 	hvcsd = tty->driver_data;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
+	kobjp = &hvcsd->kobj;
 	if (--hvcsd->open_count == 0) {
 
 		/*
@@ -1084,16 +1131,18 @@
 		}
 
 		hvcs_final_close(hvcsd);
-
+		irq = hvcsd->vdev->irq;
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		free_irq(irq, hvcsd);
+		kobject_put(kobjp);
+		return;
 	} else if (hvcsd->open_count < 0) {
 		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
 				" is missmanaged.\n",
-			hvcsd->vdev->unit_address, hvcsd->open_count);
+		hvcsd->vdev->unit_address, hvcsd->open_count);
 	}
-	kobjp = &hvcsd->kobj;
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
-
 	kobject_put(kobjp);
 }
 
@@ -1103,6 +1152,7 @@
 	unsigned long flags;
 	int temp_open_count;
 	struct kobject *kobjp;
+	int irq = NO_IRQ;
 
 	spin_lock_irqsave(&hvcsd->lock, flags);
 	/* Preserve this so that we know how many kobject refs to put */
@@ -1118,9 +1168,12 @@
 
 	/* Calling this will drop any buffered data on the floor. */
 	hvcs_final_close(hvcsd);
+	irq = hvcsd->vdev->irq;
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 
+	free_irq(irq, hvcsd);
+
 	/*
 	 * We need to kobject_put() for every open_count we have since the
 	 * tty_hangup() function doesn't invoke a close per open connection on a
@@ -1305,6 +1358,28 @@
 	.throttle = hvcs_throttle,
 };
 
+static int hvcs_alloc_index_list(int n)
+{
+	int i;
+	hvcs_index_list = kmalloc(n * sizeof(hvcs_index_count),GFP_KERNEL);
+	if (!hvcs_index_list)
+		return -ENOMEM;
+	hvcs_index_count = n;
+	for(i = 0; i < hvcs_index_count; i++)
+		hvcs_index_list[i] = -1;
+	return 0;
+}
+
+static void hvcs_free_index_list(void)
+{
+	/* Paranoia check to be thorough. */
+	if (hvcs_index_list) {
+		kfree(hvcs_index_list);
+		hvcs_index_list = NULL;
+		hvcs_index_count = 0;
+	}
+}
+
 static int __init hvcs_module_init(void)
 {
 	int rc;
@@ -1323,6 +1398,9 @@
 	if (!hvcs_tty_driver)
 		return -ENOMEM;
 
+	if (hvcs_alloc_index_list(num_ttys_to_alloc))
+		return -ENOMEM;
+
 	hvcs_tty_driver->owner = THIS_MODULE;
 
 	hvcs_tty_driver->driver_name = hvcs_driver_name;
@@ -1353,6 +1431,7 @@
 	if (tty_register_driver(hvcs_tty_driver)) {
 		printk(KERN_ERR "HVCS: registration "
 			" as a tty driver failed.\n");
+		hvcs_free_index_list();
 		put_tty_driver(hvcs_tty_driver);
 		return rc;
 	}
@@ -1360,14 +1439,17 @@
 	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!hvcs_pi_buff) {
 		tty_unregister_driver(hvcs_tty_driver);
+		hvcs_free_index_list();
 		put_tty_driver(hvcs_tty_driver);
 		return -ENOMEM;
 	}
 
 	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
-		printk("khvcsd creation failed.  Driver not loaded.\n");
+		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
+		tty_unregister_driver(hvcs_tty_driver);
+		hvcs_free_index_list();
 		put_tty_driver(hvcs_tty_driver);
 		return -EIO;
 	}
@@ -1408,6 +1490,8 @@
 	vio_unregister_driver(&hvcs_vio_driver);
 
 	tty_unregister_driver(hvcs_tty_driver);
+
+	hvcs_free_index_list();
 
 	put_tty_driver(hvcs_tty_driver);
 
--- linux-2.6.8.1/Documentation/powerpc/hvcs.txt	Sat Aug 14 05:55:09 2004
+++ hvcs_patch1_lkml_linux-2.6.8.1/Documentation/powerpc/hvcs.txt	Tue Aug 24 17:14:18 2004
@@ -10,7 +10,7 @@
 
 	       Author(s) :  Ryan S. Arnold <rsa@us.ibm.com>
 		       Date Created: March, 02, 2004
-		       Last Changed: July, 07, 2004
+		       Last Changed: August, 24, 2004
 
 ---------------------------------------------------------------------------
 Table of contents:
@@ -243,6 +243,25 @@
 continue using the previous user's logged in session which includes
 using the $TERM variable that the previous user supplied.
 
+Hotplug add and remove of vty-server adapters affects which /dev/hvcs* node
+is used to connect to each vty-server adapter.  In order to determine which
+vty-server adapter is associated with which /dev/hvcs* node a special sysfs
+attribute has been added to each vty-server sysfs entry.  This entry is
+called "index" and showing it reveals an integer that refers to the
+/dev/hvcs* entry to use to connect to that device.  For instance cating the
+index attribute of vty-server adapter 30000004 shows the following.
+
+	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # cat index
+	2
+
+This index of '2' means that in order to connect to vty-server adapter
+30000004 the user should interact with /dev/hvcs2.
+
+It should be noted that due to the system hotplug I/O capabilities of a
+system the /dev/hvcs* entry that interacts with a particular vty-server
+adapter is not guarenteed to remain the same across system reboots.  Look
+in the Q & A section for more on this issue.
+
 ---------------------------------------------------------------------------
 6. Disconnection
 
@@ -328,8 +347,8 @@
 looks like the following:
 
 	Pow5:/sys/bus/vio/drivers/hvcs/30000004 # ls
-	.   current_vty   devspec  partner_clcs  vterm_state
-	..  detach_state  name     partner_vtys
+	.   current_vty   devspec  name          partner_vtys
+	..  detach_state  index    partner_clcs  vterm_state
 
 Each entry is provided, by default with a "name" attribute.  Reading the
 "name" attribute will reveal the device type as shown in the following
@@ -498,6 +517,20 @@
 A: Yes, if you have dlpar and hotplug enabled for your system and it has
 been built into the kernel the hvcs drivers is configured to dynamically
 handle additions of new devices and removals of unused devices.
+
+---------------------------------------------------------------------------
+Q: For some reason /dev/hvcs* doesn't map to the same vty-server adapter
+after a reboot.  What happened?
+
+A: Assignment of vty-server adapters to /dev/hvcs* entries is always done
+in the order that the adapters are exposed.  Due to hotplug capabilities of
+this driver assignment of hotplug added vty-servers may be in a different
+order than how they would be exposed on module load.  Rebooting or
+reloading the module after dynamic addition may result in the /dev/hvcs*
+and vty-server coupling changing if a vty-server adapter was added in a
+slot inbetween two other vty-server adapters.  Refer to the section above
+on how to determine which vty-server goes with which /dev/hvcs* node.
+Hint; look at the sysfs "index" attribute for the vty-server.
 
 ---------------------------------------------------------------------------
 Q: Can I use /dev/hvcs* as a conduit to another partition and use a tty

--=-21oibpQIck6QPsBdmyvJ--

