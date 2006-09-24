Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWIXSFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWIXSFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWIXSFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:05:23 -0400
Received: from mout1.freenet.de ([194.97.50.132]:25056 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1752017AbWIXSFR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:05:17 -0400
Date: Sun, 24 Sep 2006 20:05:11 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.18] pktcdvd driver module: added sysfs interface
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "Greg KH" <greg@kroah.com>, "petero2@telia.com" <petero2@telia.com>,
       torvalds@osdl.org, alan@redhat.com
Content-Type: text/plain; charset=US-ASCII
Message-ID: <op.tgd9kamfiudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a patch for the packet writing module pktcdvd.
The patch adds a sysfs and a debugfs interface, a Kconfig
parameter to switch of the procfs interface off and a
bio write queue congestion handling for the driver.

I got kernel out of memory errors (kernel 2.6.17) while
using the pktcdvd driver writing on a DVDRAM.
When writing big files (>200MB), the drivers internal
bio write queue raised over 200000 entries and more,
since the underlying block driver was not able to process
the write requests as fast as they were supplied to the pktcdvd driver.
This seems to consume all available kernel memory leading
to kernel out of memory faults. (-> KDE crashed and other
funny things happend ;)

Patched files:

drivers/block/pktcdvd.c
drivers/block/Kconfig
include/linux/pktcdvd.h
Documentation/cdrom/packet-writing.txt
Documentation/ABI/testing/sysfs-class-pktcdvd
Documentation/ABI/testing/debugfs-pktcdvd


I wrote a little shell script to control the pktcdvd driver
using the sysfs interface.
See  http://people.freenet.de/BalaGi#pktcdvd

MfG

Thomas Maier

------------------------------------------------------------------------
diff -urpN linux-2.6.18/Documentation/ABI/testing/debugfs-pktcdvd pktcdvd-patch-2.6.18/Documentation/ABI/testing/debugfs-pktcdvd
--- linux-2.6.18/Documentation/ABI/testing/debugfs-pktcdvd	1970-01-01 01:00:00.000000000 +0100
+++ pktcdvd-patch-2.6.18/Documentation/ABI/testing/debugfs-pktcdvd	2006-09-24 17:51:49.000000000 +0200
@@ -0,0 +1,20 @@
+What:           /debug/pktcdvd[0-7]
+Date:           Sep. 2006
+KernelVersion:  2.6.19
+Contact:        Thomas Maier <balagi@justmail.de>
+Description:
+
+debugfs interface
+-----------------
+
+The pktcdvd module (packet writing driver) creates
+these files in debugfs:
+
+/debug/pktcdvd[0-7]/
+    info            (0444) Lots of human readable driver
+                           statistics and infos. Multiple lines!
+
+Example:
+-------
+
+cat /debug/pktcdvd3/info
diff -urpN linux-2.6.18/Documentation/ABI/testing/sysfs-class-pktcdvd pktcdvd-patch-2.6.18/Documentation/ABI/testing/sysfs-class-pktcdvd
--- linux-2.6.18/Documentation/ABI/testing/sysfs-class-pktcdvd	1970-01-01 01:00:00.000000000 +0100
+++ pktcdvd-patch-2.6.18/Documentation/ABI/testing/sysfs-class-pktcdvd	2006-09-24 17:51:49.000000000 +0200
@@ -0,0 +1,78 @@
+What:           /sys/class/pktcdvd/
+Date:           Sep. 2006
+KernelVersion:  2.6.19
+Contact:        Thomas Maier <balagi@justmail.de>
+Description:
+
+sysfs interface
+---------------
+
+The pktcdvd module (packet writing driver) creates
+these files in the sysfs:
+(<devid> is in format  major:minor )
+
+/sys/class/pktcdvd/
+    add            (0200)  Write a block device id to create a
+                           new pktcdvd device and map it to the
+                           block device.
+
+    remove         (0200)  Write the pktcdvd device id or the
+                           mapped block device id to it, to
+                           remove the pktcdvd device.
+
+    device_map     (0444)  Shows the device mapping in format:
+                             pktcdvd[0-7] <pktdevid> <blkdevid>
+
+    packet_buffers (0644)  Number of concurrent packets per
+                           pktcdvd device. Used for new created
+                           devices.
+	
+/sys/class/pktcdvd/pktcdvd[0-7]/
+    dev                   (0444) Device id
+    uevent                (0200) To send an uevent.
+
+/sys/class/pktcdvd/pktcdvd[0-7]/stat/
+    packets_started       (0444) Number of started packets.
+    packets_finished      (0444) Number of finished packets.
+
+    kb_written            (0444) kBytes written.
+    kb_read               (0444) kBytes read.
+    kb_read_gather        (0444) kBytes read to fill write packets.
+
+    reset                 (0200) Write any value to it to reset
+                                 pktcdvd device statistic values, like
+                                 bytes read/written.
+
+/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/
+    size                  (0444) Contains the size of the bio write
+                                 queue.
+
+    congestion_off        (0644) If bio write queue size is below
+                                 this mark, accept new bio requests
+                                 from the block layer.
+
+    congestion_on         (0644) If bio write queue size is higher
+                                 as this mark, do no longer accept
+                                 bio write requests from the block
+                                 layer and wait till the pktcdvd
+                                 device has processed enough bio's
+                                 so that bio write queue size is
+                                 below congestion off mark.
+
+
+
+Example:
+--------
+To use the pktcdvd sysfs interface directly, you can do:
+
+# create a new pktcdvd device mapped to /dev/hdc
+echo "22:0" >/sys/class/pktcdvd/add
+cat /sys/class/pktcdvd/device_map
+# assuming device pktcdvd0 was created, look at stat's
+cat /sys/class/pktcdvd/pktcdvd0/stat/kb_written
+# print the device id of the mapped block device
+fgrep pktcdvd0 /sys/class/pktcdvd/device_map
+# remove device, using pktcdvd0 device id   253:0
+echo "253:0" >/sys/class/pktcdvd/remove
+# same as using the mapped block device id  22:0
+echo "22:0" >/sys/class/pktcdvd/remove
diff -urpN linux-2.6.18/Documentation/cdrom/packet-writing.txt pktcdvd-patch-2.6.18/Documentation/cdrom/packet-writing.txt
--- linux-2.6.18/Documentation/cdrom/packet-writing.txt	2006-09-24 14:25:15.000000000 +0200
+++ pktcdvd-patch-2.6.18/Documentation/cdrom/packet-writing.txt	2006-09-24 17:51:49.000000000 +0200
@@ -1,13 +1,15 @@
  Getting started quick
  ---------------------

-- Select packet support in the block device section and UDF support in
-  the file system section.
+- Select packet support in the block device section (and enable
+  the pktcdvd procfs interface) and UDF support in the file
+  system section.

  - Compile and install kernel and modules, reboot.

  - You need the udftools package (pktsetup, mkudffs, cdrwtool).
    Download from http://sourceforge.net/projects/linux-udf/
+  Note: pktsetup needs the pktcdvd procfs interface!

  - Grab a new CD-RW disc and format it (assuming CD-RW is hdc, substitute
    as appropriate):
@@ -90,6 +92,59 @@ Notes
    to create an ext2 filesystem on the disc.


