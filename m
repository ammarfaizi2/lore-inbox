Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUCPBDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUCPARO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:17:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:60079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262872AbUCPADc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:32 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951494179@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:09 -0800
Message-Id: <1079395149503@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.16, 2004/03/15 14:39:18-08:00, greg@kroah.com

kref: add kref structure to kernel tree.

Based on the kobject structure, but much smaller and simpler to use.


 include/linux/kref.h |   32 +++++++++++++++++++++++++++
 lib/Makefile         |    3 ++
 lib/kref.c           |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)


diff -Nru a/include/linux/kref.h b/include/linux/kref.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/kref.h	Mon Mar 15 15:28:04 2004
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
--- a/lib/Makefile	Mon Mar 15 15:28:04 2004
+++ b/lib/Makefile	Mon Mar 15 15:28:04 2004
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
+++ b/lib/kref.c	Mon Mar 15 15:28:04 2004
@@ -0,0 +1,60 @@
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
+/**
+ * kref_init - initialize object.
+ * @kref: object in question.
+ * @release: pointer to a function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
+ */
+void kref_init(struct kref *kref, void (*release)(struct kref *kref))
+{
+	WARN_ON(release == NULL);
+	atomic_set(&kref->refcount,1);
+	kref->release = release;
+}
+
+/**
+ * kref_get - increment refcount for object.
+ * @kref: object.
+ */
+struct kref *kref_get(struct kref *kref)
+{
+	WARN_ON(!atomic_read(&kref->refcount));
+	atomic_inc(&kref->refcount);
+	return kref;
+}
+
+/**
+ * kref_put - decrement refcount for object.
+ * @kref: object.
+ *
+ * Decrement the refcount, and if 0, call kref->release().
+ */
+void kref_put(struct kref *kref)
+{
+	if (atomic_dec_and_test(&kref->refcount)) {
+		pr_debug("kref cleaning up\n");
+		kref->release(kref);
+	}
+}
+
+EXPORT_SYMBOL(kref_init);
+EXPORT_SYMBOL(kref_get);
+EXPORT_SYMBOL(kref_put);

