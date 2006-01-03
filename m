Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWACQsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWACQsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWACQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:48:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65190 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932432AbWACQr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:47:57 -0500
Date: Tue, 3 Jan 2006 17:47:39 +0100
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
Message-ID: <20060103164739.GQ25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

change SX8 semaphores to completions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/block/sx8.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/drivers/block/sx8.c
===================================================================
--- linux.orig/drivers/block/sx8.c
+++ linux/drivers/block/sx8.c
@@ -27,8 +27,8 @@
 #include <linux/time.h>
 #include <linux/hdreg.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 #if 0
@@ -303,7 +303,7 @@ struct carm_host {
 
 	struct work_struct		fsm_task;
 
-	struct semaphore		probe_sem;
+	struct completion		probe_comp;
 };
 
 struct carm_response {
@@ -1365,7 +1365,7 @@ static void carm_fsm_task (void *_data)
 	}
 
 	case HST_PROBE_FINISHED:
-		up(&host->probe_sem);
+		complete(&host->probe_comp);
 		break;
 
 	case HST_ERROR:
@@ -1641,7 +1641,7 @@ static int carm_init_one (struct pci_dev
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
-	init_MUTEX_LOCKED(&host->probe_sem);
+	init_completion(&host->probe_comp);
 
 	for (i = 0; i < ARRAY_SIZE(host->req); i++)
 		host->req[i].tag = i;
@@ -1710,8 +1710,8 @@ static int carm_init_one (struct pci_dev
 	if (rc)
 		goto err_out_free_irq;
 
-	DPRINTK("waiting for probe_sem\n");
-	down(&host->probe_sem);
+	DPRINTK("waiting for probe_comp\n");
+	wait_for_completion(&host->probe_comp);
 
 	printk(KERN_INFO "%s: pci %s, ports %d, io %lx, irq %u, major %d\n",
 	       host->name, pci_name(pdev), (int) CARM_MAX_PORTS,
