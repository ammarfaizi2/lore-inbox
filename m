Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263295AbSJHUkc>; Tue, 8 Oct 2002 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJHTKH>; Tue, 8 Oct 2002 15:10:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19216 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263228AbSJHTDl>; Tue, 8 Oct 2002 15:03:41 -0400
Subject: PATCH: 2.5 cleanup + 2.4 merge of depca
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:59:44 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yza4-0004st-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes this is big but 2.4 has been indented, updated and there wasnt a
sane way to deal with it

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/depca.c linux.2.5.41-ac1/drivers/net/depca.c
--- linux.2.5.41/drivers/net/depca.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/depca.c	2002-10-03 18:24:07.000000000 +0100
@@ -267,8 +267,7 @@
 
 #include "depca.h"
 
-static char version[] __initdata =
-	"depca.c:v0.53 2001/1/12 davies@maniac.ultranet.com\n";
+static char version[] __initdata = "depca.c:v0.53 2001/1/12 davies@maniac.ultranet.com\n";
 
 #ifdef DEPCA_DEBUG
 static int depca_debug = DEPCA_DEBUG;
@@ -276,7 +275,7 @@
 static int depca_debug = 1;
 #endif
 
-#define DEPCA_NDA 0xffe0            /* No Device Address */
+#define DEPCA_NDA 0xffe0	/* No Device Address */
 
 #define TX_TIMEOUT (1*HZ)
 
@@ -293,15 +292,15 @@
 **
 ** total_memory = NUM_RX_DESC*(8+RX_BUFF_SZ) + NUM_TX_DESC*(8+TX_BUFF_SZ)
 */
-#define NUM_RX_DESC     8               /* Number of RX descriptors */
-#define NUM_TX_DESC     8               /* Number of TX descriptors */
-#define RX_BUFF_SZ	1536            /* Buffer size for each Rx buffer */
-#define TX_BUFF_SZ	1536            /* Buffer size for each Tx buffer */
+#define NUM_RX_DESC     8	/* Number of RX descriptors */
+#define NUM_TX_DESC     8	/* Number of TX descriptors */
+#define RX_BUFF_SZ	1536	/* Buffer size for each Rx buffer */
+#define TX_BUFF_SZ	1536	/* Buffer size for each Tx buffer */
 
 /*
 ** EISA bus defines
 */
-#define DEPCA_EISA_IO_PORTS 0x0c00       /* I/O port base address, slot 0 */
+#define DEPCA_EISA_IO_PORTS 0x0c00	/* I/O port base address, slot 0 */
 #define MAX_EISA_SLOTS 16
 #define EISA_SLOT_INC 0x1000
 
@@ -328,7 +327,7 @@
                          "DE422",\
                          ""}
 static enum {
-  DEPCA, de100, de101, de200, de201, de202, de210, de212, de422, unknown
+	DEPCA, de100, de101, de200, de201, de202, de210, de212, de422, unknown
 } adapter;
 
 /*
@@ -340,81 +339,81 @@
 /*
 ** Memory Alignment. Each descriptor is 4 longwords long. To force a
 ** particular alignment on the TX descriptor, adjust DESC_SKIP_LEN and
-** DESC_ALIGN. ALIGN aligns the start address of the private memory area
+** DESC_ALIGN. DEPCA_ALIGN aligns the start address of the private memory area
 ** and hence the RX descriptor ring's first entry. 
 */
-#define ALIGN4      ((u_long)4 - 1)       /* 1 longword align */
-#define ALIGN8      ((u_long)8 - 1)       /* 2 longword (quadword) align */
-#define ALIGN         ALIGN8              /* Keep the LANCE happy... */
+#define DEPCA_ALIGN4      ((u_long)4 - 1)	/* 1 longword align */
+#define DEPCA_ALIGN8      ((u_long)8 - 1)	/* 2 longword (quadword) align */
+#define DEPCA_ALIGN         DEPCA_ALIGN8	/* Keep the LANCE happy... */
 
 /*
 ** The DEPCA Rx and Tx ring descriptors. 
 */
 struct depca_rx_desc {
-    volatile s32 base;
-    s16 buf_length;		/* This length is negative 2's complement! */
-    s16 msg_length;		/* This length is "normal". */
+	volatile s32 base;
+	s16 buf_length;		/* This length is negative 2's complement! */
+	s16 msg_length;		/* This length is "normal". */
 };
 
 struct depca_tx_desc {
-    volatile s32 base;
-    s16 length;		        /* This length is negative 2's complement! */
-    s16 misc;                   /* Errors and TDR info */
+	volatile s32 base;
+	s16 length;		/* This length is negative 2's complement! */
+	s16 misc;		/* Errors and TDR info */
 };
 
-#define LA_MASK 0x0000ffff      /* LANCE address mask for mapping network RAM
+#define LA_MASK 0x0000ffff	/* LANCE address mask for mapping network RAM
 				   to LANCE memory address space */
 
 /*
 ** The Lance initialization block, described in databook, in common memory.
 */
 struct depca_init {
-    u16 mode;	                /* Mode register */
-    u8  phys_addr[ETH_ALEN];	/* Physical ethernet address */
-    u8  mcast_table[8];	        /* Multicast Hash Table. */
-    u32 rx_ring;     	        /* Rx ring base pointer & ring length */
-    u32 tx_ring;	        /* Tx ring base pointer & ring length */
+	u16 mode;		/* Mode register */
+	u8 phys_addr[ETH_ALEN];	/* Physical ethernet address */
+	u8 mcast_table[8];	/* Multicast Hash Table. */
+	u32 rx_ring;		/* Rx ring base pointer & ring length */
+	u32 tx_ring;		/* Tx ring base pointer & ring length */
 };
 
 #define DEPCA_PKT_STAT_SZ 16
-#define DEPCA_PKT_BIN_SZ  128                /* Should be >=100 unless you
-                                                increase DEPCA_PKT_STAT_SZ */
+#define DEPCA_PKT_BIN_SZ  128	/* Should be >=100 unless you
+				   increase DEPCA_PKT_STAT_SZ */
 struct depca_private {
-    char devname[DEPCA_STRLEN];    /* Device Product String                  */
-    char adapter_name[DEPCA_STRLEN];/* /proc/ioports string                  */
-    char adapter;                  /* Adapter type                           */
-    char mca_slot;                 /* MCA slot, if MCA else -1               */
-    struct depca_init	init_block;/* Shadow Initialization block            */
+	char devname[DEPCA_STRLEN];	/* Device Product String                  */
+	char adapter_name[DEPCA_STRLEN];	/* /proc/ioports string                  */
+	char adapter;		/* Adapter type                           */
+	char mca_slot;		/* MCA slot, if MCA else -1               */
+	struct depca_init init_block;	/* Shadow Initialization block            */
 /* CPU address space fields */
-    struct depca_rx_desc *rx_ring; /* Pointer to start of RX descriptor ring */
-    struct depca_tx_desc *tx_ring; /* Pointer to start of TX descriptor ring */
-    void *rx_buff[NUM_RX_DESC];    /* CPU virt address of sh'd memory buffs  */
-    void *tx_buff[NUM_TX_DESC];    /* CPU virt address of sh'd memory buffs  */
-    void *sh_mem;                  /* CPU mapped virt address of device RAM  */
+	struct depca_rx_desc *rx_ring;	/* Pointer to start of RX descriptor ring */
+	struct depca_tx_desc *tx_ring;	/* Pointer to start of TX descriptor ring */
+	void *rx_buff[NUM_RX_DESC];	/* CPU virt address of sh'd memory buffs  */
+	void *tx_buff[NUM_TX_DESC];	/* CPU virt address of sh'd memory buffs  */
+	void *sh_mem;		/* CPU mapped virt address of device RAM  */
 /* Device address space fields */
-    u_long device_ram_start;       /* Start of RAM in device addr space      */
+	u_long device_ram_start;	/* Start of RAM in device addr space      */
 /* Offsets used in both address spaces */
-    u_long rx_ring_offset;         /* Offset from start of RAM to rx_ring    */
-    u_long tx_ring_offset;         /* Offset from start of RAM to tx_ring    */
-    u_long buffs_offset;	   /* LANCE Rx and Tx buffers start address. */
+	u_long rx_ring_offset;	/* Offset from start of RAM to rx_ring    */
+	u_long tx_ring_offset;	/* Offset from start of RAM to tx_ring    */
+	u_long buffs_offset;	/* LANCE Rx and Tx buffers start address. */
 /* Kernel-only (not device) fields */
-    int	rx_new, tx_new;		   /* The next free ring entry               */
-    int rx_old, tx_old;	           /* The ring entries to be free()ed.       */
-    struct net_device_stats stats;
-    spinlock_t lock;
-    struct {                       /* Private stats counters                 */
-	u32 bins[DEPCA_PKT_STAT_SZ];
-	u32 unicast;
-	u32 multicast;
-	u32 broadcast;
-	u32 excessive_collisions;
-	u32 tx_underruns;
-	u32 excessive_underruns;
-    } pktStats;
-    int txRingMask;                /* TX ring mask                           */
-    int rxRingMask;                /* RX ring mask                           */
-    s32 rx_rlen;                   /* log2(rxRingMask+1) for the descriptors */
-    s32 tx_rlen;                   /* log2(txRingMask+1) for the descriptors */
+	int rx_new, tx_new;	/* The next free ring entry               */
+	int rx_old, tx_old;	/* The ring entries to be free()ed.       */
+	struct net_device_stats stats;
+	spinlock_t lock;
+	struct {		/* Private stats counters                 */
+		u32 bins[DEPCA_PKT_STAT_SZ];
+		u32 unicast;
+		u32 multicast;
+		u32 broadcast;
+		u32 excessive_collisions;
+		u32 tx_underruns;
+		u32 excessive_underruns;
+	} pktStats;
+	int txRingMask;		/* TX ring mask                           */
+	int rxRingMask;		/* RX ring mask                           */
+	s32 rx_rlen;		/* log2(rxRingMask+1) for the descriptors */
+	s32 tx_rlen;		/* log2(txRingMask+1) for the descriptors */
 };
 
 /*
@@ -431,61 +430,61 @@
 /*
 ** Public Functions
 */
-static int    depca_open(struct net_device *dev);
-static int    depca_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void   depca_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static int    depca_close(struct net_device *dev);
-static int    depca_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-static void   depca_tx_timeout (struct net_device *dev);
+static int depca_open(struct net_device *dev);
+static int depca_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static void depca_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static int depca_close(struct net_device *dev);
+static int depca_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static void depca_tx_timeout(struct net_device *dev);
 static struct net_device_stats *depca_get_stats(struct net_device *dev);
-static void   set_multicast_list(struct net_device *dev);
+static void set_multicast_list(struct net_device *dev);
 
 /*
 ** Private functions
 */
-static int    depca_hw_init(struct net_device *dev, u_long ioaddr, int mca_slot);
-static void   depca_init_ring(struct net_device *dev);
-static int    depca_rx(struct net_device *dev);
-static int    depca_tx(struct net_device *dev);
-
-static void   LoadCSRs(struct net_device *dev);
-static int    InitRestartDepca(struct net_device *dev);
-static void   DepcaSignature(char *name, u_long paddr);
-static int    DevicePresent(u_long ioaddr);
-static int    get_hw_addr(struct net_device *dev);
-static int    EISA_signature(char *name, s32 eisa_id);
-static void   SetMulticastFilter(struct net_device *dev);
-static void   isa_probe(struct net_device *dev, u_long iobase);
-static void   eisa_probe(struct net_device *dev, u_long iobase);
-#ifdef CONFIG_MCA      
-static void   mca_probe(struct net_device *dev, u_long iobase);
+static int depca_hw_init(struct net_device *dev, u_long ioaddr, int mca_slot);
+static void depca_init_ring(struct net_device *dev);
+static int depca_rx(struct net_device *dev);
+static int depca_tx(struct net_device *dev);
+
+static void LoadCSRs(struct net_device *dev);
+static int InitRestartDepca(struct net_device *dev);
+static void DepcaSignature(char *name, u_long paddr);
+static int DevicePresent(u_long ioaddr);
+static int get_hw_addr(struct net_device *dev);
+static int EISA_signature(char *name, s32 eisa_id);
+static void SetMulticastFilter(struct net_device *dev);
+static void isa_probe(struct net_device *dev, u_long iobase);
+static void eisa_probe(struct net_device *dev, u_long iobase);
+#ifdef CONFIG_MCA
+static void mca_probe(struct net_device *dev, u_long iobase);
 #endif
 static struct net_device *alloc_device(struct net_device *dev, u_long iobase);
-static int    depca_dev_index(char *s);
-static struct net_device *insert_device(struct net_device *dev, u_long iobase, int (*init)(struct net_device *));
-static int    load_packet(struct net_device *dev, struct sk_buff *skb);
-static void   depca_dbg_open(struct net_device *dev);
+static int depca_dev_index(char *s);
+static struct net_device *insert_device(struct net_device *dev, u_long iobase, int (*init) (struct net_device *));
+static int load_packet(struct net_device *dev, struct sk_buff *skb);
+static void depca_dbg_open(struct net_device *dev);
 
 #ifdef MODULE
-int           init_module(void);
-void          cleanup_module(void);
-static int    autoprobed = 1, loading_module = 1;
+int init_module(void);
+void cleanup_module(void);
+static int autoprobed = 1, loading_module = 1;
 # else
-static u_char de1xx_irq[] __initdata = {2,3,4,5,7,9,0};
-static u_char de2xx_irq[] __initdata = {5,9,10,11,15,0};
-static u_char de422_irq[] __initdata = {5,9,10,11,0};
+static u_char de1xx_irq[] __initdata = { 2, 3, 4, 5, 7, 9, 0 };
+static u_char de2xx_irq[] __initdata = { 5, 9, 10, 11, 15, 0 };
+static u_char de422_irq[] __initdata = { 5, 9, 10, 11, 0 };
 static u_char *depca_irq;
-static int    autoprobed, loading_module;
-#endif /* MODULE */
+static int autoprobed, loading_module;
+#endif				/* MODULE */
 
