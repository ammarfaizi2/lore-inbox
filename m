Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWGJFsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWGJFsx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGJFsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:48:52 -0400
Received: from mga03.intel.com ([143.182.124.21]:34232 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751346AbWGJFsu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:48:50 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="63485151:sNHT11556481223"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [BUG] sleeping function called from invalid context during resume
Date: Mon, 10 Jul 2006 01:48:13 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA44@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] sleeping function called from invalid context during resume
Thread-Index: AcaiJbSA9fmQBmPVS66Wa47h+P7cygBvZh0w
From: "Brown, Len" <len.brown@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>
Cc: <johnstul@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 10 Jul 2006 05:48:15.0703 (UTC) FILETIME=[7034FE70:01C6A3E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, if system_state is off limits, there here is what I've got
(interesting part is the last 20 lines)

ACPI: acpi_os_allocate() fixes

Replace acpi_in_resume with a more general hack
to check irqs_disabled() on any kmalloc() from ACPI.
While setting (system_state != SYSTEM_RUNNING) on resume
seemed more general, Andrew Morton preferred this approach.

http://bugzilla.kernel.org/show_bug.cgi?id=3469

Make acpi_os_allocate() into an inline function to
allow /proc/slab_allocators to work.

Delete some memset() that could fault on allocation failure.

Signed-off-by: Len Brown <len.brown@intel.com>

 drivers/acpi/osl.c               |   30 ------------------------------
 drivers/acpi/parser/psutils.c    |    2 --
 drivers/acpi/pci_link.c          |    7 -------
 drivers/acpi/utilities/utalloc.c |    2 ++
 include/acpi/acmacros.h          |    8 +++++++-
 include/acpi/platform/aclinux.h  |   21 +++++++++++++++++++++
 6 files changed, 30 insertions(+), 40 deletions(-)


diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index eedb05c..47dfde9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -136,16 +136,6 @@ #else
 #endif
 }
 
-
-extern int acpi_in_resume;
-void *acpi_os_allocate(acpi_size size)
-{
-	if (acpi_in_resume)
-		return kmalloc(size, GFP_ATOMIC);
-	else
-		return kmalloc(size, GFP_KERNEL);
-}
-
 acpi_status acpi_os_get_root_pointer(u32 flags, struct acpi_pointer
*addr)
 {
 	if (efi_enabled) {
@@ -1115,26 +1105,6 @@ acpi_status acpi_os_release_object(acpi_
 	return (AE_OK);
 }
 
-/**********************************************************************
*********
- *
- * FUNCTION:    acpi_os_acquire_object
- *
- * PARAMETERS:  Cache           - Handle to cache object
- *              ReturnObject    - Where the object is returned
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Return a zero-filled object.
- *
-
************************************************************************
******/
-
-void *acpi_os_acquire_object(acpi_cache_t * cache)
-{
-	void *object = kmem_cache_zalloc(cache, GFP_KERNEL);
-	WARN_ON(!object);
-	return object;
-}
-
 
/***********************************************************************
*******
  *
  * FUNCTION:    acpi_os_validate_interface
diff --git a/drivers/acpi/parser/psutils.c
b/drivers/acpi/parser/psutils.c
index 182474a..d405387 100644
--- a/drivers/acpi/parser/psutils.c
+++ b/drivers/acpi/parser/psutils.c
@@ -139,12 +139,10 @@ union acpi_parse_object *acpi_ps_alloc_o
 		/* The generic op (default) is by far the most common
(16 to 1) */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 8197c0e..7f3e7e7 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -780,11 +780,6 @@ static int acpi_pci_link_resume(struct a
 		return 0;
 }
 
-/*
- * FIXME: this is a workaround to avoid nasty warning.  It will be
removed
- * after every device calls pci_disable_device in .resume.
- */
-int acpi_in_resume;
 static int irqrouter_resume(struct sys_device *dev)
 {
 	struct list_head *node = NULL;
@@ -794,7 +789,6 @@ static int irqrouter_resume(struct sys_d
 	/* Make sure SCI is enabled again (Apple firmware bug?) */
 	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1,
ACPI_MTX_DO_NOT_LOCK);
 
-	acpi_in_resume = 1;
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
@@ -803,7 +797,6 @@ static int irqrouter_resume(struct sys_d
 		}
 		acpi_pci_link_resume(link);
 	}
-	acpi_in_resume = 0;
 	return 0;
 }
 
diff --git a/drivers/acpi/utilities/utalloc.c
b/drivers/acpi/utilities/utalloc.c
index 5cff17d..f6cbc0b 100644
--- a/drivers/acpi/utilities/utalloc.c
+++ b/drivers/acpi/utilities/utalloc.c
@@ -285,6 +285,7 @@ acpi_ut_initialize_buffer(struct acpi_bu
 	return (status);
 }
 
+#ifdef NOT_USED_BY_LINUX
 
/***********************************************************************
********
  *
  * FUNCTION:    acpi_ut_allocate
@@ -360,3 +361,4 @@ void *acpi_ut_allocate_zeroed(acpi_size 
 
 	return (allocation);
 }
+#endif
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index f1ac610..192fa09 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -724,9 +724,15 @@ #ifndef ACPI_DBG_TRACK_ALLOCATIONS
 
 /* Memory allocation */
 
+#ifndef ACPI_ALLOCATE
 #define ACPI_ALLOCATE(a)
acpi_ut_allocate((acpi_size)(a),_COMPONENT,_acpi_module_name,__LINE__)
+#endif
+#ifndef ACPI_ALLOCATE_ZEROED
 #define ACPI_ALLOCATE_ZEROED(a)
acpi_ut_allocate_zeroed((acpi_size)(a),
_COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_FREE(a)                kfree(a)
+#endif
+#ifndef ACPI_FREE
+#define ACPI_FREE(a)                acpio_os_free(a)
+#endif
 #define ACPI_MEM_TRACKING(a)
 
 #else
diff --git a/include/acpi/platform/aclinux.h
b/include/acpi/platform/aclinux.h
index 3f853ca..e0eacfa 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -104,4 +104,25 @@ #define acpi_thread_id u32
 
 static inline acpi_thread_id acpi_os_get_thread_id(void) { return 0; }
 
+/*
+ * The irqs_disabled() check is for resume from RAM.
+ * Interrupts are off during resume, just like they are for boot.
+ * However, boot has  (system_state != SYSTEM_RUNNING)
+ * to quiet __might_sleep() in kmalloc() and resume does not.
+ */
+static inline void *acpi_os_allocate(acpi_size size) {
+	return kmalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+}
+static inline void *acpi_os_allocate_zeroed(acpi_size size) {
+	return kzalloc(size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
+}
+
+static inline void *acpi_os_acquire_object(acpi_cache_t * cache) {
+        return kmem_cache_zalloc(cache, irqs_disabled() ? GFP_ATOMIC :
GFP_KERNEL);
+}
+
+#define ACPI_ALLOCATE(a)	acpi_os_allocate(a)
+#define ACPI_ALLOCATE_ZEROED(a)	acpi_os_allocate_zeroed(a)
+#define ACPI_FREE(a)		kfree(a)
+
 #endif				/* __ACLINUX_H__ */
