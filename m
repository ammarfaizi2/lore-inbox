Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSJYWM7>; Fri, 25 Oct 2002 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJYWM7>; Fri, 25 Oct 2002 18:12:59 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:16382 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S261627AbSJYWMU>; Fri, 25 Oct 2002 18:12:20 -0400
Message-ID: <3DB9C3F2.3000800@mvista.com>
Date: Fri, 25 Oct 2002 15:21:38 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Advanced TCA SCSI / FC Disk Hotswap revision 0.92
Content-Type: multipart/mixed;
 boundary="------------050805010200080600070800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050805010200080600070800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is an update of the Advanced TCA disk hotswap driver to provide 
disk hotswap
support for the Linux Kernel 2.5.44.  Hotswap targets include both SCSI 
and FibreChannel.
Note this support is generic in that it will work in a typical PC system 
with SCSI or
FibreChannel disks.

The patch includes support for the QLA adaptor but this adaptor is not 
included in the
standard linux kernel.  If you havn't patched your kernel with this 
driver, just ignore the
patch for the qla adaptor to still gain all functionality except for 
hotswap using
that adaptor for WWN identifiers.

As always, the latest Advanced TCA hotswap patches (including scsi disk 
hotswap) can be found:

http://www.sourceforge.net/projects/atca-hotswap

Changes from kernel 2.5.44 0.90 to 0.91 release:
-----------------------------------------------------------------
* Dumped custom ramfs and integrated with driverfs under 
bus/scsi/hotswap_commads (suggested by several people)
* changed read_file to _show and write_file to _store while also 
changing symantics
* switched lun/id and lun/wwn ordering to id/lun and wwn/lun (pointed as 
an error by Michael Anderson)
* spinlocks changed to semaphores to fix lock held during sleep in 
function scsi_eh_bus_device_reset (pointed as an error by Patrick Mansfield)

Thanks for looking at the patch...
-steve

--------------050805010200080600070800
Content-Type: text/plain;
 name="linux-2.5.44-scsi-hotswap-0.91.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.44-scsi-hotswap-0.91.patch"

diff -uNr linux-2.5.44-qla/MAINTAINERS linux-2.5.44-scsi-hotswap/MAINTAINERS
--- linux-2.5.44-qla/MAINTAINERS	Fri Oct 18 21:01:59 2002
+++ linux-2.5.44-scsi-hotswap/MAINTAINERS	Wed Oct 23 11:44:05 2002
@@ -1418,6 +1418,12 @@
 W:	http://www.kernel.dk
 S:	Maintained
 
+SCSI HOTSWAP DRIVER
+P:	Steven Dake
+M:	sdake@mvista.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 SCSI SG DRIVER
 P:	Doug Gilbert
 M:	dgilbert@interlog.com
diff -uNr linux-2.5.44-qla/drivers/scsi/Config.help linux-2.5.44-scsi-hotswap/drivers/scsi/Config.help
--- linux-2.5.44-qla/drivers/scsi/Config.help	Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Config.help	Wed Oct 23 11:44:06 2002
@@ -34,6 +34,17 @@
   is located on a SCSI disk. In this case, do not compile the driver
   for your SCSI host adapter (below) as a module either.
 
+CONFIG_SCSIFCHOTSWAP
+ If you want to support the ability to include the hotswap FibreChannel
+ and SCSI driver, please say yes here.  Hotswap can then be executed
+ through a ramfs interface which provides better error reporting.
+
+ Further, this interface supports insertion and removal by WWN for
+ FibreChannel drivers which support this feature.
+
+ The only FibreChannel driver that supports this feature is Qlogic V6
+ with a specific support patch.
+
 CONFIG_SD_EXTRA_DEVS
   This controls the amount of additional space allocated in tables for
   drivers that are loaded as modules after the kernel is booted.  In
diff -uNr linux-2.5.44-qla/drivers/scsi/Config.in linux-2.5.44-scsi-hotswap/drivers/scsi/Config.in
--- linux-2.5.44-qla/drivers/scsi/Config.in	Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Config.in	Wed Oct 23 11:44:06 2002
@@ -1,5 +1,6 @@
 comment 'SCSI support type (disk, tape, CD-ROM)'
 
+dep_tristate '  SCSI hotswap support' CONFIG_SCSIFCHOTSWAP $CONFIG_SCSI
 dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
 
 if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
diff -uNr linux-2.5.44-qla/drivers/scsi/Makefile linux-2.5.44-scsi-hotswap/drivers/scsi/Makefile
--- linux-2.5.44-qla/drivers/scsi/Makefile	Wed Oct 23 10:26:12 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/Makefile	Wed Oct 23 11:44:06 2002
@@ -117,6 +117,7 @@
 
 obj-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi/
 
+obj-$(CONFIG_SCSIFCHOTSWAP)	+= hotswap.o
 obj-$(CONFIG_CHR_DEV_ST)	+= st.o
 obj-$(CONFIG_CHR_DEV_OSST)	+= osst.o
 obj-$(CONFIG_BLK_DEV_SD)	+= sd_mod.o
diff -uNr linux-2.5.44-qla/drivers/scsi/hosts.c linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c
--- linux-2.5.44-qla/drivers/scsi/hosts.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c	Fri Oct 25 13:41:46 2002
@@ -371,6 +371,7 @@
 	scsi_hosts_registered++;
 
 	spin_lock_init(&shost->default_lock);
+	sema_init (&shost->host_queue_sema, 1);
 	scsi_assign_lock(shost, &shost->default_lock);
 	atomic_set(&shost->host_active,0);
 
diff -uNr linux-2.5.44-qla/drivers/scsi/hosts.h linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.h
--- linux-2.5.44-qla/drivers/scsi/hosts.h	Fri Oct 18 21:01:21 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.h	Fri Oct 25 13:29:16 2002
@@ -264,6 +264,12 @@
      */
     int (* bios_param)(Disk *, struct block_device *, int []);
 
