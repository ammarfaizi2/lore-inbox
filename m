Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUCPQmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUCPQmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:42:21 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:16144 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id S263345AbUCPQaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:30:21 -0500
Date: Tue, 16 Mar 2004 10:41:24 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray patches for 2.6 [3 of 5]
Message-ID: <20040316164124.GC21377@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third of 5 patches for cpqarray. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
   * cpqarray in kernel 2.6.1 seems to be based from 2.4.18 kernel with
     specific 2.6.x stuff added.
   * Defines io_mem_addr and io_mem_length to replace ioaddr (change from
     2.4.18 to 2.4.19)



 drivers/block/cpqarray.c |    6 +++---
 drivers/block/cpqarray.h |    3 ++-
 drivers/block/smart1,2.h |   42 +++++++++++++++++++++---------------------
 3 files changed, 26 insertions(+), 25 deletions(-)

--- linux-2.6.1/drivers/block/cpqarray.c~cpqarray_io_mem	2004-02-11 18:00:05.691060480 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.c	2004-02-11 18:00:05.698059416 -0600
@@ -224,7 +224,7 @@ static int ida_proc_get_info(char *buffe
 		(unsigned long)h->board_id,
 		h->firm_rev[0], h->firm_rev[1], h->firm_rev[2], h->firm_rev[3],
 		(unsigned long)h->ctlr_sig, (unsigned long)h->vaddr,
-		(unsigned int) h->ioaddr, (unsigned int)h->intr,
+		(unsigned int) h->io_mem_addr, (unsigned int)h->intr,
 		h->log_drives, h->phys_drives,
 		h->Qdepth, h->maxQsinceinit);
 
@@ -570,7 +570,7 @@ DBGINFO(
 );
 
 	c->intr = irq;
-	c->ioaddr = addr[0];
+	c->io_mem_addr = addr[0];
 
 	c->paddr = 0;
 	for(i=0; i<6; i++)
@@ -678,7 +678,7 @@ static int cpqarray_eisa_detect(void)
 			continue;
 		}
 		memset(hba[nr_ctlr], 0, sizeof(ctlr_info_t));
