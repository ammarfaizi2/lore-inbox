Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbSJKBPp>; Thu, 10 Oct 2002 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJKBPp>; Thu, 10 Oct 2002 21:15:45 -0400
Received: from themargofoundation.org ([65.206.132.246]:40718 "HELO
	themargofoundation.org") by vger.kernel.org with SMTP
	id <S262245AbSJKBPd>; Thu, 10 Oct 2002 21:15:33 -0400
From: "Steven Dake" <scd@broked.org>
To: <linux-kernel@vger.kernel.org>
Cc: <linux1394-devel@lists.sourceforge.net>
Subject: [PATCH] [RFC] Advanced TCA Disk Hotswap support in Linux Kernel [core 1/2]
Date: Thu, 10 Oct 2002 18:19:49 -0700
Message-ID: <004401c270c4$4bbe2a50$0200000a@persist>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml,

I am developing the Linux kernel support required to support Advanced
TCA
(PICMG 3.0) architecture.  Advanced TCA is a technology where boards
exist
in a chassis and can either be processor nodes or storage nodes.  All
blades in the chassis are connected by FibreChannel and Ethernet.  The
blades can be hot added or hot removed while the Linux processor nodes
are
active, meaning that the SCSI subsystem must add devices on insertion
requests and remove devices on ejection requests.

The following is the first public patch that I am posting that adds
support
for SCSI and FibreChannel hotswap via a programmatic kernel interface,
as 
well as userland access via ioctls.

The second patch is a FibreChannel driver that is modified to support
SCSI
hotswap.

This mechanism is far superior to /proc/scsi/scsi because it:
1) provides true FibreChannel hotswap support (at this point qlogic FC
HBAs)
2) is programmatic such that errors can be reported from kernel to user
   without looking is /var/log/.
3) Provides superior response times vs opening a file and writing to
proc.
4) Easier to control from kernel and user via C APIs vs using
open/write.


Regards
-steve

diff -uNr linux-2.4.19/Documentation/Configure.help
linux-2.4.19-scsi-hotswap/Documentation/Configure.help
--- linux-2.4.19/Documentation/Configure.help	Fri Aug  2 17:39:42 2002
+++ linux-2.4.19-scsi-hotswap/Documentation/Configure.help	Thu Oct
10 17:28:28 2002
@@ -6795,6 +6795,17 @@
   module if your root file system (the one containing the directory /)
   is located on a SCSI device.
 
+SCSI hotswap support
+CONFIG_SCSIFCHOTSWAP
+  If you want to support the ability to include the hotswap 
+FibreChannel
+  and SCSI driver, please say yes here.  Hotswap can then be executed
+  through an ioctl interface which will provide better error reporting
+  then the previous method /proc/scsi/scsi.  Further, this interface
+  supports insertion and removal by WWN for FibreChannel drivers which
+  support this feature.
+
+  The only FibreChannel driver that supports this feature is Qlogic V6.
+
 SCSI disk support
 CONFIG_BLK_DEV_SD
   If you want to use a SCSI hard disk or the SCSI or parallel port diff
-uNr linux-2.4.19/drivers/scsi/Config.in
linux-2.4.19-scsi-hotswap/drivers/scsi/Config.in
--- linux-2.4.19/drivers/scsi/Config.in	Fri Aug  2 17:39:44 2002
+++ linux-2.4.19-scsi-hotswap/drivers/scsi/Config.in	Thu Oct 10
17:28:28 2002
@@ -1,5 +1,6 @@
 comment 'SCSI support type (disk, tape, CD-ROM)'
 
+dep_bool '  SCSI hotswap support' CONFIG_SCSIFCHOTSWAP $CONFIG_SCSI
 dep_tristate '  SCSI disk support' CONFIG_BLK_DEV_SD $CONFIG_SCSI
 
 if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
diff -uNr linux-2.4.19/drivers/scsi/Makefile
linux-2.4.19-scsi-hotswap/drivers/scsi/Makefile
--- linux-2.4.19/drivers/scsi/Makefile	Fri Aug  2 17:39:44 2002
+++ linux-2.4.19-scsi-hotswap/drivers/scsi/Makefile	Thu Oct 10
17:28:28 2002
@@ -130,6 +130,7 @@
 subdir-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi
 obj-$(CONFIG_ARCH_ACORN)	+= ../acorn/scsi/acorn-scsi.o
 
