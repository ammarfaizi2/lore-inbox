Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319344AbSH2VtF>; Thu, 29 Aug 2002 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSH2VtF>; Thu, 29 Aug 2002 17:49:05 -0400
Received: from smtpout.mac.com ([204.179.120.89]:23747 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319344AbSH2VtA>;
	Thu, 29 Aug 2002 17:49:00 -0400
Message-Id: <200208292153.g7TLrNZH003425@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 1/41 sound/oss/maestro3.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of a series of patches against 2.5.32 
converting almost all remaining OSS sound drivers to use 
spin_lock_irqsave&co instead of cli() which is nowadays
gone when compiling for SMP.

The more complicated ones were:
dmabuf.c
maestro3.c
ad1848.c

I hope I haven't broken anything - but I think some of the
drivers are simply not SMP safe.
One day OSS and some of the older soundcards are obsolete - so what?


--- vanilla-2.5.32/sound/oss/maestro3.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/maestro3.c	Tue Aug 13 18:38:15 2002
@@ -199,8 +199,11 @@
     int index;
 
     /* this locks around the oss state in the driver */
-    spinlock_t lock;
-
+	/* no, this lock is removed - only use card->lock */
+	/* otherwise: against what are you protecting on SMP 
+		when irqhandler uses s->lock
+		and m3_assp_read uses card->lock ?
+		*/
     struct semaphore open_sem;
     wait_queue_head_t open_wait;
     mode_t open_mode;
@@ -1066,8 +1069,6 @@
 
 }
 
-static void m3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-
 static int 
 prog_dmabuf(struct m3_state *s, unsigned rec)
 {
@@ -1078,7 +1079,7 @@
     unsigned char fmt;
     unsigned long flags;
 
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&s->card->lock, flags);
 
     fmt = s->fmt;
     if (rec) {
@@ -1126,7 +1127,7 @@
 
     db->ready = 1;
 
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&s->card->lock, flags);
 
     return 0;
 }
@@ -1250,9 +1251,9 @@
             if(ctl & DSP2HOST_REQ_TIMER) {
                 outb( DSP2HOST_REQ_TIMER, c->iobase + ASSP_HOST_INT_STATUS);
                 /* update adc/dac info if it was a timer int */
-                spin_lock(&s->lock);
+                spin_lock(&c->lock);
                 m3_update_ptr(s);
-                spin_unlock(&s->lock);
+                spin_unlock(&c->lock);
             }
         }
     }
@@ -1292,9 +1293,9 @@
     set_current_state(TASK_INTERRUPTIBLE);
     add_wait_queue(&s->dma_dac.wait, &wait);
     for (;;) {
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&s->card->lock, flags);
         count = s->dma_dac.count;
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&s->card->lock, flags);
         if (count <= 0)
             break;
         if (signal_pending(current))
@@ -1337,7 +1338,7 @@
         return -EFAULT;
     ret = 0;
 
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&s->card->lock, flags);
 
     while (count > 0) {
         int timed_out;
@@ -1358,9 +1359,9 @@
                 goto out;
             }
 
-            spin_unlock_irqrestore(&s->lock, flags);
+            spin_unlock_irqrestore(&s->card->lock, flags);
             timed_out = interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ) == 0;
-            spin_lock_irqsave(&s->lock, flags);
+            spin_lock_irqsave(&s->card->lock, flags);
 
             if(timed_out) {
                 printk("read: chip lockup? dmasz %u fragsz %u count %u hwptr %u swptr %u\n",
@@ -1378,12 +1379,12 @@
             continue;
         }
     
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&s->card->lock, flags);
         if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt)) {
             ret = ret ? ret : -EFAULT;
             return ret;
         }
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&s->card->lock, flags);
 
         swptr = (swptr + cnt) % s->dma_adc.dmasize;
         s->dma_adc.swptr = swptr;
@@ -1395,7 +1396,7 @@
     }
 
 out:
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&s->card->lock, flags);
     return ret;
 }
 
@@ -1418,7 +1419,7 @@
         return -EFAULT;
     ret = 0;
 
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&s->card->lock, flags);
 
     while (count > 0) {
         int timed_out;
@@ -1444,9 +1445,9 @@
                 if(!ret) ret = -EAGAIN;
                 goto out;
             }
-            spin_unlock_irqrestore(&s->lock, flags);
+            spin_unlock_irqrestore(&s->card->lock, flags);
             timed_out = interruptible_sleep_on_timeout(&s->dma_dac.wait, HZ) == 0;
-            spin_lock_irqsave(&s->lock, flags);
+            spin_lock_irqsave(&s->card->lock, flags);
             if(timed_out) {
                 DPRINTK(DPCRAP,"write: chip lockup? dmasz %u fragsz %u count %u hwptr %u swptr %u\n",
                        s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count, 
@@ -1461,12 +1462,12 @@
             }
             continue;
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&s->card->lock, flags);
         if (copy_from_user(s->dma_dac.rawbuf + swptr, buffer, cnt)) {
             if (!ret) ret = -EFAULT;
             return ret;
         }
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&s->card->lock, flags);
 
         DPRINTK(DPSYS,"wrote %6d bytes at sw: %6d cnt: %6d while hw: %6d\n",
                 cnt, swptr, s->dma_dac.count, s->dma_dac.hwptr);
