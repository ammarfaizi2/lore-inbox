Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSFLMle>; Wed, 12 Jun 2002 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSFLMld>; Wed, 12 Jun 2002 08:41:33 -0400
Received: from [159.226.39.4] ([159.226.39.4]:38329 "HELO mail.ict.ac.cn")
	by vger.kernel.org with SMTP id <S317694AbSFLMlS>;
	Wed, 12 Jun 2002 08:41:18 -0400
Message-ID: <3D0740ED.2060907@ict.ac.cn>
Date: Wed, 12 Jun 2002 20:39:09 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, saw@saw.sw.com.sg, linux-kernel@vger.kernel.org
Subject: NAPI for eepro100
Content-Type: multipart/mixed;
 boundary="------------070502030508090306010005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070502030508090306010005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,all
   Recently i've converted eepro100 driver to use napi,in order to improve
network performance of my poor 150M mips machine. It does eliminate
the interrupt live lock seen before,maintaining a peak throughput under
heavy load.
  In case anybody are interested,i post the patches to the list. They are
3 incremental patchs:
   eepro100-napi.patch is against 2.5.20 eepro100.c and provide basic
napi support
   eepro100-proc.patch is proc file system support adapted from intel's
e100 driver. I am using it for debugging.
   eepro100-mips.patch is mips specific patch to make it work(well) for 
my mips
platform.
(i suppose people use: patch eepro100.c < x.patch to apply patch)

   Tests are mainly done on my mips machine for 2.4 kernel,though i think
 it should work for at least x86 on which minimal test is performed. Be 
careful.

   A little pitty is that to achieve good performance under heavy load, the
/proc/sys/net/core/netdev_max_backlog value may need to be adjusted.
   
  Feedbacks are always welcome:). But i am not on linux-kernel list,so 
people
there please CC me.

--------------070502030508090306010005
Content-Type: text/plain;
 name="eepro100-mips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100-mips.patch"

--- eepro100-napi-proc.c	Wed Jun 12 17:33:51 2002
+++ eepro100-mips.c	Wed Jun 12 19:22:29 2002
@@ -45,7 +45,7 @@
 
 /* Set the copy breakpoint for the copy-only-tiny-buffer Rx method.
    Lower values use more memory, but are faster. */
-#if defined(__alpha__) || defined(__sparc__) || defined(__mips__) || \
+#if defined(__alpha__) || defined(__sparc__) || /*defined(__mips__) ||*/ \
     defined(__arm__)
 static int rx_copybreak = 1518;
 #else
@@ -66,8 +66,8 @@
 
 /* A few values that may be tweaked. */
 /* The ring sizes should be a power of two for efficiency. */
-#define TX_RING_SIZE	64
-#define RX_RING_SIZE	64
+#define TX_RING_SIZE	32
+#define RX_RING_SIZE	32
 /* How much slots multicast filter setup may take.
    Do not descrease without changing set_rx_mode() implementaion. */
 #define TX_MULTICAST_SIZE   2
@@ -1298,7 +1298,14 @@
 		if (skb == NULL)
 			break;			/* OK.  Just initially short of Rx bufs. */
 		skb->dev = dev;			/* Mark as being used by this device. */
+#ifndef __mips__
 		rxf = (struct RxFD *)skb->tail;
+#else
+		/* use uncached address,use pci_dma_sync_xx seems 
+		 * problematic in my mips platform
+		 */
+		rxf = (struct RxFD *)(KSEG1ADDR(skb->tail));
+#endif
 		sp->rx_ringp[i] = rxf;
 		sp->rx_ring_dma[i] =
 			pci_map_single(sp->pdev, rxf,
@@ -1306,8 +1313,10 @@
 		skb_reserve(skb, sizeof(struct RxFD));
 		if (last_rxf) {
 			last_rxf->link = cpu_to_le32(sp->rx_ring_dma[i]);
+#ifndef __mips__
 			pci_dma_sync_single(sp->pdev, last_rxf_dma,
 					sizeof(struct RxFD), PCI_DMA_TODEVICE);
+#endif
 		}
 		last_rxf = rxf;
 		last_rxf_dma = sp->rx_ring_dma[i];
@@ -1316,14 +1325,18 @@
 		/* This field unused by i82557. */
 		rxf->rx_buf_addr = 0xffffffff;
 		rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
+#ifndef __mips__
 		pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[i],
 				sizeof(struct RxFD), PCI_DMA_TODEVICE);