+obj-$(CONFIG_SCSIFCHOTSWAP)	+= hotswap.o
 obj-$(CONFIG_CHR_DEV_ST)	+= st.o
 obj-$(CONFIG_CHR_DEV_OSST)	+= osst.o
 obj-$(CONFIG_BLK_DEV_SD)	+= sd_mod.o
diff -uNr linux-2.4.19/drivers/scsi/hosts.h
linux-2.4.19-scsi-hotswap/drivers/scsi/hosts.h
--- linux-2.4.19/drivers/scsi/hosts.h	Mon Feb 25 12:38:04 2002
+++ linux-2.4.19-scsi-hotswap/drivers/scsi/hosts.h	Thu Oct 10
17:28:28 2002
@@ -214,6 +214,14 @@
      */
     int (* bios_param)(Disk *, kdev_t, int []);
 
+#ifdef CONFIG_SCSIFCHOTSWAP
+	/*
+	 * Used to determine the id to send the inquiry command to
during
+	 * hot additions
+	 */
+	int (*get_scsi_info_from_wwn)(int mode, unsigned long long wwn,
int 
+*host, int *channel, int *lun, int *id);
+
+#endif
 
     /*
      * Used to set the queue depth for a specific device.
diff -uNr linux-2.4.19/drivers/scsi/hotswap.c
linux-2.4.19-scsi-hotswap/drivers/scsi/hotswap.c
--- linux-2.4.19/drivers/scsi/hotswap.c	Wed Dec 31 17:00:00 1969
+++ linux-2.4.19-scsi-hotswap/drivers/scsi/hotswap.c	Thu Oct 10
17:28:28 2002
@@ -0,0 +1,684 @@
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
+ * Derived from linux/scsi/scsi.c hotswap code
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Library General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
DAMAGE.
+ *
+ *  You should have received a copy of the GNU Library General Public
+ *  License along with this program; if not, write to the Free
+ *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+#include <linux/blk.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp_lock.h>
+#include <linux/completion.h>
+#define __KERNEL_SYSCALLS__
+
+#include <linux/unistd.h>
+#include <linux/spinlock.h>
+
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
+
+#include "scsi.h"
+#include "hosts.h"
+#include "constants.h"
+#include <linux/scsi_hotswap.h>
+
+
+/*
+ * Prototypes
+ */
+static int scsi_hotswap_ioctl (struct inode *inode,
+	struct file *file,
+	unsigned int cmd,
+	unsigned long parameters);
+int ioctl_scsi_hotswap_insert_by_scsi_id (unsigned long parameters); 
+int ioctl_scsi_hotswap_remove_by_scsi_id (unsigned long parameters); 
+int ioctl_scsi_hotswap_insert_by_fc_wwn (unsigned long parameters); int

+ioctl_scsi_hotswap_remove_by_fc_wwn (unsigned long parameters); int 
+ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long 
+parameters); int ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned

