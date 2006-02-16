Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWBPQPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWBPQPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWBPQPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:15:37 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:19653 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932310AbWBPQPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:15:35 -0500
Subject: Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060212190520.244fcaec.akpm@osdl.org>  <20060213203800.GC22441@kroah.com>
	 <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 20:56:00 -0500
Message-Id: <1140054960.3037.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 10:34 -0600, James Bottomley wrote:
> Well, I can't solve the problem that it requires memory allocation from
> IRQ context to operate.  Based on that, it's an unsafe interface.  I'm
> going to put it inside SCSI for 2.6.16, since it's better than what we
> have now, but I don't think we can export it globally.

OK, this is what I'm proposing as the device model fix.  What it does is
thread context checking APIs throughout the device subsystem.  SCSI can
then use it simply via device_put_process_context().  Since we have to
supply the kref_work; I'd plan to do that as an additional element in
struct scsi_device.

This, by itself, won't solve the SCSI target problem, but I plan to fix
that via a device model addition which would have target alloc waiting
around for any deleted targets to disappear.

Since this is planned for post 2.6.16, we have plenty of time to argue
about it.

James

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6b355bd..4ae42de 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -338,10 +338,10 @@ struct device * get_device(struct device
  *	put_device - decrement reference count.
  *	@dev:	device in question.
  */
-void put_device(struct device * dev)
+void put_device_process_context(struct device * dev, struct kref_work *work)
 {
 	if (dev)
-		kobject_put(&dev->kobj);
+	  kobject_put_process_context(&dev->kobj, work);
 }
 
 
@@ -445,7 +445,7 @@ EXPORT_SYMBOL_GPL(device_register);
 EXPORT_SYMBOL_GPL(device_del);
 EXPORT_SYMBOL_GPL(device_unregister);
 EXPORT_SYMBOL_GPL(get_device);
-EXPORT_SYMBOL_GPL(put_device);
+EXPORT_SYMBOL_GPL(put_device_process_context);
 
 EXPORT_SYMBOL_GPL(device_create_file);
 EXPORT_SYMBOL_GPL(device_remove_file);
diff --git a/include/linux/device.h b/include/linux/device.h
index 58df18d..ac9d457 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -396,7 +396,13 @@ extern int (*platform_notify_remove)(str
  *
  */
 extern struct device * get_device(struct device * dev);
-extern void put_device(struct device * dev);
+extern void put_device_process_context(struct device * dev,
+				       struct kref_work *work);
+static inline void put_device(struct device *dev)
+{
+	put_device_process_context(dev, NULL);
+}
+						  
 
 
 /* drivers/base/power.c */
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 2a8d8da..d079fea 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -76,7 +76,12 @@ extern int kobject_register(struct kobje
 extern void kobject_unregister(struct kobject *);
 
 extern struct kobject * kobject_get(struct kobject *);
-extern void kobject_put(struct kobject *);
+extern void kobject_put_process_context(struct kobject *, struct kref_work *);
+
+static inline void kobject_put(struct kobject *kobj)
+{
+	kobject_put_process_context(kobj, NULL);
+}
 
 extern char * kobject_get_path(struct kobject *, gfp_t);
 
diff --git a/include/linux/kref.h b/include/linux/kref.h
index 6fee353..16b15db 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -18,15 +18,29 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <asm/atomic.h>
 
 struct kref {
 	atomic_t refcount;
 };
 
+struct kref_work {
+	struct work_struct work;
+	struct kref *kref;
+	void (*release)(struct kref *kref);
+};
+
 void kref_init(struct kref *kref);
 void kref_get(struct kref *kref);
-int kref_put(struct kref *kref, void (*release) (struct kref *kref));
+int kref_put_process_context(struct kref *kref,
+			     void (*release) (struct kref *kref),
+			     struct kref_work *work);
+static inline int kref_put(struct kref *kref,
+			   void (*release) (struct kref *kref))
+{
+	return kref_put_process_context(kref, release, NULL);
+}
 
 #endif /* __KERNEL__ */
 #endif /* _KREF_H_ */
diff --git a/lib/kobject.c b/lib/kobject.c
index efe67fa..6b80c54 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -372,10 +372,10 @@ static void kobject_release(struct kref 
  *
  *	Decrement the refcount, and if 0, call kobject_cleanup().
  */
-void kobject_put(struct kobject * kobj)
+void kobject_put_process_context(struct kobject * kobj, struct kref_work *work)
 {
 	if (kobj)
-		kref_put(&kobj->kref, kobject_release);
+		kref_put_process_context(&kobj->kref, kobject_release, work);
 }
 
 
@@ -537,7 +537,7 @@ EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);
 EXPORT_SYMBOL(kobject_get);
-EXPORT_SYMBOL(kobject_put);
+EXPORT_SYMBOL(kobject_put_process_context);
 EXPORT_SYMBOL(kobject_add);
 EXPORT_SYMBOL(kobject_del);
 
diff --git a/lib/kref.c b/lib/kref.c
index 0d07cc3..66231cf 100644
--- a/lib/kref.c
+++ b/lib/kref.c
@@ -13,6 +13,7 @@
 
 #include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/hardirq.h>
 
 /**
  * kref_init - initialize object.
@@ -33,27 +34,47 @@ void kref_get(struct kref *kref)
 	atomic_inc(&kref->refcount);
 }
 
+static void kref_release_process_context(void *data)
+{
+	struct kref_work *work = data;
+
+	work->release(work->kref);
+}
+
 /**
- * kref_put - decrement refcount for object.
+ * kref_put_user - decrement refcount for object and put in user context
  * @kref: object.
  * @release: pointer to the function that will clean up the object when the
  *	     last reference to the object is released.
  *	     This pointer is required, and it is not acceptable to pass kfree
  *	     in as this function.
+ * @work:    pointer to a kref_work used to take the release through user
+ *	     context (may be null)
  *
- * Decrement the refcount, and if 0, call release().
+ * Decrement the refcount, and if 0, call release().  If work is not null
+ * execute release via schedule_work if not in process context.
  * Return 1 if the object was removed, otherwise return 0.  Beware, if this
  * function returns 0, you still can not count on the kref from remaining in
  * memory.  Only use the return value if you want to see if the kref is now
  * gone, not present.
  */
-int kref_put(struct kref *kref, void (*release)(struct kref *kref))
+int kref_put_process_context(struct kref *kref,
+			     void (*release)(struct kref *kref),
+			     struct kref_work *work)
 {
 	WARN_ON(release == NULL);
 	WARN_ON(release == (void (*)(struct kref *))kfree);
 
 	if (atomic_dec_and_test(&kref->refcount)) {
-		release(kref);
+		if (!work || !in_interrupt())
+			release(kref);
+		else {
+			INIT_WORK(&work->work, kref_release_process_context,
+				  work);
+			schedule_work(&work->work);
+		}
+			
+			
 		return 1;
 	}
 	return 0;
@@ -61,4 +82,4 @@ int kref_put(struct kref *kref, void (*r
 
 EXPORT_SYMBOL(kref_init);
 EXPORT_SYMBOL(kref_get);
-EXPORT_SYMBOL(kref_put);
+EXPORT_SYMBOL(kref_put_process_context);