+#endif
 	}
 	sp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 	/* Mark the last entry as end-of-list. */
 	last_rxf->status = cpu_to_le32(0xC0000002);	/* '2' is flag value only. */
+#ifndef __mips__
 	pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[RX_RING_SIZE-1],
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+#endif
 	sp->last_rxf = last_rxf;
 	sp->last_rxf_dma = last_rxf_dma;
 }
@@ -1733,15 +1746,21 @@
 #endif
 		return NULL;
 	}
+#ifndef __mips__
 	rxf = sp->rx_ringp[entry] = (struct RxFD *)skb->tail;
+#else
+	rxf = sp->rx_ringp[entry] = (struct RxFD *)(KSEG1ADDR(skb->tail));
+#endif
 	sp->rx_ring_dma[entry] =
 		pci_map_single(sp->pdev, rxf,
 					   PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
 	skb->dev = dev;
 	skb_reserve(skb, sizeof(struct RxFD));
 	rxf->rx_buf_addr = 0xffffffff;
+#ifndef __mips__
 	pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+#endif
 	return rxf;
 }
 
@@ -1754,8 +1773,10 @@
 	rxf->count = cpu_to_le32(PKT_BUF_SZ << 16);
 	sp->last_rxf->link = cpu_to_le32(rxf_dma);
 	sp->last_rxf->status &= cpu_to_le32(~0xC0000000);
+#ifndef __mips__
 	pci_dma_sync_single(sp->pdev, sp->last_rxf_dma,
 			sizeof(struct RxFD), PCI_DMA_TODEVICE);
+#endif
 	sp->last_rxf = rxf;
 	sp->last_rxf_dma = rxf_dma;
 }
@@ -2274,8 +2295,10 @@
 		int status;
 		int pkt_len;
 
+#ifndef __mips__
 		pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
 			sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
+#endif
 		status = le32_to_cpu(sp->rx_ringp[entry]->status);
 		pkt_len = le32_to_cpu(sp->rx_ringp[entry]->count) & 0x3fff;
 

--------------070502030508090306010005
Content-Type: text/plain;
 name="eepro100-napi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100-napi.patch"

--- eepro100.c.ori	Wed Jun 12 17:25:28 2002
+++ eepro100-napi.c	Wed Jun 12 17:11:38 2002
@@ -25,6 +25,8 @@
 		Disabled FC and ER, to avoid lockups when when we get FCP interrupts.
 	2000 Jul 17 Goutham Rao <goutham.rao@intel.com>
 		PCI DMA API fixes, adding pci_dma_sync_single calls where neccesary
+	2002 Jun 12 Zhang Fuxin <fxzhang@ict.ac.cn>
+		add NAPI support
 */
 
 static const char *version =
@@ -115,6 +117,8 @@
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 
+#define CONFIG_EEPRO100_NAPI
+
 MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
 MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
 MODULE_LICENSE("GPL");
@@ -494,8 +498,34 @@
 #ifdef CONFIG_PM
 	u32 pm_state[16];
 #endif
+
+	/* added by zfx for NAPI*/
+#ifdef CONFIG_EEPRO100_NAPI
+
+	/* used to pass rx_work_limit into speedo_rx,i don't want to 
+	 * change its prototype
+	 */
+	int curr_work_limit;
+	unsigned long poll_switch;
+	unsigned long failed_poll_switch;
+	unsigned long done_poll;
+	unsigned long notdone_poll;
+	unsigned long empty_poll;
+	unsigned long soft_reset_count;
+	unsigned long rx_resume_count;
+	unsigned long alloc_fail;
+	unsigned long long poll_cycles;
+
+#ifdef CONFIG_NET_FASTROUTE
+	unsigned long fastroute_hit;
+	unsigned long fastroute_success;
+	unsigned long fastroute_defer;
+#endif
+
+#endif
 };
 
