Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTFIREL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFIREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:04:11 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:26551 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264538AbTFIRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:03:37 -0400
Message-Id: <200306091717.h59HHAsG024795@ginger.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] assorted changes to atm protocol stack 
In-reply-to: Your message of "Sun, 08 Jun 2003 21:51:21 EDT."
             <200306090151.h591pLC07310@relax.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 09 Jun 2003 13:15:18 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i left out part of the diff by accident, here the needed changes
to drivers/atm:

===== drivers/atm/atmtcp.c 1.7 vs edited =====
--- 1.7/drivers/atm/atmtcp.c	Thu May 15 20:20:17 2003
+++ edited/drivers/atm/atmtcp.c	Sat Jun  7 11:38:19 2003
@@ -153,9 +153,9 @@
 
 static int atmtcp_v_ioctl(struct atm_dev *dev,unsigned int cmd,void *arg)
 {
-	unsigned long flags;
 	struct atm_cirange ci;
 	struct atm_vcc *vcc;
+	struct sock *s;
 
 	if (cmd != ATM_SETCIRANGE) return -ENOIOCTLCMD;
 	if (copy_from_user(&ci,(void *) arg,sizeof(ci))) return -EFAULT;
@@ -163,14 +163,18 @@
 	if (ci.vci_bits == ATM_CI_MAX) ci.vci_bits = MAX_VCI_BITS;
 	if (ci.vpi_bits > MAX_VPI_BITS || ci.vpi_bits < 0 ||
 	    ci.vci_bits > MAX_VCI_BITS || ci.vci_bits < 0) return -EINVAL;
-	spin_lock_irqsave(&dev->lock, flags);
-	for (vcc = dev->vccs; vcc; vcc = vcc->next)
+	read_lock(&vcc_sklist_lock);
+	for (s = vcc_sklist; s; s = s->next) {
+		vcc = atm_sk(s);
+		if (vcc->dev != dev)
+			continue;
 		if ((vcc->vpi >> ci.vpi_bits) ||
 		    (vcc->vci >> ci.vci_bits)) {
-			spin_unlock_irqrestore(&dev->lock, flags);
+			read_unlock(&vcc_sklist_lock);
 			return -EBUSY;
 		}
-	spin_unlock_irqrestore(&dev->lock, flags);
+	}
+	read_unlock(&vcc_sklist_lock);
 	dev->ci_range = ci;
 	return 0;
 }
@@ -233,9 +237,9 @@
 
 static void atmtcp_c_close(struct atm_vcc *vcc)
 {
-	unsigned long flags;
 	struct atm_dev *atmtcp_dev;
 	struct atmtcp_dev_data *dev_data;
+	struct sock *s;
 	struct atm_vcc *walk;
 
 	atmtcp_dev = (struct atm_dev *) vcc->dev_data;
@@ -246,19 +250,23 @@
 	kfree(dev_data);
 	shutdown_atm_dev(atmtcp_dev);
 	vcc->dev_data = NULL;
-	spin_lock_irqsave(&atmtcp_dev->lock, flags);
-	for (walk = atmtcp_dev->vccs; walk; walk = walk->next)
+	read_lock(&vcc_sklist_lock);
+	for (s = vcc_sklist; s; s = s->next) {
+		walk = atm_sk(s);
+		if (walk->dev != atmtcp_dev)
+			continue;
 		wake_up(&walk->sleep);
-	spin_unlock_irqrestore(&atmtcp_dev->lock, flags);
+	}
+	read_unlock(&vcc_sklist_lock);
 }
 
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
-	unsigned long flags;
 	struct atm_dev *dev;
 	struct atmtcp_hdr *hdr;
-	struct atm_vcc *out_vcc;
+	struct sock *s;
+	struct atm_vcc *out_vcc = NULL;
 	struct sk_buff *new_skb;
 	int result = 0;
 
@@ -270,13 +278,17 @@
 		    (struct atmtcp_control *) skb->data);
 		goto done;
 	}
