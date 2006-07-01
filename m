Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWGAA3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWGAA3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWGAA3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:29:38 -0400
Received: from web50112.mail.yahoo.com ([206.190.39.149]:11117 "HELO
	web50112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751708AbWGAA3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:29:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wnUbsq1/eA6SluxR32Lp2ZTtVXYYxFB6XsyyZMNuDi4LVOx3RxyWAL7PhzVXxX2/MvlFhg5hrJLxNX1XaswJxGOMGWJcwjqGo8PisxEa9RamGKudjxX0tplUfUIbQ9O4rSQXwiUX89Dk86mX3eH7DrUuoer9OhVf+VtVvhka2sc=  ;
Message-ID: <20060701002936.65377.qmail@web50112.mail.yahoo.com>
Date: Fri, 30 Jun 2006 17:29:35 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH] FIX and enable EDAC sysfs operation
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This patch applies to kernel 2.6.17-mm4  because of previous EDAC patches that have
been placed into the -mm4 tree.

When EDAC was first introduced into the kernel it had a sysfs interface, but due to
some problems it was disabled in 2.6.16 and remained disabled in 2.6.17. 

With feedback, several of the control and attribute files of that interface had some
good constructive feedback. PCI Blacklist/Whitelist was a major set which has design
issues and it has been removed in this patch. Instead of storing PCI broken parity
status in EDAC, it has been moved to the pci_dev structure itself by a previous PCI
patch. A future patch will enable that feature in EDAC by utilizing the pci_dev
info.

The sysfs is now enabled in this patch, with a minimal set of control and attribute
files for examining EDAC state and for enabling/disabling the memory and PCI
operations.

The Documentation for EDAC has also been updated to reflect the new state of EDAC
operation.


Signed-off-by:	Doug Thompson <norsk5@xmisson.com>
---

 Documentation/drivers/edac/edac.txt |  152 +------
 drivers/edac/edac_mc.c              |  689 ++++++++++--------------------------
 2 files changed, 222 insertions(+), 619 deletions(-)


Index: linux-2.6.17.edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/edac_mc.c	2006-06-29 16:53:54.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/edac_mc.c	2006-06-29 16:54:02.000000000 -0600
@@ -1,6 +1,6 @@
 /*
  * edac_mc kernel module
- * (C) 2005 Linux Networx (http://lnxi.com)
+ * (C) 2005, 2006 Linux Networx (http://lnxi.com)
  * This file may be distributed under the terms of the
  * GNU General Public License.
  *
@@ -34,13 +34,8 @@
 #include <asm/edac.h>
 #include "edac_mc.h"
 
-#define EDAC_MC_VERSION "Ver: 2.0.0 " __DATE__
+#define EDAC_MC_VERSION "Ver: 2.0.1 " __DATE__
 
-/* For now, disable the EDAC sysfs code.  The sysfs interface that EDAC
- * presents to user space needs more thought, and is likely to change
- * substantially.
- */
-#define DISABLE_EDAC_SYSFS
 
 #ifdef CONFIG_EDAC_DEBUG
 /* Values of 0 to 4 will generate output */
@@ -65,31 +60,12 @@
 static int panic_on_pci_parity;		/* default no panic on PCI Parity */
 static atomic_t pci_parity_count = ATOMIC_INIT(0);
 
-/* Structure of the whitelist and blacklist arrays */
-struct edac_pci_device_list {
-	unsigned int  vendor;		/* Vendor ID */
-	unsigned int  device;		/* Deviice ID */
-};
-
-#define MAX_LISTED_PCI_DEVICES		32
-
-/* List of PCI devices (vendor-id:device-id) that should be skipped */
-static struct edac_pci_device_list pci_blacklist[MAX_LISTED_PCI_DEVICES];
-static int pci_blacklist_count;
-
-/* List of PCI devices (vendor-id:device-id) that should be scanned */
-static struct edac_pci_device_list pci_whitelist[MAX_LISTED_PCI_DEVICES];
-static int pci_whitelist_count ;
-
-#ifndef DISABLE_EDAC_SYSFS
 static struct kobject edac_pci_kobj; /* /sys/devices/system/edac/pci */
 static struct completion edac_pci_kobj_complete;
-#endif	/* DISABLE_EDAC_SYSFS */
 #endif	/* CONFIG_PCI */
 
 /*  START sysfs data and methods */
 
-#ifndef DISABLE_EDAC_SYSFS
 
 static const char *mem_types[] = {
 	[MEM_EMPTY] = "Empty",
@@ -148,18 +124,10 @@
  * /sys/devices/system/edac/mc;
  *	data structures and methods
  */
-#if 0
-static ssize_t memctrl_string_show(void *ptr, char *buffer)
-{
-	char *value = (char*) ptr;
-	return sprintf(buffer, "%s\n", value);
-}
-#endif
-
 static ssize_t memctrl_int_show(void *ptr, char *buffer)
 {
 	int *value = (int*) ptr;
-	return sprintf(buffer, "%d\n", *value);
+	return sprintf(buffer, "%u\n", *value);
 }
 
 static ssize_t memctrl_int_store(void *ptr, const char *buffer, size_t count)
@@ -225,11 +193,6 @@
 	.store  = _store,					\
 };
 
-/* cwrow<id> attribute f*/
-#if 0
-MEMCTRL_STRING_ATTR(mc_version,EDAC_MC_VERSION,S_IRUGO,memctrl_string_show,NULL);
-#endif
-
 /* csrow<id> control files */
 MEMCTRL_ATTR(panic_on_ue,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
 MEMCTRL_ATTR(log_ue,S_IRUGO|S_IWUSR,memctrl_int_show,memctrl_int_store);
@@ -258,8 +221,6 @@
 	.default_attrs = (struct attribute **) memctrl_attr,
 };
 
