Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757451AbWK1WEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbWK1WEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757453AbWK1WEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:04:34 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:57219 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1757451AbWK1WEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:04:32 -0500
Date: Tue, 28 Nov 2006 22:04:13 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] Pass struct dev pointer to dma_cache_sync()
Message-ID: <20061128220413.GA30639@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So following the previous patch to pass a struct dev pointer to
dma_is_consistent() there is still dma_cache_sync left which does not
receive a dev pointer.

  Ralf

---------

Pass struct dev pointer to dma_cache_sync()
    
dma_cache_sync() is ill-designed in that it does not have a struct
device pointer argument which makes proper support for systems that consist
of a mix of coherent and non-coherent DMA devices hard.  Change
dma_cache_sync to take a struct device pointer as first argument and fix
all its callers to pass it.
    
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 Documentation/DMA-API.txt         |    2 -
 arch/avr32/mm/dma-coherent.c      |    2 -
 arch/mips/mm/dma-coherent.c       |    2 -
 arch/mips/mm/dma-ip27.c           |    2 -
 arch/mips/mm/dma-ip32.c           |    3 +
 arch/mips/mm/dma-noncoherent.c    |    3 +
 drivers/net/lasi_82596.c          |   94 +++++++++++++++++++------------------
 drivers/scsi/53c700.c             |   80 +++++++++++++++++--------------
 drivers/scsi/53c700.h             |   16 +++---
 drivers/serial/mpsc.c             |   22 ++++-----
 include/asm-alpha/dma-mapping.h   |    2 -
 include/asm-avr32/dma-mapping.h   |    3 +
 include/asm-cris/dma-mapping.h    |    2 -
 include/asm-frv/dma-mapping.h     |    2 -
 include/asm-generic/dma-mapping.h |    2 -
 include/asm-i386/dma-mapping.h    |    2 -
 include/asm-ia64/dma-mapping.h    |    3 +
 include/asm-m68k/dma-mapping.h    |    2 -
 include/asm-mips/dma-mapping.h    |    2 -
 include/asm-parisc/dma-mapping.h  |    2 -
 include/asm-powerpc/dma-mapping.h |    2 -
 include/asm-sh/dma-mapping.h      |    2 -
 include/asm-sh64/dma-mapping.h    |    2 -
 include/asm-sparc64/dma-mapping.h |    2 -
 include/asm-um/dma-mapping.h      |    2 -
 include/asm-x86_64/dma-mapping.h  |    3 +
 include/asm-xtensa/dma-mapping.h  |    2 -
 27 files changed, 137 insertions(+), 126 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 6e826f4..b3dafd5 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -459,7 +459,7 @@ anything like this.  You must also be ex
 memory you intend to sync partially.
 
 void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 
 Do a partial sync of memory that was allocated by
diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
index 44ab8a7..b68d669 100644
--- a/arch/avr32/mm/dma-coherent.c
+++ b/arch/avr32/mm/dma-coherent.c
@@ -11,7 +11,7 @@ #include <linux/dma-mapping.h>
 #include <asm/addrspace.h>
 #include <asm/cacheflush.h>
 
