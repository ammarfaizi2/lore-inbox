Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbRFGULW>; Thu, 7 Jun 2001 16:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbRFGULN>; Thu, 7 Jun 2001 16:11:13 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10161 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263058AbRFGUK5>;
	Thu, 7 Jun 2001 16:10:57 -0400
Message-ID: <3B1FDFCA.C76AE063@mandrakesoft.com>
Date: Thu, 07 Jun 2001 16:10:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-via@gtf.org
Subject: PATCH: via audio 1.1.15-pre1
Content-Type: multipart/mixed;
 boundary="------------6B6658E9390F2079982C3562"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B6658E9390F2079982C3562
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch against kernel 2.4.6-pre1 which includes fixes for
via audio.  It -should- patch against kernel 2.4.3 or later, though.

I'm interested in feedback from people having via audio problems, if
this patch fixes them.  I am of course also interested in general
testing, to ensure I did not break anything in the process of fixing
things.  :)

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------6B6658E9390F2079982C3562
Content-Type: text/plain; charset=us-ascii;
 name="via-pre1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-pre1.patch"

Index: linux_2_4/drivers/sound/via82cxxx_audio.c
diff -u linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.19 linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.19.2.2
--- linux_2_4/drivers/sound/via82cxxx_audio.c:1.1.1.19	Mon Jun  4 19:43:41 2001
+++ linux_2_4/drivers/sound/via82cxxx_audio.c	Thu Jun  7 13:04:28 2001
@@ -15,7 +15,7 @@
  */
 
 
-#define VIA_VERSION	"1.1.14b"
+#define VIA_VERSION	"1.1.15-pre1"
 
 
 #include <linux/config.h>
@@ -92,6 +92,7 @@
 #endif
 
 /* 82C686 function 5 (audio codec) PCI configuration registers */
+#define VIA_ACLINK_STATUS	0x40
 #define VIA_ACLINK_CTRL		0x41
 #define VIA_FUNC_ENABLE		0x42
 #define VIA_PNP_CONTROL		0x43
@@ -187,6 +188,7 @@
 /* controller base 0 register bitmasks */
 #define VIA_INT_DISABLE_MASK		(~(0x01|0x02))
 #define VIA_SGD_STOPPED			(1 << 2)
+#define VIA_SGD_PAUSED			(1 << 6)
 #define VIA_SGD_ACTIVE			(1 << 7)
 #define VIA_SGD_TERMINATE		(1 << 6)
 #define VIA_SGD_FLAG			(1 << 0)
@@ -381,7 +383,7 @@
  *
  */
 
-static inline void via_chan_stop (int iobase)
+static inline void via_chan_stop (long iobase)
 {
 	if (inb (iobase + VIA_PCM_STATUS) & VIA_SGD_ACTIVE)
 		outb (VIA_SGD_TERMINATE, iobase + VIA_PCM_CONTROL);
@@ -402,7 +404,7 @@
  *
  */
 
-static inline void via_chan_status_clear (int iobase)
+static inline void via_chan_status_clear (long iobase)
 {
 	u8 tmp = inb (iobase + VIA_PCM_STATUS);
 
@@ -425,6 +427,19 @@
 }
 
 
+static int sg_active (long iobase)
+{
+	u8 tmp = inb (iobase + VIA_PCM_STATUS);
+	if ((tmp & VIA_SGD_STOPPED) || (tmp & VIA_SGD_PAUSED)) {
+		printk(KERN_WARNING "via82cxxx warning: SG stopped or paused\n");
+		return 0;
+	}
+	if (tmp & VIA_SGD_ACTIVE)
+		return 1;
+	return 0;
+}
+
+
 /****************************************************************
  *
  * Miscellaneous debris
@@ -467,6 +482,8 @@
 
 static void via_stop_everything (struct via_info *card)
 {
+	u8 tmp, new_tmp;
+	
 	DPRINTK ("ENTER\n");
 
 	assert (card != NULL);
@@ -486,11 +503,32 @@
 	via_chan_status_clear (card->baseaddr + VIA_BASE0_FM_OUT_CHAN);
 
 	/*
-	 * clear any enabled interrupt bits, reset to 8-bit mono PCM mode
+	 * clear any enabled interrupt bits
 	 */
-	outb (0, card->baseaddr + VIA_BASE0_PCM_OUT_CHAN_TYPE);
-	outb (0, card->baseaddr + VIA_BASE0_PCM_IN_CHAN_TYPE);
-	outb (0, card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE);
+	tmp = inb (card->baseaddr + VIA_BASE0_PCM_OUT_CHAN_TYPE);
+	new_tmp = tmp & ~(VIA_IRQ_ON_FLAG|VIA_IRQ_ON_EOL|VIA_RESTART_SGD_ON_EOL);
+	if (tmp != new_tmp)
+		outb (0, card->baseaddr + VIA_BASE0_PCM_OUT_CHAN_TYPE);
+
+	tmp = inb (card->baseaddr + VIA_BASE0_PCM_IN_CHAN_TYPE);
+	new_tmp = tmp & ~(VIA_IRQ_ON_FLAG|VIA_IRQ_ON_EOL|VIA_RESTART_SGD_ON_EOL);
+	if (tmp != new_tmp)
+		outb (0, card->baseaddr + VIA_BASE0_PCM_IN_CHAN_TYPE);
+
+	tmp = inb (card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE);
+	new_tmp = tmp & ~(VIA_IRQ_ON_FLAG|VIA_IRQ_ON_EOL|VIA_RESTART_SGD_ON_EOL);
+	if (tmp != new_tmp)
+		outb (0, card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE);
+
+	udelay(10);
+	
+	/*
+	 * clear any existing flags
+	 */
+	via_chan_status_clear (card->baseaddr + VIA_BASE0_PCM_OUT_CHAN);
+	via_chan_status_clear (card->baseaddr + VIA_BASE0_PCM_IN_CHAN);
+	via_chan_status_clear (card->baseaddr + VIA_BASE0_FM_OUT_CHAN);
+
 	DPRINTK ("EXIT\n");
 }
 