+long parameters);
+
+extern devfs_handle_t scsi_devfs_handle;
+static devfs_handle_t scsi_hotswap_devfs_handle;
+
+struct file_operations scsi_hotswap_fileoperations = {
+	owner:	THIS_MODULE,
+	ioctl:	scsi_hotswap_ioctl
+};
+
+/*
+struct miscsi_deviceevice scsi_hotswap_miscsi_deviceevice = {
+	223,
+	"hotswap",
+	&scsi_hotswap_fileoperations
+};
+*/
+
+/*
+ * Implementation
+ */
+static int scsi_hotswap_ioctl (struct inode *inode,
+	struct file *file,
+	unsigned int cmd,
+	unsigned long parameters) {
+
+int result = -EINVAL;
+
+	switch (cmd) {
+		case IOCTL_SCSI_HOTSWAP_INSERT_BY_SCSI_ID:
+		result = ioctl_scsi_hotswap_insert_by_scsi_id
(parameters);
+		break;
+
+		case IOCTL_SCSI_HOTSWAP_REMOVE_BY_SCSI_ID:
+		result = ioctl_scsi_hotswap_remove_by_scsi_id
(parameters);
+		break;
+
+		case IOCTL_SCSI_HOTSWAP_INSERT_BY_FC_WWN:
+		result = ioctl_scsi_hotswap_insert_by_fc_wwn
(parameters);
+		break;
+
+		case IOCTL_SCSI_HOTSWAP_REMOVE_BY_FC_WWN:
+		result = ioctl_scsi_hotswap_remove_by_fc_wwn
(parameters);
+		break;
+
+		case IOCTL_SCSI_HOTSWAP_INSERT_BY_FC_WWN_WILDCARD:
+		result = ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard
(parameters);
+		break;
+
+		case IOCTL_SCSI_HOTSWAP_REMOVE_BY_FC_WWN_WILDCARD:
+		result = ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard
(parameters);
+		break;
+	}
+	return (result);
+}
+
+int scsi_hotswap_insert_by_scsi_id (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned int id) {
+
+struct Scsi_Host *scsi_host;
+Scsi_Device *scsi_device;
+
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host) {
+		return (-ENXIO);
+	}
+
+	/*
+	 * Determine if device already attached
+	 */
+	for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	/*
+	 * If scsi_device found in host queue, then device already
attached
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
+int scsi_hotswap_remove_by_scsi_id (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned int id) {
+
+struct Scsi_Device_Template *scsi_template;
+struct Scsi_Host *scsi_host;
+Scsi_Device *scsi_device;
+
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host == 0) {
+		return (-ENODEV);
+	}
+
+	for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	if (scsi_device == NULL) {
+		return (-ENOENT);
+	}
+
+	if (scsi_device->access_count) {
+		return (-EBUSY);
+	}
+
+	scsi_template = scsi_devicelist;
+	while (scsi_template != NULL) {
+		if (scsi_template->detach)
+			(*scsi_template->detach) (scsi_device);
+		scsi_template = scsi_template->next;
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
+int scsi_hotswap_insert_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned long long wwn) {
+
+struct Scsi_Host *scsi_host;
+Scsi_Device *scsi_device;
+int id;
+int result;
+
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+
+	if (!scsi_host) {
+		return (-ENXIO);
+	}
+
+	result = scsi_host->hostt->get_scsi_info_from_wwn (
+		0,
+		wwn,
+		&host,
+		&channel,
+		&lun,
+		&id);
+	/*
+	 * Nonzero result indicates error
+	 */
+	if (result) {
+		return (result);
+	}
+
+	/*
+	 * Determine if device already attached
+	 */
+	for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	/*
+	 * If scsi_device found in host queue, then device already
attached
+	 */
+	if (scsi_device) {
+		return (-EEXIST);
+	}
+
+	scan_scsis(scsi_host, 1, channel, id, lun);
+	return (0);
+}
+
+int scsi_hotswap_remove_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned long long wwn) {
+
+struct Scsi_Device_Template *scsi_template;
+Scsi_Device *scsi_device;
+struct Scsi_Host *scsi_host;
+int id;
+int result;
+
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		if (scsi_host->host_no == host) {
+			break;
+		}
+	}
+	if (scsi_host == 0) {
+		return (-ENODEV);
+	}
+
+	result = scsi_host->hostt->get_scsi_info_from_wwn (
+		1,
+		wwn,
+		&host,
+		&channel,
+		&lun,
+		&id);
+
+	/*
+	 * Nonzero indicates error
+	 */
+	if (result) {
+		return (result);
+	}
+
+	for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+		if ((scsi_device->channel == channel
+		     && scsi_device->id == id
+		     && scsi_device->lun == lun)) {
+			break;
+		}
+	}
+
+	if (scsi_device == NULL) {
+		return (-ENOENT);
+	}
+
+	if (scsi_device->access_count) {
+		return (-EBUSY);
+	}
+
+	scsi_template = scsi_devicelist;
+	while (scsi_template != NULL) {
+		if (scsi_template->detach)
+			(*scsi_template->detach) (scsi_device);
+		scsi_template = scsi_template->next;
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
+int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long wwn) { 
+struct Scsi_Host *scsi_host; Scsi_Device *scsi_device;
+int host, lun, channel, id;
+int result;
+
+	/*
+	 * Search scsi hostlist 
+	 */
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		/*
+		 * Skip unsupported drivers
+		 */
+		if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+			continue;
+		}
+		
+		result = scsi_host->hostt->get_scsi_info_from_wwn (
+			0,
+			wwn,
+			&host,
+			&channel,
+			&lun,
+			&id);
+		/*
+		 * WWN not found, try next adaptor
+		 */
+		if (result == -ENOENT) {
+			continue;
+		}
+
+
+		/*
+		 * If the currently scanned host doesn't match the WWN's
host ID
+		 * try again searching with new host id
+		 */
+		if (scsi_host->host_no != host) {
+			continue;
+		}
+
+			
+		/*
+		 * Verify we are not inserting an existing device
+		 */
+		for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+			if ((scsi_device->channel == channel
+			     && scsi_device->id == id
+			     && scsi_device->lun == lun)) {
+				break;
+			}
+		}
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
+int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long wwn) { 
+struct Scsi_Device_Template *scsi_template; Scsi_Device *scsi_device;
+struct Scsi_Host *scsi_host;
+int host, lun, channel, id;
+int result;
+
+	for (scsi_host = scsi_hostlist; scsi_host; scsi_host =
scsi_host->next) {
+		/*
+		 * Skip unsupported drivers
+		 */
+		if (scsi_host->hostt->get_scsi_info_from_wwn == 0) {
+			continue;
+		}
+
+		result = scsi_host->hostt->get_scsi_info_from_wwn (
+			1,
+			wwn,
+			&host,
+			&channel,
+			&lun,
+			&id);
+
+		/*
+		 * Adaptor not found, try next adaptor 
+		 */
+		if (result) {
+			continue;
+		}
+
+		for (scsi_device = scsi_host->host_queue; scsi_device;
scsi_device = scsi_device->next) {
+			if ((scsi_device->channel == channel
+				 && scsi_device->id == id
+				 && scsi_device->lun == lun)) {
+				break;
+			}
+		}
+
+		if (scsi_device->access_count) {
+			return (-EBUSY);
+		}
+
+		scsi_template = scsi_devicelist;
+		while (scsi_template != NULL) {
+			if (scsi_template->detach)
+				(*scsi_template->detach) (scsi_device);
+			scsi_template = scsi_template->next;
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
+				scsi_device->next->prev =
scsi_device->prev;
+	
+			if (scsi_device->prev != NULL)
+				scsi_device->prev->next =
scsi_device->next;
+	
+			if (scsi_host->host_queue == scsi_device) {
+				scsi_host->host_queue =
scsi_device->next;
+			}
+			blk_cleanup_queue(&scsi_device->request_queue);
+			kfree((char *) scsi_device);
+		}
+		break; /* Break from scan all hosts since we found match
*/
+	} /* scan all hosts */
+
+	if (scsi_host == 0) {
+		return (-ENOENT);
+	}
+	return (0);
+}
+
+
+int ioctl_scsi_hotswap_insert_by_scsi_id (unsigned long parameters) { 
+struct s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters 
+ioctl_scsi_hotswap_insert_by_scsi_id_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_insert_by_scsi_id_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters))) {
+		return (-EFAULT);
+	}
+	ioctl_scsi_hotswap_insert_by_scsi_id_parameters.result =
+		scsi_hotswap_insert_by_scsi_id (
+
ioctl_scsi_hotswap_insert_by_scsi_id_parameters.host,
+
ioctl_scsi_hotswap_insert_by_scsi_id_parameters.channel,
+
ioctl_scsi_hotswap_insert_by_scsi_id_parameters.lun,
+
ioctl_scsi_hotswap_insert_by_scsi_id_parameters.id);
+
+	if (copy_to_user ((int *)parameters,
+		&ioctl_scsi_hotswap_insert_by_scsi_id_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+
+
+int ioctl_scsi_hotswap_remove_by_scsi_id (unsigned long parameters) { 
+struct s_ioctl_scsi_hotswap_remove_by_scsi_id_parameters 
+ioctl_scsi_hotswap_remove_by_scsi_id_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_remove_by_scsi_id_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_scsi_id_parameters))) {
+		return (-EFAULT);
+	}
+	ioctl_scsi_hotswap_remove_by_scsi_id_parameters.result =
+		scsi_hotswap_remove_by_scsi_id (
+
ioctl_scsi_hotswap_remove_by_scsi_id_parameters.host,
+
ioctl_scsi_hotswap_remove_by_scsi_id_parameters.channel,
+
ioctl_scsi_hotswap_remove_by_scsi_id_parameters.lun,
+
ioctl_scsi_hotswap_remove_by_scsi_id_parameters.id);
+
+	if (copy_to_user ((int *)parameters,
+		&ioctl_scsi_hotswap_remove_by_scsi_id_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_scsi_id_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+
+int ioctl_scsi_hotswap_insert_by_fc_wwn (unsigned long parameters) { 
+struct s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters 
+ioctl_scsi_hotswap_insert_by_fc_wwn_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_insert_by_fc_wwn_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_fc_wwn_parameters))) {
+		return (-EFAULT);
+	}
+	ioctl_scsi_hotswap_insert_by_fc_wwn_parameters.result =
+		scsi_hotswap_insert_by_fc_wwn (
+
ioctl_scsi_hotswap_insert_by_fc_wwn_parameters.host,
+
ioctl_scsi_hotswap_insert_by_fc_wwn_parameters.channel,
+
ioctl_scsi_hotswap_insert_by_fc_wwn_parameters.lun,
+
ioctl_scsi_hotswap_insert_by_fc_wwn_parameters.id);
+
+	if (copy_to_user ((int *)parameters,
+		&ioctl_scsi_hotswap_insert_by_fc_wwn_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_fc_wwn_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+
+int ioctl_scsi_hotswap_remove_by_fc_wwn (unsigned long parameters) { 
+struct s_ioctl_scsi_hotswap_remove_by_fc_wwn_parameters 
+ioctl_scsi_hotswap_remove_by_fc_wwn_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_remove_by_fc_wwn_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_fc_wwn_parameters))) {
+		return (-EFAULT);
+	}
+	ioctl_scsi_hotswap_remove_by_fc_wwn_parameters.result =
+		scsi_hotswap_remove_by_fc_wwn (
+
ioctl_scsi_hotswap_remove_by_fc_wwn_parameters.host,
+
ioctl_scsi_hotswap_remove_by_fc_wwn_parameters.channel,
+
ioctl_scsi_hotswap_remove_by_fc_wwn_parameters.lun,
+
ioctl_scsi_hotswap_remove_by_fc_wwn_parameters.wwn);
+
+	if (copy_to_user ((int *)parameters,
+		&ioctl_scsi_hotswap_remove_by_fc_wwn_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_fc_wwn_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+
+int ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long 
+parameters) { struct 
+s_ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters 
+ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters))) {
+		return (-EFAULT);
+	}
+	ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters.result =
+		scsi_hotswap_insert_by_fc_wwn_wildcard (
+
ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters.wwn);
+
+	if (copy_to_user ((int *)parameters,
+
&ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+
+int ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long 
+parameters) { struct 
+s_ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters 
+ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters;
+
+	if (copy_from_user
((int*)&ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters,
+ 		(void *)parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters))) {
+		return (-EFAULT);
+	}
+
+	ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters.result =
+		scsi_hotswap_remove_by_fc_wwn_wildcard (
+
ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters.wwn);
+
+	if (copy_to_user ((int *)parameters,
+
&ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters,
+		sizeof (struct
s_ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters))) {
+		return (-EFAULT);
+	}
+	return (0);
+}
+int scsi_hotswap_init (void) {
+	printk (KERN_INFO "Copyright (C) 2002 MontaVista Software -
SCSI/FC hotswap driver\n");
+	scsi_hotswap_devfs_handle = devfs_register(scsi_devfs_handle,
+		"hotswap",
+		DEVFS_FL_NONE,
+		10,
+		223,
+		S_IFCHR | S_IRUSR | S_IWUSR,
+		&scsi_hotswap_fileoperations,
+		NULL);
+
+	if (scsi_hotswap_devfs_handle == 0) {
+		return (-ENXIO);
+	}
+
+	return (0);
+}
+
+void scsi_hotswap_exit (void) {
+	devfs_unregister (scsi_hotswap_devfs_handle);
+}
diff -uNr linux-2.4.19/include/linux/scsi_hotswap.h
linux-2.4.19-scsi-hotswap/include/linux/scsi_hotswap.h
--- linux-2.4.19/include/linux/scsi_hotswap.h	Wed Dec 31 17:00:00 1969
+++ linux-2.4.19-scsi-hotswap/include/linux/scsi_hotswap.h	Thu Oct
10 17:26:37 2002
@@ -0,0 +1,145 @@
+/*
+ * scsi_hotswap.h
+ *
+ * SCSI/FibreChannel Hotswap userland interface to kernel features
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
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
DAMAGE.
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
+ * Find a device by host, channel, lun and scsi id and insert it into 
+the system  */ extern int scsi_hotswap_insert_by_scsi_id (unsigned int 
+host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned int id);
+
+/*
+ * Find a device by host, channel, lun and scsi id and remove it from 
+the system  */ extern int scsi_hotswap_remove_by_scsi_id (unsigned int 
+host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned int id);
+
+/*
+ * Find a device by host, channel, lun and wwn and insert it into the 
+system  */ extern int scsi_hotswap_insert_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned long long wwn);
+
+/*
+ * Find a device by host, channel, lun and wwn and remove it from the 
+system  */ extern int scsi_hotswap_remove_by_fc_wwn (unsigned int host,
+	unsigned int channel,
+	unsigned int lun,
+	unsigned long long wwn);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, insert it into the system
+ */
+extern int scsi_hotswap_insert_by_fc_wwn_wildcard (unsigned long long 
+wwn);
+
+/*
+ * Find a device by WWN, searching all adaptor hosts and channels.
+ * If found, remove it from the system
+ */
+extern int scsi_hotswap_remove_by_fc_wwn_wildcard (unsigned long long 
+wwn);
+
+/*
+ * Initialize the hotswap library
+ */
+extern int scsi_hotswap_init(void);
+
+/*
+ * Ioctl Interface
+ */
+struct s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters {
+	unsigned int host;
+	unsigned int channel;
+	unsigned int lun;
+	unsigned int id;
+	int result;
+};
+struct s_ioctl_scsi_hotswap_remove_by_scsi_id_parameters {
+	unsigned int host;
+	unsigned int channel;
+	unsigned int lun;
+	unsigned int id;
+	int result;
+};
+struct s_ioctl_scsi_hotswap_insert_by_fc_wwn_parameters {
+	unsigned int host;
+	unsigned int channel;
+	unsigned int lun;
+	unsigned long long wwn;
+	int result;
+};
+struct s_ioctl_scsi_hotswap_remove_by_fc_wwn_parameters {
+	unsigned int host;
+	unsigned int channel;
+	unsigned int lun;
+	unsigned long long wwn;
+	int result;
+};
+
+struct s_ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters {
+	unsigned long long wwn;
+	int result;
+};
+
+struct s_ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters {
+	unsigned long long wwn;
+	int result;
+};
+
+#define SCSI_HOTSWAP_IOC_MAGIC 'b'
+
+#define IOCTL_SCSI_HOTSWAP_INSERT_BY_SCSI_ID _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 0, struct 
+s_ioctl_scsi_hotswap_insert_by_scsi_id_parameters)
+
+#define IOCTL_SCSI_HOTSWAP_REMOVE_BY_SCSI_ID _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 1, struct 
+s_ioctl_scsi_hotswap_remove_by_scsi_id_parameters)
+
+#define IOCTL_SCSI_HOTSWAP_INSERT_BY_FC_WWN _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 2, struct 
+s_ioctl_scsi_hotswap_insert_by_fc_wwn_parameters)
+
+#define IOCTL_SCSI_HOTSWAP_REMOVE_BY_FC_WWN _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 3, struct 
+s_ioctl_scsi_hotswap_remove_by_fc_wwn_parameters)
+
+#define IOCTL_SCSI_HOTSWAP_INSERT_BY_FC_WWN_WILDCARD _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 4, struct 
+s_ioctl_scsi_hotswap_insert_by_fc_wwn_wildcard_parameters)
+
+#define IOCTL_SCSI_HOTSWAP_REMOVE_BY_FC_WWN_WILDCARD _IOWR 
+(SCSI_HOTSWAP_IOC_MAGIC, 5, struct 
+s_ioctl_scsi_hotswap_remove_by_fc_wwn_wildcard_parameters)
+
+#endif /* __SCSI_HOTSWAP_H */