-void dma_cache_sync(void *vaddr, size_t size, int direction)
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size, int direction)
 {
 	/*
 	 * No need to sync an uncached area
diff --git a/arch/mips/mm/dma-coherent.c b/arch/mips/mm/dma-coherent.c
index 18bc83e..5697c6e 100644
--- a/arch/mips/mm/dma-coherent.c
+++ b/arch/mips/mm/dma-coherent.c
@@ -197,7 +197,7 @@ int dma_is_consistent(struct device *dev
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size,
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
diff --git a/arch/mips/mm/dma-ip27.c b/arch/mips/mm/dma-ip27.c
index 8e9a5a8..f088344 100644
--- a/arch/mips/mm/dma-ip27.c
+++ b/arch/mips/mm/dma-ip27.c
@@ -204,7 +204,7 @@ int dma_is_consistent(struct device *dev
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size,
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
diff --git a/arch/mips/mm/dma-ip32.c b/arch/mips/mm/dma-ip32.c
index 08720a4..b42b6f7 100644
--- a/arch/mips/mm/dma-ip32.c
+++ b/arch/mips/mm/dma-ip32.c
@@ -370,7 +370,8 @@ int dma_is_consistent(struct device *dev
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+	enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		return;
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 4a3efc6..8cecef0 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -306,7 +306,8 @@ int dma_is_consistent(struct device *dev
 
 EXPORT_SYMBOL(dma_is_consistent);
 
-void dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction direction)
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+	enum dma_data_direction direction)
 {
 	if (direction == DMA_NONE)
 		return;
diff --git a/drivers/net/lasi_82596.c b/drivers/net/lasi_82596.c
index f4d815b..ea392f2 100644
--- a/drivers/net/lasi_82596.c
+++ b/drivers/net/lasi_82596.c
@@ -119,14 +119,14 @@ #define DEB_ANY		0xffff
 #define DEB(x,y)	if (i596_debug & (x)) { y; }
 
 
-#define  CHECK_WBACK(addr,len) \
-	do { dma_cache_sync((void *)addr, len, DMA_TO_DEVICE); } while (0)
+#define  CHECK_WBACK(priv, addr,len) \
+	do { dma_cache_sync((priv)->dev, (void *)addr, len, DMA_TO_DEVICE); } while (0)
 
-#define  CHECK_INV(addr,len) \
-	do { dma_cache_sync((void *)addr, len, DMA_FROM_DEVICE); } while(0)
+#define  CHECK_INV(priv, addr,len) \
+	do { dma_cache_sync((priv)->dev, (void *)addr, len, DMA_FROM_DEVICE); } while(0)
 
-#define  CHECK_WBACK_INV(addr,len) \
-	do { dma_cache_sync((void *)addr, len, DMA_BIDIRECTIONAL); } while (0)
+#define  CHECK_WBACK_INV(priv, addr,len) \
+	do { dma_cache_sync((priv)->dev, (void *)addr, len, DMA_BIDIRECTIONAL); } while (0)
 
 
 #define PA_I82596_RESET		0	/* Offsets relative to LASI-LAN-Addr.*/
@@ -449,10 +449,10 @@ static inline void MPU_PORT(struct net_d
 
 static inline int wait_istat(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)
 {
-	CHECK_INV(&(lp->iscp), sizeof(struct i596_iscp));
+	CHECK_INV(lp, &(lp->iscp), sizeof(struct i596_iscp));
 	while (--delcnt && lp->iscp.stat) {
 		udelay(10);
-		CHECK_INV(&(lp->iscp), sizeof(struct i596_iscp));
+		CHECK_INV(lp, &(lp->iscp), sizeof(struct i596_iscp));
 	}
 	if (!delcnt) {
 		printk("%s: %s, iscp.stat %04x, didn't clear\n",
@@ -466,10 +466,10 @@ static inline int wait_istat(struct net_
 
 static inline int wait_cmd(struct net_device *dev, struct i596_private *lp, int delcnt, char *str)
 {
-	CHECK_INV(&(lp->scb), sizeof(struct i596_scb));
+	CHECK_INV(lp, &(lp->scb), sizeof(struct i596_scb));
 	while (--delcnt && lp->scb.command) {
 		udelay(10);
-		CHECK_INV(&(lp->scb), sizeof(struct i596_scb));
+		CHECK_INV(lp, &(lp->scb), sizeof(struct i596_scb));
 	}
 	if (!delcnt) {
 		printk("%s: %s, status %4.4x, cmd %4.4x.\n",
@@ -522,7 +522,7 @@ static void i596_display_data(struct net
 			rbd, rbd->count, rbd->b_next, rbd->b_data, rbd->size);
 		rbd = rbd->v_next;
 	} while (rbd != lp->rbd_head);
-	CHECK_INV(lp, sizeof(struct i596_private));
+	CHECK_INV(lp, lp, sizeof(struct i596_private));
 }
 
 
@@ -592,7 +592,7 @@ static inline void init_rx_bufs(struct n
 	rfd->b_next = WSWAPrfd(virt_to_dma(lp,lp->rfds));
 	rfd->cmd = CMD_EOL|CMD_FLEX;
 
-	CHECK_WBACK_INV(lp, sizeof(struct i596_private));
+	CHECK_WBACK_INV(lp, lp, sizeof(struct i596_private));
 }
 
 static inline void remove_rx_bufs(struct net_device *dev)
@@ -629,7 +629,7 @@ static void rebuild_rx_bufs(struct net_d
 	lp->rbd_head = lp->rbds;
 	lp->rfds[0].rbd = WSWAPrbd(virt_to_dma(lp,lp->rbds));
 
-	CHECK_WBACK_INV(lp, sizeof(struct i596_private));
+	CHECK_WBACK_INV(lp, lp, sizeof(struct i596_private));
 }
 
 
@@ -663,8 +663,8 @@ static int init_i596_mem(struct net_devi
 
 	DEB(DEB_INIT, printk("%s: starting i82596.\n", dev->name));
 
-	CHECK_WBACK(&(lp->scp), sizeof(struct i596_scp));
-	CHECK_WBACK(&(lp->iscp), sizeof(struct i596_iscp));
+	CHECK_WBACK(lp, &(lp->scp), sizeof(struct i596_scp));
+	CHECK_WBACK(lp, &(lp->iscp), sizeof(struct i596_iscp));
 
 	MPU_PORT(dev, PORT_ALTSCP, virt_to_dma(lp,&lp->scp));
 
@@ -678,25 +678,25 @@ static int init_i596_mem(struct net_devi
 	rebuild_rx_bufs(dev);
 
 	lp->scb.command = 0;
-	CHECK_WBACK(&(lp->scb), sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &(lp->scb), sizeof(struct i596_scb));
 
 	enable_irq(dev->irq);	/* enable IRQs from LAN */
 
 	DEB(DEB_INIT, printk("%s: queuing CmdConfigure\n", dev->name));
 	memcpy(lp->cf_cmd.i596_config, init_setup, 14);
 	lp->cf_cmd.cmd.command = CmdConfigure;
-	CHECK_WBACK(&(lp->cf_cmd), sizeof(struct cf_cmd));
+	CHECK_WBACK(lp, &(lp->cf_cmd), sizeof(struct cf_cmd));
 	i596_add_cmd(dev, &lp->cf_cmd.cmd);
 
 	DEB(DEB_INIT, printk("%s: queuing CmdSASetup\n", dev->name));
 	memcpy(lp->sa_cmd.eth_addr, dev->dev_addr, 6);
 	lp->sa_cmd.cmd.command = CmdSASetup;
-	CHECK_WBACK(&(lp->sa_cmd), sizeof(struct sa_cmd));
+	CHECK_WBACK(lp, &(lp->sa_cmd), sizeof(struct sa_cmd));
 	i596_add_cmd(dev, &lp->sa_cmd.cmd);
 
 	DEB(DEB_INIT, printk("%s: queuing CmdTDR\n", dev->name));
 	lp->tdr_cmd.cmd.command = CmdTDR;
-	CHECK_WBACK(&(lp->tdr_cmd), sizeof(struct tdr_cmd));
+	CHECK_WBACK(lp, &(lp->tdr_cmd), sizeof(struct tdr_cmd));
 	i596_add_cmd(dev, &lp->tdr_cmd.cmd);
 
 	spin_lock_irqsave (&lp->lock, flags);
@@ -708,7 +708,7 @@ static int init_i596_mem(struct net_devi
 	DEB(DEB_INIT, printk("%s: Issuing RX_START\n", dev->name));
 	lp->scb.command = RX_START;
 	lp->scb.rfd = WSWAPrfd(virt_to_dma(lp,lp->rfds));
-	CHECK_WBACK(&(lp->scb), sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &(lp->scb), sizeof(struct i596_scb));
 
 	CA(dev);
 
@@ -740,13 +740,13 @@ static inline int i596_rx(struct net_dev
 
 	rfd = lp->rfd_head;		/* Ref next frame to check */
 
-	CHECK_INV(rfd, sizeof(struct i596_rfd));
+	CHECK_INV(lp, rfd, sizeof(struct i596_rfd));
 	while ((rfd->stat) & STAT_C) {	/* Loop while complete frames */
 		if (rfd->rbd == I596_NULL)
 			rbd = NULL;
 		else if (rfd->rbd == lp->rbd_head->b_addr) {
 			rbd = lp->rbd_head;
-			CHECK_INV(rbd, sizeof(struct i596_rbd));
+			CHECK_INV(lp, rbd, sizeof(struct i596_rbd));
 		}
 		else {
 			printk("%s: rbd chain broken!\n", dev->name);
@@ -790,7 +790,7 @@ static inline int i596_rx(struct net_dev
 				dma_addr = dma_map_single(lp->dev, newskb->data, PKT_BUF_SZ, DMA_FROM_DEVICE);
 				rbd->v_data = newskb->data;
 				rbd->b_data = WSWAPchar(dma_addr);
-				CHECK_WBACK_INV(rbd, sizeof(struct i596_rbd));
+				CHECK_WBACK_INV(lp, rbd, sizeof(struct i596_rbd));
 			}
 			else
 				skb = dev_alloc_skb(pkt_len + 2);
@@ -842,7 +842,7 @@ memory_squeeze:
 		if (rbd != NULL && (rbd->count & 0x4000)) {
 			rbd->count = 0;
 			lp->rbd_head = rbd->v_next;
-			CHECK_WBACK_INV(rbd, sizeof(struct i596_rbd));
+			CHECK_WBACK_INV(lp, rbd, sizeof(struct i596_rbd));
 		}
 
 		/* Tidy the frame descriptor, marking it as end of list */
@@ -860,10 +860,10 @@ memory_squeeze:
 
 		lp->scb.rfd = rfd->b_next;
 		lp->rfd_head = rfd->v_next;
-		CHECK_WBACK_INV(rfd->v_prev, sizeof(struct i596_rfd));
-		CHECK_WBACK_INV(rfd, sizeof(struct i596_rfd));
+		CHECK_WBACK_INV(lp, rfd->v_prev, sizeof(struct i596_rfd));
+		CHECK_WBACK_INV(lp, rfd, sizeof(struct i596_rfd));
 		rfd = lp->rfd_head;
-		CHECK_INV(rfd, sizeof(struct i596_rfd));
+		CHECK_INV(lp, rfd, sizeof(struct i596_rfd));
 	}
 
 	DEB(DEB_RXFRAME, printk("frames %d\n", frames));
@@ -902,12 +902,12 @@ static inline void i596_cleanup_cmd(stru
 			ptr->v_next = NULL;
 			ptr->b_next = I596_NULL;
 		}
-		CHECK_WBACK_INV(ptr, sizeof(struct i596_cmd));
+		CHECK_WBACK_INV(lp, ptr, sizeof(struct i596_cmd));
 	}
 
 	wait_cmd(dev, lp, 100, "i596_cleanup_cmd timed out");
 	lp->scb.cmd = I596_NULL;
-	CHECK_WBACK(&(lp->scb), sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &(lp->scb), sizeof(struct i596_scb));
 }
 
 
@@ -925,7 +925,7 @@ static inline void i596_reset(struct net
 
 	/* FIXME: this command might cause an lpmc */
 	lp->scb.command = CUC_ABORT | RX_ABORT;
-	CHECK_WBACK(&(lp->scb), sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &(lp->scb), sizeof(struct i596_scb));
 	CA(dev);
 
 	/* wait for shutdown */
@@ -951,20 +951,20 @@ static void i596_add_cmd(struct net_devi
 	cmd->command |= (CMD_EOL | CMD_INTR);
 	cmd->v_next = NULL;
 	cmd->b_next = I596_NULL;
-	CHECK_WBACK(cmd, sizeof(struct i596_cmd));
+	CHECK_WBACK(lp, cmd, sizeof(struct i596_cmd));
 
 	spin_lock_irqsave (&lp->lock, flags);
 
 	if (lp->cmd_head != NULL) {
 		lp->cmd_tail->v_next = cmd;
 		lp->cmd_tail->b_next = WSWAPcmd(virt_to_dma(lp,&cmd->status));
-		CHECK_WBACK(lp->cmd_tail, sizeof(struct i596_cmd));
+		CHECK_WBACK(lp, lp->cmd_tail, sizeof(struct i596_cmd));
 	} else {
 		lp->cmd_head = cmd;
 		wait_cmd(dev, lp, 100, "i596_add_cmd timed out");
 		lp->scb.cmd = WSWAPcmd(virt_to_dma(lp,&cmd->status));
 		lp->scb.command = CUC_START;
-		CHECK_WBACK(&(lp->scb), sizeof(struct i596_scb));
+		CHECK_WBACK(lp, &(lp->scb), sizeof(struct i596_scb));
 		CA(dev);
 	}
 	lp->cmd_tail = cmd;
@@ -998,12 +998,12 @@ static int i596_test(struct net_device *
 	data = virt_to_dma(lp,tint);
 
 	tint[1] = -1;
-	CHECK_WBACK(tint,PAGE_SIZE);
+	CHECK_WBACK(lp, tint, PAGE_SIZE);
 
 	MPU_PORT(dev, 1, data);
 
 	for(data = 1000000; data; data--) {
-		CHECK_INV(tint,PAGE_SIZE);
+		CHECK_INV(lp, tint, PAGE_SIZE);
 		if(tint[1] != -1)
 			break;
 
@@ -1061,7 +1061,7 @@ static void i596_tx_timeout (struct net_
 		/* Issue a channel attention signal */
 		DEB(DEB_ERRORS, printk("Kicking board.\n"));
 		lp->scb.command = CUC_START | RX_START;
-		CHECK_WBACK_INV(&(lp->scb), sizeof(struct i596_scb));
+		CHECK_WBACK_INV(lp, &(lp->scb), sizeof(struct i596_scb));
 		CA (dev);
 		lp->last_restart = lp->stats.tx_packets;
 	}
@@ -1118,8 +1118,8 @@ static int i596_start_xmit(struct sk_buf
 		tbd->data = WSWAPchar(tx_cmd->dma_addr);
 
 		DEB(DEB_TXADDR,print_eth(skb->data, "tx-queued"));
-		CHECK_WBACK_INV(tx_cmd, sizeof(struct tx_cmd));
-		CHECK_WBACK_INV(tbd, sizeof(struct i596_tbd));
+		CHECK_WBACK_INV(lp, tx_cmd, sizeof(struct tx_cmd));
+		CHECK_WBACK_INV(lp, tbd, sizeof(struct i596_tbd));
 		i596_add_cmd(dev, &tx_cmd->cmd);
 
 		lp->stats.tx_packets++;
@@ -1228,7 +1228,7 @@ #endif
 	lp->dma_addr = dma_addr;
 	lp->dev = gen_dev;
 
-	CHECK_WBACK_INV(dev->mem_start, sizeof(struct i596_private));
+	CHECK_WBACK_INV(lp, dev->mem_start, sizeof(struct i596_private));
 
 	i = register_netdev(dev);
 	if (i) {
@@ -1295,7 +1295,7 @@ static irqreturn_t i596_interrupt(int ir
 			DEB(DEB_INTS, printk("%s: i596 interrupt command unit inactive %x.\n", dev->name, status & 0x0700));
 
 		while (lp->cmd_head != NULL) {
-			CHECK_INV(lp->cmd_head, sizeof(struct i596_cmd));
+			CHECK_INV(lp, lp->cmd_head, sizeof(struct i596_cmd));
 			if (!(lp->cmd_head->status & STAT_C))
 				break;
 
@@ -1358,7 +1358,7 @@ static irqreturn_t i596_interrupt(int ir
 			}
 			ptr->v_next = NULL;
 		        ptr->b_next = I596_NULL;
-			CHECK_WBACK(ptr, sizeof(struct i596_cmd));
+			CHECK_WBACK(lp, ptr, sizeof(struct i596_cmd));
 			lp->last_cmd = jiffies;
 		}
 
@@ -1372,13 +1372,13 @@ static irqreturn_t i596_interrupt(int ir
 
 			ptr->command &= 0x1fff;
 			ptr = ptr->v_next;
-			CHECK_WBACK_INV(prev, sizeof(struct i596_cmd));
+			CHECK_WBACK_INV(lp, prev, sizeof(struct i596_cmd));
 		}
 
 		if ((lp->cmd_head != NULL))
 			ack_cmd |= CUC_START;
 		lp->scb.cmd = WSWAPcmd(virt_to_dma(lp,&lp->cmd_head->status));
-		CHECK_WBACK_INV(&lp->scb, sizeof(struct i596_scb));
+		CHECK_WBACK_INV(lp, &lp->scb, sizeof(struct i596_scb));
 	}
 	if ((status & 0x1000) || (status & 0x4000)) {
 		if ((status & 0x4000))
@@ -1397,7 +1397,7 @@ static irqreturn_t i596_interrupt(int ir
 	}
 	wait_cmd(dev, lp, 100, "i596 interrupt, timeout");
 	lp->scb.command = ack_cmd;
-	CHECK_WBACK(&lp->scb, sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &lp->scb, sizeof(struct i596_scb));
 
 	/* DANGER: I suspect that some kind of interrupt
 	 acknowledgement aside from acking the 82596 might be needed
@@ -1426,7 +1426,7 @@ static int i596_close(struct net_device 
 
 	wait_cmd(dev, lp, 100, "close1 timed out");
 	lp->scb.command = CUC_ABORT | RX_ABORT;
-	CHECK_WBACK(&lp->scb, sizeof(struct i596_scb));
+	CHECK_WBACK(lp, &lp->scb, sizeof(struct i596_scb));
 
 	CA(dev);
 
@@ -1486,7 +1486,7 @@ static void set_multicast_list(struct ne
 			       dev->name);
 		else {
 			lp->cf_cmd.cmd.command = CmdConfigure;
-			CHECK_WBACK_INV(&lp->cf_cmd, sizeof(struct cf_cmd));
+			CHECK_WBACK_INV(lp, &lp->cf_cmd, sizeof(struct cf_cmd));
 			i596_add_cmd(dev, &lp->cf_cmd.cmd);
 		}
 	}
@@ -1514,7 +1514,7 @@ static void set_multicast_list(struct ne
 				DEB(DEB_MULTI, printk("%s: Adding address %02x:%02x:%02x:%02x:%02x:%02x\n",
 						dev->name, cp[0],cp[1],cp[2],cp[3],cp[4],cp[5]));
 		}
-		CHECK_WBACK_INV(&lp->mc_cmd, sizeof(struct mc_cmd));
+		CHECK_WBACK_INV(lp, &lp->mc_cmd, sizeof(struct mc_cmd));
 		i596_add_cmd(dev, &cmd->cmd);
 	}
 }
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 3741f92..f10b1d9 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -362,11 +362,11 @@ NCR_700_detect(struct scsi_host_template
 	for (j = 0; j < PATCHES; j++)
 		script[LABELPATCHES[j]] = bS_to_host(pScript + SCRIPT[LABELPATCHES[j]]);
 	/* now patch up fixed addresses. */
-	script_patch_32(script, MessageLocation,
+	script_patch_32(hostdata->dev, script, MessageLocation,
 			pScript + MSGOUT_OFFSET);
-	script_patch_32(script, StatusAddress,
+	script_patch_32(hostdata->dev, script, StatusAddress,
 			pScript + STATUS_OFFSET);
-	script_patch_32(script, ReceiveMsgAddress,
+	script_patch_32(hostdata->dev, script, ReceiveMsgAddress,
 			pScript + MSGIN_OFFSET);
 
 	hostdata->script = script;
@@ -819,8 +819,9 @@ process_extended_message(struct Scsi_Hos
 			shost_printk(KERN_WARNING, host,
 				"Unexpected SDTR msg\n");
 			hostdata->msgout[0] = A_REJECT_MSG;
-			dma_cache_sync(hostdata->msgout, 1, DMA_TO_DEVICE);
-			script_patch_16(hostdata->script, MessageCount, 1);
+			dma_cache_sync(hostdata->dev, hostdata->msgout, 1, DMA_TO_DEVICE);
+			script_patch_16(hostdata->dev, hostdata->script,
+			                MessageCount, 1);
 			/* SendMsgOut returns, so set up the return
 			 * address */
 			resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
@@ -831,8 +832,9 @@ process_extended_message(struct Scsi_Hos
 		printk(KERN_INFO "scsi%d: (%d:%d), Unsolicited WDTR after CMD, Rejecting\n",
 		       host->host_no, pun, lun);
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_sync(hostdata->msgout, 1, DMA_TO_DEVICE);
-		script_patch_16(hostdata->script, MessageCount, 1);
+		dma_cache_sync(hostdata->dev, hostdata->msgout, 1, DMA_TO_DEVICE);
+		script_patch_16(hostdata->dev, hostdata->script, MessageCount,
+		                1);
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
 
 		break;
@@ -845,8 +847,9 @@ process_extended_message(struct Scsi_Hos
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_sync(hostdata->msgout, 1, DMA_TO_DEVICE);
-		script_patch_16(hostdata->script, MessageCount, 1);
+		dma_cache_sync(hostdata->dev, hostdata->msgout, 1, DMA_TO_DEVICE);
+		script_patch_16(hostdata->dev, hostdata->script, MessageCount,
+		                1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
@@ -927,8 +930,9 @@ #endif
 		printk("\n");
 		/* just reject it */
 		hostdata->msgout[0] = A_REJECT_MSG;
-		dma_cache_sync(hostdata->msgout, 1, DMA_TO_DEVICE);
-		script_patch_16(hostdata->script, MessageCount, 1);
+		dma_cache_sync(hostdata->dev, hostdata->msgout, 1, DMA_TO_DEVICE);
+		script_patch_16(hostdata->dev, hostdata->script, MessageCount,
+		                1);
 		/* SendMsgOut returns, so set up the return
 		 * address */
 		resume_offset = hostdata->pScript + Ent_SendMessageWithATN;
@@ -937,7 +941,7 @@ #endif
 	}
 	NCR_700_writel(temp, host, TEMP_REG);
 	/* set us up to receive another message */
-	dma_cache_sync(hostdata->msgin, MSG_ARRAY_SIZE, DMA_FROM_DEVICE);
+	dma_cache_sync(hostdata->dev, hostdata->msgin, MSG_ARRAY_SIZE, DMA_FROM_DEVICE);
 	return resume_offset;
 }
 
@@ -1014,9 +1018,9 @@ #endif
 				slot->SG[1].ins = bS_to_host(SCRIPT_RETURN);
 				slot->SG[1].pAddr = 0;
 				slot->resume_offset = hostdata->pScript;
-				dma_cache_sync(slot->SG, sizeof(slot->SG[0])*2, DMA_TO_DEVICE);
-				dma_cache_sync(SCp->sense_buffer, sizeof(SCp->sense_buffer), DMA_FROM_DEVICE);
-				
+				dma_cache_sync(hostdata->dev, slot->SG, sizeof(slot->SG[0])*2, DMA_TO_DEVICE);
+				dma_cache_sync(hostdata->dev, SCp->sense_buffer, sizeof(SCp->sense_buffer), DMA_FROM_DEVICE);
+
 				/* queue the command for reissue */
 				slot->state = NCR_700_SLOT_QUEUED;
 				slot->flags = NCR_700_FLAG_AUTOSENSE;
@@ -1131,11 +1135,12 @@ #endif
 			hostdata->cmd = slot->cmnd;
 
 			/* re-patch for this command */
-			script_patch_32_abs(hostdata->script, CommandAddress, 
-					    slot->pCmd);
-			script_patch_16(hostdata->script,
+			script_patch_32_abs(hostdata->dev, hostdata->script,
+			                    CommandAddress, slot->pCmd);
+			script_patch_16(hostdata->dev, hostdata->script,
 					CommandCount, slot->cmnd->cmd_len);
-			script_patch_32_abs(hostdata->script, SGScriptStartAddress,
+			script_patch_32_abs(hostdata->dev, hostdata->script,
+			                    SGScriptStartAddress,
 					    to32bit(&slot->pSG[0].ins));
 
 			/* Note: setting SXFER only works if we're
@@ -1145,13 +1150,13 @@ #endif
 			 * should therefore always clear ACK */
 			NCR_700_writeb(NCR_700_get_SXFER(hostdata->cmd->device),
 				       host, SXFER_REG);
-			dma_cache_sync(hostdata->msgin,
+			dma_cache_sync(hostdata->dev, hostdata->msgin,
 				       MSG_ARRAY_SIZE, DMA_FROM_DEVICE);
-			dma_cache_sync(hostdata->msgout,
+			dma_cache_sync(hostdata->dev, hostdata->msgout,
 				       MSG_ARRAY_SIZE, DMA_TO_DEVICE);
 			/* I'm just being paranoid here, the command should
 			 * already have been flushed from the cache */
-			dma_cache_sync(slot->cmnd->cmnd,
+			dma_cache_sync(hostdata->dev, slot->cmnd->cmnd,
 				       slot->cmnd->cmd_len, DMA_TO_DEVICE);
 
 
@@ -1215,7 +1220,7 @@ #endif
 		hostdata->reselection_id = reselection_id;
 		/* just in case we have a stale simple tag message, clear it */
 		hostdata->msgin[1] = 0;
-		dma_cache_sync(hostdata->msgin,
+		dma_cache_sync(hostdata->dev, hostdata->msgin,
 			       MSG_ARRAY_SIZE, DMA_BIDIRECTIONAL);
 		if(hostdata->tag_negotiated & (1<<reselection_id)) {
 			resume_offset = hostdata->pScript + Ent_GetReselectionWithTag;
@@ -1331,7 +1336,7 @@ process_selection(struct Scsi_Host *host
 	hostdata->cmd = NULL;
 	/* clear any stale simple tag message */
 	hostdata->msgin[1] = 0;
-	dma_cache_sync(hostdata->msgin, MSG_ARRAY_SIZE,
+	dma_cache_sync(hostdata->dev, hostdata->msgin, MSG_ARRAY_SIZE,
 		       DMA_BIDIRECTIONAL);
 
 	if(id == 0xff) {
@@ -1428,29 +1433,30 @@ NCR_700_start_command(struct scsi_cmnd *
 		NCR_700_set_flag(SCp->device, NCR_700_DEV_BEGIN_SYNC_NEGOTIATION);
 	}
 
-	script_patch_16(hostdata->script, MessageCount, count);
+	script_patch_16(hostdata->dev, hostdata->script, MessageCount, count);
 
 
-	script_patch_ID(hostdata->script,
+	script_patch_ID(hostdata->dev, hostdata->script,
 			Device_ID, 1<<scmd_id(SCp));
 
-	script_patch_32_abs(hostdata->script, CommandAddress, 
+	script_patch_32_abs(hostdata->dev, hostdata->script, CommandAddress,
 			    slot->pCmd);
-	script_patch_16(hostdata->script, CommandCount, SCp->cmd_len);
+	script_patch_16(hostdata->dev, hostdata->script, CommandCount,
+	                SCp->cmd_len);
 	/* finally plumb the beginning of the SG list into the script
 	 * */
-	script_patch_32_abs(hostdata->script, SGScriptStartAddress,
-			    to32bit(&slot->pSG[0].ins));
+	script_patch_32_abs(hostdata->dev, hostdata->script,
+	                    SGScriptStartAddress, to32bit(&slot->pSG[0].ins));
 	NCR_700_clear_fifo(SCp->device->host);
 
 	if(slot->resume_offset == 0)
 		slot->resume_offset = hostdata->pScript;
 	/* now perform all the writebacks and invalidates */
-	dma_cache_sync(hostdata->msgout, count, DMA_TO_DEVICE);
-	dma_cache_sync(hostdata->msgin, MSG_ARRAY_SIZE,
+	dma_cache_sync(hostdata->dev, hostdata->msgout, count, DMA_TO_DEVICE);
+	dma_cache_sync(hostdata->dev, hostdata->msgin, MSG_ARRAY_SIZE,
 		       DMA_FROM_DEVICE);
-	dma_cache_sync(SCp->cmnd, SCp->cmd_len, DMA_TO_DEVICE);
-	dma_cache_sync(hostdata->status, 1, DMA_FROM_DEVICE);
+	dma_cache_sync(hostdata->dev, SCp->cmnd, SCp->cmd_len, DMA_TO_DEVICE);
+	dma_cache_sync(hostdata->dev, hostdata->status, 1, DMA_FROM_DEVICE);
 
 	/* set the synchronous period/offset */
 	NCR_700_writeb(NCR_700_get_SXFER(SCp->device),
@@ -1626,7 +1632,7 @@ #endif
 					slot->SG[i].ins = bS_to_host(SCRIPT_NOP);
 					slot->SG[i].pAddr = 0;
 				}
-				dma_cache_sync(slot->SG, sizeof(slot->SG), DMA_TO_DEVICE);
+				dma_cache_sync(hostdata->dev, slot->SG, sizeof(slot->SG), DMA_TO_DEVICE);
 				/* and pretend we disconnected after
 				 * the command phase */
 				resume_offset = hostdata->pScript + Ent_MsgInDuringData;
@@ -1892,9 +1898,9 @@ #endif
 		}
 		slot->SG[i].ins = bS_to_host(SCRIPT_RETURN);
 		slot->SG[i].pAddr = 0;
-		dma_cache_sync(slot->SG, sizeof(slot->SG), DMA_TO_DEVICE);
+		dma_cache_sync(hostdata->dev, slot->SG, sizeof(slot->SG), DMA_TO_DEVICE);
 		DEBUG((" SETTING %08lx to %x\n",
-		       (&slot->pSG[i].ins), 
+		       (&slot->pSG[i].ins),
 		       slot->SG[i].ins));
 	}
 	slot->resume_offset = 0;
diff --git a/drivers/scsi/53c700.h b/drivers/scsi/53c700.h
index f5c3caf..f38822d 100644
--- a/drivers/scsi/53c700.h
+++ b/drivers/scsi/53c700.h
@@ -415,31 +415,31 @@ #define NCR_700_MIN_XFERP	1
 #define NCR_710_MIN_XFERP	0
 #define NCR_700_MIN_PERIOD	25 /* for SDTR message, 100ns */
 
-#define script_patch_32(script, symbol, value) \
+#define script_patch_32(dev, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
 		__u32 val = bS_to_cpu((script)[A_##symbol##_used[i]]) + value; \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_cache_sync(&(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
+		dma_cache_sync((dev), &(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
 		DEBUG((" script, patching %s at %d to 0x%lx\n", \
 		       #symbol, A_##symbol##_used[i], (value))); \
 	} \
 }
 
-#define script_patch_32_abs(script, symbol, value) \
+#define script_patch_32_abs(dev, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
 		(script)[A_##symbol##_used[i]] = bS_to_host(value); \
-		dma_cache_sync(&(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
+		dma_cache_sync((dev), &(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
 		DEBUG((" script, patching %s at %d to 0x%lx\n", \
 		       #symbol, A_##symbol##_used[i], (value))); \
 	} \
 }
 
 /* Used for patching the SCSI ID in the SELECT instruction */
-#define script_patch_ID(script, symbol, value) \
+#define script_patch_ID(dev, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
@@ -447,13 +447,13 @@ #define script_patch_ID(script, symbol, 
 		val &= 0xff00ffff; \
 		val |= ((value) & 0xff) << 16; \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_cache_sync(&(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
+		dma_cache_sync((dev), &(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
 		DEBUG((" script, patching ID field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
 }
 
-#define script_patch_16(script, symbol, value) \
+#define script_patch_16(dev, script, symbol, value) \
 { \
 	int i; \
 	for(i=0; i< (sizeof(A_##symbol##_used) / sizeof(__u32)); i++) { \
@@ -461,7 +461,7 @@ #define script_patch_16(script, symbol, 
 		val &= 0xffff0000; \
 		val |= ((value) & 0xffff); \
 		(script)[A_##symbol##_used[i]] = bS_to_host(val); \
-		dma_cache_sync(&(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
+		dma_cache_sync((dev), &(script)[A_##symbol##_used[i]], 4, DMA_TO_DEVICE); \
 		DEBUG((" script, patching short field %s at %d to 0x%x\n", \
 		       #symbol, A_##symbol##_used[i], val)); \
 	} \
diff --git a/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
index 8eea69f..29823bd 100644
--- a/drivers/serial/mpsc.c
+++ b/drivers/serial/mpsc.c
@@ -555,7 +555,7 @@ mpsc_sdma_start_tx(struct mpsc_port_info
 	if (!mpsc_sdma_tx_active(pi)) {
 		txre = (struct mpsc_tx_desc *)(pi->txr +
 			(pi->txr_tail * MPSC_TXRE_SIZE));
-		dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
+		dma_cache_sync(pi->port.dev, (void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			invalidate_dcache_range((ulong)txre,
@@ -931,7 +931,7 @@ mpsc_init_rings(struct mpsc_port_info *p
 	}
 	txre->link = cpu_to_be32(pi->txr_p);	/* Wrap last back to first */
 
-	dma_cache_sync((void *) pi->dma_region, MPSC_DMA_ALLOC_SIZE,
+	dma_cache_sync(pi->port.dev, (void *) pi->dma_region, MPSC_DMA_ALLOC_SIZE,
 		DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
@@ -1005,7 +1005,7 @@ mpsc_rx_intr(struct mpsc_port_info *pi)
 
 	rxre = (struct mpsc_rx_desc *)(pi->rxr + (pi->rxr_posn*MPSC_RXRE_SIZE));
 
-	dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
+	dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 		invalidate_dcache_range((ulong)rxre,
@@ -1029,7 +1029,7 @@ #endif
 		}
 
 		bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE);
-		dma_cache_sync((void *) bp, MPSC_RXBE_SIZE, DMA_FROM_DEVICE);
+		dma_cache_sync(pi->port.dev, (void *) bp, MPSC_RXBE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			invalidate_dcache_range((ulong)bp,
@@ -1098,7 +1098,7 @@ next_frame:
 					    SDMA_DESC_CMDSTAT_F |
 					    SDMA_DESC_CMDSTAT_L);
 		wmb();
-		dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_BIDIRECTIONAL);
+		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			flush_dcache_range((ulong)rxre,
@@ -1109,7 +1109,7 @@ #endif
 		pi->rxr_posn = (pi->rxr_posn + 1) & (MPSC_RXR_ENTRIES - 1);
 		rxre = (struct mpsc_rx_desc *)(pi->rxr +
 			(pi->rxr_posn * MPSC_RXRE_SIZE));
-		dma_cache_sync((void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
+		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			invalidate_dcache_range((ulong)rxre,
@@ -1143,7 +1143,7 @@ mpsc_setup_tx_desc(struct mpsc_port_info
 							   SDMA_DESC_CMDSTAT_EI
 							   : 0));
 	wmb();
-	dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_BIDIRECTIONAL);
+	dma_cache_sync(pi->port.dev, (void *) txre, MPSC_TXRE_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 		flush_dcache_range((ulong)txre,
@@ -1192,7 +1192,7 @@ mpsc_copy_tx_data(struct mpsc_port_info 
 		else /* All tx data copied into ring bufs */
 			return;
 
-		dma_cache_sync((void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
+		dma_cache_sync(pi->port.dev, (void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			flush_dcache_range((ulong)bp,
@@ -1217,7 +1217,7 @@ mpsc_tx_intr(struct mpsc_port_info *pi)
 		txre = (struct mpsc_tx_desc *)(pi->txr +
 			(pi->txr_tail * MPSC_TXRE_SIZE));
 
-		dma_cache_sync((void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
+		dma_cache_sync(pi->port.dev, (void *) txre, MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			invalidate_dcache_range((ulong)txre,
@@ -1235,7 +1235,7 @@ #endif
 
 			txre = (struct mpsc_tx_desc *)(pi->txr +
 				(pi->txr_tail * MPSC_TXRE_SIZE));
-			dma_cache_sync((void *) txre, MPSC_TXRE_SIZE,
+			dma_cache_sync(pi->port.dev, (void *) txre, MPSC_TXRE_SIZE,
 				DMA_FROM_DEVICE);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
@@ -1652,7 +1652,7 @@ mpsc_console_write(struct console *co, c
 			count--;
 		}
 
-		dma_cache_sync((void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
+		dma_cache_sync(pi->port.dev, (void *) bp, MPSC_TXBE_SIZE, DMA_BIDIRECTIONAL);
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
 			flush_dcache_range((ulong)bp,
diff --git a/include/asm-alpha/dma-mapping.h b/include/asm-alpha/dma-mapping.h
index b274bf6..57e09f5 100644
--- a/include/asm-alpha/dma-mapping.h
+++ b/include/asm-alpha/dma-mapping.h
@@ -60,7 +60,7 @@ #define dma_sync_single_for_device(dev, 
 #define dma_sync_single_range(dev, addr, off, size, dir)  do { } while (0)
 #define dma_sync_sg_for_cpu(dev, sg, nents, dir)	  do { } while (0)
 #define dma_sync_sg_for_device(dev, sg, nents, dir)	  do { } while (0)
-#define dma_cache_sync(va, size, dir)			  do { } while (0)
+#define dma_cache_sync(dev, va, size, dir)		  do { } while (0)
 
 #define dma_get_cache_alignment()			  L1_CACHE_BYTES
 
diff --git a/include/asm-avr32/dma-mapping.h b/include/asm-avr32/dma-mapping.h
index 44630be..0580b5d 100644
--- a/include/asm-avr32/dma-mapping.h
+++ b/include/asm-avr32/dma-mapping.h
@@ -8,7 +8,8 @@ #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-extern void dma_cache_sync(void *vaddr, size_t size, int direction);
+extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+	int direction);
 
 /*
  * Return whether the given device DMA address mask can be supported
diff --git a/include/asm-cris/dma-mapping.h b/include/asm-cris/dma-mapping.h
index af704fd..662cea7 100644
--- a/include/asm-cris/dma-mapping.h
+++ b/include/asm-cris/dma-mapping.h
@@ -159,7 +159,7 @@ dma_get_cache_alignment(void)
 #define dma_is_consistent(d, h)	(1)
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 }
diff --git a/include/asm-frv/dma-mapping.h b/include/asm-frv/dma-mapping.h
index 7b97fc7..bcb2df6 100644
--- a/include/asm-frv/dma-mapping.h
+++ b/include/asm-frv/dma-mapping.h
@@ -175,7 +175,7 @@ int dma_get_cache_alignment(void)
 #define dma_is_consistent(d, h)	(1)
 
 static inline
-void dma_cache_sync(void *vaddr, size_t size,
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
 	flush_write_buffers();
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index b9be3fc..783ab99 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -295,7 +295,7 @@ dma_sync_single_range_for_device(struct 
 }
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	/* could define this in terms of the dma_cache ... operations,
diff --git a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
index 7da64c9..183eebe 100644
--- a/include/asm-i386/dma-mapping.h
+++ b/include/asm-i386/dma-mapping.h
@@ -159,7 +159,7 @@ dma_get_cache_alignment(void)
 #define dma_is_consistent(d, h)	(1)
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	flush_write_buffers();
diff --git a/include/asm-ia64/dma-mapping.h b/include/asm-ia64/dma-mapping.h
index 4b075bc..ebd5887 100644
--- a/include/asm-ia64/dma-mapping.h
+++ b/include/asm-ia64/dma-mapping.h
@@ -50,7 +50,8 @@ dma_set_mask (struct device *dev, u64 ma
 extern int dma_get_cache_alignment(void);
 
 static inline void
-dma_cache_sync (void *vaddr, size_t size, enum dma_data_direction dir)
+dma_cache_sync (struct device *dev, void *vaddr, size_t size,
+	enum dma_data_direction dir)
 {
 	/*
 	 * IA-64 is cache-coherent, so this is mostly a no-op.  However, we do need to
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index efc89c1..00259ed 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -41,7 +41,7 @@ static inline void dma_free_noncoherent(
 {
 	dma_free_coherent(dev, size, addr, handle);
 }
-static inline void dma_cache_sync(void *vaddr, size_t size,
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
 	/* we use coherent allocation, so not much to do here. */
diff --git a/include/asm-mips/dma-mapping.h b/include/asm-mips/dma-mapping.h
index e17f70d..236d1a4 100644
--- a/include/asm-mips/dma-mapping.h
+++ b/include/asm-mips/dma-mapping.h
@@ -65,7 +65,7 @@ dma_get_cache_alignment(void)
 
 extern int dma_is_consistent(struct device *dev, dma_addr_t dma_addr);
 
-extern void dma_cache_sync(void *vaddr, size_t size,
+extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
 #define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-mapping.h
index c40d48a..66f0b40 100644
--- a/include/asm-parisc/dma-mapping.h
+++ b/include/asm-parisc/dma-mapping.h
@@ -197,7 +197,7 @@ dma_is_consistent(struct device *dev, dm
 }
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	if(hppa_dma_ops->dma_sync_single_for_cpu)
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 3487a4b..6c6d4dc 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -254,7 +254,7 @@ static inline void dma_sync_single_range
 	dma_sync_single_for_device(dev, dma_handle, offset + size, direction);
 }
 
-static inline void dma_cache_sync(void *vaddr, size_t size,
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
diff --git a/include/asm-sh/dma-mapping.h b/include/asm-sh/dma-mapping.h
index 56cd4b9..37ab0c1 100644
--- a/include/asm-sh/dma-mapping.h
+++ b/include/asm-sh/dma-mapping.h
@@ -53,7 +53,7 @@ static inline void dma_free_coherent(str
 	consistent_free(vaddr, size);
 }
 
-static inline void dma_cache_sync(void *vaddr, size_t size,
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
 	consistent_sync(vaddr, size, (int)dir);
diff --git a/include/asm-sh64/dma-mapping.h b/include/asm-sh64/dma-mapping.h
index 68e27a8..5efe906 100644
--- a/include/asm-sh64/dma-mapping.h
+++ b/include/asm-sh64/dma-mapping.h
@@ -35,7 +35,7 @@ static inline void dma_free_coherent(str
 	consistent_free(NULL, size, vaddr, dma_handle);
 }
 
-static inline void dma_cache_sync(void *vaddr, size_t size,
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
 	dma_cache_wback_inv((unsigned long)vaddr, size);
diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index 5fe0072..2f858a2 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -210,7 +210,7 @@ dma_sync_single_range_for_device(struct 
 }
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	/* could define this in terms of the dma_cache ... operations,
diff --git a/include/asm-um/dma-mapping.h b/include/asm-um/dma-mapping.h
index defb5b8..f0ee4fb 100644
--- a/include/asm-um/dma-mapping.h
+++ b/include/asm-um/dma-mapping.h
@@ -112,7 +112,7 @@ dma_sync_single_range(struct device *dev
 }
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	BUG();
diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
index c8cc488..be9ec68 100644
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -185,7 +185,8 @@ #define dma_is_consistent(d, h) 1
 extern int dma_set_mask(struct device *dev, u64 mask);
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size, enum dma_data_direction dir)
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+	enum dma_data_direction dir)
 {
 	flush_write_buffers();
 }
diff --git a/include/asm-xtensa/dma-mapping.h b/include/asm-xtensa/dma-mapping.h
index 827d1df..82b03b3 100644
--- a/include/asm-xtensa/dma-mapping.h
+++ b/include/asm-xtensa/dma-mapping.h
@@ -173,7 +173,7 @@ dma_get_cache_alignment(void)
 #define dma_is_consistent(d, h)	(1)
 
 static inline void
-dma_cache_sync(void *vaddr, size_t size,
+dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction)
 {
 	consistent_sync(vaddr, size, direction);