@@ -515,6 +553,8 @@
 
 	DPRINTK ("ENTER, rate = %d\n", rate);
 
+	if (chan->rate == rate)
+		goto out;
 	if (card->locked_rate) {
 		chan->rate = 48000;
 		goto out;
@@ -762,17 +802,17 @@
 {
 	DPRINTK ("ENTER\n");
 
-	synchronize_irq();
-
 	spin_lock_irq (&card->lock);
 
 	/* stop any existing channel output */
+	via_chan_status_clear (chan->iobase);
 	via_chan_stop (chan->iobase);
 	via_chan_status_clear (chan->iobase);
-	via_chan_pcm_fmt (chan, 1);
 
 	spin_unlock_irq (&card->lock);
 
+	synchronize_irq();
+
 	DPRINTK ("EXIT\n");
 }
 
@@ -840,7 +880,7 @@
 	/* if we are recording, enable recording fifo bit */
 	if (chan->is_record)
 		chan->pcm_fmt |= VIA_PCM_REC_FIFO;
-	/* set interrupt select bits where applicable (PCM & FM out channels) */
+	/* set interrupt select bits where applicable (PCM in & out channels) */
 	if (!chan->is_record)
 		chan->pcm_fmt |= VIA_CHAN_TYPE_INT_SELECT;
 
@@ -1142,6 +1182,8 @@
 
 static inline void via_chan_maybe_start (struct via_channel *chan)
 {
+	assert (chan->is_active == sg_active(chan->iobase));
+	
 	if (!chan->is_active && chan->is_enabled) {
 		chan->is_active = 1;
 		sg_begin (chan);
@@ -1405,20 +1447,43 @@
 #endif
 
         /*
-         * reset AC97 controller: enable, disable, enable
-         * pause after each command for good luck
+         * Reset AC97 controller: enable, disable, enable,
+         * pausing after each command for good luck.  Only
+	 * do this if the codec is not ready, because it causes
+	 * loud pops and such due to such a hard codec reset.
          */
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL, VIA_CR41_AC97_ENABLE |
-                               VIA_CR41_AC97_RESET | VIA_CR41_AC97_WAKEUP);
-        udelay (100);
-
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL, 0);
-        udelay (100);
-
-        pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
-			       VIA_CR41_AC97_ENABLE | VIA_CR41_PCM_ENABLE |
-                               VIA_CR41_VRA | VIA_CR41_AC97_RESET);
-        udelay (100);
+	pci_read_config_byte (pdev, VIA_ACLINK_STATUS, &tmp8);
+	if ((tmp8 & VIA_CR40_AC97_READY) == 0) {
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+                		       VIA_CR41_AC97_RESET |
+				       VIA_CR41_AC97_WAKEUP);
+        	udelay (100);
+
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL, 0);
+        	udelay (100);
+
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+				       VIA_CR41_PCM_ENABLE |
+                		       VIA_CR41_VRA | VIA_CR41_AC97_RESET);
+        	udelay (100);
+	}
+
+	/* Make sure VRA is enabled, in case we didn't do a
+	 * complete codec reset, above
+	 */
+	pci_read_config_byte (pdev, VIA_ACLINK_CTRL, &tmp8);
+	if (((tmp8 & VIA_CR41_VRA) == 0) ||
+	    ((tmp8 & VIA_CR41_AC97_ENABLE) == 0) ||
+	    ((tmp8 & VIA_CR41_PCM_ENABLE) == 0) ||
+	    ((tmp8 & VIA_CR41_AC97_RESET) == 0)) {
+        	pci_write_config_byte (pdev, VIA_ACLINK_CTRL,
+				       VIA_CR41_AC97_ENABLE |
+				       VIA_CR41_PCM_ENABLE |
+                		       VIA_CR41_VRA | VIA_CR41_AC97_RESET);
+        	udelay (100);
+	}
 
 #if 0 /* this breaks on K7M */
 	/* disable legacy stuff */