+
 /* The parameters for a CmdConfigure operation.
    There are so many options that it would be difficult to document each bit.
    We mostly use the default or recommended settings. */
@@ -546,6 +576,14 @@
 static void set_rx_mode(struct net_device *dev);
 static void speedo_show_state(struct net_device *dev);
 
+#ifdef CONFIG_EEPRO100_NAPI
+
+static int speedo_poll (struct net_device *dev, int *budget);
+static void enable_rx_and_rxnobuf_ints(struct net_device *dev);
+static void disable_rx_and_rxnobuf_ints(struct net_device *dev);
+
+#endif
+
 
 
 #ifdef honor_default_port
@@ -842,6 +880,10 @@
 	dev->set_multicast_list = &set_rx_mode;
 	dev->do_ioctl = &speedo_ioctl;
 
+#ifdef CONFIG_EEPRO100_NAPI
+	dev->poll = speedo_poll;
+	dev->quota = dev->weight = RX_RING_SIZE;
+#endif
 	return 0;
 }
 
@@ -1517,6 +1559,9 @@
 	struct speedo_private *sp;
 	long ioaddr, boguscnt = max_interrupt_work;
 	unsigned short status;
+#ifdef CONFIG_EEPRO100_NAPI
+	int first = 1;
+#endif
 
 #ifndef final_version
 	if (dev == NULL) {
@@ -1543,16 +1588,21 @@
 		/* Acknowledge all of the current interrupt sources ASAP. */
 		/* Will change from 0xfc00 to 0xff00 when we start handling
 		   FCP and ER interrupts --Dragan */
+#ifndef CONFIG_EEPRO100_NAPI
 		outw(status & 0xfc00, ioaddr + SCBStatus);
+#else
+		/* Rx & RxNoBuf is acked in speedo_poll */
+		outw(status & 0xac00, ioaddr + SCBStatus);
+#endif
 
 		if (speedo_debug > 4)
 			printk(KERN_DEBUG "%s: interrupt  status=%#4.4x.\n",
 				   dev->name, status);
 
+#ifndef CONFIG_EEPRO100_NAPI
 		if ((status & 0xfc00) == 0)
 			break;
 
-
 		if ((status & 0x5000) ||	/* Packet received, or Rx error. */
 			(sp->rx_ring_state&(RrNoMem|RrPostponed)) == RrPostponed)
 									/* Need to gather the postponed packet. */
@@ -1560,8 +1610,33 @@
 
 		/* Always check if all rx buffers are allocated.  --SAW */
 		speedo_refill_rx_buffers(dev, 0);
+#else
+		/* Packet received, or Rx error. */
+		if (first && ((status & 0x5000) || (sp->rx_ring_state&(RrNoMem|RrPostponed)) == RrPostponed || (status & 0x3c) != 0x10 ))
+			/* Need to gather the postponed packet. */
+		{
+			if (speedo_debug > 4) 
+				printk("switching to poll,status=%x\n",status);
+			first = 0;
+			if (netif_rx_schedule_prep(dev)) {
+				sp->poll_switch++;
+				/* disable interrupts caused by arriving packets */
+				disable_rx_and_rxnobuf_ints(dev);
+				/* tell system we have work to be done. */
+				__netif_rx_schedule(dev);
+			}else {
+				sp->failed_poll_switch++;
+			}
+
+		}
+
+		if ((status & 0xac00) == 0)
+			break;
+#endif
 		
 		spin_lock(&sp->lock);
+
+#ifndef CONFIG_EEPRO100_NAPI
 		/*
 		 * The chip may have suspended reception for various reasons.
 		 * Check for that, and re-prime it should this be the case.
@@ -1581,7 +1656,7 @@
 			/* these are all reserved values */
 			break;
 		}
