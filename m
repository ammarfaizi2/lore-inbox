Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVACN0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVACN0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVACN0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:26:36 -0500
Received: from verein.lst.de ([213.95.11.210]:46998 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261442AbVACN0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:26:25 -0500
Date: Mon, 3 Jan 2005 14:26:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] warn about cli, sti & co uses even on UP
Message-ID: <20050103132620.GA22351@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These don't exist on SMP at all, at least warn on compiling for UP.


--- 1.33/include/linux/interrupt.h	2004-10-28 09:40:01 +02:00
+++ edited/include/linux/interrupt.h	2004-11-03 21:31:02 +01:00
@@ -61,12 +61,30 @@
  * Temporary defines for UP kernels, until all code gets fixed.
  */
 #ifndef CONFIG_SMP
-# define cli()			local_irq_disable()
-# define sti()			local_irq_enable()
-# define save_flags(x)		local_save_flags(x)
-# define restore_flags(x)	local_irq_restore(x)
-# define save_and_cli(x)	local_irq_save(x)
-#endif
+static inline void __deprecated cli(void)
+{
+	local_irq_disable();
+}
+static inline void __deprecated sti(void)
+{
+	local_irq_enable();
+}
+static inline void __deprecated save_flags(unsigned long *x)
+{
+	local_save_flags(*x);
+}
+#define save_flags(x) save_flags(&x);
+static inline void __deprecated restore_flags(unsigned long x)
+{
+	local_irq_restore(x);
+}
+
+static inline void __deprecated save_and_cli(unsigned long *x)
+{
+	local_irq_save(*x);
+}
+#define save_and_cli(x)	save_and_cli(&x)
+#endif /* CONFIG_SMP */
 
 /* SoftIRQ primitives.  */
 #define local_bh_disable() \