@@ -1435,20 +1500,10 @@
 
 	/* WARNING: this line is magic.  Remove this
 	 * and things break. */
-	/* enable variable rate, variable rate MIC ADC */
- 	/*
- 	 * If we cannot enable VRA, we have a locked-rate codec.
- 	 * We try again to enable VRA before assuming so, however.
- 	 */
+	/* enable variable rate */
  	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
- 	if ((tmp16 & 1) == 0) {
+ 	if ((tmp16 & 1) == 0)
  		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
- 		tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
- 		if ((tmp16 & 1) == 0) {
- 			card->locked_rate = 1;
- 			printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
- 		}
- 	}
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
@@ -1496,10 +1551,24 @@
 		goto err_out;
 	}
 
-	/* enable variable rate, variable rate MIC ADC */
+	/* enable variable rate */
 	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
 	via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
 
+ 	/*
+ 	 * If we cannot enable VRA, we have a locked-rate codec.
+ 	 * We try again to enable VRA before assuming so, however.
+ 	 */
+ 	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 	if ((tmp16 & 1) == 0) {
+ 		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+ 		tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 		if ((tmp16 & 1) == 0) {
+ 			card->locked_rate = 1;
+ 			printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
+ 		}
+ 	}
+
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
@@ -1649,47 +1718,6 @@
 
 
 /**
- *	via_interrupt_disable - Disable all interrupt-generating sources
- *	@card: Private info for specified board
- *
- *	Disables all interrupt-generation flags in the Via
- *	audio hardware registers.
- */
-
-static void via_interrupt_disable (struct via_info *card)
-{
-	u8 tmp8;
-	unsigned long flags;
-
-	DPRINTK ("ENTER\n");
-
-	assert (card != NULL);
-
-	spin_lock_irqsave (&card->lock, flags);
-
-	pci_read_config_byte (card->pdev, VIA_FM_NMI_CTRL, &tmp8);
-	if ((tmp8 & VIA_CR48_FM_TRAP_TO_NMI) == 0) {
-		tmp8 |= VIA_CR48_FM_TRAP_TO_NMI;
-		pci_write_config_byte (card->pdev, VIA_FM_NMI_CTRL, tmp8);
-	}
-
-	outb (inb (card->baseaddr + VIA_BASE0_PCM_OUT_CHAN_TYPE) &
-	      VIA_INT_DISABLE_MASK,
-	      card->baseaddr + VIA_BASE0_PCM_OUT_CHAN_TYPE);
-	outb (inb (card->baseaddr + VIA_BASE0_PCM_IN_CHAN_TYPE) &
-	      VIA_INT_DISABLE_MASK,
-	      card->baseaddr + VIA_BASE0_PCM_IN_CHAN_TYPE);
-	outb (inb (card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE) &
-	      VIA_INT_DISABLE_MASK,
-	      card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE);
-
-	spin_unlock_irqrestore (&card->lock, flags);
-
-	DPRINTK ("EXIT\n");
-}
-
-
-/**
  *	via_interrupt_init - Initialize interrupt handling
  *	@card: Private info for specified board
  *
@@ -1700,6 +1728,8 @@
 
 static int via_interrupt_init (struct via_info *card)
 {
+	u8 tmp8;
+
 	DPRINTK ("ENTER\n");
 
 	assert (card != NULL);
@@ -1713,6 +1743,13 @@
 		return -EIO;
 	}
 
+	/* make sure FM irq is not routed to us */
+	pci_read_config_byte (card->pdev, VIA_FM_NMI_CTRL, &tmp8);
+	if ((tmp8 & VIA_CR48_FM_TRAP_TO_NMI) == 0) {
+		tmp8 |= VIA_CR48_FM_TRAP_TO_NMI;
+		pci_write_config_byte (card->pdev, VIA_FM_NMI_CTRL, tmp8);
+	}
+
 	if (request_irq (card->pdev->irq, via_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
 		printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
 			card->pdev->irq);
@@ -1720,38 +1757,11 @@
 		return -EBUSY;
 	}
 
