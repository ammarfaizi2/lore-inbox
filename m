Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWJ3MAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJ3MAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWJ3MAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:00:47 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45959 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750705AbWJ3MAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:00:46 -0500
From: "Peter Pearse" <peter.pearse@arm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC 2/7][PATCH] AMBA DMA: Implement /proc/dma for arm DMA 
Date: Mon, 30 Oct 2006 12:00:42 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Acb8GwXp5u3YC9EmQKGWil0kTAuqhg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <CAM-OWA1KgRKmKNEJM100000003@cam-owa1.Emea.Arm.com>
X-OriginalArrivalTime: 30 Oct 2006 12:00:45.0252 (UTC) FILETIME=[07D78840:01C6FC1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the necessary functions to arch/arm/kernel/dma.c.

Signed-off-by: Peter M Pearse <peter.pearse@arm.com> 

---
diff -purN arm_amba/arch/arm/kernel/dma.c
arm_amba_proc_dma/arch/arm/kernel/dma.c
--- arm_amba/arch/arm/kernel/dma.c	2006-10-17 13:28:37.000000000 +0100
+++ arm_amba_proc_dma/arch/arm/kernel/dma.c	2006-10-17
17:05:21.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/proc_fs.h>
 
 #include <asm/dma.h>
 
@@ -258,6 +259,47 @@ int get_dma_residue(dmach_t channel)
 }
 EXPORT_SYMBOL(get_dma_residue);
 
+#ifdef CONFIG_PROC_FS
+static int proc_dma_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	for (i = 0 ; i < MAX_DMA_CHANNELS ; i++) {
+		if (dma_chan[i].lock) {
+			seq_printf(m, "%2d: %14s %s\n", i,
+				   dma_chan[i].d_ops->type,
dma_chan[i].device_id);
+		}
+	}
+	return 0;
+}
+static int proc_dma_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_dma_show, NULL);
+}
+
+static struct file_operations proc_dma_operations = {
+	.open		= proc_dma_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init proc_dma_init(void)
+{
+	if(MAX_DMA_CHANNELS > 0){
+		struct proc_dir_entry *e;
+
+		e = create_proc_entry("dma", 0, NULL);
+		if (e)
+			e->proc_fops = &proc_dma_operations;
+	}
+	return 0;
+}
+
+__initcall(proc_dma_init);
+
+#endif
+
 static int __init init_dma(void)
 {
 	arch_dma_init(dma_chan);



