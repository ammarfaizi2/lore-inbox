Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275282AbTHSB0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHSBY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:24:27 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:62219 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S275276AbTHSBXx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:23:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1061256231526@movementarian.org>
Subject: [PATCH 2/3] OProfile: export kernel pointer size in oprofilefs
In-Reply-To: <10612562312671@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 19 Aug 2003 02:23:51 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19ovE0-000BdQ-4a*jHkeMMjSIgA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tell user-space how big kernel pointers are, as preferable to sniffing /proc/kcore.
Improve the oprofilefs_ulong_to_user() prototype.

diff -X dontdiff -Naur linux-cvs/drivers/oprofile/oprofile_files.c linux-fixes/drivers/oprofile/oprofile_files.c
--- linux-cvs/drivers/oprofile/oprofile_files.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-fixes/drivers/oprofile/oprofile_files.c	2003-08-14 19:19:05.000000000 +0100
@@ -19,6 +19,17 @@
 unsigned long fs_buffer_watershed = 32768; /* FIXME: tune */
 
  
+static ssize_t pointer_size_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	return oprofilefs_ulong_to_user((unsigned long)sizeof(void *), buf, count, offset);
+}
+
+
+static struct file_operations pointer_size_fops = {
+	.read		= pointer_size_read,
+};
+
+
 static ssize_t cpu_type_read(struct file * file, char * buf, size_t count, loff_t * offset)
 {
 	return oprofilefs_str_to_user(oprofile_ops->cpu_type, buf, count, offset);
@@ -32,7 +43,7 @@
  
 static ssize_t enable_read(struct file * file, char * buf, size_t count, loff_t * offset)
 {
-	return oprofilefs_ulong_to_user(&oprofile_started, buf, count, offset);
+	return oprofilefs_ulong_to_user(oprofile_started, buf, count, offset);
 }
 
 
@@ -85,6 +96,7 @@
 	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
 	oprofilefs_create_ulong(sb, root, "cpu_buffer_size", &fs_cpu_buffer_size);
 	oprofilefs_create_file(sb, root, "cpu_type", &cpu_type_fops); 
+	oprofilefs_create_file(sb, root, "pointer_size", &pointer_size_fops);
 	oprofile_create_stats_files(sb, root);
 	if (oprofile_ops->create_files)
 		oprofile_ops->create_files(sb, root);
diff -X dontdiff -Naur linux-cvs/drivers/oprofile/oprofilefs.c linux-fixes/drivers/oprofile/oprofilefs.c
--- linux-cvs/drivers/oprofile/oprofilefs.c	2003-05-26 02:04:50.000000000 +0100
+++ linux-fixes/drivers/oprofile/oprofilefs.c	2003-08-14 19:21:16.000000000 +0100
@@ -69,7 +69,7 @@
 
 #define TMPBUFSIZE 50
 
-ssize_t oprofilefs_ulong_to_user(unsigned long * val, char * buf, size_t count, loff_t * offset)
+ssize_t oprofilefs_ulong_to_user(unsigned long val, char * buf, size_t count, loff_t * offset)
 {
 	char tmpbuf[TMPBUFSIZE];
 	size_t maxlen;
@@ -78,7 +78,7 @@
 		return 0;
 
 	spin_lock(&oprofilefs_lock);
-	maxlen = snprintf(tmpbuf, TMPBUFSIZE, "%lu\n", *val);
+	maxlen = snprintf(tmpbuf, TMPBUFSIZE, "%lu\n", val);
 	spin_unlock(&oprofilefs_lock);
 	if (maxlen > TMPBUFSIZE)
 		maxlen = TMPBUFSIZE;
@@ -122,7 +122,8 @@
 
 static ssize_t ulong_read_file(struct file * file, char * buf, size_t count, loff_t * offset)
 {
-	return oprofilefs_ulong_to_user(file->private_data, buf, count, offset);
+	unsigned long * val = file->private_data;
+	return oprofilefs_ulong_to_user(*val, buf, count, offset);
 }
 
 
@@ -212,9 +213,8 @@
 
 static ssize_t atomic_read_file(struct file * file, char * buf, size_t count, loff_t * offset)
 {
-	atomic_t * aval = file->private_data;
-	unsigned long val = atomic_read(aval);
-	return oprofilefs_ulong_to_user(&val, buf, count, offset);
+	atomic_t * val = file->private_data;
+	return oprofilefs_ulong_to_user(atomic_read(val), buf, count, offset);
 }
  
 
diff -X dontdiff -Naur linux-cvs/include/linux/oprofile.h linux-fixes/include/linux/oprofile.h
--- linux-cvs/include/linux/oprofile.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-fixes/include/linux/oprofile.h	2003-08-14 19:19:42.000000000 +0100
@@ -92,7 +92,7 @@
  * Convert an unsigned long value into ASCII and copy it to the user buffer @buf,
  * updating *offset appropriately. Returns bytes written or -EFAULT.
  */
-ssize_t oprofilefs_ulong_to_user(unsigned long * val, char * buf, size_t count, loff_t * offset);
+ssize_t oprofilefs_ulong_to_user(unsigned long val, char * buf, size_t count, loff_t * offset);
 
 /**
  * Read an ASCII string for a number from a userspace buffer and fill *val on success.

