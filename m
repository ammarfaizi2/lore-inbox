Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTHDUrW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHDUrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:47:21 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:9990 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272235AbTHDUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:47:09 -0400
Date: Mon, 4 Aug 2003 21:47:06 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: Re: [ANNOUNCE] megaraid linux driver version 2.00.7
Message-ID: <20030804214706.A24448@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570185F3E7@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F3E7@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Mon, Aug 04, 2003 at 02:18:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 02:18:59PM -0400, Mukker, Atul wrote:
> > and incorporating my patch to kill
> > the useless hostlock redefintion?
> > 
> ??, can you resend this patch


diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Mon Jun 23 11:03:07 2003
+++ b/drivers/scsi/megaraid.c	Mon Jun 23 11:03:07 2003
@@ -32,15 +32,16 @@
 
 #include <linux/mm.h>
 #include <linux/fs.h>
-#include <linux/blk.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <linux/blkdev.h>
+#include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <scsi/scsicam.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
 
 #include "scsi.h"
 #include "hosts.h"
@@ -368,8 +369,6 @@
 		INIT_LIST_HEAD(&adapter->completed_list);
 
 		adapter->flag = flag;
-		spin_lock_init(&adapter->lock);
-		scsi_assign_lock(host, &adapter->lock);
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;
@@ -1754,7 +1753,7 @@
 	/*
 	 * loop till F/W has more commands for us to complete.
 	 */
-	spin_lock_irqsave(&adapter->lock, flags);
+	spin_lock_irqsave(adapter->host->host_lock, flags);
 
 	do {
 		/* Check if a valid interrupt is pending */
@@ -1800,7 +1799,7 @@
 
  out_unlock:
 
-	spin_unlock_irqrestore(&adapter->lock, flags);
+	spin_unlock_irqrestore(adapter->host->host_lock, flags);
 
 	return IRQ_RETVAL(handled);
 }
@@ -1831,7 +1830,7 @@
 	/*
 	 * loop till F/W has more commands for us to complete.
 	 */
-	spin_lock_irqsave(&adapter->lock, flags);
+	spin_lock_irqsave(adapter->host->host_lock, flags);
 
 	do {
 		/* Check if a valid interrupt is pending */
@@ -1880,7 +1879,7 @@
 
  out_unlock:
 
-	spin_unlock_irqrestore(&adapter->lock, flags);
+	spin_unlock_irqrestore(adapter->host->host_lock, flags);
 
 	return IRQ_RETVAL(handled);
 }
@@ -2608,7 +2607,7 @@
 	mc.cmd = MEGA_CLUSTER_CMD;
 	mc.opcode = MEGA_RESET_RESERVATIONS;
 
-	spin_unlock_irq(&adapter->lock);
+	spin_unlock_irq(adapter->host->host_lock);
 	if( mega_internal_command(adapter, LOCK_INT, &mc, NULL) != 0 ) {
 		printk(KERN_WARNING
 				"megaraid: reservation reset failed.\n");
@@ -2616,7 +2615,7 @@
 	else {
 		printk(KERN_INFO "megaraid: reservation reset.\n");
 	}
-	spin_lock_irq(&adapter->lock);
+	spin_lock_irq(adapter->host->host_lock);
 #endif
 
 	rval =  megaraid_abort_and_reset(adapter, cmd, SCB_RESET);
@@ -4860,7 +4859,7 @@
 
 	rval = mega_do_del_logdrv(adapter, logdrv);
 
-	spin_lock_irqsave(&adapter->lock, flags);
+	spin_lock_irqsave(adapter->host->host_lock, flags);
 
 	/*
 	 * If delete operation was successful, add 0x80 to the logical drive
@@ -4879,7 +4878,7 @@
 
 	mega_runpendq(adapter);
 
-	spin_unlock_irqrestore(&adapter->lock, flags);
+	spin_unlock_irqrestore(adapter->host->host_lock, flags);
 
 	return rval;
 }
@@ -5258,11 +5257,11 @@
 	/*
 	 * Get the lock only if the caller has not acquired it already
 	 */
-	if( ls == LOCK_INT ) spin_lock_irqsave(&adapter->lock, flags);
-
+	if( ls == LOCK_INT )
+		spin_lock_irqsave(adapter->host->host_lock, flags);
 	megaraid_queue(scmd, mega_internal_done);
-
-	if( ls == LOCK_INT ) spin_unlock_irqrestore(&adapter->lock, flags);
+	if( ls == LOCK_INT )
+		spin_unlock_irqrestore(adapter->host->host_lock, flags);
 
 	/*
 	 * Wait till this command finishes. Do not use
diff -Nru a/drivers/scsi/megaraid.h b/drivers/scsi/megaraid.h
--- a/drivers/scsi/megaraid.h	Mon Jun 23 11:03:07 2003
+++ b/drivers/scsi/megaraid.h	Mon Jun 23 11:03:07 2003
@@ -1,10 +1,6 @@
 #ifndef __MEGARAID_H__
 #define __MEGARAID_H__
 
-#include <linux/version.h>
-#include <linux/spinlock.h>
-
-
 #define MEGARAID_VERSION	\
 	"v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST 2003)\n"
 
@@ -879,8 +875,6 @@
 					   drive needs to be done. Stop
 					   sending requests to the hba till
 					   delete operation is completed */
-	spinlock_t	lock;
-
 	u8	logdrv_chan[MAX_CHANNELS+NVIRT_CHAN]; /* logical drive are on
 							what channels. */
 	int	mega_ch_class;
