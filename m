Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGUToD>; Sun, 21 Jul 2002 15:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSGUToD>; Sun, 21 Jul 2002 15:44:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32273 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313571AbSGUTmI>; Sun, 21 Jul 2002 15:42:08 -0400
Subject: PATCH: 2.5.27 i2o api/headers
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:09:21 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WN17-0007Ym-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the i2o headers and exported API in line with the 2.4 extensions and
IORSTRAT/WSTRAT interfaces


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/include/linux/i2o.h linux-2.5.27-ac1/include/linux/i2o.h
--- linux-2.5.27/include/linux/i2o.h	Sat Jul 20 20:11:11 2002
+++ linux-2.5.27-ac1/include/linux/i2o.h	Sun Jul 21 15:20:20 2002
@@ -81,9 +81,9 @@
 struct i2o_pci
 {
 	int		irq;
-	int		queue_buggy:3;	/* Don't send a lot of messages */
 	int		short_req:1;	/* Use small block sizes        */
 	int		dpt:1;		/* Don't quiesce                */
+	int		promise:1;	/* Promise controller		*/
 #ifdef CONFIG_MTRR
 	int		mtrr_reg0;
 	int		mtrr_reg1;
@@ -112,9 +112,9 @@
 	atomic_t users;
 	struct i2o_device *devices;		/* I2O device chain */
 	struct i2o_controller *next;		/* Controller chain */
-	volatile u32 *post_port;		/* Inbout port */
-	volatile u32 *reply_port;		/* Outbound port */
-	volatile u32 *irq_mask;			/* Interrupt register */
+	unsigned long post_port;		/* Inbout port address */
+	unsigned long reply_port;		/* Outbound port address */
+	unsigned long irq_mask;			/* Interrupt register address */
 
 	/* Dynamic LCT related data */
 	struct semaphore lct_sem;
@@ -122,12 +122,17 @@
 	int lct_running;
 
 	i2o_status_block *status_block;		/* IOP status block */
+	dma_addr_t status_block_phys;
 	i2o_lct *lct;				/* Logical Config Table */
+	dma_addr_t lct_phys;
 	i2o_lct *dlct;				/* Temp LCT */
+	dma_addr_t dlct_phys;
 	i2o_hrt *hrt;				/* HW Resource Table */
+	dma_addr_t hrt_phys;
+	u32 hrt_len;
 
-	u32 mem_offset;				/* MFA offset */
-	u32 mem_phys;				/* MFA physical */
+	unsigned long mem_offset;		/* MFA offset */
+	unsigned long mem_phys;			/* MFA physical */
 
 	int battery:1;				/* Has a battery backup */
 	int io_alloc:1;				/* An I/O resource was allocated */
@@ -252,34 +257,34 @@
  */
 static inline u32 I2O_POST_READ32(struct i2o_controller *c)
 {
-	return *c->post_port;
+	return readl(c->post_port);
 }
 
-static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_POST_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->post_port = Val;
+	writel(val, c->post_port);
 }
 
 
 static inline u32 I2O_REPLY_READ32(struct i2o_controller *c)
 {
-	return *c->reply_port;
+	return readl(c->reply_port);
 }
 
-static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_REPLY_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->reply_port = Val;
+	writel(val, c->reply_port);
 }
 
 
 static inline u32 I2O_IRQ_READ32(struct i2o_controller *c)
 {
-	return *c->irq_mask;
+	return readl(c->irq_mask);
 }
 
-static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 Val)
+static inline void I2O_IRQ_WRITE32(struct i2o_controller *c, u32 val)
 {
-	*c->irq_mask = Val;
+	writel(val, c->irq_mask);
 }
 
 
@@ -295,6 +300,13 @@
 	I2O_REPLY_WRITE32(c, m);
 }
 
+/*
+ *	Endian handling wrapped into the macro - keeps the core code
+ *	cleaner.
+ */
+ 
+#define i2o_raw_writel(val, mem)	__raw_writel(cpu_to_le32(val), mem)
+
 extern struct i2o_controller *i2o_find_controller(int);
 extern void i2o_unlock_controller(struct i2o_controller *);
 extern struct i2o_controller *i2o_controller_chain;