-	/* we don't want interrupts until we're opened */
-	via_interrupt_disable (card);
-
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 }
 
 
-/**
- *	via_interrupt_cleanup - Shutdown driver interrupt handling
- *	@card: Private info for specified board
- *
- *	Disable any potential interrupt sources in the Via audio
- *	hardware, and then release (un-reserve) the IRQ line
- *	in the kernel core.
- */
-
-static void via_interrupt_cleanup (struct via_info *card)
-{
-	DPRINTK ("ENTER\n");
-
-	assert (card != NULL);
-	assert (card->pdev != NULL);
-
-	via_interrupt_disable (card);
-
-	free_irq (card->pdev->irq, card);
-
-	DPRINTK ("EXIT\n");
-}
-
-
 /****************************************************************
  *
  * OSS DSP device
@@ -1983,17 +1993,16 @@
 	tmp = atomic_read (&chan->n_frags);
 	assert (tmp >= 0);
 	assert (tmp <= chan->frag_number);
-	while (tmp == 0) {
+	if (tmp == 0) {
+	    	int ret;
 		if (nonblock || !chan->is_active)
 			return -EAGAIN;
 
 		DPRINTK ("Sleeping on block %d\n", n);
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current))
-			return -ERESTARTSYS;
-
-		tmp = atomic_read (&chan->n_frags);
+		ret = wait_event_interruptible(chan->wait,
+				(tmp = atomic_read(&chan->n_frags)));
+		if (ret < 0)
+			return ret;
 	}
 
 	/* Now that we have a buffer we can read from, send
@@ -2001,10 +2010,12 @@
 	 */
 	while ((count > 0) && (chan->slop_len < chan->frag_size)) {
 		size_t slop_left = chan->frag_size - chan->slop_len;
+		void *base = chan->pgtbl[n / (PAGE_SIZE / chan->frag_size)].cpuaddr;
+		unsigned ofs = n % (PAGE_SIZE / chan->frag_size);
 
 		size = (count < slop_left) ? count : slop_left;
 		if (copy_to_user (userbuf,
-				  chan->pgtbl[n / (PAGE_SIZE / chan->frag_size)].cpuaddr + n % (PAGE_SIZE / chan->frag_size) + chan->slop_len,
+				  base + ofs + chan->slop_len,
 				  size))
 			return -EFAULT;
 
@@ -2130,17 +2141,16 @@
 	tmp = atomic_read (&chan->n_frags);
 	assert (tmp >= 0);
 	assert (tmp <= chan->frag_number);
-	while (tmp == 0) {
+	if (tmp == 0) {
+	    	int ret;
 		if (nonblock || !chan->is_enabled)
 			return -EAGAIN;
 
 		DPRINTK ("Sleeping on page %d, tmp==%d, ir==%d\n", n, tmp, chan->is_record);
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current))
-			return -ERESTARTSYS;
-
-		tmp = atomic_read (&chan->n_frags);
+		ret = wait_event_interruptible(chan->wait,
+				(tmp = atomic_read(&chan->n_frags)));
+		if (ret < 0)
+		    	return ret;
 	}
 
 	/* Now that we have at least one fragment we can write to, fill the buffer
@@ -2263,36 +2273,30 @@
 static unsigned int via_dsp_poll(struct file *file, struct poll_table_struct *wait)
 {
 	struct via_info *card;
-	unsigned int mask = 0, rd, wr;
+	struct via_channel *chan;
+	unsigned int mask = 0;
 
 	DPRINTK ("ENTER\n");
 
 	assert (file != NULL);
 	card = file->private_data;
 	assert (card != NULL);
-
-	rd = (file->f_mode & FMODE_READ);
-	wr = (file->f_mode & FMODE_WRITE);
 
-	if (wr && (atomic_read (&card->ch_out.n_frags) == 0)) {
-		assert (card->ch_out.is_active);
-                poll_wait(file, &card->ch_out.wait, wait);
-	}
-        if (rd) {
-		/* XXX is it ok, spec-wise, to start DMA here? */
-		if (!card->ch_in.is_active) {
-			via_chan_set_buffering(card, &card->ch_in, -1);
-			via_chan_buffer_init(card, &card->ch_in);
-		}
-		via_chan_maybe_start (&card->ch_in);
-		if (atomic_read (&card->ch_in.n_frags) == 0)
-	                poll_wait(file, &card->ch_in.wait, wait);
+	if (file->f_mode & FMODE_READ) {
+		chan = &card->ch_in;
+		if (sg_active (chan->iobase))
+	                poll_wait(file, &chan->wait, wait);
+		if (atomic_read (&chan->n_frags) > 0)
+			mask |= POLLIN | POLLRDNORM;
 	}
 
