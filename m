Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275411AbTHNTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275412AbTHNTS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:18:58 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:44813 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S275411AbTHNTSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:18:37 -0400
Date: Thu, 14 Aug 2003 20:18:35 +0100
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export pointer size in oprofilefs
Message-ID: <20030814191835.GA55693@compsoc.man.ac.uk>
References: <20030814165512.GA36329@compsoc.man.ac.uk> <Pine.LNX.4.44.0308141011030.8148-100000@home.osdl.org> <20030814173024.GA42066@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814173024.GA42066@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19nNcJ-0001Yk-H4*o34ITmTYDWE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 06:30:24PM +0100, John Levon wrote:

> > Why not just fix the oprofile interfaces to contain that information? You 
> > already have to export CPU type, buffer size etc..

Export kernel pointer size from oprofilefs. Also fix the prototype of
oprofilefs_ulong_to_user not to take a pointer for no reason.

Briefly tested on my x86 box with a modified oprofiled.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprofile_files.c linux-fixes/drivers/oprofile/oprofile_files.c
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
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprofilefs.c linux-fixes/drivers/oprofile/oprofilefs.c
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
  
 
diff -Naur -X dontdiff linux-cvs/include/linux/oprofile.h linux-fixes/include/linux/oprofile.h
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
