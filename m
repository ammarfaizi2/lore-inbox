Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJJUJB>; Thu, 10 Oct 2002 16:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbSJJUJA>; Thu, 10 Oct 2002 16:09:00 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:27292 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262214AbSJJUDf>; Thu, 10 Oct 2002 16:03:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (2/9) services.c
Date: Thu, 10 Oct 2002 14:35:14 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014351404.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 2 of the EVMS core driver.

This file provides all of the common services that are available
to the EVMS plugins.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/drivers/evms/core/services.c linux-2.5.41-evms/drivers/evms/core/services.c
--- linux-2.5.41/drivers/evms/core/services.c	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/services.c	Thu Oct 10 13:14:27 2002
@@ -0,0 +1,1003 @@
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
+ * EVMS Common Services
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bio.h>
+#include <linux/smp_lock.h>
+#include <asm/uaccess.h>
+
+#include <linux/evms.h>
+#include <linux/evms_ioctl.h>
+#include "evms_core.h"
+
+/*
+ * evms services version
+ */
+struct evms_version evms_svc_version = {
+	.major = EVMS_COMMON_SERVICES_MAJOR,
+	.minor = EVMS_COMMON_SERVICES_MINOR,
+	.patchlevel = EVMS_COMMON_SERVICES_PATCHLEVEL
+};
+
+/**
+ * evms_cs_check_version - compares to evms_version structures
+ * @required:	required version level
+ * @actual:	actual version level
+ *
+ * Compares two evms_version structures and returns -EINVAL if the
+ * actual version does not meet the required version level.
+ **/
+int
+evms_cs_check_version(struct evms_version *required,
+		      struct evms_version *actual)
+{
+	if ((required->major != actual->major) ||
+	    (required->minor > actual->minor) ||
+	    ((required->minor == actual->minor) &&
+	     (required->patchlevel > actual->patchlevel)))
+		return -EINVAL;
+	return 0;
+}
+
+EXPORT_SYMBOL(evms_cs_check_version);
+
+/**
+ * evms_cs_allocate_logical_node - allocates an evms logical node structure
+ * @pp:		address of the pointer which will contain the address of newly allocated node
+ *
+ * Allocates and zeros an evms_logical_node structure.
+ *
+ * returns: 0 if sucessful
+ *          -ENOMEM if unsuccessful
+ **/
+int
+evms_cs_allocate_logical_node(struct evms_logical_node **pp)
+{
+	*pp = kmalloc(sizeof (struct evms_logical_node), GFP_KERNEL);
+	if (*pp == NULL) {
+		return -ENOMEM;
+	}
+	memset(*pp, 0, sizeof (struct evms_logical_node));
+	INIT_LIST_HEAD(&(*pp)->discover);
+	INIT_LIST_HEAD(&(*pp)->device);
+	INIT_LIST_HEAD(&(*pp)->fbottom);
+	INIT_LIST_HEAD(&(*pp)->removable);
+	INIT_LIST_HEAD(&(*pp)->consumed);
+	INIT_LIST_HEAD(&(*pp)->produced);
+	return 0;
+}
+
+EXPORT_SYMBOL(evms_cs_allocate_logical_node);
+
+/**
+ * evms_cs_deallocate_volume_info - frees any attached volume info structure
+ * @p:	address node to be freed
+ *
+ * If there is a evms_volume_info structure attached to this logical node, we
+ * know this node is a bottom-most storage object containing EVMS metadata for
+ * this volume. As such we must remove the node from the global feature node
+ * list, and then free the volume info structure.
+ **/
+void
+evms_cs_deallocate_volume_info(struct evms_logical_node *p)
+{
+	if (p->iflags & EVMS_FEATURE_BOTTOM) {
+		list_del_init(&p->fbottom);
+		kfree(p->volume_info);
+		p->volume_info = NULL;
+		p->iflags &= ~EVMS_FEATURE_BOTTOM;
+	}
+}
+
+EXPORT_SYMBOL(evms_cs_deallocate_volume_info);
+
+/**
+ * evms_cs_deallocate_logical_node - frees an evms logical node structure
+ * @p:	address of node to be freed
+ *
+ * Frees an allocated logical node, frees any attached volume info or feature
+ * header structures.
+ **/
+void
+evms_cs_deallocate_logical_node(struct evms_logical_node *p)
+{
+	evms_cs_deallocate_volume_info(p);
+	if (p->feature_header) {
+		kfree(p->feature_header);
+		p->feature_header = NULL;
+	}
+	BUG_ON(!list_empty(&p->discover));
+	BUG_ON(!list_empty(&p->device));
+	BUG_ON(!list_empty(&p->fbottom));
+	BUG_ON(!list_empty(&p->removable));
+	BUG_ON(!list_empty(&p->consumed));
+	BUG_ON(!list_empty(&p->produced));
+	kfree(p);
+}
+
+EXPORT_SYMBOL(evms_cs_deallocate_logical_node);
+
+/**
+ * evms_cs_register_plugin - validates and registers a newly loaded kernel plugin
+ * @plugin:	header of plugin attempting to register
+ *
+ * Validates and registers a new plugin.
+ **/
+int
+evms_cs_register_plugin(struct evms_plugin_header *plugin)
+{
+	int rc;
+	struct evms_plugin_header *p;
+
+	if (!(plugin_head.next && plugin_head.prev)) {
+		INIT_LIST_HEAD(&plugin_head);
+	}
+
+	LOG_EXTRA("registering plugin (id=%d.%d.%d, ver=%d.%d.%d)\n",
+		  GetPluginOEM(plugin->id), GetPluginType(plugin->id),
+		  GetPluginID(plugin->id), plugin->version.major,
+		  plugin->version.minor, plugin->version.patchlevel);
+
+	/* ensure a plugin with this feature id is
+	 * not already loaded.
+	 */
+	spin_lock(&plugin_lock);
+	list_for_each_entry(p, &plugin_head, headers) {
+		if (p->id == plugin->id) {
+			spin_unlock(&plugin_lock);
+			rc = -EBUSY;
+			LOG_ERROR("error(%d) attempting to load another "
+				  "plugin with id(%x).\n", rc, plugin->id);
+			return rc;
+		}
+	}
+	spin_unlock(&plugin_lock);
+
+	/* ensure the plugin has provided functions for
+	 * the mandatory entry points.
+	 */
+	if (!plugin->fops->discover ||
+	    !plugin->fops->sync_io ||
+	    !plugin->fops->ioctl ||
+	    !plugin->fops->submit_io ||
+	    !plugin->fops->open ||
+	    !plugin->fops->release ||
+	    !plugin->fops->check_media_change ||
+	    !plugin->fops->revalidate ||
+	    !plugin->fops->quiesce ||
+	    !plugin->fops->get_geo ||
+	    !plugin->fops->device_list ||
+	    !plugin->fops->device_status ||
+	    !plugin->fops->delete) {
+		return -EINVAL;
+	}
+	spin_lock(&plugin_lock);
+	list_add(&plugin->headers, &plugin_head);
+	spin_unlock(&plugin_lock);
+	return 0;
+}
+
+EXPORT_SYMBOL(evms_cs_register_plugin);
+
+/**
+ * evms_cs_unregister_plugin - unregisters a kernel plugin
+ * @plugin:	header of plugin to unregister
+ *
+ * Unregisters a loaded EVMS kernel plugin.
+ **/
+int
+evms_cs_unregister_plugin(struct evms_plugin_header *plugin)
+{
+	struct evms_plugin_header *p;
+
+	LOG_EXTRA("unregistering plugin (id=%d.%d.%d ver=%d.%d.%d)\n",
+		  GetPluginOEM(plugin->id), GetPluginType(plugin->id),
+		  GetPluginID(plugin->id), plugin->version.major,
+		  plugin->version.minor, plugin->version.patchlevel);
+
+	/* Ensure a plugin with this feature id is
+	 * currently loaded.
+	 */
+	spin_lock(&plugin_lock);
+	list_for_each_entry(p, &plugin_head, headers) {
+		if (p->id == plugin->id) {
+			list_del_init(&plugin->headers);
+			spin_unlock(&plugin_lock);
+			return 0;
+		}
+	}
+	spin_unlock(&plugin_lock);
+	LOG_ERROR("error(%d) attempt to unload a non-loaded plugin "
+		  "with id(%x).\n", -ENOPKG, plugin->id);
+	return -ENOPKG;
+}
+
+EXPORT_SYMBOL(evms_cs_unregister_plugin);
+
+/**
+ * evms_cs_kernel_ioctl - performs a userspace ioctl from within the kernel
+ * @node:	the storage object that is the target of this ioctl
+ * @cmd:	the ioctl command
+ * @arg:	the ioctl argument(s)
+ *
+ * Performs a userspace ioctl from within the kernel
+ **/
+int
+evms_cs_kernel_ioctl(struct evms_logical_node *node,
+		     unsigned int cmd, ulong arg)
+{
+	int rc;
+	struct inode tmp_inode;
+	mm_segment_t fs;
+
+	lock_kernel();
+	fs = get_fs();
+	set_fs(get_ds());
+	rc = IOCTL(node, &tmp_inode, NULL, cmd, arg);
+	set_fs(fs);
+	unlock_kernel();
+
+	return rc;
+}
+
+EXPORT_SYMBOL(evms_cs_kernel_ioctl);
+
+/**
+ * evms_cs_size_in_vsectors - returns rounded-up 512 byte unit value
+ * *item_size:	size of item in bytes
+ *
+ * Returns the # of 512 byte multiples an item occupies
+ **/
+inline ulong
+evms_cs_size_in_vsectors(long long item_size)
+{
+	long long sectors;
+	sectors = item_size >> EVMS_VSECTOR_SIZE_SHIFT;
+	if (item_size & (EVMS_VSECTOR_SIZE - 1))
+		sectors++;
+	return sectors;
+}
+
+EXPORT_SYMBOL(evms_cs_size_in_vsectors);
+
+/**
+ * evms_cs_log2 - computes the power of 2 of a specified value
+ * @value:	any value
+ *
+ * returns: -1 for value of 0
+ *	    -2 if value is not a power of 2
+ *	    power of 2
+ **/
+inline int
+evms_cs_log2(long long value)
+{
+	int result = -1;
+	long long tmp;
+
+	if (value) {
+		tmp = value;
+		result++;
+		while (!(tmp & 1)) {
+			result++;
+			tmp >>= 1;
+		}
+		if (tmp != 1) {
+			result = -2;
+		}
+	}
+	return result;
+}
+
+EXPORT_SYMBOL(evms_cs_log2);
+
+/*
+ * Defines and variables used by the CRC function
+ */
+#define CRC_POLYNOMIAL     0xEDB88320L
+static u32 crc_table[256];
+static u32 crc_table_built = 0;
+
+/**
+ * build_crc_table
+ *
+ * Initialzes the internal crc table
+ **/
+static void
+build_crc_table(void)
+{
+	u32 i, j, crc;
+
+	for (i = 0; i <= 255; i++) {
+		crc = i;
+		for (j = 8; j > 0; j--) {
+			if (crc & 1)
+				crc = (crc >> 1) ^ CRC_POLYNOMIAL;
+			else
+				crc >>= 1;
+		}
+		crc_table[i] = crc;
+	}
+	crc_table_built = 1;
+}
+
+/**
+ * evms_cs_calculate_crc
+ * @crc:       	the inital(0xFFFFFFFF) or rolling crc value
+ * @buffer:	address of buffer to compute crc
+ * @buffersize:	size of buffer
+ *
+ * This function calculates the crc value for the data 
+ * in the buffer specified by Buffer. 
+ **/
+u32
+evms_cs_calculate_crc(u32 crc, void *buffer, u32 buffersize)
+{
+	unsigned char *current_byte;
+	u32 temp1, temp2, i;
+
+	current_byte = (unsigned char *) buffer;
+	/* Make sure the crc table is available */
+	if (crc_table_built == 0)
+		build_crc_table();
+	/* Process each byte in the buffer. */
+	for (i = 0; i < buffersize; i++) {
+		temp1 = (crc >> 8) & 0x00FFFFFF;
+		temp2 = crc_table[(crc ^ (u32) * current_byte) & (u32) 0xff];
+		current_byte++;
+		crc = temp1 ^ temp2;
+	}
+	return crc;
+}
+
+EXPORT_SYMBOL(evms_cs_calculate_crc);
+
+/**
+ * evms_end_io
+ * @bio:	newly IO completed bio
+ *
+ * This is a support function for evms_cs_register_for_end_io_notification.
+ * This function is called during I/O completion on any bio that had its
+ * completion callback hooked by a plugin. Control is passed here
+ * and this routine will, thru the use of the I/O notify entry stored 
+ * in the bi_private field of the bio, restore the bi_rsector value and
+ * the bi_bdev value to the value bio had at the time of hook registration 
+ * and passes control to the registered callback_function, with pointers 
+ * to the bio and an optional plugin private data. Upon completion of the 
+ * callback_function, control is returned back here. The io notify list 
+ * entry is deleted. This process repeats until this routine detects that 
+ * all I/O notify entries registered by plugins have been called back and
+ * the bio's original end_io function has been called. At this point the 
+ * DONE flag is set, and we terminate the callback loop and exit.
+ *
+ * Plugins may desire to break or interrupt the callback sequence or chain. 
+ * This may be useful to redrive I/O or to wait for other bios to complete 
+ * before allowing the original bio callback to occur. To interrupt the
+ * callback "chain", a registered plugin's callback_function must return
+ * with the DONE flag set.
+ *
+ * NOTE: If a plugin sets the DONE flag, and wishes to redrive a bio, the
+ * plugin MUST reregister the bio to receive another callback on this bio.
+ * Also, the plugin MUST ensure that the original bio end_io function gets
+ * called at some point, either by reregistering this bio and receiving
+ * another callback, or by means of bio aggregation triggered by the callbacks
+ * of other bios.
+ */
+static int
+evms_end_io(struct bio *bio,
+	    unsigned int bytes_done,
+	    int err)
+{
+	struct evms_io_notify *entry;
+	int done;
+
+	if (bio->bi_size)
+		return 1;
+
+	done = 0;
+	while (!done) {
+		entry = (struct evms_io_notify *) bio->bi_private;
+		/* 
+		 * restore original values
+		 */
+		bio->bi_private = entry->b_private;
+		bio->bi_bdev = entry->bdev;
+		bio->bi_sector = entry->rsector;
+
+		if (entry->flags & EVMS_ORIGINAL_CALLBACK_FLAG) {
+			struct evms_logical_volume *lv;
+			lv = lookup_volume(minor(to_kdev_t(bio->bi_bdev->bd_dev)));
+			entry->flags &= ~EVMS_ORIGINAL_CALLBACK_FLAG;
+			if (atomic_dec_and_test(&lv->requests_in_progress) &&
+			    lv->quiesced) {
+				wake_up(&lv->quiesce_wait_queue);
+			}
+			bio->bi_end_io = (void *) entry->callback_function;
+			if (bio->bi_end_io) {
+				bio_endio(bio, bytes_done, err);
+			}
+			done = 1;
+		} else {
+			entry->callback_function(entry->private, bio, &done);
+		}
+		mempool_free(entry, evms_io_notify_pool);
+	}
+
+	return 0;
+}
+
+/**
+ * evms_cs_register_for_end_io_notification
+ * @private:		plugin private data
+ * @bio:		bio being hooked/registered for
+ * @callback_function:	plugin's callback function
+ *
+ * This routine allows a (plugin) function to register to participate
+ * in the io completion notification process. This is useful for plugins
+ * which alter data after it has been read from the disk (i.e. 
+ * encryption or compression).
+ *
+ * This routine also records the rsector and bdev values at the time of
+ * registration, so that they can be restored prior to the callback to
+ * a plugin, thus allowing that plugin to work with the values it had seen
+ * during its I/O request processing.
+ *
+ * This routine also records a private data pointer at the time of 
+ * registration that is returned to the plugin at callback time. This 
+ * private data pointer frees the plugin from having to create a place to
+ * store private data and later find that private data at the time of the
+ * callback. This field is not used by this function and is optional (NULL
+ * if unused). It is recorded and returned as a convenience for the plugins.
+ *
+ * DANGER!!! - WILL ROBINSON - DANGER!!!
+ * This routine uses the bi_private field in the bio structure. If any lower
+ * level driver uses this field and do NOT save and restore it, the I/O 
+ * callback will fail!!
+ */
+int
+evms_cs_register_for_end_io_notification(void *private,
+					 struct bio *bio,
+					 void *callback_function)
+{
+	int done;
+	struct evms_io_notify *new_entry;
+
+	done = 0;
+	while (!done) {
+		new_entry = mempool_alloc(evms_io_notify_pool, GFP_NOIO);
+		if (!new_entry) {
+			schedule();
+			continue;
+		}
+
+		new_entry->private = private;
+		new_entry->bio = bio;
+		new_entry->rsector = bio->bi_sector;
+		new_entry->bdev = bio->bi_bdev;
+		new_entry->b_private = bio->bi_private;
+		new_entry->flags = 0;
+
+		if (bio->bi_end_io != evms_end_io) {
+			struct evms_logical_volume *lv;
+			new_entry->flags |= EVMS_ORIGINAL_CALLBACK_FLAG;
+			lv = lookup_volume(minor(to_kdev_t(bio->bi_bdev->bd_dev)));
+			new_entry->callback_function = (void *) bio->bi_end_io;
+			atomic_inc(&lv->requests_in_progress);
+			bio->bi_end_io = evms_end_io;
+		} else {
+			new_entry->callback_function = callback_function;
+			done = 1;
+		}
+		bio->bi_private = new_entry;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(evms_cs_register_for_end_io_notification);
+
+/**
+ * evms_cs_signal_event - notify a PID of an event occurrence
+ * @eventid:	id of event to signal occurrence of
+ *
+ * Signal any registered PIDs that event corresponding to eventid has occurred.
+ **/
+void
+evms_cs_signal_event(int eventid)
+{
+	int rc;
+	struct evms_kevent *kevent;
+
+	/* signal PID(s) of specified event */
+	list_for_each_entry(kevent, &evms_notify_list, list) {
+		struct evms_event *event = &kevent->uevent;
+		if (event->eventid == eventid) {
+			struct task_struct *tsk;
+
+			tsk = find_task_by_pid(event->pid);
+			if (tsk) {
+				struct siginfo siginfo;
+
+				siginfo.si_signo = event->signo;
+				siginfo.si_errno = 0;
+				siginfo.si_code = 0;
+				rc = send_sig_info(event->signo, &siginfo, tsk);
+			} else {
+				/* TODO:
+				 * unregister this stale
+				 * notification record
+				 */
+			}
+		}
+	}
+}
+
+EXPORT_SYMBOL(evms_cs_signal_event);
+
+/**
+ * evms_flush_signals
+ *
+ * Flushes pending signals for the current process
+ **/
+static inline void
+evms_flush_signals(void)
+{
+	spin_lock(&current->sig->siglock);
+	flush_signals(current);
+	spin_unlock(&current->sig->siglock);
+}
+
+/**
+ * evms_init_signals
+ *
+ * Initialize the signal set for the current process
+ **/
+static inline void
+evms_init_signals(void)
+{
+	current->exit_signal = SIGCHLD;
+	siginitsetinv(&current->blocked, sigmask(SIGKILL));
+}
+
+/**
+ * evms_kernel_thread - generic evms kernel thread templace
+ * @arg:	thread structure
+ *
+ * Generic evms kernel thread template
+ **/
+static int
+evms_kernel_thread(void *arg)
+{
+	struct evms_thread *thread = arg;
+	lock_kernel();
+
+	/* Detach thread */
+	daemonize();
+
+	sprintf(current->comm, thread->name);
+	evms_init_signals();
+	evms_flush_signals();
+	thread->tsk = current;
+
+	unlock_kernel();
+
+	complete(thread->event);
+	while (thread->run) {
+		void (*run) (void *data);
+		DECLARE_WAITQUEUE(wait, current);
+
+		add_wait_queue(&thread->wqueue, &wait);
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		if (!test_bit(EVMS_THREAD_WAKEUP, &thread->flags)) {
+			schedule();
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&thread->wqueue, &wait);
+		clear_bit(EVMS_THREAD_WAKEUP, &thread->flags);
+
+		run = thread->run;
+		if (run) {
+			run(thread->data);
+			blk_run_queues();
+		}
+		if (signal_pending(current)) {
+			evms_flush_signals();
+		}
+	}
+	complete(thread->event);
+	return 0;
+}
+
+/**
+ * evms_cs_register_thread
+ * @run:	function to be run by the kernel thread
+ * @data:	argument for function
+ * @name:	name for kernel thread
+ *
+ * Creates a kernel thread named @name, that invokes the function @run
+ * which accepts the argument @data.
+ *
+ * returns: ptr to thread control structure on success
+ *          NULL on error
+ **/
+struct evms_thread *
+evms_cs_register_thread(void (*run) (void *), void *data, const u8 * name)
+{
+	struct evms_thread *thread;
+	int ret;
+	struct completion event;
+
+	thread = kmalloc(sizeof (struct evms_thread), GFP_KERNEL);
+	if (!thread)
+		return NULL;
+
+	memset(thread, 0, sizeof (struct evms_thread));
+	init_waitqueue_head(&thread->wqueue);
+
+	init_completion(&event);
+	thread->event = &event;
+	thread->run = run;
+	thread->data = data;
+	thread->name = name;
+	ret = kernel_thread(evms_kernel_thread, thread, 0);
+	if (ret < 0) {
+		kfree(thread);
+		return NULL;
+	}
+	wait_for_completion(&event);
+	return thread;
+}
+
+EXPORT_SYMBOL(evms_cs_register_thread);
+
+/**
+ * evms_cs_unregister_thread
+ * @thread:	thread control structure (created when thread was registered)
+ *
+ * Destroys the specified kernel thread.
+ **/
+void
+evms_cs_unregister_thread(struct evms_thread *thread)
+{
+	struct completion event;
+
+	init_completion(&event);
+
+	thread->event = &event;
+	thread->run = NULL;
+	thread->name = NULL;
+	evms_cs_interrupt_thread(thread);
+	wait_for_completion(&event);
+	kfree(thread);
+}
+
+EXPORT_SYMBOL(evms_cs_unregister_thread);
+
+/**
+ * evms_cs_wakeup_thread
+ * @thread:	thread control structure of thread to wake up
+ *
+ * Causes the kernel thread to wake up and run.
+ **/
+void
+evms_cs_wakeup_thread(struct evms_thread *thread)
+{
+	set_bit(EVMS_THREAD_WAKEUP, &thread->flags);
+	wake_up(&thread->wqueue);
+}
+
+EXPORT_SYMBOL(evms_cs_wakeup_thread);
+
+/**
+ * evms_cs_interrupt_thread
+ * @thread:	thread control structure of thread to interrupt
+ *
+ * Signals a kernel thread.
+ **/
+void
+evms_cs_interrupt_thread(struct evms_thread *thread)
+{
+	if (!thread->tsk) {
+		LOG_ERROR("error: attempted to interrupt an invalid thread!\n");
+		return;
+	}
+	send_sig(SIGKILL, thread->tsk, 1);
+}
+
+EXPORT_SYMBOL(evms_cs_interrupt_thread);
+
+/**
+ * evms_cs_get_evms_proc_dir
+ *
+ * Retrieves the EVMS proc dir entry.
+ **/
+struct proc_dir_entry *
+evms_cs_get_evms_proc_dir(void)
+{
+	if (!evms_proc_dir) {
+		evms_proc_dir = create_proc_entry("evms", S_IFDIR, &proc_root);
+	}
+	return evms_proc_dir;
+}
+
+EXPORT_SYMBOL(evms_cs_get_evms_proc_dir);
+
+/**
+ * evms_cs_volume_request_in_progress - get/change a volume's request in progress count
+ * @dev:
+ * @operation:		input, > 0 = inc count, < 0 = dec count, 0 = query count
+ * @current_count:	output, current count
+ *
+ * Query or change a volume's request in progress count.
+ *
+ * returns: 0 = success
+ *          -ENODEV if dev points to a non-existent volume
+ **/
+int
+evms_cs_volume_request_in_progress(kdev_t dev,
+				   int operation, int *current_count)
+{
+	struct evms_logical_volume *volume = lookup_volume(minor(dev));
+	if (!volume || !volume->node) {
+		return -ENODEV;
+	}
+	if (operation > 0) {
+		atomic_inc(&volume->requests_in_progress);
+	} else if (operation < 0) {
+		if (atomic_dec_and_test(&volume->requests_in_progress) &&
+		    volume->quiesced) {
+			wake_up(&volume->quiesce_wait_queue);
+		}
+	}
+	if (current_count) {
+		*current_count = atomic_read(&volume->requests_in_progress);
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(evms_cs_volume_request_in_progress);
+
+/**
+ * evms_cs_invalidate_volume - invalidate a volume's cache blocks
+ * @node:		top-most storage object in a volume
+ *
+ * Invalidates the resources (inodes, cache blocks, etc) used by this volume.
+ **/
+void
+evms_cs_invalidate_volume(struct evms_logical_node *node)
+{
+	struct evms_logical_volume *lv = NULL;
+	while ((lv = find_next_volume(lv))) {
+		if (!lv->node || !node->name) {
+			continue;
+		}
+		if (strcmp(lv->node->name, node->name)) {
+			continue;
+		}
+		LOG_DETAILS("Invalidating EVMS device %s minor %d\n",
+			    node->name, lv->minor);
+		invalidate_device(mk_kdev(EVMS_MAJOR, lv->minor), 0);
+		break;
+	}
+}
+
+EXPORT_SYMBOL(evms_cs_invalidate_volume);
+
+/**
+ * evms_bio_collector - manages split bio and real bio I/O completions
+ * @bio:	a split bio
+ *
+ * Collects all the split bio end_io's and when all have completed, calls
+ * the original bio's end_io, and setting the uptodate flag accordingly.
+ **/
+int
+evms_bio_collector(struct bio *bio,
+		   unsigned int bytes_done,
+		   int err)
+{
+	struct bio_split_cb *evms_bio_split_record;
+
+	if (bio->bi_size)
+		return 1;
+
+	evms_bio_split_record = (struct bio_split_cb *) bio->bi_private;
+	if (err || !test_bit(BIO_UPTODATE, &bio->bi_flags)) {
+		evms_bio_split_record->rc = -EIO;
+	}
+	mempool_free(bio, evms_bio_split_record->bio_pool);
+	atomic_dec(&evms_bio_split_record->outstanding_bios);
+	if (!atomic_read(&evms_bio_split_record->outstanding_bios)) {
+		int rc = evms_bio_split_record->rc;
+		bio = evms_bio_split_record->original_bio;
+		if (!rc) {
+			set_bit(BIO_UPTODATE, &bio->bi_flags);
+		}
+		mempool_free(evms_bio_split_record, evms_bio_split_record->split_pool);
+		bio_endio(bio, bio->bi_size, rc);
+	}
+
+	return 0;
+}
+
+/**
+ * Convenience macro for initializing the bio split control block.
+ **/
+#define EVMS_SPLIT_CB_INIT(bio, split_rec, b_pool, s_pool) \
+	(split_rec)->rc = 0; \
+	(split_rec)->outstanding_bios = (atomic_t)ATOMIC_INIT(1); \
+	(split_rec)->original_bio = bio; \
+	(split_rec)->bio_pool = b_pool; \
+	(split_rec)->split_pool = s_pool;		
+
+/**
+ * Convenience macro for initializing a new bio.
+ **/
+#define EVMS_BIO_INIT(bio, split_rec) \
+	bio_init(bio); \
+       	(bio)->bi_end_io = evms_bio_collector; \
+	(bio)->bi_private = (split_rec);
+
+/**
+ * evms_bio_vcnt - computes the correct number of bio_vectors needed for a piece of storage
+ * @addr:	virtual address of storage
+ * @size:	size of storage
+ *
+ * Computes the correct number of required bio vectors, with respect to page
+ * size and alignment, for given a memory object starting address and size.
+ *
+ * returns: the count of bio vectors required.
+ **/
+static inline int
+evms_bio_vcnt(ulong addr, int size)
+{
+	int vcnt, offset, lskew, rskew;
+
+	vcnt = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	rskew = size & (PAGE_SIZE - 1);
+	offset = addr & (PAGE_SIZE - 1);
+	lskew = PAGE_SIZE - offset;
+	if (lskew < rskew) {
+		vcnt++;
+	}
+	return vcnt;
+}
+
+/**
+ * evms_cs_split_bio - split a bio into two smaller bios.
+ * @source_bio:		the original bio
+ * @target_size:	the size of the target bio
+ * @target_bio:		the resulting target bio
+ * @remainder_bio:	the bio of the remaining data
+ *
+ * Split the source bio into a target bio, of a specified size, and remainder
+ * bio of the remaining size. The caller can then submit the target bio and if
+ * necessary split the remaining bio down futher with subsequent calls to this
+ * function. This function handles allocating and initializing the target bio
+ * & remainder bios as well as the bio split control block. All split bio's end
+ * io will pass control to the bio collector function which will collect the
+ * end ios until all the splits have completed and will then call the original
+ * bio's end io.
+ *
+ * returns: 0 on sucess, a target bio, a remainder bio
+ *	    error code on error
+ **/
+int
+evms_cs_split_bio(struct bio *source_bio,
+		  u64 target_size,
+		  struct bio **target_bio, struct bio **remainder_bio,
+		  mempool_t *my_bio_pool, mempool_t *my_bio_split_pool)
+{
+	int rc = 0;
+	struct bio_split_cb *evms_bio_split_record = NULL;
+
+	/* 
+	 * validate split target_size
+	 */
+	if (target_size >= source_bio->bi_size) {
+		rc = -EINVAL;
+		LOG_ERROR("error(%d): unable to split bio(size:%d) "
+			  "on specified boundary("PFU64").\n",
+			  rc, source_bio->bi_size, target_size);
+		return rc;
+	}
+
+	/*
+	 * allocate target bio and bio split record if needed
+	 */
+	if (source_bio->bi_end_io != evms_bio_collector) {
+		*target_bio = mempool_alloc(my_bio_pool, GFP_NOIO);
+		evms_bio_split_record =
+		    mempool_alloc(my_bio_split_pool, GFP_NOIO);
+		EVMS_SPLIT_CB_INIT(source_bio, evms_bio_split_record,
+				    my_bio_pool, my_bio_split_pool);
+		EVMS_BIO_INIT(*target_bio, evms_bio_split_record);
+		(*target_bio)->bi_rw = source_bio->bi_rw;
+		(*target_bio)->bi_bdev = source_bio->bi_bdev;
+	} else {
+		*target_bio = source_bio;
+		evms_bio_split_record =
+		    (struct bio_split_cb *) source_bio->bi_private;
+	}
+
+	/*
+	 * allocate remainder bio
+	 */
+	*remainder_bio = mempool_alloc(my_bio_pool, GFP_NOIO);
+	atomic_inc(&evms_bio_split_record->outstanding_bios);
+	EVMS_BIO_INIT(*remainder_bio, evms_bio_split_record);
+	(*remainder_bio)->bi_rw = source_bio->bi_rw;
+	(*remainder_bio)->bi_bdev = source_bio->bi_bdev;
+
+	/*
+	 * build the io vecs for target and remainder
+	 */
+	{
+		int remaining_bytes, i, src_vcnt, cur_vcnt;
+		struct bio_vec *src_io_vec, *cur_io_vec;
+
+		remaining_bytes = target_size;
+		src_io_vec = &source_bio->bi_io_vec[0];
+		cur_io_vec = &(*target_bio)->bi_io_vec[0];
+		src_vcnt = source_bio->bi_vcnt;
+		for (i = cur_vcnt = 0; i < src_vcnt; i++, src_io_vec++) {
+			unsigned int src_len = src_io_vec->bv_len;
+
+			cur_io_vec->bv_offset = src_io_vec->bv_offset;
+			cur_io_vec->bv_page = src_io_vec->bv_page;
+			if ((remaining_bytes <= 0)
+			    || (remaining_bytes > src_len)) {
+				cur_io_vec->bv_len = src_len;
+			} else {
+				unsigned int trg_len = remaining_bytes;
+
+				cur_io_vec->bv_len = remaining_bytes;
+				cur_vcnt++;
+				(*target_bio)->bi_vcnt = cur_vcnt;
+
+				cur_vcnt = remaining_bytes = 0;
+				cur_io_vec = &(*remainder_bio)->bi_io_vec[0];
+				if (!(src_len - trg_len))
+					continue;
+				cur_io_vec->bv_len = src_len - trg_len;
+				cur_io_vec->bv_offset =
+				    src_io_vec->bv_offset + trg_len;
+				cur_io_vec->bv_page = src_io_vec->bv_page;
+			}
+			cur_vcnt++;
+			remaining_bytes -= cur_io_vec->bv_len;
+			cur_io_vec++;
+		}
+		(*remainder_bio)->bi_vcnt = cur_vcnt;
+	}
+	/*
+	 * update the sector and size fields in the
+	 * target and remainder bio.
+	 */
+	(*remainder_bio)->bi_size = source_bio->bi_size - target_size;
+	(*remainder_bio)->bi_sector = source_bio->bi_sector;
+	(*remainder_bio)->bi_sector += target_size >> EVMS_VSECTOR_SIZE_SHIFT;
+	(*target_bio)->bi_size = target_size;
+	(*target_bio)->bi_sector = source_bio->bi_sector;
+
+	return rc;
+}
+
+EXPORT_SYMBOL(evms_cs_split_bio);
+