-static char   name[DEPCA_STRLEN];
-static int    num_depcas, num_eth;
-static int    mem;                       /* For loadable module assignment
-                                              use insmod mem=0x????? .... */
-static char   *adapter_name; /* = '\0';     If no PROM when loadable module
-					      use insmod adapter_name=DE??? ...
-					      bss initializes this to zero
-					   */
+static char name[DEPCA_STRLEN];
+static int num_depcas, num_eth;
+static int mem;			/* For loadable module assignment
+				   use insmod mem=0x????? .... */
+static char *adapter_name;	/* = '\0';     If no PROM when loadable module
+				   use insmod adapter_name=DE??? ...
+				   bss initializes this to zero
+				 */
 /*
 ** Miscellaneous defines...
 */
@@ -493,49 +492,48 @@
     outw(CSR0, DEPCA_ADDR);\
     outw(STOP, DEPCA_DATA)
 
-int __init 
-depca_probe(struct net_device *dev)
+int __init depca_probe(struct net_device *dev)
 {
-  int tmp = num_depcas, status = -ENODEV;
-  u_long iobase = dev->base_addr;
+	int tmp = num_depcas, status = -ENODEV;
+	u_long iobase = dev->base_addr;
 
-  SET_MODULE_OWNER(dev);
+	SET_MODULE_OWNER(dev);
 
-  if ((iobase == 0) && loading_module){
-    printk("Autoprobing is not supported when loading a module based driver.\n");
-    status = -EIO;
-  } else {
-#ifdef CONFIG_MCA      
-    mca_probe(dev, iobase);
+	if ((iobase == 0) && loading_module) {
+		printk("Autoprobing is not supported when loading a module based driver.\n");
+		status = -EIO;
+	} else {
+#ifdef CONFIG_MCA
+		mca_probe(dev, iobase);
 #endif
-    isa_probe(dev, iobase);
-    eisa_probe(dev, iobase);
+		isa_probe(dev, iobase);
+		eisa_probe(dev, iobase);
 
-    if ((tmp == num_depcas) && (iobase != 0) && loading_module) {
-      printk("%s: depca_probe() cannot find device at 0x%04lx.\n", dev->name, 
-	                                                               iobase);
-    }
-
-    /*
-    ** Walk the device list to check that at least one device
-    ** initialised OK
-    */
-    for (; (dev->priv == NULL) && (dev->next != NULL); dev = dev->next);
+		if ((tmp == num_depcas) && (iobase != 0) && loading_module) {
+			printk("%s: depca_probe() cannot find device at 0x%04lx.\n", dev->name, iobase);
+		}
 
-    if (dev->priv) status = 0;
-    if (iobase == 0) autoprobed = 1;
-  }
+		/*
+		   ** Walk the device list to check that at least one device
+		   ** initialised OK
+		 */
+		for (; (dev->priv == NULL) && (dev->next != NULL); dev = dev->next);
+
+		if (dev->priv)
+			status = 0;
+		if (iobase == 0)
+			autoprobed = 1;
+	}
 
-  return status;
+	return status;
 }
 
-static int __init 
-depca_hw_init(struct net_device *dev, u_long ioaddr, int mca_slot)
+static int __init depca_hw_init(struct net_device *dev, u_long ioaddr, int mca_slot)
 {
 	struct depca_private *lp;
-	int i, j, offset, netRAM, mem_len, status=0;
+	int i, j, offset, netRAM, mem_len, status = 0;
 	s16 nicsr;
-	u_long mem_start=0, mem_base[] = DEPCA_RAM_BASE_ADDRESSES;
+	u_long mem_start = 0, mem_base[] = DEPCA_RAM_BASE_ADDRESSES;
 
 	STOP_DEPCA;
 
@@ -553,19 +551,17 @@
 		DepcaSignature(name, mem_start);
 	} while (!mem && mem_base[mem_chkd] && (adapter == unknown));
 
-	if ((adapter == unknown) || !mem_start) { /* DEPCA device not found */
+	if ((adapter == unknown) || !mem_start) {	/* DEPCA device not found */
 		return -ENXIO;
 	}
 
 	dev->base_addr = ioaddr;
 
 	if (mca_slot != -1) {
-		printk("%s: %s at 0x%04lx (MCA slot %d)", dev->name, name, 
-		                                          ioaddr, mca_slot);
-	} else if ((ioaddr & 0x0fff) == DEPCA_EISA_IO_PORTS) { /* EISA slot address */
-		printk("%s: %s at 0x%04lx (EISA slot %d)", 
-		       dev->name, name, ioaddr, (int)((ioaddr>>12)&0x0f));
-	} else {                             /* ISA port address */
+		printk("%s: %s at 0x%04lx (MCA slot %d)", dev->name, name, ioaddr, mca_slot);
+	} else if ((ioaddr & 0x0fff) == DEPCA_EISA_IO_PORTS) {	/* EISA slot address */
+		printk("%s: %s at 0x%04lx (EISA slot %d)", dev->name, name, ioaddr, (int) ((ioaddr >> 12) & 0x0f));
+	} else {		/* ISA port address */
 		printk("%s: %s at 0x%04lx", dev->name, name, ioaddr);
 	}
 
@@ -575,7 +571,7 @@
 		printk("      which has an Ethernet PROM CRC error.\n");
 		return -ENXIO;
 	}
-	for (i=0; i<ETH_ALEN - 1; i++) { /* get the ethernet address */
+	for (i = 0; i < ETH_ALEN - 1; i++) {	/* get the ethernet address */
 		printk("%2.2x:", dev->dev_addr[i]);
 	}
 	printk("%2.2x", dev->dev_addr[i]);
@@ -586,19 +582,16 @@
 		netRAM = 128;
 	offset = 0x0000;
 
-	/* Shared Memory Base Address */ 
+	/* Shared Memory Base Address */
 	if (nicsr & BUF) {
-		offset = 0x8000;        /* 32kbyte RAM offset*/
-		nicsr &= ~BS;           /* DEPCA RAM in top 32k */
+		offset = 0x8000;	/* 32kbyte RAM offset */
+		nicsr &= ~BS;	/* DEPCA RAM in top 32k */
 		netRAM -= 32;
 	}
-	mem_start += offset;            /* (E)ISA start address */
-	if ((mem_len = (NUM_RX_DESC*(sizeof(struct depca_rx_desc)+RX_BUFF_SZ) +
-			NUM_TX_DESC*(sizeof(struct depca_tx_desc)+TX_BUFF_SZ) +
-			sizeof(struct depca_init)))
-	    > (netRAM<<10)) {
-		printk(",\n       requests %dkB RAM: only %dkB is available!\n",
-		        (mem_len >> 10), netRAM);
+	mem_start += offset;	/* (E)ISA start address */
+	if ((mem_len = (NUM_RX_DESC * (sizeof(struct depca_rx_desc) + RX_BUFF_SZ) + NUM_TX_DESC * (sizeof(struct depca_tx_desc) + TX_BUFF_SZ) + sizeof(struct depca_init)))
+	    > (netRAM << 10)) {
+		printk(",\n       requests %dkB RAM: only %dkB is available!\n", (mem_len >> 10), netRAM);
 		return -ENXIO;
 	}
 
@@ -609,21 +602,20 @@
 		nicsr |= SHE;
 		outb(nicsr, DEPCA_NICSR);
 	}
- 
+
 	/* Define the device private memory */
 	dev->priv = (void *) kmalloc(sizeof(struct depca_private), GFP_KERNEL);
 	if (dev->priv == NULL)
 		return -ENOMEM;
-	lp = (struct depca_private *)dev->priv;
-	memset((char *)dev->priv, 0, sizeof(struct depca_private));
+	lp = (struct depca_private *) dev->priv;
+	memset((char *) dev->priv, 0, sizeof(struct depca_private));
 	lp->adapter = adapter;
 	lp->mca_slot = mca_slot;
 	lp->lock = SPIN_LOCK_UNLOCKED;
- 	sprintf(lp->adapter_name,"%s (%s)", name, dev->name);
+	sprintf(lp->adapter_name, "%s (%s)", name, dev->name);
 	status = -EBUSY;
 	if (!request_region(ioaddr, DEPCA_TOTAL_SIZE, lp->adapter_name)) {
-		printk(KERN_ERR "depca: I/O resource 0x%x @ 0x%lx busy\n",
-		       DEPCA_TOTAL_SIZE, ioaddr);
+		printk(KERN_ERR "depca: I/O resource 0x%x @ 0x%lx busy\n", DEPCA_TOTAL_SIZE, ioaddr);
 		goto out_priv;
 	}
 
@@ -635,17 +627,17 @@
 		goto out_region;
 	}
 	lp->device_ram_start = mem_start & LA_MASK;
-	
+
 	offset = 0;
 	offset += sizeof(struct depca_init);
 
 	/* Tx & Rx descriptors (aligned to a quadword boundary) */
-	offset = (offset + ALIGN) & ~ALIGN;
-	lp->rx_ring = (struct depca_rx_desc *)(lp->sh_mem + offset);
+	offset = (offset + DEPCA_ALIGN) & ~DEPCA_ALIGN;
+	lp->rx_ring = (struct depca_rx_desc *) (lp->sh_mem + offset);
 	lp->rx_ring_offset = offset;
 
 	offset += (sizeof(struct depca_rx_desc) * NUM_RX_DESC);
-	lp->tx_ring = (struct depca_tx_desc *)(lp->sh_mem + offset);
+	lp->tx_ring = (struct depca_tx_desc *) (lp->sh_mem + offset);
 	lp->tx_ring_offset = offset;
 
 	offset += (sizeof(struct depca_tx_desc) * NUM_TX_DESC);
@@ -657,14 +649,14 @@
 	lp->txRingMask = NUM_TX_DESC - 1;
 
 	/* Calculate Tx/Rx RLEN size for the descriptors. */
-	for (i=0, j = lp->rxRingMask; j>0; i++) {
+	for (i = 0, j = lp->rxRingMask; j > 0; i++) {
 		j >>= 1;
 	}
-	lp->rx_rlen = (s32)(i << 29);
-	for (i=0, j = lp->txRingMask; j>0; i++) {
+	lp->rx_rlen = (s32) (i << 29);
+	for (i = 0, j = lp->txRingMask; j > 0; i++) {
 		j >>= 1;
 	}
-	lp->tx_rlen = (s32)(i << 29);
+	lp->tx_rlen = (s32) (i << 29);
 
 	/* Load the initialisation block */
 	depca_init_ring(dev);
@@ -673,7 +665,7 @@
 	LoadCSRs(dev);
 
 	/* Enable DEPCA board interrupts for autoprobing */
-	nicsr = ((nicsr & ~IM)|IEN);
+	nicsr = ((nicsr & ~IM) | IEN);
 	outb(nicsr, DEPCA_NICSR);
 
 	/* To auto-IRQ we enable the initialization-done and DMA err,
@@ -706,9 +698,10 @@
 
 		/* Trigger an initialization just for the interrupt. */
 		outw(INEA | INIT, DEPCA_DATA);
-	  
+
 		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			yield();
 		irqnum = probe_irq_off(irq_mask);
 
 		status = -ENXIO;
@@ -716,19 +709,19 @@
 			printk(" and failed to detect IRQ line.\n");
 			goto out_region;
 		} else {
-			for (dev->irq=0,i=0; (depca_irq[i]) && (!dev->irq); i++)
+			for (dev->irq = 0, i = 0; (depca_irq[i]) && (!dev->irq); i++)
 				if (irqnum == depca_irq[i]) {
 					dev->irq = irqnum;
 					printk(" and uses IRQ%d.\n", dev->irq);
 				}
-	      
+
 			status = -ENXIO;
 			if (!dev->irq) {
 				printk(" but incorrect IRQ line detected.\n");
 				goto out_region;
 			}
 		}
-#endif /* MODULE */
+#endif				/* MODULE */
 	} else {
 		printk(" and assigned IRQ%d.\n", dev->irq);
 	}
@@ -752,65 +745,63 @@
 	/* Fill in the generic field of the device structure. */
 	ether_setup(dev);
 	return 0;
-out_region:
+      out_region:
 	release_region(ioaddr, DEPCA_TOTAL_SIZE);
-out_priv:
+      out_priv:
 	kfree(dev->priv);
 	dev->priv = NULL;
 	return status;
 }
-
 
-static int
-depca_open(struct net_device *dev)
+
+static int depca_open(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  u_long ioaddr = dev->base_addr;
-  s16 nicsr;
-  int status = 0;
-
-  STOP_DEPCA;
-  nicsr = inb(DEPCA_NICSR);
-
-  /* Make sure the shadow RAM is enabled */
-  if (lp->adapter != DEPCA) {
-    nicsr |= SHE;
-    outb(nicsr, DEPCA_NICSR);
-  }
-
-  /* Re-initialize the DEPCA... */
-  depca_init_ring(dev);
-  LoadCSRs(dev);
-
-  depca_dbg_open(dev);
-
-  if (request_irq(dev->irq, &depca_interrupt, 0, lp->adapter_name, dev)) {
-    printk("depca_open(): Requested IRQ%d is busy\n",dev->irq);
-    status = -EAGAIN;
-  } else {
-
-    /* Enable DEPCA board interrupts and turn off LED */
-    nicsr = ((nicsr & ~IM & ~LED)|IEN);
-    outb(nicsr, DEPCA_NICSR);
-    outw(CSR0,DEPCA_ADDR);
-    
-    netif_start_queue(dev);
-    
-    status = InitRestartDepca(dev);
-
-    if (depca_debug > 1){
-      printk("CSR0: 0x%4.4x\n",inw(DEPCA_DATA));
-      printk("nicsr: 0x%02x\n",inb(DEPCA_NICSR));
-    }
-  }
-  return status;
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	u_long ioaddr = dev->base_addr;
+	s16 nicsr;
+	int status = 0;
+
+	STOP_DEPCA;
+	nicsr = inb(DEPCA_NICSR);
+
+	/* Make sure the shadow RAM is enabled */
+	if (lp->adapter != DEPCA) {
+		nicsr |= SHE;
+		outb(nicsr, DEPCA_NICSR);
+	}
+
+	/* Re-initialize the DEPCA... */
+	depca_init_ring(dev);
+	LoadCSRs(dev);
+
+	depca_dbg_open(dev);
+
+	if (request_irq(dev->irq, &depca_interrupt, 0, lp->adapter_name, dev)) {
+		printk("depca_open(): Requested IRQ%d is busy\n", dev->irq);
+		status = -EAGAIN;
+	} else {
+
+		/* Enable DEPCA board interrupts and turn off LED */
+		nicsr = ((nicsr & ~IM & ~LED) | IEN);
+		outb(nicsr, DEPCA_NICSR);
+		outw(CSR0, DEPCA_ADDR);
+
+		netif_start_queue(dev);
+
+		status = InitRestartDepca(dev);
+
+		if (depca_debug > 1) {
+			printk("CSR0: 0x%4.4x\n", inw(DEPCA_DATA));
+			printk("nicsr: 0x%02x\n", inb(DEPCA_NICSR));
+		}
+	}
+	return status;
 }
 
 /* Initialize the lance Rx and Tx descriptor rings. */