-	spin_lock_irqsave(&dev->lock, flags);
-	for (out_vcc = dev->vccs; out_vcc; out_vcc = out_vcc->next)
+	read_lock(&vcc_sklist_lock);
+	for (s = vcc_sklist; s; s = s->next) {
+		out_vcc = atm_sk(s);
+		if (out_vcc->dev != dev)
+			continue;
 		if (out_vcc->vpi == ntohs(hdr->vpi) &&
 		    out_vcc->vci == ntohs(hdr->vci) &&
 		    out_vcc->qos.rxtp.traffic_class != ATM_NONE)
 			break;
-	spin_unlock_irqrestore(&dev->lock, flags);
+	}
+	read_unlock(&vcc_sklist_lock);
 	if (!out_vcc) {
 		atomic_inc(&vcc->stats->tx_err);
 		goto done;
@@ -366,7 +378,7 @@
 	if (itf != -1) dev = atm_dev_lookup(itf);
 	if (dev) {
 		if (dev->ops != &atmtcp_v_dev_ops) {
-			atm_dev_release(dev);
+			atm_dev_put(dev);
 			return -EMEDIUMTYPE;
 		}
 		if (PRIV(dev)->vcc) return -EBUSY;
@@ -378,7 +390,8 @@
 		if (error) return error;
 	}
 	PRIV(dev)->vcc = vcc;
-	bind_vcc(vcc,&atmtcp_control_dev);
+	vcc->dev = &atmtcp_control_dev;
+	vcc_insert_socket(vcc->sk);
 	set_bit(ATM_VF_META,&vcc->flags);
 	set_bit(ATM_VF_READY,&vcc->flags);
 	vcc->dev_data = dev;
@@ -402,7 +415,7 @@
 	dev = atm_dev_lookup(itf);
 	if (!dev) return -ENODEV;
 	if (dev->ops != &atmtcp_v_dev_ops) {
-		atm_dev_release(dev);
+		atm_dev_put(dev);
 		return -EMEDIUMTYPE;
 	}
 	dev_data = PRIV(dev);
@@ -410,7 +423,7 @@
 	dev_data->persist = 0;
 	if (PRIV(dev)->vcc) return 0;
 	kfree(dev_data);
-	atm_dev_release(dev);
+	atm_dev_put(dev);
 	shutdown_atm_dev(dev);
 	return 0;
 }
===== drivers/atm/eni.c 1.14 vs edited =====
--- 1.14/drivers/atm/eni.c	Thu May 15 20:20:17 2003
+++ edited/drivers/atm/eni.c	Sat Jun  7 11:38:20 2003
@@ -1887,10 +1887,10 @@
 
 static int get_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
-	unsigned long flags;
+	struct sock *s;
 	struct atm_vcc *walk;
 
-	spin_lock_irqsave(&vcc->dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
 	if (*vpi == ATM_VPI_ANY) *vpi = 0;
 	if (*vci == ATM_VCI_ANY) {
 		for (*vci = ATM_NOT_RSV_VCI; *vci < NR_VCI; (*vci)++) {
@@ -1898,40 +1898,47 @@
 			    ENI_DEV(vcc->dev)->rx_map[*vci])
 				continue;
 			if (vcc->qos.txtp.traffic_class != ATM_NONE) {
-				for (walk = vcc->dev->vccs; walk;
-				    walk = walk->next)
+				for (s = vcc_sklist; s; s = s->next) {
+					walk = atm_sk(s);
+					if (walk->dev != vcc->dev)
+						continue;
 					if (test_bit(ATM_VF_ADDR,&walk->flags)
 					    && walk->vci == *vci &&
 					    walk->qos.txtp.traffic_class !=
 					    ATM_NONE)
 						break;
-				if (walk) continue;
+				}
+				if (s) continue;
 			}
 			break;
 		}
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return *vci == NR_VCI ? -EADDRINUSE : 0;
 	}
 	if (*vci == ATM_VCI_UNSPEC) {
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return 0;
 	}
 	if (vcc->qos.rxtp.traffic_class != ATM_NONE &&
 	    ENI_DEV(vcc->dev)->rx_map[*vci]) {
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return -EADDRINUSE;
 	}
 	if (vcc->qos.txtp.traffic_class == ATM_NONE) {
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return 0;
 	}
-	for (walk = vcc->dev->vccs; walk; walk = walk->next)
+	for (s = vcc_sklist; s; s = s->next) {
+		walk = atm_sk(s);
+		if (walk->dev != vcc->dev)
+			continue;
 		if (test_bit(ATM_VF_ADDR,&walk->flags) && walk->vci == *vci &&
 		    walk->qos.txtp.traffic_class != ATM_NONE) {
-			spin_unlock_irqrestore(&vcc->dev->lock, flags);
+			read_unlock(&vcc_sklist_lock);
 			return -EADDRINUSE;
 		}
-	spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	}
+	read_unlock(&vcc_sklist_lock);
 	return 0;
 }
 
