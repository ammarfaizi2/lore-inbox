Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUDNWQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUDNWQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:16:38 -0400
Received: from palrel11.hp.com ([156.153.255.246]:24240 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261832AbUDNWQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:16:10 -0400
Date: Wed, 14 Apr 2004 15:16:08 -0700
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Convert vlsi_ir /proc/driver to seq_file
Message-ID: <20040414221608.GB5434@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir265_vlsi_proc.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Convert vlsi_ir /proc/driver to single seq_file method.


diff -u -p linux/drivers/net/irda/vlsi_ir.d0.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.d0.c	Wed Apr  7 14:54:04 2004
+++ linux/drivers/net/irda/vlsi_ir.c	Wed Apr  7 18:34:42 2004
@@ -44,6 +44,7 @@ MODULE_LICENSE("GPL");
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -160,72 +161,64 @@ static struct proc_dir_entry *vlsi_proc_
 
 #ifdef CONFIG_PROC_FS
 
-static int vlsi_proc_pdev(struct pci_dev *pdev, char *buf, int len)
+static void vlsi_proc_pdev(struct seq_file *seq, struct pci_dev *pdev)
 {
 	unsigned iobase = pci_resource_start(pdev, 0);
 	unsigned i;
-	char *out = buf;
 
-	if (len < 500)
-		return 0;
-
-	out += sprintf(out, "\n%s (vid/did: %04x/%04x)\n",
-			PCIDEV_NAME(pdev), (int)pdev->vendor, (int)pdev->device);
-	out += sprintf(out, "pci-power-state: %u\n", (unsigned) pdev->current_state);
-	out += sprintf(out, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
-			pdev->irq, (unsigned)pci_resource_start(pdev, 0), (unsigned long long)pdev->dma_mask);
-	out += sprintf(out, "hw registers: ");
+	seq_printf(seq, "\n%s (vid/did: %04x/%04x)\n",
+		   PCIDEV_NAME(pdev), (int)pdev->vendor, (int)pdev->device);
+	seq_printf(seq, "pci-power-state: %u\n", (unsigned) pdev->current_state);
+	seq_printf(seq, "resources: irq=%u / io=0x%04x / dma_mask=0x%016Lx\n",
+		   pdev->irq, (unsigned)pci_resource_start(pdev, 0), (unsigned long long)pdev->dma_mask);
+	seq_printf(seq, "hw registers: ");
 	for (i = 0; i < 0x20; i++)
-		out += sprintf(out, "%02x", (unsigned)inb((iobase+i)));
-	out += sprintf(out, "\n");
-	return out - buf;
+		seq_printf(seq, "%02x", (unsigned)inb((iobase+i)));
+	seq_printf(seq, "\n");
 }
 		
-static int vlsi_proc_ndev(struct net_device *ndev, char *buf, int len)
+static void vlsi_proc_ndev(struct seq_file *seq, struct net_device *ndev)
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
-	char *out = buf;
 	u8 byte;
 	u16 word;
 	unsigned delta1, delta2;
 	struct timeval now;
 	unsigned iobase = ndev->base_addr;
 
-	if (len < 1000)
-		return 0;
-
-	out += sprintf(out, "\n%s link state: %s / %s / %s / %s\n", ndev->name,
+	seq_printf(seq, "\n%s link state: %s / %s / %s / %s\n", ndev->name,
 		netif_device_present(ndev) ? "attached" : "detached", 
 		netif_running(ndev) ? "running" : "not running",
 		netif_carrier_ok(ndev) ? "carrier ok" : "no carrier",
 		netif_queue_stopped(ndev) ? "queue stopped" : "queue running");
+
 	if (!netif_running(ndev))
-		return out - buf;
+		return;
 
-	out += sprintf(out, "\nhw-state:\n");
+	seq_printf(seq, "\nhw-state:\n");
 	pci_read_config_byte(idev->pdev, VLSI_PCI_IRMISC, &byte);
-	out += sprintf(out, "IRMISC:%s%s%s uart%s",
+	seq_printf(seq, "IRMISC:%s%s%s uart%s",
 		(byte&IRMISC_IRRAIL) ? " irrail" : "",
 		(byte&IRMISC_IRPD) ? " irpd" : "",
 		(byte&IRMISC_UARTTST) ? " uarttest" : "",
 		(byte&IRMISC_UARTEN) ? "@" : " disabled\n");
 	if (byte&IRMISC_UARTEN) {
-		out += sprintf(out, "0x%s\n",
+		seq_printf(seq, "0x%s\n",
 			(byte&2) ? ((byte&1) ? "3e8" : "2e8")
 				 : ((byte&1) ? "3f8" : "2f8"));
 	}
 	pci_read_config_byte(idev->pdev, VLSI_PCI_CLKCTL, &byte);
-	out += sprintf(out, "CLKCTL: PLL %s%s%s / clock %s / wakeup %s\n",
+	seq_printf(seq, "CLKCTL: PLL %s%s%s / clock %s / wakeup %s\n",
 		(byte&CLKCTL_PD_INV) ? "powered" : "down",
 		(byte&CLKCTL_LOCK) ? " locked" : "",
 		(byte&CLKCTL_EXTCLK) ? ((byte&CLKCTL_XCKSEL)?" / 40 MHz XCLK":" / 48 MHz XCLK") : "",
 		(byte&CLKCTL_CLKSTP) ? "stopped" : "running",
 		(byte&CLKCTL_WAKE) ? "enabled" : "disabled");
 	pci_read_config_byte(idev->pdev, VLSI_PCI_MSTRPAGE, &byte);
-	out += sprintf(out, "MSTRPAGE: 0x%02x\n", (unsigned)byte);
+	seq_printf(seq, "MSTRPAGE: 0x%02x\n", (unsigned)byte);
 
 	byte = inb(iobase+VLSI_PIO_IRINTR);
-	out += sprintf(out, "IRINTR:%s%s%s%s%s%s%s%s\n",
+	seq_printf(seq, "IRINTR:%s%s%s%s%s%s%s%s\n",
 		(byte&IRINTR_ACTEN) ? " ACTEN" : "",
 		(byte&IRINTR_RPKTEN) ? " RPKTEN" : "",
 		(byte&IRINTR_TPKTEN) ? " TPKTEN" : "",
@@ -235,16 +228,16 @@ static int vlsi_proc_ndev(struct net_dev
 		(byte&IRINTR_TPKTINT) ? " TPKTINT" : "",
 		(byte&IRINTR_OE_INT) ? " OE_INT" : "");
 	word = inw(iobase+VLSI_PIO_RINGPTR);
-	out += sprintf(out, "RINGPTR: rx=%u / tx=%u\n", RINGPTR_GET_RX(word), RINGPTR_GET_TX(word));
+	seq_printf(seq, "RINGPTR: rx=%u / tx=%u\n", RINGPTR_GET_RX(word), RINGPTR_GET_TX(word));
 	word = inw(iobase+VLSI_PIO_RINGBASE);
-	out += sprintf(out, "RINGBASE: busmap=0x%08x\n",
+	seq_printf(seq, "RINGBASE: busmap=0x%08x\n",
 		((unsigned)word << 10)|(MSTRPAGE_VALUE<<24));
 	word = inw(iobase+VLSI_PIO_RINGSIZE);
-	out += sprintf(out, "RINGSIZE: rx=%u / tx=%u\n", RINGSIZE_TO_RXSIZE(word),
+	seq_printf(seq, "RINGSIZE: rx=%u / tx=%u\n", RINGSIZE_TO_RXSIZE(word),
 		RINGSIZE_TO_TXSIZE(word));
 
 	word = inw(iobase+VLSI_PIO_IRCFG);
-	out += sprintf(out, "IRCFG:%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+	seq_printf(seq, "IRCFG:%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
 		(word&IRCFG_LOOP) ? " LOOP" : "",
 		(word&IRCFG_ENTX) ? " ENTX" : "",
 		(word&IRCFG_ENRX) ? " ENRX" : "",
@@ -259,7 +252,7 @@ static int vlsi_proc_ndev(struct net_dev
 		(word&IRCFG_TXPOL) ? " TXPOL" : "",
 		(word&IRCFG_RXPOL) ? " RXPOL" : "");
 	word = inw(iobase+VLSI_PIO_IRENABLE);
-	out += sprintf(out, "IRENABLE:%s%s%s%s%s%s%s%s\n",
+	seq_printf(seq, "IRENABLE:%s%s%s%s%s%s%s%s\n",
 		(word&IRENABLE_PHYANDCLOCK) ? " PHYANDCLOCK" : "",
 		(word&IRENABLE_CFGER) ? " CFGERR" : "",
 		(word&IRENABLE_FIR_ON) ? " FIR_ON" : "",
@@ -269,22 +262,22 @@ static int vlsi_proc_ndev(struct net_dev
 		(word&IRENABLE_ENRXST) ? " ENRXST" : "",
 		(word&IRENABLE_CRC16_ON) ? " CRC16_ON" : "");
 	word = inw(iobase+VLSI_PIO_PHYCTL);
-	out += sprintf(out, "PHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
+	seq_printf(seq, "PHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
 		(unsigned)PHYCTL_TO_BAUD(word),
 		(unsigned)PHYCTL_TO_PLSWID(word),
 		(unsigned)PHYCTL_TO_PREAMB(word));
 	word = inw(iobase+VLSI_PIO_NPHYCTL);
-	out += sprintf(out, "NPHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
+	seq_printf(seq, "NPHYCTL: baud-divisor=%u / pulsewidth=%u / preamble=%u\n",
 		(unsigned)PHYCTL_TO_BAUD(word),
 		(unsigned)PHYCTL_TO_PLSWID(word),
 		(unsigned)PHYCTL_TO_PREAMB(word));
 	word = inw(iobase+VLSI_PIO_MAXPKT);
-	out += sprintf(out, "MAXPKT: max. rx packet size = %u\n", word);
+	seq_printf(seq, "MAXPKT: max. rx packet size = %u\n", word);
 	word = inw(iobase+VLSI_PIO_RCVBCNT) & RCVBCNT_MASK;
-	out += sprintf(out, "RCVBCNT: rx-fifo filling level = %u\n", word);
+	seq_printf(seq, "RCVBCNT: rx-fifo filling level = %u\n", word);
 
-	out += sprintf(out, "\nsw-state:\n");
-	out += sprintf(out, "IrPHY setup: %d baud - %s encoding\n", idev->baud, 
+	seq_printf(seq, "\nsw-state:\n");
+	seq_printf(seq, "IrPHY setup: %d baud - %s encoding\n", idev->baud, 
 		(idev->mode==IFF_SIR)?"SIR":((idev->mode==IFF_MIR)?"MIR":"FIR"));
 	do_gettimeofday(&now);
 	if (now.tv_usec >= idev->last_rx.tv_usec) {
@@ -295,216 +288,110 @@ static int vlsi_proc_ndev(struct net_dev
 		delta2 = 1000000 + now.tv_usec - idev->last_rx.tv_usec;
 		delta1 = 1;
 	}
-	out += sprintf(out, "last rx: %lu.%06u sec\n",
+	seq_printf(seq, "last rx: %lu.%06u sec\n",
 		now.tv_sec - idev->last_rx.tv_sec - delta1, delta2);	
 
-	out += sprintf(out, "RX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu",
+	seq_printf(seq, "RX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu",
 		idev->stats.rx_packets, idev->stats.rx_bytes, idev->stats.rx_errors,
 		idev->stats.rx_dropped);
-	out += sprintf(out, " / overrun=%lu / length=%lu / frame=%lu / crc=%lu\n",
+	seq_printf(seq, " / overrun=%lu / length=%lu / frame=%lu / crc=%lu\n",
 		idev->stats.rx_over_errors, idev->stats.rx_length_errors,
 		idev->stats.rx_frame_errors, idev->stats.rx_crc_errors);
-	out += sprintf(out, "TX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu / fifo=%lu\n",
+	seq_printf(seq, "TX: packets=%lu / bytes=%lu / errors=%lu / dropped=%lu / fifo=%lu\n",
 		idev->stats.tx_packets, idev->stats.tx_bytes, idev->stats.tx_errors,
 		idev->stats.tx_dropped, idev->stats.tx_fifo_errors);
 
-	return out - buf;
 }
 		
-static int vlsi_proc_ring(struct vlsi_ring *r, char *buf, int len)
+static void vlsi_proc_ring(struct seq_file *seq, struct vlsi_ring *r)
 {
 	struct ring_descr *rd;
 	unsigned i, j;
 	int h, t;
-	char *out = buf;
-
-	if (len < 3000)
-		return 0;
 
-	out += sprintf(out, "size %u / mask 0x%04x / len %u / dir %d / hw %p\n",
+	seq_printf(seq, "size %u / mask 0x%04x / len %u / dir %d / hw %p\n",
 		r->size, r->mask, r->len, r->dir, r->rd[0].hw);
 	h = atomic_read(&r->head) & r->mask;
 	t = atomic_read(&r->tail) & r->mask;
-	out += sprintf(out, "head = %d / tail = %d ", h, t);
+	seq_printf(seq, "head = %d / tail = %d ", h, t);
 	if (h == t)
-		out += sprintf(out, "(empty)\n");
+		seq_printf(seq, "(empty)\n");
 	else {
 		if (((t+1)&r->mask) == h)
-			out += sprintf(out, "(full)\n");
+			seq_printf(seq, "(full)\n");
 		else
-			out += sprintf(out, "(level = %d)\n", ((unsigned)(t-h) & r->mask)); 
+			seq_printf(seq, "(level = %d)\n", ((unsigned)(t-h) & r->mask)); 
 		rd = &r->rd[h];
 		j = (unsigned) rd_get_count(rd);
-		out += sprintf(out, "current: rd = %d / status = %02x / len = %u\n",
+		seq_printf(seq, "current: rd = %d / status = %02x / len = %u\n",
 				h, (unsigned)rd_get_status(rd), j);
 		if (j > 0) {
-			out += sprintf(out, "   data:");
+			seq_printf(seq, "   data:");
 			if (j > 20)
 				j = 20;
 			for (i = 0; i < j; i++)
-				out += sprintf(out, " %02x", (unsigned)((unsigned char *)rd->buf)[i]);
-			out += sprintf(out, "\n");
+				seq_printf(seq, " %02x", (unsigned)((unsigned char *)rd->buf)[i]);
+			seq_printf(seq, "\n");
 		}
 	}
 	for (i = 0; i < r->size; i++) {
 		rd = &r->rd[i];
-		out += sprintf(out, "> ring descr %u: ", i);
-		out += sprintf(out, "skb=%p data=%p hw=%p\n", rd->skb, rd->buf, rd->hw);
-		out += sprintf(out, "  hw: status=%02x count=%u busaddr=0x%08x\n",
+		seq_printf(seq, "> ring descr %u: ", i);
+		seq_printf(seq, "skb=%p data=%p hw=%p\n", rd->skb, rd->buf, rd->hw);
+		seq_printf(seq, "  hw: status=%02x count=%u busaddr=0x%08x\n",
 			(unsigned) rd_get_status(rd),
 			(unsigned) rd_get_count(rd), (unsigned) rd_get_addr(rd));
 	}
-	return out - buf;
 }
 
-static int vlsi_proc_print(struct net_device *ndev, char *buf, int len)
+static int vlsi_seq_show(struct seq_file *seq, void *v)
 {
-	vlsi_irda_dev_t *idev;
+	struct net_device *ndev = seq->private;
+	vlsi_irda_dev_t *idev = ndev->priv;
 	unsigned long flags;
-	char *out = buf;
-
-	if (!ndev || !ndev->priv) {
-		ERROR("%s: invalid ptr!\n", __FUNCTION__);
-		return 0;
-	}
-
-	idev = ndev->priv;
 
-	if (len < 8000)
-		return 0;
-
-	out += sprintf(out, "\n%s %s\n\n", DRIVER_NAME, DRIVER_VERSION);
-	out += sprintf(out, "clksrc: %s\n", 
+	seq_printf(seq, "\n%s %s\n\n", DRIVER_NAME, DRIVER_VERSION);
+	seq_printf(seq, "clksrc: %s\n", 
 		(clksrc>=2) ? ((clksrc==3)?"40MHz XCLK":"48MHz XCLK")
 			    : ((clksrc==1)?"48MHz PLL":"autodetect"));
-	out += sprintf(out, "ringsize: tx=%d / rx=%d\n",
+	seq_printf(seq, "ringsize: tx=%d / rx=%d\n",
 		ringsize[0], ringsize[1]);
-	out += sprintf(out, "sirpulse: %s\n", (sirpulse)?"3/16 bittime":"short");
-	out += sprintf(out, "qos_mtt_bits: 0x%02x\n", (unsigned)qos_mtt_bits);
+	seq_printf(seq, "sirpulse: %s\n", (sirpulse)?"3/16 bittime":"short");
+	seq_printf(seq, "qos_mtt_bits: 0x%02x\n", (unsigned)qos_mtt_bits);
 
 	spin_lock_irqsave(&idev->lock, flags);
 	if (idev->pdev != NULL) {
-		out += vlsi_proc_pdev(idev->pdev, out, len - (out-buf));
+		vlsi_proc_pdev(seq, idev->pdev);
+
 		if (idev->pdev->current_state == 0)
-			out += vlsi_proc_ndev(ndev, out, len - (out-buf));
+			vlsi_proc_ndev(seq, ndev);
 		else
-			out += sprintf(out, "\nPCI controller down - resume_ok = %d\n",
+			seq_printf(seq, "\nPCI controller down - resume_ok = %d\n",
 				idev->resume_ok);
 		if (netif_running(ndev) && idev->rx_ring && idev->tx_ring) {
-			out += sprintf(out, "\n--------- RX ring -----------\n\n");
-			out += vlsi_proc_ring(idev->rx_ring, out, len - (out-buf));
-			out += sprintf(out, "\n--------- TX ring -----------\n\n");
-			out += vlsi_proc_ring(idev->tx_ring, out, len - (out-buf));
+			seq_printf(seq, "\n--------- RX ring -----------\n\n");
+			vlsi_proc_ring(seq, idev->rx_ring);
+			seq_printf(seq, "\n--------- TX ring -----------\n\n");
+			vlsi_proc_ring(seq, idev->tx_ring);
 		}
 	}
-	out += sprintf(out, "\n");
+	seq_printf(seq, "\n");
 	spin_unlock_irqrestore(&idev->lock, flags);
 
-	return out - buf;
-}
-
-struct vlsi_proc_data {
-	int size;
-	char *data;
-};
-
-/* most of the proc-fops code borrowed from usb/uhci */
-
-static int vlsi_proc_open(struct inode *inode, struct file *file)
-{
-	const struct proc_dir_entry *pde = PDE(inode);
-	struct net_device *ndev = pde->data;
-	vlsi_irda_dev_t *idev = ndev->priv;
-	struct vlsi_proc_data *procdata;
-	const int maxdata = 8000;
-
-	lock_kernel();
-	procdata = kmalloc(sizeof(*procdata), GFP_KERNEL);
-	if (!procdata) {
-		unlock_kernel();
-		return -ENOMEM;
-	}
-	procdata->data = kmalloc(maxdata, GFP_KERNEL);
-	if (!procdata->data) {
-		kfree(procdata);
-		unlock_kernel();
-		return -ENOMEM;
-	}
-
-	down(&idev->sem);
-	procdata->size = vlsi_proc_print(ndev, procdata->data, maxdata);
-	up(&idev->sem);
-
-	file->private_data = procdata;
-
 	return 0;
 }
 
-static loff_t vlsi_proc_lseek(struct file *file, loff_t off, int whence)
-{
-	struct vlsi_proc_data *procdata;
-	loff_t new = -1;
-
-	lock_kernel();
-	procdata = file->private_data;
-
-	switch (whence) {
-	case 0:
-		new = off;
-		break;
-	case 1:
-		new = file->f_pos + off;
-		break;
-	}
-	if (new < 0 || new > procdata->size) {
-		unlock_kernel();
-		return -EINVAL;
-	}
-	unlock_kernel();
-	return (file->f_pos = new);
-}
-
-static ssize_t vlsi_proc_read(struct file *file, char *buf, size_t nbytes,
-			loff_t *ppos)
-{
-	struct vlsi_proc_data *procdata = file->private_data;
-	unsigned int pos;
-	unsigned int size;
-
-	pos = *ppos;
-	size = procdata->size;
-	if (pos >= size)
-		return 0;
-	if (nbytes >= size)
-		nbytes = size;
-	if (pos + nbytes > size)
-		nbytes = size - pos;
-
-	if (copy_to_user(buf, procdata->data + pos, nbytes))
-		return -EFAULT;
-
-	*ppos += nbytes;
-
-	return nbytes;
-}
-
-static int vlsi_proc_release(struct inode *inode, struct file *file)
+static int vlsi_seq_open(struct inode *inode, struct file *file)
 {
-	struct vlsi_proc_data *procdata = file->private_data;
-
-	kfree(procdata->data);
-	kfree(procdata);
-
-	return 0;
+	return single_open(file, vlsi_seq_show, PDE(inode)->data);
 }
 
 static struct file_operations vlsi_proc_fops = {
-	/* protect individual procdir file entry against rmmod */
-	.owner		= THIS_MODULE,
-	.open		= vlsi_proc_open,
-	.llseek		= vlsi_proc_lseek,
-	.read		= vlsi_proc_read,
-	.release	= vlsi_proc_release,
+	.owner	 = THIS_MODULE,
+	.open    = vlsi_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
 };
 
 #define VLSI_PROC_FOPS		(&vlsi_proc_fops)
@@ -1787,13 +1674,12 @@ vlsi_irda_probe(struct pci_dev *pdev, co
 		ent = create_proc_entry(ndev->name, S_IFREG|S_IRUGO, vlsi_proc_root);
 		if (!ent) {
 			WARNING("%s: failed to create proc entry\n", __FUNCTION__);
-		}
-		else {
+		} else {
 			ent->data = ndev;
 			ent->proc_fops = VLSI_PROC_FOPS;
 			ent->size = 0;
-			idev->proc_entry = ent;
 		}
+		idev->proc_entry = ent;
 	}
 	MESSAGE("%s: registered device %s\n", drivername, ndev->name);
 