@@ -1482,7 +1483,7 @@
         start_dac(s);
     }
 out:
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&s->card->lock, flags);
     return ret;
 }
 
@@ -1498,7 +1499,7 @@
     if (file->f_mode & FMODE_READ)
         poll_wait(file, &s->dma_adc.wait, wait);
 
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&s->card->lock, flags);
     m3_update_ptr(s);
 
     if (file->f_mode & FMODE_READ) {
@@ -1515,7 +1516,7 @@
         }
     }
 
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&s->card->lock, flags);
     return mask;
 }
 
@@ -1572,6 +1573,7 @@
 static int m3_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
     struct m3_state *s = (struct m3_state *)file->private_data;
+	struct m3_card *card=s->card;
     unsigned long flags;
     audio_buf_info abinfo;
     count_info cinfo;
@@ -1602,23 +1604,23 @@
         return put_user(DSP_CAP_DUPLEX | DSP_CAP_REALTIME | DSP_CAP_TRIGGER | DSP_CAP_MMAP, (int *)arg);
         
     case SNDCTL_DSP_RESET:
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         if (file->f_mode & FMODE_WRITE) {
             stop_dac(s);
-            synchronize_irq();
+            synchronize_irq(s->card->pcidev->irq);
             s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
         }
         if (file->f_mode & FMODE_READ) {
             stop_adc(s);
-            synchronize_irq();
+            synchronize_irq(s->card->pcidev->irq);
             s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return 0;
 
     case SNDCTL_DSP_SPEED:
         get_user_ret(val, (int *)arg, -EFAULT);
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         if (val >= 0) {
             if (file->f_mode & FMODE_READ) {
                 stop_adc(s);
@@ -1631,12 +1633,12 @@
                 set_dac_rate(s, val);
             }
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return put_user((file->f_mode & FMODE_READ) ? s->rateadc : s->ratedac, (int *)arg);
         
     case SNDCTL_DSP_STEREO:
         get_user_ret(val, (int *)arg, -EFAULT);
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         fmtd = 0;
         fmtm = ~0;
         if (file->f_mode & FMODE_READ) {
@@ -1656,12 +1658,12 @@
                 fmtm &= ~(ESS_FMT_STEREO << ESS_DAC_SHIFT);
         }
         set_fmt(s, fmtm, fmtd);
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return 0;
 
     case SNDCTL_DSP_CHANNELS:
         get_user_ret(val, (int *)arg, -EFAULT);
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         if (val != 0) {
             fmtd = 0;
             fmtm = ~0;
@@ -1683,7 +1685,7 @@
             }
             set_fmt(s, fmtm, fmtd);
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return put_user((s->fmt & ((file->f_mode & FMODE_READ) ? (ESS_FMT_STEREO << ESS_ADC_SHIFT) 
                        : (ESS_FMT_STEREO << ESS_DAC_SHIFT))) ? 2 : 1, (int *)arg);
         
@@ -1692,7 +1694,7 @@
         
     case SNDCTL_DSP_SETFMT: /* Selects ONE fmt*/
         get_user_ret(val, (int *)arg, -EFAULT);
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         if (val != AFMT_QUERY) {
             fmtd = 0;
             fmtm = ~0;
@@ -1714,7 +1716,7 @@
             }
             set_fmt(s, fmtm, fmtd);
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return put_user((s->fmt & ((file->f_mode & FMODE_READ) ? 
             (ESS_FMT_16BIT << ESS_ADC_SHIFT) 
             : (ESS_FMT_16BIT << ESS_DAC_SHIFT))) ? 
@@ -1758,13 +1760,13 @@
             return -EINVAL;
         if (!(s->enable & DAC_RUNNING) && (val = prog_dmabuf(s, 0)) != 0)
             return val;
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         m3_update_ptr(s);
         abinfo.fragsize = s->dma_dac.fragsize;
         abinfo.bytes = s->dma_dac.dmasize - s->dma_dac.count;
         abinfo.fragstotal = s->dma_dac.numfrag;
         abinfo.fragments = abinfo.bytes >> s->dma_dac.fragshift;      
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
 
     case SNDCTL_DSP_GETISPACE:
@@ -1772,13 +1774,13 @@
             return -EINVAL;
         if (!(s->enable & ADC_RUNNING) && (val = prog_dmabuf(s, 1)) != 0)
             return val;
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         m3_update_ptr(s);
         abinfo.fragsize = s->dma_adc.fragsize;
         abinfo.bytes = s->dma_adc.count;
         abinfo.fragstotal = s->dma_adc.numfrag;
         abinfo.fragments = abinfo.bytes >> s->dma_adc.fragshift;      
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
         
     case SNDCTL_DSP_NONBLOCK:
@@ -1788,23 +1790,23 @@
     case SNDCTL_DSP_GETODELAY:
         if (!(file->f_mode & FMODE_WRITE))
             return -EINVAL;
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         m3_update_ptr(s);
         val = s->dma_dac.count;
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return put_user(val, (int *)arg);
 
     case SNDCTL_DSP_GETIPTR:
         if (!(file->f_mode & FMODE_READ))
             return -EINVAL;
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         m3_update_ptr(s);
         cinfo.bytes = s->dma_adc.total_bytes;
         cinfo.blocks = s->dma_adc.count >> s->dma_adc.fragshift;
         cinfo.ptr = s->dma_adc.hwptr;
         if (s->dma_adc.mapped)
             s->dma_adc.count &= s->dma_adc.fragsize-1;
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
 		return -EFAULT;
 	return 0;
@@ -1812,14 +1814,14 @@
     case SNDCTL_DSP_GETOPTR:
         if (!(file->f_mode & FMODE_WRITE))
             return -EINVAL;
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         m3_update_ptr(s);
         cinfo.bytes = s->dma_dac.total_bytes;
         cinfo.blocks = s->dma_dac.count >> s->dma_dac.fragshift;
         cinfo.ptr = s->dma_dac.hwptr;
         if (s->dma_dac.mapped)
             s->dma_dac.count &= s->dma_dac.fragsize-1;
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
 		return -EFAULT;
 	return 0;
@@ -1836,7 +1838,7 @@
 
     case SNDCTL_DSP_SETFRAGMENT:
         get_user_ret(val, (int *)arg, -EFAULT);
-        spin_lock_irqsave(&s->lock, flags);
+        spin_lock_irqsave(&card->lock, flags);
         if (file->f_mode & FMODE_READ) {
             s->dma_adc.ossfragshift = val & 0xffff;
             s->dma_adc.ossmaxfrags = (val >> 16) & 0xffff;
@@ -1857,7 +1859,7 @@
             if (s->dma_dac.ossmaxfrags < 4)
                 s->dma_dac.ossmaxfrags = 4;
         }
-        spin_unlock_irqrestore(&s->lock, flags);
+        spin_unlock_irqrestore(&card->lock, flags);
         return 0;
 
     case SNDCTL_DSP_SUBDIVIDE:
@@ -2019,7 +2021,7 @@
         down(&s->open_sem);
     }
     
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&c->lock, flags);
 
     if (file->f_mode & FMODE_READ) {
         fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_ADC_SHIFT);
@@ -2041,13 +2043,14 @@
     s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 
     up(&s->open_sem);
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&c->lock, flags);
     return 0;
 }
 
 static int m3_release(struct inode *inode, struct file *file)
 {
     struct m3_state *s = (struct m3_state *)file->private_data;
+	struct m3_card *card=s->card;
     unsigned long flags;
 
     VALIDATE_STATE(s);
@@ -2055,7 +2058,7 @@
         drain_dac(s, file->f_flags & O_NONBLOCK);
 
     down(&s->open_sem);
-    spin_lock_irqsave(&s->lock, flags);
+    spin_lock_irqsave(&card->lock, flags);
 
     if (file->f_mode & FMODE_WRITE) {
         stop_dac(s);
@@ -2074,7 +2077,7 @@
         
     s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
 
-    spin_unlock_irqrestore(&s->lock, flags);
+    spin_unlock_irqrestore(&card->lock, flags);
     up(&s->open_sem);
     wake_up(&s->open_wait);
 
@@ -2666,7 +2669,6 @@
         init_waitqueue_head(&s->dma_adc.wait);
         init_waitqueue_head(&s->dma_dac.wait);
         init_waitqueue_head(&s->open_wait);
-        spin_lock_init(&s->lock);
         init_MUTEX(&(s->open_sem));
         s->magic = M3_STATE_MAGIC;
 
@@ -2777,8 +2779,7 @@
     struct m3_card *card = pci_get_drvdata(pci_dev);
 
     /* must be a better way.. */
-    save_flags(flags);
-    cli();
+	spin_lock_irqsave(&card->lock, flags);
 
     DPRINTK(DPMOD, "pm in dev %p\n",card);
 
@@ -2816,7 +2817,7 @@
 
     card->in_suspend = 1;
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&card->lock, flags);
 
     return 0;
 }
@@ -2828,8 +2829,7 @@
     int i;
     struct m3_card *card = pci_get_drvdata(pci_dev);
 
-    save_flags(flags); /* paranoia */
-    cli();
+	spin_lock_irqsave(&card->lock, flags);
     card->in_suspend = 0;
 
     DPRINTK(DPMOD, "resuming\n");
@@ -2892,7 +2892,7 @@
         start_adc(s);    
     }
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&card->lock, flags);
 
     /* 
      * all right, we think things are ready, 