@@ -313,7 +325,7 @@
 extern int i2o_post_this(struct i2o_controller *, u32 *, int);
 extern int i2o_post_wait(struct i2o_controller *, u32 *, int, int);
 extern int i2o_post_wait_mem(struct i2o_controller *, u32 *, int, int,
-			     void *, void *);
+			     void *, void *, dma_addr_t, dma_addr_t, int, int);
 
 extern int i2o_query_scalar(struct i2o_controller *, int, int, int, void *,
 			    int);
@@ -339,13 +351,66 @@
 extern void i2o_run_queue(struct i2o_controller *);
 extern int i2o_delete_controller(struct i2o_controller *);
 
+/*
+ *	Cache strategies
+ */
+ 
+ 
+/*	The NULL strategy leaves everything up to the controller. This tends to be a
+ *	pessimal but functional choice.
+ */
+#define CACHE_NULL		0
+/*	Prefetch data when reading. We continually attempt to load the next 32 sectors
+ *	into the controller cache. 
+ */
+#define CACHE_PREFETCH		1
+/*	Prefetch data when reading. We sometimes attempt to load the next 32 sectors
+ *	into the controller cache. When an I/O is less <= 8K we assume its probably
+ *	not sequential and don't prefetch (default)
+ */
+#define CACHE_SMARTFETCH	2
+/*	Data is written to the cache and then out on to the disk. The I/O must be
+ *	physically on the medium before the write is acknowledged (default without
+ *	NVRAM)
+ */
+#define CACHE_WRITETHROUGH	17
+/*	Data is written to the cache and then out on to the disk. The controller
+ *	is permitted to write back the cache any way it wants. (default if battery
+ *	backed NVRAM is present). It can be useful to set this for swap regardless of
+ *	battery state.
+ */
+#define CACHE_WRITEBACK		18
+/*	Optimise for under powered controllers, especially on RAID1 and RAID0. We
+ *	write large I/O's directly to disk bypassing the cache to avoid the extra
+ *	memory copy hits. Small writes are writeback cached
+ */
+#define CACHE_SMARTBACK		19
+/*	Optimise for under powered controllers, especially on RAID1 and RAID0. We
+ *	write large I/O's directly to disk bypassing the cache to avoid the extra
+ *	memory copy hits. Small writes are writethrough cached. Suitable for devices
+ *	lacking battery backup
+ */
+#define CACHE_SMARTTHROUGH	20
+
+/*
+ *	Ioctl structures
+ */
+ 
+
+#define 	BLKI2OGRSTRAT	_IOR('2', 1, int) 
+#define 	BLKI2OGWSTRAT	_IOR('2', 2, int) 
+#define 	BLKI2OSRSTRAT	_IOW('2', 3, int) 
+#define 	BLKI2OSWSTRAT	_IOW('2', 4, int) 
+
+
+
 
 /*
- * I2O Function codes
+ *	I2O Function codes
  */
 
 /*
- * Executive Class
+ *	Executive Class
  */
 #define	I2O_CMD_ADAPTER_ASSIGN		0xB3
 #define	I2O_CMD_ADAPTER_READ		0xB2
@@ -416,6 +481,7 @@
 #define I2O_CMD_BLOCK_MUNLOCK		0x4B
 #define I2O_CMD_BLOCK_MMOUNT		0x41
 #define I2O_CMD_BLOCK_MEJECT		0x43
+#define I2O_CMD_BLOCK_POWER		0x70
 
 #define I2O_PRIVATE_MSG			0xFF
 
@@ -574,6 +640,7 @@
 #define EIGHT_WORD_MSG_SIZE	0x00080000
 #define NINE_WORD_MSG_SIZE	0x00090000
 #define TEN_WORD_MSG_SIZE	0x000A0000
+#define ELEVEN_WORD_MSG_SIZE	0x000B0000
 #define I2O_MESSAGE_SIZE(x)	((x)<<16)
 
 
@@ -582,10 +649,10 @@
 #define ADAPTER_TID		0
 #define HOST_TID		1
 
-#define MSG_FRAME_SIZE		128
+#define MSG_FRAME_SIZE		64	/* i2o_scsi assumes >= 32 */
 #define NMBR_MSG_FRAMES		128
 
-#define MSG_POOL_SIZE		16384
+#define MSG_POOL_SIZE		(MSG_FRAME_SIZE*NMBR_MSG_FRAMES*sizeof(u32))
 
 #define I2O_POST_WAIT_OK	0
 #define I2O_POST_WAIT_TIMEOUT	-ETIMEDOUT