-static void
-depca_init_ring(struct net_device *dev)
+static void depca_init_ring(struct net_device *dev)
 {
-	struct depca_private *lp = (struct depca_private *)dev->priv;
+	struct depca_private *lp = (struct depca_private *) dev->priv;
 	u_int i;
 	u_long offset;
 
@@ -822,17 +813,15 @@
 
 	/* Initialize the base address and length of each buffer in the ring */
 	for (i = 0; i <= lp->rxRingMask; i++) {
-		offset = lp->buffs_offset + i*RX_BUFF_SZ;
-		writel((lp->device_ram_start + offset) | R_OWN,
-		       &lp->rx_ring[i].base);
+		offset = lp->buffs_offset + i * RX_BUFF_SZ;
+		writel((lp->device_ram_start + offset) | R_OWN, &lp->rx_ring[i].base);
 		writew(-RX_BUFF_SZ, &lp->rx_ring[i].buf_length);
 		lp->rx_buff[i] = lp->sh_mem + offset;
 	}
 
 	for (i = 0; i <= lp->txRingMask; i++) {
-		offset = lp->buffs_offset + (i + lp->rxRingMask+1)*TX_BUFF_SZ;
-		writel((lp->device_ram_start + offset) & 0x00ffffff,
-	               &lp->tx_ring[i].base);
+		offset = lp->buffs_offset + (i + lp->rxRingMask + 1) * TX_BUFF_SZ;
+		writel((lp->device_ram_start + offset) & 0x00ffffff, &lp->tx_ring[i].base);
 		lp->tx_buff[i] = lp->sh_mem + offset;
 	}
 
@@ -846,30 +835,29 @@
 		lp->init_block.phys_addr[i] = dev->dev_addr[i];
 	}
 
-	lp->init_block.mode = 0x0000;            /* Enable the Tx and Rx */
+	lp->init_block.mode = 0x0000;	/* Enable the Tx and Rx */
 }
 
 
-static void depca_tx_timeout (struct net_device *dev)
+static void depca_tx_timeout(struct net_device *dev)
 {
 	u_long ioaddr = dev->base_addr;
 
-	printk ("%s: transmit timed out, status %04x, resetting.\n",
-		dev->name, inw (DEPCA_DATA));
+	printk("%s: transmit timed out, status %04x, resetting.\n", dev->name, inw(DEPCA_DATA));
 
 	STOP_DEPCA;
-	depca_init_ring (dev);
-	LoadCSRs (dev);
+	depca_init_ring(dev);
+	LoadCSRs(dev);
 	dev->trans_start = jiffies;
-	netif_wake_queue (dev);
-	InitRestartDepca (dev);
+	netif_wake_queue(dev);
+	InitRestartDepca(dev);
 }
 
 
 /* 
 ** Writes a socket buffer to TX descriptor ring and starts transmission 
 */
-static int depca_start_xmit (struct sk_buff *skb, struct net_device *dev)
+static int depca_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct depca_private *lp = (struct depca_private *) dev->priv;
 	u_long ioaddr = dev->base_addr;
@@ -879,32 +867,32 @@
 	if (skb->len < 1)
 		goto out;
 
-	netif_stop_queue (dev);
+	netif_stop_queue(dev);
 
 	if (TX_BUFFS_AVAIL) {	/* Fill in a Tx ring entry */
-		status = load_packet (dev, skb);
+		status = load_packet(dev, skb);
 
 		if (!status) {
 			/* Trigger an immediate send demand. */
-			outw (CSR0, DEPCA_ADDR);
-			outw (INEA | TDMD, DEPCA_DATA);
+			outw(CSR0, DEPCA_ADDR);
+			outw(INEA | TDMD, DEPCA_DATA);
 
 			dev->trans_start = jiffies;
-			dev_kfree_skb (skb);
+			dev_kfree_skb(skb);
 		}
 		if (TX_BUFFS_AVAIL)
-			netif_start_queue (dev);
+			netif_start_queue(dev);
 	} else
 		status = -1;
 
-out:
+      out:
 	return status;
 }
 
 /*
 ** The DEPCA interrupt handler. 
 */
-static void depca_interrupt (int irq, void *dev_id, struct pt_regs *regs)
+static void depca_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
 	struct depca_private *lp;
@@ -912,308 +900,301 @@
 	u_long ioaddr;
 
 	if (dev == NULL) {
-		printk ("depca_interrupt(): irq %d for unknown device.\n", irq);
+		printk("depca_interrupt(): irq %d for unknown device.\n", irq);
 		return;
 	}
 
 	lp = (struct depca_private *) dev->priv;
 	ioaddr = dev->base_addr;
 
-	spin_lock (&lp->lock);
+	spin_lock(&lp->lock);
 
 	/* mask the DEPCA board interrupts and turn on the LED */
-	nicsr = inb (DEPCA_NICSR);
+	nicsr = inb(DEPCA_NICSR);
 	nicsr |= (IM | LED);
-	outb (nicsr, DEPCA_NICSR);
+	outb(nicsr, DEPCA_NICSR);
 
-	outw (CSR0, DEPCA_ADDR);
-	csr0 = inw (DEPCA_DATA);
+	outw(CSR0, DEPCA_ADDR);
+	csr0 = inw(DEPCA_DATA);
 
 	/* Acknowledge all of the current interrupt sources ASAP. */
-	outw (csr0 & INTE, DEPCA_DATA);
+	outw(csr0 & INTE, DEPCA_DATA);
 
 	if (csr0 & RINT)	/* Rx interrupt (packet arrived) */
-		depca_rx (dev);
+		depca_rx(dev);
 
 	if (csr0 & TINT)	/* Tx interrupt (packet sent) */
-		depca_tx (dev);
+		depca_tx(dev);
 
 	/* Any resources available? */
 	if ((TX_BUFFS_AVAIL >= 0) && netif_queue_stopped(dev)) {
-		netif_wake_queue (dev);
+		netif_wake_queue(dev);
 	}
 
 	/* Unmask the DEPCA board interrupts and turn off the LED */
 	nicsr = (nicsr & ~IM & ~LED);
-	outb (nicsr, DEPCA_NICSR);
+	outb(nicsr, DEPCA_NICSR);
 
-	spin_unlock (&lp->lock);
+	spin_unlock(&lp->lock);
 }
 
 
-static int
-depca_rx(struct net_device *dev)
+static int depca_rx(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  int i, entry;
-  s32 status;
-
-  for (entry=lp->rx_new; 
-       !(readl(&lp->rx_ring[entry].base) & R_OWN);
-       entry=lp->rx_new){
-    status = readl(&lp->rx_ring[entry].base) >> 16 ;
-    if (status & R_STP) {                      /* Remember start of frame */
-      lp->rx_old = entry;
-    }
-    if (status & R_ENP) {                      /* Valid frame status */
-      if (status & R_ERR) {	               /* There was an error. */
-	lp->stats.rx_errors++;                 /* Update the error stats. */
-	if (status & R_FRAM) lp->stats.rx_frame_errors++;
-	if (status & R_OFLO) lp->stats.rx_over_errors++;
-	if (status & R_CRC)  lp->stats.rx_crc_errors++;
-	if (status & R_BUFF) lp->stats.rx_fifo_errors++;
-      } else {	
-	short len, pkt_len = readw(&lp->rx_ring[entry].msg_length) - 4;
-	struct sk_buff *skb;
-
-	skb = dev_alloc_skb(pkt_len+2);
-	if (skb != NULL) {
-	  unsigned char *buf;
-	  skb_reserve(skb,2);               /* 16 byte align the IP header */
-	  buf = skb_put(skb,pkt_len);
-	  skb->dev = dev;
-	  if (entry < lp->rx_old) {         /* Wrapped buffer */
-	    len = (lp->rxRingMask - lp->rx_old + 1) * RX_BUFF_SZ;
-	    memcpy_fromio(buf, lp->rx_buff[lp->rx_old], len);
-	    memcpy_fromio(buf + len, lp->rx_buff[0], pkt_len-len);
-	  } else {                          /* Linear buffer */
-	    memcpy_fromio(buf, lp->rx_buff[lp->rx_old], pkt_len);
-	  }
-
-	  /* 
-	  ** Notify the upper protocol layers that there is another 
-	  ** packet to handle
-	  */
-	  skb->protocol=eth_type_trans(skb,dev);
-	  netif_rx(skb);
-
-	  /*
-	  ** Update stats
-	  */
-	  dev->last_rx = jiffies;
-	  lp->stats.rx_packets++;
-	  lp->stats.rx_bytes += pkt_len;
-	  for (i=1; i<DEPCA_PKT_STAT_SZ-1; i++) {
-	    if (pkt_len < (i*DEPCA_PKT_BIN_SZ)) {
-	      lp->pktStats.bins[i]++;
-	      i = DEPCA_PKT_STAT_SZ;
-	    }
-	  }
-	  if (buf[0] & 0x01) {              /* Multicast/Broadcast */
-	    if ((*(s16 *)&buf[0] == -1) &&
-		(*(s16 *)&buf[2] == -1) &&
-		(*(s16 *)&buf[4] == -1)) {
-	      lp->pktStats.broadcast++;
-	    } else {
-	      lp->pktStats.multicast++;
-	    }
-	  } else if ((*(s16 *)&buf[0] == *(s16 *)&dev->dev_addr[0]) &&
-		     (*(s16 *)&buf[2] == *(s16 *)&dev->dev_addr[2]) &&
-		     (*(s16 *)&buf[4] == *(s16 *)&dev->dev_addr[4])) {
-	    lp->pktStats.unicast++;
-	  }
-	  
-	  lp->pktStats.bins[0]++;           /* Duplicates stats.rx_packets */
-	  if (lp->pktStats.bins[0] == 0) {  /* Reset counters */
-	    memset((char *)&lp->pktStats, 0, sizeof(lp->pktStats));
-	  }
-	} else {
-	  printk("%s: Memory squeeze, deferring packet.\n", dev->name);
-	  lp->stats.rx_dropped++;	/* Really, deferred. */
-	  break;
-	}
-      }
-      /* Change buffer ownership for this last frame, back to the adapter */
-      for (; lp->rx_old!=entry; lp->rx_old=(++lp->rx_old)&lp->rxRingMask) {
-	writel(readl(&lp->rx_ring[lp->rx_old].base) | R_OWN, 
-	                                        &lp->rx_ring[lp->rx_old].base);
-      }
-      writel(readl(&lp->rx_ring[entry].base) | R_OWN, &lp->rx_ring[entry].base);
-    }
-
-    /*
-    ** Update entry information
-    */
-    lp->rx_new = (++lp->rx_new) & lp->rxRingMask;
-    }
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	int i, entry;
+	s32 status;
 
-    return 0;
+	for (entry = lp->rx_new; !(readl(&lp->rx_ring[entry].base) & R_OWN); entry = lp->rx_new) {
+		status = readl(&lp->rx_ring[entry].base) >> 16;
+		if (status & R_STP) {	/* Remember start of frame */
+			lp->rx_old = entry;
+		}
+		if (status & R_ENP) {	/* Valid frame status */
+			if (status & R_ERR) {	/* There was an error. */
+				lp->stats.rx_errors++;	/* Update the error stats. */
+				if (status & R_FRAM)
+					lp->stats.rx_frame_errors++;
+				if (status & R_OFLO)
+					lp->stats.rx_over_errors++;
+				if (status & R_CRC)
+					lp->stats.rx_crc_errors++;
+				if (status & R_BUFF)
+					lp->stats.rx_fifo_errors++;
+			} else {
+				short len, pkt_len = readw(&lp->rx_ring[entry].msg_length) - 4;
+				struct sk_buff *skb;
+
+				skb = dev_alloc_skb(pkt_len + 2);
+				if (skb != NULL) {
+					unsigned char *buf;
+					skb_reserve(skb, 2);	/* 16 byte align the IP header */
+					buf = skb_put(skb, pkt_len);
+					skb->dev = dev;
+					if (entry < lp->rx_old) {	/* Wrapped buffer */
+						len = (lp->rxRingMask - lp->rx_old + 1) * RX_BUFF_SZ;
+						memcpy_fromio(buf, lp->rx_buff[lp->rx_old], len);
+						memcpy_fromio(buf + len, lp->rx_buff[0], pkt_len - len);
+					} else {	/* Linear buffer */
+						memcpy_fromio(buf, lp->rx_buff[lp->rx_old], pkt_len);
+					}
+
+					/* 
+					   ** Notify the upper protocol layers that there is another 
+					   ** packet to handle
+					 */
+					skb->protocol = eth_type_trans(skb, dev);
+					netif_rx(skb);
+
+					/*
+					   ** Update stats
+					 */
+					dev->last_rx = jiffies;
+					lp->stats.rx_packets++;
+					lp->stats.rx_bytes += pkt_len;
+					for (i = 1; i < DEPCA_PKT_STAT_SZ - 1; i++) {
+						if (pkt_len < (i * DEPCA_PKT_BIN_SZ)) {
+							lp->pktStats.bins[i]++;
+							i = DEPCA_PKT_STAT_SZ;
+						}
+					}
+					if (buf[0] & 0x01) {	/* Multicast/Broadcast */
+						if ((*(s16 *) & buf[0] == -1) && (*(s16 *) & buf[2] == -1) && (*(s16 *) & buf[4] == -1)) {
+							lp->pktStats.broadcast++;
+						} else {
+							lp->pktStats.multicast++;
+						}
+					} else if ((*(s16 *) & buf[0] == *(s16 *) & dev->dev_addr[0]) && (*(s16 *) & buf[2] == *(s16 *) & dev->dev_addr[2]) && (*(s16 *) & buf[4] == *(s16 *) & dev->dev_addr[4])) {
+						lp->pktStats.unicast++;
+					}
+
+					lp->pktStats.bins[0]++;	/* Duplicates stats.rx_packets */
+					if (lp->pktStats.bins[0] == 0) {	/* Reset counters */
+						memset((char *) &lp->pktStats, 0, sizeof(lp->pktStats));
+					}
+				} else {
+					printk("%s: Memory squeeze, deferring packet.\n", dev->name);
+					lp->stats.rx_dropped++;	/* Really, deferred. */
+					break;
+				}
+			}
+			/* Change buffer ownership for this last frame, back to the adapter */
+			for (; lp->rx_old != entry; lp->rx_old = (++lp->rx_old) & lp->rxRingMask) {
+				writel(readl(&lp->rx_ring[lp->rx_old].base) | R_OWN, &lp->rx_ring[lp->rx_old].base);
+			}
+			writel(readl(&lp->rx_ring[entry].base) | R_OWN, &lp->rx_ring[entry].base);
+		}
+
+		/*
+		   ** Update entry information
+		 */
+		lp->rx_new = (++lp->rx_new) & lp->rxRingMask;
+	}
+
+	return 0;
 }
 
 /*
 ** Buffer sent - check for buffer errors.
 */
