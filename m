Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUGTMYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUGTMYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 08:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUGTMYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 08:24:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45520 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265823AbUGTMYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 08:24:08 -0400
Date: Tue, 20 Jul 2004 17:53:11 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] kref shrinkage patches -- 1 of 2 -- kref shrinkage
Message-ID: <20040720122307.GA1235@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
Here's the first step towards getting to kref_get_rcu :)
This patch is to shrink the kref object by removing the 
function pointer 'release' from the kref object, and modifying
kref_init and kref_put interfaces so that kref_init will not take
the release pointer anymore and kref_put will.  Patch will probably talk
better.

Just had a question about definition of kref_get though, 
why does it need to return struct kref * ? struct kref * is anywayz 
being passed to it, hence the caller has it anywayz -- so it doesn't 
value add anything afaics (but i might have limited vision so pls correct me)
In fact, I see that the scsi applications  of kref have code like

<quote drivers/scsi/sd.c>

        if (!kref_get(&sdkp->kref))
                goto out_sdkp;

</>

the goto can never happen afaics. IMO,  kref_get must return void to 
avoid such wrong usage -- or atleast add some bold comments . Do let me 
know and I can make a patch to do either.

Thanks,
Kiran 
	
Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

diff -ruN -X dontdiff2 linux-2.6.7/include/linux/kref.h kref-2.6.7/include/linux/kref.h
--- linux-2.6.7/include/linux/kref.h	2004-06-16 10:48:59.000000000 +0530
+++ kref-2.6.7/include/linux/kref.h	2004-07-20 12:53:24.226739304 +0530
@@ -8,6 +8,9 @@
  * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
  * Copyright (C) 2002-2003 Open Source Development Labs
  *
+ * 07/2004 - struct kref shrinkage by Ravikiran Thirumalai <kiran@in.ibm.com>
+ * Copyright (C) 2004 IBM Corp.
+ *
  * This file is released under the GPLv2.
  *
  */
@@ -21,12 +24,11 @@
 
 struct kref {
 	atomic_t refcount;
-	void (*release)(struct kref *kref);
 };
 
-void kref_init(struct kref *kref, void (*release)(struct kref *));
+void kref_init(struct kref *kref);
 struct kref *kref_get(struct kref *kref);
-void kref_put(struct kref *kref);
+void kref_put(struct kref *kref, void (*release) (struct kref *kref));
 
 
 #endif /* _KREF_H_ */
diff -ruN -X dontdiff2 linux-2.6.7/lib/kref.c kref-2.6.7/lib/kref.c
--- linux-2.6.7/lib/kref.c	2004-06-16 10:50:26.000000000 +0530
+++ kref-2.6.7/lib/kref.c	2004-07-20 13:00:36.819975136 +0530
@@ -7,6 +7,9 @@
  * based on lib/kobject.c which was:
  * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
  *
+ * 07/2004 - kref object shrinkage by Ravikiran Thirumalai <kiran@in.ibm.com>
+ * Copyright (C) 2004 IBM Corp.
+ * 
  * This file is released under the GPLv2.
  *
  */
@@ -19,15 +22,10 @@
 /**
  * kref_init - initialize object.
  * @kref: object in question.
- * @release: pointer to a function that will clean up the object
- *	     when the last reference to the object is released.
- *	     This pointer is required.
  */
-void kref_init(struct kref *kref, void (*release)(struct kref *kref))
+void kref_init(struct kref *kref)
 {
-	WARN_ON(release == NULL);
 	atomic_set(&kref->refcount,1);
-	kref->release = release;
 }
 
 /**
@@ -44,14 +42,17 @@
 /**
  * kref_put - decrement refcount for object.
  * @kref: object.
- *
- * Decrement the refcount, and if 0, call kref->release().
+ * @release: pointer to the function that will clean up the object
+ *	     when the last reference to the object is released.
+ *	     This pointer is required.
+ * Decrement the refcount, and if 0, call release().
  */
-void kref_put(struct kref *kref)
+void kref_put(struct kref *kref, void (*release) (struct kref *kref))
 {
+	WARN_ON(release == NULL);
 	if (atomic_dec_and_test(&kref->refcount)) {
 		pr_debug("kref cleaning up\n");
-		kref->release(kref);
+		release(kref);
 	}
 }
 
