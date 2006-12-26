Return-Path: <linux-kernel-owner+w=401wt.eu-S932693AbWLZPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWLZPT5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWLZPSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:18:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653AbWLZPSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=l2UKntyjiZRPJ3kqtbgJJkr2n1D/y0KXke9k9Y35eWtQD2bD6yecGkqF7CKYM0Jp4ocytjnncnKPSHwIVMjGQsNhkoFi/yxG4kq5DPYJcAYqvLfMMbpUhdsFnhEfoW8KkE3Tmw8MDijMDuF9HRXItDGwMzV/9JrWIngouNrLEZM=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/12] devres: implement managed IO region interface
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:34 +0900
Message-Id: <1167146314352-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed IO region interface - devm_request_region() and
devm_release_region().  Except for the first @dev argument and being
managed, these take the same arguments and have the same effect as
non-managed coutnerparts.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/ioport.h |   20 +++++++++++++++
 kernel/resource.c      |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 15228d7..6859a3b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -137,4 +137,24 @@ static inline int __deprecated check_region(resource_size_t s,
 {
 	return __check_region(&ioport_resource, s, n);
 }
+
+/* Wrappers for managed devices */
+struct device;
+#define devm_request_region(dev,start,n,name) \
+	__devm_request_region(dev, &ioport_resource, (start), (n), (name))
+#define devm_request_mem_region(dev,start,n,name) \
+	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
+
+extern struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name);
+
+#define devm_release_region(start,n) \
+	__devm_release_region(dev, &ioport_resource, (start), (n))
+#define devm_release_mem_region(start,n) \
+	__devm_release_region(dev, &iomem_resource, (start), (n))
+
+extern void __devm_release_region(struct device *dev, struct resource *parent,
+				  resource_size_t start, resource_size_t n);
+
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 7b9a497..2a3f886 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <asm/io.h>
 
 
@@ -618,6 +619,67 @@ void __release_region(struct resource *parent, resource_size_t start,
 EXPORT_SYMBOL(__release_region);
 
 /*
+ * Managed region resource
+ */
+struct region_devres {
+	struct resource *parent;
+	resource_size_t start;
+	resource_size_t n;
+};
+
+static void devm_region_release(struct device *dev, void *res)
+{
+	struct region_devres *this = res;
+
+	__release_region(this->parent, this->start, this->n);
+}
+
+static int devm_region_match(struct device *dev, void *res, void *match_data)
+{
+	struct region_devres *this = res, *match = match_data;
+
+	return this->parent == match->parent &&
+		this->start == match->start && this->n == match->n;
+}
+
+struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name)
+{
+	struct region_devres *dr = NULL;
+	struct resource *res;
+
+	dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
+			  GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	dr->parent = parent;
+	dr->start = start;
+	dr->n = n;
+
+	res = __request_region(parent, start, n, name);
+	if (res)
+		devres_add(dev, dr);
+	else
+		devres_free(dr);
+
+	return res;
+}
+EXPORT_SYMBOL(__devm_request_region);
+
+void __devm_release_region(struct device *dev, struct resource *parent,
+			   resource_size_t start, resource_size_t n)
+{
+	struct region_devres match_data = { parent, start, n };
+
+	__release_region(parent, start, n);
+	WARN_ON(devres_destroy(dev, devm_region_release, devm_region_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(__devm_release_region);
+
+/*
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
-- 
1.4.4.2