-#endif  /* DISABLE_EDAC_SYSFS */
-
 /* Initialize the main sysfs entries for edac:
  *   /sys/devices/system/edac
  *
@@ -269,11 +230,6 @@
  *         !0 FAILURE
  */
 static int edac_sysfs_memctrl_setup(void)
-#ifdef DISABLE_EDAC_SYSFS
-{
-	return 0;
-}
-#else
 {
 	int err=0;
 
@@ -305,7 +261,6 @@
 
 	return err;
 }
-#endif  /* DISABLE_EDAC_SYSFS */
 
 /*
  * MC teardown:
@@ -313,7 +268,6 @@
  */
 static void edac_sysfs_memctrl_teardown(void)
 {
-#ifndef DISABLE_EDAC_SYSFS
 	debugf0("MC: " __FILE__ ": %s()\n", __func__);
 
 	/* Unregister the MC's kobject and wait for reference count to reach
@@ -325,144 +279,9 @@
 
 	/* Unregister the 'edac' object */
 	sysdev_class_unregister(&edac_class);
-#endif  /* DISABLE_EDAC_SYSFS */
 }
 
 #ifdef CONFIG_PCI
-
-#ifndef DISABLE_EDAC_SYSFS
-
-/*
- * /sys/devices/system/edac/pci;
- * 	data structures and methods
- */
-
-struct list_control {
-	struct edac_pci_device_list *list;
-	int *count;
-};
-
-#if 0
-/* Output the list as:  vendor_id:device:id<,vendor_id:device_id> */
-static ssize_t edac_pci_list_string_show(void *ptr, char *buffer)
-{
-	struct list_control *listctl;
-	struct edac_pci_device_list *list;
-	char *p = buffer;
-	int len=0;
-	int i;
-
-	listctl = ptr;
-	list = listctl->list;
-
-	for (i = 0; i < *(listctl->count); i++, list++ ) {
-		if (len > 0)
-			len += snprintf(p + len, (PAGE_SIZE-len), ",");
-
-		len += snprintf(p + len,
-				(PAGE_SIZE-len),
-				"%x:%x",
-				list->vendor,list->device);
-	}
-
-	len += snprintf(p + len,(PAGE_SIZE-len), "\n");
-	return (ssize_t) len;
-}
-
-/**
- *
- * Scan string from **s to **e looking for one 'vendor:device' tuple
- * where each field is a hex value
- *
- * return 0 if an entry is NOT found
- * return 1 if an entry is found
- *	fill in *vendor_id and *device_id with values found
- *
- * In both cases, make sure *s has been moved forward toward *e
- */
-static int parse_one_device(const char **s,const char **e,
-	unsigned int *vendor_id, unsigned int *device_id)
-{
-	const char *runner, *p;
-
-	/* if null byte, we are done */
-	if (!**s) {
-		(*s)++;  /* keep *s moving */
-		return 0;
-	}
-
-	/* skip over newlines & whitespace */
-	if ((**s == '\n') || isspace(**s)) {
-		(*s)++;
-		return 0;
-	}
-
-	if (!isxdigit(**s)) {
-		(*s)++;
-		return 0;
-	}
-
-	/* parse vendor_id */
-	runner = *s;
-
-	while (runner < *e) {
-		/* scan for vendor:device delimiter */
-		if (*runner == ':') {
-			*vendor_id = simple_strtol((char*) *s, (char**) &p, 16);
-			runner = p + 1;
-			break;
-		}
-
-		runner++;
-	}
-
-	if (!isxdigit(*runner)) {
-		*s = ++runner;
-		return 0;
-	}
-
-	/* parse device_id */
-	if (runner < *e) {
-		*device_id = simple_strtol((char*)runner, (char**)&p, 16);
-		runner = p;
-	}
-
-	*s = runner;
-	return 1;
-}
-
-static ssize_t edac_pci_list_string_store(void *ptr, const char *buffer,
-		size_t count)
-{
-	struct list_control *listctl;
-	struct edac_pci_device_list *list;
-	unsigned int vendor_id, device_id;
-	const char *s, *e;
-	int *index;
-
-	s = (char*)buffer;
-	e = s + count;
-	listctl = ptr;
-	list = listctl->list;
-	index = listctl->count;
-	*index = 0;
-
-	while (*index < MAX_LISTED_PCI_DEVICES) {
-		if (parse_one_device(&s,&e,&vendor_id,&device_id)) {
-			list[ *index ].vendor = vendor_id;
-			list[ *index ].device = device_id;
-			(*index)++;
-		}
-
-		/* check for all data consume */
-		if (s >= e)
-			break;
-	}
-
-	return count;
-}
-
-#endif
 static ssize_t edac_pci_int_show(void *ptr, char *buffer)
 {
 	int *value = ptr;
@@ -530,31 +349,6 @@
 	.store  = _store,					\
 };
 
-#if 0
-static struct list_control pci_whitelist_control = {
-	.list = pci_whitelist,
-	.count = &pci_whitelist_count
-};
-
-static struct list_control pci_blacklist_control = {
-	.list = pci_blacklist,
-	.count = &pci_blacklist_count
-};
-
-/* whitelist attribute */
-EDAC_PCI_STRING_ATTR(pci_parity_whitelist,
-	&pci_whitelist_control,
-	S_IRUGO|S_IWUSR,
-	edac_pci_list_string_show,
-	edac_pci_list_string_store);
-
-EDAC_PCI_STRING_ATTR(pci_parity_blacklist,
-	&pci_blacklist_control,
-	S_IRUGO|S_IWUSR,
-	edac_pci_list_string_show,
-	edac_pci_list_string_store);
-#endif
-
 /* PCI Parity control files */
 EDAC_PCI_ATTR(check_pci_parity, S_IRUGO|S_IWUSR, edac_pci_int_show,
 	edac_pci_int_store);
