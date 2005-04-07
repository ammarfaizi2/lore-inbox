Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVDGJs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVDGJs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDGJs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:48:56 -0400
Received: from mx1.suse.de ([195.135.220.2]:58329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262408AbVDGJq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:46:28 -0400
Message-ID: <42550173.1040503@suse.de>
Date: Thu, 07 Apr 2005 11:46:27 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH] Use proper seq_file api for /proc/scsi/scsi
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030500070906010809030006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030500070906010809030006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi all,

/proc/scsi/scsi currently has a very dumb implementation of the seq_file
api which causes 'cat /proc/scsi/scsi' to return with -ENOMEM when a
large amount of devices are connected.

This patch impelements the proper seq_file interface which prints out
all devices sequentially.
The use of 'get_device()/put_device()' is interesting, as it relies on
->show being called after a successful call to ->start / ->next.
But the current seq_file implementation does it that way; and using
->stop doesn't quite work as it's end up being called several times for
no appearent reason.

But I'm all ears for a better solution.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------030500070906010809030006
Content-Type: text/plain;
 name="scsi-use-seq_file-for-proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-use-seq_file-for-proc.patch"

From: Hannes Reinecke <hare@suse.de>
Subject: cat /proc/scsi/scsi crashes with 'out of memory'
Reference: 75899

'cat /proc/scsi/scsi' returns 'out of memory' when a large number of devices
is connected. This is due to the use of the simple interface into seq_file
which tries to allocate a buffer holding _all_ devices.

This patch converts the proc interface to use the seq_file API properly.

Signed-off-by: Hannes Reinecke <hare@suse.de>

--- linux-2.6.5/drivers/scsi/scsi_proc.c.orig	2004-04-04 05:36:17.000000000 +0200
+++ linux-2.6.5/drivers/scsi/scsi_proc.c	2005-04-07 11:08:16.877718912 +0200
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/blkdev.h>
 #include <linux/seq_file.h>
+#include <linux/list.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi_host.h>
@@ -141,10 +142,90 @@ void scsi_proc_host_rm(struct Scsi_Host 
 	remove_proc_entry(name, shost->hostt->proc_dir);
 }
 
-static int proc_print_scsidevice(struct device *dev, void *data)
+/*
+ * Simple selector for the next device in list.
+ * We take a reference on the current device to
+ * avoid it having vanished underneath us.
+ */
+static int proc_print_sdev_select( struct device *d, void *p)
+{
+	struct device **t = p;
+	struct list_head *l;
+
+	if (!*t) {
+		get_device(d);
+		*t = d;
+		return 1;
+	}
+
+	l = &((*t)->bus_list);
+	if (list_entry(l->next, struct device, bus_list) == d ) {
+		get_device(d);
+		*t = d;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * seq_file interface
+ * The iterator is of type 'struct device *' and points to the
+ * current device. A reference to the current device is taken
+ * by the selector function above and must be dropped during
+ * the show function.
+ */
+static void *proc_print_sdev_start(struct seq_file *s, loff_t *pos)
+{
+	struct device *d = NULL;
+
+	if (*pos != 0)
+		return NULL;
+
+	seq_printf(s, "Attached devices:\n");
+
+	if ( bus_for_each_dev(&scsi_bus_type, NULL, &d,
+			      proc_print_sdev_select) > 0 )
+		return d;
+
+	return NULL;
+}
+
+/*
+ * fetch next device.
+ * We don't actually need the pos argument but seq_file is unhappy
+ * without it.
+ */
+static void *proc_print_sdev_next(struct seq_file *s, void *p, loff_t *pos)
+{
+	struct device *d = p;
+
+	(*pos)++;
+
+	if ( bus_for_each_dev(&scsi_bus_type, p, &d,
+			      proc_print_sdev_select) > 0 )
+		return d;
+
+	return NULL;
+}
+
+/*
+ * Stop device iteration.
+ * Nothing to be done here.
+ */
+static void proc_print_sdev_stop(struct seq_file *s, void *p)
+{
+	return;
+}
+
+/*
+ * Show selected device.
+ * We have to dereference the device here.
+ */
+static int proc_print_sdev_show(struct seq_file *s, void *p)
 {
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct seq_file *s = data;
+	struct device *d = p;
+	struct scsi_device *sdev = to_scsi_device(d);
 	int i;
 
 	seq_printf(s,
@@ -186,9 +267,18 @@ static int proc_print_scsidevice(struct 
 	else
 		seq_printf(s, "\n");
 
+	put_device(d);
+
 	return 0;
 }
 
+struct seq_operations scsi_proc_print_op = {
+	.start	= proc_print_sdev_start,
+	.next	= proc_print_sdev_next,
+	.stop	= proc_print_sdev_stop,
+	.show	= proc_print_sdev_show
+};
+
 static int scsi_add_single_device(uint host, uint channel, uint id, uint lun)
 {
 	struct Scsi_Host *shost;
@@ -283,20 +373,13 @@ static ssize_t proc_scsi_write(struct fi
 	return err;
 }
 
-static int proc_scsi_show(struct seq_file *s, void *p)
-{
-	seq_printf(s, "Attached devices:\n");
-	bus_for_each_dev(&scsi_bus_type, NULL, s, proc_print_scsidevice);
-	return 0;
-}
-
 static int proc_scsi_open(struct inode *inode, struct file *file)
 {
 	/*
 	 * We don't really needs this for the write case but it doesn't
 	 * harm either.
 	 */
-	return single_open(file, proc_scsi_show, NULL);
+	return seq_open(file, &scsi_proc_print_op);
 }
 
 static struct file_operations proc_scsi_operations = {
@@ -304,7 +387,7 @@ static struct file_operations proc_scsi_
 	.read		= seq_read,
 	.write		= proc_scsi_write,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= seq_release,
 };
 
 int __init scsi_init_procfs(void)

--------------030500070906010809030006--
