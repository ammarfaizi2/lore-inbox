Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRB1PRW>; Wed, 28 Feb 2001 10:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRB1PRP>; Wed, 28 Feb 2001 10:17:15 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:24326 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130216AbRB1PRE>;
	Wed, 28 Feb 2001 10:17:04 -0500
Date: Wed, 28 Feb 2001 10:17:01 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Cc: maestro-users@zabbo.net
Subject: [PATCH] maestro3 2.4.2 pci dma address fix
Message-ID: <20010228101701.H23735@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the maestro3 can't DMA from mem above 256M.   Thanks to
everyone who sent in bug reports that lead us to discover this.. 

this patch fixes that and also allocates memory at driver init time
rather than at device open time..

please apply with wild abandon.

-- 
 zach

--- linux-2.4.2/drivers/sound/maestro3.c.dma	Wed Feb 28 09:22:18 2001
+++ linux-2.4.2/drivers/sound/maestro3.c	Wed Feb 28 10:10:07 2001
@@ -28,6 +28,9 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.22 - Feb 28 2001 - Zach Brown <zab@zabbo.net>
+ *   allocate mem at insmod/setup, rather than open
+ *   limit pci dma addresses to 28bit, thanks guys.
  *  v1.21 - Feb 04 2001 - Zach Brown <zab@zabbo.net>
  *   fix up really dumb notifier -> suspend oops
  *  v1.20 - Jan 30 2001 - Zach Brown <zab@zabbo.net>
@@ -150,7 +153,7 @@
 
 #define M_DEBUG 1
 
-#define DRIVER_VERSION      "1.21"
+#define DRIVER_VERSION      "1.22"
 #define M3_MODULE_NAME      "maestro3"
 #define PFX                 M3_MODULE_NAME ": "
 
@@ -330,6 +333,12 @@
 
 MODULE_DEVICE_TABLE (pci, m3_id_table);
 
+/*
+ * reports seem to indicate that the m3 is limited
+ * to 28bit bus addresses.  aaaargggh...
+ */
+#define M3_PCI_DMA_MASK 0x0fffffff
+
 static unsigned 
 ld2(unsigned int x)
 {
@@ -1943,6 +1952,9 @@
 static void
 free_dmabuf(struct pci_dev *pci_dev, struct dmabuf *db)
 {
+    if(db->rawbuf == NULL)
+        return;
+
     DPRINTK(DPSTR,"freeing %p from dmabuf %p\n",db->rawbuf, db);
 
     {
@@ -1967,7 +1979,7 @@
     int minor = MINOR(inode->i_rdev);
     struct m3_card *c;
     struct m3_state *s = NULL;
-    int i, ret = 0;
+    int i;
     unsigned char fmtm = ~0, fmts = 0;
     unsigned long flags;
 
@@ -2013,10 +2025,6 @@
     spin_lock_irqsave(&s->lock, flags);
 
     if (file->f_mode & FMODE_READ) {
-        if(allocate_dmabuf(s->card->pcidev, &(s->dma_adc)))  {
-            ret = -ENOMEM;
-            goto out;
-        }
         fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_ADC_SHIFT);
         if ((minor & 0xf) == SND_DEV_DSP16)
             fmts |= ESS_FMT_16BIT << ESS_ADC_SHIFT; 
@@ -2025,10 +2033,6 @@
         set_adc_rate(s, 8000);
     }
     if (file->f_mode & FMODE_WRITE) {
-        if(allocate_dmabuf(s->card->pcidev, &(s->dma_dac)))  {
-            ret = -ENOMEM;
-            goto out;
-        }
         fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_DAC_SHIFT);
         if ((minor & 0xf) == SND_DEV_DSP16)
             fmts |= ESS_FMT_16BIT << ESS_DAC_SHIFT;
@@ -2040,7 +2044,6 @@
     s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 
     MOD_INC_USE_COUNT;
-out:
     up(&s->open_sem);
     spin_unlock_irqrestore(&s->lock, flags);
     return 0;
@@ -2064,7 +2067,6 @@
             m3_remove_list(s->card, &(s->card->mixer_list), s->dma_dac.mixer_index);
             nuke_lists(s->card, &(s->dma_dac));
         }
-        free_dmabuf(s->card->pcidev, &(s->dma_dac));
     }
     if (file->f_mode & FMODE_READ) {
         stop_adc(s);
@@ -2072,7 +2074,6 @@
             m3_remove_list(s->card, &(s->card->adc1_list), s->dma_adc.adc1_index);
             nuke_lists(s->card, &(s->dma_adc));
         }
-        free_dmabuf(s->card->pcidev, &(s->dma_adc));
     }
         
     s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
@@ -2594,8 +2595,8 @@
 
     DPRINTK(DPMOD, "in maestro_install\n");
 
-    if (!pci_dma_supported(pci_dev, 0xffffffff)) {
-        printk(KERN_ERR PFX "architecture does not support 32bit PCI busmaster DMA\n");
+    if (!pci_dma_supported(pci_dev, M3_PCI_DMA_MASK)) {
+        printk(KERN_ERR PFX "architecture does not support limiting to 28bit PCI bus addresses\n");
         return -ENODEV;
     }
         
@@ -2604,6 +2605,8 @@
 
     pci_set_master(pci_dev);
 
+    pci_dev->dma_mask = M3_PCI_DMA_MASK;
+
     if( (card = kmalloc(sizeof(struct m3_card), GFP_KERNEL)) == NULL) {
         printk(KERN_WARNING PFX "out of memory\n");
         return -ENOMEM;
@@ -2681,6 +2684,12 @@
         if ((s->dev_audio = register_sound_dsp(&m3_audio_fops, -1)) < 0) {
             break;
         }
+
+        if( allocate_dmabuf(card->pcidev, &(s->dma_adc)) ||
+                allocate_dmabuf(card->pcidev, &(s->dma_dac)))  { 
+            ret = -ENOMEM;
+            goto out;
+        }
     }
     
     if(request_irq(card->irq, m3_interrupt, SA_SHIRQ, card_names[card->card_type], card)) {
@@ -2734,8 +2743,12 @@
         for(i=0;i<NR_DSPS;i++)
         {
             struct m3_state *s = &card->channels[i];
-            if(s->dev_audio != -1)
-                unregister_sound_dsp(s->dev_audio);
+            if(s->dev_audio < 0)
+                continue;
+
+            unregister_sound_dsp(s->dev_audio);
+            free_dmabuf(card->pcidev, &s->dma_adc);
+            free_dmabuf(card->pcidev, &s->dma_dac);
         }
 
         release_region(card->iobase, 256);