@@ -583,18 +377,11 @@
 	.default_attrs = (struct attribute **) edac_pci_attr,
 };
 
-#endif  /* DISABLE_EDAC_SYSFS */
-
 /**
  * edac_sysfs_pci_setup()
  *
  */
 static int edac_sysfs_pci_setup(void)
-#ifdef DISABLE_EDAC_SYSFS
-{
-	return 0;
-}
-#else
 {
 	int err;
 
@@ -618,16 +405,13 @@
 
 	return err;
 }
-#endif  /* DISABLE_EDAC_SYSFS */
 
 static void edac_sysfs_pci_teardown(void)
 {
-#ifndef DISABLE_EDAC_SYSFS
 	debugf0("%s()\n", __func__);
 	init_completion(&edac_pci_kobj_complete);
 	kobject_unregister(&edac_pci_kobj);
 	wait_for_completion(&edac_pci_kobj_complete);
-#endif
 }
 
 
@@ -757,36 +541,6 @@
 }
 
 /*
- * check_dev_on_list: Scan for a PCI device on a white/black list
- * @list:	an EDAC  &edac_pci_device_list  white/black list pointer
- * @free_index:	index of next free entry on the list
- * @pci_dev:	PCI Device pointer
- *
- * see if list contains the device.
- *
- * Returns:  	0 not found
- *		1 found on list
- */
-static int check_dev_on_list(struct edac_pci_device_list *list,
-		int free_index, struct pci_dev *dev)
-{
-	int i;
-	int rc = 0;     /* Assume not found */
-	unsigned short vendor=dev->vendor;
-	unsigned short device=dev->device;
-
-	/* Scan the list, looking for a vendor/device match */
-	for (i = 0; i < free_index; i++, list++ ) {
-		if ((list->vendor == vendor ) && (list->device == device )) {
-			rc = 1;
-			break;
-		}
-	}
-
-	return rc;
-}
-
-/*
  * pci_dev parity list iterator
  *	Scan the PCI device list for one iteration, looking for SERRORs
  *	Master Parity ERRORS or Parity ERRORs on primary or secondary devices
@@ -800,22 +554,7 @@
 	 * bumped until we are done with it
 	 */
 	while((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		/* if whitelist exists then it has priority, so only scan
-		 * those devices on the whitelist
-		 */
-		if (pci_whitelist_count > 0 ) {
-			if (check_dev_on_list(pci_whitelist,
-					pci_whitelist_count, dev))
-				fn(dev);
-		} else {
-			/*
-			 * if no whitelist, then check if this devices is
-			 * blacklisted
-			 */
-			if (!check_dev_on_list(pci_blacklist,
-					pci_blacklist_count, dev))
-				fn(dev);
-		}
+		fn(dev);
 	}
 }
 
@@ -856,154 +595,101 @@
 
 #else	/* CONFIG_PCI */
 
-static inline void do_pci_parity_check(void)
-{
-	/* no-op */
-}
+/* pre-process these away */
+#define	do_pci_parity_check()
+#define	clear_pci_parity_errors()
+#define	edac_sysfs_pci_teardown()
+#define	edac_sysfs_pci_setup()	(0)
 
-static inline void clear_pci_parity_errors(void)
-{
-	/* no-op */
-}
-
-static void edac_sysfs_pci_teardown(void)
-{
-}
-
-static int edac_sysfs_pci_setup(void)
-{
-	return 0;
-}
 #endif	/* CONFIG_PCI */
 
-#ifndef DISABLE_EDAC_SYSFS
-
-/* EDAC sysfs CSROW data structures and methods */
-
-/* Set of more detailed csrow<id> attribute show/store functions */
-static ssize_t csrow_ch0_dimm_label_show(struct csrow_info *csrow, char *data)
-{
-	ssize_t size = 0;
-
-	if (csrow->nr_channels > 0) {
-		size = snprintf(data, EDAC_MC_LABEL_LEN,"%s\n",
-			csrow->channels[0].label);
-	}
-
-	return size;
-}
+/* EDAC sysfs CSROW data structures and methods
+ */
 
-static ssize_t csrow_ch1_dimm_label_show(struct csrow_info *csrow, char *data)
+/* Set of more default csrow<id> attribute show/store functions */
+static ssize_t csrow_ue_count_show(struct csrow_info *csrow, char *data, int
private)
 {
-	ssize_t size = 0;
-
-	if (csrow->nr_channels > 0) {
-		size = snprintf(data, EDAC_MC_LABEL_LEN, "%s\n",
-			csrow->channels[1].label);
-	}
-
-	return size;
+	return sprintf(data,"%u\n", csrow->ue_count);
 }
 
-static ssize_t csrow_ch0_dimm_label_store(struct csrow_info *csrow,
-		const char *data, size_t size)
+static ssize_t csrow_ce_count_show(struct csrow_info *csrow, char *data, int
private)
 {
-	ssize_t max_size = 0;
-
-	if (csrow->nr_channels > 0) {
-		max_size = min((ssize_t)size,(ssize_t)EDAC_MC_LABEL_LEN-1);
-		strncpy(csrow->channels[0].label, data, max_size);
-		csrow->channels[0].label[max_size] = '\0';
-	}
-
-	return size;
+	return sprintf(data,"%u\n", csrow->ce_count);
 }
 
