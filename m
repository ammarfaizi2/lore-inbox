Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUCMIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 03:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbUCMIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 03:22:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:14281 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263060AbUCMIV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 03:21:58 -0500
Date: Sat, 13 Mar 2004 00:20:03 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] kref, a tiny, sane, reference count object
Message-ID: <20040313082003.GA13084@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In thinking about people's complaints about the current kobject
interface, a lot of people don't like the "complexity" of what is
necessary to use a kobject.  If all you want is something to handle
reference counting properly, a kobject can seem a bit "large".

For all of those people, this patch is for you.  Introducing struct
kref.  A tiny (only 8 bytes on a 32bit platform) that will properly
handle reference counting any structure you want to use it for.  Note
that you will have to be careful around the cleanup period (but that can
be easily handled by the user with regards to not trying to grab a "new"
reference if you don't already have one, once the object is gone, just
like kobjects and sysfs today work.)

I've implemented kobjects using a kref to handle the reference counting
portion, but will leave that patch and change for 2.7, as it will add 4
more bytes (on a 32bit platform) to every kobject, and that wouldn't be
nice this early in the 2.6 series.  For now, krefs can stand on their
own.

I've already found loads of places in the kernel that can use this
structure to clean up their logic, and will probably be converting a
number of them over time to use them.  But no, Al, I will not say this
can be used to replace the atomic_t count you have in inodes, as that
count is horribly abused in ways I never really wanted to know about
(negative counts mean something "special"?  eeeeeek....)

Anyway, here's a patch against 2.6.4 that adds krefs to the kernel.
I'll follow up with a patch that converts the usb-serial core from using
kobjects to using krefs instead.

Comments are appreciated and welcomed.

thanks,

greg k-h


diff -Nru a/include/linux/kref.h b/include/linux/kref.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/kref.h	Sat Mar 13 00:04:46 2004
@@ -0,0 +1,32 @@
+/*
+ * kref.c - library routines for handling generic reference counted objects
+ *
+ * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2004 IBM Corp.
+ *
+ * based on kobject.h which was:
+ * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (C) 2002-2003 Open Source Development Labs
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#if defined(__KERNEL__) && !defined(_KREF_H_)
+#define _KREF_H_
+
+#include <linux/types.h>
+#include <asm/atomic.h>
+
+
+struct kref {
+	atomic_t refcount;
+	void (*release)(struct kref *kref);
+};
+
+void kref_init(struct kref *kref, void (*release)(struct kref *));
+struct kref *kref_get(struct kref *kref);
+void kref_put(struct kref *kref);
+
+
+#endif /* _KREF_H_ */
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Sat Mar 13 00:04:42 2004
+++ b/lib/Makefile	Sat Mar 13 00:04:42 2004
@@ -8,6 +8,9 @@
 	 kobject.o idr.o div64.o parser.o int_sqrt.o \
 	 bitmap.o extable.o
 
+# hack for now till some static code uses krefs, then it can move up above...
+obj-y += kref.o
+
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 
diff -Nru a/lib/kref.c b/lib/kref.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/kref.c	Sat Mar 13 00:04:46 2004
@@ -0,0 +1,76 @@
+/*
+ * kref.c - library routines for handling generic reference counted objects
+ *
+ * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2004 IBM Corp.
+ *
+ * based on lib/kobject.c which was:
+ * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+/* #define DEBUG */
+
+#include <linux/kref.h>
+#include <linux/module.h>
+
+
+/**
+ * kref_init - initialize object.
+ * @kref: object in question.
+ */
+void kref_init(struct kref *kref, void (*release)(struct kref *kref))
+{
+	atomic_set(&kref->refcount,1);
+	kref->release = release;
+}
+
+/**
+ * kref_get - increment refcount for object.
+ * @kref: object.
+ */
+struct kref * kref_get(struct kref *kref)
+{
+	if (kref) {
+		WARN_ON(!atomic_read(&kref->refcount));
+		atomic_inc(&kref->refcount);
+	}
+	return kref;
+}
+
+/**
+ * kref_cleanup - free kref resources. 
+ * @kref: object.
+ */
+void kref_cleanup(struct kref *kref)
+{
+	if (!kref)
+		return;
+
+	pr_debug("kref cleaning up\n");
+	if (kref->release)
+		kref->release(kref);
+	else {
+		printk(KERN_ERR "kref does not have a release() function, "
+			"it is broken and must be fixed.\n");
+		WARN_ON(1);
+	}
+}
+
+/**
+ * kref_put - decrement refcount for object.
+ * @kref: object.
+ *
+ * Decrement the refcount, and if 0, call kref_cleanup().
+ */
+void kref_put(struct kref *kref)
+{
+	if (atomic_dec_and_test(&kref->refcount))
+		kref_cleanup(kref);
+}
+
+EXPORT_SYMBOL(kref_init);
+EXPORT_SYMBOL(kref_get);
+EXPORT_SYMBOL(kref_put);