@@ -2139,7 +2146,7 @@
 
 static int eni_proc_read(struct atm_dev *dev,loff_t *pos,char *page)
 {
-	unsigned long flags;
+	struct sock *s;
 	static const char *signal[] = { "LOST","unknown","okay" };
 	struct eni_dev *eni_dev = ENI_DEV(dev);
 	struct atm_vcc *vcc;
@@ -2212,11 +2219,15 @@
 		return sprintf(page,"%10sbacklog %u packets\n","",
 		    skb_queue_len(&tx->backlog));
 	}
-	spin_lock_irqsave(&dev->lock, flags);
-	for (vcc = dev->vccs; vcc; vcc = vcc->next) {
-		struct eni_vcc *eni_vcc = ENI_VCC(vcc);
+	read_lock(&vcc_sklist_lock);
+	for (s = vcc_sklist; s; s = s->next) {
+		struct eni_vcc *eni_vcc;
 		int length;
 
+		vcc = atm_sk(s);
+		if (vcc->dev != dev)
+			continue;
+		eni_vcc = ENI_VCC(vcc);
 		if (--left) continue;
 		length = sprintf(page,"vcc %4d: ",vcc->vci);
 		if (eni_vcc->rx) {
@@ -2231,10 +2242,10 @@
 			length += sprintf(page+length,"tx[%d], txing %d bytes",
 			    eni_vcc->tx->index,eni_vcc->txing);
 		page[length] = '\n';
-		spin_unlock_irqrestore(&dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return length+1;
 	}
-	spin_unlock_irqrestore(&dev->lock, flags);
+	read_unlock(&vcc_sklist_lock);
 	for (i = 0; i < eni_dev->free_len; i++) {
 		struct eni_free *fe = eni_dev->free_list+i;
 		unsigned long offset;
===== drivers/atm/fore200e.c 1.14 vs edited =====
--- 1.14/drivers/atm/fore200e.c	Thu May 15 20:20:17 2003
+++ edited/drivers/atm/fore200e.c	Sat Jun  7 11:38:20 2003
@@ -1074,18 +1074,22 @@
 static struct atm_vcc* 
 fore200e_find_vcc(struct fore200e* fore200e, struct rpd* rpd)
 {
-    unsigned long flags;
+    struct sock *s;
     struct atm_vcc* vcc;
 
-    spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
-    for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
-
-	if (vcc->vpi == rpd->atm_header.vpi && vcc->vci == rpd->atm_header.vci)
-	    break;
+    read_lock(&vcc_sklist_lock);
+    for(s = vcc_sklist; s; s = s->next) {
+	vcc = atm_sk(s);
+	if (vcc->dev != fore200e->atm_dev)
+		continue;
+	if (vcc->vpi == rpd->atm_header.vpi && vcc->vci == rpd->atm_header.vci) {
+            read_unlock(&vcc_sklist_lock);
+	    return vcc;
+	}
     }
-    spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
-    
-    return vcc;
+    read_unlock(&vcc_sklist_lock);
+
+    return NULL;
 }
 
 
@@ -1355,20 +1359,23 @@
 static int
 fore200e_walk_vccs(struct atm_vcc *vcc, short *vpi, int *vci)
 {
-    unsigned long flags;
     struct atm_vcc* walk;
+    struct sock *s;
 
     /* find a free VPI */
 
-    spin_lock_irqsave(&vcc->dev->lock, flags);
+    read_lock(&vcc_sklist_lock);
 
     if (*vpi == ATM_VPI_ANY) {
 
-	for (*vpi = 0, walk = vcc->dev->vccs; walk; walk = walk->next) {
+	for (*vpi = 0, s = vcc_sklist; s; s = s->next) {
+	    walk = atm_sk(s);
+	    if (walk->dev != vcc->dev)
+		continue;
 
 	    if ((walk->vci == *vci) && (walk->vpi == *vpi)) {
 		(*vpi)++;
-		walk = vcc->dev->vccs;
+		s = vcc_sklist;
 	    }
 	}
     }
@@ -1376,16 +1383,19 @@
     /* find a free VCI */
     if (*vci == ATM_VCI_ANY) {
 	
-	for (*vci = ATM_NOT_RSV_VCI, walk = vcc->dev->vccs; walk; walk = walk->next) {
+	for (*vci = ATM_NOT_RSV_VCI, s = vcc_sklist; s; s = s->next) {
+	    walk = atm_sk(s);
+	    if (walk->dev != vcc->dev)
+		continue;
 
 	    if ((walk->vpi = *vpi) && (walk->vci == *vci)) {
 		*vci = walk->vci + 1;
-		walk = vcc->dev->vccs;
+		s = vcc_sklist;
 	    }
 	}
     }
 
-    spin_unlock_irqrestore(&vcc->dev->lock, flags);
+    read_unlock(&vcc_sklist_lock);
 
     return 0;
 }
@@ -2647,7 +2657,7 @@
 static int
 fore200e_proc_read(struct atm_dev *dev,loff_t* pos,char* page)
 {
-    unsigned long flags;
+    struct sock *s;
     struct fore200e* fore200e  = FORE200E_DEV(dev);
     int              len, left = *pos;
 
@@ -2894,8 +2904,12 @@
 	len = sprintf(page,"\n"    
 		      " VCCs:\n  address\tVPI.VCI:AAL\t(min/max tx PDU size) (min/max rx PDU size)\n");
 	
-	spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
-	for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
+	read_lock(&vcc_sklist_lock);
+	for (s = vcc_sklist; s; s = s->next) {
+	    vcc = atm_sk(s);
+
+	    if (vcc->dev != fore200e->atm_dev)
+		    continue;
 
 	    fore200e_vcc = FORE200E_VCC(vcc);
 	    
@@ -2909,7 +2923,7 @@
 			   fore200e_vcc->rx_max_pdu
 		);
 	}
-	spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
+	read_unlock(&vcc_sklist_lock);
 
 	return len;
     }
===== drivers/atm/he.c 1.11 vs edited =====
--- 1.11/drivers/atm/he.c	Fri May 30 10:47:13 2003
+++ edited/drivers/atm/he.c	Sat Jun  7 11:38:21 2003
@@ -79,7 +79,6 @@
 #include <linux/sonet.h>
 
 #define USE_TASKLET
-#define USE_HE_FIND_VCC
 #undef USE_SCATTERGATHER
 #undef USE_CHECKSUM_HW			/* still confused about this */
 #define USE_RBPS
@@ -328,25 +327,24 @@
 		he_writel_rcm(dev, val, 0x00000 | (cid << 3) | 7)
 
 static __inline__ struct atm_vcc*
-he_find_vcc(struct he_dev *he_dev, unsigned cid)
+__find_vcc(struct he_dev *he_dev, unsigned cid)
 {
-	unsigned long flags;
 	struct atm_vcc *vcc;
+	struct sock *s;
 	short vpi;
 	int vci;
 
 	vpi = cid >> he_dev->vcibits;
 	vci = cid & ((1 << he_dev->vcibits) - 1);
 
-	spin_lock_irqsave(&he_dev->atm_dev->lock, flags);
-	for (vcc = he_dev->atm_dev->vccs; vcc; vcc = vcc->next)
-		if (vcc->vci == vci && vcc->vpi == vpi
-			&& vcc->qos.rxtp.traffic_class != ATM_NONE) {
-				spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
+	for (s = vcc_sklist; s; s = s->next) {
+		vcc = atm_sk(s);
+		if (vcc->dev == he_dev->atm_dev &&
+		    vcc->vci == vci && vcc->vpi == vpi &&
+		    vcc->qos.rxtp.traffic_class != ATM_NONE) {
 				return vcc;
-			}
-
-	spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
+		}
+	}
 	return NULL;
 }
 
@@ -1566,17 +1564,6 @@
 	reg |= RX_ENABLE;
 	he_writel(he_dev, reg, RC_CONFIG);
 
-#ifndef USE_HE_FIND_VCC
-	he_dev->he_vcc_table = kmalloc(sizeof(struct he_vcc_table) * 
-			(1 << (he_dev->vcibits + he_dev->vpibits)), GFP_KERNEL);
-	if (he_dev->he_vcc_table == NULL) {
-		hprintk("failed to alloc he_vcc_table\n");
-		return -ENOMEM;
-	}
-	memset(he_dev->he_vcc_table, 0, sizeof(struct he_vcc_table) *
-				(1 << (he_dev->vcibits + he_dev->vpibits)));
-#endif
-
 	for (i = 0; i < HE_NUM_CS_STPER; ++i) {
 		he_dev->cs_stper[i].inuse = 0;
 		he_dev->cs_stper[i].pcr = -1;
@@ -1712,11 +1699,6 @@
 							he_dev->tpd_base, he_dev->tpd_base_phys);
 #endif
 
-#ifndef USE_HE_FIND_VCC
-	if (he_dev->he_vcc_table)
-		kfree(he_dev->he_vcc_table);
-#endif
-
 	if (he_dev->pci_dev) {
 		pci_read_config_word(he_dev->pci_dev, PCI_COMMAND, &command);
 		command &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
@@ -1798,6 +1780,7 @@
 	int pdus_assembled = 0;
 	int updated = 0;
 
+	read_lock(&vcc_sklist_lock);
 	while (he_dev->rbrq_head != rbrq_tail) {
 		++updated;
 
@@ -1823,13 +1806,10 @@
 		buf_len = RBRQ_BUFLEN(he_dev->rbrq_head) * 4;
 		cid = RBRQ_CID(he_dev->rbrq_head);
 
-#ifdef USE_HE_FIND_VCC
 		if (cid != lastcid)
-			vcc = he_find_vcc(he_dev, cid);
+			vcc = __find_vcc(he_dev, cid);
 		lastcid = cid;
-#else
-		vcc = HE_LOOKUP_VCC(he_dev, cid);
-#endif
+
 		if (vcc == NULL) {
 			hprintk("vcc == NULL  (cid 0x%x)\n", cid);
 			if (!RBRQ_HBUF_ERR(he_dev->rbrq_head))
@@ -1966,6 +1946,7 @@
 					RBRQ_MASK(++he_dev->rbrq_head));
 
 	}
+	read_unlock(&vcc_sklist_lock);
 
 	if (updated) {
 		if (updated > he_dev->rbrq_peak)
@@ -2565,10 +2546,6 @@
 #endif
 
 		spin_unlock_irqrestore(&he_dev->global_lock, flags);
-
-#ifndef USE_HE_FIND_VCC
-		HE_LOOKUP_VCC(he_dev, cid) = vcc;
-#endif
 	}
 
 open_failed:
@@ -2634,9 +2611,6 @@
 		if (timeout == 0)
 			hprintk("close rx timeout cid 0x%x\n", cid);
 
-#ifndef USE_HE_FIND_VCC
-		HE_LOOKUP_VCC(he_dev, cid) = NULL;
-#endif
 		HPRINTK("close rx cid 0x%x complete\n", cid);
 
 	}
===== drivers/atm/idt77252.c 1.13 vs edited =====
--- 1.13/drivers/atm/idt77252.c	Thu May 15 20:20:17 2003
+++ edited/drivers/atm/idt77252.c	Sat Jun  7 11:38:22 2003
@@ -2402,37 +2402,43 @@
 static int
 idt77252_find_vcc(struct atm_vcc *vcc, short *vpi, int *vci)
 {
-	unsigned long flags;
+	struct sock *s;
 	struct atm_vcc *walk;
 
-	spin_lock_irqsave(&vcc->dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
 	if (*vpi == ATM_VPI_ANY) {
 		*vpi = 0;
-		walk = vcc->dev->vccs;
-		while (walk) {
+		s = vcc_sklist;
+		while (s) {
+			walk = atm_sk(s);
+			if (walk->dev != vcc->dev)
+				continue;
 			if ((walk->vci == *vci) && (walk->vpi == *vpi)) {
 				(*vpi)++;
-				walk = vcc->dev->vccs;
+				s = vcc_sklist;
 				continue;
 			}
-			walk = walk->next;
+			s = s->next;
 		}
 	}
 
 	if (*vci == ATM_VCI_ANY) {
 		*vci = ATM_NOT_RSV_VCI;
-		walk = vcc->dev->vccs;
-		while (walk) {
+		s = vcc_sklist;
+		while (s) {
+			walk = atm_sk(s);
+			if (walk->dev != vcc->dev)
+				continue;
 			if ((walk->vci == *vci) && (walk->vpi == *vpi)) {
 				(*vci)++;
-				walk = vcc->dev->vccs;
+				s = vcc_sklist;
 				continue;
 			}
-			walk = walk->next;
+			s = s->next;
 		}
 	}
 
-	spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	read_unlock(&vcc_sklist_lock);
 	return 0;
 }
 