-static ssize_t csrow_ch1_dimm_label_store(struct csrow_info *csrow,
-		const char *data, size_t size)
+static ssize_t csrow_size_show(struct csrow_info *csrow, char *data, int private)
 {
-	ssize_t max_size = 0;
-
-	if (csrow->nr_channels > 1) {
-		max_size = min((ssize_t)size,(ssize_t)EDAC_MC_LABEL_LEN-1);
-		strncpy(csrow->channels[1].label, data, max_size);
-		csrow->channels[1].label[max_size] = '\0';
-	}
-
-	return max_size;
+	return sprintf(data,"%u\n", PAGES_TO_MiB(csrow->nr_pages));
 }
 
-static ssize_t csrow_ue_count_show(struct csrow_info *csrow, char *data)
+static ssize_t csrow_mem_type_show(struct csrow_info *csrow, char *data, int
private)
 {
-	return sprintf(data,"%u\n", csrow->ue_count);
+	return sprintf(data,"%s\n", mem_types[csrow->mtype]);
 }
 
-static ssize_t csrow_ce_count_show(struct csrow_info *csrow, char *data)
+static ssize_t csrow_dev_type_show(struct csrow_info *csrow, char *data, int
private)
 {
-	return sprintf(data,"%u\n", csrow->ce_count);
+	return sprintf(data,"%s\n", dev_types[csrow->dtype]);
 }
 
-static ssize_t csrow_ch0_ce_count_show(struct csrow_info *csrow, char *data)
+static ssize_t csrow_edac_mode_show(struct csrow_info *csrow, char *data, int
private)
 {
-	ssize_t size = 0;
-
-	if (csrow->nr_channels > 0) {
-		size = sprintf(data,"%u\n", csrow->channels[0].ce_count);
-	}
-
-	return size;
+	return sprintf(data,"%s\n", edac_caps[csrow->edac_mode]);
 }
 
-static ssize_t csrow_ch1_ce_count_show(struct csrow_info *csrow, char *data)
-{
-	ssize_t size = 0;
-
-	if (csrow->nr_channels > 1) {
-		size = sprintf(data,"%u\n", csrow->channels[1].ce_count);
-	}
-
-	return size;
+/* show/store functions for DIMM Label attributes */
+static ssize_t channel_dimm_label_show(struct csrow_info *csrow,
+		char *data, int channel)
+{
+	return snprintf(data, EDAC_MC_LABEL_LEN,"%s",
+			csrow->channels[channel].label);
 }
 
-static ssize_t csrow_size_show(struct csrow_info *csrow, char *data)
+static ssize_t channel_dimm_label_store(struct csrow_info *csrow,
+				const char *data,
+				size_t count,
+				int channel)
 {
-	return sprintf(data,"%u\n", PAGES_TO_MiB(csrow->nr_pages));
-}
+	ssize_t max_size = 0;
 
-static ssize_t csrow_mem_type_show(struct csrow_info *csrow, char *data)
-{
-	return sprintf(data,"%s\n", mem_types[csrow->mtype]);
-}
+	max_size = min((ssize_t)count,(ssize_t)EDAC_MC_LABEL_LEN-1);
+	strncpy(csrow->channels[channel].label, data, max_size);
+	csrow->channels[channel].label[max_size] = '\0';
 
-static ssize_t csrow_dev_type_show(struct csrow_info *csrow, char *data)
-{
-	return sprintf(data,"%s\n", dev_types[csrow->dtype]);
+	return max_size;
 }
 
-static ssize_t csrow_edac_mode_show(struct csrow_info *csrow, char *data)
+/* show function for dynamic chX_ce_count attribute */
+static ssize_t channel_ce_count_show(struct csrow_info *csrow,
+				char *data,
+				int channel)
 {
-	return sprintf(data,"%s\n", edac_caps[csrow->edac_mode]);
+	return sprintf(data, "%u\n", csrow->channels[channel].ce_count);
 }
 
+/* csrow specific attribute structure */
 struct csrowdev_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct csrow_info *,char *);
-	ssize_t (*store)(struct csrow_info *, const char *,size_t);
+	ssize_t (*show)(struct csrow_info *,char *,int);
+	ssize_t (*store)(struct csrow_info *, const char *,size_t,int);
+	int    private;
 };
 
 #define to_csrow(k) container_of(k, struct csrow_info, kobj)
 #define to_csrowdev_attr(a) container_of(a, struct csrowdev_attribute, attr)
 
-/* Set of show/store higher level functions for csrow objects */
-static ssize_t csrowdev_show(struct kobject *kobj, struct attribute *attr,
-		char *buffer)
+/* Set of show/store higher level functions for default csrow attributes */
+static ssize_t csrowdev_show(struct kobject *kobj,
+			struct attribute *attr,
+			char *buffer)
 {
 	struct csrow_info *csrow = to_csrow(kobj);
 	struct csrowdev_attribute *csrowdev_attr = to_csrowdev_attr(attr);
 
 	if (csrowdev_attr->show)
-		return csrowdev_attr->show(csrow, buffer);
-
+		return csrowdev_attr->show(csrow,
+					buffer,
+					csrowdev_attr->private);
 	return -EIO;
 }
 
@@ -1014,8 +700,10 @@
 	struct csrowdev_attribute * csrowdev_attr = to_csrowdev_attr(attr);
 
 	if (csrowdev_attr->store)
-		return csrowdev_attr->store(csrow, buffer, count);
-
+		return csrowdev_attr->store(csrow,
+					buffer,
+					count,
+					csrowdev_attr->private);
 	return -EIO;
 }
 
@@ -1024,69 +712,157 @@
 	.store  = csrowdev_store
 };
 
-#define CSROWDEV_ATTR(_name,_mode,_show,_store)			\
+#define CSROWDEV_ATTR(_name,_mode,_show,_store,_private)	\
 struct csrowdev_attribute attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show   = _show,					\
 	.store  = _store,					\
+	.private = _private,					\
 };
 
