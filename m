Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263954AbSJJUPs>; Thu, 10 Oct 2002 16:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSJJUPB>; Thu, 10 Oct 2002 16:15:01 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:27359 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262249AbSJJUFt>; Thu, 10 Oct 2002 16:05:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (6/9) evms.h
Date: Thu, 10 Oct 2002 14:37:29 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014372908.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 6 of the EVMS core driver.

This is the public header file for EVMS. It is included by all of the EVMS
plugins.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/include/linux/evms.h linux-2.5.41-evms/include/linux/evms.h
--- linux-2.5.41/include/linux/evms.h	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/include/linux/evms.h	Thu Oct 10 11:20:25 2002
@@ -0,0 +1,551 @@
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
+
+#ifndef __EVMS_INCLUDED__
+#define __EVMS_INCLUDED__
+
+#include <linux/blkdev.h>
+#include <linux/kdev_t.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/mempool.h>
+
+/**
+ * version info 
+ **/
+#define EVMS_MAJOR_VERSION              1
+#define EVMS_MINOR_VERSION              2
+#define EVMS_PATCHLEVEL_VERSION         0
+
+/**
+ * general defines section
+ **/
+#define MAX_EVMS_VOLUMES                256
+#define EVMS_VOLUME_NAME_SIZE           127
+#define IBM_OEM_ID                      8112
+#define EVMS_INITIAL_CRC                0xFFFFFFFF
+#define EVMS_MAGIC_CRC			0x31415926
+#define EVMS_VSECTOR_SIZE               512
+#define EVMS_VSECTOR_SIZE_SHIFT         9
+
+#define EVMS_DIR_NAME			"evms"
+#define EVMS_DEV_NAME			"block_device"
+#define EVMS_PRIMARY_STRING		"primary"
+#define EVMS_SECONDARY_STRING		"secondary"
+
+/**
+ * kernel logging levels defines 
+ **/
+#define EVMS_INFO_CRITICAL              0
+#define EVMS_INFO_SERIOUS               1
+#define EVMS_INFO_ERROR                 2
+#define EVMS_INFO_WARNING               3
+#define EVMS_INFO_DEFAULT               5
+#define EVMS_INFO_DETAILS               6
+#define EVMS_INFO_DEBUG                 7
+#define EVMS_INFO_EXTRA                 8
+#define EVMS_INFO_ENTRY_EXIT            9
+#define EVMS_INFO_EVERYTHING            10
+
+/**
+ * kernel logging level	variable
+ **/
+extern int evms_info_level;
+
+/**
+ * kernel logging macros
+ **/
+#define evmsLOG(info_level,prspec) { if (evms_info_level >= info_level) printk prspec; }
+#define evmsLOG2(info_level,statement) { if (evms_info_level >= info_level) statement; }
+
+/**
+ * LOG MACROS to make evms log messages 
+ * look much cleaner in the source.
+ **/
+#define EVMS_LOG_PREFIX "evms: "
+#define LOG_CRITICAL(msg, args...)	evmsLOG(EVMS_INFO_CRITICAL,   (KERN_CRIT    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_SERIOUS(msg, args...)	evmsLOG(EVMS_INFO_SERIOUS,    (KERN_ERR     EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_ERROR(msg, args...)		evmsLOG(EVMS_INFO_ERROR,      (KERN_ERR     EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_WARNING(msg, args...)	evmsLOG(EVMS_INFO_WARNING,    (KERN_WARNING EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_DEFAULT(msg, args...)	evmsLOG(EVMS_INFO_DEFAULT,    (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_DETAILS(msg, args...)	evmsLOG(EVMS_INFO_DETAILS,    (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_DEBUG(msg, args...)		evmsLOG(EVMS_INFO_DEBUG,      (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_EXTRA(msg, args...)		evmsLOG(EVMS_INFO_EXTRA,      (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_ENTRY_EXIT(msg, args...)	evmsLOG(EVMS_INFO_ENTRY_EXIT, (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+#define LOG_EVERYTHING(msg, args...)	evmsLOG(EVMS_INFO_EVERYTHING, (KERN_INFO    EVMS_LOG_PREFIX LOG_PREFIX msg, ## args))
+
+/**
+ * Macros to cleanly print 64-bit numbers on both 32-bit and 64-bit machines.
+ * Use these in place of %Ld, %Lu, and %Lx.
+ **/
+#if BITS_PER_LONG > 32
+#define PFD64 "%ld"
+#define PFU64 "%lu"
+#define PFX64 "%lx"
+#else
+#define PFD64 "%Ld"
+#define PFU64 "%Lu"
+#define PFX64 "%Lx"
+#endif
+
+/**
+ * helpful PROCFS macro
+ **/
+#ifdef CONFIG_PROC_FS
+#define PROCPRINT(msg, args...) (sz += sprintf(page + sz, msg, ## args));\
+			if (sz < off)\
+				off -= sz, sz = 0;\
+			else if (sz >= off + count)\
+				goto out
+#endif
+
+/**
+ * PluginID convenience macros
+ *
+ * An EVMS PluginID is a 32-bit number with the following bit positions:
+ * Top 16 bits: OEM identifier. See IBM_OEM_ID.
+ * Next 4 bits: Plugin type identifier. See evms_plugin_code.
+ * Lowest 12 bits: Individual plugin identifier within a given plugin type.
+ **/
+#define SetPluginID(oem, type, id) ((oem << 16) | (type << 12) | id)
+#define GetPluginOEM(pluginid) (pluginid >> 16)
+#define GetPluginType(pluginid) ((pluginid >> 12) & 0xf)
+#define GetPluginID(pluginid) (pluginid & 0xfff)
+
+/**
+ * enum evms_plugin_type - evms plugin types
+ **/
+enum evms_plugin_code {
+	EVMS_NO_PLUGIN = 0,
+	EVMS_DEVICE_MANAGER,
+	EVMS_SEGMENT_MANAGER,
+	EVMS_REGION_MANAGER,
+	EVMS_FEATURE,
+	EVMS_ASSOCIATIVE_FEATURE,
+	EVMS_FILESYSTEM_INTERFACE_MODULE,
+	EVMS_CLUSTER_MANAGER_INTERFACE_MODULE,
+	EVMS_DISTRIBUTED_LOCK_MANAGER_INTERFACE_MODULE
+};
+
+/**
+ * struct evms_version - 
+ * @major:	changes when incompatible difference are introduced
+ * @minor:	changes when additions are made
+ * @patchlevel:	reflects bug level fixes within a particular major/minor pair
+ *
+ * generic versioning info used by EVMS
+ **/
+struct evms_version {
+	u32 major;
+	u32 minor;
+	u32 patchlevel;
+};
+
+/**
+ * struct evms_plugin_header - kernel plugin header record
+ * @id: 			plugin id
+ * @version: 			plugin version
+ * @required_services_version: 	required common services version
+ * @fops: 			table of function operations
+ * @headers:			list member field
+ *
+ * kernel plugin header record
+ **/
+struct evms_plugin_header {
+	u32 id;
+	struct evms_version version;
+	struct evms_plugin_fops *fops;
+	struct list_head headers;
+};
+
+/**
+ * struct evms_feature_header - EVMS generic on-disk header for features
+ * @signature: 			unique magic number
+ * @crc: 			structure's crc
+ * @version: 			feature header version
+ * @engine_version: 		created by this evms engine version
+ * @flags: 			feature characteristics, bit definitions below.
+ * @feature_id: 		indicates which feature this header is describing
+ * @sequence_number: 		describes most recent copy of redundant metadata
+ * @alignment_padding: 		used when objects are moved between different sized devices
+ * @feature_data1_start_lsn: 	object relative start of 1st copy feature data
+ * @feature_data1_size: 	size of 1st copy of feature data
+ * @feature_data2_start_lsn: 	object relative start of 2nd copy feature data
+ * @feature_data2_size: 	size of 2nd copy of feature data
+ * @volume_serial_number: 	unique/persistent volume identifier
+ * @volume_system_id: 		unique/persistent minor number
+ * @object_depth: 		depth of object in volume tree
+ * @object_name: 		object's name
+ * @volume_name: 		volume name object is a part of
+ * @pad: 			padding to make structure be 512 byte aligned
+ *
+ * generic on-disk header used to describe any EVMS feature
+ * NOTE: 2nd copy of feature data is optional, if used set start_lsn to 0.
+ **/
+struct evms_feature_header {
+	u32 signature;
+	u32 crc;
+	struct evms_version version;
+	struct evms_version engine_version;
+	u32 flags;
+	u32 feature_id;
+	u64 sequence_number;
+	u64 alignment_padding;
+	u64 feature_data1_start_lsn;
+	u64 feature_data1_size;
+	u64 feature_data2_start_lsn;
+	u64 feature_data2_size;
+	u64 volume_serial_number;
+	u32 volume_system_id;
+	u32 object_depth;
+	u8 object_name[EVMS_VOLUME_NAME_SIZE + 1];
+	u8 volume_name[EVMS_VOLUME_NAME_SIZE + 1];
+	u8 pad[152];
+};
+
+/**
+ * field evms_feature_header.signature majic number
+ **/
+#define EVMS_FEATURE_HEADER_SIGNATURE           0x54414546	/* FEAT */
+/**
+ * field evms_feature_header.flags defines
+ **/
+#define EVMS_FEATURE_ACTIVE                     (1<<0)
+#define EVMS_FEATURE_VOLUME_COMPLETE            (1<<1)
+#define EVMS_VOLUME_DATA_OBJECT			(1<<16)
+#define EVMS_VOLUME_DATA_STOP			(1<<17)
+/**
+ * struct evms_feature_header version info
+ **/
+#define EVMS_FEATURE_HEADER_MAJOR	3
+#define EVMS_FEATURE_HEADER_MINOR	0
+#define EVMS_FEATURE_HEADER_PATCHLEVEL	0
+
+/**
+ * EVMS specific error codes 
+ **/
+#define EVMS_FEATURE_FATAL_ERROR                257
+#define EVMS_VOLUME_FATAL_ERROR                 258
+#define EVMS_FEATURE_INCOMPLETE_ERROR		259
+
+/**
+ * struct evms_volume_info - exported volume info
+ * @volume_sn: 		unique volume identifier
+ * @volume_minor: 	persistent device minor assigned to this volume
+ * @volume_name: 	persistent name assigned to this volume
+ *
+ * a collection of volume specific info
+ **/
+struct evms_volume_info {
+	u64 volume_sn;
+	u32 volume_minor;
+	u8 volume_name[EVMS_VOLUME_NAME_SIZE + 1];
+};
+
+/**
+ * struct evms_logical_node - generic kernel storage object
+ * @total_vsectors: 	  0 size of this object in 512 byte units
+ * @plugin: 		  8 plugin that created/owns/manages this storage object
+ * @private: 		 12 location for owner to store private info
+ * @flags: 		 16 storage object characteristics (set/used by plugins)
+ *	   		    bit definitions located in evms_common.h
+ * @iflags: 		 20 internal flags (used exclusively by the framework, not for plugins to use/set)
+ *	    		    bit definitions below.
+ * @hardsector_size: 	 24 assumed physical sector size of underlying device
+ * @block_size: 	 28 default block size for this object
+ * @system_id: 		 32 system indicator (set by the segment manager)
+ * @volume_info: 	 36 persistent volume info, used only by EVMS volumes
+ * @feature_header: 	 40 generic on-disk metadata describing any EVMS feature
+ * @next: 		 44 linked list field
+ * @discover:		 48 discover list field
+ * @device:		 56 device list field
+ * @fbottom:		 64 bottom-most feature object list field
+ * @removable:		 72 changed removable media list field
+ * @consumer:		 80 list field for use by the object's consumer
+ * @name: 		 88 storage object name
+ *			216
+ *
+ * generic kernel storage object
+ */
+struct evms_logical_node {
+	u64 total_vsectors;
+	struct evms_plugin_header *plugin;
+	void *private;
+	u32 flags;
+	u32 iflags;
+	int hardsector_size;
+	int block_size;
+	u32 system_id;
+	struct evms_volume_info *volume_info;
+	struct evms_feature_header *feature_header;
+	void *consumer_private;
+	struct list_head consumed;
+	struct list_head produced;
+	struct list_head discover;
+	struct list_head device;
+	struct list_head fbottom;
+	struct list_head removable;
+	u8 name[EVMS_VOLUME_NAME_SIZE + 1];
+};
+
+/**
+ * fields evms_logical_node.flags & evms_logical_volume.flags defines
+ **/
+#define EVMS_FLAGS_WIDTH                   	32
+#define EVMS_VOLUME_FLAG                        (1<<0)
+#define EVMS_VOLUME_PARTIAL_FLAG                (1<<1)
+#define EVMS_VOLUME_PARTIAL			(1<<1)
+#define EVMS_VOLUME_SET_READ_ONLY               (1<<2)
+#define EVMS_VOLUME_READ_ONLY               	(1<<2)
+/**
+ * these bits define volume status 
+ **/
+#define EVMS_MEDIA_CHANGED			(1<<20)
+#define EVMS_DEVICE_UNPLUGGED			(1<<21)
+/**
+ * these bits used for removable status 
+ **/
+#define EVMS_DEVICE_MEDIA_PRESENT		(1<<24)
+#define EVMS_DEVICE_PRESENT			(1<<25)
+#define EVMS_DEVICE_LOCKABLE			(1<<26)
+#define EVMS_DEVICE_REMOVABLE			(1<<27)
+
+/**
+ * fields evms_logical_node.iflags defines
+ **/
+#define EVMS_FEATURE_BOTTOM			(1<<0)
+#define EVMS_TOP_SEGMENT			(1<<1)
+
+/**
+ * macro to obtain a node's name from either EVMS or compatibility volumes
+ **/
+#define EVMS_GET_NODE_NAME(node) 				\
+	((node->flags & EVMS_VOLUME_FLAG) ?			\
+		node->volume_info->volume_name :		\
+		node->name)
+
+/**
+ * macro used to transform to/from userland device handles and device storage object nodes
+ **/
+#define EVMS_HANDLE_KEY         0x0123456789ABCDEF
+#define DEV_HANDLE_TO_NODE(handle) ((struct evms_logical_node *)(unsigned long)((handle) ^ EVMS_HANDLE_KEY))
+#define NODE_TO_DEV_HANDLE(node) (((u64)(unsigned long)(node)) ^ EVMS_HANDLE_KEY)
+
+/**
+ * struct evms_logical_volume - logical volume info
+ * @name: 			logical volume name
+ * @node: 			logical volume storage object
+ * @minor:			device minor assigned to volume
+ * @flags: 			characteristics of logical volume
+ * @quiesced: 			quiesce state info
+ * @vfs_quiesced: 		vfs quiesce state info
+ * @lock:			volume lock state
+ * @requests_in_progress: 	count of in-flight I/Os
+ * @quiesce_wait_queue:		ioctl thread wait queue
+ * @request_wait_queue:		io request wait queue
+ * @gd:				gendisk entry for the volume
+ * @request_queue: 		unique request queue
+ * @request_lock: 		unique request queue lock
+ * @volumes:			list member field
+ *
+ * contains all the fields needed to manage to a logical volume
+ **/
+struct evms_logical_volume {
+	u8 *name;
+	struct evms_logical_node *node;
+	int minor;
+	int flags;
+	int quiesced;
+	int vfs_quiesced;
+	int lock;
+	atomic_t requests_in_progress;
+	wait_queue_head_t quiesce_wait_queue;
+	wait_queue_head_t request_wait_queue;
+	struct gendisk *gd;
+	request_queue_t request_queue;
+	spinlock_t request_lock;
+	struct list_head volumes;
+};
+
+/**
+ * field evms_logical_volume.flags defines 
+ **/
+/**
+ * queued flags bits 
+ **/
+#define EVMS_REQUESTED_DELETE			(1<<5)
+#define EVMS_REQUESTED_QUIESCE			(1<<6)
+#define EVMS_REQUESTED_VFS_QUIESCE		(1<<7)
+/**
+ * this bit indicates corruption 
+ **/
+#define EVMS_VOLUME_CORRUPT			(1<<8)
+/**
+ * these bits define the source of the corruption 
+ **/
+#define EVMS_VOLUME_SOFT_DELETED               	(1<<9)
+#define EVMS_DEVICE_UNAVAILABLE			(1<<10)
+
+/*
+ * The following function table is used for all plugins.
+ */
+/**
+ * struct evms_plugin_fops - evms plugin's table of function operations
+ * @discover: 		volume discovery entry point
+ * @end_discover: 	final discovery entry point
+ * @delete: 		delete volume entry point
+ * @submit_io:		asynchronous read/write entry point
+ * @sync_io: 		synchronous io entry point
+ * @ioctl: 		generic ioctl entry point
+ * @direct_ioctl: 	non-generic ioctl entry point
+ *
+ * evms plugin's table of function operations
+ **/
+struct evms_plugin_fops {
+	int (*discover) (struct list_head *);
+	int (*end_discover) (struct list_head *);
+	int (*delete) (struct evms_logical_node *);
+	void (*submit_io) (struct evms_logical_node *, struct bio *);
+	int (*sync_io) (struct evms_logical_node *, int, u64,
+			u64, void *);
+	int (*ioctl) (struct evms_logical_node *, struct inode *,
+		      struct file *, u32, unsigned long);
+	int (*direct_ioctl) (struct inode *, struct file *,
+			     u32, unsigned long);
+	int (*open) (struct evms_logical_node *,
+		     struct inode *, struct file *);
+	int (*release) (struct evms_logical_node *,
+		      struct inode *, struct file *);
+	int (*check_media_change) (struct evms_logical_node *, kdev_t);
+	int (*revalidate) (struct evms_logical_node *, kdev_t);
+	int (*quiesce) (struct evms_logical_node *, int);
+	int (*get_geo) (struct evms_logical_node *, u64 *, 
+			uint *, uint *, u64 *);
+	int (*device_list) (struct evms_logical_node *, struct list_head *);
+	int (*device_status) (struct evms_logical_node *, int *);
+};
+
+/**
+ * convenience macros to use plugin's fops entry points  
+ **/
+#define DISCOVER(node, list) ((plugin)->fops->discover(list))
+#define END_DISCOVER(node, list) ((plugin)->fops->end_discover(list))
+#define DELETE(node) ((node)->plugin->fops->delete(node))
+#define SUBMIT_IO(node, bio) ((node)->plugin->fops->submit_io(node, bio))
+#define INIT_IO(node, rw_flag, start_sec, num_secs, buf_addr) ((node)->plugin->fops->sync_io(node, rw_flag, start_sec, num_secs, buf_addr))
+#define IOCTL(node, inode, file, cmd, arg) ((node)->plugin->fops->ioctl(node, inode, file, cmd, arg))
+#define DIRECT_IOCTL(plugin, inode, file, cmd, arg)   ((plugin)->fops->direct_ioctl(inode, file, cmd, arg))
+#define OPEN(node, inode, file) ((node)->plugin->fops->open(node, inode, file))
+#define CLOSE(node, inode, file) ((node)->plugin->fops->release(node, inode, file))
+#define CHECK_MEDIA_CHANGE(node, dev) ((node)->plugin->fops->check_media_change(node, dev))
+#define REVALIDATE(node, dev) ((node)->plugin->fops->revalidate(node, dev))
+#define QUIESCE(node, cmd) ((node)->plugin->fops->quiesce(node, cmd))
+#define GET_GEO(node, cyls, heads, sects, start) ((node)->plugin->fops->get_geo(node, cyls, heads, sects, start))
+#define DEVICE_LIST(node, list_head) ((node)->plugin->fops->device_list(node, list_head))
+#define DEVICE_STATUS(node, status) ((node)->plugin->fops->device_status(node, status))
+
+/*
+ * Notes:  
+ *	All of the following kernel thread functions belong to EVMS base.
+ *	These functions were copied from md_core.c
+ */
+#define EVMS_THREAD_WAKEUP 0
+/**
+ * struct evms_thread
+ * @run:	
+ * @data:	
+ * @wqueue:	thread wait queue
+ * @flags:	thread attributes
+ * @event:	event completion
+ * @tsk:	task info
+ * @name:	thread name
+ *
+ * data structure for creating/managing a kernel thread
+ **/
+struct evms_thread {
+	void (*run) (void *data);
+	void *data;
+	wait_queue_head_t wqueue;
+	unsigned long flags;
+	struct completion *event;
+	struct task_struct *tsk;
+	const u8 *name;
+};
+
+/**
+ * struct bio_split_cb - bio split control block structure definition
+ * @rc:
+ * @sector:
+ * @original_bio:
+ * @outstanding_bios:
+ * @pool:
+ *
+ * control block for managing bio splitting
+ **/
+struct bio_split_cb {
+	int rc;
+	u64 sector;
+	struct bio *original_bio;
+	atomic_t outstanding_bios;
+	mempool_t *bio_pool;
+	mempool_t *split_pool;
+};
+
+/**
+ * EVMS (common services) exported functions prototypes 
+ *
+ * since these function names are global, evms_cs_ has been prepended
+ * to each function name, to ensure they do not collide with any
+ * other global functions in the kernel.
+ **/
+#define EVMS_COMMON_SERVICES_MAJOR              0
+#define EVMS_COMMON_SERVICES_MINOR              6
+#define EVMS_COMMON_SERVICES_PATCHLEVEL         0
+
+int evms_cs_check_version(struct evms_version *, struct evms_version *);
+int evms_cs_allocate_logical_node(struct evms_logical_node **);
+void evms_cs_deallocate_volume_info(struct evms_logical_node *);
+void evms_cs_deallocate_logical_node(struct evms_logical_node *);
+int evms_cs_register_plugin(struct evms_plugin_header *);
+int evms_cs_unregister_plugin(struct evms_plugin_header *);
+int evms_cs_kernel_ioctl(struct evms_logical_node *, u32, unsigned long);
+inline unsigned long evms_cs_size_in_vsectors(long long);
+inline int evms_cs_log2(long long);
+u32 evms_cs_calculate_crc(u32, void *, u32);
+int evms_cs_register_for_end_io_notification(void *,
+					     struct bio *,
+					     void *callback_function);
+void evms_cs_signal_event(int);
+struct evms_thread *evms_cs_register_thread(void (*run) (void *),
+					    void *data, const u8 *name);
+void evms_cs_unregister_thread(struct evms_thread *thread);
+void evms_cs_wakeup_thread(struct evms_thread *thread);
+void evms_cs_interrupt_thread(struct evms_thread *thread);
+struct proc_dir_entry *evms_cs_get_evms_proc_dir(void);
+int evms_cs_volume_request_in_progress(kdev_t, int, int *);
+void evms_cs_invalidate_volume(struct evms_logical_node *topmost_node);
+int evms_cs_split_bio(struct bio *, u64, struct bio **, struct bio **,
+		      mempool_t *, mempool_t *);
+
+request_queue_t *evms_find_queue(kdev_t dev);
+
+/* EVMS exported global variables */
+extern struct list_head evms_device_list;
+
+#endif
+
