Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGFSXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGFSXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUGFSXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:23:35 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:22434 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264251AbUGFSXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:23:24 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Date: Tue, 6 Jul 2004 13:23:26 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com, torvalds@osdl.org,
       agk@redhat.com, Jim Houston <jim.houston@comcast.net>
References: <200407011035.13283.kevcorry@us.ibm.com> <200407021233.09610.kevcorry@us.ibm.com> <20040702124218.0ad27a85.akpm@osdl.org>
In-Reply-To: <20040702124218.0ad27a85.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407061323.27066.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 July 2004 2:42 pm, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> > > Yes, idr is the one to use.  That linear search you have in there
> > > becomes
> > >
> >  > logarithmic.  Will speed up the registration of 100,000 minors no end
> >  > ;)
> >
> >  I've got a patch that switches from a bit-set to an IDR structure. The
> > only thing I'm slightly uncertain about is the case where we're trying to
> > create a device with a specific minor number (when creating a DM device,
> > you have the choice to specify a minor number or have DM find the first
> > available one). To do this, I call idr_find() with the desired minor. If
> > that returns NULL (meaning it's not already in use), then I call
> > idr_get_new_above() with that same desired minor. In the cases I've
> > tested, this always chooses the desired minor, but can we depend on that
> > behavior?
>
> Yes, that has to work - you're holding the lock throughout.
>
> It would be sensible to make that a part of the idr API though.

After talking with Alasdair a bit, there might be one bug in the "dm-use-idr"
patch I submitted before. It seems (based on some comments in lib/idr.c) that
the idr_find() routine might not return NULL if the desired ID value is not
in the tree. However, my previous patch assumed it would. So, if that is in
fact the behavior of idr_find(), we'll need to replace my previous
"dm-use-idr" patch (now in -mm6) with this one. It now allocates a integer
before calling idr_get_new() or idr_get_new_above() so it can pass a unique
pointer to associate with each ID. After the idr_get_ call it stores the ID
into that allocated integer so it can verify that the correct pointer is
returned from calls to idr_find().

(If you'd rather have an incremental patch from the previous version, just
let me know.)

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/



Keep track of allocated minor numbers with an IDR instead of a bit-set.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm.c	2004-07-02 11:40:41.000000000 -0500
+++ source/drivers/md/dm.c	2004-07-06 11:59:34.738796728 -0500
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
@@ -624,59 +613,23 @@
 }
 
 /*-----------------------------------------------------------------
- * A bitset is used to keep track of allocated minor numbers.
+ * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
 static DECLARE_MUTEX(_minor_lock);
-static unsigned long *_minor_bits = NULL;
-static unsigned long _max_minors = 0;
+static DEFINE_IDR(_minor_idr);
 
-#define MINORS_SIZE(minors) ((minors / BITS_PER_LONG) * sizeof(unsigned long))
-
-static int realloc_minor_bits(unsigned long requested_minor)
+static void free_minor(unsigned int minor)
 {
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
+	unsigned int *m;
 
-	return 0;
-}
-
-static void free_minor_bits(void)
-{
 	down(&_minor_lock);
-	kfree(_minor_bits);
-	_minor_bits = NULL;
-	_max_minors = 0;
-	up(&_minor_lock);
-}
 
-static void free_minor(unsigned int minor)
-{
-	down(&_minor_lock);
-	if (minor < _max_minors)
-		clear_bit(minor, _minor_bits);
+	m = idr_find(&_minor_idr, minor);
+	if (m && *m == minor) {
+		idr_remove(&_minor_idr, minor);
+		kfree(m);
+	}
+
 	up(&_minor_lock);
 }
 
@@ -685,48 +638,95 @@
  */
 static int specific_minor(unsigned int minor)
 {
-	int r = 0;
+	unsigned int m, *p;
+	int r;
 
-	if (minor > (1 << MINORBITS))
+	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
 	down(&_minor_lock);
-	if (minor >= _max_minors) {
-		r = realloc_minor_bits(minor);
-		if (r) {
-			up(&_minor_lock);
-			return r;
-		}
+
+	/* Make sure this minor isn't already in use. */
+	p = idr_find(&_minor_idr, minor);
+	if (p && *p == minor) {
+		r = -EBUSY;
+		goto out;
+	}
+
+	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
+	if (!r) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	/* Allocate an int to store the minor number in. */
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		r = - ENOMEM;
+		goto out;
+	}
+
+	/* Since the desired minor isn't in the IDR, this should get that
+	 * specific minor. But, check the returned ID just to be safe.
+	 */
+	r = idr_get_new_above(&_minor_idr, p, minor, &m);
+	if (r) {
+		kfree(p);
+		goto out;
 	}
 
-	if (test_and_set_bit(minor, _minor_bits))
+	if (m != minor) {
+		idr_remove(&_minor_idr, m);
+		kfree(p);
 		r = -EBUSY;
-	up(&_minor_lock);
+		goto out;
+	}
+
+	*p = minor;
 
+out:
+	up(&_minor_lock);
 	return r;
 }
 
 static int next_free_minor(unsigned int *minor)
 {
 	int r;
-	unsigned int m;
+	unsigned int m, *p;
 
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
 	}
 
-	set_bit(m, _minor_bits);
-	*minor = m;
-	up(&_minor_lock);
+	/* Allocate an int to store the minor number in. */
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		r = - ENOMEM;
+		goto out;
+	}
 
-	return 0;
+	r = idr_get_new(&_minor_idr, p, &m);
+	if (r) {
+		kfree(p);
+		goto out;
+	}
+
+	if (m >= (1 << MINORBITS)) {
+		idr_remove(&_minor_idr, m);
+		kfree(p);
+		r = -ENOSPC;
+		goto out;
+	}
+
+	*minor = *p = m;
+
+out:
+	up(&_minor_lock);
+	return r;
 }
 
 static struct block_device_operations dm_blk_dops;