-/* cwrow<id>/attribute files */
-CSROWDEV_ATTR(size_mb,S_IRUGO,csrow_size_show,NULL);
-CSROWDEV_ATTR(dev_type,S_IRUGO,csrow_dev_type_show,NULL);
-CSROWDEV_ATTR(mem_type,S_IRUGO,csrow_mem_type_show,NULL);
-CSROWDEV_ATTR(edac_mode,S_IRUGO,csrow_edac_mode_show,NULL);
-CSROWDEV_ATTR(ue_count,S_IRUGO,csrow_ue_count_show,NULL);
-CSROWDEV_ATTR(ce_count,S_IRUGO,csrow_ce_count_show,NULL);
-CSROWDEV_ATTR(ch0_ce_count,S_IRUGO,csrow_ch0_ce_count_show,NULL);
-CSROWDEV_ATTR(ch1_ce_count,S_IRUGO,csrow_ch1_ce_count_show,NULL);
+/* default cwrow<id>/attribute files */
+CSROWDEV_ATTR(size_mb,S_IRUGO,csrow_size_show,NULL,0);
+CSROWDEV_ATTR(dev_type,S_IRUGO,csrow_dev_type_show,NULL,0);
+CSROWDEV_ATTR(mem_type,S_IRUGO,csrow_mem_type_show,NULL,0);
+CSROWDEV_ATTR(edac_mode,S_IRUGO,csrow_edac_mode_show,NULL,0);
+CSROWDEV_ATTR(ue_count,S_IRUGO,csrow_ue_count_show,NULL,0);
+CSROWDEV_ATTR(ce_count,S_IRUGO,csrow_ce_count_show,NULL,0);
 
-/* control/attribute files */
-CSROWDEV_ATTR(ch0_dimm_label,S_IRUGO|S_IWUSR,
-		csrow_ch0_dimm_label_show,
-		csrow_ch0_dimm_label_store);
-CSROWDEV_ATTR(ch1_dimm_label,S_IRUGO|S_IWUSR,
-		csrow_ch1_dimm_label_show,
-		csrow_ch1_dimm_label_store);
-
-/* Attributes of the CSROW<id> object */
-static struct csrowdev_attribute *csrow_attr[] = {
+/* default attributes of the CSROW<id> object */
+static struct csrowdev_attribute *default_csrow_attr[] = {
 	&attr_dev_type,
 	&attr_mem_type,
 	&attr_edac_mode,
 	&attr_size_mb,
 	&attr_ue_count,
 	&attr_ce_count,
-	&attr_ch0_ce_count,
-	&attr_ch1_ce_count,
-	&attr_ch0_dimm_label,
-	&attr_ch1_dimm_label,
 	NULL,
 };
 
-/* No memory to release */
+
+/* possible dynamic channel DIMM Label attribute files */
+CSROWDEV_ATTR(ch0_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		0 );
+CSROWDEV_ATTR(ch1_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		1 );
+CSROWDEV_ATTR(ch2_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		2 );
+CSROWDEV_ATTR(ch3_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		3 );
+CSROWDEV_ATTR(ch4_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		4 );
+CSROWDEV_ATTR(ch5_dimm_label,S_IRUGO|S_IWUSR,
+		channel_dimm_label_show,
+		channel_dimm_label_store,
+		5 );
+
+/* Total possible dynamic DIMM Label attribute file table */
+static struct csrowdev_attribute *dynamic_csrow_dimm_attr[] = {
+		&attr_ch0_dimm_label,
+		&attr_ch1_dimm_label,
+		&attr_ch2_dimm_label,
+		&attr_ch3_dimm_label,
+		&attr_ch4_dimm_label,
+		&attr_ch5_dimm_label
+};
+
+/* possible dynamic channel ce_count attribute files */
+CSROWDEV_ATTR(ch0_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		0 );
+CSROWDEV_ATTR(ch1_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		1 );
+CSROWDEV_ATTR(ch2_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		2 );
+CSROWDEV_ATTR(ch3_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		3 );
+CSROWDEV_ATTR(ch4_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		4 );
+CSROWDEV_ATTR(ch5_ce_count,S_IRUGO|S_IWUSR,
+		channel_ce_count_show,
+		NULL,
+		5 );
+
+/* Total possible dynamic ce_count attribute file table */
+static struct csrowdev_attribute *dynamic_csrow_ce_count_attr[] = {
+		&attr_ch0_ce_count,
+		&attr_ch1_ce_count,
+		&attr_ch2_ce_count,
+		&attr_ch3_ce_count,
+		&attr_ch4_ce_count,
+		&attr_ch5_ce_count
+};
+
+
+#define EDAC_NR_CHANNELS	6
+
+/* Create dynamic CHANNEL files, indexed by 'chan',  under specifed CSROW */
+static int edac_create_channel_files(struct kobject *kobj, int chan)
+{
+	int err=-ENODEV;
+
+	if (chan >= EDAC_NR_CHANNELS)
+		return err;
+
+	/* create the DIMM label attribute file */
+	err = sysfs_create_file(kobj,
+			(struct attribute *) dynamic_csrow_dimm_attr[chan]);
+
+	if (!err) {
+		/* create the CE Count attribute file */
+		err = sysfs_create_file(kobj,
+			(struct attribute *) dynamic_csrow_ce_count_attr[chan]);
+	} else {
+		debugf1("%s()  dimm labels and ce_count files created", __func__);
+	}
+
+	return err;
+}
+
+/* No memory to release for this kobj */
 static void edac_csrow_instance_release(struct kobject *kobj)
 {
 	struct csrow_info *cs;
 
-	debugf1("%s()\n", __func__);
 	cs = container_of(kobj, struct csrow_info, kobj);
 	complete(&cs->kobj_complete);
 }
 
+/* the kobj_type instance for a CSROW */
 static struct kobj_type ktype_csrow = {
 	.release = edac_csrow_instance_release,
 	.sysfs_ops = &csrowfs_ops,
-	.default_attrs = (struct attribute **) csrow_attr,
+	.default_attrs = (struct attribute **) default_csrow_attr,
 };
 
 /* Create a CSROW object under specifed edac_mc_device */
-static int edac_create_csrow_object(struct kobject *edac_mci_kobj,
-		struct csrow_info *csrow, int index)
+static int edac_create_csrow_object(
+		struct kobject *edac_mci_kobj,
+		struct csrow_info *csrow,
+		int index)
 {
 	int err = 0;
+	int chan;
 
-	debugf0("%s()\n", __func__);
 	memset(&csrow->kobj, 0, sizeof(csrow->kobj));
 
 	/* generate ..../edac/mc/mc<id>/csrow<index>   */
@@ -1096,21 +872,27 @@
 
 	/* name this instance of csrow<id> */
 	err = kobject_set_name(&csrow->kobj,"csrow%d",index);
+	if (err)
+		goto error_exit;
 
+	/* Instanstiate the csrow object */
+	err = kobject_register(&csrow->kobj);
 	if (!err) {
-		/* Instanstiate the csrow object */
-		err = kobject_register(&csrow->kobj);
-
-		if (err)
-			debugf0("Failed to register CSROW%d\n",index);
-		else
-			debugf0("Registered CSROW%d\n",index);
+		/* Create the dyanmic attribute files on this csrow,
+		 * namely, the DIMM labels and the channel ce_count
+		 */
+		for (chan = 0; chan < csrow->nr_channels; chan++) {
+			err = edac_create_channel_files(&csrow->kobj,chan);
+			if (err)
+				break;
+		}
 	}
 
+error_exit:
 	return err;
 }
 
-/* sysfs data structures and methods for the MCI kobjects */
+/* default sysfs methods and data structures for the main MCI kobject */
 
 static ssize_t mci_reset_counters_store(struct mem_ctl_info *mci,
 		const char *data, size_t count)
@@ -1136,6 +918,7 @@
 	return count;
 }
 
