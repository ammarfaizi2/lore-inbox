Return-Path: <linux-kernel-owner+w=401wt.eu-S932721AbXAJFg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbXAJFg1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbXAJFgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:36:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:4116 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbXAJFfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:35:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=l6oU7/qGoSdqk8Qrl1OHTtIM/kZ8ov3vxP8/K+C/n0Ihv1NDoCM37+WW/Fka9EcYsh1md0zrHtmrUQ44HHPuw3QtGR7DSY+wpKkZYV60mOiOo5j+34J4flATwcuBegG09T7CmFrq+2ueGcyzl32jf9IN8p1GQ7wZVW0QtWLnkvU=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/13] devres: implement managed IRQ interface
In-Reply-To: <11684073353213-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 10 Jan 2007 14:35:36 +0900
Message-Id: <11684073361560-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement managed IRQ interface - devm_request_irq() and
devm_free_irq().  Except for the first @dev argument and being
managed, these take the same arguments and have the same effect as
non-managed coutnerparts.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/interrupt.h |    6 +++
 kernel/irq/manage.c       |   86 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e36e86c..5a8ba0b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/irqflags.h>
 #include <linux/bottom_half.h>
+#include <linux/device.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -83,6 +84,11 @@ extern int request_irq(unsigned int, irq_handler_t handler,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
+extern int devm_request_irq(struct device *dev, unsigned int irq,
+			    irq_handler_t handler, unsigned long irqflags,
+			    const char *devname, void *dev_id);
+extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
+
 /*
  * On lockdep we dont want to enable hardirqs in hardirq
  * context. Use local_irq_enable_in_hardirq() to annotate
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b385878..9aa6544 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -479,3 +479,89 @@ int request_irq(unsigned int irq, irq_handler_t handler,
 	return retval;
 }
 EXPORT_SYMBOL(request_irq);
+
+/*
+ * Device resource management aware IRQ request/free implementation.
+ */
+struct irq_devres {
+	unsigned int irq;
+	void *dev_id;
+};
+
+static void devm_irq_release(struct device *dev, void *res)
+{
+	struct irq_devres *this = res;
+
+	free_irq(this->irq, this->dev_id);
+}
+
+static int devm_irq_match(struct device *dev, void *res, void *data)
+{
+	struct irq_devres *this = res, *match = data;
+
+	return this->irq == match->irq && this->dev_id == match->dev_id;
+}
+
+/**
+ *	devm_request_irq - allocate an interrupt line for a managed device
+ *	@dev: device to request interrupt for
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as
+ *	request_irq().  IRQs requested with this function will be
+ *	automatically freed on driver detach.
+ *
+ *	If an IRQ allocated with this function needs to be freed
+ *	separately, dev_free_irq() must be used.
+ */
+int devm_request_irq(struct device *dev, unsigned int irq,
+		     irq_handler_t handler, unsigned long irqflags,
+		     const char *devname, void *dev_id)
+{
+	struct irq_devres *dr;
+	int rc;
+
+	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
+			  GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (rc) {
+		kfree(dr);
+		return rc;
+	}
+
+	dr->irq = irq;
+	dr->dev_id = dev_id;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_request_irq);
+
+/**
+ *	devm_free_irq - free an interrupt
+ *	@dev: device to free interrupt for
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as free_irq().
+ *	This function instead of free_irq() should be used to manually
+ *	free IRQs allocated with dev_request_irq().
+ */
+void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id)
+{
+	struct irq_devres match_data = { irq, dev_id };
+
+	free_irq(irq, dev_id);
+	WARN_ON(devres_destroy(dev, devm_irq_release, devm_irq_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(devm_free_irq);
-- 
1.4.4.3