-static int
-depca_tx(struct net_device *dev)
+static int depca_tx(struct net_device *dev)
+{
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	int entry;
+	s32 status;
+	u_long ioaddr = dev->base_addr;
+
+	for (entry = lp->tx_old; entry != lp->tx_new; entry = lp->tx_old) {
+		status = readl(&lp->tx_ring[entry].base) >> 16;
+
+		if (status < 0) {	/* Packet not yet sent! */
+			break;
+		} else if (status & T_ERR) {	/* An error occurred. */
+			status = readl(&lp->tx_ring[entry].misc);
+			lp->stats.tx_errors++;
+			if (status & TMD3_RTRY)
+				lp->stats.tx_aborted_errors++;
+			if (status & TMD3_LCAR)
+				lp->stats.tx_carrier_errors++;
+			if (status & TMD3_LCOL)
+				lp->stats.tx_window_errors++;
+			if (status & TMD3_UFLO)
+				lp->stats.tx_fifo_errors++;
+			if (status & (TMD3_BUFF | TMD3_UFLO)) {
+				/* Trigger an immediate send demand. */
+				outw(CSR0, DEPCA_ADDR);
+				outw(INEA | TDMD, DEPCA_DATA);
+			}
+		} else if (status & (T_MORE | T_ONE)) {
+			lp->stats.collisions++;
+		} else {
+			lp->stats.tx_packets++;
+		}
+
+		/* Update all the pointers */
+		lp->tx_old = (++lp->tx_old) & lp->txRingMask;
+	}
+
+	return 0;
+}
+
+static int depca_close(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  int entry;
-  s32 status;
-  u_long ioaddr = dev->base_addr;
-
-  for (entry = lp->tx_old; entry != lp->tx_new; entry = lp->tx_old) {
-    status = readl(&lp->tx_ring[entry].base) >> 16 ;
-
-    if (status < 0) {                          /* Packet not yet sent! */
-      break;
-    } else if (status & T_ERR) {               /* An error occurred. */
-      status = readl(&lp->tx_ring[entry].misc);
-      lp->stats.tx_errors++;
-      if (status & TMD3_RTRY) lp->stats.tx_aborted_errors++;
-      if (status & TMD3_LCAR) lp->stats.tx_carrier_errors++;
-      if (status & TMD3_LCOL) lp->stats.tx_window_errors++;
-      if (status & TMD3_UFLO) lp->stats.tx_fifo_errors++;
-      if (status & (TMD3_BUFF | TMD3_UFLO)) {
-	/* Trigger an immediate send demand. */
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	s16 nicsr;
+	u_long ioaddr = dev->base_addr;
+
+	netif_stop_queue(dev);
+
 	outw(CSR0, DEPCA_ADDR);
-	outw(INEA | TDMD, DEPCA_DATA);
-      }
-    } else if (status & (T_MORE | T_ONE)) {
-      lp->stats.collisions++;
-    } else {
-      lp->stats.tx_packets++;
-    }
-
-    /* Update all the pointers */
-    lp->tx_old = (++lp->tx_old) & lp->txRingMask;
-  }
-
-  return 0;
-}
-
-static int
-depca_close(struct net_device *dev)
-{
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  s16 nicsr;
-  u_long ioaddr = dev->base_addr;
-
-  netif_stop_queue(dev);
-
-  outw(CSR0, DEPCA_ADDR);
-
-  if (depca_debug > 1) {
-    printk("%s: Shutting down ethercard, status was %2.2x.\n",
-	   dev->name, inw(DEPCA_DATA));
-  }
-
-  /* 
-  ** We stop the DEPCA here -- it occasionally polls
-  ** memory if we don't. 
-  */
-  outw(STOP, DEPCA_DATA);
-
-  /*
-  ** Give back the ROM in case the user wants to go to DOS
-  */
-  if (lp->adapter != DEPCA) {
-    nicsr = inb(DEPCA_NICSR);
-    nicsr &= ~SHE;
-    outb(nicsr, DEPCA_NICSR);
-  }
-
-  /*
-  ** Free the associated irq
-  */
-  free_irq(dev->irq, dev);
-  return 0;
+
+	if (depca_debug > 1) {
+		printk("%s: Shutting down ethercard, status was %2.2x.\n", dev->name, inw(DEPCA_DATA));
+	}
+
+	/* 
+	   ** We stop the DEPCA here -- it occasionally polls
+	   ** memory if we don't. 
+	 */
+	outw(STOP, DEPCA_DATA);
+
+	/*
+	   ** Give back the ROM in case the user wants to go to DOS
+	 */
+	if (lp->adapter != DEPCA) {
+		nicsr = inb(DEPCA_NICSR);
+		nicsr &= ~SHE;
+		outb(nicsr, DEPCA_NICSR);
+	}
+
+	/*
+	   ** Free the associated irq
+	 */
+	free_irq(dev->irq, dev);
+	return 0;
 }
 
 static void LoadCSRs(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  u_long ioaddr = dev->base_addr;
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	u_long ioaddr = dev->base_addr;
 
-  outw(CSR1, DEPCA_ADDR);                /* initialisation block address LSW */
-  outw((u16)lp->device_ram_start, DEPCA_DATA);
-  outw(CSR2, DEPCA_ADDR);                /* initialisation block address MSW */
-  outw((u16)(lp->device_ram_start >> 16), DEPCA_DATA);
-  outw(CSR3, DEPCA_ADDR);                /* ALE control */
-  outw(ACON, DEPCA_DATA);
+	outw(CSR1, DEPCA_ADDR);	/* initialisation block address LSW */
+	outw((u16) lp->device_ram_start, DEPCA_DATA);
+	outw(CSR2, DEPCA_ADDR);	/* initialisation block address MSW */
+	outw((u16) (lp->device_ram_start >> 16), DEPCA_DATA);
+	outw(CSR3, DEPCA_ADDR);	/* ALE control */
+	outw(ACON, DEPCA_DATA);
 
-  outw(CSR0, DEPCA_ADDR);                /* Point back to CSR0 */
+	outw(CSR0, DEPCA_ADDR);	/* Point back to CSR0 */
 
-  return;
+	return;
 }
 
 static int InitRestartDepca(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  u_long ioaddr = dev->base_addr;
-  int i, status=0;
-
-  /* Copy the shadow init_block to shared memory */
-  memcpy_toio(lp->sh_mem, &lp->init_block, sizeof(struct depca_init));
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	u_long ioaddr = dev->base_addr;
+	int i, status = 0;
 
-  outw(CSR0, DEPCA_ADDR);                /* point back to CSR0 */
-  outw(INIT, DEPCA_DATA);                /* initialize DEPCA */
+	/* Copy the shadow init_block to shared memory */
+	memcpy_toio(lp->sh_mem, &lp->init_block, sizeof(struct depca_init));
 
-  /* wait for lance to complete initialisation */
-  for (i=0;(i<100) && !(inw(DEPCA_DATA) & IDON); i++); 
+	outw(CSR0, DEPCA_ADDR);	/* point back to CSR0 */
+	outw(INIT, DEPCA_DATA);	/* initialize DEPCA */
 
-  if (i!=100) {
-    /* clear IDON by writing a "1", enable interrupts and start lance */
-    outw(IDON | INEA | STRT, DEPCA_DATA);
-    if (depca_debug > 2) {
-      printk("%s: DEPCA open after %d ticks, init block 0x%08lx csr0 %4.4x.\n",
-	     dev->name, i, virt_to_phys(lp->sh_mem), inw(DEPCA_DATA));
-    }
-  } else {
-    printk("%s: DEPCA unopen after %d ticks, init block 0x%08lx csr0 %4.4x.\n",
-	     dev->name, i, virt_to_phys(lp->sh_mem), inw(DEPCA_DATA));
-    status = -1;
-  }
+	/* wait for lance to complete initialisation */
+	for (i = 0; (i < 100) && !(inw(DEPCA_DATA) & IDON); i++);
+
+	if (i != 100) {
+		/* clear IDON by writing a "1", enable interrupts and start lance */
+		outw(IDON | INEA | STRT, DEPCA_DATA);
+		if (depca_debug > 2) {
+			printk("%s: DEPCA open after %d ticks, init block 0x%08lx csr0 %4.4x.\n", dev->name, i, virt_to_phys(lp->sh_mem), inw(DEPCA_DATA));
+		}
+	} else {
+		printk("%s: DEPCA unopen after %d ticks, init block 0x%08lx csr0 %4.4x.\n", dev->name, i, virt_to_phys(lp->sh_mem), inw(DEPCA_DATA));
+		status = -1;
+	}
 
-  return status;
+	return status;
 }
 
-static struct net_device_stats *
-depca_get_stats(struct net_device *dev)
+static struct net_device_stats *depca_get_stats(struct net_device *dev)
 {
-    struct depca_private *lp = (struct depca_private *)dev->priv;
+	struct depca_private *lp = (struct depca_private *) dev->priv;
 
-    /* Null body since there is no framing error counter */
+	/* Null body since there is no framing error counter */
 
-    return &lp->stats;
+	return &lp->stats;
 }
 
 /*
 ** Set or clear the multicast filter for this adaptor.
 */
-static void
-set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  u_long ioaddr = dev->base_addr;
-  
-  if (dev) {
-    netif_stop_queue(dev);
-    while(lp->tx_old != lp->tx_new);  /* Wait for the ring to empty */
-
-    STOP_DEPCA;                       /* Temporarily stop the depca.  */
-    depca_init_ring(dev);             /* Initialize the descriptor rings */
-
-    if (dev->flags & IFF_PROMISC) {   /* Set promiscuous mode */
-      lp->init_block.mode |= PROM;
-    } else {
-      SetMulticastFilter(dev);
-      lp->init_block.mode &= ~PROM;   /* Unset promiscuous mode */
-    }
-
-    LoadCSRs(dev);                    /* Reload CSR3 */
-    InitRestartDepca(dev);            /* Resume normal operation. */
-    netif_start_queue(dev);           /* Unlock the TX ring */
-  }
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	u_long ioaddr = dev->base_addr;
+
+	if (dev) {
+		netif_stop_queue(dev);
+		while (lp->tx_old != lp->tx_new);	/* Wait for the ring to empty */
+
+		STOP_DEPCA;	/* Temporarily stop the depca.  */
+		depca_init_ring(dev);	/* Initialize the descriptor rings */
+
+		if (dev->flags & IFF_PROMISC) {	/* Set promiscuous mode */
+			lp->init_block.mode |= PROM;
+		} else {
+			SetMulticastFilter(dev);
+			lp->init_block.mode &= ~PROM;	/* Unset promiscuous mode */
+		}
+
+		LoadCSRs(dev);	/* Reload CSR3 */
+		InitRestartDepca(dev);	/* Resume normal operation. */
+		netif_start_queue(dev);	/* Unlock the TX ring */
+	}
 }
 
 /*
@@ -1224,274 +1205,277 @@
 */
 static void SetMulticastFilter(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  struct dev_mc_list *dmi=dev->mc_list;
-  char *addrs;
-  int i, j, bit, byte;
-  u16 hashcode;
-  u32 crc;
-
-  if (dev->flags & IFF_ALLMULTI) {         /* Set all multicast bits */
-    for (i=0; i<(HASH_TABLE_LEN>>3); i++) {
-      lp->init_block.mcast_table[i] = (char)0xff;
-    }
-  } else {
-    for (i=0; i<(HASH_TABLE_LEN>>3); i++){ /* Clear the multicast table */
-      lp->init_block.mcast_table[i]=0;
-    }
-                                           /* Add multicast addresses */
-    for (i=0;i<dev->mc_count;i++) {        /* for each address in the list */
-      addrs=dmi->dmi_addr;
-      dmi=dmi->next;
-      if ((*addrs & 0x01) == 1) {          /* multicast address? */ 
-        crc = ether_crc(ETH_ALEN, addrs);
-	hashcode = (crc & 1);              /* hashcode is 6 LSb of CRC ... */
-	for (j=0;j<5;j++) {                /* ... in reverse order. */
-	  hashcode = (hashcode << 1) | ((crc>>=1) & 1);
-	}                                      
-	
-	
-	byte = hashcode >> 3;              /* bit[3-5] -> byte in filter */
-	bit = 1 << (hashcode & 0x07);      /* bit[0-2] -> bit in byte */
-	lp->init_block.mcast_table[byte] |= bit;
-      }
-    }
-  }
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	struct dev_mc_list *dmi = dev->mc_list;
+	char *addrs;
+	int i, j, bit, byte;
+	u16 hashcode;
+	u32 crc;
+
+	if (dev->flags & IFF_ALLMULTI) {	/* Set all multicast bits */
+		for (i = 0; i < (HASH_TABLE_LEN >> 3); i++) {
+			lp->init_block.mcast_table[i] = (char) 0xff;
+		}
+	} else {
+		for (i = 0; i < (HASH_TABLE_LEN >> 3); i++) {	/* Clear the multicast table */
+			lp->init_block.mcast_table[i] = 0;
+		}
+		/* Add multicast addresses */
+		for (i = 0; i < dev->mc_count; i++) {	/* for each address in the list */
+			addrs = dmi->dmi_addr;
+			dmi = dmi->next;
+			if ((*addrs & 0x01) == 1) {	/* multicast address? */
+				crc = ether_crc(ETH_ALEN, addrs);
+				hashcode = (crc & 1);	/* hashcode is 6 LSb of CRC ... */
+				for (j = 0; j < 5; j++) {	/* ... in reverse order. */
+					hashcode = (hashcode << 1) | ((crc >>= 1) & 1);
+				}
+
 
-  return;
+				byte = hashcode >> 3;	/* bit[3-5] -> byte in filter */
+				bit = 1 << (hashcode & 0x07);	/* bit[0-2] -> bit in byte */
+				lp->init_block.mcast_table[byte] |= bit;
+			}
+		}
+	}
+
+	return;
 }
 
 #ifdef CONFIG_MCA
 /*
 ** Microchannel bus I/O device probe
 */