+	/*
+	 * Used to determine the id to send the inquiry command to during
+	 * hot additions of FibreChannel targets
+	 */
+	int (*get_scsi_info_from_wwn)(int mode, unsigned long long wwn, int *host, int *channel, int *lun, int *id);
+
     /*
      * This determines if we will use a non-interrupt driven
      * or an interrupt driven scheme,  It is set to the maximum number
@@ -374,6 +380,7 @@
      */
     struct list_head      sh_list;
     Scsi_Device           * host_queue;
+    struct semaphore	  host_queue_sema;
     struct list_head	  all_scsi_hosts;
     struct list_head	  my_devices;
 
diff -uNr linux-2.5.44-qla/drivers/scsi/hotswap.c linux-2.5.44-scsi-hotswap/drivers/scsi/hotswap.c
--- linux-2.5.44-qla/drivers/scsi/hotswap.c	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hotswap.c	Fri Oct 25 13:44:05 2002
@@ -0,0 +1,921 @@
+/*
+ * hotswap.c
+ *
+ * SCSI/FibreChannel Hotswap kernel implementaton
+ * 
+ * Author: MontaVista Software, Inc.
+ *         Steven Dake (sdake@mvista.com)
+ *         source@mvista.com
+ *
+ * Copyright (C) 2002 MontaVista Software Inc.
+ *
+ * Derived from linux/scsi/scsi.c hotswap code
+ *
+ * 	added FibreChannel hotswap by both WWN/host/channel/lun and WWN wildcard
+ * 	added ramfs interface
+ * 	added locking to scsi host queue structure (list of scsi devices on host)
+ * 	changed ramfs to be based on driverfs /bus/scsi/hotswap_commands
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Library General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU Library General Public
+ *  License along with this program; if not, write to the Free
+ *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/types.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/blk.h>
+#include <asm/semaphore.h>
+#include <linux/device.h>
+
+#include <asm/uaccess.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include <linux/scsi_hotswap.h>
+
+#define SCSI_HOTSWAP_MAGIC 0x02834431
+
+#define DRIVER_VERSION "0.91"
+#define DRIVER_AUTHOR "MontaVista Software Inc, Steven Dake <sdake@mvista.com>"
+#define DRIVER_DESCRIPTION "SCSI and FibreChannel Hotswap Core"
+
+
+/*
+ * Prototypes
+ */
+static int scsi_hotswap_attr_open (struct driver_dir_entry *dir);
+static int scsi_hotswap_attr_close (struct driver_dir_entry *dir);
+static ssize_t
+scsi_hotswap_attr_show (struct driver_dir_entry *dir, struct attribute *attr,
+		char *buf, size_t count, loff_t offset);
+static ssize_t
+scsi_hotswap_attr_store(struct driver_dir_entry * dir, struct attribute *attr,
+		           const char *buf, size_t count, loff_t offset);
+
+static ssize_t scsi_hotswap_insert_by_scsi_id_show (char *buf, size_t count,
+	loff_t offset);
+static ssize_t scsi_hotswap_insert_by_scsi_id_store (char *buf,
+	size_t count, loff_t offset);
+static ssize_t scsi_hotswap_remove_by_scsi_id_show (char *buf, size_t count,
+	loff_t offset); 
+static ssize_t scsi_hotswap_remove_by_scsi_id_store (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_insert_by_fc_wwn_show (char *buf, size_t count,
+	loff_t offset); 
+static ssize_t scsi_hotswap_insert_by_fc_wwn_store (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_remove_by_fc_wwn_show (char *buf, size_t count,
+	loff_t offset); 
+static ssize_t scsi_hotswap_remove_by_fc_wwn_store (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_show (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_store (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_show (char *buf,
+	size_t count, loff_t offset); 
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_store (char *buf,
+	size_t count, loff_t offset); 
+
+/*
+ * show usage for commands
+ */
+static char scsi_hotswap_insert_by_scsi_id_usage[] = {
+	"Usage: echo \"[host] [channel] [id] [lun]\" > insert_by_scsi_id\n"
+};
+
+static char scsi_hotswap_remove_by_scsi_id_usage[] = {
+	"Usage: echo \"[host] [channel] [id] [lun]\" > remove_by_scsi_id\n"
+};
+
+static char scsi_hotswap_insert_by_fc_wwn_usage[]  = {
+	"Usage: echo \"[host] [channel] [wwn] [lun]\" > insert_by_fc_wwn\n"
+};
+
+static char scsi_hotswap_remove_by_fc_wwn_usage[]  = {
+	"Usage: echo \"[host] [channel] [wwn] [lun]\" > remove_by_fc_wwn\n"
+};
+
+static char scsi_hotswap_insert_by_fc_wwn_wildcard_usage[]  = {
+	"Usage: echo \"[wwn]\" > insert_by_fc_wwn_wildcard\n"
+};
+
+static char scsi_hotswap_remove_by_fc_wwn_wildcard_usage[]  = {
+	"Usage: echo \"[wwn]\" > remove_by_fc_wwn_wildcard\n"
+};
+
+/*
+ * DriverFS structures
+ */
+
+extern struct bus_type scsi_driverfs_bus_type;
+
+struct scsi_hotswap_commands_attribute {
+	struct attribute attr;
+	ssize_t (*show) (char *buf, size_t count, loff_t offset);
+	ssize_t (*store) (char *buf, size_t count, loff_t offset);
+};
+
+static struct driverfs_ops scsi_hotswap_attr_ops = {
+	.open	= scsi_hotswap_attr_open,
+	.close	= scsi_hotswap_attr_close,
+	.show	= scsi_hotswap_attr_show,
+	.store	= scsi_hotswap_attr_store,
+};
+
+static struct driver_dir_entry scsi_hotswap_commands_dir = {
+	.name	= "hotswap_commands",
+	.mode	= (S_IFDIR | S_IRWXU),
+	.ops	= &scsi_hotswap_attr_ops,
+};
+
+/*
+ * Hotswap commands file entires /bus/scsi/hotswap_commands
+ */
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_insert_by_scsi_id = {
+	.attr	= {
+		.name	= "insert_by_scsi_id",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_insert_by_scsi_id_show,
+	.store	= scsi_hotswap_insert_by_scsi_id_store,
+};
+
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_remove_by_scsi_id = {
+	.attr	= {
+		.name	= "remove_by_scsi_id",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_remove_by_scsi_id_show,
+	.store	= scsi_hotswap_remove_by_scsi_id_store,
+};
+
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_insert_by_fc_wwn = {
+	.attr	= {
+		.name	= "insert_by_fc_wwn",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_insert_by_fc_wwn_show,
+	.store	= scsi_hotswap_insert_by_fc_wwn_store,
+};
+
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_remove_by_fc_wwn = {
+	.attr	= {
+		.name	= "remove_by_fc_wwn",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_remove_by_fc_wwn_show,
+	.store	= scsi_hotswap_remove_by_fc_wwn_store,
+};
+
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_insert_by_fc_wwn_wildcard = {
+	.attr	= {
+		.name	= "insert_by_fc_wwn_wildcard",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_insert_by_fc_wwn_wildcard_show,
+	.store	= scsi_hotswap_insert_by_fc_wwn_wildcard_store,
+};
+
+static struct scsi_hotswap_commands_attribute
+scsi_hotswap_commands_attr_remove_by_fc_wwn_wildcard = {
+	.attr	= {
+		.name	= "remove_by_fc_wwn_wildcard",
+		.mode	= S_IRUGO
+	},
+	.show	= scsi_hotswap_remove_by_fc_wwn_wildcard_show,
+	.store	= scsi_hotswap_remove_by_fc_wwn_wildcard_store,
+};
+/*
+ * Core Interface Implementation
+ * Note these are exported to the global symbol table for
+ * other subsystems to use such as a scsi processor or 1394
+ */
+int scsi_hotswap_insert_by_scsi_id (unsigned int host, unsigned int channel,
+	unsigned int id, unsigned int lun)
+{
+	struct Scsi_Host *scsi_host;
+	Scsi_Device *scsi_device;
+
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host == 0) {
+		return (-ENXIO);
+	}
+
+	if (down_interruptible (&scsi_host->host_queue_sema)) {
+		return (-ERESTARTSYS);
+	}
+
+	/*
+	 * Determine if device already attached
+	 */
+	for (scsi_device = scsi_host->host_queue; scsi_device; scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+	
+	up (&scsi_host->host_queue_sema);
+
+	/*
+	 * If scsi_device found in host queue, then device already attached
+	 */
+	if (scsi_device) {
+		return (-EEXIST);
+	}
+
+	scan_scsis(scsi_host, 1, channel, id, lun);
+
+	return (0);
+}
+
+int scsi_hotswap_remove_by_scsi_id (unsigned int host, unsigned int channel,
+	unsigned int id, unsigned int lun)
+{
+	struct Scsi_Device_Template *scsi_template;
+	struct Scsi_Host *scsi_host;
+	Scsi_Device *scsi_device;
+
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host == 0) {
+		return (-ENODEV);
+	}
+
+	if (down_interruptible (&scsi_host->host_queue_sema)) {
+		return (-ERESTARTSYS);
+	}
+
+	for (scsi_device = scsi_host->host_queue; scsi_device;
+		scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	up (&scsi_host->host_queue_sema);
+
+	if (scsi_device == NULL) {
+		return (-ENOENT);
+	}
+
+	if (scsi_device->access_count) {
+		return (-EBUSY);
+	}
+
+	for (scsi_template = scsi_devicelist; scsi_template; scsi_template = scsi_template->next) {
+		if (scsi_template->detach) {
+			(*scsi_template->detach) (scsi_device);
+		}
+	}
+
+	if (scsi_device->attached == 0) {
+		/*
+		 * Nobody is using this device any more.
+		 * Free all of the command structures.
+		 */
+		if (scsi_host->hostt->revoke)
+			scsi_host->hostt->revoke(scsi_device);
+		devfs_unregister (scsi_device->de);
+		scsi_release_commandblocks(scsi_device);
+
+		/* Now we can remove the device structure */
+		if (scsi_device->next != NULL)
+			scsi_device->next->prev = scsi_device->prev;
+
+		if (scsi_device->prev != NULL)
+			scsi_device->prev->next = scsi_device->next;
+
+		if (scsi_host->host_queue == scsi_device) {
+			scsi_host->host_queue = scsi_device->next;
+		}
+		blk_cleanup_queue(&scsi_device->request_queue);
+		kfree((char *) scsi_device);
+	}
+
+	return (0);
+}
+
+int scsi_hotswap_insert_by_fc_wwn (unsigned int host, unsigned int channel,
+	unsigned long long wwn, unsigned int lun)
+{
+	struct Scsi_Host *scsi_host;
+	Scsi_Device *scsi_device;
+	int id;
+	int result;
+
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+
+	if (scsi_host == 0) {
+		return (-ENXIO);
+	}
+
+	result = scsi_host->hostt->get_scsi_info_from_wwn (0, wwn, &host,
+		&channel, &lun, &id);
+
+	if (result) {
+		return (result);
+	}
+
+	/*
+	 * Determine if device already attached
+	 */
+	if (down_interruptible (&scsi_host->host_queue_sema)) {
+		return (-ERESTARTSYS);
+	}
+
+	for (scsi_device = scsi_host->host_queue; scsi_device;
+		scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	up (&scsi_host->host_queue_sema);
+
+	/*
+	 * If scsi_device found in host queue, then device already attached
+	 */
+	if (scsi_device) {
+		return (-EEXIST);
+	}
+
+	scan_scsis (scsi_host, 1, channel, id, lun);
+	return (0);
+}
+
+int scsi_hotswap_remove_by_fc_wwn (unsigned int host, unsigned int channel,
+	unsigned long long wwn, unsigned int lun)
+{
+
+	struct Scsi_Device_Template *scsi_template;
+	Scsi_Device *scsi_device;
+	struct Scsi_Host *scsi_host;
+	int id;
+	int result;
+
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host == 0) {
+		return (-ENODEV);
+	}
+
+	result = scsi_host->hostt->get_scsi_info_from_wwn (1, wwn, &host,
+		&channel, &lun, &id);
+
+	if (result) {
+		return (result);
+	}
+
+	if (down_interruptible (&scsi_host->host_queue_sema)) {
+		return (-ERESTARTSYS);
+	}
+
+	for (scsi_device = scsi_host->host_queue; scsi_device;
+		scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	up (&scsi_host->host_queue_sema);
+
+	if (scsi_device == NULL) {
+		return (-ENOENT);
+	}
+
+	if (scsi_device->access_count) {
+		return (-EBUSY);
+	}
+
+	for (scsi_template = scsi_devicelist; scsi_template; scsi_template = scsi_template->next) {
+		if (scsi_template->detach) {
+			(*scsi_template->detach) (scsi_device);
+		}
+	}
+
+	if (scsi_device->attached == 0) {
+		/*
+		 * Nobody is using this device any more.
+		 * Free all of the command structures.
+		 */
+		if (scsi_host->hostt->revoke)
+			scsi_host->hostt->revoke(scsi_device);
+		devfs_unregister (scsi_device->de);
+		scsi_release_commandblocks(scsi_device);
+
+		/* Now we can remove the device structure */
+		if (scsi_device->next != NULL)
+			scsi_device->next->prev = scsi_device->prev;
+
+		if (scsi_device->prev != NULL)
+			scsi_device->prev->next = scsi_device->next;
+
+		if (scsi_host->host_queue == scsi_device) {
+			scsi_host->host_queue = scsi_device->next;
+		}
+		blk_cleanup_queue(&scsi_device->request_queue);
+		kfree((char *) scsi_device);
+	}
+	return (0);
+}
+
+int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long wwn)
+{
+	struct Scsi_Host *scsi_host;
+	Scsi_Device *scsi_device;
+	int host, lun, channel, id;
+	int result;
+
+	/*
+	 * Search scsi hostlist 
+	 */
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		/*
+		 * Skip unsupported drivers.  This is known because
+		 * get_scsi_info_from_wwn would be defined as 0
+		 */
+		if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+			continue;
+		}
+		
+		result = scsi_host->hostt->get_scsi_info_from_wwn (0, wwn,
+			&host, &channel, &lun, &id);
+		/*
+		 * WWN not found, try next adaptor
+		 */
+		if (result == -ENOENT) {
+			continue;
+		}
+
+		/*
+		 * If the currently scanned host doesn't match the WWN's host ID
+		 * try again searching with new host id
+		 */
+		if (scsi_host->host_no != host) {
+			continue;
+		}
+
+		/*
+		 * Verify we are not inserting an existing device
+		 */
+		if (down_interruptible (&scsi_host->host_queue_sema)) {
+			return (-ERESTARTSYS);
+		}
+
+		for (scsi_device = scsi_host->host_queue; scsi_device;
+			scsi_device = scsi_device->next) {
+			if ((scsi_device->channel == channel
+			     && scsi_device->id == id
+			     && scsi_device->lun == lun)) {
+				break;
+			}
+		}
+
+		up (&scsi_host->host_queue_sema);
+
+		/*
+		 * Insertion if no device found
+		 */
+		if (scsi_device == 0) {
+			scan_scsis(scsi_host, 1, 0, id, lun);
+			scan_scsis(scsi_host, 1, 1, id, lun);
+			break; /* exit scsi_host scan */
+		}
+	} /* scsi_host scan */
+
+	if (scsi_host == 0) {
+		return (-ENOENT);
+	}
+	return (0);
+}
+
+int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long wwn)
+{
+	struct Scsi_Device_Template *scsi_template;
+	Scsi_Device *scsi_device;
+	struct Scsi_Host *scsi_host;
+	int host, lun, channel, id;
+	int result;
+
+	for (scsi_host = scsi_host_get_next (NULL); scsi_host;
+		scsi_host = scsi_host_get_next (scsi_host)) {
+		/*
+		 * Skip unsupported drivers
+		 */
+		if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+			continue;
+		}
+
+		result = scsi_host->hostt->get_scsi_info_from_wwn (1, wwn,
+			&host, &channel, &lun, &id);
+
+		/*
+		 * Adaptor not found, try next adaptor 
+		 */
+		if (result) {
+			continue;
+		}
+
+		if (down_interruptible (&scsi_host->host_queue_sema)) {
+			return (-ERESTARTSYS);
+		}
+
+		for (scsi_device = scsi_host->host_queue; scsi_device;
+			scsi_device = scsi_device->next) {
+			if ((scsi_device->channel == channel
+				 && scsi_device->id == id
+				 && scsi_device->lun == lun)) {
+				break;
+			}
+		}
+
+		up (&scsi_host->host_queue_sema);
+
+		if (scsi_device->access_count) {
+			return (-EBUSY);
+		}
+
+		for (scsi_template = scsi_devicelist; scsi_template;
+			scsi_template = scsi_template->next) {
+			if (scsi_template->detach) {
+				(*scsi_template->detach) (scsi_device);
+			}
+		}
+
+		if (scsi_device->attached == 0) {
+			/*
+			 * Nobody is using this device any more.
+			 * Free all of the command structures.
+			 */
+			if (scsi_host->hostt->revoke)
+				scsi_host->hostt->revoke(scsi_device);
+			devfs_unregister (scsi_device->de);
+			scsi_release_commandblocks(scsi_device);
+
+			/* Now we can remove the device structure */
+			if (scsi_device->next != NULL)
+				scsi_device->next->prev = scsi_device->prev;
+	
+			if (scsi_device->prev != NULL)
+				scsi_device->prev->next = scsi_device->next;
+	
+			if (scsi_host->host_queue == scsi_device) {
+				scsi_host->host_queue = scsi_device->next;
+			}
+			blk_cleanup_queue(&scsi_device->request_queue);
+			kfree((char *) scsi_device);
+		}
+		break; /* Break from scan all hosts since we found match */
+	} /* scan all hosts */
+
+	if (scsi_host == 0) {
+		return (-ENOENT);
+	}
+	return (0);
+}
+
+/*
+ * DriverFS show and store calls
+ */
+static ssize_t scsi_hotswap_insert_by_scsi_id_show (char *buf, size_t count,
+	loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+	len = strlen (scsi_hotswap_insert_by_scsi_id_usage);
+	memcpy (buf, scsi_hotswap_insert_by_scsi_id_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_scsi_id_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	int host, channel, id, lun;
+	int result;
+
+	host = simple_strtoul (buf, &buf, 0);
+	channel = simple_strtoul (buf + 1, &buf, 0);
+	id = simple_strtoul (buf + 1, &buf, 0);
+	lun = simple_strtoul (buf + 1, &buf, 0);
+
+	result = scsi_hotswap_insert_by_scsi_id (host, channel, id, lun);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+static ssize_t scsi_hotswap_remove_by_scsi_id_show (char *buf, size_t count,
+	loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+
+	len = strlen (scsi_hotswap_remove_by_scsi_id_usage);
+	memcpy (buf, scsi_hotswap_remove_by_scsi_id_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_scsi_id_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	int host, channel, id, lun;
+	int result;
+
+	host = simple_strtoul (buf, &buf, 0);
+	channel = simple_strtoul (buf + 1, &buf, 0);
+	id = simple_strtoul (buf + 1, &buf, 0);
+	lun = simple_strtoul (buf + 1, &buf, 0);
+
+	result = scsi_hotswap_remove_by_scsi_id (host, channel, id, lun);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_show (char *buf, size_t count,
+	loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+	len = strlen (scsi_hotswap_insert_by_fc_wwn_usage);
+	memcpy (buf, scsi_hotswap_insert_by_fc_wwn_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	int host, channel, lun;
+	unsigned long long wwn;
+	int result;
+
+	host = simple_strtoul (buf, &buf, 0);
+	channel = simple_strtoul (buf + 1, &buf, 0);
+	wwn = simple_strtoull (buf + 1, &buf, 0);
+	lun = simple_strtoul (buf + 1, &buf, 0);
+
+	result = scsi_hotswap_insert_by_fc_wwn (host, channel, wwn, lun);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_show (char *buf, size_t count,
+	loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+	len = strlen (scsi_hotswap_remove_by_fc_wwn_usage);
+	memcpy (buf, scsi_hotswap_remove_by_fc_wwn_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	int host, channel, lun;
+	unsigned long long wwn;
+	int result;
+
+	host = simple_strtoul (buf, &buf, 0);
+	channel = simple_strtoul (buf + 1, &buf, 0);
+	wwn = simple_strtoull (buf + 1, &buf, 0);
+	lun = simple_strtoul (buf + 1, &buf, 0);
+
+	result = scsi_hotswap_remove_by_fc_wwn (host, channel, wwn, lun);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_show (char *buf,
+	size_t count, loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+	len = strlen (scsi_hotswap_insert_by_fc_wwn_wildcard_usage);
+	memcpy (buf, scsi_hotswap_insert_by_fc_wwn_wildcard_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_insert_by_fc_wwn_wildcard_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	unsigned long long wwn;
+	int result;
+
+	wwn = simple_strtoull (buf, &buf, 0);
+
+	result = scsi_hotswap_insert_by_fc_wwn_wildcard (wwn);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_show (char *buf,
+	size_t count, loff_t offset) 
+{
+	int len;
+
+	if (offset) {
+		return (0);
+	}
+	len = strlen (scsi_hotswap_remove_by_fc_wwn_wildcard_usage);
+	memcpy (buf, scsi_hotswap_remove_by_fc_wwn_wildcard_usage, len);
+
+	return (len);
+}
+
+static ssize_t scsi_hotswap_remove_by_fc_wwn_wildcard_store (char *buf,
+	size_t count, loff_t offset) 
+{
+	unsigned long long wwn;
+	int result;
+
+	wwn = simple_strtoull (buf, &buf, 0);
+
+	result = scsi_hotswap_remove_by_fc_wwn_wildcard (wwn);
+
+	if (result) {
+		return (result);
+	}
+	return (count);
+}
+
+	
+static int scsi_hotswap_attr_open (struct driver_dir_entry *dir)
+{
+	return (0);
+}
+
+static int scsi_hotswap_attr_close (struct driver_dir_entry *dir)
+{
+	return (0);
+}
+
+static ssize_t
+scsi_hotswap_attr_show (struct driver_dir_entry *dir, struct attribute *attr,
+		char *buf, size_t count, loff_t offset)
+{
+	struct scsi_hotswap_commands_attribute *scsi_hotswap_commands_attr =
+		container_of (attr, struct scsi_hotswap_commands_attribute, attr);
+	ssize_t ret = 0;
+
+	if (scsi_hotswap_commands_attr->show) {
+		ret = scsi_hotswap_commands_attr->show (buf, count, offset);
+	}
+
+	return (ret);
+}
+
+static ssize_t
+scsi_hotswap_attr_store(struct driver_dir_entry * dir, struct attribute *attr,
+		           const char *buf, size_t count, loff_t offset)
+{
+	struct scsi_hotswap_commands_attribute *scsi_hotswap_commands_attr =
+		container_of (attr, struct scsi_hotswap_commands_attribute, attr);
+	ssize_t ret = 0;
+
+	if (scsi_hotswap_commands_attr->store) {
+		ret = scsi_hotswap_commands_attr->store (buf, count, offset);
+	}
+
+	return (ret);
+}
+
+static int __init scsi_hotswap_init (void) {
+	int result = 0;
+	printk (KERN_INFO "Copyright (C) 2002 MontaVista Software - SCSI/FibreChannel hotswap driver\n");
+
+	/*
+	 * Create directory in bus/scsi/hotswap_commands with
+	 * permissions 0x700 and correct file operations structure
+	 */
+	result = driverfs_create_dir (&scsi_hotswap_commands_dir,
+		&scsi_driverfs_bus_type.dir);
+
+	/*
+	 * Create all files in driverfs
+	 */
+	driverfs_create_file (&scsi_hotswap_commands_attr_insert_by_scsi_id.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_remove_by_scsi_id.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_insert_by_fc_wwn.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_remove_by_fc_wwn.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_insert_by_fc_wwn_wildcard.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_remove_by_fc_wwn_wildcard.attr,
+			&scsi_hotswap_commands_dir);
+	driverfs_create_file (&scsi_hotswap_commands_attr_insert_by_scsi_id.attr,
+			&scsi_hotswap_commands_dir);
+
+	return (result);
+}
+
+static void __exit scsi_hotswap_exit (void) {
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "insert_by_scsi_id");
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "remove_by_scsi_id");
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "insert_by_fc_wwn");
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "remove_by_fc_wwn");
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "insert_by_fc_wwn_wildcard");
+	driverfs_remove_file (&scsi_hotswap_commands_dir, "remove_by_fc_wwn_wildcard");
+
+	driverfs_remove_dir (&scsi_hotswap_commands_dir);
+}
+
+module_init(scsi_hotswap_init);
+module_exit(scsi_hotswap_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_LICENSE("GPL");
Binary files linux-2.5.44-qla/drivers/scsi/qla2xxx/.qla2x00.c.swp and linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/.qla2x00.c.swp differ
Binary files linux-2.5.44-qla/drivers/scsi/qla2xxx/.qla2x00.h.swp and linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/.qla2x00.h.swp differ
diff -uNr linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c
--- linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c	Wed Oct 23 15:47:43 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c	Wed Oct 23 15:47:03 2002
@@ -244,6 +244,7 @@
 STATIC uint8_t  qla2x00_register_with_Linux(scsi_qla_host_t *ha, uint8_t maxchannels);
 STATIC int   qla2x00_done(scsi_qla_host_t *);
 //STATIC void qla2x00_select_queue_depth(struct Scsi_Host *, Scsi_Device *);
+int qla2x00_get_scsi_info_from_wwn (int mode, unsigned long long wwn, int *host, int *channel, int *lun, int *id);
 
 STATIC void
 qla2x00_timer(scsi_qla_host_t *);
@@ -2037,6 +2038,7 @@
 	host->can_queue = max_srbs;  /* default value:-MAX_SRBS(4096)  */
 	host->cmd_per_lun = 1;
 //	host->select_queue_depths = qla2x00_select_queue_depth;
+	host->hostt->get_scsi_info_from_wwn = qla2x00_get_scsi_info_from_wwn;
 
 	host->n_io_port = 0xFF;
 
@@ -3989,6 +3991,80 @@
 }
 #endif
 
+union wwnmap {
+	unsigned long long wwn;
+	unsigned char wwn_u8[8];
+};
+
+int qla2x00_get_scsi_info_from_wwn (int mode,
+	unsigned long long wwn,
+	int *host,
+	int *channel,
+	int *lun,
+	int *id) {
+
+scsi_qla_host_t *list;
+Scsi_Device *scsi_device;
+union wwnmap wwncompare;
+union wwnmap wwncompare2;
+int i, j, k;
+
+	/*
+	 * Retrieve big endian version of world wide name
+	 */
+	wwncompare2.wwn = wwn;
+	for (j = 0, k=7; j < 8; j++, k--) {
+		wwncompare.wwn_u8[j] = wwncompare2.wwn_u8[k];
+	}
+
+	/*
+	 * query all hosts searching for WWN
+	 */
+	for (list = qla2x00_hostlist; list; list = list->next) {
+		for (i = 0; i < MAX_FIBRE_DEVICES; i++) {
+			/*
+			 * Scan all devices in FibreChannel database
+			 * if WWN match found, return SCSI device information
+			 */
+			if (memcmp (wwncompare.wwn_u8, list->fc_db[i].wwn, 8) == 0) {
+				/*
+				 * If inserting, avoid scan for channel and lun information
+				 */
+				if (mode == 0) {
+					*channel = 0;
+					*lun = 0;
+					*host = list->host->host_no;
+					*id = i;
+					return (0);
+				}
+			
+
+				/*
+				 * WWN matches, find channel and lun information from scsi
+				 * device
+				 */
+				for (scsi_device = list->host->host_queue; scsi_device; scsi_device = scsi_device->next) {
+					if (scsi_device->id == i) {
+						*channel = scsi_device->channel;
+						*lun = scsi_device->lun;
+						break;
+					}
+				}
+				if (scsi_device == 0) {
+					return (-ENOENT);
+				}
+				/*
+				 * Device found, return all data
+				 */
+				*host = list->host->host_no;
+				*id = i;
+				return (0);
+			} /* memcmp */
+		} /* i < MAXFIBREDEVICES */
+	}
+	return (-ENOENT);
+}
+
 /**************************************************************************
 *   qla2x00_select_queue_depth
 *
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi.c linux-2.5.44-scsi-hotswap/drivers/scsi/scsi.c
--- linux-2.5.44-qla/drivers/scsi/scsi.c	Fri Oct 18 21:01:54 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi.c	Fri Oct 25 13:35:55 2002
@@ -413,6 +413,9 @@
 				 * allow us to more easily figure out whether we should
 				 * do anything here or not.
 				 */
+
+				down (&host->host_queue_sema);
+
 				for (SDpnt = host->host_queue;
 				     SDpnt;
 				     SDpnt = SDpnt->next) {
@@ -430,6 +433,9 @@
                                                 break;
                                         }
 				}
+
+				up (&host->host_queue_sema);
+
 				if (SDpnt) {
 					/*
 					 * Some other device in this cluster is busy.
@@ -1694,6 +1700,8 @@
 		len += size;
 		pos = begin + len;
 #endif
+		down (&HBA_ptr->host_queue_sema);
+
 		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
 			proc_print_scsidevice(scd, buffer, &size, len);
 			len += size;
@@ -1706,6 +1714,8 @@
 			if (pos > offset + length)
 				goto stop_output;
 		}
+
+		up (&HBA_ptr->host_queue_sema);
 	}
 
 stop_output:
@@ -1864,6 +1874,8 @@
 		if (!HBA_ptr)
 			goto out;
 
+		down (&HBA_ptr->host_queue_sema);
+
 		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
 			if ((scd->channel == channel
 			     && scd->id == id
@@ -1872,6 +1884,8 @@
 			}
 		}
 
+		up (&HBA_ptr->host_queue_sema);
+
 		err = -ENOSYS;
 		if (scd)
 			goto out;	/* We do not yet support unplugging */
@@ -1910,6 +1924,8 @@
 		if (!HBA_ptr)
 			goto out;
 
+		down (&HBA_ptr->host_queue_sema);
+
 		for (scd = HBA_ptr->host_queue; scd; scd = scd->next) {
 			if ((scd->channel == channel
 			     && scd->id == id
@@ -1918,6 +1934,8 @@
 			}
 		}
 
+		up (&HBA_ptr->host_queue_sema);
+
 		if (scd == NULL)
 			goto out;	/* there is no such device attached */
 
@@ -1951,9 +1969,14 @@
 			if (scd->prev != NULL)
 				scd->prev->next = scd->next;
 
+			down (&HBA_ptr->host_queue_sema);
+
 			if (HBA_ptr->host_queue == scd) {
 				HBA_ptr->host_queue = scd->next;
 			}
+
+			up (&HBA_ptr->host_queue_sema);
+
 			blk_cleanup_queue(&scd->request_queue);
 			if (scd->inquiry)
 				kfree(scd->inquiry);
@@ -1997,11 +2020,15 @@
 
 	for (shpnt = scsi_host_get_next(NULL); shpnt;
 	     shpnt = scsi_host_get_next(shpnt)) {
+		down (&shpnt->host_queue_sema);
+
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detect)
 				SDpnt->attached += (*tpnt->detect) (SDpnt);
 		}
+
+		up (&shpnt->host_queue_sema);
 	}
 
 	/*
@@ -2017,6 +2044,8 @@
 	 */
 	for (shpnt = scsi_host_get_next(NULL); shpnt;
 	     shpnt = scsi_host_get_next(shpnt)) {
+		down (&shpnt->host_queue_sema);
+
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->attach)
@@ -2032,6 +2061,8 @@
 					out_of_space = 1;
 			}
 		}
+
+		up (&shpnt->host_queue_sema);
 	}
 
 	/*
@@ -2068,6 +2099,8 @@
 
 	for (shpnt = scsi_host_get_next(NULL); shpnt;
 	     shpnt = scsi_host_get_next(shpnt)) {
+		spin_lock (&shpnt->host_queue_sema);
+
 		for (SDpnt = shpnt->host_queue; SDpnt;
 		     SDpnt = SDpnt->next) {
 			if (tpnt->detach)
@@ -2084,6 +2117,8 @@
 				scsi_release_commandblocks(SDpnt);
 			}
 		}
+
+		up (&shpnt->host_queue_sema);
 	}
 	/*
 	 * Extract the template from the linked list.
@@ -2154,6 +2189,8 @@
 	for (shpnt = scsi_host_get_next(NULL); shpnt;
 	     shpnt = scsi_host_get_next(shpnt)) {
 		printk(KERN_INFO "h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result\n");
+		down (&shpnt->host_queue_sema);
+
 		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
 				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
@@ -2185,6 +2222,8 @@
 				       SCpnt->result);
 			}
 		}
+
+		up (&shpnt->host_queue_sema);
 	}
 #endif	/* CONFIG_SCSI_LOGGING */ /* } */
 }
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_error.c linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_error.c
--- linux-2.5.44-qla/drivers/scsi/scsi_error.c	Fri Oct 18 21:01:07 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_error.c	Fri Oct 25 13:33:32 2002
@@ -202,6 +202,8 @@
 	int devices_failed = 0;
 
 
+	down (&shost->host_queue_sema);
+
 	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
 		for (scmd = sc_list; scmd; scmd = scmd->bh_next) {
 			if (scmd->device == sdev) {
@@ -227,6 +229,8 @@
 		}
 	}
 
+	up (&shost->host_queue_sema);
+
 	SCSI_LOG_ERROR_RECOVERY(2, printk("Total of %d commands on %d"
 					  " devices require eh work\n",
 				  total_failures, devices_failed));
@@ -247,6 +251,8 @@
 	Scsi_Device *sdev;
 	Scsi_Cmnd *scmd;
 
+	down (&shost->host_queue_sema);
+
 	for (found = 0, sdev = shost->host_queue; sdev; sdev = sdev->next) {
 		for (scmd = sdev->device_queue; scmd; scmd = scmd->next) {
 			if (scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)) {
@@ -283,6 +289,8 @@
 		}
 	}
 
+	up (&shost->host_queue_sema);
+
 	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(*sc_list, shost));
 
 	if (shost->host_failed != found)
@@ -962,6 +970,8 @@
 
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: Trying BDR\n", __FUNCTION__));
 
+	down (&shost->host_queue_sema);
+
 	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
 		for (scmd = sc_todo; scmd; scmd = scmd->bh_next)
 			if ((scmd->device == sdev) &&
@@ -985,6 +995,7 @@
 							scsi_eh_finish_cmd(scmd, shost);
 					}
 	}
+	up (&shost->host_queue_sema);
 
 	return shost->host_failed;
 }
@@ -1016,11 +1027,15 @@
 		/*
 		 * Mark all affected devices to expect a unit attention.
 		 */
+		down (&scmd->host->host_queue_sema);
+
 		for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
 			if (scmd->channel == sdev->channel) {
 				sdev->was_reset = 1;
 				sdev->expecting_cc_ua = 1;
 			}
+
+		up (&scmd->host->host_queue_sema);
 	}
 	return rtn;
 }
@@ -1052,11 +1067,13 @@
 		/*
 		 * Mark all affected devices to expect a unit attention.
 		 */
+		down (&scmd->host->host_queue_sema);
 		for (sdev = scmd->host->host_queue; sdev; sdev = sdev->next)
 			if (scmd->channel == sdev->channel) {
 				sdev->was_reset = 1;
 				sdev->expecting_cc_ua = 1;
 			}
+		up (&scmd->host->host_queue_sema);
 	}
 	return rtn;
 }