+
+Using the pktcdvd sysfs interface
+---------------------------------
+
+The pktcdvd module has a sysfs interface and can be controlled
+by the tool "pktcdvd" that uses sysfs.
+(see http://people.freenet.de/BalaGi#pktcdvd )
+
+"pktcdvd" works similar to "pktsetup", e.g.:
+
+	# pktcdvd -a dev_name /dev/hdc
+	# mkudffs /dev/pktcdvd/dev_name
+	# mount -t udf -o rw,noatime /dev/pktcdvd/dev_name /dvdram
+	# cp files /dvdram
+	# umount /dvdram
+	# pktcdvd -r dev_name
+
+
+For a description of the sysfs interface look into the file:
+
+  Documentation/ABI/testing/sysfs-class-pktcdvd
+
+
+Using the pktcdvd debugfs interface
+-----------------------------------
+
+To read pktcdvd device infos in human readable form, do:
+
+	# cat /debug/pktcdvd[0-7]/info
+
+For a description of the debugfs interface look into the file:
+
+  Documentation/ABI/testing/debugfs-pktcdvd
+
+
+
+Bio write queue congestion marks
+--------------------------------
+The pktcdvd driver allows now to adjust the behaviour of the
+internal bio write queue.
+This can be done with the two write_congestion_[on|off] marks.
+The driver does only accept up to write_congestion_on bio
+write request from the i/o block layer, and waits till the
+requests are processed by the mapped block device and
+the queue size is below the write_congestion_off mark.
+In previous versions of pktcdvd, the driver accepted all
+incoming bio write request. This led sometimes to kernel
+out of memory oops (maybe some bugs in the linux kernel ;)
+CAUTION: use this options only if you know what you do!
+The default settings for the congestion marks should be ok
+for everyone.
+	
+
  Links
  -----

diff -urpN linux-2.6.18/drivers/block/Kconfig pktcdvd-patch-2.6.18/drivers/block/Kconfig
--- linux-2.6.18/drivers/block/Kconfig	2006-09-24 14:25:37.000000000 +0200
+++ pktcdvd-patch-2.6.18/drivers/block/Kconfig	2006-09-24 17:51:49.000000000 +0200
@@ -428,17 +428,22 @@ config CDROM_PKTCDVD
  	tristate "Packet writing on CD/DVD media"
  	depends on !UML
  	help
-	  If you have a CDROM drive that supports packet writing, say Y to
-	  include preliminary support. It should work with any MMC/Mt Fuji
-	  compliant ATAPI or SCSI drive, which is just about any newer CD
-	  writer.
+	  If you have a CDROM/DVD drive that supports packet writing, say
+	  Y to include preliminary support. It should work with any
+	  MMC/Mt Fuji compliant ATAPI or SCSI drive, which is just about
+	  any newer DVD/CD writer.

-	  Currently only writing to CD-RW, DVD-RW and DVD+RW discs is possible.
+	  Currently only writing to CD-RW, DVD-RW, DVD+RW and DVDRAM discs
+	  is possible.
  	  DVD-RW disks must be in restricted overwrite mode.

  	  To compile this driver as a module, choose M here: the
  	  module will be called pktcdvd.

+	  For further information see the file
+
+	    Documentation/cdrom/packet-writing.txt
+	
  config CDROM_PKTCDVD_BUFFERS
  	int "Free buffers for data gathering"
  	depends on CDROM_PKTCDVD
@@ -458,6 +463,21 @@ config CDROM_PKTCDVD_WCACHE
  	  this option is dangerous unless the CD-RW media is known good, as we
  	  don't do deferred write error handling yet.

+config CDROM_PKTCDVD_PROCINTF
+	bool "Enable procfs interface"
+	depends on CDROM_PKTCDVD
+	default y
+	help
+	  Enable the proc filesystem interface for pktcdvd.
+	  The files can be found as:
+	
+	  /proc/driver/pktcdvd/pktcdvd<idx>
+	
+	  Also a misc device is added with a dynamic minor device id.
+	  See the entry in  /proc/misc  for the minor number.
+	  The misc pktcdvd driver supports ioctl calls, needed
+	  by the pktsetup tool found in udftools package.
+
  source "drivers/s390/block/Kconfig"

  config ATA_OVER_ETH
diff -urpN linux-2.6.18/drivers/block/pktcdvd.c pktcdvd-patch-2.6.18/drivers/block/pktcdvd.c
--- linux-2.6.18/drivers/block/pktcdvd.c	2006-09-24 14:25:41.000000000 +0200
+++ pktcdvd-patch-2.6.18/drivers/block/pktcdvd.c	2006-09-24 17:51:49.000000000 +0200
@@ -1,6 +1,7 @@
  /*
   * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
   * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ * Copyright (C) 2006 Thomas Maier <balagi@justmail.de>
   *
   * May be copied or modified under the terms of the GNU General Public
   * License.  See linux/COPYING for more information.
@@ -41,8 +42,15 @@
   * gathering to convert the unaligned writes to aligned writes and then feeds
   * them to the packet I/O scheduler.
   *
+ *
+ * 08/19/2006  Thomas Maier <balagi@justmail.de>
+ *	- added support for bio write queue congestion marks
+ * 08/26/2006  Thomas Maier <balagi@justmail.de>
+ *	- added sysfs support
+ *
   *************************************************************************/

+#include <linux/config.h>
  #include <linux/pktcdvd.h>
  #include <linux/module.h>
  #include <linux/types.h>
@@ -56,12 +64,19 @@
  #include <linux/miscdevice.h>
  #include <linux/suspend.h>
  #include <linux/mutex.h>
+#include <linux/sched.h>
  #include <scsi/scsi_cmnd.h>
  #include <scsi/scsi_ioctl.h>
  #include <scsi/scsi.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>

  #include <asm/uaccess.h>

+
+#define DRIVER_NAME	"pktcdvd"
+
+
  #if PACKET_DEBUG
  #define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
  #else
@@ -78,18 +93,690 @@

  #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))

+static int pktdev_major = 0; /* default: dynamic major number */
+static int write_congestion_on  = PKT_WRITE_CONGESTION_ON;
+static int write_congestion_off = PKT_WRITE_CONGESTION_OFF;
+static int packet_buffers = PKT_BUFFERS_DEFAULT;
+
  static struct pktcdvd_device *pkt_devs[MAX_WRITERS];
-static struct proc_dir_entry *pkt_proc;
-static int pkt_major;
  static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
  static mempool_t *psd_pool;

+static struct class	*class_pktcdvd = NULL;
+static struct dentry	*pkt_debugfs_root = NULL;
+
+
+/********************************************************
+ * utils
+ *******************************************************/
+
+static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
+{
+	if (dev_minor >= MAX_WRITERS)
+		return NULL;
+	return pkt_devs[dev_minor];
+}
+
+static struct pktcdvd_device *pkt_find_dev(dev_t devid, int* pidx)
+{
+	int idx;
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (pd && (pd->pkt_dev == devid)) {
+			if (pidx)
+				*pidx = idx;
+			return pd;
+		}
+	}
+	if (pidx)
+		*pidx = 0;
+	return NULL;
+}
+
+static struct pktcdvd_device *pkt_find_dev_bdev(dev_t bdevid, int* pidx)
+{
+	int idx;
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (pd && pd->bdev && (pd->bdev->bd_dev == bdevid)) {
+			if (pidx)
+				*pidx = idx;
+			return pd;
+		}
+	}
+	if (pidx)
+		*pidx = 0;
+	return NULL;
+}
+
+static void init_congestion(int* lo, int* hi)
+{
+	if (*hi > 0) {
+		*hi = max(*hi, PKT_WRITE_CONGESTION_MIN);
+		*hi = min(*hi, PKT_WRITE_CONGESTION_MAX);
+		if (*lo <= 0)
+			*lo = *hi - PKT_WRITE_CONGESTION_THRESHOLD;
+		else {
+			*lo = min(*lo, *hi - PKT_WRITE_CONGESTION_THRESHOLD);
+			*lo = max(*lo, PKT_WRITE_CONGESTION_MIN/4);
+		}
+	} else {
+		*hi = -1;
+		*lo = -1;
+	}
+}
+
+static void init_packet_buffers(int *n)
+{
+	if (*n < 1)
+		*n = 1;
+	else if (*n > 128)
+		*n = 128;
+}
+
+static void pkt_count_states(struct pktcdvd_device *pd, int *states)
+{
+	struct packet_data *pkt;
+	int i;
+
+	for (i = 0; i < PACKET_NUM_STATES; i++)
+		states[i] = 0;
+
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		states[pkt->state]++;
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+}
+
+static int pkt_print_info(struct pktcdvd_device *pd, char *buf, int blen)
+{
+	char *msg;
+	char bdev_buf[BDEVNAME_SIZE];
+	int states[PACKET_NUM_STATES];
+	int n = 0;
+
+#define PRINT	n += scnprintf
+#define BC	buf+n, blen-n
+	PRINT(BC, "Writer %s mapped to %s:\n", pd->name,
+		   		bdevname(pd->bdev, bdev_buf));
+
+	PRINT(BC, "\nSettings:\n");
+	PRINT(BC, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+
+	if (pd->settings.write_type == 0)
+		msg = "Packet";
+	else
+		msg = "Unknown";
+	PRINT(BC, "\twrite type:\t\t%s\n", msg);
+
+	PRINT(BC, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
+	PRINT(BC, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+
+	PRINT(BC, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+
+	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
+		msg = "Mode 1";
+	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
+		msg = "Mode 2";
+	else
+		msg = "Unknown";
+	PRINT(BC, "\tblock mode:\t\t%s\n", msg);
+	PRINT(BC, "\tconcurrent packets:\t%d\n", packet_buffers);
+
+	PRINT(BC, "\nStatistics:\n");
+	PRINT(BC, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
+	PRINT(BC, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
+	PRINT(BC, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
+	PRINT(BC, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
+	PRINT(BC, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
+
+	PRINT(BC, "\nMisc:\n");
+	PRINT(BC, "\treference count:\t%d\n", pd->refcnt);
+	PRINT(BC, "\tflags:\t\t\t0x%lx\n", pd->flags);
+	PRINT(BC, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
+	PRINT(BC, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
+	PRINT(BC, "\tstart offset:\t\t%lu\n", pd->offset);
+	PRINT(BC, "\tmode page offset:\t%u\n", pd->mode_offset);
+
+	PRINT(BC, "\nQueue state:\n");
+	PRINT(BC, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
+	PRINT(BC, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
+	PRINT(BC, "\tcurrent sector:\t\t0x%llx\n",
+					(unsigned long long)pd->current_sector);
+
+	pkt_count_states(pd, states);
+	PRINT(BC, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+	      states[0], states[1], states[2], states[3], states[4], states[5]);
+		
+	PRINT(BC, "\twrite congestion marks:\toff=%d on=%d\n",
+			pd->write_congestion_off,
+			pd->write_congestion_on);
+#undef PRINT
+#undef BC
+	buf[blen-1] = 0;
+	return n;
+}
+
+static struct pktcdvd_dev_kobj* pkt_kobj_create(struct pktcdvd_device *pd,
+				const char* name,
+				struct kobject* parent,
+				struct kobj_type* ktype)
+{
+	struct pktcdvd_dev_kobj *p;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+	kobject_set_name(&p->kobj, "%s", name);
+	p->kobj.parent = parent;
+	p->kobj.ktype = ktype;
+	p->pd = pd;
+	if (kobject_register(&p->kobj) != 0)
+		return NULL;
+	return p;
+}
+static void pkt_kobj_remove(struct pktcdvd_dev_kobj *p)
+{
+	if (p)
+		kobject_unregister(&p->kobj);
+}
+static void pkt_kobj_release(struct kobject *kobj)
+{
+	kfree(to_pktdevkobj(kobj));
+}
+
+/**********************************************************
+ *
+ * sysfs interface for pktcdvd
+ * by (C) 2006  Thomas Maier <balagi@justmail.de>
+ *
+ **********************************************************/
+
+#define DEF_ATTR(_obj,_name,_mode) \
+	static struct attribute _obj = { \
+		.name = _name, .owner = THIS_MODULE, .mode = _mode }
+
+/* forward declaration */
+static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
+static int pkt_remove_dev(dev_t pkt_dev);
+
+/**********************************************************
+  /sys/class/pktcdvd/pktcdvd[0-7]/
+                     write_queue/size
+                     write_queue/congestion_off
+                     write_queue/congestion_on
+                     stat/reset
+                     stat/packets_started
+                     stat/packets_finished
+                     stat/kb_written
+                     stat/kb_read
+                     stat/kb_read_gather
+ **********************************************************/
+
+DEF_ATTR(kobj_pkt_attr_wq1, "size", 0444);
+DEF_ATTR(kobj_pkt_attr_wq2, "congestion_off", 0644);
+DEF_ATTR(kobj_pkt_attr_wq3, "congestion_on",  0644);
+
+static struct attribute *kobj_pkt_attrs_wqueue[] = {
+	&kobj_pkt_attr_wq1,
+	&kobj_pkt_attr_wq2,
+	&kobj_pkt_attr_wq3,
+	NULL
+};
+
+DEF_ATTR(kobj_pkt_attr_st1, "reset", 0200);
+DEF_ATTR(kobj_pkt_attr_st2, "packets_started", 0444);
+DEF_ATTR(kobj_pkt_attr_st3, "packets_finished", 0444);
+DEF_ATTR(kobj_pkt_attr_st4, "kb_written", 0444);
+DEF_ATTR(kobj_pkt_attr_st5, "kb_read", 0444);
+DEF_ATTR(kobj_pkt_attr_st6, "kb_read_gather", 0444);
+
+static struct attribute *kobj_pkt_attrs_stat[] = {
+	&kobj_pkt_attr_st1,
+	&kobj_pkt_attr_st2,
+	&kobj_pkt_attr_st3,
+	&kobj_pkt_attr_st4,
+	&kobj_pkt_attr_st5,
+	&kobj_pkt_attr_st6,
+	NULL
+};
+
+
+#define DECLARE_BUF_AS_STRING(_dbuf, _b, _l) \
+	char _dbuf[64]; int dlen = (_l) < 0 ? 0 : (_l); \
+	if (dlen >= sizeof(_dbuf)) dlen = sizeof(_dbuf)-1; \
+	memcpy(_dbuf, _b, dlen); _dbuf[dlen] = 0
+	
+
+static ssize_t kobj_pkt_show(struct kobject *kobj,
+			struct attribute *attr, char *data)
+{
+	struct pktcdvd_device *pd;
+	int n = 0;
+	int v;
+
+	data[0] = 0;
+	pd = to_pktdevkobj(kobj)->pd;
+
+	if (strcmp(attr->name, "packets_started") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.pkt_started);
+
+	} else if (strcmp(attr->name, "packets_finished") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.pkt_ended);
+
+	} else if (strcmp(attr->name, "kb_written") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_w >> 1);
+
+	} else if (strcmp(attr->name, "kb_read") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_r >> 1);
+
+	} else if (strcmp(attr->name, "kb_read_gather") == 0) {
+		n = sprintf(data, "%lu\n", pd->stats.secs_rg >> 1);
+	
+	} else if (strcmp(attr->name, "size") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->bio_queue_size;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+		
+	} else if (strcmp(attr->name, "congestion_off") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_off;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+
+	} else if (strcmp(attr->name, "congestion_on") == 0) {
+		spin_lock(&pd->lock);
+		v = pd->write_congestion_on;
+		spin_unlock(&pd->lock);
+		n = sprintf(data, "%d\n", v);
+	}
+	return n;
+}
+
+static ssize_t kobj_pkt_store(struct kobject *kobj,
+			struct attribute *attr,
+			const char *data, size_t len)
+{
+	int val;
+	struct pktcdvd_device *pd;
+	DECLARE_BUF_AS_STRING(dbuf, data, len);
+
+	pd = to_pktdevkobj(kobj)->pd;
+
+	if (strcmp(attr->name, "reset") == 0 && dlen > 0) {
+		pd->stats.pkt_started = 0;
+		pd->stats.pkt_ended = 0;
+		pd->stats.secs_w = 0;
+		pd->stats.secs_rg = 0;
+		pd->stats.secs_r = 0;
+		
+	} else if (strcmp(attr->name, "congestion_off") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_off = val;
+		init_congestion(&pd->write_congestion_off,
+				&pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+	} else if (strcmp(attr->name, "congestion_on") == 0
+		   && sscanf(dbuf, "%d", &val) == 1) {
+		spin_lock(&pd->lock);
+		pd->write_congestion_on = val;
+		init_congestion(&pd->write_congestion_off,
+				&pd->write_congestion_on);
+		spin_unlock(&pd->lock);
+	}
+
+	return len;
+}
+
+static struct sysfs_ops kobj_pkt_ops = {
+	.show = kobj_pkt_show,
+	.store = kobj_pkt_store
+};
+static struct kobj_type kobj_pkt_type_stat = {
+	.release = pkt_kobj_release,
+	.sysfs_ops = &kobj_pkt_ops,
+	.default_attrs = kobj_pkt_attrs_stat
+};
+static struct kobj_type kobj_pkt_type_wqueue = {
+	.release = pkt_kobj_release,
+	.sysfs_ops = &kobj_pkt_ops,
+	.default_attrs = kobj_pkt_attrs_wqueue
+};
+
+
+static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
+{
+	if (class_pktcdvd) {
+		pd->clsdev = class_device_create(class_pktcdvd,
+					NULL, pd->pkt_dev,
+					NULL, "%s", pd->name);
+		if (IS_ERR(pd->clsdev))
+			pd->clsdev = NULL;
+	}
+	if (pd->clsdev) {
+		pd->kobj_stat = pkt_kobj_create(pd, "stat",
+					&pd->clsdev->kobj,
+					&kobj_pkt_type_stat);
+		pd->kobj_wqueue = pkt_kobj_create(pd, "write_queue",
+					&pd->clsdev->kobj,
+					&kobj_pkt_type_wqueue);
+	}
+}
+
+static void pkt_sysfs_dev_remove(struct pktcdvd_device *pd)
+{
+	pkt_kobj_remove(pd->kobj_stat);
+	pkt_kobj_remove(pd->kobj_wqueue);
+	if (class_pktcdvd)
+		class_device_destroy(class_pktcdvd, pd->pkt_dev);
+}
+
+
+/********************************************************************
+  /sys/class/pktcdvd/
+                     add            map block device
+                     remove         unmap packet dev
+                     device_map     show mappings
+                     packet_buffers number of packet buffers per dev
+ *******************************************************************/
+
+static void class_pktcdvd_release(struct class *cls)
+{
+	kfree(cls);
+}
+static ssize_t class_pktcdvd_show_map(struct class *c, char *data)
+{
+	int n = 0;
+	int idx;
+	data[0] = 0;
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	for (idx = 0; idx < MAX_WRITERS; idx++) {
+		struct pktcdvd_device *pd = pkt_devs[idx];
+		if (!pd)
+			continue;
+		n += sprintf(data+n, "%s %u:%u %u:%u\n",
+			pd->name,
+			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
+			MAJOR(pd->bdev->bd_dev),
+			MINOR(pd->bdev->bd_dev));
+	}
+	mutex_unlock(&ctl_mutex);
+	return n;
+}
+static ssize_t class_pktcdvd_show_pb(struct class *c, char *data)
+{
+	return sprintf(data, "%d\n", packet_buffers);
+}
+	
+static ssize_t class_pktcdvd_store_add(struct class *c, const char *buf,
+					size_t count)
+{
+	unsigned int major, minor;
+	DECLARE_BUF_AS_STRING(dbuf, buf, count);
+	if (sscanf(dbuf, "%u:%u", &major, &minor) == 2) {
+		pkt_setup_dev(MKDEV(major, minor), NULL);
+		return count;
+	}
+	return -EINVAL;
+}
+static ssize_t class_pktcdvd_store_remove(struct class *c, const char *buf,
+					size_t count)
+{
+	unsigned int major, minor;
+	DECLARE_BUF_AS_STRING(dbuf, buf, count);
+	if (sscanf(dbuf, "%u:%u", &major, &minor) == 2) {
+		pkt_remove_dev(MKDEV(major, minor));
+		return count;
+	}
+	return -EINVAL;
+}
+static ssize_t class_pktcdvd_store_pb(struct class *c, const char *buf,
+					size_t count)
+{
+	int val;
+	DECLARE_BUF_AS_STRING(dbuf, buf, count);
+	if (sscanf(dbuf, "%d", &val) == 1) {
+		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+		init_packet_buffers(&val);
+		packet_buffers = val;
+		mutex_unlock(&ctl_mutex);
+		return count;
+	}
+	return -EINVAL;
+}
+
+static struct class_attribute class_pktcdvd_attrs[] = {
+ __ATTR(add,            0200, NULL, class_pktcdvd_store_add),
+ __ATTR(remove,         0200, NULL, class_pktcdvd_store_remove),
+ __ATTR(device_map,     0444, class_pktcdvd_show_map, NULL),
+ __ATTR(packet_buffers, 0644, class_pktcdvd_show_pb, class_pktcdvd_store_pb),
+ __ATTR_NULL
+};
+
+
+static int pkt_sysfs_init(void)
+{
+	int ret = 0;
+	
+	/*
+	 * create control files in sysfs
+	 * /sys/class/pktcdvd/...
+	 */
+	class_pktcdvd = kzalloc(sizeof(*class_pktcdvd), GFP_KERNEL);
+	if (!class_pktcdvd)
+		return -ENOMEM;
+	class_pktcdvd->name = DRIVER_NAME;
+	class_pktcdvd->owner = THIS_MODULE;
+	class_pktcdvd->class_release = class_pktcdvd_release;
+	class_pktcdvd->class_attrs = class_pktcdvd_attrs;
+	ret = class_register(class_pktcdvd);
+	if (ret) {
+		kfree(class_pktcdvd);
+		class_pktcdvd = NULL;
+		printk(DRIVER_NAME ": failed to create class pktcdvd\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void pkt_sysfs_cleanup(void)
+{
+	if (class_pktcdvd)
+		class_destroy(class_pktcdvd);
+	class_pktcdvd = NULL;
+}
+
+/********************************************************************
+  entries in debugfs
+
+  /debugfs/pktcdvd[0-7]/
+			info
+
+ *******************************************************************/
+static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
+{
+	struct pktcdvd_device *pd = m->private;
+	char buf[1024];
+	
+	pkt_print_info(pd, buf, sizeof(buf));
+	seq_printf(m, "%s", buf);
+	return 0;
+}
+
+static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pkt_debugfs_seq_show, inode->u.generic_ip);
+}
+
+static struct file_operations debug_fops = {
+	.open		= pkt_debugfs_fops_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.owner		= THIS_MODULE,
+};
+
+static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
+{
+	if (!pkt_debugfs_root)
+		return;
+	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
+	if (IS_ERR(pd->dfs_d_root)) {
+		pd->dfs_d_root = NULL;
+		return;
+	}
+	pd->dfs_f_info = debugfs_create_file("info", S_IRUGO,
+				pd->dfs_d_root, pd, &debug_fops);
+	if (IS_ERR(pd->dfs_f_info)) {
+		pd->dfs_f_info = NULL;
+		return;
+	}
+}
+static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
+{
+	if (!pkt_debugfs_root)
+		return;
+	if (pd->dfs_f_info)
+		debugfs_remove(pd->dfs_f_info);
+	pd->dfs_f_info = NULL;
+	if (pd->dfs_d_root)
+		debugfs_remove(pd->dfs_d_root);
+	pd->dfs_d_root = NULL;
+}
+static void pkt_debugfs_init(void)
+{
+	pkt_debugfs_root = debugfs_create_dir(DRIVER_NAME, NULL);
+	if (IS_ERR(pkt_debugfs_root)) {
+		pkt_debugfs_root = NULL;
+		return;
+	}
+}
+static void pkt_debugfs_cleanup(void)
+{
+	if (!pkt_debugfs_root)
+		return;
+	debugfs_remove(pkt_debugfs_root);
+	pkt_debugfs_root = NULL;
+}
+
+
+#if PKT_USE_OLD_PROC
+/********************************************************
+ *
+ * (old) procfs interface
+ *
+ *******************************************************/
+
+static struct proc_dir_entry *pkt_proc;
+
+
+/* file operations for /proc/driver/pktcdvd/.. files */
+
+static int pkt_seq_show(struct seq_file *m, void *p)
+{
+	struct pktcdvd_device *pd = m->private;
+	char buf[1024];
+	
+	pkt_print_info(pd, buf, sizeof(buf));
+	seq_printf(m, "%s", buf);
+	return 0;
+}
+
+static int pkt_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pkt_seq_show, PDE(inode)->data);
+}
+
+static struct file_operations pkt_proc_fops = {
+	.open	= pkt_seq_open,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = single_release
+};
+
+
+/* ioctl call for pktcdvd misc device */
+
+static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
+{
+	struct pktcdvd_device *pd;
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	
+	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
+	if (pd) {
+		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
+		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	} else {
+		ctrl_cmd->dev = 0;
+		ctrl_cmd->pkt_dev = 0;
+	}
+	ctrl_cmd->num_devices = MAX_WRITERS;
+	
+	mutex_unlock(&ctl_mutex);
+}
+
+static int pkt_ctl_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct pkt_ctrl_command ctrl_cmd;
+	int ret = 0;
+	dev_t pkt_dev;
+
+	if (cmd != PACKET_CTRL_CMD)
+		return -ENOTTY;
+
+	if (copy_from_user(&ctrl_cmd, argp, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+
+	switch (ctrl_cmd.command) {
+	case PKT_CTRL_CMD_SETUP:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		ret = pkt_setup_dev(new_decode_dev(ctrl_cmd.dev), &pkt_dev);
+		ctrl_cmd.pkt_dev = new_encode_dev(pkt_dev);
+		break;
+	case PKT_CTRL_CMD_TEARDOWN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		ret = pkt_remove_dev(new_decode_dev(ctrl_cmd.pkt_dev));
+		break;
+	case PKT_CTRL_CMD_STATUS:
+		pkt_get_status(&ctrl_cmd);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	if (copy_to_user(argp, &ctrl_cmd, sizeof(struct pkt_ctrl_command)))
+		return -EFAULT;
+	return ret;
+}
+
+static struct file_operations pkt_ctl_fops = {
+	.ioctl	 = pkt_ctl_ioctl,
+	.owner	 = THIS_MODULE,
+};
+static struct miscdevice pkt_misc = {
+	.minor 		= MISC_DYNAMIC_MINOR,
+	.name  		= DRIVER_NAME,
+	.fops  		= &pkt_ctl_fops
+};
+
+#endif /* PKT_USE_OLD_PROC */
+
+
+/****************************************************************/
+

  static void pkt_bio_finished(struct pktcdvd_device *pd)
  {
  	BUG_ON(atomic_read(&pd->cdrw.pending_bios) <= 0);
  	if (atomic_dec_and_test(&pd->cdrw.pending_bios)) {
-		VPRINTK("pktcdvd: queue empty\n");
+		VPRINTK(DRIVER_NAME ": queue empty\n");
  		atomic_set(&pd->iosched.attention, 1);
  		wake_up(&pd->wqueue);
  	}
@@ -400,7 +1087,7 @@ static void pkt_dump_sense(struct packet
  	int i;
  	struct request_sense *sense = cgc->sense;

-	printk("pktcdvd:");
+	printk(DRIVER_NAME ":");
  	for (i = 0; i < CDROM_PACKET_SIZE; i++)
  		printk(" %02x", cgc->cmd[i]);
  	printk(" - ");
@@ -528,7 +1215,7 @@ static void pkt_iosched_process_queue(st
  				need_write_seek = 0;
  			if (need_write_seek && reads_queued) {
  				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					VPRINTK("pktcdvd: write, waiting\n");
+					VPRINTK(DRIVER_NAME ": write, waiting\n");
  					break;
  				}
  				pkt_flush_cache(pd);
@@ -537,7 +1224,7 @@ static void pkt_iosched_process_queue(st
  		} else {
  			if (!reads_queued && writes_queued) {
  				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					VPRINTK("pktcdvd: read, waiting\n");
+					VPRINTK(DRIVER_NAME ": read, waiting\n");
  					break;
  				}
  				pd->iosched.writing = 1;
@@ -600,7 +1287,7 @@ static int pkt_set_segment_merging(struc
  		set_bit(PACKET_MERGE_SEGS, &pd->flags);
  		return 0;
  	} else {
-		printk("pktcdvd: cdrom max_phys_segments too small\n");
+		printk(DRIVER_NAME ": cdrom max_phys_segments too small\n");
  		return -EIO;
  	}
  }
@@ -891,6 +1578,7 @@ static int pkt_handle_queue(struct pktcd
  	sector_t zone = 0; /* Suppress gcc warning */
  	struct pkt_rb_node *node, *first_node;
  	struct rb_node *n;
+	int wakeup;

  	VPRINTK("handle_queue\n");

@@ -963,7 +1651,14 @@ try_next_bio:
  		pkt->write_size += bio->bi_size / CD_FRAMESIZE;
  		spin_unlock(&pkt->lock);
  	}
+	/* check write congestion marks, and if bio_queue_size is
+	   below, wake up any waiters */
+	wakeup = (pd->write_congestion_on > 0
+	 		&& pd->bio_queue_size <= pd->write_congestion_off
+			&& waitqueue_active(&pd->write_congestion_wqueue));
  	spin_unlock(&pd->lock);
+	if (wakeup)
+		wake_up(&pd->write_congestion_wqueue);

  	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
  	pkt_set_state(pkt, PACKET_WAITING_STATE);
@@ -1049,7 +1744,7 @@ static void pkt_start_write(struct pktcd
  	for (f = 0; f < pkt->frames; f++)
  		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
  			BUG();
-	VPRINTK("pktcdvd: vcnt=%d\n", pkt->w_bio->bi_vcnt);
+	VPRINTK(DRIVER_NAME ": vcnt=%d\n", pkt->w_bio->bi_vcnt);

  	atomic_set(&pkt->io_wait, 1);
  	pkt->w_bio->bi_rw = WRITE;
@@ -1165,21 +1860,6 @@ static void pkt_handle_packets(struct pk
  	spin_unlock(&pd->cdrw.active_list_lock);
  }

-static void pkt_count_states(struct pktcdvd_device *pd, int *states)
-{
-	struct packet_data *pkt;
-	int i;
-
-	for (i = 0; i < PACKET_NUM_STATES; i++)
-		states[i] = 0;
-
-	spin_lock(&pd->cdrw.active_list_lock);
-	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
-		states[pkt->state]++;
-	}
-	spin_unlock(&pd->cdrw.active_list_lock);
-}
-
  /*
   * kcdrwd is woken up when writes have been queued for one of our
   * registered devices
@@ -1286,7 +1966,7 @@ work_to_do:

  static void pkt_print_settings(struct pktcdvd_device *pd)
  {
-	printk("pktcdvd: %s packets, ", pd->settings.fp ? "Fixed" : "Variable");
+	printk(DRIVER_NAME ": %s packets, ", pd->settings.fp ? "Fixed" : "Variable");
  	printk("%u blocks, ", pd->settings.size >> 2);
  	printk("Mode-%c disc\n", pd->settings.block_mode == 8 ? '1' : '2');
  }
@@ -1471,7 +2151,7 @@ static int pkt_set_write_settings(struct
  		/*
  		 * paranoia
  		 */
-		printk("pktcdvd: write mode wrong %d\n", wp->data_block_type);
+		printk(DRIVER_NAME ": write mode wrong %d\n", wp->data_block_type);
  		return 1;
  	}
  	wp->packet_size = cpu_to_be32(pd->settings.size >> 2);
@@ -1515,7 +2195,7 @@ static int pkt_writable_track(struct pkt
  	if (ti->rt == 1 && ti->blank == 0)
  		return 1;

-	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
+	printk(DRIVER_NAME ": bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
  	return 0;
  }

@@ -1533,7 +2213,8 @@ static int pkt_writable_disc(struct pktc
  		case 0x12: /* DVD-RAM */
  			return 1;
  		default:
-			VPRINTK("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+			VPRINTK(DRIVER_NAME ": Wrong disc profile (%x)\n",
+							pd->mmc3_profile);
  			return 0;
  	}

@@ -1542,22 +2223,22 @@ static int pkt_writable_disc(struct pktc
  	 * but i'm not sure, should we leave this to user apps? probably.
  	 */
  	if (di->disc_type == 0xff) {
-		printk("pktcdvd: Unknown disc. No track?\n");
+		printk(DRIVER_NAME ": Unknown disc. No track?\n");
  		return 0;
  	}

  	if (di->disc_type != 0x20 && di->disc_type != 0) {
-		printk("pktcdvd: Wrong disc type (%x)\n", di->disc_type);
+		printk(DRIVER_NAME ": Wrong disc type (%x)\n", di->disc_type);
  		return 0;
  	}

  	if (di->erasable == 0) {
-		printk("pktcdvd: Disc not erasable\n");
+		printk(DRIVER_NAME ": Disc not erasable\n");
  		return 0;
  	}

  	if (di->border_status == PACKET_SESSION_RESERVED) {
-		printk("pktcdvd: Can't write to last track (reserved)\n");
+		printk(DRIVER_NAME ": Can't write to last track (reserved)\n");
  		return 0;
  	}

@@ -1593,12 +2274,12 @@ static int pkt_probe_settings(struct pkt

  	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
  	if ((ret = pkt_get_track_info(pd, track, 1, &ti))) {
-		printk("pktcdvd: failed get_track\n");
+		printk(DRIVER_NAME ": failed get_track\n");
  		return ret;
  	}

  	if (!pkt_writable_track(pd, &ti)) {
-		printk("pktcdvd: can't write to this track\n");
+		printk(DRIVER_NAME ": can't write to this track\n");
  		return -EROFS;
  	}

@@ -1608,11 +2289,11 @@ static int pkt_probe_settings(struct pkt
  	 */
  	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
  	if (pd->settings.size == 0) {
-		printk("pktcdvd: detected zero packet size!\n");
+		printk(DRIVER_NAME ": detected zero packet size!\n");
  		return -ENXIO;
  	}
  	if (pd->settings.size > PACKET_MAX_SECTORS) {
-		printk("pktcdvd: packet size is too big\n");
+		printk(DRIVER_NAME ": packet size is too big\n");
  		return -EROFS;
  	}
  	pd->settings.fp = ti.fp;
@@ -1654,7 +2335,7 @@ static int pkt_probe_settings(struct pkt
  			pd->settings.block_mode = PACKET_BLOCK_MODE2;
  			break;
  		default:
-			printk("pktcdvd: unknown data mode\n");
+			printk(DRIVER_NAME ": unknown data mode\n");
  			return -EROFS;
  	}
  	return 0;
@@ -1688,10 +2369,10 @@ static int pkt_write_caching(struct pktc
  	cgc.buflen = cgc.cmd[8] = 2 + ((buf[0] << 8) | (buf[1] & 0xff));
  	ret = pkt_mode_select(pd, &cgc);
  	if (ret) {
-		printk("pktcdvd: write caching control failed\n");
+		printk(DRIVER_NAME ": write caching control failed\n");
  		pkt_dump_sense(&cgc);
  	} else if (!ret && set)
-		printk("pktcdvd: enabled write caching on %s\n", pd->name);
+		printk(DRIVER_NAME ": enabled write caching on %s\n", pd->name);
  	return ret;
  }

@@ -1805,11 +2486,11 @@ static int pkt_media_speed(struct pktcdv
  	}

  	if (!buf[6] & 0x40) {
-		printk("pktcdvd: Disc type is not CD-RW\n");
+		printk(DRIVER_NAME ": Disc type is not CD-RW\n");
  		return 1;
  	}
  	if (!buf[6] & 0x4) {
-		printk("pktcdvd: A1 values on media are not valid, maybe not CDRW?\n");
+		printk(DRIVER_NAME ": A1 values on media are not valid, maybe not CDRW?\n");
  		return 1;
  	}

@@ -1829,236 +2510,82 @@ static int pkt_media_speed(struct pktcdv
  			*speed = us_clv_to_speed[sp];
  			break;
  		default:
-			printk("pktcdvd: Unknown disc sub-type %d\n",st);
+			printk(DRIVER_NAME ": Unknown disc sub-type %d\n",st);
  			return 1;
  	}
  	if (*speed) {
-		printk("pktcdvd: Max. media speed: %d\n",*speed);
+		printk(DRIVER_NAME ": Max. media speed: %d\n",*speed);
  		return 0;
  	} else {
-		printk("pktcdvd: Unknown speed %d for sub-type %d\n",sp,st);
-		return 1;
-	}
-}
-
-static int pkt_perform_opc(struct pktcdvd_device *pd)
-{
-	struct packet_command cgc;
-	struct request_sense sense;
-	int ret;
-
-	VPRINTK("pktcdvd: Performing OPC\n");
-
-	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
-	cgc.sense = &sense;
-	cgc.timeout = 60*HZ;
-	cgc.cmd[0] = GPCMD_SEND_OPC;
-	cgc.cmd[1] = 1;
-	if ((ret = pkt_generic_packet(pd, &cgc)))
-		pkt_dump_sense(&cgc);
-	return ret;
-}
-
-static int pkt_open_write(struct pktcdvd_device *pd)
-{
-	int ret;
-	unsigned int write_speed, media_write_speed, read_speed;
-
-	if ((ret = pkt_probe_settings(pd))) {
-		VPRINTK("pktcdvd: %s failed probe\n", pd->name);
-		return ret;
-	}
-
-	if ((ret = pkt_set_write_settings(pd))) {
-		DPRINTK("pktcdvd: %s failed saving write settings\n", pd->name);
-		return -EIO;
-	}
-
-	pkt_write_caching(pd, USE_WCACHING);
-
-	if ((ret = pkt_get_max_speed(pd, &write_speed)))
-		write_speed = 16 * 177;
-	switch (pd->mmc3_profile) {
-		case 0x13: /* DVD-RW */
-		case 0x1a: /* DVD+RW */
-		case 0x12: /* DVD-RAM */
-			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
-			break;
-		default:
-			if ((ret = pkt_media_speed(pd, &media_write_speed)))
-				media_write_speed = 16;
-			write_speed = min(write_speed, media_write_speed * 177);
-			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);
-			break;
-	}
-	read_speed = write_speed;
-
-	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
-		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
-		return -EIO;
-	}
-	pd->write_speed = write_speed;
-	pd->read_speed = read_speed;
-
-	if ((ret = pkt_perform_opc(pd))) {
-		DPRINTK("pktcdvd: %s Optimum Power Calibration failed\n", pd->name);
-	}
-
-	return 0;
-}
-
-/*
- * called at open time.
- */
-static int pkt_open_dev(struct pktcdvd_device *pd, int write)
-{
-	int ret;
-	long lba;
-	request_queue_t *q;
-
-	/*
-	 * We need to re-open the cdrom device without O_NONBLOCK to be able
-	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
-	 * so bdget() can't fail.
-	 */
-	bdget(pd->bdev->bd_dev);
-	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
-		goto out;
-
-	if ((ret = bd_claim(pd->bdev, pd)))
-		goto out_putdev;
-
-	if ((ret = pkt_get_last_written(pd, &lba))) {
-		printk("pktcdvd: pkt_get_last_written failed\n");
-		goto out_unclaim;
-	}
-
-	set_capacity(pd->disk, lba << 2);
-	set_capacity(pd->bdev->bd_disk, lba << 2);
-	bd_set_size(pd->bdev, (loff_t)lba << 11);
-
-	q = bdev_get_queue(pd->bdev);
-	if (write) {
-		if ((ret = pkt_open_write(pd)))
-			goto out_unclaim;
-		/*
-		 * Some CDRW drives can not handle writes larger than one packet,
-		 * even if the size is a multiple of the packet size.
-		 */
-		spin_lock_irq(q->queue_lock);
-		blk_queue_max_sectors(q, pd->settings.size);
-		spin_unlock_irq(q->queue_lock);
-		set_bit(PACKET_WRITABLE, &pd->flags);
-	} else {
-		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-		clear_bit(PACKET_WRITABLE, &pd->flags);
-	}
-
-	if ((ret = pkt_set_segment_merging(pd, q)))
-		goto out_unclaim;
-
-	if (write) {
-		if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
-			printk("pktcdvd: not enough memory for buffers\n");
-			ret = -ENOMEM;
-			goto out_unclaim;
-		}
-		printk("pktcdvd: %lukB available on disc\n", lba << 1);
-	}
-
-	return 0;
-
-out_unclaim:
-	bd_release(pd->bdev);
-out_putdev:
-	blkdev_put(pd->bdev);
-out:
-	return ret;
-}
-
-/*
- * called when the device is closed. makes sure that the device flushes
- * the internal cache before we close.
- */
-static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
-{
-	if (flush && pkt_flush_cache(pd))
-		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
-
-	pkt_lock_door(pd, 0);
-
-	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	bd_release(pd->bdev);
-	blkdev_put(pd->bdev);
-
-	pkt_shrink_pktlist(pd);
+		printk(DRIVER_NAME ": Unknown speed %d for sub-type %d\n",sp,st);
+		return 1;
+	}
  }

-static struct pktcdvd_device *pkt_find_dev_from_minor(int dev_minor)
+static int pkt_perform_opc(struct pktcdvd_device *pd)
  {
-	if (dev_minor >= MAX_WRITERS)
-		return NULL;
-	return pkt_devs[dev_minor];
+	struct packet_command cgc;
+	struct request_sense sense;
+	int ret;
+
+	VPRINTK(DRIVER_NAME ": Performing OPC\n");
+
+	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
+	cgc.sense = &sense;
+	cgc.timeout = 60*HZ;
+	cgc.cmd[0] = GPCMD_SEND_OPC;
+	cgc.cmd[1] = 1;
+	if ((ret = pkt_generic_packet(pd, &cgc)))
+		pkt_dump_sense(&cgc);
+	return ret;
  }

-static int pkt_open(struct inode *inode, struct file *file)
+static int pkt_open_write(struct pktcdvd_device *pd)
  {
-	struct pktcdvd_device *pd = NULL;
  	int ret;
+	unsigned int write_speed, media_write_speed, read_speed;

-	VPRINTK("pktcdvd: entering open\n");
-
-	mutex_lock(&ctl_mutex);
-	pd = pkt_find_dev_from_minor(iminor(inode));
-	if (!pd) {
-		ret = -ENODEV;
-		goto out;
+	if ((ret = pkt_probe_settings(pd))) {
+		VPRINTK(DRIVER_NAME ": %s failed probe\n", pd->name);
+		return ret;
  	}
-	BUG_ON(pd->refcnt < 0);

-	pd->refcnt++;
-	if (pd->refcnt > 1) {
-		if ((file->f_mode & FMODE_WRITE) &&
-		    !test_bit(PACKET_WRITABLE, &pd->flags)) {
-			ret = -EBUSY;
-			goto out_dec;
-		}
-	} else {
-		ret = pkt_open_dev(pd, file->f_mode & FMODE_WRITE);
-		if (ret)
-			goto out_dec;
-		/*
-		 * needed here as well, since ext2 (among others) may change
-		 * the blocksize at mount time
-		 */
-		set_blocksize(inode->i_bdev, CD_FRAMESIZE);
+	if ((ret = pkt_set_write_settings(pd))) {
+		DPRINTK(DRIVER_NAME ": %s failed saving write settings\n", pd->name);
+		return -EIO;
  	}

-	mutex_unlock(&ctl_mutex);
-	return 0;
+	pkt_write_caching(pd, USE_WCACHING);

-out_dec:
-	pd->refcnt--;
-out:
-	VPRINTK("pktcdvd: failed open (%d)\n", ret);
-	mutex_unlock(&ctl_mutex);
-	return ret;
-}
+	if ((ret = pkt_get_max_speed(pd, &write_speed)))
+		write_speed = 16 * 177;
+	switch (pd->mmc3_profile) {
+		case 0x13: /* DVD-RW */
+		case 0x1a: /* DVD+RW */
+		case 0x12: /* DVD-RAM */
+			DPRINTK(DRIVER_NAME ": write speed %ukB/s\n", write_speed);
+			break;
+		default:
+			if ((ret = pkt_media_speed(pd, &media_write_speed)))
+				media_write_speed = 16;
+			write_speed = min(write_speed, media_write_speed * 177);
+			DPRINTK(DRIVER_NAME ": write speed %ux\n", write_speed / 176);
+			break;
+	}
+	read_speed = write_speed;

-static int pkt_close(struct inode *inode, struct file *file)
-{
-	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
-	int ret = 0;
+	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
+		DPRINTK(DRIVER_NAME ": %s couldn't set write speed\n", pd->name);
+		return -EIO;
+	}
+	pd->write_speed = write_speed;
+	pd->read_speed = read_speed;

-	mutex_lock(&ctl_mutex);
-	pd->refcnt--;
-	BUG_ON(pd->refcnt < 0);
-	if (pd->refcnt == 0) {
-		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
-		pkt_release_dev(pd, flush);
+	if ((ret = pkt_perform_opc(pd))) {
+		DPRINTK(DRIVER_NAME ": %s Optimum Power Calibration failed\n", pd->name);
  	}
-	mutex_unlock(&ctl_mutex);
-	return ret;
+
+	return 0;
  }


@@ -2077,6 +2604,10 @@ static int pkt_end_io_read_cloned(struct
  	return 0;
  }

+/*
+ * callback from block layer.
+ * process the bio request from the block layer.
+ */
  static int pkt_make_request(request_queue_t *q, struct bio *bio)
  {
  	struct pktcdvd_device *pd;
@@ -2088,7 +2619,7 @@ static int pkt_make_request(request_queu

  	pd = q->queuedata;
  	if (!pd) {
-		printk("pktcdvd: %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
+		printk(DRIVER_NAME ": %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
  		goto end_io;
  	}

@@ -2110,13 +2641,13 @@ static int pkt_make_request(request_queu
  	}

  	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
-		printk("pktcdvd: WRITE for ro device %s (%llu)\n",
+		printk(DRIVER_NAME ": WRITE for ro device %s (%llu)\n",
  			pd->name, (unsigned long long)bio->bi_sector);
  		goto end_io;
  	}

  	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
-		printk("pktcdvd: wrong bio size\n");
+		printk(DRIVER_NAME ": wrong bio size\n");
  		goto end_io;
  	}

@@ -2177,6 +2708,32 @@ static int pkt_make_request(request_queu
  	spin_unlock(&pd->cdrw.active_list_lock);

  	/*
+	 * Test if there is enough room left in the bio work queue
+	 * (queue size >= congestion on mark).
+	 * If not, wait till the work queue size is below the congestion off mark.
+	 * This is similar to the get_request_wait() call made in the block
+	 * layer function __make_request() used for normal block i/o request
+	 * handling.
+	 */
+	spin_lock(&pd->lock);
+	if (pd->write_congestion_on > 0
+	     && pd->bio_queue_size >= pd->write_congestion_on) {
+		DEFINE_WAIT(wait);
+		/* wait till number of bio requests is low enough */
+		do {
+			spin_unlock(&pd->lock);
+			prepare_to_wait_exclusive(&pd->write_congestion_wqueue,
+					&wait, TASK_UNINTERRUPTIBLE);
+			io_schedule();
+			/* if we are here, bio_queue_size should be below
+			   congestion_off, but be sure and do a test */
+			spin_lock(&pd->lock);
+		} while(pd->bio_queue_size > pd->write_congestion_off);
+		finish_wait(&pd->write_congestion_wqueue, &wait);
+	}
+	spin_unlock(&pd->lock);
+
+	/*
  	 * No matching packet found. Store the bio in the work queue.
  	 */
  	node = mempool_alloc(pd->rb_pool, GFP_NOIO);
@@ -2207,8 +2764,9 @@ end_io:
  	return 0;
  }

-
-
+/*
+ * callback from block layer
+ */
  static int pkt_merge_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *bvec)
  {
  	struct pktcdvd_device *pd = q->queuedata;
@@ -2228,98 +2786,253 @@ static int pkt_merge_bvec(request_queue_
  	return remaining;
  }

-static void pkt_init_queue(struct pktcdvd_device *pd)
+
+
+/*
+ * called at open time.
+ */
+static int pkt_open_dev(struct pktcdvd_device *pd, int write)
  {
-	request_queue_t *q = pd->disk->queue;
+	int ret;
+	long lba;
+	request_queue_t *q;

-	blk_queue_make_request(q, pkt_make_request);
-	blk_queue_hardsect_size(q, CD_FRAMESIZE);
-	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
-	blk_queue_merge_bvec(q, pkt_merge_bvec);
-	q->queuedata = pd;
+	/*
+	 * We need to re-open the cdrom device without O_NONBLOCK to be able
+	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
+	 * so bdget() can't fail.
+	 */
+	bdget(pd->bdev->bd_dev);
+	if ((ret = blkdev_get(pd->bdev, FMODE_READ, O_RDONLY)))
+		goto out;
+
+	if ((ret = bd_claim(pd->bdev, pd)))
+		goto out_putdev;
+
+	if ((ret = pkt_get_last_written(pd, &lba))) {
+		printk(DRIVER_NAME ": pkt_get_last_written failed\n");
+		goto out_unclaim;
+	}
+
+	set_capacity(pd->disk, lba << 2);
+	set_capacity(pd->bdev->bd_disk, lba << 2);
+	bd_set_size(pd->bdev, (loff_t)lba << 11);
+
+	q = bdev_get_queue(pd->bdev);
+	if (write) {
+		if ((ret = pkt_open_write(pd)))
+			goto out_unclaim;
+		/*
+		 * Some CDRW drives can not handle writes larger than one packet,
+		 * even if the size is a multiple of the packet size.
+		 */
+		spin_lock_irq(q->queue_lock);
+		blk_queue_max_sectors(q, pd->settings.size);
+		spin_unlock_irq(q->queue_lock);
+		set_bit(PACKET_WRITABLE, &pd->flags);
+	} else {
+		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
+		clear_bit(PACKET_WRITABLE, &pd->flags);
+	}
+
+	if ((ret = pkt_set_segment_merging(pd, q)))
+		goto out_unclaim;
+
+	if (write) {
+		if (!pkt_grow_pktlist(pd, packet_buffers)) {
+			printk(DRIVER_NAME ": not enough memory for buffers\n");
+			ret = -ENOMEM;
+			goto out_unclaim;
+		}
+		printk(DRIVER_NAME ": %lukB available on disc\n", lba << 1);
+	}
+
+	return 0;
+
+out_unclaim:
+	bd_release(pd->bdev);
+out_putdev:
+	blkdev_put(pd->bdev);
+out:
+	return ret;
  }

-static int pkt_seq_show(struct seq_file *m, void *p)
+/*
+ * called when the device is closed. makes sure that the device flushes
+ * the internal cache before we close.
+ */
+static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
  {
-	struct pktcdvd_device *pd = m->private;
-	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
-	int states[PACKET_NUM_STATES];
+	if (flush && pkt_flush_cache(pd))
+		DPRINTK(DRIVER_NAME ": %s not flushing cache\n", pd->name);

-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
+	pkt_lock_door(pd, 0);

-	seq_printf(m, "\nSettings:\n");
-	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
+	bd_release(pd->bdev);
+	blkdev_put(pd->bdev);

-	if (pd->settings.write_type == 0)
-		msg = "Packet";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\twrite type:\t\t%s\n", msg);
+	pkt_shrink_pktlist(pd);
+}
+
+
+
+/******************************************************************
+ *
+ * pktcdvd block device operations
+ *
+ *****************************************************************/
+
+static int pkt_open(struct inode *inode, struct file *file)
+{
+	struct pktcdvd_device *pd = NULL;
+	int ret;
+
+	VPRINTK(DRIVER_NAME ": entering open\n");
+
+	mutex_lock(&ctl_mutex);
+	pd = pkt_find_dev_from_minor(iminor(inode));
+	if (!pd) {
+		ret = -ENODEV;
+		goto out;
+	}
+	BUG_ON(pd->refcnt < 0);
+
+	pd->refcnt++;
+	if (pd->refcnt > 1) {
+		if ((file->f_mode & FMODE_WRITE) &&
+		    !test_bit(PACKET_WRITABLE, &pd->flags)) {
+			ret = -EBUSY;
+			goto out_dec;
+		}
+	} else {
+		ret = pkt_open_dev(pd, file->f_mode & FMODE_WRITE);
+		if (ret)
+			goto out_dec;
+		/*
+		 * needed here as well, since ext2 (among others) may change
+		 * the blocksize at mount time
+		 */
+		set_blocksize(inode->i_bdev, CD_FRAMESIZE);
+	}
+
+	mutex_unlock(&ctl_mutex);
+	return 0;
+
+out_dec:
+	pd->refcnt--;
+out:
+	VPRINTK(DRIVER_NAME ": failed open (%d)\n", ret);
+	mutex_unlock(&ctl_mutex);
+	return ret;
+}
+
+static int pkt_close(struct inode *inode, struct file *file)
+{
+	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
+	int ret = 0;
+
+	mutex_lock(&ctl_mutex);
+	pd->refcnt--;
+	BUG_ON(pd->refcnt < 0);
+	if (pd->refcnt == 0) {
+		int flush = test_bit(PACKET_WRITABLE, &pd->flags);
+		pkt_release_dev(pd, flush);
+	}
+	mutex_unlock(&ctl_mutex);
+	return ret;
+}

-	seq_printf(m, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
-	seq_printf(m, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+			unsigned long arg)
+{
+	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;

-	seq_printf(m, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));

-	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
-		msg = "Mode 1";
-	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
-		msg = "Mode 2";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\tblock mode:\t\t%s\n", msg);
+	switch (cmd) {
+	/*
+	 * forward selected CDROM ioctls to CD-ROM, for UDF
+	 */
+	case CDROMMULTISESSION:
+	case CDROMREADTOCENTRY:
+	case CDROM_LAST_WRITTEN:
+	case CDROM_SEND_PACKET:
+	case SCSI_IOCTL_SEND_COMMAND:
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);

-	seq_printf(m, "\nStatistics:\n");
-	seq_printf(m, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
-	seq_printf(m, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
-	seq_printf(m, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
-	seq_printf(m, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
-	seq_printf(m, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
-
-	seq_printf(m, "\nMisc:\n");
-	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
-	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
-	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
-	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
-	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
-	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
-
-	seq_printf(m, "\nQueue state:\n");
-	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
-	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
-	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
+	case CDROMEJECT:
+		/*
+		 * The door gets locked when the device is opened, so we
+		 * have to unlock it or else the eject command fails.
+		 */
+		if (pd->refcnt == 1)
+			pkt_lock_door(pd, 0);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);

-	pkt_count_states(pd, states);
-	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
-		   states[0], states[1], states[2], states[3], states[4], states[5]);
+	default:
+		VPRINTK(DRIVER_NAME ": Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		return -ENOTTY;
+	}

  	return 0;
  }

-static int pkt_seq_open(struct inode *inode, struct file *file)
+static int pkt_media_changed(struct gendisk *disk)
  {
-	return single_open(file, pkt_seq_show, PDE(inode)->data);
+	struct pktcdvd_device *pd = disk->private_data;
+	struct gendisk *attached_disk;
+
+	if (!pd)
+		return 0;
+	if (!pd->bdev)
+		return 0;
+	attached_disk = pd->bdev->bd_disk;
+	if (!attached_disk)
+		return 0;
+	return attached_disk->fops->media_changed(attached_disk);
  }

-static struct file_operations pkt_proc_fops = {
-	.open	= pkt_seq_open,
-	.read	= seq_read,
-	.llseek	= seq_lseek,
-	.release = single_release
+static struct block_device_operations pktcdvd_ops = {
+	.owner =		THIS_MODULE,
+	.open =			pkt_open,
+	.release =		pkt_close,
+	.ioctl =		pkt_ioctl,
+	.media_changed =	pkt_media_changed,
  };

+
+/***********************************************************************
+ *
+ * packet device setup and removal
+ *
+ **********************************************************************/
+
+/*
+ * helper for pkt_new_dev()
+ */
+ static void pkt_init_queue(struct pktcdvd_device *pd)
+{
+	request_queue_t *q = pd->disk->queue;
+
+	blk_queue_make_request(q, pkt_make_request);
+	blk_queue_hardsect_size(q, CD_FRAMESIZE);
+	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
+	blk_queue_merge_bvec(q, pkt_merge_bvec);
+	q->queuedata = pd;
+}
+/*
+ * helper for pkt_setup_dev()
+ */
  static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
  {
  	int i;
  	int ret = 0;
  	char b[BDEVNAME_SIZE];
-	struct proc_dir_entry *proc;
  	struct block_device *bdev;

  	if (pd->pkt_dev == dev) {
-		printk("pktcdvd: Recursive setup not allowed\n");
+		printk(DRIVER_NAME ": Recursive setup not allowed\n");
  		return -EBUSY;
  	}
  	for (i = 0; i < MAX_WRITERS; i++) {
@@ -2327,11 +3040,11 @@ static int pkt_new_dev(struct pktcdvd_de
  		if (!pd2)
  			continue;
  		if (pd2->bdev->bd_dev == dev) {
-			printk("pktcdvd: %s already setup\n", bdevname(pd2->bdev, b));
+			printk(DRIVER_NAME ": %s already setup\n", bdevname(pd2->bdev, b));
  			return -EBUSY;
  		}
  		if (pd2->pkt_dev == dev) {
-			printk("pktcdvd: Can't chain pktcdvd devices\n");
+			printk(DRIVER_NAME ": Can't chain pktcdvd devices\n");
  			return -EBUSY;
  		}
  	}
@@ -2342,10 +3055,19 @@ static int pkt_new_dev(struct pktcdvd_de
  	ret = blkdev_get(bdev, FMODE_READ, O_RDONLY | O_NONBLOCK);
  	if (ret)
  		return ret;
-
+	
  	/* This is safe, since we have a reference from open(). */
  	__module_get(THIS_MODULE);

+	/* the block device must have a queue ! else many of the
+	   pktcdvd code breaks. */
+	if (!bdev_get_queue(bdev)) {
+		printk(DRIVER_NAME ": block device %s has no request queue, aborting\n",
+			bdevname(bdev, b));
+		ret = -ENXIO;
+		goto out_mem;
+	}
+
  	pd->bdev = bdev;
  	set_blocksize(bdev, CD_FRAMESIZE);

@@ -2354,17 +3076,23 @@ static int pkt_new_dev(struct pktcdvd_de
  	atomic_set(&pd->cdrw.pending_bios, 0);
  	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
  	if (IS_ERR(pd->cdrw.thread)) {
-		printk("pktcdvd: can't start kernel thread\n");
+		printk(DRIVER_NAME ": can't start kernel thread\n");
  		ret = -ENOMEM;
  		goto out_mem;
  	}

-	proc = create_proc_entry(pd->name, 0, pkt_proc);
-	if (proc) {
-		proc->data = pd;
-		proc->proc_fops = &pkt_proc_fops;
+#if PKT_USE_OLD_PROC
+	{
+		struct proc_dir_entry *proc = create_proc_entry(pd->name,
+								0, pkt_proc);
+		if (proc) {
+			proc->data = pd;
+			proc->proc_fops = &pkt_proc_fops;
+		}
  	}
-	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
+#endif
+
+	DPRINTK(DRIVER_NAME ": writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
  	return 0;

  out_mem:
@@ -2374,111 +3102,59 @@ out_mem:
  	return ret;
  }

-static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
-
-	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
-
-	switch (cmd) {
-	/*
-	 * forward selected CDROM ioctls to CD-ROM, for UDF
-	 */
-	case CDROMMULTISESSION:
-	case CDROMREADTOCENTRY:
-	case CDROM_LAST_WRITTEN:
-	case CDROM_SEND_PACKET:
-	case SCSI_IOCTL_SEND_COMMAND:
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
-
-	case CDROMEJECT:
-		/*
-		 * The door gets locked when the device is opened, so we
-		 * have to unlock it or else the eject command fails.
-		 */
-		if (pd->refcnt == 1)
-			pkt_lock_door(pd, 0);
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
-
-	default:
-		VPRINTK("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
-		return -ENOTTY;
-	}
-
-	return 0;
-}
-
-static int pkt_media_changed(struct gendisk *disk)
-{
-	struct pktcdvd_device *pd = disk->private_data;
-	struct gendisk *attached_disk;
-
-	if (!pd)
-		return 0;
-	if (!pd->bdev)
-		return 0;
-	attached_disk = pd->bdev->bd_disk;
-	if (!attached_disk)
-		return 0;
-	return attached_disk->fops->media_changed(attached_disk);
-}
-
-static struct block_device_operations pktcdvd_ops = {
-	.owner =		THIS_MODULE,
-	.open =			pkt_open,
-	.release =		pkt_close,
-	.ioctl =		pkt_ioctl,
-	.media_changed =	pkt_media_changed,
-};
-
  /*
   * Set up mapping from pktcdvd device to CD-ROM device.
   */
-static int pkt_setup_dev(struct pkt_ctrl_command *ctrl_cmd)
+static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
  {
  	int idx;
  	int ret = -ENOMEM;
  	struct pktcdvd_device *pd;
  	struct gendisk *disk;
-	dev_t dev = new_decode_dev(ctrl_cmd->dev);
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

  	for (idx = 0; idx < MAX_WRITERS; idx++)
  		if (!pkt_devs[idx])
  			break;
  	if (idx == MAX_WRITERS) {
-		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
-		return -EBUSY;
+		printk(DRIVER_NAME ": max %d writers supported\n", MAX_WRITERS);
+		ret = -EBUSY;
+		goto out_mutex;
  	}

  	pd = kzalloc(sizeof(struct pktcdvd_device), GFP_KERNEL);
  	if (!pd)
-		return ret;
-
+		goto out_mutex;
+	
  	pd->rb_pool = mempool_create_kmalloc_pool(PKT_RB_POOL_SIZE,
  						  sizeof(struct pkt_rb_node));
  	if (!pd->rb_pool)
  		goto out_mem;
-
-	disk = alloc_disk(1);
-	if (!disk)
-		goto out_mem;
-	pd->disk = disk;
-
+	
  	INIT_LIST_HEAD(&pd->cdrw.pkt_free_list);
  	INIT_LIST_HEAD(&pd->cdrw.pkt_active_list);
  	spin_lock_init(&pd->cdrw.active_list_lock);

  	spin_lock_init(&pd->lock);
  	spin_lock_init(&pd->iosched.lock);
-	sprintf(pd->name, "pktcdvd%d", idx);
+	sprintf(pd->name, DRIVER_NAME "%d", idx);
  	init_waitqueue_head(&pd->wqueue);
  	pd->bio_queue = RB_ROOT;

-	disk->major = pkt_major;
+	init_waitqueue_head(&pd->write_congestion_wqueue);
+	pd->write_congestion_on  = write_congestion_on;
+	pd->write_congestion_off = write_congestion_off;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		goto out_mem;
+	pd->disk = disk;
+	disk->major = pktdev_major;
  	disk->first_minor = idx;
  	disk->fops = &pktcdvd_ops;
  	disk->flags = GENHD_FL_REMOVABLE;
-	sprintf(disk->disk_name, "pktcdvd%d", idx);
+	strcpy(disk->disk_name, pd->name);
  	disk->private_data = pd;
  	disk->queue = blk_alloc_queue(GFP_KERNEL);
  	if (!disk->queue)
@@ -2490,8 +3166,16 @@ static int pkt_setup_dev(struct pkt_ctrl
  		goto out_new_dev;

  	add_disk(disk);
+	
+	pkt_sysfs_dev_new(pd);
+
  	pkt_devs[idx] = pd;
-	ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
+	if (pkt_dev)
+		*pkt_dev = pd->pkt_dev;
+
+	pkt_debugfs_dev_new(pd);
+	
+	mutex_unlock(&ctl_mutex);
  	return 0;

  out_new_dev:
@@ -2502,149 +3186,123 @@ out_mem:
  	if (pd->rb_pool)
  		mempool_destroy(pd->rb_pool);
  	kfree(pd);
+out_mutex:	
+	mutex_unlock(&ctl_mutex);
+	printk(DRIVER_NAME ": setup of pktcdvd device failed\n");
  	return ret;
  }

+
  /*
   * Tear down mapping from pktcdvd device to CD-ROM device.
   */
-static int pkt_remove_dev(struct pkt_ctrl_command *ctrl_cmd)
+static int pkt_remove_dev(dev_t pkt_dev)
  {
  	struct pktcdvd_device *pd;
  	int idx;
-	dev_t pkt_dev = new_decode_dev(ctrl_cmd->pkt_dev);
+	int ret = 0;
+	
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

-	for (idx = 0; idx < MAX_WRITERS; idx++) {
-		pd = pkt_devs[idx];
-		if (pd && (pd->pkt_dev == pkt_dev))
-			break;
-	}
-	if (idx == MAX_WRITERS) {
-		DPRINTK("pktcdvd: dev not setup\n");
-		return -ENXIO;
+	pd = pkt_find_dev(pkt_dev, &idx);
+	if (!pd) {
+		/* maybe pkt_dev is the mapped block device id */
+		pd = pkt_find_dev_bdev(pkt_dev, &idx);
+		if (!pd) {
+			DPRINTK(DRIVER_NAME ": dev not setup\n");
+			ret = -ENXIO;
+			goto out;
+		}
  	}

-	if (pd->refcnt > 0)
-		return -EBUSY;
-
+	if (pd->refcnt > 0) {
+		ret = -EBUSY;
+		goto out;
+	}
  	if (!IS_ERR(pd->cdrw.thread))
  		kthread_stop(pd->cdrw.thread);
+	
+	pkt_devs[idx] = NULL;
+
+	pkt_debugfs_dev_remove(pd);

+	pkt_sysfs_dev_remove(pd);
+	
  	blkdev_put(pd->bdev);

+#if PKT_USE_OLD_PROC
  	remove_proc_entry(pd->name, pkt_proc);
-	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
+#endif
+	DPRINTK(DRIVER_NAME ": writer %s unmapped\n", pd->name);

  	del_gendisk(pd->disk);
  	blk_cleanup_queue(pd->disk->queue);
  	put_disk(pd->disk);

-	pkt_devs[idx] = NULL;
  	mempool_destroy(pd->rb_pool);
  	kfree(pd);

  	/* This is safe: open() is still holding a reference. */
  	module_put(THIS_MODULE);
-	return 0;
-}
-
-static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
-{
-	struct pktcdvd_device *pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
-	if (pd) {
-		ctrl_cmd->dev = new_encode_dev(pd->bdev->bd_dev);
-		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
-	} else {
-		ctrl_cmd->dev = 0;
-		ctrl_cmd->pkt_dev = 0;
-	}
-	ctrl_cmd->num_devices = MAX_WRITERS;
-}
-
-static int pkt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	struct pkt_ctrl_command ctrl_cmd;
-	int ret = 0;
-
-	if (cmd != PACKET_CTRL_CMD)
-		return -ENOTTY;
-
-	if (copy_from_user(&ctrl_cmd, argp, sizeof(struct pkt_ctrl_command)))
-		return -EFAULT;
-
-	switch (ctrl_cmd.command) {
-	case PKT_CTRL_CMD_SETUP:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		ret = pkt_setup_dev(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	case PKT_CTRL_CMD_TEARDOWN:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		ret = pkt_remove_dev(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	case PKT_CTRL_CMD_STATUS:
-		mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-		pkt_get_status(&ctrl_cmd);
-		mutex_unlock(&ctl_mutex);
-		break;
-	default:
-		return -ENOTTY;
-	}
-
-	if (copy_to_user(argp, &ctrl_cmd, sizeof(struct pkt_ctrl_command)))
-		return -EFAULT;
+	
+out:
+	mutex_unlock(&ctl_mutex);
  	return ret;
  }

-
-static struct file_operations pkt_ctl_fops = {
-	.ioctl	 = pkt_ctl_ioctl,
-	.owner	 = THIS_MODULE,
-};
-
-static struct miscdevice pkt_misc = {
-	.minor 		= MISC_DYNAMIC_MINOR,
-	.name  		= "pktcdvd",
-	.fops  		= &pkt_ctl_fops
-};
+/********************************************************
+ *
+ * module init and exit
+ *
+ *******************************************************/

  static int __init pkt_init(void)
  {
  	int ret;

+	/* check module parameters */
+	init_congestion(&write_congestion_off, &write_congestion_on);
+	init_packet_buffers(&packet_buffers);
+
+	mutex_init(&ctl_mutex);
+
  	psd_pool = mempool_create_kmalloc_pool(PSD_POOL_SIZE,
  					sizeof(struct packet_stacked_data));
  	if (!psd_pool)
  		return -ENOMEM;

-	ret = register_blkdev(pkt_major, "pktcdvd");
+	ret = register_blkdev(pktdev_major, DRIVER_NAME);
  	if (ret < 0) {
-		printk("pktcdvd: Unable to register block device\n");
+		printk(DRIVER_NAME ": Unable to register block device\n");
  		goto out2;
  	}
-	if (!pkt_major)
-		pkt_major = ret;
+	if (!pktdev_major)
+		pktdev_major = ret;
+
+	ret = pkt_sysfs_init();
+	if (ret)
+		goto out;

+#if PKT_USE_OLD_PROC
  	ret = misc_register(&pkt_misc);
  	if (ret) {
-		printk("pktcdvd: Unable to register misc device\n");
-		goto out;
+		printk(DRIVER_NAME ": Unable to register misc device\n");
+		goto out_misc;
  	}
-
-	mutex_init(&ctl_mutex);
-
-	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
-
+	pkt_proc = proc_mkdir(DRIVER_NAME, proc_root_driver);
+#endif
+	pkt_debugfs_init();
  	return 0;

+
+#if PKT_USE_OLD_PROC
+out_misc:
+	class_destroy(class_pktcdvd);
+	class_pktcdvd = NULL;
+#endif
+	
  out:
-	unregister_blkdev(pkt_major, "pktcdvd");
+	unregister_blkdev(pktdev_major, DRIVER_NAME);
  out2:
  	mempool_destroy(psd_pool);
  	return ret;
@@ -2652,15 +3310,31 @@ out2:

  static void __exit pkt_exit(void)
  {
-	remove_proc_entry("pktcdvd", proc_root_driver);
+	pkt_debugfs_cleanup();
+	pkt_sysfs_cleanup();
+	
+#if PKT_USE_OLD_PROC
+	remove_proc_entry(DRIVER_NAME, proc_root_driver);
  	misc_deregister(&pkt_misc);
-	unregister_blkdev(pkt_major, "pktcdvd");
+#endif
+	unregister_blkdev(pktdev_major, DRIVER_NAME);
  	mempool_destroy(psd_pool);
  }

+/***************************************************************
+ * module declaration
+ **************************************************************/
+
  MODULE_DESCRIPTION("Packet writing layer for CD/DVD drives");
-MODULE_AUTHOR("Jens Axboe <axboe@suse.de>");
+MODULE_AUTHOR("Jens Axboe <axboe@suse.de>,Peter Osterlund <petero2@telia.com>,"
+              "Thomas Maier <balagi@justmail.de>");
  MODULE_LICENSE("GPL");

  module_init(pkt_init);
  module_exit(pkt_exit);
+
+module_param(pktdev_major, int, 0);
+module_param(write_congestion_on, int, 0);
+module_param(write_congestion_off, int, 0);
+module_param(packet_buffers, int, 0);
+
diff -urpN linux-2.6.18/include/linux/pktcdvd.h pktcdvd-patch-2.6.18/include/linux/pktcdvd.h
--- linux-2.6.18/include/linux/pktcdvd.h	2006-09-24 14:25:58.000000000 +0200
+++ pktcdvd-patch-2.6.18/include/linux/pktcdvd.h	2006-09-24 17:51:49.000000000 +0200
@@ -1,6 +1,7 @@
  /*
   * Copyright (C) 2000 Jens Axboe <axboe@suse.de>
   * Copyright (C) 2001-2004 Peter Osterlund <petero2@telia.com>
+ * Copyright (C) 2006 Thomas Maier <balagi@justmail.de>
   *
   * May be copied or modified under the terms of the GNU General Public
   * License.  See linux/COPYING for more information.
@@ -14,6 +15,38 @@

  #include <linux/types.h>

+
+#define PKT_CTRL_CMD_SETUP	0
+#define PKT_CTRL_CMD_TEARDOWN	1
+#define PKT_CTRL_CMD_STATUS	2
+
+struct pkt_ctrl_command {
+	__u32 command;		/* in: Setup, teardown, status */
+	__u32 dev_index;	/* in/out: Device index */
+	__u32 dev;		/* in/out: Device nr for cdrw device */
+	__u32 pkt_dev;		/* in/out: Device nr for packet device */
+	__u32 num_devices;	/* out: Largest device index + 1 */
+	__u32 padding;		/* Not used */
+};
+
+/*
+ * packet ioctls
+ */
+#define PACKET_IOCTL_MAGIC	('X')
+#define PACKET_CTRL_CMD		_IOWR(PACKET_IOCTL_MAGIC, 1, struct pkt_ctrl_command)
+
+
+
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/cdrom.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
  /*
   * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
   */
@@ -23,25 +56,33 @@

  #define PKT_RB_POOL_SIZE	512

-/*
- * How long we should hold a non-full packet before starting data gathering.
- */
-#define PACKET_WAIT_TIME	(HZ * 5 / 1000)

-/*
- * use drive write caching -- we need deferred error handling to be
- * able to sucessfully recover with this option (drive will return good
- * status as soon as the cdb is validated).
- */
-#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
-#define USE_WCACHING		1
+/* use (old) procfs interface? */
+#ifdef CONFIG_CDROM_PKTCDVD_PROCINTF
+#define PKT_USE_OLD_PROC  1
  #else
-#define USE_WCACHING		0
+#define PKT_USE_OLD_PROC  0
  #endif

+/* use concurrent packets per device */
+#ifdef CONFIG_CDROM_PKTCDVD_BUFFERS
+#define PKT_BUFFERS_DEFAULT CONFIG_CDROM_PKTCDVD_BUFFERS
+#else
+#define PKT_BUFFERS_DEFAULT 8
+#endif
+
+/* default bio write queue congestion marks */
+#define PKT_WRITE_CONGESTION_ON 5000
+#define PKT_WRITE_CONGESTION_OFF 4500
+#define PKT_WRITE_CONGESTION_MAX (1024*1024)
+#define PKT_WRITE_CONGESTION_MIN 100
+#define PKT_WRITE_CONGESTION_THRESHOLD 25
+
+
  /*
- * No user-servicable parts beyond this point ->
+ * How long we should hold a non-full packet before starting data gathering.
   */
+#define PACKET_WAIT_TIME	(HZ * 5 / 1000)

  /*
   * device types
@@ -88,29 +129,19 @@

  #undef PACKET_USE_LS

-#define PKT_CTRL_CMD_SETUP	0
-#define PKT_CTRL_CMD_TEARDOWN	1
-#define PKT_CTRL_CMD_STATUS	2

-struct pkt_ctrl_command {
-	__u32 command;				/* in: Setup, teardown, status */
-	__u32 dev_index;			/* in/out: Device index */
-	__u32 dev;				/* in/out: Device nr for cdrw device */
-	__u32 pkt_dev;				/* in/out: Device nr for packet device */
-	__u32 num_devices;			/* out: Largest device index + 1 */
-	__u32 padding;				/* Not used */
-};

  /*
- * packet ioctls
+ * use drive write caching -- we need deferred error handling to be
+ * able to sucessfully recover with this option (drive will return good
+ * status as soon as the cdb is validated).
   */
-#define PACKET_IOCTL_MAGIC	('X')
-#define PACKET_CTRL_CMD		_IOWR(PACKET_IOCTL_MAGIC, 1, struct pkt_ctrl_command)
+#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
+#define USE_WCACHING		1
+#else
+#define USE_WCACHING		0
+#endif

-#ifdef __KERNEL__
-#include <linux/blkdev.h>
-#include <linux/completion.h>
-#include <linux/cdrom.h>

  struct packet_settings
  {
@@ -241,6 +272,15 @@ struct packet_stacked_data
  };
  #define PSD_POOL_SIZE		64

+
+struct pktcdvd_dev_kobj
+{
+	struct kobject		kobj;
+	struct pktcdvd_device	*pd;
+};
+#define to_pktdevkobj(_k) \
+  ((struct pktcdvd_dev_kobj*)container_of(_k,struct pktcdvd_dev_kobj,kobj))
+
  struct pktcdvd_device
  {
  	struct block_device	*bdev;		/* dev attached */
@@ -271,6 +311,17 @@ struct pktcdvd_device

  	struct packet_iosched   iosched;
  	struct gendisk		*disk;
+	
+	wait_queue_head_t	write_congestion_wqueue;
+	int			write_congestion_off;
+	int			write_congestion_on;
+
+	struct class_device	*clsdev;	/* sysfs pktcdvd[0-7] class dev */
+	struct pktcdvd_dev_kobj	*kobj_stat;	/* sysfs pktcdvd[0-7]/stat/     */
+	struct pktcdvd_dev_kobj	*kobj_wqueue;	/* sysfs pktcdvd[0-7]/write_queue/ */
+	
+	struct dentry		*dfs_d_root;	/* debugfs: devname directory */
+	struct dentry		*dfs_f_info;	/* debugfs: info file */
  };

  #endif /* __KERNEL__ */