-static void __init 
-mca_probe(struct net_device *dev, u_long ioaddr)
+static void __init mca_probe(struct net_device *dev, u_long ioaddr)
 {
-    unsigned char pos[2];
-    unsigned char where;
-    unsigned long iobase;
-    int irq;
-    int slot = 0;
-
-    /*
-    ** See if we've been here before.
-    */
-    if ((!ioaddr && autoprobed) || (ioaddr && !loading_module)) return;   
+	unsigned char pos[2];
+	unsigned char where;
+	unsigned long iobase;
+	int irq;
+	int slot = 0;
 
-    if (MCA_bus) {
 	/*
-	** Search for the adapter.  If an address has been given, search 
-	** specifically for the card at that address.  Otherwise find the
-	** first card in the system.
-	*/
-	while ((dev!=NULL) && 
-	       ((slot=mca_find_adapter(DE212_ID, slot)) != MCA_NOTFOUND)) {
-	    pos[0] = mca_read_stored_pos(slot, 2);
-	    pos[1] = mca_read_stored_pos(slot, 3);
-
-	    /*
-	    ** IO of card is handled by bits 1 and 2 of pos0.    
-	    **
-	    **    bit2 bit1    IO
-	    **       0    0    0x2c00
-	    **       0    1    0x2c10
-	    **       1    0    0x2c20
-	    **       1    1    0x2c30
-	    */
-	    where = (pos[0] & 6) >> 1;
-	    iobase = 0x2c00 + (0x10 * where);
-	       
-	    if ((ioaddr) && (ioaddr != iobase)) {
-		/*
-		** Card was found, but not at the right IO location. Continue 
-		** scanning from the next MCA slot up for another card.
-		*/
-		slot++;
-		continue;
-	    }
-
-	    /*
-	    ** Found the adapter we were looking for. Now start setting it up.
-	    ** 
-	    ** First work on decoding the IRQ.  It's stored in the lower 4 bits
-	    ** of pos1.  Bits are as follows (from the ADF file):
-	    **
-	    **      Bits           
-	    **   3   2   1   0    IRQ 
-	    **   --------------------
-	    **   0   0   1   0     5
-	    **   0   0   0   1     9
-	    **   0   1   0   0    10
-	    **   1   0   0   0    11
-	    **/
-	    where = pos[1] & 0x0f;
-	    switch(where) {       
-	    case 1:
-		irq = 9;
-		break;
-	    case 2:
-		irq = 5;
-		break;
-	    case 4:
-		irq = 10;
-		break;
-	    case 8:
-		irq = 11;
-		break;
-	    default:
-		printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", dev->name, where);
+	   ** See if we've been here before.
+	 */
+	if ((!ioaddr && autoprobed) || (ioaddr && !loading_module))
 		return;
-	    }  
- 
-	    /*
-	    ** Shared memory address of adapter is stored in bits 3-5 of pos0.
-	    ** They are mapped as follows:
-	    **
-	    **    Bit
-	    **   5  4  3       Memory Addresses
-	    **   0  0  0       C0000-CFFFF (64K)
-	    **   1  0  0       C8000-CFFFF (32K)
-	    **   0  0  1       D0000-DFFFF (64K)
-	    **   1  0  1       D8000-DFFFF (32K)
-	    **   0  1  0       E0000-EFFFF (64K)
-	    **   1  1  0       E8000-EFFFF (32K)
-	    */ 
-	    where = (pos[0] & 0x18) >> 3; 
-	    mem = 0xc0000 + (where * 0x10000);
-	    if (pos[0] & 0x20) {
-		mem += 0x8000;
-	    }
-       
-	    /*
-	    ** Get everything allocated and initialized...  (almost just
-	    ** like the ISA and EISA probes)
-	    */
-	    if (DevicePresent(iobase) != 0) {
+
+	if (MCA_bus) {
 		/*
-		** If the MCA configuration says the card should be here,
-		** it really should be here.
-		*/
-		printk(KERN_ERR "%s: MCA reports card at 0x%lx but it is not
-responding.\n", dev->name, iobase);
-	    }
-       
-	    if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
-		if ((dev = alloc_device(dev, iobase)) != NULL) {
-		    dev->irq = irq;
-		    if (depca_hw_init(dev, iobase, slot) == 0) {       
+		   ** Search for the adapter.  If an address has been given, search 
+		   ** specifically for the card at that address.  Otherwise find the
+		   ** first card in the system.
+		 */
+		while ((dev != NULL) && ((slot = mca_find_adapter(DE212_ID, slot)) != MCA_NOTFOUND)) {
+			pos[0] = mca_read_stored_pos(slot, 2);
+			pos[1] = mca_read_stored_pos(slot, 3);
+
+			/*
+			   ** IO of card is handled by bits 1 and 2 of pos0.    
+			   **
+			   **    bit2 bit1    IO
+			   **       0    0    0x2c00
+			   **       0    1    0x2c10
+			   **       1    0    0x2c20
+			   **       1    1    0x2c30
+			 */
+			where = (pos[0] & 6) >> 1;
+			iobase = 0x2c00 + (0x10 * where);
+
+			if ((ioaddr) && (ioaddr != iobase)) {
+				/*
+				   ** Card was found, but not at the right IO location. Continue 
+				   ** scanning from the next MCA slot up for another card.
+				 */
+				slot++;
+				continue;
+			}
+
 			/*
-			** Adapter initialized correctly:  Name it in
-			** /proc/mca.
-			*/
-			mca_set_adapter_name(slot, "DE210/212 Ethernet Adapter");
-			mca_mark_as_used(slot);
-			num_depcas++;
-		    }
-		    num_eth++;
-		}
-	    } else if (autoprobed) {
-		printk(KERN_WARNING "%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
-	    }
-       
-	    /*
-	    ** If this is a probe by a module, return after setting up the
-	    ** given card.
-	    */
-	    if (ioaddr) return;
-       
-	    /*
-	    ** Set up to check the next slot and loop.
-	    */
-	    slot++;
+			   ** Found the adapter we were looking for. Now start setting it up.
+			   ** 
+			   ** First work on decoding the IRQ.  It's stored in the lower 4 bits
+			   ** of pos1.  Bits are as follows (from the ADF file):
+			   **
+			   **      Bits           
+			   **   3   2   1   0    IRQ 
+			   **   --------------------
+			   **   0   0   1   0     5
+			   **   0   0   0   1     9
+			   **   0   1   0   0    10
+			   **   1   0   0   0    11
+			   * */
+			where = pos[1] & 0x0f;
+			switch (where) {
+			case 1:
+				irq = 9;
+				break;
+			case 2:
+				irq = 5;
+				break;
+			case 4:
+				irq = 10;
+				break;
+			case 8:
+				irq = 11;
+				break;
+			default:
+				printk("%s: mca_probe IRQ error.  You should never get here (%d).\n", dev->name, where);
+				return;
+			}
+
+			/*
+			   ** Shared memory address of adapter is stored in bits 3-5 of pos0.
+			   ** They are mapped as follows:
+			   **
+			   **    Bit
+			   **   5  4  3       Memory Addresses
+			   **   0  0  0       C0000-CFFFF (64K)
+			   **   1  0  0       C8000-CFFFF (32K)
+			   **   0  0  1       D0000-DFFFF (64K)
+			   **   1  0  1       D8000-DFFFF (32K)
+			   **   0  1  0       E0000-EFFFF (64K)
+			   **   1  1  0       E8000-EFFFF (32K)
+			 */
+			where = (pos[0] & 0x18) >> 3;
+			mem = 0xc0000 + (where * 0x10000);
+			if (pos[0] & 0x20) {
+				mem += 0x8000;
+			}
+
+			/*
+			   ** Get everything allocated and initialized...  (almost just
+			   ** like the ISA and EISA probes)
+			 */
+			if (DevicePresent(iobase) != 0) {
+				/*
+				   ** If the MCA configuration says the card should be here,
+				   ** it really should be here.
+				 */
+				printk(KERN_ERR "%s: MCA reports card at 0x%lx but it is not responding.\n", dev->name, iobase);
+			}
+
+			if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
+				if ((dev = alloc_device(dev, iobase)) != NULL) {
+					dev->irq = irq;
+					if (depca_hw_init(dev, iobase, slot) == 0) {
+						/*
+						   ** Adapter initialized correctly:  Name it in
+						   ** /proc/mca.
+						 */
+						mca_set_adapter_name(slot, "DE210/212 Ethernet Adapter");
+						mca_mark_as_used(slot);
+						num_depcas++;
+					}
+					num_eth++;
+				}
+			} else if (autoprobed) {
+				printk(KERN_WARNING "%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
+			}
+
+			/*
+			   ** If this is a probe by a module, return after setting up the
+			   ** given card.
+			 */
+			if (ioaddr)
+				return;
+
+			/*
+			   ** Set up to check the next slot and loop.
+			 */
+			slot++;
+		}
 	}
-    }
 
-    return;
+	return;
 }
 #endif
 
 /*
 ** ISA bus I/O device probe
 */
-static void __init 
-isa_probe(struct net_device *dev, u_long ioaddr)
+static void __init isa_probe(struct net_device *dev, u_long ioaddr)
 {
-  int i = num_depcas, maxSlots;
-  s32 ports[] = DEPCA_IO_PORTS;
+	int i = num_depcas, maxSlots;
+	s32 ports[] = DEPCA_IO_PORTS;
 
-  if (!ioaddr && autoprobed) return ;          /* Been here before ! */
-  if (ioaddr > 0x400) return;                  /* EISA Address */
-  if (i >= MAX_NUM_DEPCAS) return;             /* Too many ISA adapters */
-
-  if (ioaddr == 0) {                           /* Autoprobing */
-    maxSlots = MAX_NUM_DEPCAS;
-  } else {                                     /* Probe a specific location */
-    ports[i] = ioaddr;
-    maxSlots = i + 1;
-  }
-
-  for (; (i<maxSlots) && (dev!=NULL) && ports[i]; i++) {
-    if (check_region(ports[i], DEPCA_TOTAL_SIZE) == 0) {
-      if (DevicePresent(ports[i]) == 0) { 
-	if ((dev = alloc_device(dev, ports[i])) != NULL) {
-	  if (depca_hw_init(dev, ports[i], -1) == 0) {
-	    num_depcas++;
-	  }
-	  num_eth++;
-	}
-      }
-    } else if (autoprobed) {
-      printk("%s: region already allocated at 0x%04x.\n", dev->name, ports[i]);
-    }
-  }
+	if (!ioaddr && autoprobed)
+		return;		/* Been here before ! */
+	if (ioaddr > 0x400)
+		return;		/* EISA Address */
+	if (i >= MAX_NUM_DEPCAS)
+		return;		/* Too many ISA adapters */
+
+	if (ioaddr == 0) {	/* Autoprobing */
+		maxSlots = MAX_NUM_DEPCAS;
+	} else {		/* Probe a specific location */
+		ports[i] = ioaddr;
+		maxSlots = i + 1;
+	}
+
+	for (; (i < maxSlots) && (dev != NULL) && ports[i]; i++) {
+		if (check_region(ports[i], DEPCA_TOTAL_SIZE) == 0) {
+			if (DevicePresent(ports[i]) == 0) {
+				if ((dev = alloc_device(dev, ports[i])) != NULL) {
+					if (depca_hw_init(dev, ports[i], -1) == 0) {
+						num_depcas++;
+					}
+					num_eth++;
+				}
+			}
+		} else if (autoprobed) {
+			printk("%s: region already allocated at 0x%04x.\n", dev->name, ports[i]);
+		}
+	}
 
-  return;
+	return;
 }
 
 /*
 ** EISA bus I/O device probe. Probe from slot 1 since slot 0 is usually
 ** the motherboard. Upto 15 EISA devices are supported.
 */
-static void __init 
-eisa_probe(struct net_device *dev, u_long ioaddr)
+static void __init eisa_probe(struct net_device *dev, u_long ioaddr)
 {
-  int i, maxSlots;
-  u_long iobase;
-  char name[DEPCA_STRLEN];
-
-  if (!ioaddr && autoprobed) return ;            /* Been here before ! */
-  if ((ioaddr < 0x400) && (ioaddr > 0)) return;  /* ISA Address */
-
-  if (ioaddr == 0) {                           /* Autoprobing */
-    iobase = EISA_SLOT_INC;                    /* Get the first slot address */
-    i = 1;
-    maxSlots = MAX_EISA_SLOTS;
-  } else {                                     /* Probe a specific location */
-    iobase = ioaddr;
-    i = (ioaddr >> 12);
-    maxSlots = i + 1;
-  }
-  if ((iobase & 0x0fff) == 0) iobase += DEPCA_EISA_IO_PORTS;
-
-  for (; (i<maxSlots) && (dev!=NULL); i++, iobase+=EISA_SLOT_INC) {
-    if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
-      if (EISA_signature(name, EISA_ID)) {
-	if (DevicePresent(iobase) == 0) { 
-	  if ((dev = alloc_device(dev, iobase)) != NULL) {
-	    if (depca_hw_init(dev, iobase, -1) == 0) {
-	      num_depcas++;
-	    }
-	    num_eth++;
-	  }
-	}
-      }
-    } else if (autoprobed) {
-      printk("%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
-    }
-  }
+	int i, maxSlots;
+	u_long iobase;
+	char name[DEPCA_STRLEN];
+
+	if (!ioaddr && autoprobed)
+		return;		/* Been here before ! */
+	if ((ioaddr < 0x400) && (ioaddr > 0))
+		return;		/* ISA Address */
+
+	if (ioaddr == 0) {	/* Autoprobing */
+		iobase = EISA_SLOT_INC;	/* Get the first slot address */
+		i = 1;
+		maxSlots = MAX_EISA_SLOTS;
+	} else {		/* Probe a specific location */
+		iobase = ioaddr;
+		i = (ioaddr >> 12);
+		maxSlots = i + 1;
+	}
+	if ((iobase & 0x0fff) == 0)
+		iobase += DEPCA_EISA_IO_PORTS;
+
+	for (; (i < maxSlots) && (dev != NULL); i++, iobase += EISA_SLOT_INC) {
+		if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
+			if (EISA_signature(name, EISA_ID)) {
+				if (DevicePresent(iobase) == 0) {
+					if ((dev = alloc_device(dev, iobase)) != NULL) {
+						if (depca_hw_init(dev, iobase, -1) == 0) {
+							num_depcas++;
+						}
+						num_eth++;
+					}
+				}
+			}
+		} else if (autoprobed) {
+			printk("%s: region already allocated at 0x%04lx.\n", dev->name, iobase);
+		}
+	}
 
-  return;
+	return;
 }
 
 /*
@@ -1500,89 +1484,87 @@
 ** are not available then insert a new device structure at the end of
 ** the current list.
 */
-static struct net_device * __init 
-alloc_device(struct net_device *dev, u_long iobase)
+static struct net_device *__init alloc_device(struct net_device *dev, u_long iobase)
 {
-    struct net_device *adev = NULL;
-    int fixed = 0, new_dev = 0;
+	struct net_device *adev = NULL;
+	int fixed = 0, new_dev = 0;
 
-    num_eth = depca_dev_index(dev->name);
-    if (loading_module) return dev;
-    
-    while (1) {
-	if (((dev->base_addr == DEPCA_NDA) || (dev->base_addr==0)) && !adev) {
-	    adev=dev;
-	} else if ((dev->priv == NULL) && (dev->base_addr==iobase)) {
-	    fixed = 1;
-	} else {
-	    if (dev->next == NULL) {
-		new_dev = 1;
-	    } else if (strncmp(dev->next->name, "eth", 3) != 0) {
-		new_dev = 1;
-	    }
-	}
-	if ((dev->next == NULL) || new_dev || fixed) break;
-	dev = dev->next;
-	num_eth++;
-    }
-    if (adev && !fixed) {
-	dev = adev;
 	num_eth = depca_dev_index(dev->name);
-	new_dev = 0;
-    }
+	if (loading_module)
+		return dev;
 
-    if (((dev->next == NULL) &&  
-	((dev->base_addr != DEPCA_NDA) && (dev->base_addr != 0)) && !fixed) ||
-	new_dev) {
-	num_eth++;                         /* New device */
-	dev = insert_device(dev, iobase, depca_probe);
-    }
-    
-    return dev;
+	while (1) {
+		if (((dev->base_addr == DEPCA_NDA) || (dev->base_addr == 0)) && !adev) {
+			adev = dev;
+		} else if ((dev->priv == NULL) && (dev->base_addr == iobase)) {
+			fixed = 1;
+		} else {
+			if (dev->next == NULL) {
+				new_dev = 1;
+			} else if (strncmp(dev->next->name, "eth", 3) != 0) {
+				new_dev = 1;
+			}
+		}
+		if ((dev->next == NULL) || new_dev || fixed)
+			break;
+		dev = dev->next;
+		num_eth++;
+	}
+	if (adev && !fixed) {
+		dev = adev;
+		num_eth = depca_dev_index(dev->name);
+		new_dev = 0;
+	}
+
+	if (((dev->next == NULL) && ((dev->base_addr != DEPCA_NDA) && (dev->base_addr != 0)) && !fixed) || new_dev) {
+		num_eth++;	/* New device */
+		dev = insert_device(dev, iobase, depca_probe);
+	}
+
+	return dev;
 }
 
 /*
 ** If at end of eth device list and can't use current entry, malloc
 ** one up. If memory could not be allocated, print an error message.
 */
-static struct net_device * __init 
-insert_device(struct net_device *dev, u_long iobase, int (*init)(struct net_device *))
+static struct net_device *__init insert_device(struct net_device *dev, u_long iobase, int (*init) (struct net_device *))
 {
-    struct net_device *new;
+	struct net_device *new;
 
-    new = (struct net_device *)kmalloc(sizeof(struct net_device), GFP_KERNEL);
-    if (new == NULL) {
-	printk("eth%d: Device not initialised, insufficient memory\n",num_eth);
-	return NULL;
-    } else {
-	new->next = dev->next;
-	dev->next = new;
-	dev = dev->next;               /* point to the new device */
-	if (num_eth > 9999) {
-	    sprintf(dev->name,"eth????");/* New device name */
+	new = (struct net_device *) kmalloc(sizeof(struct net_device), GFP_KERNEL);
+	if (new == NULL) {
+		printk("eth%d: Device not initialised, insufficient memory\n", num_eth);
+		return NULL;
 	} else {
-	    sprintf(dev->name,"eth%d", num_eth);/* New device name */
+		new->next = dev->next;
+		dev->next = new;
+		dev = dev->next;	/* point to the new device */
+		if (num_eth > 9999) {
+			sprintf(dev->name, "eth????");	/* New device name */
+		} else {
+			sprintf(dev->name, "eth%d", num_eth);	/* New device name */
+		}
+		dev->base_addr = iobase;	/* assign the io address */
+		dev->init = init;	/* initialisation routine */
 	}
-	dev->base_addr = iobase;       /* assign the io address */
-	dev->init = init;              /* initialisation routine */
-    }
 
-    return dev;
+	return dev;
 }
 
-static int __init 
-depca_dev_index(char *s)
+static int __init depca_dev_index(char *s)
 {
-    int i=0, j=0;
+	int i = 0, j = 0;
 
-    for (;*s; s++) {
-	if (isdigit(*s)) {
-	    j=1;
-	    i = (i * 10) + (*s - '0');
-	} else if (j) break;
-    }
+	for (; *s; s++) {
+		if (isdigit(*s)) {
+			j = 1;
+			i = (i * 10) + (*s - '0');
+		} else if (j)
+			break;
+	}
 
-    return i;
+	return i;
 }
 
 /*
@@ -1590,50 +1572,51 @@
 ** and Boot (readb) ROM. This will also give us a clue to the network RAM
 ** base address.
 */
-static void __init 
-DepcaSignature(char *name, u_long paddr)
+static void __init DepcaSignature(char *name, u_long paddr)
 {
-  u_int i,j,k;
-  const char *signatures[] = DEPCA_SIGNATURE;
-  void *ptr;
-  char tmpstr[16];
-
-  /* Copy the first 16 bytes of ROM */
-  ptr = ioremap(paddr + 0xc000, 16);
-  if (ptr == NULL) {
-	  printk(KERN_ERR "depca: I/O remap failed at %lx\n", paddr+0xc000);
-	  adapter = unknown;
-	  return;
-  }
-  for (i=0;i<16;i++) {
-    tmpstr[i] = readb(ptr + i);
-  }
-  iounmap(ptr);
-
-  /* Check if PROM contains a valid string */
-  for (i=0;*signatures[i]!='\0';i++) {
-    for (j=0,k=0;j<16 && k<strlen(signatures[i]);j++) {
-      if (signatures[i][k] == tmpstr[j]) {              /* track signature */
-	k++;
-      } else {                     /* lost signature; begin search again */
-	k=0;
-      }
-    }
-    if (k == strlen(signatures[i])) break;
-  }
-
-  /* Check if name string is valid, provided there's no PROM */
-  if (*name && (i == unknown)) {
-    for (i=0;*signatures[i]!='\0';i++) {
-      if (strcmp(name,signatures[i]) == 0) break;
-    }
-  }
-
-  /* Update search results */
-  strcpy(name,signatures[i]);
-  adapter = i;
+	u_int i, j, k;
+	const char *signatures[] = DEPCA_SIGNATURE;
+	void *ptr;
+	char tmpstr[16];
+
+	/* Copy the first 16 bytes of ROM */
+	ptr = ioremap(paddr + 0xc000, 16);
+	if (ptr == NULL) {
+		printk(KERN_ERR "depca: I/O remap failed at %lx\n", paddr + 0xc000);
+		adapter = unknown;
+		return;
+	}
+	for (i = 0; i < 16; i++) {
+		tmpstr[i] = readb(ptr + i);
+	}
+	iounmap(ptr);
+
+	/* Check if PROM contains a valid string */
+	for (i = 0; *signatures[i] != '\0'; i++) {
+		for (j = 0, k = 0; j < 16 && k < strlen(signatures[i]); j++) {
+			if (signatures[i][k] == tmpstr[j]) {	/* track signature */
+				k++;
+			} else {	/* lost signature; begin search again */
+				k = 0;
+			}
+		}
+		if (k == strlen(signatures[i]))
+			break;
+	}
 
-  return;
+	/* Check if name string is valid, provided there's no PROM */
+	if (*name && (i == unknown)) {
+		for (i = 0; *signatures[i] != '\0'; i++) {
+			if (strcmp(name, signatures[i]) == 0)
+				break;
+		}
+	}
+
+	/* Update search results */
+	strcpy(name, signatures[i]);
+	adapter = i;
+
+	return;
 }
 
 /*
@@ -1651,52 +1634,52 @@
 ** PROM address counter is correctly positioned at the start of the
 ** ethernet address for later read out.
 */
-static int __init 
-DevicePresent(u_long ioaddr)
+static int __init DevicePresent(u_long ioaddr)
 {
-  union {
-    struct {
-      u32 a;
-      u32 b;
-    } llsig;
-    char Sig[sizeof(u32) << 1];
-  } dev;
-  short sigLength=0;
-  s8 data;
-  s16 nicsr;
-  int i, j, status = 0;
-
-  data = inb(DEPCA_PROM);                /* clear counter on DEPCA */
-  data = inb(DEPCA_PROM);                /* read data */
-
-  if (data == 0x08) {                    /* Enable counter on DEPCA */
-    nicsr = inb(DEPCA_NICSR);
-    nicsr |= AAC;
-    outb(nicsr, DEPCA_NICSR);
-  }
-  
-  dev.llsig.a = ETH_PROM_SIG;
-  dev.llsig.b = ETH_PROM_SIG;
-  sigLength = sizeof(u32) << 1;
-
-  for (i=0,j=0;j<sigLength && i<PROBE_LENGTH+sigLength-1;i++) {
-    data = inb(DEPCA_PROM);
-    if (dev.Sig[j] == data) {    /* track signature */
-      j++;
-    } else {                     /* lost signature; begin search again */
-      if (data == dev.Sig[0]) {  /* rare case.... */
-	j=1;
-      } else {
-	j=0;
-      }
-    }
-  }
-
-  if (j!=sigLength) {
-    status = -ENODEV;           /* search failed */
-  }
+	union {
+		struct {
+			u32 a;
+			u32 b;
+		} llsig;
+		char Sig[sizeof(u32) << 1];
+	}
+	dev;
+	short sigLength = 0;
+	s8 data;
+	s16 nicsr;
+	int i, j, status = 0;
+
+	data = inb(DEPCA_PROM);	/* clear counter on DEPCA */
+	data = inb(DEPCA_PROM);	/* read data */
 
-  return status;
+	if (data == 0x08) {	/* Enable counter on DEPCA */
+		nicsr = inb(DEPCA_NICSR);
+		nicsr |= AAC;
+		outb(nicsr, DEPCA_NICSR);
+	}
+
+	dev.llsig.a = ETH_PROM_SIG;
+	dev.llsig.b = ETH_PROM_SIG;
+	sigLength = sizeof(u32) << 1;
+
+	for (i = 0, j = 0; j < sigLength && i < PROBE_LENGTH + sigLength - 1; i++) {
+		data = inb(DEPCA_PROM);
+		if (dev.Sig[j] == data) {	/* track signature */
+			j++;
+		} else {	/* lost signature; begin search again */
+			if (data == dev.Sig[0]) {	/* rare case.... */
+				j = 1;
+			} else {
+				j = 0;
+			}
+		}
+	}
+
+	if (j != sigLength) {
+		status = -ENODEV;	/* search failed */
+	}
+
+	return status;
 }
 
 /*
@@ -1704,33 +1687,36 @@
 ** reason: access the upper half of the PROM with x=0; access the lower half
 ** with x=1.
 */
-static int __init 
-get_hw_addr(struct net_device *dev)
+static int __init get_hw_addr(struct net_device *dev)
 {
-  u_long ioaddr = dev->base_addr;
-  int i, k, tmp, status = 0;
-  u_short j, x, chksum;
-
-  x = (((adapter == de100) || (adapter == de101)) ? 1 : 0);
-
-  for (i=0,k=0,j=0;j<3;j++) {
-    k <<= 1 ;
-    if (k > 0xffff) k-=0xffff;
-
-    k += (u_char) (tmp = inb(DEPCA_PROM + x));
-    dev->dev_addr[i++] = (u_char) tmp;
-    k += (u_short) ((tmp = inb(DEPCA_PROM + x)) << 8);
-    dev->dev_addr[i++] = (u_char) tmp;
+	u_long ioaddr = dev->base_addr;
+	int i, k, tmp, status = 0;
+	u_short j, x, chksum;
 
-    if (k > 0xffff) k-=0xffff;
-  }
-  if (k == 0xffff) k=0;
+	x = (((adapter == de100) || (adapter == de101)) ? 1 : 0);
 
-  chksum = (u_char) inb(DEPCA_PROM + x);
-  chksum |= (u_short) (inb(DEPCA_PROM + x) << 8);
-  if (k != chksum) status = -1;
+	for (i = 0, k = 0, j = 0; j < 3; j++) {
+		k <<= 1;
+		if (k > 0xffff)
+			k -= 0xffff;
+
+		k += (u_char) (tmp = inb(DEPCA_PROM + x));
+		dev->dev_addr[i++] = (u_char) tmp;
+		k += (u_short) ((tmp = inb(DEPCA_PROM + x)) << 8);
+		dev->dev_addr[i++] = (u_char) tmp;
+
+		if (k > 0xffff)
+			k -= 0xffff;
+	}
+	if (k == 0xffff)
+		k = 0;
+
+	chksum = (u_char) inb(DEPCA_PROM + x);
+	chksum |= (u_short) (inb(DEPCA_PROM + x) << 8);
+	if (k != chksum)
+		status = -1;
 
-  return status;
+	return status;
 }
 
 /*
@@ -1738,165 +1724,161 @@
 */
 static int load_packet(struct net_device *dev, struct sk_buff *skb)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  int i, entry, end, len, status = 0;
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	int i, entry, end, len, status = 0;
 
-  entry = lp->tx_new;  		               /* Ring around buffer number. */
-  end = (entry + (skb->len - 1) / TX_BUFF_SZ) & lp->txRingMask;
-  if (!(readl(&lp->tx_ring[end].base) & T_OWN)) {/* Enough room? */
-    /* 
-    ** Caution: the write order is important here... don't set up the
-    ** ownership rights until all the other information is in place.
-    */
-    if (end < entry) {                         /* wrapped buffer */
-      len = (lp->txRingMask - entry + 1) * TX_BUFF_SZ;
-      memcpy_toio(lp->tx_buff[entry], skb->data, len);
-      memcpy_toio(lp->tx_buff[0], skb->data + len, skb->len - len);
-    } else {                                   /* linear buffer */
-      memcpy_toio(lp->tx_buff[entry], skb->data, skb->len);
-    }
-
-    /* set up the buffer descriptors */
-    len = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
-    for (i = entry; i != end; i = (++i) & lp->txRingMask) {
-                                               /* clean out flags */
-      writel(readl(&lp->tx_ring[i].base) & ~T_FLAGS, &lp->tx_ring[i].base);
-      writew(0x0000, &lp->tx_ring[i].misc);    /* clears other error flags */
-      writew(-TX_BUFF_SZ, &lp->tx_ring[i].length);/* packet length in buffer */
-      len -= TX_BUFF_SZ;
-    }
-                                               /* clean out flags */
-    writel(readl(&lp->tx_ring[end].base) & ~T_FLAGS, &lp->tx_ring[end].base);
-    writew(0x0000, &lp->tx_ring[end].misc);    /* clears other error flags */
-    writew(-len, &lp->tx_ring[end].length);    /* packet length in last buff */
-
-                                               /* start of packet */
-    writel(readl(&lp->tx_ring[entry].base) | T_STP, &lp->tx_ring[entry].base);
-                                               /* end of packet */
-    writel(readl(&lp->tx_ring[end].base) | T_ENP, &lp->tx_ring[end].base);
-
-    for (i=end; i!=entry; --i) {
-                                               /* ownership of packet */
-      writel(readl(&lp->tx_ring[i].base) | T_OWN, &lp->tx_ring[i].base);
-      if (i == 0) i=lp->txRingMask+1;
-    }   
-    writel(readl(&lp->tx_ring[entry].base) | T_OWN, &lp->tx_ring[entry].base);
- 
-    lp->tx_new = (++end) & lp->txRingMask;     /* update current pointers */
-  } else {
-    status = -1;
-  }
+	entry = lp->tx_new;	/* Ring around buffer number. */
+	end = (entry + (skb->len - 1) / TX_BUFF_SZ) & lp->txRingMask;
+	if (!(readl(&lp->tx_ring[end].base) & T_OWN)) {	/* Enough room? */
+		/* 
+		   ** Caution: the write order is important here... don't set up the
+		   ** ownership rights until all the other information is in place.
+		 */
+		if (end < entry) {	/* wrapped buffer */
+			len = (lp->txRingMask - entry + 1) * TX_BUFF_SZ;
+			memcpy_toio(lp->tx_buff[entry], skb->data, len);
+			memcpy_toio(lp->tx_buff[0], skb->data + len, skb->len - len);
+		} else {	/* linear buffer */
+			memcpy_toio(lp->tx_buff[entry], skb->data, skb->len);
+		}
 
-  return status;
+		/* set up the buffer descriptors */
+		len = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
+		for (i = entry; i != end; i = (++i) & lp->txRingMask) {
+			/* clean out flags */
+			writel(readl(&lp->tx_ring[i].base) & ~T_FLAGS, &lp->tx_ring[i].base);
+			writew(0x0000, &lp->tx_ring[i].misc);	/* clears other error flags */
+			writew(-TX_BUFF_SZ, &lp->tx_ring[i].length);	/* packet length in buffer */
+			len -= TX_BUFF_SZ;
+		}
+		/* clean out flags */
+		writel(readl(&lp->tx_ring[end].base) & ~T_FLAGS, &lp->tx_ring[end].base);
+		writew(0x0000, &lp->tx_ring[end].misc);	/* clears other error flags */
+		writew(-len, &lp->tx_ring[end].length);	/* packet length in last buff */
+
+		/* start of packet */
+		writel(readl(&lp->tx_ring[entry].base) | T_STP, &lp->tx_ring[entry].base);
+		/* end of packet */
+		writel(readl(&lp->tx_ring[end].base) | T_ENP, &lp->tx_ring[end].base);
+
+		for (i = end; i != entry; --i) {
+			/* ownership of packet */
+			writel(readl(&lp->tx_ring[i].base) | T_OWN, &lp->tx_ring[i].base);
+			if (i == 0)
+				i = lp->txRingMask + 1;
+		}
+		writel(readl(&lp->tx_ring[entry].base) | T_OWN, &lp->tx_ring[entry].base);
+
+		lp->tx_new = (++end) & lp->txRingMask;	/* update current pointers */
+	} else {
+		status = -1;
+	}
+
+	return status;
 }
 
 /*
 ** Look for a particular board name in the EISA configuration space
 */
-static int __init 
-EISA_signature(char *name, s32 eisa_id)
+static int __init EISA_signature(char *name, s32 eisa_id)
 {
-  u_int i;
-  const char *signatures[] = DEPCA_SIGNATURE;
-  char ManCode[DEPCA_STRLEN];
-  union {
-    s32 ID;
-    char Id[4];
-  } Eisa;
-  int status = 0;
-
-  *name = '\0';
-  Eisa.ID = inl(eisa_id);
-
-  ManCode[0]=(((Eisa.Id[0]>>2)&0x1f)+0x40);
-  ManCode[1]=(((Eisa.Id[1]&0xe0)>>5)+((Eisa.Id[0]&0x03)<<3)+0x40);
-  ManCode[2]=(((Eisa.Id[2]>>4)&0x0f)+0x30);
-  ManCode[3]=(( Eisa.Id[2]&0x0f)+0x30);
-  ManCode[4]=(((Eisa.Id[3]>>4)&0x0f)+0x30);
-  ManCode[5]='\0';
-
-  for (i=0;(*signatures[i] != '\0') && (*name == '\0');i++) {
-    if (strstr(ManCode, signatures[i]) != NULL) {
-      strcpy(name,ManCode);
-      status = 1;
-    }
-  }
+	u_int i;
+	const char *signatures[] = DEPCA_SIGNATURE;
+	char ManCode[DEPCA_STRLEN];
+	union {
+		s32 ID;
+		char Id[4];
+	} Eisa;
+	int status = 0;
+
+	*name = '\0';
+	Eisa.ID = inl(eisa_id);
+
+	ManCode[0] = (((Eisa.Id[0] >> 2) & 0x1f) + 0x40);
+	ManCode[1] = (((Eisa.Id[1] & 0xe0) >> 5) + ((Eisa.Id[0] & 0x03) << 3) + 0x40);
+	ManCode[2] = (((Eisa.Id[2] >> 4) & 0x0f) + 0x30);
+	ManCode[3] = ((Eisa.Id[2] & 0x0f) + 0x30);
+	ManCode[4] = (((Eisa.Id[3] >> 4) & 0x0f) + 0x30);
+	ManCode[5] = '\0';
+
+	for (i = 0; (*signatures[i] != '\0') && (*name == '\0'); i++) {
+		if (strstr(ManCode, signatures[i]) != NULL) {
+			strcpy(name, ManCode);
+			status = 1;
+		}
+	}
 
-  return status;
+	return status;
 }
 
 static void depca_dbg_open(struct net_device *dev)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  u_long ioaddr = dev->base_addr;
-  struct depca_init *p = &lp->init_block;
-  int i; 
-
-  if (depca_debug > 1){
-    /* Do not copy the shadow init block into shared memory */
-    /* Debugging should not affect normal operation! */
-    /* The shadow init block will get copied across during InitRestartDepca */
-    printk("%s: depca open with irq %d\n",dev->name,dev->irq);
-    printk("Descriptor head addresses (CPU):\n");
-    printk("        0x%lx  0x%lx\n",(u_long)lp->rx_ring, (u_long)lp->tx_ring);
-    printk("Descriptor addresses (CPU):\nRX: ");
-    for (i=0;i<lp->rxRingMask;i++){
-      if (i < 3) {
-	printk("0x%8.8lx ", (long) &lp->rx_ring[i].base);
-      }
-    }
-    printk("...0x%8.8lx\n", (long) &lp->rx_ring[i].base);
-    printk("TX: ");
-    for (i=0;i<lp->txRingMask;i++){
-      if (i < 3) {
-	printk("0x%8.8lx ", (long) &lp->tx_ring[i].base);
-      }
-    }
-    printk("...0x%8.8lx\n", (long) &lp->tx_ring[i].base);
-    printk("\nDescriptor buffers (Device):\nRX: ");
-    for (i=0;i<lp->rxRingMask;i++){
-      if (i < 3) {
-	printk("0x%8.8x  ", readl(&lp->rx_ring[i].base));
-      }
-    }
-    printk("...0x%8.8x\n", readl(&lp->rx_ring[i].base));
-    printk("TX: ");
-    for (i=0;i<lp->txRingMask;i++){
-      if (i < 3) {
-	printk("0x%8.8x  ", readl(&lp->tx_ring[i].base));
-      }
-    }
-    printk("...0x%8.8x\n", readl(&lp->tx_ring[i].base));
-    printk("Initialisation block at 0x%8.8lx(Phys)\n",virt_to_phys(lp->sh_mem));
-    printk("        mode: 0x%4.4x\n",p->mode);
-    printk("        physical address: ");
-    for (i=0;i<ETH_ALEN-1;i++){
-      printk("%2.2x:", p->phys_addr[i]);
-    }
-    printk("%2.2x\n", p->phys_addr[i]);
-    printk("        multicast hash table: ");
-    for (i=0;i<(HASH_TABLE_LEN >> 3)-1;i++){
-      printk("%2.2x:", p->mcast_table[i]);
-    }
-    printk("%2.2x\n", p->mcast_table[i]);
-    printk("        rx_ring at: 0x%8.8x\n", p->rx_ring);
-    printk("        tx_ring at: 0x%8.8x\n", p->tx_ring);
-    printk("buffers (Phys): 0x%8.8lx\n",virt_to_phys(lp->sh_mem)+lp->buffs_offset);
-    printk("Ring size:\nRX: %d  Log2(rxRingMask): 0x%8.8x\n", 
-	   (int)lp->rxRingMask + 1, 
-	   lp->rx_rlen);
-    printk("TX: %d  Log2(txRingMask): 0x%8.8x\n", 
-	   (int)lp->txRingMask + 1, 
-	   lp->tx_rlen);
-    outw(CSR2,DEPCA_ADDR);
-    printk("CSR2&1: 0x%4.4x",inw(DEPCA_DATA));
-    outw(CSR1,DEPCA_ADDR);
-    printk("%4.4x\n",inw(DEPCA_DATA));
-    outw(CSR3,DEPCA_ADDR);
-    printk("CSR3: 0x%4.4x\n",inw(DEPCA_DATA));
-  }
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	u_long ioaddr = dev->base_addr;
+	struct depca_init *p = &lp->init_block;
+	int i;
 
-  return;
+	if (depca_debug > 1) {
+		/* Do not copy the shadow init block into shared memory */
+		/* Debugging should not affect normal operation! */
+		/* The shadow init block will get copied across during InitRestartDepca */
+		printk("%s: depca open with irq %d\n", dev->name, dev->irq);
+		printk("Descriptor head addresses (CPU):\n");
+		printk("        0x%lx  0x%lx\n", (u_long) lp->rx_ring, (u_long) lp->tx_ring);
+		printk("Descriptor addresses (CPU):\nRX: ");
+		for (i = 0; i < lp->rxRingMask; i++) {
+			if (i < 3) {
+				printk("0x%8.8lx ", (long) &lp->rx_ring[i].base);
+			}
+		}
+		printk("...0x%8.8lx\n", (long) &lp->rx_ring[i].base);
+		printk("TX: ");
+		for (i = 0; i < lp->txRingMask; i++) {
+			if (i < 3) {
+				printk("0x%8.8lx ", (long) &lp->tx_ring[i].base);
+			}
+		}
+		printk("...0x%8.8lx\n", (long) &lp->tx_ring[i].base);
+		printk("\nDescriptor buffers (Device):\nRX: ");
+		for (i = 0; i < lp->rxRingMask; i++) {
+			if (i < 3) {
+				printk("0x%8.8x  ", readl(&lp->rx_ring[i].base));
+			}
+		}
+		printk("...0x%8.8x\n", readl(&lp->rx_ring[i].base));
+		printk("TX: ");
+		for (i = 0; i < lp->txRingMask; i++) {
+			if (i < 3) {
+				printk("0x%8.8x  ", readl(&lp->tx_ring[i].base));
+			}
+		}
+		printk("...0x%8.8x\n", readl(&lp->tx_ring[i].base));
+		printk("Initialisation block at 0x%8.8lx(Phys)\n", virt_to_phys(lp->sh_mem));
+		printk("        mode: 0x%4.4x\n", p->mode);
+		printk("        physical address: ");
+		for (i = 0; i < ETH_ALEN - 1; i++) {
+			printk("%2.2x:", p->phys_addr[i]);
+		}
+		printk("%2.2x\n", p->phys_addr[i]);
+		printk("        multicast hash table: ");
+		for (i = 0; i < (HASH_TABLE_LEN >> 3) - 1; i++) {
+			printk("%2.2x:", p->mcast_table[i]);
+		}
+		printk("%2.2x\n", p->mcast_table[i]);
+		printk("        rx_ring at: 0x%8.8x\n", p->rx_ring);
+		printk("        tx_ring at: 0x%8.8x\n", p->tx_ring);
+		printk("buffers (Phys): 0x%8.8lx\n", virt_to_phys(lp->sh_mem) + lp->buffs_offset);
+		printk("Ring size:\nRX: %d  Log2(rxRingMask): 0x%8.8x\n", (int) lp->rxRingMask + 1, lp->rx_rlen);
+		printk("TX: %d  Log2(txRingMask): 0x%8.8x\n", (int) lp->txRingMask + 1, lp->tx_rlen);
+		outw(CSR2, DEPCA_ADDR);
+		printk("CSR2&1: 0x%4.4x", inw(DEPCA_DATA));
+		outw(CSR1, DEPCA_ADDR);
+		printk("%4.4x\n", inw(DEPCA_DATA));
+		outw(CSR3, DEPCA_ADDR);
+		printk("CSR3: 0x%4.4x\n", inw(DEPCA_DATA));
+	}
+
+	return;
 }
 
 /*
@@ -1906,177 +1888,196 @@
 */
 static int depca_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-  struct depca_private *lp = (struct depca_private *)dev->priv;