@@ -1474,7 +1491,9 @@
 	 * now that error recovery is done, we will need to ensure that these
 	 * requests are started.
 	 */
+	down (&shost->host_queue_sema);
 	spin_lock_irqsave(shost->host_lock, flags);
+
 	for (sdev = shost->host_queue; sdev; sdev = sdev->next) {
 		request_queue_t *q = &sdev->request_queue;
 
@@ -1487,7 +1506,9 @@
 
 		q->request_fn(q);
 	}
+
 	spin_unlock_irqrestore(shost->host_lock, flags);
+	up (&shost->host_queue_sema);
 }
 
 /**
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_lib.c linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_lib.c
--- linux-2.5.44-qla/drivers/scsi/scsi_lib.c	Fri Oct 18 21:01:53 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_lib.c	Fri Oct 25 13:30:17 2002
@@ -261,6 +261,8 @@
 	if (SDpnt->single_lun && blk_queue_empty(q) && SDpnt->device_busy ==0) {
 		request_queue_t *q;
 
+		down (&SHpnt->host_queue_sema);
+
 		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			if (((SHpnt->can_queue > 0)
 			     && (SHpnt->host_busy >= SHpnt->can_queue))
@@ -273,6 +275,8 @@
 			q = &SDpnt->request_queue;
 			q->request_fn(q);
 		}
+
+		up (&SHpnt->host_queue_sema);
 	}
 
 	/*
@@ -285,6 +289,7 @@
 	 */
 	all_clear = 1;
 	if (SHpnt->some_device_starved) {
+		down (&SHpnt->host_queue_sema);
 		for (SDpnt = SHpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			request_queue_t *q;
 			if ((SHpnt->can_queue > 0 && (SHpnt->host_busy >= SHpnt->can_queue))
@@ -299,6 +304,7 @@
 			q->request_fn(q);
 			all_clear = 0;
 		}
+		up (&SHpnt->host_queue_sema);
 		if (SDpnt == NULL && all_clear) {
 			SHpnt->some_device_starved = 0;
 		}
@@ -1038,8 +1044,13 @@
 
 	SHpnt->host_self_blocked = FALSE;
 	/* Now that we are unblocked, try to start the queues. */
+
+	down (&SHpnt->host_queue_sema);
+
 	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
 		scsi_queue_next_request(&SDloop->request_queue, NULL);
+
+	up (&SHpnt->host_queue_sema);
 }
 
 /*
@@ -1066,12 +1077,17 @@
 void scsi_report_bus_reset(struct Scsi_Host * SHpnt, int channel)
 {
 	Scsi_Device *SDloop;
+
+	down (&SHpnt->host_queue_sema);
+
 	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next) {
 		if (channel == SDloop->channel) {
 			SDloop->was_reset = 1;
 			SDloop->expecting_cc_ua = 1;
 		}
 	}
+
+	up (&SHpnt->host_queue_sema);
 }
 
 /*
diff -uNr linux-2.5.44-qla/drivers/scsi/scsi_scan.c linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_scan.c
--- linux-2.5.44-qla/drivers/scsi/scsi_scan.c	Fri Oct 18 21:02:28 2002
+++ linux-2.5.44-scsi-hotswap/drivers/scsi/scsi_scan.c	Fri Oct 25 14:50:46 2002
@@ -530,6 +530,8 @@
 		/*
 		 * Add it to the end of the shost->host_queue list.
 		 */
+		down (&shost->host_queue_sema);
+
 		if (shost->host_queue != NULL) {
 			sdev->prev = shost->host_queue;
 			while (sdev->prev->next != NULL)
@@ -538,6 +540,8 @@
 		} else
 			shost->host_queue = sdev;
 
+		up (&shost->host_queue_sema);
+
 	}
 	return (sdev);
 }