-		
+#endif
 		
 		/* User interrupt, Command/Tx unit interrupt or CU not active. */
 		if (status & 0xA400) {
@@ -1602,7 +1677,12 @@
 			/* Clear all interrupt sources. */
 			/* Will change from 0xfc00 to 0xff00 when we start handling
 			   FCP and ER interrupts --Dragan */
+#ifndef CONFIG_EEPRO100_NAPI
 			outw(0xfc00, ioaddr + SCBStatus);
+#else
+			outw(0xac00, ioaddr + SCBStatus);
+#endif
+
 			break;
 		}
 	} while (1);
@@ -1611,7 +1691,9 @@
 		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
 			   dev->name, inw(ioaddr + SCBStatus));
 
+#ifndef final_version
 	clear_bit(0, (void*)&sp->in_interrupt);
+#endif
 	return;
 }
 
@@ -1625,6 +1707,9 @@
 	sp->rx_skbuff[entry] = skb;
 	if (skb == NULL) {
 		sp->rx_ringp[entry] = NULL;
+#ifdef CONFIG_EEPRO100_NAPI
+		sp->alloc_fail++;
+#endif
 		return NULL;
 	}
 	rxf = sp->rx_ringp[entry] = (struct RxFD *)skb->tail;
@@ -1705,12 +1790,112 @@
 			speedo_refill_rx_buf(dev, force) != -1);
 }
 
