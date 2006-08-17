Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWHQVWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWHQVWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWHQVWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:22:49 -0400
Received: from vena.lwn.net ([206.168.112.25]:47508 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932265AbWHQVWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:22:48 -0400
Message-ID: <20060817212248.19853.qmail@lwn.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: cdev documentation (was Drop second arg of unregister_chrdev())
From: corbet@lwn.net (Jonathan Corbet)
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-reply-to: Your message of "Wed, 16 Aug 2006 09:03:19 +0200."
             <200608160903.25145.eike-kernel@sf-tec.de> 
Date: Thu, 17 Aug 2006 15:22:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> > Might this, instead, be an opportunity to get rid of the internal
> > register_chrdev() and unregister_chrdev() calls in favor of the cdev
> > interface?
> 
> In this case I would suggest to add documentation to this functions first to 
> get people the chance to actually know how to use them.

How's the following?  Quickly done but, I hope, useful.

I've also put something more tutorial-oriented at:

	http://lwn.net/SubscriberLink/195805/b835f36d3b8ee266/

This can be formatted up for the Documentation directory if so desired.

jon

---

Add some documentation comments for the cdev interface.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>

diff -rpuN -X current/Documentation/dontdiff 2.6.18-rc4/Documentation/DocBook/kernel-api.tmpl 2.6.18-rc4-jc1/Documentation/DocBook/kernel-api.tmpl
--- 2.6.18-rc4/Documentation/DocBook/kernel-api.tmpl	2006-08-16 15:21:11.000000000 -0600
+++ 2.6.18-rc4-jc1/Documentation/DocBook/kernel-api.tmpl	2006-08-17 14:25:47.000000000 -0600
@@ -437,6 +437,11 @@ X!Edrivers/pnp/system.c
 !Eblock/ll_rw_blk.c
   </chapter>
 
+  <chapter id="chrdev">
+	<title>Char devices</title>
+!Efs/char_dev.c
+  </chapter>
+
   <chapter id="miscdev">
      <title>Miscellaneous Devices</title>
 !Edrivers/char/misc.c
diff -rpuN -X current/Documentation/dontdiff 2.6.18-rc4/fs/char_dev.c 2.6.18-rc4-jc1/fs/char_dev.c
--- 2.6.18-rc4/fs/char_dev.c	2006-08-16 15:21:44.000000000 -0600
+++ 2.6.18-rc4-jc1/fs/char_dev.c	2006-08-17 14:22:16.000000000 -0600
@@ -146,6 +146,15 @@ __unregister_chrdev_region(unsigned majo
 	return cd;
 }
 
+/**
+ * register_chrdev_region() - register a range of device numbers
+ * @from: the first in the desired range of device numbers; must include
+ *        the major number.
+ * @count: the number of consecutive device numbers required
+ * @name: the name of the device or driver.
+ *
+ * Return value is zero on success, a negative error code on failure.
+ */
 int register_chrdev_region(dev_t from, unsigned count, const char *name)
 {
 	struct char_device_struct *cd;
@@ -171,6 +180,17 @@ fail:
 	return PTR_ERR(cd);
 }
 
+/**
+ * alloc_chrdev_region() - register a range of char device numbers
+ * @dev: output parameter for first assigned number
+ * @baseminor: first of the requested range of minor numbers
+ * @count: the number of minor numbers required
+ * @name: the name of the associated device or driver
+ *
+ * Allocates a range of char device numbers.  The major number will be
+ * chosen dynamically, and returned (along with the first minor number)
+ * in @dev.  Returns zero or a negative error code.
+ */
 int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count,
 			const char *name)
 {
@@ -240,6 +260,15 @@ out2:
 	return err;
 }
 
+/**
+ * unregister_chrdev_region() - return a range of device numbers
+ * @from: the first in the range of numbers to unregister
+ * @count: the number of device numbers to unregister
+ *
+ * This function will unregister a range of @count device numbers,
+ * starting with @from.  The caller should normally be the one who
+ * allocated those numbers in the first place...
+ */
 void unregister_chrdev_region(dev_t from, unsigned count)
 {
 	dev_t to = from + count;
@@ -377,6 +406,16 @@ static int exact_lock(dev_t dev, void *d
 	return cdev_get(p) ? 0 : -1;
 }
 
+/**
+ * cdev_add() - add a char device to the system
+ * @p: the cdev structure for the device
+ * @dev: the first device number for which this device is responsible
+ * @count: the number of consecutive minor numbers corresponding to this
+ *         device
+ *
+ * cdev_add() adds the device represented by @p to the system, making it
+ * live immediately.  A negative error code is returned on failure.
+ */
 int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 {
 	p->dev = dev;
@@ -389,6 +428,13 @@ static void cdev_unmap(dev_t dev, unsign
 	kobj_unmap(cdev_map, dev, count);
 }
 
+/**
+ * cdev_del() - remove a cdev from the system
+ * @p: the cdev structure to be removed
+ *
+ * cdev_del() removes @p from the system, possibly freeing the structure
+ * itself.
+ */
 void cdev_del(struct cdev *p)
 {
 	cdev_unmap(p->dev, p->count);
@@ -417,6 +463,11 @@ static struct kobj_type ktype_cdev_dynam
 	.release	= cdev_dynamic_release,
 };
 
+/**
+ * cdev_alloc() - allocate a cdev structure
+ *
+ * Allocates and returns a cdev structure, or NULL on failure.
+ */
 struct cdev *cdev_alloc(void)
 {
 	struct cdev *p = kzalloc(sizeof(struct cdev), GFP_KERNEL);
@@ -428,6 +479,14 @@ struct cdev *cdev_alloc(void)
 	return p;
 }
 
+/**
+ * cdev_init() - initialize a cdev structure
+ * @cdev: the structure to initialize
+ * @fops: the file_operations for this device
+ *
+ * Initializes @cdev, remembering @fops, making it ready to add to the
+ * system with cdev_add().
+ */
 void cdev_init(struct cdev *cdev, const struct file_operations *fops)
 {
 	memset(cdev, 0, sizeof *cdev);