-  struct depca_ioctl *ioc = (struct depca_ioctl *) &rq->ifr_data;
-  int i, status = 0;
-  u_long ioaddr = dev->base_addr;
-  union {
-    u8  addr[(HASH_TABLE_LEN * ETH_ALEN)];
-    u16 sval[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
-    u32 lval[(HASH_TABLE_LEN * ETH_ALEN) >> 2];
-  } tmp;
-
-  switch(ioc->cmd) {
-  case DEPCA_GET_HWADDR:             /* Get the hardware address */
-    for (i=0; i<ETH_ALEN; i++) {
-      tmp.addr[i] = dev->dev_addr[i];
-    }
-    ioc->len = ETH_ALEN;
-    if (copy_to_user(ioc->data, tmp.addr, ioc->len))
-      return -EFAULT;
-    break;
-
-  case DEPCA_SET_HWADDR:             /* Set the hardware address */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    if (copy_from_user(tmp.addr, ioc->data, ETH_ALEN))
-      return -EFAULT;
-    for (i=0; i<ETH_ALEN; i++) {
-      dev->dev_addr[i] = tmp.addr[i];
-    }
-    netif_stop_queue(dev);
-    while(lp->tx_old != lp->tx_new);    /* Wait for the ring to empty */
-
-    STOP_DEPCA;                         /* Temporarily stop the depca.  */
-    depca_init_ring(dev);               /* Initialize the descriptor rings */
-    LoadCSRs(dev);                      /* Reload CSR3 */
-    InitRestartDepca(dev);              /* Resume normal operation. */
-    netif_start_queue(dev);             /* Unlock the TX ring */
-    break;
-
-  case DEPCA_SET_PROM:               /* Set Promiscuous Mode */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    netif_stop_queue(dev);
-    while(lp->tx_old != lp->tx_new);    /* Wait for the ring to empty */
-
-    STOP_DEPCA;                         /* Temporarily stop the depca.  */
-    depca_init_ring(dev);               /* Initialize the descriptor rings */
-    lp->init_block.mode |= PROM;        /* Set promiscuous mode */
-
-    LoadCSRs(dev);                      /* Reload CSR3 */
-    InitRestartDepca(dev);              /* Resume normal operation. */
-    netif_start_queue(dev);             /* Unlock the TX ring */
-    break;
-
-  case DEPCA_CLR_PROM:               /* Clear Promiscuous Mode */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    netif_stop_queue(dev);
-    while(lp->tx_old != lp->tx_new);    /* Wait for the ring to empty */
-
-    STOP_DEPCA;                         /* Temporarily stop the depca.  */
-    depca_init_ring(dev);               /* Initialize the descriptor rings */
-    lp->init_block.mode &= ~PROM;       /* Clear promiscuous mode */
-
-    LoadCSRs(dev);                      /* Reload CSR3 */
-    InitRestartDepca(dev);              /* Resume normal operation. */
-    netif_start_queue(dev);             /* Unlock the TX ring */
-    break;
-
-  case DEPCA_SAY_BOO:                /* Say "Boo!" to the kernel log file */
-    printk("%s: Boo!\n", dev->name);
-    break;
-
-  case DEPCA_GET_MCA:                /* Get the multicast address table */
-    ioc->len = (HASH_TABLE_LEN >> 3);
-    if (copy_to_user(ioc->data, lp->init_block.mcast_table, ioc->len))
-      return -EFAULT;
-    break;
-
-  case DEPCA_SET_MCA:                /* Set a multicast address */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    if (copy_from_user(tmp.addr, ioc->data, ETH_ALEN * ioc->len))
-      return -EFAULT;
-    set_multicast_list(dev);
-    break;
-
-  case DEPCA_CLR_MCA:                /* Clear all multicast addresses */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    set_multicast_list(dev);
-    break;
-
-  case DEPCA_MCA_EN:                 /* Enable pass all multicast addressing */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-      set_multicast_list(dev);
-    break;
-
-  case DEPCA_GET_STATS:              /* Get the driver statistics */
-    cli();
-    ioc->len = sizeof(lp->pktStats);
-    if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
-      status = -EFAULT;
-    sti();
-    break;
-
-  case DEPCA_CLR_STATS:              /* Zero out the driver statistics */
-    if (!capable(CAP_NET_ADMIN)) return -EPERM;
-    cli();
-    memset(&lp->pktStats, 0, sizeof(lp->pktStats));
-    sti();
-    break;
-
-  case DEPCA_GET_REG:                /* Get the DEPCA Registers */
-    i=0;
-    tmp.sval[i++] = inw(DEPCA_NICSR);
-    outw(CSR0, DEPCA_ADDR);              /* status register */
-    tmp.sval[i++] = inw(DEPCA_DATA);
-    memcpy(&tmp.sval[i], &lp->init_block, sizeof(struct depca_init));
-    ioc->len = i+sizeof(struct depca_init);
-    if (copy_to_user(ioc->data, tmp.addr, ioc->len))
-      return -EFAULT;
-    break;
-
-  default:
-    return -EOPNOTSUPP;
-  }
+	struct depca_private *lp = (struct depca_private *) dev->priv;
+	struct depca_ioctl *ioc = (struct depca_ioctl *) &rq->ifr_data;
+	int i, status = 0;
+	u_long ioaddr = dev->base_addr;
+	union {
+		u8 addr[(HASH_TABLE_LEN * ETH_ALEN)];
+		u16 sval[(HASH_TABLE_LEN * ETH_ALEN) >> 1];
+		u32 lval[(HASH_TABLE_LEN * ETH_ALEN) >> 2];
+	} tmp;
+	unsigned long flags;
+	void *buf;
+
+	switch (ioc->cmd) {
+	case DEPCA_GET_HWADDR:	/* Get the hardware address */
+		for (i = 0; i < ETH_ALEN; i++) {
+			tmp.addr[i] = dev->dev_addr[i];
+		}
+		ioc->len = ETH_ALEN;
+		if (copy_to_user(ioc->data, tmp.addr, ioc->len))
+			return -EFAULT;
+		break;
 
-  return status;
+	case DEPCA_SET_HWADDR:	/* Set the hardware address */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (copy_from_user(tmp.addr, ioc->data, ETH_ALEN))
+			return -EFAULT;
+		for (i = 0; i < ETH_ALEN; i++) {
+			dev->dev_addr[i] = tmp.addr[i];
+		}
+		netif_stop_queue(dev);
+		while (lp->tx_old != lp->tx_new)
+			cpu_relax();	/* Wait for the ring to empty */
+
+		STOP_DEPCA;	/* Temporarily stop the depca.  */
+		depca_init_ring(dev);	/* Initialize the descriptor rings */
+		LoadCSRs(dev);	/* Reload CSR3 */
+		InitRestartDepca(dev);	/* Resume normal operation. */
+		netif_start_queue(dev);	/* Unlock the TX ring */
+		break;
+
+	case DEPCA_SET_PROM:	/* Set Promiscuous Mode */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		netif_stop_queue(dev);
+		while (lp->tx_old != lp->tx_new)
+			cpu_relax();	/* Wait for the ring to empty */
+
+		STOP_DEPCA;	/* Temporarily stop the depca.  */
+		depca_init_ring(dev);	/* Initialize the descriptor rings */
+		lp->init_block.mode |= PROM;	/* Set promiscuous mode */
+
+		LoadCSRs(dev);	/* Reload CSR3 */
+		InitRestartDepca(dev);	/* Resume normal operation. */
+		netif_start_queue(dev);	/* Unlock the TX ring */
+		break;
+
+	case DEPCA_CLR_PROM:	/* Clear Promiscuous Mode */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		netif_stop_queue(dev);
+		while (lp->tx_old != lp->tx_new)
+			cpu_relax();	/* Wait for the ring to empty */
+
+		STOP_DEPCA;	/* Temporarily stop the depca.  */
+		depca_init_ring(dev);	/* Initialize the descriptor rings */
+		lp->init_block.mode &= ~PROM;	/* Clear promiscuous mode */
+
+		LoadCSRs(dev);	/* Reload CSR3 */
+		InitRestartDepca(dev);	/* Resume normal operation. */
+		netif_start_queue(dev);	/* Unlock the TX ring */
+		break;
+
+	case DEPCA_SAY_BOO:	/* Say "Boo!" to the kernel log file */
+		if(!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		printk("%s: Boo!\n", dev->name);
+		break;
+
+	case DEPCA_GET_MCA:	/* Get the multicast address table */
+		ioc->len = (HASH_TABLE_LEN >> 3);
+		if (copy_to_user(ioc->data, lp->init_block.mcast_table, ioc->len))
+			return -EFAULT;
+		break;
+
+	case DEPCA_SET_MCA:	/* Set a multicast address */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (ioc->len >= HASH_TABLE_LEN)
+			return -EINVAL;
+		if (copy_from_user(tmp.addr, ioc->data, ETH_ALEN * ioc->len))
+			return -EFAULT;
+		set_multicast_list(dev);
+		break;
+
+	case DEPCA_CLR_MCA:	/* Clear all multicast addresses */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		set_multicast_list(dev);
+		break;
+
+	case DEPCA_MCA_EN:	/* Enable pass all multicast addressing */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		set_multicast_list(dev);
+		break;
+
+	case DEPCA_GET_STATS:	/* Get the driver statistics */
+		ioc->len = sizeof(lp->pktStats);
+		buf = kmalloc(ioc->len, GFP_KERNEL);
+		if(!buf)
+			return -ENOMEM;
+		spin_lock_irqsave(&lp->lock, flags);
+		memcpy(buf, &lp->pktStats, ioc->len);
+		spin_unlock_irqrestore(&lp->lock, flags);
+		if (copy_to_user(ioc->data, &lp->pktStats, ioc->len))
+			status = -EFAULT;
+		kfree(buf);
+		break;
+
+	case DEPCA_CLR_STATS:	/* Zero out the driver statistics */
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		spin_lock_irqsave(&lp->lock, flags);
+		memset(&lp->pktStats, 0, sizeof(lp->pktStats));
+		spin_unlock_irqrestore(&lp->lock, flags);
+		break;
+
+	case DEPCA_GET_REG:	/* Get the DEPCA Registers */
+		i = 0;
+		tmp.sval[i++] = inw(DEPCA_NICSR);
+		outw(CSR0, DEPCA_ADDR);	/* status register */
+		tmp.sval[i++] = inw(DEPCA_DATA);
+		memcpy(&tmp.sval[i], &lp->init_block, sizeof(struct depca_init));
+		ioc->len = i + sizeof(struct depca_init);
+		if (copy_to_user(ioc->data, tmp.addr, ioc->len))
+			return -EFAULT;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return status;
 }
 
 #ifdef MODULE
 static struct net_device thisDepca;
-static int irq=7;	/* EDIT THESE LINE FOR YOUR CONFIGURATION */
-static int io=0x200;    /* Or use the irq= io= options to insmod */
+static int irq = 7;		/* EDIT THESE LINE FOR YOUR CONFIGURATION */
+static int io = 0x200;		/* Or use the irq= io= options to insmod */
 MODULE_PARM(irq, "i");
 MODULE_PARM(io, "i");
 MODULE_PARM_DESC(irq, "DEPCA IRQ number");
 MODULE_PARM_DESC(io, "DEPCA I/O base address");
 
-/* See depca_probe() for autoprobe messages when a module */	
-int
-init_module(void)
+/* See depca_probe() for autoprobe messages when a module */
+int init_module(void)
 {
-  thisDepca.irq=irq;
-  thisDepca.base_addr=io;
-  thisDepca.init = depca_probe;
+	thisDepca.irq = irq;
+	thisDepca.base_addr = io;
+	thisDepca.init = depca_probe;
 
-  if (register_netdev(&thisDepca) != 0)
-    return -EIO;
+	if (register_netdev(&thisDepca) != 0)
+		return -EIO;
 
-  return 0;
+	return 0;
 }
 
-void
-cleanup_module(void)
+void cleanup_module(void)
 {
-  struct depca_private *lp = thisDepca.priv;
+	struct depca_private *lp = thisDepca.priv;
 
-  unregister_netdev(&thisDepca);
-  if (lp) {
-    iounmap(lp->sh_mem);
-#ifdef CONFIG_MCA      
-    if(lp->mca_slot != -1)
-      mca_mark_as_unused(lp->mca_slot);
-#endif                 
-    kfree(lp);
-    thisDepca.priv = NULL;
-  }
-  thisDepca.irq=0;
+	unregister_netdev(&thisDepca);
+	if (lp) {
+		iounmap(lp->sh_mem);
+#ifdef CONFIG_MCA
+		if (lp->mca_slot != -1)
+			mca_mark_as_unused(lp->mca_slot);
+#endif
+		kfree(lp);
+		thisDepca.priv = NULL;
+	}
+	thisDepca.irq = 0;
 
-  release_region(thisDepca.base_addr, DEPCA_TOTAL_SIZE);
+	release_region(thisDepca.base_addr, DEPCA_TOTAL_SIZE);
 }
-#endif /* MODULE */
+#endif				/* MODULE */
 MODULE_LICENSE("GPL");
-
 
+
 /*
  * Local variables:
  *  compile-command: "gcc -D__KERNEL__ -I/linux/include -Wall -Wstrict-prototypes -fomit-frame-pointer -fno-strength-reduce -malign-loops=2 -malign-jumps=2 -malign-functions=2 -O2 -m486 -c depca.c"