+#ifdef CONFIG_EEPRO100_NAPI
+static void enable_rx_and_rxnobuf_ints(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	outw(SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr + SCBCmd);
+	inw(ioaddr + SCBStatus); /* flushes last write, read-safe */
+};
+
+static void disable_rx_and_rxnobuf_ints(struct net_device *dev)
+{
+	long ioaddr = dev->base_addr;
+	outw(SCBMaskRxDone | SCBMaskRxSuspend | SCBMaskEarlyRx | SCBMaskFlowCtl, ioaddr + SCBCmd);
+	inw(ioaddr + SCBStatus); /* flushes last write, read-safe */
+};
+
+static int speedo_poll (struct net_device *dev, int *budget)
+{
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
+	long ioaddr, received = 0;
+	unsigned short intr_status;
+
+	ioaddr = dev->base_addr;
+	intr_status = inw(ioaddr + SCBStatus);
+
+	if (speedo_debug > 4)
+		printk(KERN_DEBUG " In speedo_poll().\n");
+
+	sp->curr_work_limit = *budget;
+	if (sp->curr_work_limit > dev->quota) 
+		sp->curr_work_limit = dev->quota;
+
+	do {  
+		/* ack Rx & RxNobuf intrs*/
+		outw(intr_status & 0x5000, ioaddr + SCBStatus);
+
+		received += speedo_rx(dev);
+
+		if (sp->curr_work_limit < 0) /* out of quota */
+			goto not_done;
+
+		/* no packets on ring; but new ones can arrive since we last checked  */
+		intr_status = inw(ioaddr + SCBStatus);
+
+		if ((intr_status & 0x5000) == 0) {
+			/* If something arrives in this narrow window,an interrupt 
+			 * will be generated 
+			 */
+			goto done;
+		}
+		/* done! at least thats what it looks like ;->
+		   if new packets came in after our last check on status bits
+		   they'll be caught by the while check and we go back and clear them
+		   since we havent exceeded our quota 
+		 */
+	} while (intr_status & 0x5000);
+
+done:
+	if (!received) {
+		if (speedo_debug > 4) printk("received==0\n");
+		received = 1;
+		sp->empty_poll++;
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	/* we are happy/done, no more packets on ring; put us back
+	 * to where we can start processing interrupts again 
+	 */
+	netif_rx_complete(dev);
+	enable_rx_and_rxnobuf_ints(dev);
+
+	sp->done_poll++;
+
+	if (speedo_debug > 3)
+		printk("done,received=%lu\n",received);
+
+        return 0;   /* done */
+
+not_done:
+	if (!received) {
+		if (speedo_debug > 4) printk("received==0\n");
+		received = 1;
+		sp->empty_poll++;
+	}
+	dev->quota -= received;
+	*budget -= received;
+
+	sp->notdone_poll++;
+
+	if (speedo_debug > 3)
+		printk("not done,received=%lu\n",received);
+
+	return 1;  /* not_done */
+}
+
+#endif /* NAPI */
+
 static int
 speedo_rx(struct net_device *dev)
 {
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	int entry = sp->cur_rx % RX_RING_SIZE;
+#ifndef CONFIG_EEPRO100_NAPI
 	int rx_work_limit = sp->dirty_rx + RX_RING_SIZE - sp->cur_rx;
+#endif
+	int received = 0;
 	int alloc_ok = 1;
 
 	if (speedo_debug > 4)
@@ -1725,11 +1910,42 @@
 		status = le32_to_cpu(sp->rx_ringp[entry]->status);
 		pkt_len = le32_to_cpu(sp->rx_ringp[entry]->count) & 0x3fff;
 
+#ifndef CONFIG_EEPRO100_NAPI
 		if (!(status & RxComplete))
 			break;
 
 		if (--rx_work_limit < 0)
 			break;
+#else
+		if (!(status & RxComplete)) {
+			int intr_status;
+			unsigned long ioaddr = dev->base_addr;
+
+			intr_status = inw(ioaddr + SCBStatus);
+			/* We check receiver state here because if 
+			 * we have to do soft reset,sp->cur_rx should
+			 * point to an empty entry or something 
+			 * unexpected will happen
+			 */
+			if (intr_status | 0x1000) { /* suspended */
+				outw(0x5000,ioaddr + SCBStatus);
+				/* No resources */
+				if ((intr_status & 0x3c) == 0x28) {
+					outw(RxResumeNoResources,ioaddr+SCBCmd);
+					sp->rx_resume_count++;
+				}else if ((intr_status & 0x3c) == 0x8) {
+					if (speedo_debug > 4) 
+						printk("No resource,reset\n");
+					speedo_rx_soft_reset(dev);
+					sp->soft_reset_count++;
+				}
+			}
+			break;
+		}
+
+		if (--sp->curr_work_limit < 0) 
+			break;
+#endif
 
 		/* Check for a rare out-of-memory case: the current buffer is
 		   the last buffer allocated in the RX ring.  --SAW */
@@ -1793,7 +2009,12 @@
 						PKT_BUF_SZ + sizeof(struct RxFD), PCI_DMA_FROMDEVICE);
 			}
 			skb->protocol = eth_type_trans(skb, dev);
+#ifndef CONFIG_EEPRO100_NAPI
 			netif_rx(skb);
+#else
+			netif_receive_skb(skb);
+			received ++;
+#endif
 			dev->last_rx = jiffies;
 			sp->stats.rx_packets++;
 			sp->stats.rx_bytes += pkt_len;
@@ -1811,7 +2032,7 @@
 
 	sp->last_rx_time = jiffies;
 
-	return 0;
+	return received;
 }
 
 static int

--------------070502030508090306010005
Content-Type: text/plain;
 name="eepro100-proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100-proc.patch"

--- eepro100-napi.c	Wed Jun 12 17:11:38 2002
+++ eepro100-napi-proc.c	Wed Jun 12 17:33:51 2002
@@ -119,6 +119,10 @@
 
 #define CONFIG_EEPRO100_NAPI
 
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif
+
 MODULE_AUTHOR("Maintainer: Andrey V. Savochkin <saw@saw.sw.com.sg>");
 MODULE_DESCRIPTION("Intel i82557/i82558/i82559 PCI EtherExpressPro driver");
 MODULE_LICENSE("GPL");
@@ -516,6 +520,10 @@
 	unsigned long alloc_fail;
 	unsigned long long poll_cycles;
 
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *proc_parent;
+#endif
+
 #ifdef CONFIG_NET_FASTROUTE
 	unsigned long fastroute_hit;
 	unsigned long fastroute_success;
