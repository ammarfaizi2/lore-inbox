Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUGBReu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUGBReu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGBReu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:34:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:41890 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264737AbUGBRdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:33:04 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org, DevMapper <dm-devel@redhat.com>
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Date: Fri, 2 Jul 2004 12:33:09 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Alasdair Kergon <agk@redhat.com>
References: <200407011035.13283.kevcorry@us.ibm.com> <200407012154.16312.kevcorry@us.ibm.com> <20040701203043.08226a0c.akpm@osdl.org>
In-Reply-To: <20040701203043.08226a0c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407021233.09610.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 10:30 pm, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> > > Did you consider going to a different data structure altogether?
> > >
> >  > lib/radix-tree.c and lib/idr.c provide appropriate ones.
> >
> >  The idr stuff looks promising at first glance. I'll take a better look
> > at it tomorrow and see if we can switch from a bit-set to one of these
> > data structures.
>
> Yes, idr is the one to use.  That linear search you have in there becomes
> logarithmic.  Will speed up the registration of 100,000 minors no end ;)

I've got a patch that switches from a bit-set to an IDR structure. The only
thing I'm slightly uncertain about is the case where we're trying to create
a device with a specific minor number (when creating a DM device, you have
the choice to specify a minor number or have DM find the first available
one). To do this, I call idr_find() with the desired minor. If that returns
NULL (meaning it's not already in use), then I call idr_get_new_above() with
that same desired minor. In the cases I've tested, this always chooses the
desired minor, but can we depend on that behavior? For now I've got a check
to make sure the idr_get_new_above() call returned the correct value, but if
we can't be certain that this value will be correct in at least the vast
majority of the cases, we might want to find an alternate approach.

Here's the proposed patch. This is in addition to yesterday's, since Linus
has already picked that one up in his tree. It completely removes the
realloc_minor_bits() and free_minor_bits() routines, and modifies
free_minor(), specific_minor() and next_free_minor() to use the IDR
instead of the bit-set.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


Keep track of allocated minor numbers with an IDR instead of a bit-set.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm.c	2004-07-02 11:48:26.402266784 -0500
+++ source/drivers/md/dm.c	2004-07-02 12:14:12.000000000 -0500
@@ -15,15 +15,13 @@
 #include <linux/buffer_head.h>
 #include <linux/mempool.h>
 #include <linux/slab.h>
+#include <linux/idr.h>
 
 static const char *_name = DM_NAME;
 
 static unsigned int major = 0;
 static unsigned int _major = 0;
 
-static int realloc_minor_bits(unsigned long requested_minor);
-static void free_minor_bits(void);
-
 /*
  * One of these is allocated per bio.
  */
@@ -113,19 +111,11 @@
 		return -ENOMEM;
 	}
 
-	r = realloc_minor_bits(1024);
-	if (r < 0) {
-		kmem_cache_destroy(_tio_cache);
-		kmem_cache_destroy(_io_cache);
-		return r;
-	}
-
 	_major = major;
 	r = register_blkdev(_major, _name);
 	if (r < 0) {
 		kmem_cache_destroy(_tio_cache);
 		kmem_cache_destroy(_io_cache);
-		free_minor_bits();
 		return r;
 	}
 
@@ -139,7 +129,6 @@
 {
 	kmem_cache_destroy(_tio_cache);
 	kmem_cache_destroy(_io_cache);
-	free_minor_bits();
 
 	if (unregister_blkdev(_major, _name) < 0)
 		DMERR("devfs_unregister_blkdev failed");
@@ -624,59 +613,15 @@
 }
 
 /*-----------------------------------------------------------------
- * A bitset is used to keep track of allocated minor numbers.
+ * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
 static DECLARE_MUTEX(_minor_lock);
-static unsigned long *_minor_bits = NULL;
-static unsigned long _max_minors = 0;
-
-#define MINORS_SIZE(minors) ((minors / BITS_PER_LONG) * sizeof(unsigned long))
-
-static int realloc_minor_bits(unsigned long requested_minor)
-{
-	unsigned long max_minors;
-	unsigned long *minor_bits, *tmp;
-
-	if (requested_minor < _max_minors)
-		return -EINVAL;
-
-	/* Round up the requested minor to the next power-of-2. */
-	max_minors = 1 << fls(requested_minor - 1);
-	if (max_minors > (1 << MINORBITS))
-		return -EINVAL;
-
-	minor_bits = kmalloc(MINORS_SIZE(max_minors), GFP_KERNEL);
-	if (!minor_bits)
-		return -ENOMEM;
-	memset(minor_bits, 0, MINORS_SIZE(max_minors));
-
-	/* Copy the existing bit-set to the new one. */
-	if (_minor_bits)
-		memcpy(minor_bits, _minor_bits, MINORS_SIZE(_max_minors));
-
-	tmp = _minor_bits;
-	_minor_bits = minor_bits;
-	_max_minors = max_minors;
-	if (tmp)
-		kfree(tmp);
-
-	return 0;
-}
-
-static void free_minor_bits(void)
-{
-	down(&_minor_lock);
-	kfree(_minor_bits);
-	_minor_bits = NULL;
-	_max_minors = 0;
-	up(&_minor_lock);
-}
+static DEFINE_IDR(_minor_idr);
 
 static void free_minor(unsigned int minor)
 {
 	down(&_minor_lock);
-	if (minor < _max_minors)
-		clear_bit(minor, _minor_bits);
+	idr_remove(&_minor_idr, minor);
 	up(&_minor_lock);
 }
 
@@ -685,24 +630,37 @@
  */
 static int specific_minor(unsigned int minor)
 {
-	int r = 0;
+	int r, m;
 
 	if (minor > (1 << MINORBITS))
 		return -EINVAL;
 
 	down(&_minor_lock);
-	if (minor >= _max_minors) {
-		r = realloc_minor_bits(minor);
-		if (r) {
-			up(&_minor_lock);
-			return r;
-		}
+
+	if (idr_find(&_minor_idr, minor)) {
+		r = -EBUSY;
+		goto out;
 	}
 
-	if (test_and_set_bit(minor, _minor_bits))
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	r = idr_get_new_above(&_minor_idr, specific_minor, minor, &m);
+	if (r) {
+		goto out;
+	}
+
+	if (m != minor) {
+		idr_remove(&_minor_idr, m);
 		r = -EBUSY;
-	up(&_minor_lock);
+		goto out;
+	}
 
+out:
+	up(&_minor_lock);
 	return r;
 }
 
@@ -712,21 +670,29 @@
 	unsigned int m;
 
 	down(&_minor_lock);
-	m = find_first_zero_bit(_minor_bits, _max_minors);
-	if (m >= _max_minors) {
-		r = realloc_minor_bits(_max_minors * 2);
-		if (r) {
-			up(&_minor_lock);
-			return r;
-		}
-		m = find_first_zero_bit(_minor_bits, _max_minors);
+
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	r = idr_get_new(&_minor_idr, next_free_minor, &m);
+	if (r) {
+		goto out;
+	}
+
+	if (m > (1 << MINORBITS)) {
+		idr_remove(&_minor_idr, m);
+		r = -ENOSPC;
+		goto out;
 	}
 
-	set_bit(m, _minor_bits);
 	*minor = m;
-	up(&_minor_lock);
 
-	return 0;
+out:
+	up(&_minor_lock);
+	return r;
 }
 
 static struct block_device_operations dm_blk_dops;
