Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbTAENhf>; Sun, 5 Jan 2003 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTAENhf>; Sun, 5 Jan 2003 08:37:35 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:11677 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S264743AbTAENhc>;
	Sun, 5 Jan 2003 08:37:32 -0500
Date: Sun, 5 Jan 2003 14:45:59 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
Subject: [PATCH] drivers/net/rcpci45 DMA mapping API conversion
Message-ID: <20030105144559.A2835@se1.cogenit.fr>
Reply-To: romieu@fr.zoreil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  I've been asked to convert the driver while compiling, so:
- the exit paths look ok;
- it compiles;
- in rcpci45_remove_one(), I have been unable to find under which condition
  it would be possible to have pDpa->msgbuf set to NULL. Test removed.

Comment, test and forward to Linus if correct.

diff -pruN linux-2.5.54.orig/drivers/net/rclanmtl.h linux-2.5.54/drivers/net/rclanmtl.h
--- linux-2.5.54.orig/drivers/net/rclanmtl.h	Mon Sep 16 04:18:29 2002
+++ linux-2.5.54/drivers/net/rclanmtl.h	Sun Jan  5 13:38:03 2003
@@ -182,6 +182,7 @@ typedef struct {
 	U32 pci_addr;		/* the pci address of the adapter */
 	U32 pci_addr_len;
 
+	struct pci_dev *pci_dev;
 	struct timer_list timer;	/*  timer */
 	struct net_device_stats stats;	/* the statistics structure */
 	unsigned long numOutRcvBuffers;	/* number of outstanding receive buffers */
@@ -189,7 +190,7 @@ typedef struct {
 	unsigned char reboot;
 	unsigned char nexus;
 	PU8 msgbuf;		/* Pointer to Lan Api Private Area */
-	PU8 PLanApiPA;		/* Pointer to Lan Api Private Area (aligned) */
+	dma_addr_t msgbuf_dma;
 	PPAB pPab;		/* Pointer to the PCI Adapter Block */
 } *PDPA;
 
diff -pruN linux-2.5.54.orig/drivers/net/rclanmtl.c linux-2.5.54/drivers/net/rclanmtl.c
--- linux-2.5.54.orig/drivers/net/rclanmtl.c	Mon Sep 16 04:18:40 2002
+++ linux-2.5.54/drivers/net/rclanmtl.c	Sat Jan  4 02:15:58 2003
@@ -301,8 +301,8 @@ RCInitI2OMsgLayer (struct net_device *de
 	PPAB pPab;
 	U32 pciBaseAddr = dev->base_addr;
 	PDPA pDpa = dev->priv;
-	PU8 p_msgbuf = pDpa->PLanApiPA;
-	PU8 p_phymsgbuf = (PU8) virt_to_bus ((void *) p_msgbuf);
+	PU8 p_msgbuf = pDpa->msgbuf;
+	PU8 p_phymsgbuf = (PU8) pDpa->msgbuf_dma;
 
 	dprintk
 	    ("InitI2O: Adapter:0x%04ux ATU:0x%08ulx msgbuf:0x%08ulx phymsgbuf:0x%08ulx\n"
diff -pruN linux-2.5.54.orig/drivers/net/rcpci45.c linux-2.5.54/drivers/net/rcpci45.c
--- linux-2.5.54.orig/drivers/net/rcpci45.c	Thu Dec 19 23:18:52 2002
+++ linux-2.5.54/drivers/net/rcpci45.c	Sun Jan  5 14:19:15 2003
@@ -29,6 +29,8 @@
 **  along with this program; if not, write to the Free Software
 **  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 **
+**  Francois Romieu, Jan 2003: Converted to pci DMA mapping API.
+**
 **  Pete Popov, Oct 2001: Fixed a few bugs to make the driver functional
 **  again. Note that this card is not supported or manufactured by 
 **  RedCreek anymore.
@@ -47,8 +49,6 @@
 **
 ***************************************************************************/
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -140,8 +140,8 @@ rcpci45_remove_one (struct pci_dev *pdev
 	free_irq (dev->irq, dev);
 	iounmap ((void *) dev->base_addr);
 	pci_release_regions (pdev);
-	if (pDpa->msgbuf)
-		kfree (pDpa->msgbuf);
+	pci_free_consistent (pdev, MSG_BUF_SIZE, pDpa->msgbuf,
+			     pDpa->msgbuf_dma);
 	if (pDpa->pPab)
 		kfree (pDpa->pPab);
 	kfree (dev);
@@ -193,6 +193,7 @@ rcpci45_init_one (struct pci_dev *pdev, 
 
 	pDpa = dev->priv;
 	pDpa->id = card_idx;
+	pDpa->pci_dev = pdev;
 	pDpa->pci_addr = pci_start;
 
 	if (!pci_start || !(pci_resource_flags (pdev, 0) & IORESOURCE_MEM)) {
@@ -204,10 +205,13 @@ rcpci45_init_one (struct pci_dev *pdev, 
 
 	/*
 	 * pDpa->msgbuf is where the card will dma the I2O 
-	 * messages. Thus, we need contiguous physical pages of
-	 * memory.
+	 * messages. Thus, we need contiguous physical pages of memory.
+	 * 2003/01/04: pci_alloc_consistent() provides well over the needed
+	 * alignment on a 256 bytes boundary for the LAN API private area.
+	 * Thus it isn't needed anymore to align it by hand.
 	 */
-	pDpa->msgbuf = kmalloc (MSG_BUF_SIZE, GFP_DMA|GFP_ATOMIC|GFP_KERNEL);
+	pDpa->msgbuf = pci_alloc_consistent (pdev, MSG_BUF_SIZE,
+					     &pDpa->msgbuf_dma);
 	if (!pDpa->msgbuf) {
 		printk (KERN_ERR "(rcpci45 driver:) \
 			Could not allocate %d byte memory for the \
@@ -215,13 +219,6 @@ rcpci45_init_one (struct pci_dev *pdev, 
 		goto err_out_free_dev;
 	}
 
-	/*
-	 * Save the starting address of the LAN API private area.  We'll
-	 * pass that to RCInitI2OMsgLayer().
-	 *
-	 */
-	pDpa->PLanApiPA = (void *) (((long) pDpa->msgbuf + 0xff) & ~0xff);
-
 	/* The adapter is accessible through memory-access read/write, not
 	 * I/O read/write.  Thus, we need to map it to some virtual address
 	 * area in order to access the registers as normal memory.
@@ -253,7 +250,8 @@ rcpci45_init_one (struct pci_dev *pdev, 
 err_out_free_region:
 	pci_release_regions (pdev);
 err_out_free_msgbuf:
-	kfree (pDpa->msgbuf);
+	pci_free_consistent (pdev, MSG_BUF_SIZE, pDpa->msgbuf,
+			     pDpa->msgbuf_dma);
 err_out_free_dev:
 	unregister_netdev (dev);
 	kfree (dev);
@@ -406,7 +404,8 @@ RC_xmit_packet (struct sk_buff *skb, str
 	ptcb->b.context = (U32) skb;
 	ptcb->b.scount = 1;
 	ptcb->b.size = skb->len;
-	ptcb->b.addr = virt_to_bus ((void *) skb->data);
+	ptcb->b.addr = pci_map_single(pDpa->pci_dev, skb->data, skb->len,
+				      PCI_DMA_TODEVICE);
 
 	if ((status = RCI2OSendPacket (dev, (U32) NULL, (PRCTCB) ptcb))
 	    != RC_RTN_NO_ERROR) {
@@ -455,6 +454,8 @@ RCxmit_callback (U32 Status,
 	while (PcktCount--) {
 		skb = (struct sk_buff *) (BufferContext[0]);
 		BufferContext++;
+		pci_unmap_single(pDpa->pci_dev, BufferContext[1], skb->len,
+				 PCI_DMA_TODEVICE);
 		dev_kfree_skb_irq (skb);
 	}
 	netif_wake_queue (dev);
@@ -988,8 +989,9 @@ RC_allocate_and_post_buffers (struct net
 	PU32 p;
 	psingleB pB;
 	struct sk_buff *skb;
+	PDPA pDpa = dev->priv;
 	RC_RETURN status;
-	U32 res;
+	U32 res = 0;
 
 	if (!numBuffers)
 		return 0;
@@ -1005,7 +1007,7 @@ RC_allocate_and_post_buffers (struct net
 	if (!p) {
 		printk (KERN_WARNING "%s unable to allocate TCB\n",
 				dev->name);
-		return 0;
+		goto out;
 	}
 
 	p[0] = 0;		/* Buffer Count */
@@ -1017,18 +1019,14 @@ RC_allocate_and_post_buffers (struct net
 			printk (KERN_WARNING 
 					"%s: unable to allocate enough skbs!\n",
 					dev->name);
-			if (*p != 0) {	/* did we allocate any buffers */
-				break;
-			} else {
-				kfree (p);	/* Free the TCB */
-				return 0;
-			}
+			goto err_out_unmap;
 		}
 		skb_reserve (skb, 2);	/* Align IP on 16 byte boundaries */
 		pB->context = (U32) skb;
 		pB->scount = 1;	/* segment count */
 		pB->size = MAX_ETHER_SIZE;
-		pB->addr = virt_to_bus ((void *) skb->data);
+		pB->addr = pci_map_single(pDpa->pci_dev, skb->data, 
+					  MAX_ETHER_SIZE, PCI_DMA_FROMDEVICE);
 		p[0]++;
 		pB++;
 	}
@@ -1036,16 +1034,21 @@ RC_allocate_and_post_buffers (struct net
 	if ((status = RCPostRecvBuffers (dev, (PRCTCB) p)) != RC_RTN_NO_ERROR) {
 		printk (KERN_WARNING "%s: Post buffer failed, error 0x%x\n",
 				dev->name, status);
-		/* point to the first buffer */
-		pB = (psingleB) ((U32) p + sizeof (U32));
-		while (p[0]) {
-			skb = (struct sk_buff *) pB->context;
-			dev_kfree_skb (skb);
-			p[0]--;
-			pB++;
-		}
+		goto err_out_unmap;
 	}
+out_free:
 	res = p[0];
 	kfree (p);
+out:
 	return (res);		/* return the number of posted buffers */
+
+err_out_unmap:
+	for (; p[0] > 0; p[0]--) {
+		--pB;
+		skb = (struct sk_buff *) pB->context;
+		pci_unmap_single(pDpa->pci_dev, pB->addr, MAX_ETHER_SIZE,
+				 PCI_DMA_FROMDEVICE);
+		dev_kfree_skb (skb);
+	}
+	goto out_free;
 }