-	if (wr && ((atomic_read (&card->ch_out.n_frags) > 0) || !card->ch_out.is_active))
-		mask |= POLLOUT | POLLWRNORM;
-	if (rd && (atomic_read (&card->ch_in.n_frags) > 0))
-		mask |= POLLIN | POLLRDNORM;
+	if (file->f_mode & FMODE_WRITE) {
+		chan = &card->ch_out;
+		if (sg_active (chan->iobase))
+	                poll_wait(file, &chan->wait, wait);
+		if (atomic_read (&chan->n_frags) > 0)
+			mask |= POLLOUT | POLLWRNORM;
+	}
 
 	DPRINTK ("EXIT, returning %u\n", mask);
 	return mask;
@@ -2324,7 +2328,8 @@
 
 	via_chan_maybe_start (chan);
 
-	while (atomic_read (&chan->n_frags) < chan->frag_number) {
+	if (atomic_read (&chan->n_frags) < chan->frag_number) {
+	    	int ret;
 		if (nonblock) {
 			DPRINTK ("EXIT, returning -EAGAIN\n");
 			return -EAGAIN;
@@ -2357,11 +2362,11 @@
 #endif
 
 		DPRINTK ("sleeping, nbufs=%d\n", atomic_read (&chan->n_frags));
-		interruptible_sleep_on (&chan->wait);
-
-		if (signal_pending (current)) {
+		ret = wait_event_interruptible(chan->wait,
+			(atomic_read (&chan->n_frags) >= chan->frag_number));
+		if (ret < 0) {
 			DPRINTK ("EXIT, returning -ERESTARTSYS\n");
-			return -ERESTARTSYS;
+			return ret;
 		}
 	}
 
@@ -2950,7 +2955,7 @@
 				via_chan_pcm_fmt (chan, 0);
 				via_set_rate (&card->ac97, chan, 44100);
 			} else {
-				via_chan_pcm_fmt (chan, 0);
+				via_chan_pcm_fmt (chan, 1);
 				via_set_rate (&card->ac97, chan, 8000);
 			}
 		}
@@ -3020,25 +3024,19 @@
 	if (printed_version++ == 0)
 		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");
 
-	if (pci_enable_device (pdev)) {
-		rc = -EIO;
-		goto err_out_none;
-	}
-
-	if (!request_region (pci_resource_start (pdev, 0),
-	    		     pci_resource_len (pdev, 0),
-			     VIA_MODULE_NAME)) {
-		printk (KERN_ERR PFX "unable to obtain I/O resources, aborting\n");
-		rc = -EBUSY;
+	rc = pci_enable_device (pdev);
+	if (rc)
 		goto err_out;
-	}
 
+	rc = pci_request_regions (pdev, "via82cxxx_audio");
+	if (rc)
+		goto err_out;
 
 	card = kmalloc (sizeof (*card), GFP_KERNEL);
 	if (!card) {
 		printk (KERN_ERR PFX "out of memory, aborting\n");
 		rc = -ENOMEM;
-		goto err_out_none;
+		goto err_out_res;
 	}
 
 	pci_set_drvdata (pdev, card);
@@ -3143,8 +3128,8 @@
 #endif
 	kfree (card);
 
-err_out_none:
-	release_region (pci_resource_start (pdev, 0), pci_resource_len (pdev, 0));
+err_out_res:
+	pci_release_regions (pdev);
 err_out:
 	pci_set_drvdata (pdev, NULL);
 	DPRINTK ("EXIT - returning %d\n", rc);
@@ -3162,12 +3147,12 @@
 	card = pci_get_drvdata (pdev);
 	assert (card != NULL);
 
-	via_interrupt_cleanup (card);
+	free_irq (card->pdev->irq, card);
 	via_card_cleanup_proc (card);
 	via_dsp_cleanup (card);
 	via_ac97_cleanup (card);
 
-	release_region (pci_resource_start (pdev, 0), pci_resource_len (pdev, 0));
+	pci_release_regions (pdev);
 
 #ifndef VIA_NDEBUG
 	memset (card, 0xAB, sizeof (*card)); /* poison memory */

--------------6B6658E9390F2079982C3562--