@@ -554,8 +558,12 @@
 {
 	if (sdev->prev != NULL)
 		sdev->prev->next = sdev->next;
-	else
+	else {
+		down (&sdev->host->host_queue_sema);
 		sdev->host->host_queue = sdev->next;
+		up (&sdev->host->host_queue_sema);
+	}
+
 	if (sdev->next != NULL)
 		sdev->next->prev = sdev->prev;
 
diff -uNr linux-2.5.44-qla/include/linux/scsi_hotswap.h linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h
--- linux-2.5.44-qla/include/linux/scsi_hotswap.h	Wed Dec 31 17:00:00 1969
+++ linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h	Fri Oct 25 11:36:04 2002
@@ -0,0 +1,84 @@
+/*
+ * scsi_hotswap.h
+ *
+ * SCSI/FibreChannel Hotswap interface to kernel features
+ * 
+ * Author: MontaVista Software, Inc.
+ *         Steven Dake (sdake@mvista.com)
+ *         source@mvista.com
+ *
+ * Copyright (C) 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Library General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU Library General Public
+ *  License along with this program; if not, write to the Free
+ *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __SCSI_HOTSWAP_H
+#define __SCSI_HOTSWAP_H
+
+/*
+ * Software Interface
+ */
+
+/*
+ * Find a device by host, channel, lun and scsi id and insert it into the system
+ */
+extern int scsi_hotswap_insert_by_scsi_id (unsigned int host,
+	unsigned int channel,
+	unsigned int id,
+	unsigned int lun);
+
+/*
+ * Find a device by host, channel, lun and scsi id and remove it from the system
+ */
+extern int scsi_hotswap_remove_by_scsi_id (unsigned int host,
+	unsigned int channel,
+	unsigned int id,
+	unsigned int lun);
+
+/*
+ * Find a device by host, channel, lun and wwn and insert it into the system
+ */
+extern int scsi_hotswap_insert_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned long long wwn,
+	unsigned int lun);
+
+/*
+ * Find a device by host, channel, lun and wwn and remove it from the system
+ */
+extern int scsi_hotswap_remove_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned long long wwn,
+	unsigned int lun);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, insert it into the system
+ */
+extern int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long wwn);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, remove it from the system
+ */
+extern int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long wwn);
+
+#endif /* __SCSI_HOTSWAP_H */

--------------050805010200080600070800--

