Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318475AbSHENxy>; Mon, 5 Aug 2002 09:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318486AbSHENxy>; Mon, 5 Aug 2002 09:53:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31757 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318475AbSHENxv>; Mon, 5 Aug 2002 09:53:51 -0400
Message-ID: <3D4E831B.30000@evision.ag>
Date: Mon, 05 Aug 2002 15:52:27 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.30 Maestro3
Content-Type: multipart/mixed;
 boundary="------------030000080401090606030204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030000080401090606030204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch is updating the Maestro3 OSS sound chip driver to

1. The changes in IRQ handline.

2. C99 standard conformant initializers.

Plese apply. (I happen to use such a chip...)

--------------030000080401090606030204
Content-Type: text/plain;
 name="maestro3-2.5.30.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maestro3-2.5.30.diff"

diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/sound/oss/maestro3.c linux/sound/oss/maestro3.c
--- linux-2.5.30/sound/oss/maestro3.c	2002-08-01 23:16:35.000000000 +0200
+++ linux/sound/oss/maestro3.c	2002-08-03 19:01:34.000000000 +0200
@@ -1605,12 +1605,12 @@ static int m3_ioctl(struct inode *inode,
         spin_lock_irqsave(&s->lock, flags);
         if (file->f_mode & FMODE_WRITE) {
             stop_dac(s);
-            synchronize_irq();
+            synchronize_irq(s->card->irq);
             s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
         }
         if (file->f_mode & FMODE_READ) {
             stop_adc(s);
-            synchronize_irq();
+            synchronize_irq(s->card->irq);
             s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
         }
         spin_unlock_irqrestore(&s->lock, flags);
@@ -2172,11 +2172,11 @@ static int m3_ioctl_mixdev(struct inode 
 }
 
 static struct file_operations m3_mixer_fops = {
-    owner:          THIS_MODULE,
-    llseek:         no_llseek,
-    ioctl:          m3_ioctl_mixdev,
-    open:           m3_open_mixdev,
-    release:        m3_release_mixdev,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .ioctl	= m3_ioctl_mixdev,
+    .open	= m3_open_mixdev,
+    .release	= m3_release_mixdev,
 };
 
 void remote_codec_config(int io, int isremote)
@@ -2546,15 +2546,15 @@ static void m3_enable_ints(struct m3_car
 }
 
 static struct file_operations m3_audio_fops = {
-    owner:      THIS_MODULE,
-    llseek:     &no_llseek,
-    read:       &m3_read,
-    write:      &m3_write,
-    poll:       &m3_poll,
-    ioctl:      &m3_ioctl,
-    mmap:       &m3_mmap,
-    open:       &m3_open,
-    release:    &m3_release,
+    .owner	= THIS_MODULE,
+    .llseek	= no_llseek,
+    .read	= m3_read,
+    .write	= m3_write,
+    .poll	= m3_poll,
+    .ioctl	= m3_ioctl,
+    .mmap	= m3_mmap,
+    .open	= m3_open,
+    .release	= m3_release,
 };
 
 #ifdef CONFIG_PM
@@ -2777,8 +2777,7 @@ static int m3_suspend(struct pci_dev *pc
     struct m3_card *card = pci_get_drvdata(pci_dev);
 
     /* must be a better way.. */
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
 
     DPRINTK(DPMOD, "pm in dev %p\n",card);
 
@@ -2816,7 +2815,7 @@ static int m3_suspend(struct pci_dev *pc
 
     card->in_suspend = 1;
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     return 0;
 }
@@ -2828,8 +2827,7 @@ static int m3_resume(struct pci_dev *pci
     int i;
     struct m3_card *card = pci_get_drvdata(pci_dev);
 
-    save_flags(flags); /* paranoia */
-    cli();
+    local_irq_save(flags); /* paranoia */
     card->in_suspend = 0;
 
     DPRINTK(DPMOD, "resuming\n");
@@ -2888,13 +2886,13 @@ static int m3_resume(struct pci_dev *pci
          * called unconditionally..
          */
         DPRINTK(DPMOD, "turning on dacs ind %d\n",i);
-        start_dac(s);    
-        start_adc(s);    
+        start_dac(s);
+        start_adc(s);
     }
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
-    /* 
+    /*
      * all right, we think things are ready, 
      * wake up people who were using the device 
      * when we suspended
@@ -2914,12 +2912,12 @@ MODULE_PARM(debug,"i");
 MODULE_PARM(external_amp,"i");
 
 static struct pci_driver m3_pci_driver = {
-    name:       "ess_m3_audio",
-    id_table:   m3_id_table,
-    probe:      m3_probe,
-    remove:     m3_remove,
-    suspend:    m3_suspend,
-    resume:     m3_resume,
+    .name	= "ess_m3_audio",
+    .id_table	= m3_id_table,
+    .probe	= m3_probe,
+    .remove	= m3_remove,
+    .suspend	= m3_suspend,
+    .resume	= m3_resume,
 };
 
 static int __init m3_init_module(void)

--------------030000080401090606030204--

