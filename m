Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWIIDdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWIIDdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWIIDdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:33:31 -0400
Received: from mail.suse.de ([195.135.220.2]:63431 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932114AbWIIDd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:33:29 -0400
Date: Fri, 8 Sep 2006 20:33:18 -0700
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.13
Message-ID: <20060909033318.GB8960@kroah.com>
References: <20060909033300.GA8960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909033300.GA8960@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 5e9bd16..078ac10 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .12
+EXTRAVERSION = .13
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/include/linux/idr.h b/include/linux/idr.h
index d37c8d8..f559a71 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -78,6 +78,7 @@ void *idr_find(struct idr *idp, int id);
 int idr_pre_get(struct idr *idp, gfp_t gfp_mask);
 int idr_get_new(struct idr *idp, void *ptr, int *id);
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id);
+void *idr_replace(struct idr *idp, void *ptr, int id);
 void idr_remove(struct idr *idp, int id);
 void idr_destroy(struct idr *idp);
 void idr_init(struct idr *idp);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 590dc6d..10d6759 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1235,6 +1235,7 @@ #define PCI_DEVICE_ID_VIA_PT880ULTRA	0x0
 #define PCI_DEVICE_ID_VIA_PX8X0_0	0x0259
 #define PCI_DEVICE_ID_VIA_3269_0	0x0269
 #define PCI_DEVICE_ID_VIA_K8T800PRO_0	0x0282
+#define PCI_DEVICE_ID_VIA_3296_0	0x0296
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305
 #define PCI_DEVICE_ID_VIA_P4M800CE	0x0314
 #define PCI_DEVICE_ID_VIA_8371_0	0x0391
@@ -1242,6 +1243,7 @@ #define PCI_DEVICE_ID_VIA_8501_0	0x0501
 #define PCI_DEVICE_ID_VIA_82C561	0x0561
 #define PCI_DEVICE_ID_VIA_82C586_1	0x0571
 #define PCI_DEVICE_ID_VIA_82C576	0x0576
+#define PCI_DEVICE_ID_VIA_SATA_EIDE	0x0581
 #define PCI_DEVICE_ID_VIA_82C586_0	0x0586
 #define PCI_DEVICE_ID_VIA_82C596	0x0596
 #define PCI_DEVICE_ID_VIA_82C597_0	0x0597
@@ -1282,10 +1284,11 @@ #define PCI_DEVICE_ID_VIA_8378_0	0x3205
 #define PCI_DEVICE_ID_VIA_8783_0	0x3208
 #define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_8251		0x3287
-#define PCI_DEVICE_ID_VIA_3296_0	0x0296
+#define PCI_DEVICE_ID_VIA_8237A		0x3337
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
 #define PCI_DEVICE_ID_VIA_8365_1	0x8305
+#define PCI_DEVICE_ID_VIA_CX700		0x8324
 #define PCI_DEVICE_ID_VIA_8371_1	0x8391
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_838X_1	0xB188
diff --git a/lib/idr.c b/lib/idr.c
index de19030..4d09681 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -29,6 +29,7 @@ #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #endif
+#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/idr.h>
 
@@ -398,6 +399,48 @@ void *idr_find(struct idr *idp, int id)
 }
 EXPORT_SYMBOL(idr_find);
 
+/**
+ * idr_replace - replace pointer for given id
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the id
+ * @id: lookup key
+ *
+ * Replace the pointer registered with an id and return the old value.
+ * A -ENOENT return indicates that @id was not found.
+ * A -EINVAL return indicates that @id was not within valid constraints.
+ *
+ * The caller must serialize vs idr_find(), idr_get_new(), and idr_remove().
+ */
+void *idr_replace(struct idr *idp, void *ptr, int id)
+{
+	int n;
+	struct idr_layer *p, *old_p;
+
+	n = idp->layers * IDR_BITS;
+	p = idp->top;
+
+	id &= MAX_ID_MASK;
+
+	if (id >= (1 << n))
+		return ERR_PTR(-EINVAL);
+
+	n -= IDR_BITS;
+	while ((n > 0) && p) {
+		p = p->ary[(id >> n) & IDR_MASK];
+		n -= IDR_BITS;
+	}
+
+	n = id & IDR_MASK;
+	if (unlikely(p == NULL || !test_bit(n, &p->bitmap)))
+		return ERR_PTR(-ENOENT);
+
+	old_p = p->ary[n];
+	p->ary[n] = ptr;
+
+	return old_p;
+}
+EXPORT_SYMBOL(idr_replace);
+
 static void idr_cache_ctor(void * idr_layer, kmem_cache_t *idr_layer_cache,
 		unsigned long flags)
 {
