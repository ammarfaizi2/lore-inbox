Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSJJUI4>; Thu, 10 Oct 2002 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSJJUHN>; Thu, 10 Oct 2002 16:07:13 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:57054 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262215AbSJJUDw>; Thu, 10 Oct 2002 16:03:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (3/9) discover.c
Date: Thu, 10 Oct 2002 14:35:29 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014352905.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 3 of the EVMS core driver.

This file provides the code to coordinate volume
discovery among the EVMS plugins.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/drivers/evms/core/discover.c linux-2.5.41-evms/drivers/evms/core/discover.c
--- linux-2.5.41/drivers/evms/core/discover.c	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/discover.c	Thu Oct 10 13:14:27 2002
@@ -0,0 +1,1714 @@
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
+ * Core routines related to volume discovery and activation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blk.h>
+#include <linux/root_dev.h>
+#include <linux/evms.h>
+#include <linux/evms_ioctl.h>
+#include "evms_core.h"
+
+/**
+ * evms_discover_logical_disk - invokes the discover code in each device manager plugin
+ * @disk_list:	ptr to logical disk (storage objects)
+ *
+ * Traverses the list of plugins, passing the disk_list to each
+ * device manager plugin type.
+ **/
+void
+evms_discover_logical_disks(struct list_head *disk_list)
+{
+	struct evms_plugin_header *plugin;
+	LOG_EXTRA("discovering logical disks...\n");
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		if (GetPluginType(plugin->id) == EVMS_DEVICE_MANAGER) {
+			spin_unlock(&plugin_lock);
+			DISCOVER(plugin, disk_list);
+			spin_lock(&plugin_lock);
+		}
+	}
+	spin_unlock(&plugin_lock);
+}
+
+/**
+ * evms_discover_segments - invokes the discover code in each segment manager plugin
+ * @discover_list:	ptr to discover list of storage objects
+ *
+ * Traverses the list of plugins, passing the discover list (list of objects
+ * to be probed) to each segment manager plugin type.
+ *
+ * Plugins claim storage objects by removing them from the discover list.
+ * Objects not claimed are left on the list. Newly created objects are put onto
+ * the list. The segment managers return a positive value indicating the number
+ * of object they put onto the list.
+ *
+ * Since segment managers can be stacked, when a segment manager puts a new
+ * object on the list it also returns a count to this function. If this
+ * function receives a positive count from segment manager, it must rerun
+ * through the entire list of segment managers again to allow each segment
+ * manager to probe the new object(s). Rerunning continues until no segment
+ * manager puts any new objects onto the list.
+ *
+ * Plugins with incomplete objects do not put them on the discover list when
+ * invoked through their discover entry point. However, when the plugin's
+ * end_discover entry point is called, they can then put partial volumes (in
+ * READ-ONLY mode) on to the list.
+ **/
+static void
+evms_discover_segments(struct list_head *discover_list)
+{
+	int rc, done;
+
+	struct evms_plugin_header *plugin;
+	LOG_EXTRA("discovering segments...\n");
+	do {
+		done = 1;
+		spin_lock(&plugin_lock);
+		list_for_each_entry(plugin, &plugin_head, headers) {
+			if (GetPluginType(plugin->id) == EVMS_SEGMENT_MANAGER) {
+				spin_unlock(&plugin_lock);
+				rc = DISCOVER(plugin, discover_list);
+				spin_lock(&plugin_lock);
+				if (rc > 0)
+					done = 0;
+			}
+		}
+		spin_unlock(&plugin_lock);
+	} while (done == 0);
+
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		if (GetPluginType(plugin->id) == EVMS_SEGMENT_MANAGER) {
+			if (plugin->fops->end_discover) {
+				spin_unlock(&plugin_lock);
+				END_DISCOVER(plugin, discover_list);
+				spin_lock(&plugin_lock);
+			}
+		}
+	}
+	spin_unlock(&plugin_lock);
+}
+
+/**
+ * evms_discover_regions - invokes the discover code in each region manager plugin
+ * @dicover_list:	ptr to discover list of storage objects
+ *
+ * Traverses the list of plugins, passing the discover list (list of objects
+ * to be probed) to each region manager plugin type.
+ *
+ * Plugins claim storage objects by removing them from the discover list.
+ * Objects not claimed are left on the list. Newly created objects are put onto
+ * the list. The region managers return a positive value indicating the number
+ * of object they put onto the list.
+ *
+ * Since region managers can be stacked, when a region manager puts a new object
+ * on the list it also returns a count to this function. If this function
+ * receives a positive count from region manager, it must rerun through the
+ * entire list of region managers again to allow each region manager to probe
+ * the new object(s). Rerunning continues until no region manager puts any new
+ * objects onto the list.
+ *
+ * Plugins with incomplete objects do not put them on the discover list when
+ * invoked through their discover entry point. However, when the plugin's
+ * end_discover entry point is called, they can then put partial volumes (in
+ * READ-ONLY mode) on to the list.
+ **/
+static void
+evms_discover_regions(struct list_head *discover_list)
+{
+	int rc, done;
+
+	struct evms_plugin_header *plugin;
+	LOG_EXTRA("discovering regions...\n");
+	do {
+		done = 1;
+		spin_lock(&plugin_lock);
+		list_for_each_entry(plugin, &plugin_head, headers) {
+			if (GetPluginType(plugin->id) == EVMS_REGION_MANAGER) {
+				spin_unlock(&plugin_lock);
+				rc = DISCOVER(plugin, discover_list);
+				spin_lock(&plugin_lock);
+				if (rc > 0)
+					done = 0;
+			}
+		}
+		spin_unlock(&plugin_lock);
+	} while (done == 0);
+
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		if (GetPluginType(plugin->id) == EVMS_REGION_MANAGER) {
+			if (plugin->fops->end_discover) {
+				spin_unlock(&plugin_lock);
+				END_DISCOVER(plugin, discover_list);
+				spin_lock(&plugin_lock);
+			}
+		}
+	}
+	spin_unlock(&plugin_lock);
+}
+
+/**
+ * le_feature_header_to_cpu - convert a feature header struct to native cpu format
+ * @fh:		feature header ptr
+ *
+ * Convert all the feature header fields into cpu native format from the
+ * on-disk Little Endian format. From this point forward all plugins can deal
+ * with feature headers natively.
+ **/
+void
+le_feature_header_to_cpu(struct evms_feature_header *fh)
+{
+	fh->signature = le32_to_cpup(&fh->signature);
+	fh->crc = le32_to_cpup(&fh->crc);
+	fh->version.major = le32_to_cpup(&fh->version.major);
+	fh->version.minor = le32_to_cpup(&fh->version.minor);
+	fh->version.patchlevel = le32_to_cpup(&fh->version.patchlevel);
+	fh->engine_version.major = le32_to_cpup(&fh->engine_version.major);
+	fh->engine_version.minor = le32_to_cpup(&fh->engine_version.minor);
+	fh->engine_version.patchlevel =
+	    le32_to_cpup(&fh->engine_version.patchlevel);
+	fh->flags = le32_to_cpup(&fh->flags);
+	fh->feature_id = le32_to_cpup(&fh->feature_id);
+	fh->sequence_number = le64_to_cpup(&fh->sequence_number);
+	fh->alignment_padding = le64_to_cpup(&fh->alignment_padding);
+	fh->feature_data1_start_lsn =
+	    le64_to_cpup(&fh->feature_data1_start_lsn);
+	fh->feature_data1_size = le64_to_cpup(&fh->feature_data1_size);
+	fh->feature_data2_start_lsn =
+	    le64_to_cpup(&fh->feature_data2_start_lsn);
+	fh->feature_data2_size = le64_to_cpup(&fh->feature_data2_size);
+	fh->volume_serial_number = le64_to_cpup(&fh->volume_serial_number);
+	fh->volume_system_id = le32_to_cpup(&fh->volume_system_id);
+	fh->object_depth = le32_to_cpup(&fh->object_depth);
+}
+
+/**
+ * edef_load_feature_header - load a feature header into memory
+ * @node:	storage object to feature header is read
+ *
+ * load and validate the feature header for a storage object. validation consists
+ * of verifying the signature and crc of the structure. since there is redundant (two)
+ * copies of the feature header, check them both, and select the most recent copy.
+ *
+ * returns: 0 = success
+ *          otherwise error code
+ **/
+static int
+edef_load_feature_header(struct evms_logical_node *node)
+{
+	int i, rc = 0, rc_array[2] = { 0, 0 };
+	ulong size_in_bytes;
+	u64 size_in_sectors, starting_sector = 0;
+	struct evms_feature_header *fh = NULL, *fh1 = NULL, *fh2 = NULL;
+	char *location_name = NULL;
+	struct evms_version version = {
+		EVMS_FEATURE_HEADER_MAJOR,
+		EVMS_FEATURE_HEADER_MINOR,
+		EVMS_FEATURE_HEADER_PATCHLEVEL
+	};
+
+	if (node->feature_header) {
+		return 0;
+	}
+	/* allocate buffers for feature headers */
+	size_in_sectors = evms_cs_size_in_vsectors(sizeof (*fh));
+	size_in_bytes = size_in_sectors << EVMS_VSECTOR_SIZE_SHIFT;
+	fh1 = kmalloc(size_in_bytes, GFP_KERNEL);
+	if (!fh1) {
+		return -ENOMEM;
+	}
+	fh2 = kmalloc(size_in_bytes, GFP_KERNEL);
+	if (!fh2) {
+		kfree(fh1);
+		return -ENOMEM;
+	}
+	for (i = 0; i < 2; i++) {
+		if (i == 0) {
+			starting_sector =
+			    node->total_vsectors - size_in_sectors;
+			fh = fh1;
+			location_name = EVMS_PRIMARY_STRING;
+		} else {
+			starting_sector--;
+			fh = fh2;
+			location_name = EVMS_SECONDARY_STRING;
+		}
+		/* read header into buffer */
+		rc = INIT_IO(node, 0, starting_sector, size_in_sectors, fh);
+		if (rc) {
+			LOG_ERROR("error(%d) probing for %s feature header "
+				  "(at "PFU64") on '%s'.\n", rc, location_name,
+				  starting_sector, node->name);
+			rc_array[i] = rc;
+			continue;
+		}
+		/* validate header signature */
+		if (cpu_to_le32(fh->signature) != EVMS_FEATURE_HEADER_SIGNATURE) {
+			rc_array[i] = -ENODATA;
+			continue;
+		}
+		/* validate header CRC */
+		if (fh->crc != EVMS_MAGIC_CRC) {
+			u32 org_crc, final_crc;
+			org_crc = cpu_to_le32(fh->crc);
+			fh->crc = 0;
+			final_crc =
+			    evms_cs_calculate_crc(EVMS_INITIAL_CRC, fh,
+						  sizeof (*fh));
+			if (final_crc != org_crc) {
+				LOG_ERROR("CRC mismatch error [stored(%x), "
+					  "computed(%x)] in %s feature header "
+					  "(at "PFU64") on '%s'.\n",
+					  org_crc, final_crc, location_name,
+					  starting_sector, node->name);
+				rc_array[i] = -EINVAL;
+				continue;
+			}
+		} else {
+			LOG_WARNING("CRC disabled in %s feature header "
+				    "(at "PFU64") on '%s'.\n", location_name,
+				    starting_sector, node->name);
+		}
+		/* convert the feature header from the
+		 * on-disk format (Little Endian) to
+		 * native cpu format.
+		 */
+		le_feature_header_to_cpu(fh);
+		/* verify the system data version */
+		rc = evms_cs_check_version(&version, &fh->version);
+		if (rc) {
+			LOG_ERROR("error: obsolete version(%d,%d,%d) in %s "
+				  "feature header on '%s'.\n",
+				  fh->version.major, fh->version.minor,
+				  fh->version.patchlevel, location_name,
+				  node->name);
+			rc_array[i] = rc;
+		}
+	}
+	/* analyze return codes from both copies */
+	/* getting same return code for both copies? */
+	if (rc_array[0] == rc_array[1]) {
+		rc = rc_array[0];
+		/* if no errors on both copies,
+		 * check the sequence numbers.
+		 * use the highest sequence number.
+		 */
+		if (!rc) {
+			/* compare sequence numbers */
+			if (fh1->sequence_number == fh2->sequence_number) {
+				fh = fh1;
+			} else {
+				LOG_WARNING("%s feature header sequence number"
+					    "("PFU64") mismatches %s feature "
+					    "header sequence number("PFU64") "
+					    "on '%s'!\n", EVMS_PRIMARY_STRING,
+					    fh1->sequence_number,
+					    EVMS_SECONDARY_STRING,
+					    fh2->sequence_number, node->name);
+				if (fh1->sequence_number > fh2->sequence_number) {
+					fh = fh1;
+					location_name = EVMS_PRIMARY_STRING;
+					/* indicate bad sequence number of secondary */
+					rc_array[1] = -1;
+				} else {
+					fh = fh2;
+					location_name = EVMS_SECONDARY_STRING;
+					/* indicate bad sequence number of primary */
+					rc_array[0] = -1;
+				}
+			}
+		}
+	} else			/* getting different return codes for each copy */
+	/* if either primary or secondary copy is
+	   * valid, use the valid copy.
+	 */ if ((rc_array[0] == 0) || (rc_array[1] == 0)) {
+		char *warn_name = NULL;
+
+		/* indicate success */
+		rc = 0;
+		/* set variables based on which copy is valid */
+		if (rc_array[0] == 0) {
+			/* use primary (rear) copy if its good */
+			fh = fh1;
+			location_name = EVMS_PRIMARY_STRING;
+			warn_name = EVMS_SECONDARY_STRING;
+		} else {
+			/* use secondary (front) copy if its good */
+			fh = fh2;
+			location_name = EVMS_SECONDARY_STRING;
+			warn_name = EVMS_PRIMARY_STRING;
+		}
+		/* warn the user about the invalid copy */
+		LOG_WARNING("warning: error(%d) probing/verifying the %s "
+			    "feature header on '%s'.\n",
+			    rc_array[0] + rc_array[1], warn_name, node->name);
+	} else
+		/* both copies had a different error,
+		 * and one was a fatal error, so
+		 * indicate fatal error.
+		 */
+	if ((rc_array[0] == -EINVAL) || (rc_array[1] == -EINVAL)) {
+		rc = -EINVAL;
+	}
+	/* on error, set fh to NULL */
+	if (rc) {
+		fh = NULL;
+	}
+	/* deallocate metadata buffers appropriately */
+	if (fh != fh2)
+		kfree(fh2);
+	if (fh != fh1)
+		kfree(fh1);
+	/* save validated feature header pointer */
+	if (!rc) {
+		node->feature_header = fh;
+		if (rc_array[0] != rc_array[1]) {
+			LOG_DETAILS("using %s feature header on '%s'.\n",
+				    location_name, node->name);
+		}
+	}
+	/* if no signature found, adjust return code */
+	if (rc == -ENODATA) {
+		rc = 0;
+		LOG_DEBUG("no feature header found on '%s'.\n", node->name);
+	}
+	return rc;
+}
+
+/**
+ * edef_find_first_features - probes potential EVMS bottom-most objects for EVMS metadata.
+ * @discover_list:	ptr to list of storage objects to probe
+ *
+ * probe this list of objects to see if any objects have EVMS metadata on them. this
+ * probe occurs after regions discover has been completed and represents the earlier
+ * point at which EVMS features could be found.
+ *
+ * if a storage object is found to have EVMS metadata, we allocate a volume info structure,
+ * which keeps track of the persistant EVMS volume data (Serial #, minor #, name). this
+ * volume info structure is then shared by all storage objects built off/from this storage
+ * object. 
+ * 
+ * EVMS also has metadata it uses to determine if a region/segment/disk is not to be
+ * exported. if we detect these flags here, we purge the storage object from memory. 
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_find_first_features(struct list_head *discover_list)
+{
+	int rc;
+	struct evms_logical_node *node, *next_node, *tmp_node;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		int found = 0;
+
+		/* check for duplicate pointers
+		 * search for the node in evms fbottom list
+		 */
+		list_for_each_entry(tmp_node, &evms_fbottom_list, fbottom) {
+			if (tmp_node == node) {
+				found = 1;
+				break;
+			}
+		}
+		/* already present? */
+		if (found) {
+			/* yes, already present */
+			LOG_DETAILS("deleting duplicate reference to '%s'.\n",
+				    node->name);
+			/* forgot this node by not adding back
+			 * onto the discover list.
+			 */
+			list_del_init(&node->discover);
+			continue;
+		}
+		/* load the feature header if present */
+		rc = edef_load_feature_header(node);
+		if (rc) {
+			LOG_ERROR("error(%d): reading feature header on '%s'\n",
+				  rc, node->name);
+			list_del_init(&node->discover);
+			DELETE(node);
+			continue;
+		}
+		if (node->feature_header) {
+			/* check for object flag */
+			if (node->feature_header->flags &
+			    EVMS_VOLUME_DATA_OBJECT) {
+				LOG_DEFAULT("object detected, deleting '%s'.\n",
+					    node->name);
+				list_del_init(&node->discover);
+				DELETE(node);
+				continue;
+			}
+			/* check for stop-data flag */
+			if (node->feature_header->flags & EVMS_VOLUME_DATA_STOP) {
+				LOG_DEFAULT("stop data detected, deleting "
+					    "'%s'.\n", node->name);
+				list_del_init(&node->discover);
+				DELETE(node);
+				continue;
+			}
+			/* we have a valid feature header.
+			   * initialize appropriate node fields
+			   * to indicate this.
+			 */
+			node->flags |= EVMS_VOLUME_FLAG;
+			node->iflags |= EVMS_FEATURE_BOTTOM;
+			node->volume_info
+			    = kmalloc(sizeof (struct evms_volume_info),
+				      GFP_KERNEL);
+			if (!node->volume_info) {
+				LOG_ERROR("error(%d): allocating volume info "
+					  "struct, deleting '%s'.\n",
+					  -ENOMEM, node->name);
+				list_del_init(&node->discover);
+				DELETE(node);
+				continue;
+			}
+			/* set up volume
+			   * info struct
+			 */
+			node->volume_info->
+			    volume_sn =
+			    node->feature_header->volume_serial_number;
+			node->volume_info->
+			    volume_minor =
+			    node->feature_header->volume_system_id;
+			strcpy(node->volume_info->
+			       volume_name, node->feature_header->volume_name);
+			/* register(add) node to the bottom feature list */
+			list_add(&node->fbottom, &evms_fbottom_list);
+		}
+	}
+	return 0;
+}
+
+/**
+ * edef_isolate_nodes_ty_type - move storage objects by type from one list to another
+ * @type:     		type of node to move (see defines below)
+ * @src_list:		source list to search
+ * @trg_list:		target list to put matching nodes
+ * @compare32:		32-bit comparison field
+ * @compare64:		64-bit comparison field
+ *
+ * moves storage object nodes by type from one list to another.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+/**
+ * file @type defines
+ **/
+#define ISOLATE_ASSOCIATIVE_FEATURES		0
+#define ISOLATE_COMPATIBILITY_VOLUMES		1
+#define ISOLATE_EVMS_VOLUMES			2
+#define ISOLATE_EVMS_VOLUME_SERIAL_NUMBER	3
+#define ISOLATE_EVMS_NODES_BY_FEATURE_AND_DEPTH	4
+
+static int
+edef_isolate_nodes_by_type(unsigned int type,
+			   struct list_head *src_list,
+			   struct list_head *trg_list,
+			   u32 compare32, u64 compare64)
+{
+	struct evms_logical_node *node, *next_node;
+	int rc = 0, found_node;
+	struct evms_feature_header *fh = NULL;
+
+	list_for_each_entry_safe(node, next_node, src_list, discover) {
+		if (node->feature_header)
+			fh = node->feature_header;
+		found_node = 0;
+		switch (type) {
+		case ISOLATE_ASSOCIATIVE_FEATURES:
+			if (fh) {
+				if (GetPluginType(fh->feature_id) ==
+				    EVMS_ASSOCIATIVE_FEATURE) {
+					found_node = 1;
+				}
+			}
+			break;
+		case ISOLATE_COMPATIBILITY_VOLUMES:
+			if (!(node->flags & EVMS_VOLUME_FLAG)) {
+				found_node = 1;
+			}
+			break;
+		case ISOLATE_EVMS_VOLUMES:
+			if (node->flags & EVMS_VOLUME_FLAG) {
+				found_node = 1;
+			}
+			break;
+			/* EVMS volumes with same serial # */
+		case ISOLATE_EVMS_VOLUME_SERIAL_NUMBER:
+			if (node->volume_info->volume_sn == compare64) {
+				found_node = 1;
+			}
+			break;
+		case ISOLATE_EVMS_NODES_BY_FEATURE_AND_DEPTH:
+			if (fh) {
+				if (fh->object_depth == compare64) {
+					if (fh->feature_id == compare32) {
+						found_node = 1;
+					}
+				}
+			}
+			break;
+		}
+		if (found_node == 1) {
+			list_del_init(&node->discover);
+			list_add(&node->discover, trg_list);
+		}
+	}
+	return rc;
+}
+
+/**
+ * edef_apply_feature - apply a feature to a list of objects 
+ * @node:		object whose plugin's discover function will be invoked
+ * @volume_node_list:	list of potentially associated objects used during discover
+ *
+ * invoke the node's plugin's discover entry point and pass in the list of objects
+ * that can be processed by this plugin.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_apply_feature(struct evms_logical_node *node,
+		   struct list_head *volume_node_list)
+{
+	struct evms_plugin_header *plugin;
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		if (plugin->id == node->feature_header->feature_id) {
+			spin_unlock(&plugin_lock);
+			return DISCOVER(plugin, volume_node_list);
+		}
+	}
+	spin_unlock(&plugin_lock);
+	return -ENOPKG;
+}
+
+/**
+ * edef_get_feature_plugin_header - retrieves the header record for a plugin
+ * @id:	       	the feature or plugin ID
+ * @header:	the returned plugin header record
+ *
+ * retrieve the header record for the specified plugin.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_get_feature_plugin_header(u32 id, struct evms_plugin_header **header)
+{
+	struct evms_plugin_header *plugin;
+	spin_lock(&plugin_lock);
+	list_for_each_entry(plugin, &plugin_head, headers) {
+		if (plugin->id == id) {
+			spin_unlock(&plugin_lock);
+			*header = plugin;
+			return 0;
+		}
+	}
+	spin_unlock(&plugin_lock);
+	LOG_SERIOUS("no plugin loaded for feature id(0x%x)\n", id);
+	return -ENOPKG;
+}
+
+/**
+ * struct evms_volume_build_info - handy struct used during volume create time
+ * @node_count:			count of objects in this pass
+ * @feature_count:		count of unique plugins for the objects in this pass
+ * @associative_feature_count:	count of objects needing associations to continue
+ * @max_depth:			object with max volume depth on this pass
+ * @plugin:			plugin the max depth object requires to continue
+ * @feature_node_list:		list of nodes at max depth requiring @plugin
+ *
+ * handy structure used to track volume building info. updated and reused on each pass.
+ **/
+struct evms_volume_build_info {
+	int node_count;
+	int feature_count;
+	int associative_feature_count;
+	u64 max_depth;
+	struct evms_plugin_header *plugin;
+	struct list_head feature_node_list;
+};
+
+/**
+ * edef_evaluate_volume_node_list - performs one pass on the volume node list
+ * @volume_node_list:	list of nodes to built into a volume
+ * @vbi:		per pass volume build info
+ * @volume_complete:	status flag
+ *
+ *   does:
+ *	1) put all nodes from feature list back on volume list
+ *      2) loads the node's feature headers
+ *      3) counts the node list's entries
+ *      4) builds the feature node list
+ *	5) counts the feature headers for associative features
+ *	6) sets feature count to >1 if >1 features to be processed
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ */
+static int
+edef_evaluate_volume_node_list(struct list_head *volume_node_list,
+			       struct evms_volume_build_info *vbi,
+			       int volume_complete)
+{
+	int rc;
+	struct evms_logical_node *node;
+
+	vbi->node_count =
+	    vbi->feature_count =
+	    vbi->associative_feature_count = vbi->max_depth = 0;
+	vbi->plugin = NULL;
+
+	/* put all feature nodes back on the volume list */
+	rc = edef_isolate_nodes_by_type(ISOLATE_EVMS_VOLUMES,
+					&vbi->feature_node_list,
+					volume_node_list, 0, 0);
+	if (rc) {
+		return rc;
+	}
+	/* load all the feature headers */
+	if (!volume_complete) {
+		list_for_each_entry(node, volume_node_list, discover) {
+			rc = edef_load_feature_header(node);
+			if (rc) {
+				return rc;
+			}
+		}
+	}
+
+	/* find the 1st max depth object:
+	 *   record the depth
+	 *   record the plugin
+	 */
+	list_for_each_entry(node, volume_node_list, discover) {
+		struct evms_plugin_header *plugin;
+		struct evms_feature_header *fh = node->feature_header;
+
+		/* count the nodes */
+		vbi->node_count++;
+
+		/* no feature header found, continue to next node */
+		if (!fh) {
+			continue;
+		}
+		/* check the depth */
+		if (fh->object_depth > vbi->max_depth) {
+			/* record new max depth */
+			vbi->max_depth = fh->object_depth;
+			/* find the plugin header for this feature id */
+			rc = edef_get_feature_plugin_header(fh->feature_id,
+							    &plugin);
+			if (rc) {
+				return rc;
+			}
+			/* check for >1 plugins */
+			if (vbi->plugin != plugin) {
+				vbi->feature_count++;
+				vbi->plugin = plugin;
+			}
+		}
+		/* check for "associative" feature indicator */
+		if (GetPluginType(vbi->plugin->id) == EVMS_ASSOCIATIVE_FEATURE) {
+			vbi->associative_feature_count++;
+		}
+	}
+	/* build a list of max depth nodes for this feature */
+	if (vbi->max_depth) {
+		rc = edef_isolate_nodes_by_type
+		    (ISOLATE_EVMS_NODES_BY_FEATURE_AND_DEPTH, volume_node_list,
+		     &vbi->feature_node_list, vbi->plugin->id, vbi->max_depth);
+		if (rc) {
+			return rc;
+		}
+		if (!vbi->plugin) {
+			return -ENODATA;
+		}
+		if (list_empty(&vbi->feature_node_list)) {
+			return -ENODATA;
+		}
+	}
+	return rc;
+}
+
+/**
+ * edef_check_feature_conditions
+ * @vbi:	volume build info
+ *
+ * This routine verifies the state of volume based on the features
+ * headers and nodes in the current @vbi.
+ */
+static int
+edef_check_feature_conditions(struct evms_volume_build_info *vbi)
+{
+	if (vbi->associative_feature_count) {
+		if (vbi->node_count > 1) {
+			LOG_ERROR("associative ERROR: > 1 nodes(%d) remaining "
+				  "to be processed!\n", vbi->node_count);
+			return -EVMS_VOLUME_FATAL_ERROR;
+		}
+		if (vbi->max_depth != 1) {
+			LOG_ERROR("associative ERROR: associative feature "
+				  "found at node depth("PFU64") != 1!\n",
+				  vbi->max_depth);
+			return -EVMS_VOLUME_FATAL_ERROR;
+		}
+		return -EVMS_ASSOCIATIVE_FEATURE;
+	}
+	if (!vbi->max_depth) {
+		if (vbi->node_count > 1) {
+			LOG_ERROR("max depth ERROR: > 1 nodes(%d) remaining "
+				  "to be processed!\n", vbi->node_count);
+			return -EVMS_VOLUME_FATAL_ERROR;
+		}
+	}
+	if (vbi->max_depth == 1) {
+		if (vbi->feature_count > 1) {
+			LOG_ERROR("max depth 1 ERROR: > 1 features remaining "
+				  "to be processed!\n");
+			return -EVMS_VOLUME_FATAL_ERROR;
+		}
+	}
+	return 0;
+}
+
+/** edef_apply_features
+ * @volume_node_list:	all the objects to be built into a volume
+ *
+ * This routine applies none, one, or more features to an EVMS
+ * volume. The features are applied and verified recursively until the
+ * entire volume has been constructed. Fatal errors result in
+ * all nodes in the volume discovery list being deleted.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ */
+static int
+edef_apply_features(struct list_head *volume_node_list)
+{
+	int rc, done, top_feature_applying;
+	struct evms_volume_build_info vbi;
+
+	INIT_LIST_HEAD(&vbi.feature_node_list);
+	rc = edef_evaluate_volume_node_list(volume_node_list, &vbi, 0);
+
+	/* ensure we don't go into the next loop
+	 * without having a target plugin to
+	 * pass control to.
+	 */
+	if (!rc) {
+		if (!vbi.plugin) {
+			rc = -ENODATA;
+		}
+	}
+
+	/* this loop should ONLY get used when
+	 * there are features to process.
+	 */
+	done = (rc) ? 1 : 0;
+	while (!done) {
+		rc = edef_check_feature_conditions(&vbi);
+		if (rc)
+			break;
+		top_feature_applying = (vbi.max_depth == 1) ? 1 : 0;
+		rc = vbi.plugin->fops->discover(&vbi.feature_node_list);
+		if (!rc) {
+			rc = edef_evaluate_volume_node_list(volume_node_list,
+							    &vbi,
+							    top_feature_applying);
+			if (top_feature_applying == 1) {
+				if (vbi.node_count > 1) {
+					rc = -EVMS_VOLUME_FATAL_ERROR;
+					LOG_ERROR("ERROR: detected > 1 node at "
+						  "volume completion!\n");
+				}
+				done = 1;
+			} else {
+				if (!vbi.plugin) {
+					rc = -EVMS_VOLUME_FATAL_ERROR;
+					LOG_ERROR("ERROR: depth("PFU64"): "
+						  "expected another feature!\n",
+						  vbi.max_depth);
+					done = 1;
+				}
+			}
+		} else {	/* rc != 0 */
+			rc = -EVMS_VOLUME_FATAL_ERROR;
+			done = 1;
+		}
+	}
+	if (rc) {
+		/* put all feature nodes back on the volume list */
+		if (edef_isolate_nodes_by_type(ISOLATE_EVMS_VOLUMES,
+					       &vbi.feature_node_list,
+					       volume_node_list, 0, 0)) {
+			BUG();
+		}
+	}
+	return rc;
+}
+
+/**
+ * edef_delete_node - generic delete an object from a volume node list
+ * @node_list:		the current object list
+ * @node:		the object to be deleted
+ * @return_code:	the error code
+ * @log_text:		logging text
+ *
+ * convenience function to delete an object from a volume list. this generates
+ * the appropriate syslog messages and sets the return code.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_delete_node(struct list_head *node_list,
+		 struct evms_logical_node *node, int return_code,
+		 char *log_text)
+{
+	int rc;
+
+	if (!list_empty(&node->discover)) {
+		list_del_init(&node->discover);
+		LOG_ERROR("%s error(%d): deleting volume(%s), node(%s)\n",
+			  log_text, return_code,
+			  node->volume_info->volume_name, node->name);
+		rc = DELETE(node);
+		if (rc) {
+			LOG_ERROR("error(%d) while deleting node(%s)\n",
+				  rc, node->name);
+		}
+	} else {
+		LOG_WARNING("%s error(%d): node gone, assumed deleted by "
+			    "plugin.\n", log_text, return_code);
+		/* plugin must have cleaned up the node.
+		 * So just reset the return code and leave.
+		 */
+		rc = 0;
+	}
+
+	return rc;
+}
+
+/**
+ * edef_process_evms_volumes - build an EVMS volume from storage objects
+ * @discover_list:		list of all objects being discovered
+ * @associative_feature_list:	returned list of objects required associative features
+ *
+ * groups all evms objects with the same serial number onto a volume list and sends
+ * that list into edef_apply_features. this process is repeated unto all evms volume
+ * serial number groups have been processed. objects representing complete volumes
+ * are put back on the discover list and objects requiring associative processing
+ * are put on an associative feature list.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_process_evms_volumes(struct list_head *discover_list,
+			  struct list_head *associative_feature_list)
+{
+	int rc = 0;
+	struct list_head evms_volumes_list, volume_node_list;
+	struct evms_logical_node *node = NULL;
+	u64 volume_sn;
+
+	INIT_LIST_HEAD(&evms_volumes_list);
+	/* put all EVMS volumes on their own list */
+	rc = edef_isolate_nodes_by_type(ISOLATE_EVMS_VOLUMES,
+					discover_list,
+					&evms_volumes_list, 0, 0);
+
+	/* apply features to each EVMS volume */
+	/* one volume at a time on each pass  */
+	while (!list_empty(&evms_volumes_list)) {
+		node = list_entry(evms_volumes_list.next, struct evms_logical_node, discover);
+		/* put all nodes for one EVMS volume on separate list */
+		INIT_LIST_HEAD(&volume_node_list);
+		volume_sn = node->volume_info->volume_sn;
+		rc = edef_isolate_nodes_by_type
+		    (ISOLATE_EVMS_VOLUME_SERIAL_NUMBER, &evms_volumes_list,
+		     &volume_node_list, 0, volume_sn);
+		if (rc) {
+			break;
+		}
+		/* go apply all the volume features now */
+		rc = edef_apply_features(&volume_node_list);
+		switch (rc) {
+		case 0:	/* SUCCESS */
+			/* remove volume just processed */
+			node = list_entry(volume_node_list.next, struct evms_logical_node, discover);
+			list_del_init(&node->discover);
+			/* put volume on global list */
+			list_add_tail(&node->discover, discover_list);
+			break;
+		case -EVMS_ASSOCIATIVE_FEATURE:
+			/* put all "associative" features on their own list */
+			rc = edef_isolate_nodes_by_type
+			    (ISOLATE_ASSOCIATIVE_FEATURES, &volume_node_list,
+			     associative_feature_list, 0, 0);
+			break;
+		default:	/* FATAL ERROR */
+			/* delete each node remaining in the list */
+			if (!list_empty(&volume_node_list)) {
+				node = list_entry(volume_node_list.next, struct evms_logical_node, discover);
+				LOG_ERROR("encountered fatal error building "
+					  "volume '%s'\n",
+					  node->volume_info->volume_name);
+			}
+			while (!list_empty(&volume_node_list)) {
+				node = list_entry(volume_node_list.next, struct evms_logical_node, discover);
+				edef_delete_node(&volume_node_list,
+						 node, rc, "EVMS feature");
+			}
+			rc = 0;
+			break;
+		}
+		if (rc) {
+			break;
+		}
+	}
+	return rc;
+}
+
+/**
+ * edef_process_associative_volumes - find the associative feature for the objects in this list
+ * @associative_feature_list:	list of objects requiring associative features
+ * @discover_list:		list to put completed volumes object back onto
+ * 
+ * find and apply the appropriate associative feature for the objects on the
+ * associative feature list. if successfully applied, put the resulting completed
+ * volume objects on to the discover list. error result in the volume objects
+ * being deleted.
+ * 
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+static int
+edef_process_associative_volumes(struct list_head *associative_feature_list,
+				 struct list_head *discover_list)
+{
+	int rc = 0;
+	struct evms_logical_node *node, *next_node;
+
+	list_for_each_entry_safe(node, next_node, associative_feature_list, discover) {
+		/* remove this node from associative feature list */
+		list_del_init(&node->discover);
+		rc = edef_load_feature_header(node);
+		if (rc) {
+			edef_delete_node(discover_list, node, rc,
+					 "Associative Feature");
+			continue;
+		}
+		/* put volume on global list */
+		list_add_tail(&node->discover, discover_list);
+		rc = edef_apply_feature(node, discover_list);
+	}
+	return rc;
+}
+
+/**
+ * edef_check_for_incomplete_volumes
+ * @discover_list:	list of post discovery time volume objects
+ *
+ * check to see if any incomplete volumes are left around if so, delete them.
+ * complete volumes should not have feature_headers hanging off them, if we
+ * find any, we know the volume is incomplete.
+ **/
+static void
+edef_check_for_incomplete_volumes(struct list_head *discover_list)
+{
+	struct evms_logical_node *next_node, *node;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		if (node->feature_header) {
+			edef_delete_node(discover_list, node, 0,
+					 "Unexpected feature header");
+		}
+	}
+}
+
+/**
+ * evms_discover_evms_features
+ * @discover_list:	list of objects to discover evms features on
+ *
+ * find EVMS features for nodes on the discover list
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ */
+static int
+evms_discover_evms_features(struct list_head *discover_list)
+{
+	struct list_head associative_feature_list;
+	int rc;
+
+	LOG_EXTRA("discovering evms volume features...\n");
+
+	INIT_LIST_HEAD(&associative_feature_list);
+	rc = edef_find_first_features(discover_list);
+	if (rc) {
+		return rc;
+	}
+	rc = edef_process_evms_volumes(discover_list,
+				       &associative_feature_list);
+	if (rc) {
+		return rc;
+	}
+	rc = edef_process_associative_volumes(&associative_feature_list,
+					      discover_list);
+	if (rc) {
+		return rc;
+	}
+	edef_check_for_incomplete_volumes(discover_list);
+	return 0;
+}
+
+/**
+ * eelv_geninit - initialize a gendisk entry for a volume
+ * @volume:	ptr to new volume
+ * @minor:	minor value of new volume
+ *
+ * This routine initializes a gendisk entry for the specified volume.
+ **/
+static void
+eelv_geninit(struct evms_logical_volume *lv)
+{
+	struct gendisk *gd = lv->gd;
+
+	if (!gd) {
+		gd = alloc_disk();
+		BUG_ON(!gd);
+		lv->gd = gd;
+	}
+
+	gd->major = EVMS_MAJOR;
+	gd->first_minor = lv->minor;
+	snprintf(gd->disk_name, 16, "%s%d", EVMS_DIR_NAME, lv->minor);
+	gd->fops = &evms_fops;
+	set_capacity(gd, lv->node->total_vsectors);
+
+	/* set removable flags as needed */
+	gd->flags = 0;
+	if (lv->flags & EVMS_DEVICE_REMOVABLE) {
+		gd->flags |= GENHD_FL_REMOVABLE;
+	}
+
+	gd->de = devfs_register(evms_dir_devfs_handle,
+				lv->name, DEVFS_FL_DEFAULT,
+				EVMS_MAJOR, lv->minor,
+				S_IFBLK | S_IRUGO | S_IWUGO,
+				&evms_fops, NULL);
+
+	add_disk(gd);
+}
+
+/**
+ * add_logical_volume - adds a newly created logical volume to our list
+ * @lv:		logical volume to be added.
+ *
+ * adds a newly created logical volume to our list.
+ * this function keeps the list ordered by minor
+ * number from low to high.
+ **/
+static void
+add_logical_volume(struct evms_logical_volume *lv)
+{
+	if (list_empty(&evms_logical_volumes)) {
+		list_add(&lv->volumes, &evms_logical_volumes);
+	} else {
+		struct evms_logical_volume *tmpvol;
+		list_for_each_entry(tmpvol, &evms_logical_volumes, volumes) {
+			BUG_ON(tmpvol->minor == lv->minor);
+			if (tmpvol->minor > lv->minor) {
+				break;
+			}
+		}
+		list_add(&lv->volumes, tmpvol->volumes.prev);
+	}
+}
+
+/**
+ * evms_do_request_fn
+ * @q:		request queue
+ **/
+static void
+evms_do_request_fn(request_queue_t * q)
+{
+	LOG_WARNING("This function should not be called.\n");
+}
+
+/**
+ * eelv_assign_volume_minor - assigns a minor number to a volume
+ * @node: 	volume object to process
+ * @minor:	minor device number to assign
+ *
+ * This routine assigns a specific minor number to a volume. It
+ * also performs the remaining steps to make this volume visible
+ * and usable to the kernel.
+ **/
+static void
+eelv_assign_volume_minor(struct evms_logical_node *node, int minor,
+			 struct evms_logical_volume *vol)
+{
+	struct evms_logical_volume *lv = vol;
+
+	if (!lv) {
+		lv = kmalloc(sizeof(struct evms_logical_volume), GFP_KERNEL);
+		BUG_ON(!lv);
+		memset(lv, 0, sizeof(struct evms_logical_volume));
+		lv->requests_in_progress = (atomic_t) ATOMIC_INIT(0);
+	}
+	lv->node = node;
+	lv->name = kmalloc(strlen(EVMS_GET_NODE_NAME(node)) + 1, GFP_KERNEL);
+	BUG_ON(!lv->name);
+	strcpy(lv->name, EVMS_GET_NODE_NAME(node));
+	lv->minor = minor;
+	lv->flags = node->flags;
+	if (lv->flags & EVMS_VOLUME_READ_ONLY) {
+		set_device_ro(mk_kdev(EVMS_MAJOR, minor), 1);
+	}
+
+	/* round volume size down to next hardsector */
+	node->total_vsectors &=
+	    ~((node->hardsector_size >> EVMS_VSECTOR_SIZE_SHIFT) - 1);
+
+	eelv_geninit(lv);
+
+	/* set up the request queue for this volume */
+	lv->requests_in_progress = (atomic_t) ATOMIC_INIT(0);
+	lv->request_lock = SPIN_LOCK_UNLOCKED;
+	if (!vol) {
+		init_waitqueue_head(&lv->quiesce_wait_queue);
+		init_waitqueue_head(&lv->request_wait_queue);
+		blk_init_queue(&lv->request_queue,
+			       evms_do_request_fn,
+			       &lv->request_lock);
+		blk_queue_make_request(&lv->request_queue,
+				       evms_make_request_fn);
+		add_logical_volume(lv);
+	}
+	evms_volumes++;
+	LOG_DEFAULT("Exporting EVMS Volume(%u,%u) from \"%s%s\".\n",
+		    EVMS_MAJOR, minor, EVMS_DIR_NAME "/", lv->name);
+}
+
+/**
+ * eelv_check_for_duplicity
+ * @discover_list: 	list of potential volume objects to export
+ *
+ * This routine compares the serial number in the top most node
+ * in the volume to the list of currently exported volumes. If
+ * this volumes serial number is found in the list then we know
+ * this volume is a duplicate and it is then delete.
+ **/
+static void
+eelv_check_for_duplicity(struct list_head *discover_list)
+{
+	struct evms_logical_node *next_node, *node;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		struct evms_logical_volume *lv = NULL;
+		int is_dup = 0;
+		while ((lv = find_next_volume(lv))) {
+			char *type_ptr = NULL;
+			/* only check exported volumes */
+			if (!lv->node) {
+				continue;
+			}
+			/* check for duplicate pointer */
+			if (node == lv->node) {
+				is_dup = 1;
+				type_ptr = "pointer";
+				/* check for duplicate node */
+			} else if (!strcmp(node->name, lv->node->name)) {
+				is_dup = 1;
+				type_ptr = "node";
+			}
+			if (is_dup == 1) {
+				LOG_DETAILS("deleting duplicate %s to EVMS "
+					    "volume(%u,%u,%s)...\n",
+					    type_ptr, EVMS_MAJOR, lv->minor,
+					    EVMS_GET_NODE_NAME(node));
+				list_del_init(&node->discover);
+				/* forget duplicate */
+				break;
+			}
+		}
+	}
+}
+
+/**
+ * eelv_reassign_soft_deleted_volume_minors
+ * @discover_list: 	list of volume objects to export
+ *
+ * This routine reassigns previous minor numbers to rediscovered "soft"
+ * deleted volumes.
+ **/
+static void
+eelv_reassign_soft_deleted_volume_minors(struct list_head *discover_list)
+{
+	struct evms_logical_node *next_node, *node;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		struct evms_logical_volume *lv = NULL;
+		while ((lv = find_next_volume(lv))) {
+			/* only check soft deleted volumes:
+			 *  they have a non-NULL name.
+			 */
+			if (!(lv->flags & EVMS_VOLUME_SOFT_DELETED)) {
+				continue;
+			}
+			if (strcmp(EVMS_GET_NODE_NAME(node), lv->name)) {
+				continue;
+			}
+			/* reassign requested minor */
+			list_del_init(&node->discover);
+			LOG_DEFAULT("Re");
+			/* free the previously used name */
+			kfree(lv->name);
+			lv->name = NULL;
+			/* clear the EVMS_VOLUME_SOFT_DELETED flag */
+			lv->flags = 0;
+			eelv_assign_volume_minor(node, lv->minor, lv);
+			break;
+		}
+	}
+}
+
+/**
+ * eelv_assign_evms_volume_minors
+ * @discover_list: 	list of volume objects to export
+ *
+ * This routine assigns minor numbers to new evms volumes. If
+ * the specified minor is already in use, the requested minor
+ * is set to 0, and will be assigned next available along with
+ * any remaining volumes at the end of evms_export_logical_volumes.
+ **/
+static void
+eelv_assign_evms_volume_minors(struct list_head *discover_list)
+{
+	struct evms_logical_node *next_node, *node, *lv_node;
+	unsigned int requested_minor, lv_flags;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		/* only process evms volumes */
+		if (!(node->flags & EVMS_VOLUME_FLAG)) {
+			continue;
+		}
+		requested_minor = node->volume_info->volume_minor;
+		/* is there a requested minor? */
+		if (!requested_minor) {
+			continue;
+		}
+		/* check range of requested minor */
+		if (requested_minor >= MAX_EVMS_VOLUMES) {
+			lv_node = node;
+			lv_flags = 0;
+		} else {
+			struct evms_logical_volume *lv;
+			lv_node = NULL;
+			lv_flags = 0;
+			lv = lookup_volume(requested_minor);
+			if (lv) {
+				lv_node = lv->node;
+				lv_flags = lv->flags;
+			}
+		}
+		if (lv_node || (lv_flags & EVMS_VOLUME_SOFT_DELETED)) {
+			LOG_WARNING("EVMS volume(%s) requesting invalid/in-use "
+				    "minor(%d), assigning next available!\n",
+				    node->volume_info->volume_name,
+				    requested_minor);
+			/*
+			 * requested minor is already
+			 * in use, defer assignment
+			 * until later.
+			 */
+			node->volume_info->volume_minor = 0;
+		} else {
+			/* assign requested minor */
+			list_del_init(&node->discover);
+			eelv_assign_volume_minor(node, requested_minor, NULL);
+		}
+	}
+}
+
+/**
+ * find_unused_minor - finds the first unused minor based on the specified direction
+ * @dir:	direction of search (0 = forward, 1 = backward)
+ *
+ * Searches for the first available minor number in the specified search
+ * direction.
+ *
+ * Returns the first available minor number or 0. 0 is reserved for the block
+ * device itself and is therefore never usable for a logical volume.
+ **/
+static int
+find_unused_minor(int dir)
+{
+	int i;
+	if (!dir) {
+		for (i = 1; i < MAX_EVMS_VOLUMES; i++) {
+			if (!lookup_volume(i)) {
+				return i;
+			}
+		}
+	} else {
+		for (i = MAX_EVMS_VOLUMES - 1; i; i--) {
+			if (!lookup_volume(i)) {
+				return i;
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * eelv_assign_remaining_evms_volume_minors
+ * @discover_list: 	list of volume objects to export
+ *
+ * This routine assigns minor numbers to new evms volumes that
+ * have no/conflicting minor assignments. This function will
+ * search from high(255) minor values down, for the first available
+ * minor. Searching high to low minimizes the possibility of
+ * conflicting evms volumes causing "compatibility" minor
+ * assignments to shift from expected assignments.
+ */
+static void
+eelv_assign_remaining_evms_volume_minors(struct list_head *discover_list)
+{
+	struct evms_logical_node *next_node, *node;
+	int minor;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		/* only process evms volumes */
+		/* all remaining evms volumes should now
+		 * have a minor value of 0, meaning they
+		 * had no minor assignment, or their minor
+		 * assignment conflicted with an existing
+		 * minor assignment.
+		 */
+		if (!(node->flags & EVMS_VOLUME_FLAG)) {
+			continue;
+		}
+		list_del_init(&node->discover);
+		/* find next available minor number */
+		minor = find_unused_minor(1);
+		/* check range of assigned minor */
+		if (!minor) {
+			LOG_CRITICAL("no more minor numbers available for "
+				     "evms volumes!!!!\n");
+			DELETE(node);
+		} else {
+			/* assign requested minor */
+			eelv_assign_volume_minor(node, minor, NULL);
+		}
+	}
+}
+
+/**
+ * eelv_assign_remaining_volume_minors
+ * @discover_list: 	list of volume objects to export
+ *
+ * This routine assigns minor numbers to all remaining unassigned
+ * volumes. Minor numbers are assigned on an first availability
+ * basis. The first free minor number is used in the assignment.
+ **/
+static void
+eelv_assign_remaining_volume_minors(struct list_head *discover_list)
+{
+	struct evms_logical_node *node, *next_node;
+	int minor;
+
+	list_for_each_entry_safe(node, next_node, discover_list, discover) {
+		list_del_init(&node->discover);
+		/* find next available minor number */
+		minor = find_unused_minor(0);
+		if (!minor) {
+			LOG_CRITICAL("no more minor numbers available for "
+				     "compatibility volumes!!!!\n");
+			DELETE(node);
+		} else {
+			/* assign minor */
+			eelv_assign_volume_minor(node, minor, NULL);
+		}
+	}
+}
+
+/**
+ * eelv_check_for_unreassign_soft_deleted_volume
+ * @discover_list: 	list of volume objects to export
+ *
+ * This routine reports any "soft deleted" volumes that were not
+ * found after a rediscovery.
+ **/
+static void
+eelv_check_for_unreassign_soft_deleted_volume(void)
+{
+	struct evms_logical_volume *lv, *next_lv;
+
+	next_lv = NULL;
+	while ((lv = find_next_volume_safe(&next_lv))) {
+		/* only check soft deleted volumes:
+		 *  they have a NULL node ptr &
+		 *  they have a non-NULL name.
+		 */
+		if (!(lv->flags & EVMS_VOLUME_SOFT_DELETED)) {
+			continue;
+		}
+		if (is_busy(mk_kdev(EVMS_MAJOR, lv->minor))) {
+			lv->flags |= EVMS_VOLUME_CORRUPT;
+		}
+		LOG_ERROR("error: rediscovery failed to find %smounted "
+			  "'soft deleted' volume(%u,%u,%s)...\n",
+			  ((lv->flags & EVMS_VOLUME_CORRUPT) ? "" : "un"),
+			  EVMS_MAJOR, lv->minor, lv->name);
+		if (lv->flags & EVMS_VOLUME_CORRUPT) {
+			LOG_ERROR("    flagging volume(%u:%u,%s) as CORRUPT!\n",
+				  EVMS_MAJOR, lv->minor, lv->name);
+		} else {
+			LOG_ERROR("    releasing minor(%d) used by "
+				  "volume(%s)!\n", lv->minor, lv->name);
+			/* clear logical volume structure
+			 * for this volume so it may be
+			 * reused.
+			 */
+			blk_cleanup_queue(&lv->request_queue);
+			kfree(lv->name);
+			list_del_init(&lv->volumes);
+			kfree(lv);
+		}
+	}
+}
+
+/**
+ * eelv_unquiesce_volumes - unquiesces all volumes after a rediscover operation
+ *
+ * unquiesces all volumes after a rediscover operation.
+ **/
+static void
+eelv_unquiesce_volumes(void)
+{
+	struct evms_logical_volume *lv = NULL;
+	/* check each volume entry */
+	while((lv = find_next_volume(lv))) {
+		/* is this volume "quiesced" ? */
+		if (!lv->quiesced) {
+			continue;
+		}
+		if (!lv->node) {
+			continue;
+		}
+		/* "unquiesce" it */
+		evms_quiesce_volume(lv, 0, lv->minor, 0);
+	}
+}
+
+/**
+ * evms_export_logical_volumes
+ *
+ * This function is called from evms_discover_volumes. It
+ * check for duplicate volumes, assigns minor values to evms
+ * volumes, and assigns minor values to the remaining volumes.
+ * In addition to assigning minor values to each volume this
+ * function also completes the final steps necessary to allow
+ * the volumes to be using by the operating system.
+ **/
+static void
+evms_export_logical_volumes(struct list_head *discover_list)
+{
+	LOG_EXTRA("exporting EVMS logical volumes...\n");
+
+	eelv_check_for_duplicity(discover_list);
+	eelv_reassign_soft_deleted_volume_minors(discover_list);
+	eelv_assign_evms_volume_minors(discover_list);
+	eelv_assign_remaining_evms_volume_minors(discover_list);
+	eelv_assign_remaining_volume_minors(discover_list);
+	eelv_check_for_unreassign_soft_deleted_volume();
+	eelv_unquiesce_volumes();
+}
+
+/**
+ * edv_populate_discover_list - initially populates the discover list with disk objects
+ * @src_list:		source list for disk objects
+ * @trg_list:		target list for disk objects
+ * @discover_parms:	rediscover ioctl packet
+ *
+ * based on the presence or the contents of the rediscover packet, the discover list
+ * is populated with disk objects. if the @discover_parms == NULL, all disk objects
+ * will be copied to the discover list. if the @discover_parms points to a rediscover
+ * packet, the disks matching the disk handles from in the ioctl packet will be copied
+ * to the discover list.
+ *
+ **/
+static void
+edv_populate_discover_list(struct list_head *src_list,
+			   struct list_head *trg_list,
+			   struct evms_rediscover_pkt *discover_parms)
+{
+	int i, use_all_disks = 0;
+	struct evms_logical_node *node;
+
+	/* if no discover parameters are specified */
+	/* copy ALL the disk nodes into the        */
+	/* discovery list.                         */
+	if ((discover_parms == NULL) ||
+	    (discover_parms->drive_count == REDISCOVER_ALL_DEVICES))
+		use_all_disks = 1;
+
+	/* copy the disk nodes specified in the */
+	/* discover_parms over to a discover list */
+
+	list_for_each_entry(node, &evms_device_list, device) {
+		int move_node;
+		move_node = use_all_disks;
+		if (move_node == 0)
+			/* check the rediscovery array */
+			for (i = 0; i < discover_parms->drive_count; i++) {
+				struct evms_logical_node *disk_node = 
+				    DEV_HANDLE_TO_NODE(discover_parms->
+						       drive_array[i]);
+				if (disk_node == node) {
+					move_node = 1;
+					break;
+				}
+			}
+		/* check to see if we want this node */
+		if (move_node == 1) {
+			if (list_empty(&node->discover)) {
+				list_add_tail(&node->discover, trg_list);
+			}
+		}
+	}
+}
+
+/**
+ * evms_discover_volumes - probe the disks to discover volumes
+ * @discover_parms:	ptr to a rediscover ioctl packet
+ *
+ * perform a rediscover operation. the presence or contents of a rediscover packet
+ * will dictate the scope of the operation.
+ *
+ * returns: 0 = success
+ *	    otherwise error code
+ **/
+int
+evms_discover_volumes(struct evms_rediscover_pkt *discover_parms)
+{
+	struct list_head discover_list;
+
+	INIT_LIST_HEAD(&discover_list);
+	evms_discover_logical_disks(&discover_list);
+	if (!list_empty(&evms_device_list)) {
+		/* move the appropriate disk nodes, based on */
+		/* on the discover parameters, onto the      */
+		/* discover list for the partition managers  */
+		/* to process                                */
+		edv_populate_discover_list(&evms_device_list,
+					   &discover_list, discover_parms);
+	}
+	if (!list_empty(&discover_list)) {
+		evms_discover_segments(&discover_list);
+	}
+	if (!list_empty(&discover_list)) {
+		evms_discover_regions(&discover_list);
+	}
+	if (!list_empty(&discover_list)) {
+		evms_discover_evms_features(&discover_list);
+	}
+	if (!list_empty(&discover_list)) {
+		evms_export_logical_volumes(&discover_list);
+		evms_cs_signal_event(EVMS_EVENT_END_OF_DISCOVERY);
+	}
+	BUG_ON(!list_empty(&discover_list));
+	return 0;
+}
+
+/**
+ * find_root_fs_dev
+ *
+ * If "root=/dev/evms/???" was specified on the kernel command line, and devfs
+ * is not enabled, we need to determine the appropriate minor number for the
+ * specified volume for the root fs.
+ *
+ * This function will never get called if EVMS is built as a module, and
+ * adding the #ifndef MODULE condition prevents having to add an
+ * EXPORT_SYMBOL() somewhere for get_root_device_name.
+ */
+static void
+find_root_fs_dev(void)
+{
+#ifndef MODULE
+	struct evms_logical_volume *lv;
+	char root_name[64] = { 0 };
+	char *name;
+
+	//get_root_device_name(root_name);
+
+	if (!strncmp(root_name, EVMS_DIR_NAME "/", strlen(EVMS_DIR_NAME) + 1)) {
+		name = &root_name[strlen(EVMS_DIR_NAME) + 1];
+		
+		lv = NULL;
+		while ((lv = find_next_volume(lv))) {
+			if (lv->name &&
+			    !strncmp(name, lv->name, strlen(lv->name))) {
+				ROOT_DEV = kdev_val(mk_kdev(EVMS_MAJOR, lv->minor));
+				return;
+			}
+		}
+	}
+#endif
+}
+
+/**
+ * evms_init_discover
+ *
+ * If EVMS is statically built into the kernel, this function will be called
+ * to perform an initial volume discovery.
+ **/
+int __init
+evms_init_discover(void)
+{
+	/* Go find volumes */
+	evms_discover_volumes(NULL);
+
+	/* Check if the root fs is on EVMS */
+	if (MAJOR(ROOT_DEV) == EVMS_MAJOR) {
+		find_root_fs_dev();
+	}
+	return 0;
+}
+
+__initcall(evms_init_discover);
+
