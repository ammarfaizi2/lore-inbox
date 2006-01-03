Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWACKJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWACKJq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWACKJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:09:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:994 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751141AbWACKJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:09:41 -0500
Date: Tue, 3 Jan 2006 11:09:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 16/19] mutex subsystem, semaphore to completion: SX8
Message-ID: <20060103100924.GP23289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

change SX8 semaphores to completions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/block/sx8.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

Index: linux/drivers/block/sx8.c
===================================================================
--- linux.orig/drivers/block/sx8.c
+++ linux/drivers/block/sx8.c
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 #include <linux/hdreg.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -303,7 +304,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
-	struct semaphore		probe_sem;
+	struct completion		probe_comp;
 };
 
 struct carm_response {
@@ -1365,7 +1366,7 @@ static void carm_fsm_task (void *_data)
 	}
 
 	case HST_PROBE_FINISHED:
-		up(&host->probe_sem);
+		complete(&host->probe_comp);
 		break;
 
 	case HST_ERROR:
@@ -1641,7 +1642,7 @@ static int carm_init_one (struct pci_dev
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
-	init_MUTEX_LOCKED(&host->probe_sem);
+	init_completion(&host->probe_comp);
 
 	for (i = 0; i < ARRAY_SIZE(host->req); i++)
 		host->req[i].tag = i;
@@ -1710,8 +1711,8 @@ static int carm_init_one (struct pci_dev
 	if (rc)
 		goto err_out_free_irq;
 
-	DPRINTK("waiting for probe_sem\n");
-	down(&host->probe_sem);
+	DPRINTK("waiting for probe_comp\n");
+	wait_for_completion(&host->probe_comp);
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
