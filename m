Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUGAPfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUGAPfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUGAPfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:35:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45053 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265900AbUGAPfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:35:10 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Date: Thu, 1 Jul 2004 10:35:13 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011035.13283.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the limitation of 1024 DM devices.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm.c	2004-06-30 08:45:34.512303600 -0500
+++ source/drivers/md/dm.c	2004-06-30 08:48:42.085788096 -0500
@@ -17,11 +17,13 @@
 #include <linux/slab.h>
 
 static const char *_name = DM_NAME;
-#define MAX_DEVICES 1024
 
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
+static int realloc_minor_bits(unsigned long requested_minor);
+static void free_minor_bits(void);
+
 /*
  * One of these is allocated per bio.
  */
@@ -111,11 +113,19 @@
 		return -ENOMEM;
 	}
 
+	r = realloc_minor_bits(1024);
+	if (r < 0) {
+		kmem_cache_destroy(_tio_cache);
+		kmem_cache_destroy(_io_cache);
+		return r;
+	}
+
 	_major = major;
 	r = register_blkdev(_major, _name);
 	if (r < 0) {
 		kmem_cache_destroy(_tio_cache);
 		kmem_cache_destroy(_io_cache);
+		free_minor_bits();
 		return r;
 	}
 
@@ -129,6 +139,7 @@
 {
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
+	free_minor_bits();
 
 	if (unregister_blkdev(_major, _name) < 0)
 		DMERR("devfs_unregister_blkdev failed");
@@ -615,14 +626,58 @@
 /*-----------------------------------------------------------------
  * A bitset is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
-static spinlock_t _minor_lock = SPIN_LOCK_UNLOCKED;
-static unsigned long _minor_bits[MAX_DEVICES / BITS_PER_LONG];
+static DECLARE_MUTEX(_minor_lock);
+static unsigned long *_minor_bits = NULL;
+static unsigned long _max_minors = 0;
+
+#define MINORS_SIZE(minors) ((minors / BITS_PER_LONG) * sizeof(unsigned long))
+
+static int realloc_minor_bits(unsigned long requested_minor)
+{
+	unsigned long max_minors;
+	unsigned long *minor_bits, *tmp;
+
+	if (requested_minor < _max_minors)
+		return -EINVAL;
+
+	/* Round up the requested minor to the next power-of-2. */
+	max_minors = 1 << fls(requested_minor - 1);
+	if (max_minors > (1 << MINORBITS))
+		return -EINVAL;
+
+	minor_bits = kmalloc(MINORS_SIZE(max_minors), GFP_KERNEL);
+	if (!minor_bits)
+		return -ENOMEM;
+	memset(minor_bits, 0, MINORS_SIZE(max_minors));
+
+	/* Copy the existing bit-set to the new one. */
+	if (_minor_bits)
+		memcpy(minor_bits, _minor_bits, MINORS_SIZE(_max_minors));
+
+	tmp = _minor_bits;
+	_minor_bits = minor_bits;
+	_max_minors = max_minors;
+	if (tmp)
+		kfree(tmp);
+
+	return 0;
+}
+
+static void free_minor_bits(void)
+{
+	down(&_minor_lock);
+	kfree(_minor_bits);
+	_minor_bits = NULL;
+	_max_minors = 0;
+	up(&_minor_lock);
+}
 
 static void free_minor(unsigned int minor)
 {
-	spin_lock(&_minor_lock);
-	clear_bit(minor, _minor_bits);
-	spin_unlock(&_minor_lock);
+	down(&_minor_lock);
+	if (minor < _max_minors)
+		clear_bit(minor, _minor_bits);
+	up(&_minor_lock);
 }
 
 /*
@@ -630,37 +685,48 @@
  */
 static int specific_minor(unsigned int minor)
 {
-	int r = -EBUSY;
+	int r = 0;
 
-	if (minor >= MAX_DEVICES) {
-		DMWARN("request for a mapped_device beyond MAX_DEVICES (%d)",
-		       MAX_DEVICES);
+	if (minor > (1 << MINORBITS))
 		return -EINVAL;
+
+	down(&_minor_lock);
+	if (minor >= _max_minors) {
+		r = realloc_minor_bits(minor);
+		if (r) {
+			up(&_minor_lock);
+			return r;
+		}
 	}
 
-	spin_lock(&_minor_lock);
-	if (!test_and_set_bit(minor, _minor_bits))
-		r = 0;
-	spin_unlock(&_minor_lock);
+	if (test_and_set_bit(minor, _minor_bits))
+		r = -EBUSY;
+	up(&_minor_lock);
 
 	return r;
 }
 
 static int next_free_minor(unsigned int *minor)
 {
-	int r = -EBUSY;
+	int r;
 	unsigned int m;
 
-	spin_lock(&_minor_lock);
-	m = find_first_zero_bit(_minor_bits, MAX_DEVICES);
-	if (m != MAX_DEVICES) {
-		set_bit(m, _minor_bits);
-		*minor = m;
-		r = 0;
+	down(&_minor_lock);
+	m = find_first_zero_bit(_minor_bits, _max_minors);
+	if (m >= _max_minors) {
+		r = realloc_minor_bits(_max_minors * 2);
+		if (r) {
+			up(&_minor_lock);
+			return r;
+		}
+		m = find_first_zero_bit(_minor_bits, _max_minors);
 	}
-	spin_unlock(&_minor_lock);
 
-	return r;
+	set_bit(m, _minor_bits);
+	*minor = m;
+	up(&_minor_lock);
+
+	return 0;
 }
 
 static struct block_device_operations dm_blk_dops;
