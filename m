Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKYWuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKYWuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKYWuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:50:39 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34759 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932400AbVKYWui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:50:38 -0500
Subject: [PATCH -rt] convert compat sem in block device sx8
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>,
       Aleksey Makarov <amakarov@dev.rtsoft.ru>
In-Reply-To: <1132929218.11915.2.camel@localhost.localdomain>
References: <438709F5.1050801@dev.rtsoft.ru>
	 <1132929218.11915.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 17:50:25 -0500
Message-Id: <1132959025.24417.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I decided to add a few more conversions to the list :-)

Here's sx8. Unfortunately, I was only able to test compiling it, since I
don't have the hardware. Hence, I'm not sending this to mainline unless
someone can test it on yours. (your patch is the new -mm ;-)

-- Steve

Index: linux-2.6.14-rt15/drivers/block/sx8.c
===================================================================
--- linux-2.6.14-rt15.orig/drivers/block/sx8.c	2005-11-25 10:14:09.000000000 -0500
+++ linux-2.6.14-rt15/drivers/block/sx8.c	2005-11-25 16:55:01.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 #include <linux/hdreg.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -280,10 +281,7 @@
 
 	struct work_struct		fsm_task;
 
-	/*
-	 * PREEMPT_RT: should be converted to completions.
-	 */
-	struct compat_semaphore		probe_sem;
+	struct completion		probe_comp;
 };
 
 struct carm_response {
@@ -1345,7 +1343,7 @@
 	}
 
 	case HST_PROBE_FINISHED:
-		up(&host->probe_sem);
+		completion(&host->probe_comp);
 		break;
 
 	case HST_ERROR:
@@ -1621,7 +1619,7 @@
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
-	init_MUTEX_LOCKED(&host->probe_sem);
+	init_completion(&host->probe_comp);
 
 	for (i = 0; i < ARRAY_SIZE(host->req); i++)
 		host->req[i].tag = i;
@@ -1690,8 +1688,8 @@
 	if (rc)
 		goto err_out_free_irq;
 
-	DPRINTK("waiting for probe_sem\n");
-	down(&host->probe_sem);
+	DPRINTK("waiting for probe_comp\n");
+	wait_for_completion(&host->probe_comp);
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,


