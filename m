Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266059AbRGSVMN>; Thu, 19 Jul 2001 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266062AbRGSVLx>; Thu, 19 Jul 2001 17:11:53 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:41808
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S266059AbRGSVLu>; Thu, 19 Jul 2001 17:11:50 -0400
Date: Thu, 19 Jul 2001 23:11:47 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Peter.Deschrijver@linux.cc.kuleuven.ac.be
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] error path deallocation in ibmtr.c (246ac5)
Message-ID: <20010719231147.D887@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.

The following patch makes drivers/net/tokenring/ibmtr.c
call iounmap before it returns on error paths, makes it 
not use check_region(), makes it check the return
of request_region and init_trdev and adds a few comment
strings on #endifs.

It applies against 246ac5 and my writing this patch was
caused by the Stanford team reporting the init_trdev
problem a while back.


--- linux-246-ac5-clean/drivers/net/tokenring/ibmtr.c	Mon Jul 16 20:40:03 2001
+++ linux-246-ac5/drivers/net/tokenring/ibmtr.c	Thu Jul 19 23:04:49 2001
@@ -330,7 +330,6 @@
 	for (i = 0; ibmtr_portlist[i]; i++) {
 		int ioaddr = ibmtr_portlist[i];
 
-		if (check_region(ioaddr, IBMTR_IO_EXTENT)) continue;
 		if (!ibmtr_probe1(dev, ioaddr)) return 0;
 	}
 	return -ENODEV;
@@ -355,6 +354,8 @@
 #ifndef MODULE
 #ifndef PCMCIA
 	dev = init_trdev(dev, 0);
+	if (!dev)
+		return -ENOMEM;
 #endif
 #endif
 
@@ -392,6 +393,7 @@
 	 *    what we is there to learn of ISA/MCA or not TR card
 	 */
 #ifdef PCMCIA
+	iounmap(t_mmio);
 	ti = dev->priv;		/*BMS moved up here */
 	t_mmio = ti->mmio;	/*BMS to get virtual address */
 	irq = ti->irq;		/*BMS to display the irq!   */
@@ -424,7 +426,12 @@
 	if (cardpresent == TR_ISA && (readb(AIPFID + t_mmio) == 0x0e))
 		cardpresent = TR_ISAPNP;
 	if (cardpresent == NOTOK) {	/* "channel_id" did not match, report */
-		if (!(ibmtr_debug_trace & TRC_INIT)) return -ENODEV;
+		if (!(ibmtr_debug_trace & TRC_INIT)) {
+#ifndef PCMCIA
+			iounmap(t_mmio);
+#endif
+			return -ENODEV;
+		}
 		DPRINTK( "Channel ID string not found for PIOaddr: %4hx\n",
 								PIOaddr);
 		DPRINTK("Expected for ISA: ");
@@ -442,7 +449,10 @@
 	   waste the memory, just use the existing structure */
 #ifndef PCMCIA
 	ti = (struct tok_info *) kmalloc(sizeof(struct tok_info), GFP_KERNEL);
-	if (ti == NULL) return -ENOMEM;
+	if (ti == NULL) {
+		iounmap(t_mmio);
+		return -ENOMEM;
+	}
 	memset(ti, 0, sizeof(struct tok_info));
 	ti->mmio = t_mmio;
 	dev->priv = ti;		/* this seems like the logical use of the
@@ -459,7 +469,7 @@
 		ti->turbo=1;
 		t_irq=turbo_irq[i];
         }
-#endif
+#endif /* !PCMCIA */
 	ti->readlog_pending = 0;
 	init_waitqueue_head(&ti->wait_for_reset);
 
@@ -496,6 +506,7 @@
 		while (!readb(ti->mmio + ACA_OFFSET + ACA_RW + RRR_EVEN)){
 			if (!time_after(jiffies, timeout)) continue;
 			DPRINTK( "Hardware timeout during initialization.\n");
+			iounmap(t_mmio);
 			kfree(ti);
 			return -ENODEV;
 		}
@@ -609,6 +620,7 @@
 		default:
 			DPRINTK("Unknown shared ram paging info %01X\n",
 							ti->shared_ram_paging);
+			iounmap(t_mmio); 
 			kfree(ti);
 			return -ENODEV;
 			break;
@@ -638,6 +650,7 @@
 			DPRINTK("Shared RAM for this adapter (%05x) exceeds "
 			"driver limit (%05x), adapter not started.\n",
 			chk_base, ibmtr_mem_base + IBMTR_SHARED_RAM_SIZE);
+			iounmap(t_mmio);
 			kfree(ti);
 			return -ENODEV;
 		} else { /* seems cool, record what we have figured out */
@@ -652,16 +665,24 @@
 	if (request_irq(dev->irq = irq, &tok_interrupt, 0, "ibmtr", dev) != 0) {
 		DPRINTK("Could not grab irq %d.  Halting Token Ring driver.\n",
 					irq);
+		iounmap(t_mmio);
 		kfree(ti);
 		return -ENODEV;
 	}
 	/*?? Now, allocate some of the PIO PORTs for this driver.. */
 	/* record PIOaddr range as busy */
-	request_region(PIOaddr, IBMTR_IO_EXTENT, "ibmtr");
+	if (!request_region(PIOaddr, IBMTR_IO_EXTENT, "ibmtr")) {
+		DPRINTK("Could not grab PIO range. Halting driver.\n");
+		free_irq(dev->irq);
+		iounmap(t_mmio);
+		kfree(ti);
+		return -EBUSY;
+	}
+
 	if (!version_printed++) {
 		printk(version);
 	}
-#endif
+#endif /* !PCMCIA */
 	DPRINTK("%s %s found\n",
 		channel_def[cardpresent - 1], adapter_def(ti->adapter_type));
 	DPRINTK("using irq %d, PIOaddr %hx, %dK shared RAM.\n",
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"I begin by taking. I shall find scholars later to demonstrate my 
perfect right." - Frederick (II) the Great