+/* default attribute files for the MCI object */
 static ssize_t mci_ue_count_show(struct mem_ctl_info *mci, char *data)
 {
 	return sprintf(data,"%d\n", mci->ue_count);
@@ -1161,71 +944,11 @@
 	return sprintf(data,"%ld\n", (jiffies - mci->start_time) / HZ);
 }
 
-static ssize_t mci_mod_name_show(struct mem_ctl_info *mci, char *data)
-{
-	return sprintf(data,"%s %s\n", mci->mod_name, mci->mod_ver);
-}
-
 static ssize_t mci_ctl_name_show(struct mem_ctl_info *mci, char *data)
 {
 	return sprintf(data,"%s\n", mci->ctl_name);
 }
 
-static int mci_output_edac_cap(char *buf, unsigned long edac_cap)
-{
-	char *p = buf;
-	int bit_idx;
-
-	for (bit_idx = 0; bit_idx < 8 * sizeof(edac_cap); bit_idx++) {
-		if ((edac_cap >> bit_idx) & 0x1)
-			p += sprintf(p, "%s ", edac_caps[bit_idx]);
-	}
-
-	return p - buf;
-}
-
-static ssize_t mci_edac_capability_show(struct mem_ctl_info *mci, char *data)
-{
-	char *p = data;
-
-	p += mci_output_edac_cap(p,mci->edac_ctl_cap);
-	p += sprintf(p, "\n");
-	return p - data;
-}
-
-static ssize_t mci_edac_current_capability_show(struct mem_ctl_info *mci,
-		char *data)
-{
-	char *p = data;
-
-	p += mci_output_edac_cap(p,mci->edac_cap);
-	p += sprintf(p, "\n");
-	return p - data;
-}
-
-static int mci_output_mtype_cap(char *buf, unsigned long mtype_cap)
-{
-	char *p = buf;
-	int bit_idx;
-
-	for (bit_idx = 0; bit_idx < 8 * sizeof(mtype_cap); bit_idx++) {
-		if ((mtype_cap >> bit_idx) & 0x1)
-			p += sprintf(p, "%s ", mem_types[bit_idx]);
-	}
-
-	return p - buf;
-}
-
-static ssize_t mci_supported_mem_type_show(struct mem_ctl_info *mci,
-		char *data)
-{
-	char *p = data;
-
-	p += mci_output_mtype_cap(p,mci->mtype_cap);
-	p += sprintf(p, "\n");
-	return p - data;
-}
-
 static ssize_t mci_size_mb_show(struct mem_ctl_info *mci, char *data)
 {
 	int total_pages, csrow_idx;
@@ -1252,6 +975,7 @@
 #define to_mci(k) container_of(k, struct mem_ctl_info, edac_mci_kobj)
 #define to_mcidev_attr(a) container_of(a, struct mcidev_attribute, attr)
 
+/* MCI show/store functions for top most object */
 static ssize_t mcidev_show(struct kobject *kobj, struct attribute *attr,
 		char *buffer)
 {
@@ -1288,31 +1012,21 @@
 	.store  = _store,					\
 };
 
-/* Control file */
+/* default Control file */
 MCIDEV_ATTR(reset_counters,S_IWUSR,NULL,mci_reset_counters_store);
 
-/* Attribute files */
+/* default Attribute files */
 MCIDEV_ATTR(mc_name,S_IRUGO,mci_ctl_name_show,NULL);
-MCIDEV_ATTR(module_name,S_IRUGO,mci_mod_name_show,NULL);
-MCIDEV_ATTR(edac_capability,S_IRUGO,mci_edac_capability_show,NULL);
 MCIDEV_ATTR(size_mb,S_IRUGO,mci_size_mb_show,NULL);
 MCIDEV_ATTR(seconds_since_reset,S_IRUGO,mci_seconds_show,NULL);
 MCIDEV_ATTR(ue_noinfo_count,S_IRUGO,mci_ue_noinfo_show,NULL);
 MCIDEV_ATTR(ce_noinfo_count,S_IRUGO,mci_ce_noinfo_show,NULL);
 MCIDEV_ATTR(ue_count,S_IRUGO,mci_ue_count_show,NULL);
 MCIDEV_ATTR(ce_count,S_IRUGO,mci_ce_count_show,NULL);
-MCIDEV_ATTR(edac_current_capability,S_IRUGO,
-	mci_edac_current_capability_show,NULL);
-MCIDEV_ATTR(supported_mem_type,S_IRUGO,
-	mci_supported_mem_type_show,NULL);
 
 static struct mcidev_attribute *mci_attr[] = {
 	&mci_attr_reset_counters,
-	&mci_attr_module_name,
 	&mci_attr_mc_name,
-	&mci_attr_edac_capability,
-	&mci_attr_edac_current_capability,
-	&mci_attr_supported_mem_type,
 	&mci_attr_size_mb,
 	&mci_attr_seconds_since_reset,
 	&mci_attr_ue_noinfo_count,
@@ -1340,7 +1054,6 @@
 	.default_attrs = (struct attribute **) mci_attr,
 };
 
-#endif  /* DISABLE_EDAC_SYSFS */
 
 #define EDAC_DEVICE_SYMLINK	"device"
 
@@ -1353,11 +1066,6 @@
  *	!0	Failure
  */
 static int edac_create_sysfs_mci_device(struct mem_ctl_info *mci)
-#ifdef DISABLE_EDAC_SYSFS
-{
-	return 0;
-}
-#else
 {
 	int i;
 	int err;
@@ -1369,7 +1077,6 @@
 
 	/* set the name of the mc<id> object */
 	err = kobject_set_name(edac_mci_kobj,"mc%d",mci->mc_idx);
-
 	if (err)
 		return err;
 
@@ -1379,14 +1086,12 @@
 
 	/* register the mc<id> kobject */
 	err = kobject_register(edac_mci_kobj);
-
 	if (err)
 		return err;
 
 	/* create a symlink for the device */
 	err = sysfs_create_link(edac_mci_kobj, &mci->dev->kobj,
 				EDAC_DEVICE_SYMLINK);
-
 	if (err)
 		goto fail0;
 
@@ -1399,7 +1104,6 @@
 		/* Only expose populated CSROWs */
 		if (csrow->nr_pages > 0) {
 			err = edac_create_csrow_object(edac_mci_kobj,csrow,i);
-
 			if (err)
 				goto fail1;
 		}
@@ -1423,14 +1127,12 @@
 	wait_for_completion(&mci->kobj_complete);
 	return err;
 }
-#endif  /* DISABLE_EDAC_SYSFS */
 
 /*
  * remove a Memory Controller instance
  */
 static void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 {
-#ifndef DISABLE_EDAC_SYSFS
 	int i;
 
 	debugf0("%s()\n", __func__);
@@ -1448,7 +1150,6 @@
 	init_completion(&mci->kobj_complete);
 	kobject_unregister(&mci->edac_mci_kobj);
 	wait_for_completion(&mci->kobj_complete);
-#endif  /* DISABLE_EDAC_SYSFS */
 }
 
 /* END OF sysfs data and methods */
Index: linux-2.6.17.edac/Documentation/drivers/edac/edac.txt
===================================================================
--- linux-2.6.17.edac.orig/Documentation/drivers/edac/edac.txt	2006-06-29
16:53:54.000000000 -0600
+++ linux-2.6.17.edac/Documentation/drivers/edac/edac.txt	2006-06-29
16:54:02.000000000 -0600
@@ -35,15 +35,14 @@
 to generate parity.  Some vendors do not do this, and thus the parity bit
 can "float" giving false positives.
 
-The PCI Parity EDAC device has the ability to "skip" known flaky
-cards during the parity scan. These are set by the parity "blacklist"
-interface in the sysfs for PCI Parity. (See the PCI section in the sysfs
-section below.) There is also a parity "whitelist" which is used as
-an explicit list of devices to scan, while the blacklist is a list
-of devices to skip.
+[There are patches in the kernel queue which will allow for storage of
+quirks of PCI devices reporting false parity positives. The 2.6.18
+kernel should have those patches included. When that becomes available,
+then EDAC will be patched to utilize that information to "skip" such
+devices.]
 
-EDAC will have future error detectors that will be added or integrated
-into EDAC in the following list:
+EDAC will have future error detectors that will be integrated with
+EDAC or added to it, in the following list:
 
 	MCE	Machine Check Exception
 	MCA	Machine Check Architecture
@@ -93,22 +92,24 @@
 there currently reside 2 'edac' components:
 
 	mc	memory controller(s) system
-	pci	PCI status system
+	pci	PCI control and status system
 
 
 ============================================================================
 Memory Controller (mc) Model
 
 First a background on the memory controller's model abstracted in EDAC.
-Each mc device controls a set of DIMM memory modules. These modules are
+Each 'mc' device controls a set of DIMM memory modules. These modules are
 laid out in a Chip-Select Row (csrowX) and Channel table (chX). There can
-be multiple csrows and two channels.
+be multiple csrows and multiple channels.
 
 Memory controllers allow for several csrows, with 8 csrows being a typical value.
 Yet, the actual number of csrows depends on the electrical "loading"
 of a given motherboard, memory controller and DIMM characteristics.
 
 Dual channels allows for 128 bit data transfers to the CPU from memory.
+Some newer chipsets allow for more than 2 channels, like Fully Buffered DIMMs
+(FB-DIMMs). The following example will assume 2 channels:
 
 
 		Channel 0	Channel 1
@@ -234,23 +235,15 @@
 	The time period, in milliseconds, for polling for error information.
 	Too small a value wastes resources.  Too large a value might delay
 	necessary handling of errors and might loose valuable information for
-	locating the error.  1000 milliseconds (once each second) is about
-	right for most uses.
+	locating the error.  1000 milliseconds (once each second) is the current
+	default. Systems which require all the bandwidth they can get, may
+	increase this.
 
 	LOAD TIME: module/kernel parameter: poll_msec=[0|1]
 
 	RUN TIME: echo "1000" >/sys/devices/system/edac/mc/poll_msec
 
 
-Module Version read-only attribute file:
-
-	'mc_version'
-
-	The EDAC CORE module's version and compile date are shown here to
-	indicate what EDAC is running.
-
-
-
 ============================================================================
 'mcX' DIRECTORIES
 
@@ -284,35 +277,6 @@
 
 
 
-DIMM capability attribute file:
-
-	'edac_capability'
-
-	The EDAC (Error Detection and Correction) capabilities/modes of
-	the memory controller hardware.
-
-
-DIMM Current Capability attribute file:
-
-	'edac_current_capability'
-
-	The EDAC capabilities available with the hardware
-	configuration.  This may not be the same as "EDAC capability"
-	if the correct memory is not used.  If a memory controller is
-	capable of EDAC, but DIMMs without check bits are in use, then
-	Parity, SECDED, S4ECD4ED capabilities will not be available
-	even though the memory controller might be capable of those
-	modes with the proper memory loaded.
-
-
-Memory Type supported on this controller attribute file:
-
-	'supported_mem_type'
-
-	This attribute file displays the memory type, usually
-	buffered and unbuffered DIMMs.
-
-
 Memory Controller name attribute file:
 
 	'mc_name'
@@ -321,16 +285,6 @@
 	that is being utilized.
 
 
-Memory Controller Module name attribute file:
-
-	'module_name'
-
-	This attribute file displays the memory controller module name,
-	version and date built.  The name of the memory controller
-	hardware - some drivers work with multiple controllers and
-	this field shows which hardware is present.
-
-
 Total memory managed by this memory controller attribute file:
 
 	'size_mb'
@@ -432,6 +386,9 @@
 
 	This attribute file will display what type of memory is currently
 	on this csrow. Normally, either buffered or unbuffered memory.
+	Examples:
+		Registered-DDR
+		Unbuffered-DDR
 
 
 EDAC Mode of operation attribute file:
@@ -446,8 +403,13 @@
 
 	'dev_type'
 
-	This attribute file will display what type of DIMM device is
-	being utilized. Example:  x4
+	This attribute file will display what type of DRAM device is
+	being utilized on this DIMM.
+	Examples:
+		x1
+		x2
+		x4
+		x8
 
 
 Channel 0 CE Count attribute file:
@@ -522,10 +484,10 @@
 If logging for UEs and CEs are enabled then system logs will have
 error notices indicating errors that have been detected:
 
-MC0: CE page 0x283, offset 0xce0, grain 8, syndrome 0x6ec3, row 0,
+EDAC MC0: CE page 0x283, offset 0xce0, grain 8, syndrome 0x6ec3, row 0,
 channel 1 "DIMM_B1": amd76x_edac
 
-MC0: CE page 0x1e5, offset 0xfb0, grain 8, syndrome 0xb741, row 0,
+EDAC MC0: CE page 0x1e5, offset 0xfb0, grain 8, syndrome 0xb741, row 0,
 channel 1 "DIMM_B1": amd76x_edac
 
 
@@ -610,64 +572,4 @@
 
 
 
-PCI Device Whitelist:
-
-	'pci_parity_whitelist'
-
-	This control file allows for an explicit list of PCI devices to be
-	scanned for parity errors. Only devices found on this list will
-	be examined.  The list is a line of hexadecimal VENDOR and DEVICE
-	ID tuples:
-
-	1022:7450,1434:16a6
-
-	One or more can be inserted, separated by a comma.
-
-	To write the above list doing the following as one command line:
-
-	echo "1022:7450,1434:16a6"
-		> /sys/devices/system/edac/pci/pci_parity_whitelist
-
-
-
-	To display what the whitelist is, simply 'cat' the same file.
-
-
-PCI Device Blacklist:
-
-	'pci_parity_blacklist'
-
-	This control file allows for a list of PCI devices to be
-	skipped for scanning.
-	The list is a line of hexadecimal VENDOR and DEVICE ID tuples:
-
-	1022:7450,1434:16a6
-
-	One or more can be inserted, separated by a comma.
-
-	To write the above list doing the following as one command line:
-
-	echo "1022:7450,1434:16a6"
-		> /sys/devices/system/edac/pci/pci_parity_blacklist
-
-
-	To display what the whitelist currently contains,
-	simply 'cat' the same file.
-
 =======================================================================
-
-PCI Vendor and Devices IDs can be obtained with the lspci command. Using
-the -n option lspci will display the vendor and device IDs. The system
-administrator will have to determine which devices should be scanned or
-skipped.
-
-
-
-The two lists (white and black) are prioritized. blacklist is the lower
-priority and will NOT be utilized when a whitelist has been set.
-Turn OFF a whitelist by an empty echo command:
-
-	echo > /sys/devices/system/edac/pci/pci_parity_whitelist
-
-and any previous blacklist will be utilized.
-