@@ -582,6 +590,11 @@
 static void enable_rx_and_rxnobuf_ints(struct net_device *dev);
 static void disable_rx_and_rxnobuf_ints(struct net_device *dev);
 
+#ifdef CONFIG_PROC_FS
+int __devinit speedo_create_proc_subdir(struct net_device *sp);
+void speedo_remove_proc_subdir(struct net_device *sp);
+#endif
+
 #endif
 
 
@@ -883,6 +896,14 @@
 #ifdef CONFIG_EEPRO100_NAPI
 	dev->poll = speedo_poll;
 	dev->quota = dev->weight = RX_RING_SIZE;
+
+#ifdef CONFIG_PROC_FS
+	if (speedo_create_proc_subdir(dev) < 0) {
+		printk(KERN_ERR "Failed to create proc directory for %s\n",
+				dev->name);
+	}              
+#endif
+
 #endif
 	return 0;
 }
@@ -1885,6 +1906,354 @@
 	return 1;  /* not_done */
 }
 
+#ifdef CONFIG_PROC_FS
+/* adapted from intel's e100 code */
+static struct proc_dir_entry *adapters_proc_dir = 0;
+
+static void speedo_proc_cleanup(void);
+static unsigned char speedo_init_proc_dir(void);
+
+#define ADAPTERS_PROC_DIR "eepro100"
+#define WRITE_BUF_MAX_LEN 20	
+#define READ_BUF_MAX_LEN  256
+#define SPEEDO_PE_LEN       25
+
+#define sp_off(off) (unsigned long)(offsetof(struct speedo_private, off))
+
+typedef struct _speedo_proc_entry {
+	char *name;
+	read_proc_t *read_proc;
+	write_proc_t *write_proc;
+	unsigned long offset;	/* offset into sp. ~0 means no value, pass NULL. */
+} speedo_proc_entry;
+
+static int
+generic_read(char *page, char **start, off_t off, int count, int *eof, int len)
+{
+	if (len <= off + count)
+		*eof = 1;
+
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int
+read_ulong(char *page, char **start, off_t off,
+	   int count, int *eof, unsigned long l)
+{
+	int len;
+
+	len = sprintf(page, "%lu\n", l);
+
+	return generic_read(page, start, off, count, eof, len);
+}
+
+static int
+read_gen_ulong(char *page, char **start, off_t off,
+	       int count, int *eof, void *data)
+{
+	unsigned long val = 0;
+
+	if (data)
+		val = *((unsigned long *) data);
+
+	return read_ulong(page, start, off, count, eof, val);
+}
+
+static int
+read_ulonglong(char *page, char **start, off_t off,
+	   int count, int *eof, unsigned long long ll)
+{
+	int len;
+
+	len = sprintf(page, "%llu\n", ll);
+
+	return generic_read(page, start, off, count, eof, len);
+}
+
+static int
+read_gen_ulonglong(char *page, char **start, off_t off,
+	       int count, int *eof, void *data)
+{
+	unsigned long val = 0;
+
+	if (data)
+		val = *((unsigned long long *) data);
+
+	return read_ulonglong(page, start, off, count, eof, val);
+}
+
+static int
+set_debug(struct file *file, const char *buffer,
+		    unsigned long count, void *data)
+
+{
+	if (speedo_debug == 1) 
+		speedo_debug = 6;
+	else
+		speedo_debug = 1;
+	return count;
+}
+
+static int
+_speedo_show_state(struct file *file, const char *buffer,
+		    unsigned long count, void *data)
+{
+	
+	struct net_device *dev = (struct net_device *)data;
+
+	speedo_show_state(dev);
+
+	return count;
+}
+
+static speedo_proc_entry speedo_proc_list[] = {
+	{"set_debug", 0, set_debug, ~0},
+	{"show_state", 0, _speedo_show_state, ~0},
+	{"poll_switch",read_gen_ulong,0,sp_off(poll_switch)},
+	{"failed_poll_switch",read_gen_ulong,0,sp_off(failed_poll_switch)},
+	{"done_poll",read_gen_ulong,0,sp_off(done_poll)},
+	{"notdone_poll",read_gen_ulong,0,sp_off(notdone_poll)},
+	{"empty_poll",read_gen_ulong,0,sp_off(empty_poll)},
+	{"soft_reset_count",read_gen_ulong,0,sp_off(soft_reset_count)},
+	{"rx_resume_count",read_gen_ulong,0,sp_off(rx_resume_count)},
+	{"alloc_fail",read_gen_ulong,0,sp_off(alloc_fail)},
+	{"poll_cycles",read_gen_ulonglong,0,sp_off(poll_cycles)},
+	{"fastroute_hit",read_gen_ulonglong,0,sp_off(fastroute_hit)},
+	{"fastroute_success",read_gen_ulonglong,0,sp_off(fastroute_success)},
+	{"fastroute_defer",read_gen_ulonglong,0,sp_off(fastroute_defer)},
+	{"", 0, 0, 0}
+};
+
+static int
+read_info(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	struct speedo_private *sp = data;
+	speedo_proc_entry *pe;
+	int tmp;
+	void *val;
+	int len = 0;
+
+	for (pe = speedo_proc_list; pe->name[0]; pe++) {
+		if (pe->name[0] == '\n') {
+			len += sprintf(page + len, "\n");
+			continue;
+		}
+
+		if (pe->read_proc) {
+			if ((len + READ_BUF_MAX_LEN + SPEEDO_PE_LEN + 1) >=
+			    PAGE_SIZE)
+				break;
+
+			if (pe->offset != ~0)
+				val = ((char *) sp) + pe->offset;
+			else
+				val = NULL;
+
+			len += sprintf(page + len, "%-"
+				       __MODULE_STRING(SPEEDO_PE_LEN)
+				       "s ", pe->name);
+			len += pe->read_proc(page + len, start, 0,
+					     READ_BUF_MAX_LEN + 1, &tmp, val);
+		}
+	}
+
+	return generic_read(page, start, off, count, eof, len);
+}
+
+static struct proc_dir_entry * __devinit
+create_proc_rw(char *name, void *data, struct proc_dir_entry *parent,
+	       read_proc_t * read_proc, write_proc_t * write_proc)
+{
+	struct proc_dir_entry *pdep;
+	mode_t mode = S_IFREG;
+
+	if (write_proc) {
+		mode |= S_IWUSR;
+		if (read_proc) {
+			mode |= S_IRUSR;
+		}
+
+	} else if (read_proc) {
+		mode |= S_IRUGO;
+	}
+
+	if (!(pdep = create_proc_entry(name, mode, parent)))
+		return NULL;
+
+	pdep->read_proc = read_proc;
+	pdep->write_proc = write_proc;
+	pdep->data = data;
+	return pdep;
+}
+
+void
+speedo_remove_proc_subdir(struct net_device *dev)
+{
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
+	speedo_proc_entry *pe;
+	char info[256];
+	int len;
+
+	/* If our root /proc dir was not created, there is nothing to remove */
+	if (adapters_proc_dir == NULL) {
+		return;
+	}
+
+	len = strlen(dev->name);
+	strncpy(info, dev->name, sizeof (info));
+	strncat(info + len, ".info", sizeof (info) - len);
+
+	if (sp->proc_parent) {
+		for (pe = speedo_proc_list; pe->name[0]; pe++) {
+			if (pe->name[0] == '\n')
+				continue;
+
+			remove_proc_entry(pe->name, sp->proc_parent);
+		}
+
+		remove_proc_entry(dev->name, adapters_proc_dir);
+		sp->proc_parent = NULL;
+	}
+
+	remove_proc_entry(info, adapters_proc_dir);
+
+	/* try to remove the main /proc dir, if it's empty */
+	speedo_proc_cleanup();
+}
+
+int __devinit
+speedo_create_proc_subdir(struct net_device *dev)
+{
+	struct speedo_private *sp = (struct speedo_private *)dev->priv;
+	struct proc_dir_entry *dev_dir;
+	speedo_proc_entry *pe;
+	char info[256];
+	int len;
+	void *data;
+
+	/* create the main /proc dir if needed */
+	if (!adapters_proc_dir) {
+		if (!speedo_init_proc_dir())
+			return -ENOMEM;
+	}
+
+	strncpy(info, dev->name, sizeof (info));
+	len = strlen(info);
+	strncat(info + len, ".info", sizeof (info) - len);
+
+	/* info */
+	if (!(create_proc_rw(info, sp, adapters_proc_dir, read_info, 0))) {
+		speedo_proc_cleanup();
+		return -ENOMEM;
+	}
+
+	dev_dir = create_proc_entry(dev->name, S_IFDIR,
+				    adapters_proc_dir);
+	sp->proc_parent = dev_dir;
+
+	if (!dev_dir) {
+		speedo_remove_proc_subdir(dev);
+		return -ENOMEM;
+	}
+
+	for (pe = speedo_proc_list; pe->name[0]; pe++) {
+		if (pe->name[0] == '\n')
+			continue;
+
+		if (pe->offset != ~0)
+			data = ((char *) sp) + pe->offset;
+		else
+			data = dev;
+
+		if (!(create_proc_rw(pe->name, data, dev_dir,
+				     pe->read_proc, pe->write_proc))) {
+			speedo_remove_proc_subdir(dev);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/****************************************************************************
+ * Name:          speedo_init_proc_dir
+ *
+ * Description:   This routine creates the top-level /proc directory for the
+ *                driver in /proc/net
+ *
+ * Arguments:     none
+ *
+ * Returns:       true on success, false on fail
+ *
+ ***************************************************************************/
+static unsigned char
+speedo_init_proc_dir(void)
+{
+	int len;
+
+	/* first check if adapters_proc_dir already exists */
+	len = strlen(ADAPTERS_PROC_DIR);
+	for (adapters_proc_dir = proc_net->subdir;
+	     adapters_proc_dir; adapters_proc_dir = adapters_proc_dir->next) {
+
+		if ((adapters_proc_dir->namelen == len) &&
+		    (!memcmp(adapters_proc_dir->name, ADAPTERS_PROC_DIR, len)))
+			break;
+	}
+
+	if (!adapters_proc_dir)
+		adapters_proc_dir =
+			create_proc_entry(ADAPTERS_PROC_DIR, S_IFDIR, proc_net);
+
+	if (!adapters_proc_dir)
+		return 0;
+
+	return 1;
+}
+
+/****************************************************************************
+ * Name:          speedo_proc_cleanup
+ *
+ * Description:   This routine clears the top-level /proc directory, if empty.
+ *
+ * Arguments:     none
+ *
+ * Returns:       none
+ *
+ ***************************************************************************/
+static void
+speedo_proc_cleanup(void)
+{
+	struct proc_dir_entry *de;
+
+	if (adapters_proc_dir == NULL) {
+		return;
+	}
+
+	/* check if subdir list is empty before removing adapters_proc_dir */
+	for (de = adapters_proc_dir->subdir; de; de = de->next) {
+		/* ignore . and .. */
+		if (*(de->name) != '.')
+			break;
+	}
+
+	if (de)
+		return;
+
+	remove_proc_entry(ADAPTERS_PROC_DIR, proc_net);
+	adapters_proc_dir = NULL;
+}
+
+#endif /* CONFIG_PROC_FS */
+
 #endif /* NAPI */
 
 static int
@@ -2474,6 +2843,9 @@
 	
 	unregister_netdev(dev);
 
+#if defined(CONFIG_EEPRO100_NAPI) && defined(CONFIG_PROC_FS)
+	speedo_remove_proc_subdir(dev);
+#endif
 	release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
 	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 

--------------070502030508090306010005--