-		hba[nr_ctlr]->ioaddr = eisa[i];
+		hba[nr_ctlr]->io_mem_addr = eisa[i];
 
 		/*
 		 * Read the config register to find our interrupt
--- linux-2.6.1/drivers/block/cpqarray.h~cpqarray_io_mem	2004-02-11 18:00:05.693060176 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.h	2004-02-11 18:00:05.698059416 -0600
@@ -92,7 +92,8 @@ struct ctlr_info {
 
 	void *vaddr;
 	unsigned long paddr;
-	unsigned long ioaddr;
+	unsigned long io_mem_addr;
+	unsigned long io_mem_length;
 	int	intr;
 	int	usage_count;
 	drv_info_t	drv[NWD];
--- linux-2.6.1/drivers/block/smart1,2.h~cpqarray_io_mem	2004-02-11 18:00:05.695059872 -0600
+++ linux-2.6.1-root/drivers/block/smart1,2.h	2004-02-11 18:00:05.699059264 -0600
@@ -156,27 +156,27 @@ static struct access_method smart2_acces
  */
 static void smart2e_submit_command(ctlr_info_t *h, cmdlist_t *c)
 {
-	outl(c->busaddr, h->ioaddr + COMMAND_FIFO);
+	outl(c->busaddr, h->io_mem_addr + COMMAND_FIFO);
 }
 
 static void smart2e_intr_mask(ctlr_info_t *h, unsigned long val)
 {
-	outl(val, h->ioaddr + INTR_MASK);
+	outl(val, h->io_mem_addr + INTR_MASK);
 }
 
 static unsigned long smart2e_fifo_full(ctlr_info_t *h)
 {
-	return inl(h->ioaddr + COMMAND_FIFO);
+	return inl(h->io_mem_addr + COMMAND_FIFO);
 }
 
 static unsigned long smart2e_completed(ctlr_info_t *h)
 {
-	return inl(h->ioaddr + COMMAND_COMPLETE_FIFO);
+	return inl(h->io_mem_addr + COMMAND_COMPLETE_FIFO);
 }
 
 static unsigned long smart2e_intr_pending(ctlr_info_t *h)
 {
-	return inl(h->ioaddr + INTR_PENDING);
+	return inl(h->io_mem_addr + INTR_PENDING);
 }
 
 static struct access_method smart2e_access = {
@@ -212,30 +212,30 @@ static void smart1_submit_command(ctlr_i
 	 */
 	c->hdr.size = 0;
 
-	outb(CHANNEL_CLEAR, h->ioaddr + SMART1_SYSTEM_DOORBELL);
+	outb(CHANNEL_CLEAR, h->io_mem_addr + SMART1_SYSTEM_DOORBELL);
 
-	outl(c->busaddr, h->ioaddr + SMART1_LISTADDR);
-	outw(c->size, h->ioaddr + SMART1_LISTLEN);
+	outl(c->busaddr, h->io_mem_addr + SMART1_LISTADDR);
+	outw(c->size, h->io_mem_addr + SMART1_LISTLEN);
 
-	outb(CHANNEL_BUSY, h->ioaddr + SMART1_LOCAL_DOORBELL);
+	outb(CHANNEL_BUSY, h->io_mem_addr + SMART1_LOCAL_DOORBELL);
 }
 
 static void smart1_intr_mask(ctlr_info_t *h, unsigned long val)
 {
 	if (val == 1) {
-		outb(0xFD, h->ioaddr + SMART1_SYSTEM_DOORBELL);
-		outb(CHANNEL_BUSY, h->ioaddr + SMART1_LOCAL_DOORBELL);
-		outb(0x01, h->ioaddr + SMART1_INTR_MASK);
-		outb(0x01, h->ioaddr + SMART1_SYSTEM_MASK);
+		outb(0xFD, h->io_mem_addr + SMART1_SYSTEM_DOORBELL);
+		outb(CHANNEL_BUSY, h->io_mem_addr + SMART1_LOCAL_DOORBELL);
+		outb(0x01, h->io_mem_addr + SMART1_INTR_MASK);
+		outb(0x01, h->io_mem_addr + SMART1_SYSTEM_MASK);
 	} else {
-		outb(0, h->ioaddr + 0xC8E);
+		outb(0, h->io_mem_addr + 0xC8E);
 	}
 }
 
 static unsigned long smart1_fifo_full(ctlr_info_t *h)
 {
 	unsigned char chan;
-	chan = inb(h->ioaddr + SMART1_SYSTEM_DOORBELL) & CHANNEL_CLEAR;
+	chan = inb(h->io_mem_addr + SMART1_SYSTEM_DOORBELL) & CHANNEL_CLEAR;
 	return chan;
 }
 
@@ -244,13 +244,13 @@ static unsigned long smart1_completed(ct
 	unsigned char status;
 	unsigned long cmd;
 
-	if (inb(h->ioaddr + SMART1_SYSTEM_DOORBELL) & CHANNEL_BUSY) {
-		outb(CHANNEL_BUSY, h->ioaddr + SMART1_SYSTEM_DOORBELL);
+	if (inb(h->io_mem_addr + SMART1_SYSTEM_DOORBELL) & CHANNEL_BUSY) {
+		outb(CHANNEL_BUSY, h->io_mem_addr + SMART1_SYSTEM_DOORBELL);
 
-		cmd = inl(h->ioaddr + SMART1_COMPLETE_ADDR);
-		status = inb(h->ioaddr + SMART1_LISTSTATUS);
+		cmd = inl(h->io_mem_addr + SMART1_COMPLETE_ADDR);
+		status = inb(h->io_mem_addr + SMART1_LISTSTATUS);
 
-		outb(CHANNEL_CLEAR, h->ioaddr + SMART1_LOCAL_DOORBELL);
+		outb(CHANNEL_CLEAR, h->io_mem_addr + SMART1_LOCAL_DOORBELL);
 
 		/*
 		 * this is x86 (actually compaq x86) only, so it's ok
@@ -265,7 +265,7 @@ static unsigned long smart1_completed(ct
 static unsigned long smart1_intr_pending(ctlr_info_t *h)
 {
 	unsigned char chan;
-	chan = inb(h->ioaddr + SMART1_SYSTEM_DOORBELL) & CHANNEL_BUSY;
+	chan = inb(h->io_mem_addr + SMART1_SYSTEM_DOORBELL) & CHANNEL_BUSY;
 	return chan;
 }
 

_
