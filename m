Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJJUMK>; Thu, 10 Oct 2002 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263646AbSJJULv>; Thu, 10 Oct 2002 16:11:51 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:37792 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262212AbSJJUD0>; Thu, 10 Oct 2002 16:03:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (1/9) evms.c
Date: Thu, 10 Oct 2002 14:35:03 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014350303.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 1 of the EVMS core driver.

This file provides all of the block device requirements, the module
init/exit routines, and the ioctl interface to EVMS.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/drivers/evms/core/evms.c linux-2.5.41-evms/drivers/evms/core/evms.c
--- linux-2.5.41/drivers/evms/core/evms.c Sun Jul 17 18:46:18 1994
+++ linux-2.5.41-evms/drivers/evms/core/evms.c	Thu Oct 10 13:50:01 2002
@@ -0,0 +1,2692 @@
+/*
+ *   Copyright (c) International Business Machines  Corp., 2000 - 2002
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+/*
+ * EVMS core driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blk.h>
+#include <linux/blkpg.h>
+#include <linux/bio.h>
+#include <linux/hdreg.h>
+#include <linux/mempool.h>
+#include <linux/reboot.h>
+#include <asm/uaccess.h>
+#include <asm/checksum.h>
+
+#include <linux/evms.h>
+#include <linux/evms_ioctl.h>
+#include "evms_core.h"
+
+/**
+ * Global data
+ **/
+/*
+ * evms_info_level is the in-memory syslog level
+ */
+int evms_info_level = EVMS_INFO_LEVEL;
+EXPORT_SYMBOL(evms_info_level);
+struct proc_dir_entry *evms_proc_dir = NULL;
+
+/*
+ * the rediscover semaphore
+ */
+static struct semaphore red_sem;
+
+/*
+ * list of all registered (loaded) plugins
+ */
+struct list_head plugin_head;
+spinlock_t plugin_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * list of all disk devices EVMS is aware of
+ */
+struct list_head evms_device_list;
+EXPORT_SYMBOL(evms_device_list);
+
+/*
+ * list of all bottom level storage objects with EVMS metadata
+ */
+struct list_head evms_fbottom_list;
+
+/*
+ * list of all registered notification events
+ */
+struct list_head evms_notify_list;
+
+struct list_head evms_logical_volumes;
+int evms_volumes = 0;
+
+/* 
+ * internal POOL variables 
+ */
+mempool_t *evms_io_notify_pool;
+static kmem_cache_t *evms_io_notify_slab;
+
+/* 
+ * Handle for the devfs directory entry 
+ */
+devfs_handle_t evms_dir_devfs_handle;
+devfs_handle_t evms_blk_devfs_handle;
+
+/**
+ * SYSCTL - EVMS folder definitions/variables
+ **/
+static struct ctl_table_header *evms_table_header;
+static int evms_info_level_min = EVMS_INFO_CRITICAL;
+static int evms_info_level_max = EVMS_INFO_EVERYTHING;
+
+static struct ctl_table evms_table[] = {
+	{DEV_EVMS_INFO_LEVEL, "evms_info_level",
+	 &evms_info_level, sizeof (int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec,
+	 NULL, &evms_info_level_min, &evms_info_level_max},
+	{0}
+};
+
+static struct ctl_table evms_dir_table[] = {
+	{DEV_EVMS, "evms", NULL, 0, 0555, evms_table},
+	{0}
+};
+
+static struct ctl_table dev_dir_table[] = {
+	{CTL_DEV, "dev", NULL, 0, 0555, evms_dir_table},
+	{0}
+};
+
+/**
+ * find_next_volume - locates first or next logical volume
+ * @lv:		current logical volume
+ *
+ * returns the next logical volume or NULL
+ **/
+struct evms_logical_volume *
+find_next_volume(struct evms_logical_volume *lv)
+{
+	struct list_head *list_member =
+		(lv) ? &lv->volumes : &evms_logical_volumes;
+	for (lv = list_entry(list_member->next, typeof(*lv), volumes),
+		     prefetch(lv->volumes.next);
+	     &lv->volumes != &evms_logical_volumes; 
+	     lv = list_entry(lv->volumes.next, typeof(*lv), volumes),
+		     prefetch(lv->volumes.next)) {
+		return lv;
+	}
+	return NULL;
+}
+
+/**
+ * find_next_volume_safe - locates first or next logical volume (safe for removes)
+ * @next_lv:	ptr to next logical volume
+ *
+ * returns the next logical volume or NULL
+ **/
+struct evms_logical_volume *
+find_next_volume_safe(struct evms_logical_volume **next_lv)
+{
+	struct evms_logical_volume *lv =
+		(*next_lv) ? *next_lv :
+                list_entry(evms_logical_volumes.next, typeof(*lv), volumes);
+	*next_lv = list_entry(lv->volumes.next, typeof(*lv), volumes);
+	if (&lv->volumes != &evms_logical_volumes) {
+		return lv;
+	}
+	return NULL;
+}
+
+/**
+ * lookup_volume - finds a logical volume by minor number
+ * @minor:	minor number of logical volume to be found
+ *
+ * returns the logical volume of the specified minor or NULL.
+ **/
+struct evms_logical_volume *
+lookup_volume(int minor)
+{
+	struct evms_logical_volume *lv;
+	list_for_each_entry(lv, &evms_logical_volumes, volumes) {
+		if (lv->minor == minor) {
+			return lv;
+		}
+	}
+	return NULL;
+}
+
+/**
+ * remove_logical_volume - removes a logical volume from our list
+ * @lv:		logical volume to be removed.
+ *
+ * removes an existing logical volume from our list.
+ **/
+static void
+remove_logical_volume(struct evms_logical_volume *lv)
+{
+	BUG_ON(list_empty(&lv->volumes));
+	list_del_init(&lv->volumes);
+}
+
+/**********************************************************/
+/* START -- Proc FS Support functions                     */
+/**********************************************************/
+
+/**
+ * evms_info_read_proc - /proc/evms/info support function
+ * @page:	procfs required field
+ * @start:	procfs required field
+ * @off:	procfs required field
+ * @count:	procfs required field
+ * @eof:	procfs required field
+ * @data:	procfs required field
+ *
+ * cat /proc/evms/info function that provides info about EVMS.
+ **/
+static int
+evms_info_read_proc(char *page, char **start, off_t off,
+		    int count, int *eof, void *data)
+{
+	int sz = 0;
+	char *info_level_text = NULL;
+
+	PROCPRINT("Enterprise Volume Management System: Info\n");
+	switch (evms_info_level) {
+	case EVMS_INFO_CRITICAL:
+		info_level_text = "critical";
+		break;
+	case EVMS_INFO_SERIOUS:
+		info_level_text = "serious";
+		break;
+	case EVMS_INFO_ERROR:
+		info_level_text = "error";
+		break;
+	case EVMS_INFO_WARNING:
+		info_level_text = "warning";
+		break;
+	case EVMS_INFO_DEFAULT:
+		info_level_text = "default";
+		break;
+	case EVMS_INFO_DETAILS:
+		info_level_text = "details";
+		break;
+	case EVMS_INFO_DEBUG:
+		info_level_text = "debug";
+		break;
+	case EVMS_INFO_EXTRA:
+		info_level_text = "extra";
+		break;
+	case EVMS_INFO_ENTRY_EXIT:
+		info_level_text = "entry exit";
+		break;
+	case EVMS_INFO_EVERYTHING:
+		info_level_text = "everything";
+		break;
+	default:
+		info_level_text = "unknown";
+		break;
+	}
+	PROCPRINT("EVMS info level: %d (%s).\n",
+		  evms_info_level, info_level_text);
+
+	PROCPRINT("EVMS kernel version: %d.%d.%d\n",
+		  EVMS_MAJOR_VERSION,
+		  EVMS_MINOR_VERSION, EVMS_PATCHLEVEL_VERSION);
+
+	PROCPRINT("EVMS IOCTL interface version: %d.%d.%d\n",
+		  EVMS_IOCTL_INTERFACE_MAJOR,
+		  EVMS_IOCTL_INTERFACE_MINOR, EVMS_IOCTL_INTERFACE_PATCHLEVEL);
+
+	PROCPRINT("EVMS Common Services version: %d.%d.%d\n",
+		  EVMS_COMMON_SERVICES_MAJOR,
+		  EVMS_COMMON_SERVICES_MINOR, EVMS_COMMON_SERVICES_PATCHLEVEL);
+
+	*eof = 1;
+
+out:
+	*start = page + off;
+	sz -= off;
+	if (sz < 0)
+		sz = 0;
+	return sz > count ? count : sz;
+}
+
+/**
+ * evms_plugins_read_proc - /proc/evms/plugins support function
+ * @page:	procfs required field
+ * @start:	procfs required field
+ * @off:	procfs required field
+ * @count:	procfs required field
+ * @eof:	procfs required field
+ * @data:	procfs required field
+ *
+ * cat /proc/evms/plugins that lists the currently loaded plugin modules in EVMS.
+ **/
+static int
+evms_plugins_read_proc(char *page,
+		       char **start, off_t off, int count, int *eof, void *data)
+{
+	int sz = 0;
+	struct evms_plugin_header *plugin;
+
+	PROCPRINT("Enterprise Volume Management System: Plugins\n");
+	/*             0    1    1    2    2    3    3    4    4    5    5    6    6    7 */
+	/*         1   5    0    5    0    5    0    5    0    5    0    5    0    5    0 */
+	PROCPRINT(" ---------Plugin----------\n");
+	PROCPRINT(" ----id----        version\n\n");
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		PROCPRINT(" %x.%x.%x\t   %d.%d.%d\n",
+			  GetPluginOEM(plugin->id),
+			  GetPluginType(plugin->id),
+			  GetPluginID(plugin->id),
+			  plugin->version.major,
+			  plugin->version.minor,
+			  plugin->version.patchlevel);
+	}
+	spin_unlock(&plugin_lock);
+
+out:
+	*start = page + off;
+	sz -= off;
+	if (sz < 0)
+		sz = 0;
+	return sz > count ? count : sz;
+}
+
+/**
+ * evms_volumes_read_proc - /proc/evms/volumes support function
+ * @page:	procfs required field
+ * @start:	procfs required field
+ * @off:	procfs required field
+ * @count:	procfs required field
+ * @eof:	procfs required field
+ * @data:	procfs required field
+ *
+ * cat /proc/evms/volumes that lists the currently exported volumes in EVMS.
+ **/
+static int
+evms_volumes_read_proc(char *page,
+		       char **start, off_t off, int count, int *eof, void *data)
+{
+	struct evms_logical_volume *lv = NULL;
+	int sz = 0;
+
+	PROCPRINT("Enterprise Volume Management System: Volumes\n");
+	PROCPRINT("major   minor          #blocks type   flags name\n\n");
+	while ((lv = find_next_volume(lv))) {
+		if (!lv->node) {
+			continue;
+		}
+		PROCPRINT("%5d %7d %16Ld %s %s %s %s%s\n",
+			  EVMS_MAJOR, lv->minor,
+			  (long long)lv->node->total_vsectors >> 1,
+			  (lv->flags & EVMS_VOLUME_FLAG) ? 
+			  "evms  " : "compat",
+			  (lv->flags & EVMS_VOLUME_READ_ONLY) ? 
+			  "ro" : "rw",
+			  (lv->flags & EVMS_VOLUME_PARTIAL) ? 
+			  "p " : "  ",
+			  EVMS_DIR_NAME "/", lv->name);
+	}
+out:
+	*start = page + off;
+	sz -= off;
+	if (sz < 0)
+		sz = 0;
+	return sz > count ? count : sz;
+}
+
+/**********************************************************/
+/* END -- Proc FS Support functions                       */
+/**********************************************************/
+
+/**********************************************************/
+/* START -- FOPS functions definitions                    */
+/**********************************************************/
+
+/**
+ * is_busy - determines if a block_devices is currently in use
+ * @dev:	device to check
+ *
+ * determines if a block_device is in use or not
+ *
+ * returns: 0 = device is not in use
+ *	    -EBUSY if device is in use
+ *	    -ENOMEM if unable to get a bdev
+ **/
+int
+is_busy(kdev_t dev)
+{
+	struct block_device *bdev;
+
+	bdev = bdget(kdev_t_to_nr(dev));
+	if (!bdev)
+		return -ENOMEM;
+	if (bd_claim(bdev, is_busy))
+		return -EBUSY;
+	bd_release(bdev);
+	return 0;
+}
+
+/************************************************/
+/* START -- IOCTL commands -- EVMS specific     */
+/************************************************/
+
+/**
+ * evms_ioctl_cmd_get_ioctl_version
+ * @arg:	evms version packet
+ *
+ * retrieves the evms ioctl interface version
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_ioctl_version(void *arg)
+{
+	struct evms_version ver;
+
+	ver.major = EVMS_IOCTL_INTERFACE_MAJOR;
+	ver.minor = EVMS_IOCTL_INTERFACE_MINOR;
+	ver.patchlevel = EVMS_IOCTL_INTERFACE_PATCHLEVEL;
+
+	/* copy info to userspace */
+	if (copy_to_user(arg, &ver, sizeof (ver)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_get_version
+ * @arg:	evms version packet
+ *
+ * retrieves the evms kernel version
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_version(void *arg)
+{
+	struct evms_version ver;
+
+	ver.major = EVMS_MAJOR_VERSION;
+	ver.minor = EVMS_MINOR_VERSION;
+	ver.patchlevel = EVMS_PATCHLEVEL_VERSION;
+
+	/* copy info to userspace */
+	if (copy_to_user(arg, &ver, sizeof (ver)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_get_info_level
+ * @arg:	int value
+ *
+ * retrieves the evms info (syslog logging) level
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_info_level(void *arg)
+{
+	/* copy info to userspace */
+	if (copy_to_user(arg, &evms_info_level, sizeof (evms_info_level)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_set_info_level
+ * @arg:	int value
+ *
+ * sets the evms info (syslog logging) level
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_set_info_level(void *arg)
+{
+	int temp;
+
+	/* copy info from userspace */
+	if (copy_from_user(&temp, arg, sizeof (temp)))
+		return -EFAULT;
+	evms_info_level = temp;
+
+	return 0;
+}
+
+/**
+ * evms_quiesce_volume
+ * @volume:	volume to be quiesced
+ * @command:	0 = unquiesce, 1 = quiesce
+ * @minor:	minor of volume to be quiesce
+ * @lock_vfs:	0 = no lock, 1 = lock
+ *
+ * this function performs the actual quiesce operation on
+ * a volume in kernel memory.
+ *
+ * when quiescing, all new I/Os to a volume are stopped,
+ * causing the calling thread to block. this thread then
+ * waits until all I/Os in progress are completed, before
+ * return control to the caller.
+ *
+ * when unquiescing, all new I/Os are allowed to proceed
+ * unencumbered, and all threads waiting (blocked) on this
+ * volume, are woken up and allowed to proceed.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ */
+int
+evms_quiesce_volume(struct evms_logical_volume *volume,
+		    int command, int minor, int lock_vfs)
+{
+	int rc;
+
+	LOG_DEBUG("%squiescing %s.\n",
+		  ((command) ? "" : "un"), volume->name);
+
+	if (lock_vfs) {
+		/* VFS function call to sync and lock the filesystem */
+		fsync_dev_lockfs(mk_kdev(EVMS_MAJOR, minor));
+		volume->vfs_quiesced = 1;
+	}
+
+	volume->quiesced = command;
+
+	/* Command specified was "quiesce". */
+	if (command) {
+		/* After setting the volume to a quiesced state, there could
+		 * still be I/O requests in progress. Wait for the request
+		 * count to go to zero before continuing.
+		 */
+		wait_event(volume->quiesce_wait_queue,
+			   (atomic_read(&volume->requests_in_progress) == 0));
+	}
+
+	/* Send this command down the stack so lower */
+	/* layers can know about this                */
+	rc = QUIESCE(volume->node, command);
+	
+	/* Command specified was "unquiesce". */
+	if (!command) {
+		/* "wakeup" any I/O requests waiting on this volume */
+		wake_up(&volume->request_wait_queue);
+		if (volume->vfs_quiesced) {
+			/* VFS function call to unlock the filesystem */
+			unlockfs(mk_kdev(EVMS_MAJOR, minor));
+			volume->vfs_quiesced = 0;
+		}
+	}
+	if (rc) {
+		LOG_ERROR("error(%d) %squiescing %s.\n",
+			  rc, ((command) ? "" : "un"), volume->name);
+	}
+	return rc;
+}
+
+/**
+ * evms_delete_volume
+ * @volume:	logical volume being deleted
+ * @command:	0 = "soft", 1 = "hard" delete request
+ * @minor:	minor of volume to be deleted
+ * @associative_minor: minor of volume associated to the @minor volume
+ *
+ * this function performs the actual delete operation on
+ * a volume to purge it from kernel memory. all structures
+ * and memory consumed by this volume will be free as well
+ * as clearing or unregistering any system services.
+ *
+ * returns: 0 = on success
+ *          -EBUSY if volume is mounted
+ *	    otherwise error code
+ **/
+static int
+evms_delete_volume(struct evms_logical_volume *lv,
+		   int command, int minor, int associative_minor)
+{
+	int rc = 0;
+	struct block_device *bdev = NULL;
+
+	/* if this is a "permament" delete */
+	/* check to make sure volume is not in use */
+	if (command) {
+		bdev = bdget(kdev_t_to_nr(mk_kdev(EVMS_MAJOR, lv->minor)));
+		if (!bdev) {
+			if (command == 1) {
+				return -ENOMEM;
+			}
+			command = 0;
+		} 
+	}
+	if (command) {
+		if (bd_claim(bdev, evms_delete_volume)) {
+			if (command == 1) {
+				return -EBUSY;
+			}
+			command = 0;
+		}
+	}
+       	if (command) {
+		/* invalidate the device since it is not coming back
+		 * this is required incase we are re-using the minor number
+		 */
+		invalidate_device(mk_kdev(EVMS_MAJOR, minor), 1);
+	}
+	/* invoke the delete ioctl at the top of the feature stack */
+	LOG_DETAILS("deleting '%s'.\n", lv->name);
+	rc = DELETE(lv->node);
+	if (rc) {
+		LOG_ERROR("error(%d) %s deleting %s.\n",
+			  rc, ((command) ? "hard" : "soft"), lv->name);
+		return rc;
+	}
+	/* the volume has been deleted, do any clean up work
+	 * required.
+	 */
+	devfs_unregister(lv->gd->de);
+	set_device_ro(mk_kdev(EVMS_MAJOR, minor), 0);
+	del_gendisk(lv->gd);
+	put_disk(lv->gd);
+	lv->gd = NULL;
+	lv->node = NULL;
+	evms_volumes--;
+	if (command) {
+		/* if "permanent" delete, free the name
+		 * and NULL the name field.
+		 */
+		blk_cleanup_queue(&lv->request_queue);
+		remove_logical_volume(lv);
+		kfree(lv->name);
+		bd_release(bdev);
+		kfree(lv);
+	} else {
+		/* if "soft" delete, leave the name so
+		 * we can use it to reassign the same
+		 * minor to this volume after a
+		 * rediscovery.
+		 */
+		lv->flags = EVMS_VOLUME_SOFT_DELETED;
+	}
+	return 0;
+}
+
+/**
+ * evms_user_delete_volume
+ * @lvt:	logical volume
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @dv:		delete volume ioctl packet
+ *
+ * this function, depending on the parameters, performs
+ * a "soft" or a "hard" delete. for a "soft" delete, a
+ * quiesce & delete request is queued up, to be executed
+ * at the beginning of the next rediscovery. for a
+ * "hard" delete, the target volume is quiesced and then
+ * deleted. if there is any errors attempting to delete
+ * the target, then the target is unquiesced. if an
+ * associative volume is specified it is quiesced before
+ * the target volume is quiesced, and is unquiesced
+ * after the attempt to delete the target volume.
+ **/
+static int
+evms_user_delete_volume(struct evms_logical_volume *lvt,
+			struct inode *inode, struct file *file, 
+			struct evms_delete_vol_pkt *dv)
+{
+	int rc, qa = 0;
+	struct evms_logical_volume *lva = NULL;
+
+	if (!dv->command) {
+		/* "soft delete" requested */
+		lvt->flags |= (EVMS_REQUESTED_QUIESCE | EVMS_REQUESTED_DELETE);
+		if (dv->do_vfs) {
+			lvt->flags |= EVMS_REQUESTED_VFS_QUIESCE;
+		}
+		return 0;
+	}
+	/* "hard delete" requested */
+	if (dv->associative_minor) {
+		/* associative volume specified
+		 *
+		 * quiesce it
+		 */
+		lva = lookup_volume(dv->associative_minor);
+		/* quiesce associative volume */
+		rc = evms_quiesce_volume(lva, 1,
+					 dv->associative_minor,
+					 0);
+		if (!rc) {
+			qa = 1;
+		} else {
+			goto error;
+		}
+	}
+	/* quiesce target volume */
+	rc = evms_quiesce_volume(lvt, 1, dv->minor, 0);
+	if (rc) {
+		goto error;
+	}
+	/* delete the target volume */
+	rc = evms_delete_volume(lvt, dv->command, dv->minor,
+				dv->associative_minor);
+	if (rc) {
+		/* got an error undeleting...
+		 *
+		 * unquiesce the target
+		 */
+		rc = evms_quiesce_volume(lvt, 0, dv->minor, 0);
+	}
+      error:
+	if (dv->associative_minor) {
+		/* associative volume specified
+		 *
+		 * unquiesce it
+		 */
+		if (qa) {
+			/* only unquiesce associative
+			 * if we successfully quiesced
+			 * it previously.
+			 */
+			rc = evms_quiesce_volume(lva, 0,
+						 dv->associative_minor,
+						 0);
+		}
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_delete_volume
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @arg:	delete volume ioctl packet
+ *
+ * this function will copy user data to/from the kernel, and
+ * validates user parameters. after validation, control
+ * is passed to worker routine evms_user_delete_volume.
+ *
+ * returns: 0 on success
+ *	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_delete_volume(struct inode *inode, struct file *file, ulong arg)
+{
+	int rc = 0;
+	struct evms_delete_vol_pkt tmp, *user_parms;
+	struct evms_logical_volume *lv = NULL;
+
+	user_parms = (struct evms_delete_vol_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		rc = -EFAULT;
+		goto exit;
+	}
+	/* check to make sure associative minor is in use */
+	if (tmp.associative_minor) {
+		lv = lookup_volume(tmp.associative_minor);
+		if (lv == NULL || lv->node == NULL) {
+			rc = -ENXIO;
+			goto exit;
+		}
+	}
+	/* check to make sure target minor is in use */
+	lv = lookup_volume(tmp.minor);
+	if (lv == NULL || lv->node == NULL) {
+		rc = -ENXIO;
+	} else {
+		rc = evms_user_delete_volume(lv, inode, file, &tmp);
+	}
+      exit:
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_full_rediscover_prep
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ *
+ * this function helps to prevent problems when evms is
+ * configured with the base built in statically and some
+ * plugins built as modules.
+ *
+ * in these cases, when the initial discovery is done,
+ * only the statically built modules are available for
+ * volume construction. as a result, some volumes that
+ * require the plugins built as modules (which haven't
+ * been loaded) to be fully reconstructed, may come up
+ * as compatibility volumes or partial volumes.
+ *
+ * when parts of evms are built as modules, the
+ * evms_rediscovery utility is used, to perform a secondary
+ * rediscover, after all the plugins built as modules
+ * have been loaded, to construct all the volumes
+ * requiring these plugins.
+ *
+ * however since some of the volumes, requiring the plugins
+ * built as modules, may have been already exported as
+ * compatibility or partial volumes, we need to purge these
+ * volumes from kernel's memory, so they can be rediscovered
+ * and claimed by the appropriate plugins, and reconstructed
+ * into the correct volumes.
+ *
+ * this function purges all compatibility volumes that are
+ * not in use (unmounted) and all partial volumes, prior to
+ * doing the secondary rediscover, thus allowing volumes to
+ * be rediscovered correctly.
+ *
+ * NOTE: again, this is only required in cases when a
+ * combination of plugins are built statically and as
+ * modules.
+ **/
+static void
+evms_full_rediscover_prep(struct inode *inode, struct file *file)
+{
+	struct evms_logical_volume *lv, *next_lv = NULL;
+
+	LOG_DETAILS("%s: started.\n", __FUNCTION__);
+	/* check for acceptable volumes to be deleted */
+	while ((lv = find_next_volume_safe(&next_lv))) {
+		struct evms_delete_vol_pkt dv;
+		int volume_mounted, doit;
+		kdev_t devp;
+
+		if (!lv->node)
+			continue;
+		devp = mk_kdev(EVMS_MAJOR, lv->minor);
+		volume_mounted = (is_busy(devp)) ? 1 : 0;
+		/* only proceed on volumes that are:
+		 *   partial volumes
+		 *      OR
+		 *   unmounted compatibility volumes
+		 */
+		doit = 0;
+		if (lv->flags & EVMS_VOLUME_PARTIAL) {
+			/* do all partial volumes
+			 */
+			doit = 1;
+		} else if (!(lv->flags & EVMS_VOLUME_FLAG)) {
+			/* check all compatibility volumes
+			 */
+			if (!volume_mounted) {
+				/* only do unmounted volumes
+				 */
+				doit = 1;
+			}
+		}
+		if (doit == 0) {
+			continue;
+		}
+		/* delete the volume from memory.
+		 * do a 'soft' delete if volume
+		 * is mounted, and 'hard' delete
+		 * if it is not.
+		 *
+		 * NOTE: the delete operation will
+		 * clear the bits in the flags field.
+		 */
+		dv.command = (volume_mounted) ? EVMS_SOFT_DELETE : 
+			EVMS_HARD_DELETE;
+		dv.minor = lv->minor;
+		dv.do_vfs = dv.associative_minor = 0;
+		evms_user_delete_volume(lv, inode, file, &dv);
+	}
+	LOG_DETAILS("%s: completed.\n", __FUNCTION__);
+}
+
+/**
+ * evms_ioctl_cmd_rediscover_volumes
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @cmd:	vfs ioctl parameter, the ioctl command
+ * @arg:	vfs ioctl parameter, the rediscover ioctl packet
+ *
+ * performs a rediscovery (probing) off all specified devices and exports any
+ * newly found volumes.
+ **/
+static int
+evms_ioctl_cmd_rediscover_volumes(struct inode *inode,
+				  struct file *file,
+				  unsigned int cmd, ulong arg)
+{
+	int rc;
+	struct evms_rediscover_pkt tmp, *user_parms;
+	u64 *array_ptr = NULL;
+	ulong array_size = 0;
+	struct evms_logical_volume *lv = NULL, *next_lv;
+
+	/* grab the rediscover semaphore */
+	down(&red_sem);
+
+	rc = tmp.drive_count = 0;
+	user_parms = (struct evms_rediscover_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		rc = -EFAULT;
+		goto exit;
+	}
+
+	if (tmp.drive_count == REDISCOVER_ALL_DEVICES) {
+		evms_full_rediscover_prep(inode, file);
+	}
+	/* quiesce all queued volumes */
+	while ((lv = find_next_volume(lv))) {
+		if (!lv->node) {
+			continue;
+		}
+		if (!(lv->flags & EVMS_REQUESTED_QUIESCE)) {
+			continue;
+		}
+		rc = evms_quiesce_volume(lv, 1, lv->minor,
+			(lv->flags & EVMS_REQUESTED_VFS_QUIESCE) ?
+			1 : 0);
+	}
+	/* "soft" delete all queued volumes */
+	next_lv = NULL;
+	while ((lv = find_next_volume_safe(&next_lv))) {
+		if (!lv->node) {
+			continue;
+		}
+		if (!(lv->flags & EVMS_REQUESTED_DELETE)) {
+			continue;
+		}
+		rc = evms_delete_volume(lv, EVMS_SOFT_DELETE,
+					lv->minor, 0);
+	}
+
+	if (tmp.drive_count && (tmp.drive_count != REDISCOVER_ALL_DEVICES)) {
+		/* create space for userspace drive array */
+		array_size = sizeof (*tmp.drive_array) * tmp.drive_count;
+		array_ptr = tmp.drive_array;
+		tmp.drive_array = kmalloc(array_size, GFP_KERNEL);
+		if (!tmp.drive_array) {
+			rc = -ENOMEM;
+			goto exit;
+		}
+		/* copy rediscover drive array to kernel space */
+		if (copy_from_user(tmp.drive_array, array_ptr, array_size)) {
+			rc = -EFAULT;
+			goto exit;
+		}
+	}
+	/* perform the rediscovery operation */
+	rc = evms_discover_volumes(&tmp);
+
+	/* clean up after operation */
+	if (tmp.drive_count && (tmp.drive_count != REDISCOVER_ALL_DEVICES))
+		kfree(tmp.drive_array);
+      exit:
+	/* set return code and copy info to userspace */
+	tmp.status = rc;
+	if (copy_to_user(&user_parms->status, &tmp.status, sizeof (tmp.status))) {
+		rc = -EFAULT;
+	}
+
+	/* release the rediscover semaphore */
+	up(&red_sem);
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_get_logical_disk
+ * @arg:	vfs ioctl parameter, the disk handle ioctl packet
+ *
+ * retrieves the 1st or next device (disk) handle to the caller
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static struct list_head *user_disk_ptr;
+static int
+evms_ioctl_cmd_get_logical_disk(void *arg)
+{
+	struct evms_user_disk_pkt tmp, *user_parms;
+
+	user_parms = (struct evms_user_disk_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user
+	    (&tmp.command, &user_parms->command, sizeof (tmp.command))) {
+		return -EFAULT;
+	}
+	if (tmp.command == EVMS_FIRST_DISK)
+		user_disk_ptr = evms_device_list.next;
+	else			/* tmp.command == EVMS_NEXT_DISK */
+		user_disk_ptr = user_disk_ptr->next;
+
+	if (user_disk_ptr == &evms_device_list)
+		tmp.status = EVMS_DISK_INVALID;
+	else {
+		struct evms_logical_node *node =
+		    list_entry(user_disk_ptr, struct evms_logical_node, device);
+		tmp.status = EVMS_DISK_VALID;
+		tmp.disk_handle = NODE_TO_DEV_HANDLE(node);
+	}
+	/* copy info to userspace */
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_get_logical_disk_info
+ * @arg:	vfs ioctl parameter, the disk info ioctl packet
+ *
+ * fills in info about the device specified by the disk handle
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_logical_disk_info(void *arg)
+{
+	int rc;
+	struct evms_user_disk_info_pkt tmp, *user_parms;
+	struct evms_logical_node *disk_node, *mem_node;
+
+	user_parms = (struct evms_user_disk_info_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user
+	    (&tmp.disk_handle, &user_parms->disk_handle,
+	     sizeof (tmp.disk_handle))) {
+		return -EFAULT;
+	}
+	/* check handle for validity */
+	rc = -EINVAL;
+	disk_node = DEV_HANDLE_TO_NODE(tmp.disk_handle);
+	list_for_each_entry(mem_node, &evms_device_list, device) {
+		if (mem_node == disk_node) {
+			rc = 0;
+			break;
+		}
+	}
+	if (rc) {
+		goto exit;
+	}
+	/* populate kernel copy of user's structure with appropriate info */
+	tmp.flags = disk_node->flags;
+	strcpy(tmp.disk_name, EVMS_DIR_NAME "/");
+	strcat(tmp.disk_name, disk_node->name);
+	rc = evms_cs_kernel_ioctl(disk_node, EVMS_UPDATE_DEVICE_INFO, 
+				  (ulong) NULL);
+	if (rc) {
+		goto exit;
+	}
+	tmp.total_sectors = disk_node->total_vsectors;
+	tmp.hardsect_size = disk_node->hardsector_size;
+	tmp.block_size = disk_node->block_size;
+	rc = GET_GEO(disk_node, &tmp.geo_cylinders, &tmp.geo_heads,
+		     &tmp.geo_sectors, NULL);
+      exit:
+	/* set return code and copy info to userspace */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_sector_io - performs sector based IO to a disk device
+ * @arg:	vfs ioctl parameter, the sector io ioctl packet
+ *
+ * performs 512 byte sector based io on a specified device. internally this
+ * routine will do I/O upto 64KB at a time, breaking larger requests up as
+ * needed.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+#define MAX_IO_SIZE 128
+static int
+evms_ioctl_cmd_sector_io(void *arg)
+{
+	int rc;
+	struct evms_sector_io_pkt tmp, *user_parms;
+	struct evms_logical_node *disk_node, *mem_node;
+	u8 *io_buffer = NULL, *user_buffer_ptr;
+	u64 io_sector_offset, io_remaining, io_bytes, io_size = MAX_IO_SIZE;
+
+	user_parms = (struct evms_sector_io_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	/* check handle for validity */
+	rc = -EINVAL;
+	disk_node = DEV_HANDLE_TO_NODE(tmp.disk_handle);
+	list_for_each_entry(mem_node, &evms_device_list, device) {
+		if (mem_node == disk_node) {
+			rc = 0;
+			break;
+		}
+	}
+	if (rc) {
+		goto exit;
+	}
+	/* allocate a io buffer upto 64Kbytes in size */
+	if (tmp.sector_count < MAX_IO_SIZE) {
+		io_size = tmp.sector_count;
+	}
+	/* allocate buffer large enough to hold a single sector */
+	io_buffer = kmalloc(io_size << EVMS_VSECTOR_SIZE_SHIFT, GFP_KERNEL);
+	if (!io_buffer) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+	/* perform io with specified disk */
+	io_remaining = tmp.sector_count;
+	io_sector_offset = 0;
+	user_buffer_ptr = tmp.buffer_address;
+	while (io_remaining) {
+		/* compute the io_size for this pass */
+		io_size = (io_remaining >= MAX_IO_SIZE) ?
+		    MAX_IO_SIZE : io_remaining;
+		io_bytes = io_size << EVMS_VSECTOR_SIZE_SHIFT;
+		/* for writes, copy a sector from user to kernel */
+		if (tmp.io_flag == EVMS_SECTOR_IO_WRITE) {
+			/* copy sector from user data buffer */
+			if (copy_from_user
+			    (io_buffer, user_buffer_ptr, io_bytes)) {
+				rc = -EFAULT;
+				goto exit;
+			}
+		}
+		/* perform IO */
+		rc = INIT_IO(disk_node, tmp.io_flag,
+			     io_sector_offset + tmp.starting_sector,
+			     io_size, io_buffer);
+		if (rc) {
+			goto exit;
+		}
+		if (tmp.io_flag != EVMS_SECTOR_IO_WRITE) {
+			/* copy sector to user data buffer */
+			if (copy_to_user(user_buffer_ptr, io_buffer, io_bytes)) {
+				rc = -EFAULT;
+				goto exit;
+			}
+		}
+		user_buffer_ptr += io_bytes;
+		tmp.buffer_address += io_bytes;
+		io_sector_offset += io_size;
+		io_remaining -= io_size;
+	}
+exit:
+	/* if the sector_buffer was allocated, free it */
+	if (io_buffer)
+		kfree(io_buffer);
+
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp)))
+		rc = -EFAULT;
+
+	return rc;
+}
+
+#undef MAX_IO_SIZE
+
+/**
+ * evms_ioctl_cmd_get_minor - retrieves the volume minor device number
+ * @arg:	vfs ioctl parameter, the get minor ioctl packet
+ *
+ * retrieves the minor device number for the 1st or the next volume exported by EVMS.
+ *
+ * NOTE: this routine will look for, and purge any volumes previous mounted as
+ * corrupt that are no longer mounted.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int user_minor;
+static int
+evms_ioctl_cmd_get_minor(void *arg)
+{
+	struct evms_user_minor_pkt tmp, *user_parms;
+	struct evms_logical_volume *lv;
+
+	user_parms = (struct evms_user_minor_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user
+	    (&tmp.command, &user_parms->command, sizeof (tmp.command))) {
+		return -EFAULT;
+	}
+	if (tmp.command == EVMS_FIRST_VOLUME) {
+		user_minor = 0;
+		lv = NULL;
+	} else {	/* tmp.command == EVMS_NEXT_VOLUME */
+		lv = lookup_volume(user_minor);
+	}
+
+	tmp.status = EVMS_VOLUME_INVALID;
+	while ((lv = find_next_volume(lv))) {
+		user_minor = lv->minor;
+		/* see if any corrupt volumes have been
+		 * unmounted. If so, clean up the entry
+		 * in evms_logical_volumes, and
+		 * don't report the volume to the user.
+		 */
+		if (lv->flags & EVMS_VOLUME_CORRUPT) {
+			if (!is_busy(mk_kdev(EVMS_MAJOR, user_minor))) {
+				/* clear logical volume structure
+				   * for this volume so it may be
+				   * reused.
+				 */
+				LOG_WARNING("ioctl_get_minor: found unmounted "
+					    "%s volume(%u,%u,%s).\n",
+					    ((lv->flags & EVMS_VOLUME_SOFT_DELETED) ?
+					     "'soft deleted'" : ""),
+					    EVMS_MAJOR, user_minor, lv->name);
+				LOG_WARNING("     releasing minor(%d) used by "
+					    "volume(%s)!\n",
+					    user_minor, lv->name);
+				blk_cleanup_queue(&lv->request_queue);
+				kfree(lv->name);
+				list_del_init(&lv->volumes);
+				kfree(lv);
+			}
+		}
+		if (lv->node || (lv->flags & EVMS_VOLUME_CORRUPT)) {
+			tmp.status = EVMS_VOLUME_VALID;
+			tmp.minor = user_minor;
+			break;
+		}
+	}
+	/* copy info to userspace */
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_get_volume_data - retrieves info about a volume
+ * @arg:	vfs ioctl parameter, the get volume data ioctl packet
+ *
+ * retrieves the info about a specified volume
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_volume_data(void *arg)
+{
+	int rc = 0;
+	struct evms_volume_data_pkt tmp, *user_parms;
+	struct evms_logical_volume *lv = NULL;
+
+	user_parms = (struct evms_volume_data_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	lv = lookup_volume(tmp.minor);
+	if (lv == NULL || lv->node == NULL) {
+		rc = -ENODEV;
+		goto exit;
+	}
+	tmp.flags = lv->flags;
+	strcpy(tmp.volume_name, EVMS_DIR_NAME "/");
+	strcat(tmp.volume_name, lv->name);
+      exit:
+	/* copy return code and info to userspace */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_get_plugin - retrieves info about the 1st or next loaded kernel plugin
+ * @arg:	vfs ioctl parameter, the registered plugin ioctl packet
+ *
+ * retrieves the info about the 1st or next loaded kernel plugin
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int plugin_id;
+static int
+evms_ioctl_cmd_get_plugin(void *arg)
+{
+	struct evms_kernel_plugin_pkt tmp, *user_parms;
+	struct evms_plugin_header *plugin;
+
+	user_parms = (struct evms_kernel_plugin_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user
+	    (&tmp.command, &user_parms->command, sizeof (tmp.command))) {
+		return -EFAULT;
+	}
+	spin_lock(&plugin_lock);
+	plugin = list_entry(&plugin_head, typeof(*plugin), headers);
+	/* if the command is not 0, then verify
+	 * that ioctl_reg_record is pointing to
+	 * current and valid plugin header.
+	 */
+	if (tmp.command) {	/* tmp.command == EVMS_NEXT_PLUGIN */
+		list_for_each_entry(plugin, &plugin_head, headers) {
+			if (plugin_id == plugin->id) {
+				break;
+			}
+		}
+		if (&plugin->headers == &plugin_head) {
+			tmp.command = EVMS_FIRST_PLUGIN;
+		}
+	}
+	if (tmp.command == EVMS_FIRST_PLUGIN) {
+		plugin_id = 0;
+	}
+	if (!list_empty(&plugin_head)) {
+		plugin = list_entry(plugin->headers.next, typeof(*plugin), headers);
+		if (&plugin->headers != &plugin_head) {
+			plugin_id = plugin->id;
+		}
+	}
+	/* populate the user's buffer */
+	tmp.status = EVMS_PLUGIN_INVALID;
+	tmp.id = 0;
+	if (plugin_id) {
+		tmp.id = plugin->id;
+		tmp.version = plugin->version;
+		tmp.status = EVMS_PLUGIN_VALID;
+	}
+	spin_unlock(&plugin_lock);
+	/* copy info to userspace */
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
+/**
+ * evms_ioctl_cmd_plugin_ioctl - sends a plugin specific ioctl to a specified plugin
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @cmd:	vfs ioctl parameter
+ * @arg:	vfs ioctl parameter, the plugin ioctl packet
+ *
+ * routes a plugin specific ioctl to the specified plugin
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_plugin_ioctl(struct inode *inode,
+			    struct file *file, unsigned int cmd, ulong arg)
+{
+	int rc;
+	struct evms_plugin_ioctl_pkt tmp, *user_parms;
+	struct evms_plugin_header *plugin;
+
+	user_parms = (struct evms_plugin_ioctl_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	/* search for the specified plugin */
+	rc = -ENOPKG;
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		/* check for the specified feature id */
+		if (plugin->id == tmp.feature_id) {
+			/* check that entry point is used */
+			rc = -ENOSYS;
+			if (plugin->fops->direct_ioctl) {
+				spin_unlock(&plugin_lock);
+				rc = DIRECT_IOCTL(plugin, inode, file, cmd, arg);
+				spin_lock(&plugin_lock);
+			}
+			break;
+		}
+	}
+	spin_unlock(&plugin_lock);
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_kernel_partial_csum - invokes the kernel's csum_partial routine 
+ * @arg:	vfs ioctl parameter, the compute csum ioctl packet
+ *
+ * provides userspace access to the kernel's csum_partial routine
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+#define MAX_BUFFER_SIZE 65536
+static int
+evms_ioctl_cmd_kernel_partial_csum(void *arg)
+{
+	int rc = 0;
+	struct evms_compute_csum_pkt tmp, *user_parms;
+	u8 *user_buffer_ptr, *buffer = NULL;
+	u64 remaining_bytes, compute_size = MAX_BUFFER_SIZE;
+	unsigned int insum;
+
+	user_parms = (struct evms_compute_csum_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	/* allocate a io buffer upto 64Kbytes in size */
+	if (tmp.buffer_size < MAX_BUFFER_SIZE) {
+		compute_size = tmp.buffer_size;
+	}
+	/* allocate buffer large enough to hold a single sector */
+	buffer = kmalloc(compute_size, GFP_KERNEL);
+	if (!buffer) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+	/* perform io with specified disk */
+	insum = tmp.insum;
+	remaining_bytes = tmp.buffer_size;
+	user_buffer_ptr = tmp.buffer_address;
+	while (remaining_bytes) {
+		/* compute the compute_size for this pass */
+		compute_size = (remaining_bytes >= MAX_BUFFER_SIZE) ?
+		    MAX_BUFFER_SIZE : remaining_bytes;
+		/* copy into kernel from user data buffer */
+		if (copy_from_user(buffer, user_buffer_ptr, compute_size)) {
+			rc = -EFAULT;
+			goto exit;
+		}
+		/* compute the checksum for this pass */
+		tmp.outsum = csum_partial(buffer, tmp.buffer_size, insum);
+		/* set up for another possible pass */
+		insum = tmp.outsum;
+		/* update loop progress variables */
+		user_buffer_ptr += compute_size;
+		tmp.buffer_address += compute_size;
+		remaining_bytes -= compute_size;
+	}
+      exit:
+	/* if the sector_buffer was allocated, free it */
+	if (buffer)
+		kfree(buffer);
+
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+#undef MAX_BUFFER_SIZE
+
+/**
+ * evms_ioctl_cmd_get_bmap - computes the physical dev/sector pair from a logical dev/sector 
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @cmd:	vfs ioctl parameter
+ * @arg:	vfs ioctl parameter, the get bmap ioctl packet
+ *
+ * takes a logical volume's device/sector pair and returns the physical device/sector. this
+ * is typically used by loaders such as lilo, to read system files using BIOS during boot.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_get_bmap(struct inode *inode,
+			struct file *file, unsigned int cmd, ulong arg)
+{
+	int rc;
+	struct evms_get_bmap_pkt tmp, *user_parms;
+	struct evms_logical_volume *lv;
+
+	user_parms = (struct evms_get_bmap_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	/* pass the ioctl down the volume stack */
+	lv = lookup_volume(minor(inode->i_rdev));
+	rc = IOCTL(lv->node, inode, file, cmd, (ulong) & tmp);
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_process_notify_event - allows a process to register for a signal on an event
+ * @arg:	vfs ioctl parameter, the notify ioctl packet
+ *
+ * lets a process register for a signal notification when a specified kernel event occurs.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_process_notify_event(ulong arg)
+{
+	int rc = 0, found = 0;
+	struct evms_notify_pkt tmp, *user_parms;
+	struct evms_event *event = NULL;
+	struct evms_kevent *kevent = NULL;
+
+	user_parms = (struct evms_notify_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	/* check to see if PID has already been registered
+	 * for this event.
+	 */
+	list_for_each_entry(kevent, &evms_notify_list, list) {
+		event = &kevent->uevent;
+		if ((event->pid == tmp.eventry.pid) &&
+		    (event->eventid == tmp.eventry.eventid)) {
+			found = 1;
+			break;
+		}
+	}
+	if (tmp.command) {	/* tmp.command == EVMS_REGISTER_EVENT */
+		/* registration code */
+		if (found) {
+			rc = -EBUSY;
+			LOG_ERROR("error(%d): pid(%d) already registered to "
+				  "receive signal(%d) on event(%d).\n", rc,
+				  tmp.eventry.pid, tmp.eventry.signo,
+				  tmp.eventry.eventid);
+		} else {
+			/* register this pid/event type */
+			kevent =
+			    kmalloc(sizeof (struct evms_kevent), GFP_KERNEL);
+			if (!kevent) {
+				rc = -ENOMEM;
+				LOG_ERROR("error(%d) allocating event "
+					  "structure.\n", rc);
+			} else {
+				kevent->uevent.pid = tmp.eventry.pid;
+				kevent->uevent.eventid = tmp.eventry.eventid;
+				kevent->uevent.signo = tmp.eventry.signo;
+				list_add(&kevent->list, &evms_notify_list);
+			}
+		}
+	} else {		/* tmp.command == EVMS_UNREGISTER_EVENT */
+		/* unregistration code */
+		if (!found) {
+			rc = -ENODATA;
+			LOG_ERROR("error(%d) attempting to unregister a "
+				  "non-registered pid(%d) on event(%d).\n",
+				  rc, tmp.eventry.pid, tmp.eventry.eventid);
+		} else {
+			list_del_init(&kevent->list);
+			kfree(event);
+		}
+	}
+	/* copy the status value back to the user */
+	tmp.status = rc;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		rc = -EFAULT;
+	}
+	return rc;
+}
+
+/**
+ * evms_ioctl_cmd_check_mount_status - determines if the specified volume is current mounted
+ * @inode:	vfs ioctl parameter
+ * @file:	vfs ioctl parameter
+ * @arg:	vfs ioctl parameter, the mount status ioctl packet
+ *
+ * allows userspace to query the kernel to know if the specified volume is mounted (in use)
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl_cmd_check_mount_status(struct inode *inode, struct file *file,
+				  ulong arg)
+{
+	struct evms_mount_status_pkt tmp, *user_parms;
+
+	user_parms = (struct evms_mount_status_pkt *) arg;
+	/* copy user's parameters to kernel space */
+	if (copy_from_user(&tmp, user_parms, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	tmp.mounted = (is_busy(mk_kdev(EVMS_MAJOR, tmp.minor))) ? 1 : 0;
+	/* copy the status value back to the user */
+	tmp.status = 0;
+	if (copy_to_user(user_parms, &tmp, sizeof (tmp))) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
+/************************************************/
+/* END -- IOCTL commands -- EVMS specific       */
+/************************************************/
+
+/************************************************/
+/* START -- IOCTL commands -- Volume specific   */
+/************************************************/
+
+/************************************************/
+/* END -- IOCTL commands -- Volume specific     */
+/************************************************/
+
+/************************************************/
+/* START -- IOCTL main                          */
+/************************************************/
+
+/**
+ * evms_ioctl - the main ioctl routing function
+ * @inode:	vfs ioctl parameter, the inode
+ * @file:	vfs ioctl parameter, the file
+ * @cmd:	vfs ioctl parameter, the command
+ * @arg:	vfs ioctl parameter, the argument
+ *
+ * EVMS' main ioctl entry point and routing function
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_ioctl(struct inode *inode, struct file *file, unsigned int cmd, ulong arg)
+{
+	ulong minor = 0;
+	int rc = 0;
+
+	/* check user access */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (!inode)
+		return -EINVAL;
+
+	/* get the minor */
+	minor = minor(inode->i_rdev);
+	LOG_EXTRA("ioctl: minor(%lu), dir(%d), size(%d), type(%d), nr(%d)\n",
+		  minor, (cmd >> _IOC_DIRSHIFT) & _IOC_DIRMASK,
+		  (cmd >> _IOC_SIZESHIFT) & _IOC_SIZEMASK,
+		  (cmd >> _IOC_TYPESHIFT) & _IOC_TYPEMASK,
+		  (cmd >> _IOC_NRSHIFT) & _IOC_NRMASK);
+
+	/* process the IOCTL commands */
+	if (!minor) {
+		/* process all EVMS specific commands */
+		switch (cmd) {
+		case EVMS_GET_IOCTL_VERSION:
+			rc = evms_ioctl_cmd_get_ioctl_version((void *)
+							      arg);
+			break;
+		case EVMS_GET_VERSION:
+			rc = evms_ioctl_cmd_get_version((void *) arg);
+			break;
+		case EVMS_GET_INFO_LEVEL:
+			rc = evms_ioctl_cmd_get_info_level((void *)
+							   arg);
+			break;
+		case EVMS_SET_INFO_LEVEL:
+			rc = evms_ioctl_cmd_set_info_level((void *)
+							   arg);
+			break;
+		case EVMS_REDISCOVER_VOLUMES:
+			rc = evms_ioctl_cmd_rediscover_volumes(inode,
+							       file, cmd, arg);
+			break;
+		case EVMS_GET_LOGICAL_DISK:
+			rc = evms_ioctl_cmd_get_logical_disk((void *)
+							     arg);
+			break;
+		case EVMS_GET_LOGICAL_DISK_INFO:
+			rc = evms_ioctl_cmd_get_logical_disk_info((void *)
+								  arg);
+			break;
+		case EVMS_SECTOR_IO:
+			rc = evms_ioctl_cmd_sector_io((void *) arg);
+			break;
+		case EVMS_GET_MINOR:
+			rc = evms_ioctl_cmd_get_minor((void *) arg);
+			break;
+		case EVMS_GET_VOLUME_DATA:
+			rc = evms_ioctl_cmd_get_volume_data((void *)
+							    arg);
+			break;
+		case EVMS_DELETE_VOLUME:
+			rc = evms_ioctl_cmd_delete_volume(inode, file, arg);
+			break;
+		case EVMS_GET_PLUGIN:
+			rc = evms_ioctl_cmd_get_plugin((void *) arg);
+			break;
+		case EVMS_PLUGIN_IOCTL:
+			rc = evms_ioctl_cmd_plugin_ioctl(inode, file, cmd, arg);
+			break;
+		case EVMS_COMPUTE_CSUM:
+			rc = evms_ioctl_cmd_kernel_partial_csum((void *)
+								arg);
+			break;
+		case EVMS_PROCESS_NOTIFY_EVENT:
+			rc = evms_ioctl_cmd_process_notify_event(arg);
+			break;
+		case EVMS_CHECK_MOUNT_STATUS:
+			rc = evms_ioctl_cmd_check_mount_status(inode, file,
+							       arg);
+			break;
+		default:
+			rc = -ENOTTY;
+			break;
+		}
+	} else {
+		struct evms_logical_volume *lv;
+		struct evms_logical_node *node = NULL;
+
+		/* insure this minor points to a valid volume */
+		lv = lookup_volume(minor);
+		if (lv == NULL || lv->node == NULL) {
+			return -ENXIO;
+		}
+		node = lv->node;
+		
+		/* process Volume specific commands */
+		switch (cmd) {
+		case EVMS_GET_IOCTL_VERSION:
+			rc = evms_ioctl_cmd_get_ioctl_version((void *)
+							      arg);
+			break;
+		case EVMS_GET_BMAP:
+			rc = evms_ioctl_cmd_get_bmap(inode, file, cmd, arg);
+			break;
+		default:
+			rc = IOCTL(node, inode, file, cmd, arg);
+			break;
+		}
+	}
+	return rc;
+}
+
+/************************************************/
+/* END -- IOCTL main                            */
+/************************************************/
+
+/************************************************/
+/* START -- CHECK MEDIA CHANGE		        */
+/************************************************/
+
+/**
+ * evms_check_media_change
+ * @dev:	the device to check
+ *
+ * checks to see if the media change flag is set for this device
+ *
+ * returns: 1 = media change detected
+ *	    0 = no media change detected
+ * 	    otherwise error code
+ **/
+static int
+evms_check_media_change(kdev_t dev)
+{
+	int rc = 0;
+	struct evms_logical_volume *lv;
+
+	lv = lookup_volume(minor(dev));
+	if (lv == NULL || lv->node == NULL) {
+		return -ENXIO;
+	}
+	/* Wait here if the volume is quiesced. */
+	atomic_inc(&lv->requests_in_progress);
+	do {
+		if (!lv->quiesced)
+			break;
+		if (atomic_dec_and_test(&lv->requests_in_progress))
+			wake_up(&lv->quiesce_wait_queue);
+		wait_event(lv->request_wait_queue, (!lv->quiesced));
+		atomic_inc(&lv->requests_in_progress);
+	} while (0);
+	/* Volume node may have gone away while we were waiting. */
+	if (!lv->node) {
+		return -ENXIO;
+	}
+	if (lv->flags & EVMS_DEVICE_REMOVABLE) {
+		rc = CHECK_MEDIA_CHANGE(lv->node, dev);
+	}
+	if (atomic_dec_and_test(&lv->requests_in_progress) &&
+	    lv->quiesced) {
+		wake_up(&lv->quiesce_wait_queue);
+	}
+	if (rc < 0) {
+		LOG_ERROR("error(%d) checking media change on '%s'.\n", 
+			  rc, lv->name);
+	}
+	return rc;
+}
+
+/************************************************/
+/* END -- CHECK MEDIA CHANGE		        */
+/************************************************/
+
+/**
+ * evms_check_for_device_changes - looks for any new/removed devices/media
+ * @inode:	vfs ioctl parameter, the inode
+ * @file:	vfs ioctl parameter, the file
+ *
+ * checks for new or removed devices as well as changed removable media. to accomplish
+ * this, this routine will completely purge from kernel memory entire volumes that may
+ * only partially reside on the change devices. once purged, all new devices and devices
+ * that purged volumes resided on, are re-probed and the resulting volumes are made
+ * available.
+ *
+ * NOTE: to maximize the effectiveness of this function, it is called on every OPEN
+ * of the EVMS block_device. Everytime the user tools are invoked, or a volume is
+ * mounted, this check will happen and the user will the see the updated results 
+ * without any manual steps.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_check_for_device_changes(struct inode *inode, struct file *file)
+{
+	int rc = 0, something_changed = 0, i;
+	struct evms_rediscover_pkt kernel_rd_pckt = { 0, 0, NULL };
+	struct list_head changed_list, new_device_list;
+	struct evms_logical_node *disk, *next;
+	struct evms_logical_volume *lv = NULL, *next_lv;
+
+	/* grab the rediscover semaphore */
+	down(&red_sem);
+
+	INIT_LIST_HEAD(&changed_list);
+	INIT_LIST_HEAD(&new_device_list);
+
+	/* check for new devices
+	 *
+	 * put all new devices on the disk list so they
+	 * will be included in the rediscovery process.
+	 */
+	evms_discover_logical_disks(&new_device_list);
+	if (!list_empty(&new_device_list)) {
+		LOG_DETAILS("%s: new devices detected.\n", __FUNCTION__);
+		something_changed++;
+		/* put these new nodes on the disk list */
+		list_for_each_entry_safe(disk, next, &new_device_list, discover) {
+			list_del_init(&disk->discover);
+			list_add(&disk->removable, &changed_list);
+		}
+	}
+
+	/* check all devices for changed removable media
+	 *
+	 * scan the evms device list and issue check
+	 * media change on each removable media device.
+	 * put all removable devices that indicate a
+	 * media change on the changed list.
+	 *
+	 * also scan for devices that have been unplugged
+	 * or contain corrupt volumes.
+	 */
+	list_for_each_entry_safe(disk, next, &evms_device_list, device) {
+		int add_to_list = 0;
+		/* only really check removable media devices */
+		if (disk->flags & EVMS_DEVICE_REMOVABLE) {
+			/* check for media change */
+			rc = CHECK_MEDIA_CHANGE(disk, mk_kdev(0,0));
+			if (rc < 0) {
+				LOG_ERROR("error(%d) doing CHECK_MEDIA_CHANGE "
+					  "on '%s'.\n", rc, disk->name);
+			} else if (rc == 1) {
+				add_to_list = 1;
+			}
+		}
+		/* check for devices that were present
+		 * earlier, but are gone now (from being 
+		 * unplugged or unloaded driver).
+		 */
+		if (disk->flags & EVMS_DEVICE_UNAVAILABLE) {
+			add_to_list = 1;
+		}
+		if (add_to_list) {
+			something_changed++;
+			list_add(&disk->removable, &changed_list);
+		}
+	}
+	/* log a statement that we detected changed media.
+	 */
+	if (!list_empty(&changed_list)) {
+		LOG_DETAILS("%s: media change detected.\n", __FUNCTION__);
+	}
+
+	/* check for volumes with removed removable media.
+	 * mark the volumes that reside on changed media.
+	 */
+	lv = NULL;
+	while ((lv = find_next_volume(lv))) {
+		if (!lv->node)
+			continue;
+		if (!(lv->flags & EVMS_DEVICE_REMOVABLE))
+			continue;
+		if (evms_check_media_change(mk_kdev(EVMS_MAJOR, lv->minor)) <= 0)
+			continue;
+		/* remember which volumes have changed media */
+		lv->flags |= EVMS_MEDIA_CHANGED;
+		something_changed++;
+	}
+
+	/* check for removed devices */
+	lv = NULL;
+	while ((lv = find_next_volume(lv))) {
+		int status;
+		if (!lv->node)
+			continue;
+		/* check for device status */
+		status = 0;
+		rc = DEVICE_STATUS(lv->node, &status);
+		if (rc) {
+			LOG_ERROR("error(%d) doing DEVICE_STATUS "
+				  "on '%s'.\n", rc, lv->name);
+			continue;
+		}
+		if (!(status & EVMS_DEVICE_UNAVAILABLE)) {
+			continue;
+		}
+		/* remember which volumes have changed media */
+		lv->flags |= EVMS_DEVICE_UNPLUGGED;
+		something_changed++;
+	}
+
+	/* do we have some work to do? */
+	if (something_changed) {
+		/* check for volumes to be deleted */
+		lv = NULL;
+		while ((lv = find_next_volume(lv))) {
+			if (!lv->node)
+				continue;
+			/* only proceed on volumes with:
+			 *  changed media,
+			 *  hot-unplugged devices,
+			 *  & partial volumes
+			 */
+			if (!(lv->flags &
+			      (EVMS_MEDIA_CHANGED |
+			       EVMS_VOLUME_PARTIAL | EVMS_DEVICE_UNPLUGGED)))
+				continue;
+			/* gather the disk's needing to be
+			 * rediscovered to rebuild this
+			 * volume.
+			 *
+			 * this will locate other disks that
+			 * the volume resides on that don't
+			 * indicate media change.
+			 */
+			rc = DEVICE_LIST(lv->node, &changed_list);
+			if (rc) {
+				LOG_ERROR("%s: error(%d) retrieving underlying "
+					  "disk list for '%s', skipping ...\n",
+					  __FUNCTION__, rc, lv->name);
+				continue;
+			}
+			/* quiesce all the changed volumes
+			 * prior to being deleted.
+			 */
+			rc = evms_quiesce_volume(lv, 1, lv->minor, 0);
+			if (rc) {
+				LOG_ERROR("%s: error(%d) attempting to quiesce "
+					  "'%s%s'.\n", __FUNCTION__, rc,
+					  EVMS_DIR_NAME "/", lv->name);
+			}
+		}
+
+		/* we need to revalidate all the changed
+		 * media. this is accomplished by issuing
+		 * the revalidate disk ioctl to each device
+		 * with changed media. the device manager
+		 * remembers which devices indicated
+		 * media changed (set by check media
+		 * changed ioctl issued earlier), and will
+		 * only issue the revalidate disk ioctl to
+		 * those disks one time.
+		 *
+		 * NOTE:
+		 * this needs to be done BEFORE deleting
+		 * the volumes because deleting the
+		 * last segment on disk will cause the
+		 * associated disk node to freed, and we
+		 * will not be able to issue the
+		 * revalidate disk ioctl after that.
+		 */
+		list_for_each_entry(disk, &changed_list, removable) {
+			/* only really do removable media devices */
+			if (disk->flags & EVMS_MEDIA_CHANGED) {
+				/* go revalidate the change media */
+				rc = REVALIDATE(disk, mk_kdev(0,0));
+				if (rc) {
+					LOG_ERROR("%s: error(%d) attempting to "
+						  "revalidate '%s%s'.\n",
+						  __FUNCTION__, rc,
+						  EVMS_DIR_NAME "/", lv->name);
+				}
+			}
+		}
+
+		/* delete all the affected volumes */
+		next_lv = NULL;
+		while ((lv = find_next_volume_safe(&next_lv))) {
+			if (!lv->node)
+				continue;
+			/* only proceed on volumes with:
+			 *  changed media,
+			 *  hot-unplugged devices,
+			 *  & partial volumes
+			 */
+			if (!(lv->flags &
+			      (EVMS_MEDIA_CHANGED |
+			       EVMS_VOLUME_PARTIAL | EVMS_DEVICE_UNPLUGGED)))
+				continue;
+			/* only delete quiesced volumes */
+			if (!lv->quiesced)
+				continue;
+			/* delete the volume from memory.
+			 * do a 'soft' delete if volume
+			 * is mounted, and 'hard' delete
+			 * if it is not.
+			 *
+			 * NOTE: the delete operation will
+			 * clear the bits in the flags field.
+			 */
+			rc = evms_delete_volume(lv, 2, lv->minor, 0);
+		}
+
+		/* at this point all devices indicating
+		 * media change that had volumes on them
+		 * should be gone. however, we could still
+		 * have devices indicating media change
+		 * that had no volumes on them in the disk
+		 * list. we need to delete these devices
+		 * from kernel memory and the global device
+		 * list.
+		 */
+		list_for_each_entry_safe(disk, next, &evms_device_list, device) {
+			if (disk->flags & EVMS_MEDIA_CHANGED) {
+				DELETE(disk);
+			}
+		}
+
+		/* all the devices that indicated media
+		 * change should be gone, both from kernel
+		 * memory and evms device list. we now
+		 * need to remove any references to these
+		 * devices from the disk list.
+		 *
+		 * when removable media is installed, it
+		 * will get detected in the device manager's
+		 * rediscovery as a new device and added to
+		 * the discover list.
+		 */
+		list_for_each_entry_safe(disk, next, &changed_list, removable) {
+			int still_in_changed_list;
+			struct evms_logical_node *edl_node;
+
+			still_in_changed_list = 0;
+			list_for_each_entry(edl_node, &evms_device_list, device) {
+				if (edl_node == disk) {
+					still_in_changed_list = 1;
+					break;
+				}
+			}
+			if (still_in_changed_list == 0) {
+				list_del_init(&disk->removable);
+			}
+		}
+
+		/* build the in-kernel rediscover packet */
+
+		/* allocate the space for the drive_array in
+		 * the struct evms_rediscover packet. to do this
+		 * we need to count the number of disk nodes,
+		 * then allocate the necessary space.
+		 */
+		/* count the disk nodes */
+		list_for_each_entry(disk, &changed_list, removable) {
+			kernel_rd_pckt.drive_count++;
+		}
+		/* allocate the space */
+		if (kernel_rd_pckt.drive_count) {
+			kernel_rd_pckt.drive_array
+			    = kmalloc(kernel_rd_pckt.drive_count *
+				      sizeof (u64), GFP_KERNEL);
+			if (!kernel_rd_pckt.drive_array) {
+				rc = -ENOMEM;
+				LOG_ERROR("%s: error(%d) allocating rediscover "
+					  "drive array.\n", __FUNCTION__, rc);
+				return rc;
+			}
+		}
+		/* populate the drive array
+		 *
+		 * this also frees the changed_list which is useful
+		 * if we had an error allocating the drive array.
+		 */
+		i = 0;
+		list_for_each_entry_safe(disk, next, &changed_list, removable) {
+			/* remove this disk from the disk list */
+			list_del_init(&disk->removable);
+			/* add this disk to rediscover packet
+			 */
+			kernel_rd_pckt.drive_array[i++] =
+			    NODE_TO_DEV_HANDLE(disk);
+		}
+		/* perform the rediscovery operation */
+		rc = evms_discover_volumes(&kernel_rd_pckt);
+		if (kernel_rd_pckt.drive_count) {
+			kfree(kernel_rd_pckt.drive_array);
+		}
+		LOG_DETAILS("%s: rediscover completed.\n", __FUNCTION__);
+	}
+
+	/* release the rediscover semaphore */
+	up(&red_sem);
+
+	return rc;
+}
+
+/************************************************/
+/* START -- REVALIDATE DISK		        */
+/************************************************/
+
+/**
+ * evms_revalidate_disk - routes revalidate ioctls to all underlying volume devices
+ * @dev:	the volume whose underlying devices will be revalidated
+ *
+ * ripples the revalidate request down the EVMS volume feature stack and routes to
+ * all underlying dasd devices. This is typically done after issuing a change
+ * media change which reports a media change, so the kernel can update its disk
+ * info for the new media.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_revalidate_disk(kdev_t dev)
+{
+	int rc;
+	struct evms_logical_volume *lv;
+
+	lv = lookup_volume(minor(dev));
+	if (lv == NULL || lv->node == NULL) {
+		return -ENXIO;
+	}
+	/* Wait here if the volume is quiesced. */
+	atomic_inc(&lv->requests_in_progress);
+	do {
+		if (!lv->quiesced)
+			break;
+		if (atomic_dec_and_test(&lv->requests_in_progress))
+			wake_up(&lv->quiesce_wait_queue);
+		wait_event(lv->request_wait_queue, (!lv->quiesced));
+		atomic_inc(&lv->requests_in_progress);
+	} while (0);
+	/* Volume node may have gone away while we were waiting. */
+	if (!lv->node) {
+		return -ENXIO;
+	}
+	rc = REVALIDATE(lv->node, dev);
+	if (atomic_dec_and_test(&lv->requests_in_progress) &&
+	    lv->quiesced) {
+		wake_up(&lv->quiesce_wait_queue);
+	}
+	return rc;
+}
+
+/************************************************/
+/* END -- REVALIDATE DISK		        */
+/************************************************/
+
+/************************************************/
+/* START -- OPEN			        */
+/************************************************/
+
+/**
+ * evms_open - open a volume or EVMS block device
+ * @inode:	vfs ioctl parameter, the inode
+ * @file:	vfs ioctl parameter, the file
+ *
+ * opens a volume or the EVMS block device. this will also check for device changes
+ * prior to rippling the OPEN request down the volume feature stack to the underlying
+ * devices.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_open(struct inode *inode, struct file *file)
+{
+	int minor, rc;
+	struct evms_logical_volume *lv;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (!inode)
+		return -EINVAL;
+	rc = evms_check_for_device_changes(inode, file);
+	if (rc) {
+		return rc;
+	}
+	minor = minor(inode->i_rdev);
+	if (minor) {
+		lv = lookup_volume(minor);
+		if (lv == NULL || lv->node == NULL) {
+			return -ENXIO;
+		}
+		/* Wait here if the volume is quiesced. */
+		atomic_inc(&lv->requests_in_progress);
+		do {
+			if (!lv->quiesced)
+				break;
+			if (atomic_dec_and_test(&lv->requests_in_progress))
+				wake_up(&lv->quiesce_wait_queue);
+			wait_event(lv->request_wait_queue, (!lv->quiesced));
+			atomic_inc(&lv->requests_in_progress);
+		} while (0);
+		/* Volume node may have gone away while we were waiting. */
+		if (!lv->node) {
+			return -ENXIO;
+		}
+		rc = OPEN(lv->node, inode, file);
+		if (atomic_dec_and_test(&lv->requests_in_progress) &&
+		    lv->quiesced) {
+			wake_up(&lv->quiesce_wait_queue);
+		}
+		if (rc) {
+			LOG_ERROR("error(%d) opening volume '%s'.\n", 
+				  rc, lv->name);
+			return rc;
+		}
+	}
+	return 0;
+}
+
+/************************************************/
+/* END -- OPEN				        */
+/************************************************/
+
+/************************************************/
+/* START -- RELEASE			        */
+/************************************************/
+
+/**
+ * evms_release - release or close a volume or EVMS block device
+ * @inode:	vfs ioctl parameter, the inode
+ * @file:	vfs ioctl parameter, the file
+ *
+ * releases a volume or the EVMS block device, rippling the RELEASE request
+ * down the volume feature stack to the underlying devices.
+ *
+ * returns: 0 on success
+ * 	    otherwise error code
+ **/
+static int
+evms_release(struct inode *inode, struct file *file)
+{
+	int minor;
+	struct evms_logical_volume *lv = NULL;
+
+	if (!inode)
+		return -EINVAL;
+	minor = minor(inode->i_rdev);
+	if (minor) {
+		int rc;
+		lv = lookup_volume(minor);
+		if (lv == NULL || lv->node == NULL) {
+			return -ENXIO;
+		}
+		/* Wait here if the volume is quiesced. */
+		atomic_inc(&lv->requests_in_progress);
+		do {
+			if (!lv->quiesced)
+				break;
+			if (atomic_dec_and_test(&lv->requests_in_progress))
+				wake_up(&lv->quiesce_wait_queue);
+			wait_event(lv->request_wait_queue, (!lv->quiesced));
+			atomic_inc(&lv->requests_in_progress);
+		} while (0);
+		/* Volume node may have gone away while we were waiting. */
+		if (!lv->node) {
+			return -ENXIO;
+		}
+		rc = CLOSE(lv->node, inode, file);
+		if (atomic_dec_and_test(&lv->requests_in_progress) &&
+		    lv->quiesced) {
+			wake_up(&lv->quiesce_wait_queue);
+		}
+		if (rc) {
+			LOG_ERROR("error(%d) releasing volume '%s'.\n", 
+				  rc, lv->name);
+			return rc;
+		}
+	}
+	return 0;
+}
+
+/************************************************/
+/* END -- RELEASE			        */
+/************************************************/
+
+/**
+ * evms_fops - EVMS block device operations table
+ **/
+struct block_device_operations evms_fops = {
+	owner:THIS_MODULE,
+	open:evms_open,
+	release:evms_release,
+	ioctl:evms_ioctl,
+	check_media_change:evms_check_media_change,
+	revalidate:evms_revalidate_disk
+};
+
+/**********************************************************/
+/* END -- FOPS functions definitions                      */
+/**********************************************************/
+
+/**********************************************************/
+/* START -- RUNTIME support functions                     */
+/**********************************************************/
+
+/**
+ * evms_find_queue - finds the appropriate per volume request queue
+ * @dev:	the volume whose queue to find
+ *
+ * locates the request queue for the specified volume
+ *
+ * returns: NULL if request queue not found
+ *          volume's request queue
+ **/
+request_queue_t *
+evms_find_queue(kdev_t dev)
+{
+	struct evms_logical_volume *lv = lookup_volume(minor(dev));
+	if (lv && lv->node)
+		return &lv->request_queue;
+	return NULL;
+}
+EXPORT_SYMBOL(evms_find_queue);
+
+/**
+ * evms_make_request_fn - IO request submission routine for EVMS
+ * @q:		request queue
+ * @bio:	submitted bio
+ *
+ * routes the bio to the appropriate volume's submit_io entry point
+ *
+ * returns: 0 always
+ **/
+int
+evms_make_request_fn(request_queue_t * q, struct bio *bio)
+{
+	struct evms_logical_volume *lv = 
+		lookup_volume(minor(to_kdev_t(bio->bi_bdev->bd_dev)));
+	if (!lv || !lv->node) {
+		goto error;
+	}
+
+	/* Wait here if the volume is quiesced. */
+	atomic_inc(&lv->requests_in_progress);
+	do {
+		if (!lv->quiesced)
+			break;
+		if (atomic_dec_and_test(&lv->requests_in_progress))
+			wake_up(&lv->quiesce_wait_queue);
+		wait_event(lv->request_wait_queue, (!lv->quiesced));
+		atomic_inc(&lv->requests_in_progress);
+	} while (0);
+
+	/* Volume node may have gone away while we were waiting. */
+	if (!lv->node) {
+		goto error;
+	}
+
+	SUBMIT_IO(lv->node, bio);
+
+	if (atomic_dec_and_test(&lv->requests_in_progress) &&
+	    lv->quiesced) {
+		wake_up(&lv->quiesce_wait_queue);
+	}
+	return 0;
+
+error:
+	LOG_ERROR("request for unknown logical volume [minor(%d)].\n",
+		  minor(to_kdev_t(bio->bi_bdev->bd_dev)));
+	bio_io_error(bio, bio->bi_size);
+	return 0;
+}
+
+/**********************************************************/
+/* END -- RUNTIME support functions                       */
+/**********************************************************/
+
+/**
+ * evms_notify_reboot - EVMS' reboot notification response function
+ * @this:	notifer_block
+ * @code:	reboot reason code
+ * @x:		unused here
+ *
+ * this function gets called at shutdown time and is used
+ * to remove any evms controlled volumes from memory, thus
+ * allowing any plugins needing to flush internal caches
+ * to do so.
+ *
+ * returns: NOTIFY_DONE
+ */
+int
+evms_notify_reboot(struct notifier_block *this, ulong code, void *x)
+{
+	struct evms_logical_volume *lv, *next_lv;
+
+	switch (code) {
+	case SYS_DOWN:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		LOG_DEFAULT("stopping all evms controlled volumes.\n");
+
+		/* quiesce all volumes */
+		lv = NULL;
+		while ((lv = find_next_volume(lv))) {
+			if (!lv->node) {
+				continue;
+			}
+			evms_quiesce_volume(lv, 1, lv->minor, 0);
+		}
+		/* delete all volumes
+		 *
+		 * to ensure this work under the
+		 * most circumstances, a "soft"
+		 * delete will be done. this will
+		 * handle the strange case of a
+		 * volume still being mounted.
+		 */
+		next_lv = NULL;
+		while ((lv = find_next_volume_safe(&next_lv))) {
+			if (!lv->node)
+				continue;
+			/* only delete quiesced volumes */
+			if (!lv->quiesced)
+				continue;
+			/* delete the volume from memory.
+			 * do a 'soft' delete if volume
+			 * is mounted, and 'hard' delete
+			 * if it is not.
+			 */
+			evms_delete_volume(lv, 2, lv->minor, 0);
+		}
+	}
+	return NOTIFY_DONE;
+}
+
+/**
+ * evms_notifier - reboot notification registration record
+ **/
+static struct notifier_block evms_notifier = {
+	.notifier_call = evms_notify_reboot,
+	.next = NULL,
+	.priority = INT_MAX,	/* before any real devices */
+};
+
+/* Hooks to be able to force-load the Passthru plugin. */
+extern int evms_passthru_init(void);
+extern void evms_passthru_exit(void);
+
+void evms_load_passthru(void)
+{
+	evms_passthru_init();
+}
+
+void evms_unload_passthru(void)
+{
+	evms_passthru_exit();
+}
+
+/**
+ * slab_pool_alloc
+ * @gfp_mask:	GFP allocation flag
+ * @data:	mempool prototype required fields
+ *
+ * mempool allocate function
+ **/
+static void *
+slab_pool_alloc(int gfp_mask, void *data)
+{
+	return kmem_cache_alloc(data, gfp_mask);
+}
+
+/**
+ * slab_pool_free
+ * @ptr:	mempool prototype required fields
+ * @data:	mempool prototype required fields
+ *
+ * mempool free function
+ **/
+static void
+slab_pool_free(void *ptr, void *data)
+{
+	kmem_cache_free(data, ptr);
+}
+
+int evms_can_unload(void)
+{
+	return (atomic_read(&red_sem.count) < 1) ? -EBUSY : 0;
+}
+
+/**
+ * evms_init_module
+ *
+ * This function runs once at module initialization and performs the one time
+ * EVMS setup tasks of allocating memory, initializing variables, and
+ * registering the block device.
+ **/
+static int __init
+evms_init_module(void)
+{
+	int rc;
+
+	LOG_DEFAULT("EVMS v%d.%d.%d initializing .... info level(%d).\n",
+		    EVMS_MAJOR_VERSION, EVMS_MINOR_VERSION,
+		    EVMS_PATCHLEVEL_VERSION, evms_info_level);
+
+	INIT_LIST_HEAD(&evms_device_list);
+	INIT_LIST_HEAD(&evms_fbottom_list);
+	INIT_LIST_HEAD(&evms_notify_list);
+	INIT_LIST_HEAD(&evms_logical_volumes);
+	init_MUTEX(&red_sem);
+
+	/* Initialize the evms_io_notify pool */
+	evms_io_notify_slab = kmem_cache_create("EVMS IO Notify",
+						sizeof (struct evms_io_notify),
+						0, SLAB_HWCACHE_ALIGN,
+						NULL, NULL);
+	if (!evms_io_notify_slab) {
+		LOG_ERROR("error(%d): unable to create EVMS IO Notify cache.",
+			  -ENOMEM);
+		return -ENOMEM;
+	}
+	evms_io_notify_pool = mempool_create(256, slab_pool_alloc,
+					     slab_pool_free,
+					     evms_io_notify_slab);
+	if (!evms_io_notify_pool) {
+		kmem_cache_destroy(evms_io_notify_slab);
+		LOG_ERROR("error(%d): unable to create EVMS IO Notify pool.",
+			  -ENOMEM);
+		return -ENOMEM;
+	}
+
+	/* Register the block device */
+	rc = register_blkdev(EVMS_MAJOR, EVMS_DIR_NAME, &evms_fops);
+	if (rc) {
+		LOG_CRITICAL("error(%d) calling register_blkdev()\n", rc);
+		return -EINVAL;
+	}
+
+	/* Register with devfs. A NULL return is not fatal,
+	 * since devfs just might not be running.
+	 */
+        evms_dir_devfs_handle = devfs_mk_dir(NULL, EVMS_DIR_NAME, NULL);
+	if (evms_dir_devfs_handle) {
+		evms_blk_devfs_handle =
+		    devfs_register(evms_dir_devfs_handle, EVMS_DEV_NAME,
+				   DEVFS_FL_DEFAULT, EVMS_MAJOR, 0,
+				   S_IFBLK | S_IRUGO | S_IWUGO,
+				   &evms_fops, NULL);
+		if (!evms_blk_devfs_handle) {
+			LOG_DETAILS("NULL return from devfs_register() for \"%s\"\n",
+				    EVMS_DEV_NAME);
+		}
+	}
+
+	blk_dev[EVMS_MAJOR].queue = evms_find_queue;
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(EVMS_MAJOR),
+			       evms_make_request_fn);
+
+	/* Create the proc and sysctl entries. */
+	evms_cs_get_evms_proc_dir();
+	if (evms_proc_dir) {
+		create_proc_read_entry("info", 0, evms_proc_dir,
+				       evms_info_read_proc, NULL);
+		create_proc_read_entry("plugins", 0, evms_proc_dir,
+				       evms_plugins_read_proc, NULL);
+		create_proc_read_entry("volumes", 0, evms_proc_dir,
+				       evms_volumes_read_proc, NULL);
+	}
+
+	evms_table_header = register_sysctl_table(dev_dir_table, 1);
+
+	register_reboot_notifier(&evms_notifier);
+
+	evms_ioctl32_register();
+
+	evms_load_passthru();
+
+	return 0;
+}
+
+/**
+ * evms_exit_module
+ *
+ * This function runs when the EVMS block device is being unloaded. it
+ * unloads the passthru plugin, unregisters the ioctl32 handlers and the
+ * reboot notifier. Then it cleans up the proc and sysctl entries and the
+ * I/O request queue. Finally it unregisters with devfs and the block
+ * layer and frees up all allocated memory.
+ **/
+static void __exit
+evms_exit_module(void)
+{
+	LOG_DEFAULT("EVMS v%d.%d.%d unloading ....\n",
+		    EVMS_MAJOR_VERSION,
+		    EVMS_MINOR_VERSION, EVMS_PATCHLEVEL_VERSION);
+
+	evms_unload_passthru();
+
+	evms_ioctl32_unregister();
+
+	unregister_reboot_notifier(&evms_notifier);
+
+	if (evms_proc_dir) {
+		remove_proc_entry("volumes", evms_proc_dir);
+		remove_proc_entry("plugins", evms_proc_dir);
+		remove_proc_entry("info", evms_proc_dir);
+		remove_proc_entry("evms", NULL);
+	}
+
+	unregister_sysctl_table(evms_table_header);
+
+	blk_cleanup_queue(BLK_DEFAULT_QUEUE(EVMS_MAJOR));
+	blk_dev[EVMS_MAJOR].queue = NULL;
+
+	devfs_unregister(evms_dir_devfs_handle);
+
+	unregister_blkdev(EVMS_MAJOR, EVMS_DIR_NAME);
+
+	mempool_destroy(evms_io_notify_pool);
+	kmem_cache_destroy(evms_io_notify_slab);
+}
+
+/**
+ * evms_cluster_init
+ *
+ * a placeholder for cluster enablement
+ **/
+void
+evms_cluster_init(int nodeid, int clusterid)
+{
+	/* dummy */
+	return;
+}
+
+EXPORT_SYMBOL(evms_cluster_init);
+
+/**
+ * evms_cluster_shutdown
+ *
+ * a placeholder for cluster enablement
+ **/
+int
+evms_cluster_shutdown(void)
+{
+	/* dummy */
+	return -1;
+}
+
+EXPORT_SYMBOL(evms_cluster_shutdown);
+
+/**
+ * evms_boot_info_level - parses the ascii evms info level parm on the loader's boot line
+ * @str:	the ascii info level to be parsed
+ *
+ * parses the ascii evms info level parm on the loader's boot line
+ *
+ * returns: 1 (always)
+ **/
+int __init
+evms_boot_info_level(char *str)
+{
+	int evms_boot_info_level = (int) simple_strtoul(str, NULL, 10);
+	if (evms_boot_info_level) {
+		evms_info_level = evms_boot_info_level;
+	}
+	return 1;
+}
+
+__setup("evms_info_level=", evms_boot_info_level);
+module_init(evms_init_module);
+module_exit(evms_exit_module);
+MODULE_LICENSE("GPL");
+
