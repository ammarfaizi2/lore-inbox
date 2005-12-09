Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVLIP3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVLIP3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVLIP3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:29:21 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:24003 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964781AbVLIP3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:29:14 -0500
Date: Fri, 9 Dec 2005 16:29:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 15/17] s390: convert /proc/cio_ignore.
Message-ID: <20051209152909.GP6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 15/17] s390: convert /proc/cio_ignore.

Convert /proc/cio_ignore to a sequential file. This makes multiple
subchannel sets support easier.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/blacklist.c |  124 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 93 insertions(+), 31 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-12-09 14:26:02.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-12-09 14:26:04.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/ctype.h>
 #include <linux/device.h>
 
@@ -279,41 +280,82 @@ blacklist_parse_proc_parameters (char *b
 	s390_redo_validation ();
 }
 
-/* FIXME: These should be real bus ids and not home-grown ones! */
-static int cio_ignore_read (char *page, char **start, off_t off,
-			    int count, int *eof, void *data)
-{
-	const unsigned int entry_size = 18; /* "0.0.ABCD-0.0.EFGH\n" */
-	long devno;
-	int len;
-
-	len = 0;
-	for (devno = off; /* abuse the page variable
-			   * as counter, see fs/proc/generic.c */
-	     devno < __MAX_SUBCHANNEL && len + entry_size < count; devno++) {
-		if (!test_bit(devno, bl_dev))
-			continue;
-		len += sprintf(page + len, "0.0.%04lx", devno);
-		if (test_bit(devno + 1, bl_dev)) { /* print range */
-			while (++devno < __MAX_SUBCHANNEL)
-				if (!test_bit(devno, bl_dev))
-					break;
-			len += sprintf(page + len, "-0.0.%04lx", --devno);
-		}
-		len += sprintf(page + len, "\n");
-	}
+/* Iterator struct for all devices. */
+struct ccwdev_iter {
+	int devno;
+	int in_range;
+};
+
+static void *
+cio_ignore_proc_seq_start(struct seq_file *s, loff_t *offset)
+{
+	struct ccwdev_iter *iter;
+
+	if (*offset > __MAX_SUBCHANNEL)
+		return NULL;
+	iter = kmalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+	memset(iter, 0, sizeof(struct ccwdev_iter));
+	iter->devno = *offset;
+	return iter;
+}
+
+static void
+cio_ignore_proc_seq_stop(struct seq_file *s, void *it)
+{
+	if (!IS_ERR(it))
+		kfree(it);
+}
+
+static void *
+cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
+{
+	struct ccwdev_iter *iter;
+
+	if (*offset > __MAX_SUBCHANNEL)
+		return NULL;
+	iter = (struct ccwdev_iter *)it;
+	iter->devno++;
+	(*offset)++;
+	return iter;
+}
 
-	if (devno < __MAX_SUBCHANNEL)
-		*eof = 1;
-	*start = (char *) (devno - off); /* number of checked entries */
-	return len;
+static int
+cio_ignore_proc_seq_show(struct seq_file *s, void *it)
+{
+	struct ccwdev_iter *iter;
+
+	iter = (struct ccwdev_iter *)it;
+	if (!is_blacklisted(iter->devno))
+		/* Not blacklisted, nothing to output. */
+		return 0;
+	if (!iter->in_range) {
+		/* First device in range. */
+		if ((iter->devno == __MAX_SUBCHANNEL) ||
+		    !is_blacklisted(iter->devno + 1))
+			/* Singular device. */
+			return seq_printf(s, "0.0.%04x\n", iter->devno);
+		iter->in_range = 1;
+		return seq_printf(s, "0.0.%04x-", iter->devno);
+	}
+	if ((iter->devno == __MAX_SUBCHANNEL) ||
+	    !is_blacklisted(iter->devno + 1)) {
+		/* Last device in range. */
+		iter->in_range = 0;
+		return seq_printf(s, "0.0.%04x\n", iter->devno);
+	}
+	return 0;
 }
 
-static int cio_ignore_write(struct file *file, const char __user *user_buf,
-			     unsigned long user_len, void *data)
+static ssize_t
+cio_ignore_write(struct file *file, const char __user *user_buf,
+		 size_t user_len, loff_t *offset)
 {
 	char *buf;
 
+	if (*offset)
+		return -EINVAL;
 	if (user_len > 65536)
 		user_len = 65536;
 	buf = vmalloc (user_len + 1); /* maybe better use the stack? */
@@ -331,6 +373,27 @@ static int cio_ignore_write(struct file 
 	return user_len;
 }
 
+static struct seq_operations cio_ignore_proc_seq_ops = {
+	.start = cio_ignore_proc_seq_start,
+	.stop  = cio_ignore_proc_seq_stop,
+	.next  = cio_ignore_proc_seq_next,
+	.show  = cio_ignore_proc_seq_show,
+};
+
+static int
+cio_ignore_proc_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &cio_ignore_proc_seq_ops);
+}
+
+static struct file_operations cio_ignore_proc_fops = {
+	.open    = cio_ignore_proc_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+	.write   = cio_ignore_write,
+};
+
 static int
 cio_ignore_proc_init (void)
 {
@@ -341,8 +404,7 @@ cio_ignore_proc_init (void)
 	if (!entry)
 		return 0;
 
-	entry->read_proc  = cio_ignore_read;
-	entry->write_proc = cio_ignore_write;
+	entry->proc_fops = &cio_ignore_proc_fops;
 
 	return 1;
 }
