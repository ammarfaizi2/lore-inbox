Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263668AbRFFRIA>; Wed, 6 Jun 2001 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263655AbRFFRHv>; Wed, 6 Jun 2001 13:07:51 -0400
Received: from rmx460-mta.mail.com ([165.251.48.47]:31453 "EHLO
	rmx460-mta.mail.com") by vger.kernel.org with ESMTP
	id <S263653AbRFFRHj>; Wed, 6 Jun 2001 13:07:39 -0400
Message-ID: <383443482.991847258860.JavaMail.root@web395-wra.mail.com>
Date: Wed, 6 Jun 2001 13:07:33 -0400 (EDT)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: patches sound driver locking issue
CC: fdavis112@juno.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="383733383.991847253860.JavaMail.root@web395-wra.mail.com"
X-Mailer: mail.com
X-Originating-IP: 128.2.78.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--383733383.991847253860.JavaMail.root@web395-wra.mail.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all,
    I have attached patches against the following sound drivers to fix the locking issues mentioned in Alan's release notes for 2.4.5-ac9 . Please CC me on your comments to the code (I can address the issues quicker). Thanks.
drivers/sound/esssolo1.c
drivers/sound/maestro.c
drivers/sound/maestro3.c
drivers/sound/cmpci.c

Regards,
Frank


--383733383.991847253860.JavaMail.root@web395-wra.mail.com
Content-Type: text/plain; name=CMPCI_DI
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=CMPCI_DI
Content-ID: CMPCI_DI

--- drivers/sound/cmpci.c.old	Tue Jun  5 21:21:39 2001
+++ drivers/sound/cmpci.c	Tue Jun  5 23:20:41 2001
@@ -312,6 +312,7 @@
 	
 	/* spdif frame counter */
 	int	spdif_counter;
+	struct semaphore sem;
 };
 
 /* flags used for capability */
@@ -1653,7 +1654,7 @@
 static ssize_t cm_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
 	struct cm_state *s = (struct cm_state *)file->private_data;
-	ssize_t ret;
+	ssize_t ret = 0;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
@@ -1663,11 +1664,11 @@
 		return -ESPIPE;
 	if (s->dma_adc.mapped)
 		return -ENXIO;
-	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
-		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	ret = 0;
+	down(&s->sem);
+	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
+		goto out;
 #if 0
    spin_lock_irqsave(&s->lock, flags);
    cm_update_ptr(s);
@@ -1684,8 +1685,12 @@
 			cnt = count;
 		if (cnt <= 0) {
 			start_adc(s);
-			if (file->f_flags & O_NONBLOCK)
-				return ret ? ret : -EAGAIN;
+			if (file->f_flags & O_NONBLOCK)a
+			{
+				if(!ret) ret = -EAGAIN;
+				goto out;
+			}
+			up(&s->sem);
 			if (!interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ)) {
 				printk(KERN_DEBUG "cm: read: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_adc.dmasize, s->dma_adc.fragsize, s->dma_adc.count,
@@ -1698,12 +1703,24 @@
 				s->dma_adc.count = s->dma_adc.hwptr = s->dma_adc.swptr = 0;
 				spin_unlock_irqrestore(&s->lock, flags);
 			}
-			if (signal_pending(current))
-				return ret ? ret : -ERESTARTSYS;
+			if (signal_pending(current)) 
+			{
+				if(!ret) ret = -ERESTARTSYS;
+				goto out;
+			}
+			down(&s->sem);
+			if (s->dma_adc.mapped)
+			{
+				ret = -ENXIO;
+				goto out;
+			}
 			continue;
 		}
 		if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt))
-			return ret ? ret : -EFAULT;
+		{
+			if(!ret) ret = -EFAULT;
+			goto out;
+		}
 		swptr = (swptr + cnt) % s->dma_adc.dmasize;
 		spin_lock_irqsave(&s->lock, flags);
 		s->dma_adc.swptr = swptr;
@@ -1714,6 +1731,8 @@
 		start_adc_unlocked(s);
 		spin_unlock_irqrestore(&s->lock, flags);
 	}
+out:
+	up(&s->sem);
 	return ret;
 }
 
@@ -1730,18 +1749,20 @@
 		return -ESPIPE;
 	if (s->dma_dac.mapped)
 		return -ENXIO;
-	if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
-		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
 	if (s->status & DO_DUAL_DAC) {
 		if (s->dma_adc.mapped)
 			return -ENXIO;
-		if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
-			return ret;
 		if (!access_ok(VERIFY_READ, buffer, count))
 			return -EFAULT;
+	down(&s->sem);
+	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
+			goto out;
 	}
+	down(&s->sem);
+	if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+		goto out;
 	ret = 0;
 #if 0
    spin_lock_irqsave(&s->lock, flags);
@@ -1776,7 +1797,11 @@
 		if (cnt <= 0) {
 			start_dac(s);
 			if (file->f_flags & O_NONBLOCK)
-				return ret ? ret : -EAGAIN;
+			{
+				 if(!ret) ret = -EAGAIN;
+				 goto out;
+			}
+			up(&s->sem);
 			if (!interruptible_sleep_on_timeout(&s->dma_dac.wait, HZ)) {
 				printk(KERN_DEBUG "cm: write: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count,
@@ -1794,7 +1819,16 @@
 				spin_unlock_irqrestore(&s->lock, flags);
 			}
 			if (signal_pending(current))
-				return ret ? ret : -ERESTARTSYS;
+			{
+				if(!ret) ret = -ERESTARTSYS;
+				goto out;
+			}
+			down(&s->sem);
+			if (s->dma_dac.mapped)
+			{
+				ret = -ENXIO;
+				goto out;
+			}
 			continue;
 		}
 		if (s->status & DO_AC3_SW) {
@@ -1818,7 +1852,10 @@
 			swptr = (swptr + cnt) % s->dma_dac.dmasize;
 		} else {
 			if (copy_from_user(s->dma_dac.rawbuf + swptr, buffer, cnt))
-				return ret ? ret : -EFAULT;
+			{
+				if(!ret) ret = -EFAULT;
+				goto out;
+			}
 			swptr = (swptr + cnt) % s->dma_dac.dmasize;
 		}
 		spin_lock_irqsave(&s->lock, flags);
@@ -1838,6 +1875,8 @@
 		}
 		start_dac(s);
 	}
+out:
+	up(&s->sem);
 	return ret;
 }
 
@@ -1880,6 +1919,7 @@
 
 	VALIDATE_STATE(s);
 	lock_kernel();
+	down(&s->sem);
 	if (vma->vm_flags & VM_WRITE) {
 		if ((ret = prog_dmabuf(s, 0)) != 0)
 			goto out;
@@ -1888,20 +1928,24 @@
 		if ((ret = prog_dmabuf(s, 1)) != 0)
 			goto out;
 		db = &s->dma_adc;
-	} else
+	} else {
+		ret = -EINVAL;
 		goto out;
-	ret = -EINVAL;
+		}
 	if (vma->vm_pgoff != 0)
 		goto out;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
+	{
+		ret = -EINVAL;
 		goto out;
-	ret = -EINVAL;
+	}
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
 out:
+	up(&s->sem);
 	unlock_kernel();
 	return ret;
 }
@@ -3047,6 +3091,7 @@
 		init_waitqueue_head(&s->midi.iwait);
 		init_waitqueue_head(&s->midi.owait);
 		init_MUTEX(&s->open_sem);
+		init_MUTEX(&s->sem);
 		spin_lock_init(&s->lock);
 		s->magic = CM_MAGIC;
 		s->iobase = pci_resource_start(pcidev, 0);

--383733383.991847253860.JavaMail.root@web395-wra.mail.com
Content-Type: text/plain; name=MAESTRO_
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=MAESTRO_
Content-ID: MAESTRO_

--- drivers/sound/maestro.c.old	Tue Jun  5 21:21:43 2001
+++ drivers/sound/maestro.c	Tue Jun  5 23:44:41 2001
@@ -431,6 +431,7 @@
 
 	/* pointer to each dsp?s piece of the apu->src buffer page */
 	void *mixbuf;
+	struct semaphore sem;
 
 };
 	
@@ -2258,7 +2259,7 @@
 ess_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
 	struct ess_state *s = (struct ess_state *)file->private_data;
-	ssize_t ret;
+	ssize_t ret = 0; 
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
@@ -2269,13 +2270,13 @@
 		return -ESPIPE;
 	if (s->dma_adc.mapped)
 		return -ENXIO;
-	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
-		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
 	if(!(combbuf = kmalloc(count,GFP_KERNEL)))
 		return -ENOMEM;
-	ret = 0;
+	down(&s->sem);	
+	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
+		goto rec_return_free;
 
 	calc_bob_rate(s);
 
@@ -2298,9 +2299,10 @@
 			start_adc(s);
 			if (file->f_flags & O_NONBLOCK) 
 			{
-				ret = ret ? ret : -EAGAIN;
+				if(!ret) ret = -EAGAIN;
 				goto rec_return_free;
 			}
+			up(&s->sem);
 			if (!interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ)) {
 				if(! s->card->in_suspend) printk(KERN_DEBUG "maestro: read: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_adc.dmasize, s->dma_adc.fragsize, s->dma_adc.count, 
@@ -2317,7 +2319,13 @@
 			}
 			if (signal_pending(current)) 
 			{
-				ret = ret ? ret : -ERESTARTSYS;
+				if(!ret) ret = -ERESTARTSYS;
+				goto rec_return_free;
+			}
+			down(&s->sem);
+			if (s->dma_adc.mapped)
+			{
+				ret = -ENXIO;
 				goto rec_return_free;
 			}
 			continue;
@@ -2327,12 +2335,12 @@
 			/* swptr/2 so that we know the real offset in each apu's buffer */
 			comb_stereo(s->dma_adc.rawbuf,combbuf,swptr/2,cnt,s->dma_adc.dmasize);
 			if (copy_to_user(buffer, combbuf, cnt)) {
-				ret = ret ? ret : -EFAULT;
+				if(!ret) ret = -EFAULT;
 				goto rec_return_free;
 			}
 		} else  {
 			if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt)) {
-				ret = ret ? ret : -EFAULT;
+				if(!ret) ret = -EFAULT;
 				goto rec_return_free;
 			}
 		}
@@ -2349,6 +2357,7 @@
 	}
 
 rec_return_free:
+	up(&s->sem);
 	if(combbuf) kfree(combbuf);
 	return ret;
 }
@@ -2367,10 +2376,11 @@
 		return -ESPIPE;
 	if (s->dma_dac.mapped)
 		return -ENXIO;
-	if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
-		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
+	down(&s->sem);
+	if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+		goto return_free;
 	ret = 0;
 
 	calc_bob_rate(s);
@@ -2400,6 +2410,7 @@
 				if(!ret) ret = -EAGAIN;
 				goto return_free;
 			}
+			up(&s->sem);
 			if (!interruptible_sleep_on_timeout(&s->dma_dac.wait, HZ)) {
 				if(! s->card->in_suspend) printk(KERN_DEBUG "maestro: write: chip lockup? dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				       s->dma_dac.dmasize, s->dma_dac.fragsize, s->dma_dac.count, 
@@ -2418,6 +2429,12 @@
 				if (!ret) ret = -ERESTARTSYS;
 				goto return_free;
 			}
+			down(&s->sem);
+			if (s->dma_dac.mapped)
+			{
+				ret = -ENXIO;
+				goto return_free;
+			}
 			continue;
 		}
 		if (copy_from_user(s->dma_dac.rawbuf + swptr, buffer, cnt)) {
@@ -2439,6 +2456,7 @@
 		start_dac(s);
 	}
 return_free:
+	up(&s->sem);
 	return ret;
 }
 
@@ -2493,11 +2511,12 @@
 
 	VALIDATE_STATE(s);
 	lock_kernel();
+	down(&s->sem);
 	if (vma->vm_flags & VM_WRITE) {
 		if ((ret = prog_dmabuf(s, 1)) != 0)
 			goto out;
 		db = &s->dma_dac;
-	} else 
+	} else { 
 #if 0
 	/* if we can have the wp/wc do the combining
 		we can turn this back on.  */
@@ -2507,19 +2526,23 @@
 		db = &s->dma_adc;
 	} else  
 #endif
+		ret = -EINVAL;
 		goto out;
-	ret = -EINVAL;
+	}
 	if (vma->vm_pgoff != 0)
 		goto out;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
+	{
+		ret = -EAGAIN;
 		goto out;
-	ret = -EAGAIN;
+	}
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
 out:
+	up(&s->sem);
 	unlock_kernel();
 	return ret;
 }
@@ -3463,6 +3486,7 @@
 		init_waitqueue_head(&s->open_wait);
 		spin_lock_init(&s->lock);
 		init_MUTEX(&s->open_sem);
+		init_MUTEX(&s->sem);
 		s->magic = ESS_STATE_MAGIC;
 		
 		s->apu[0] = 6*i;

--383733383.991847253860.JavaMail.root@web395-wra.mail.com
Content-Type: text/plain; name=MAESTRO3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=MAESTRO3
Content-ID: MAESTRO3

--- drivers/sound/maestro3.c.old	Tue May  8 22:24:57 2001
+++ drivers/sound/maestro3.c	Wed Jun  6 00:00:06 2001
@@ -242,6 +242,7 @@
         dma_addr_t handle;
 
     } dma_dac, dma_adc;
+	struct semaphore sem;
 };
     
 struct m3_card {
@@ -1328,7 +1329,7 @@
 static ssize_t m3_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
     struct m3_state *s = (struct m3_state *)file->private_data;
-    ssize_t ret;
+    ssize_t ret = 0;
     unsigned long flags;
     unsigned swptr;
     int cnt;
@@ -1338,12 +1339,11 @@
         return -ESPIPE;
     if (s->dma_adc.mapped)
         return -ENXIO;
-    if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
-        return ret;
     if (!access_ok(VERIFY_WRITE, buffer, count))
         return -EFAULT;
-    ret = 0;
-
+    down(&s->sem);
+    if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
+        goto out;
     spin_lock_irqsave(&s->lock, flags);
 
     while (count > 0) {
@@ -1361,10 +1361,10 @@
             start_adc(s);
             if (file->f_flags & O_NONBLOCK) 
             {
-                ret = ret ? ret : -EAGAIN;
+                if(!ret) ret = -EAGAIN;
                 goto out;
             }
-
+	    up(&s->sem);	
             spin_unlock_irqrestore(&s->lock, flags);
             timed_out = interruptible_sleep_on_timeout(&s->dma_adc.wait, HZ) == 0;
             spin_lock_irqsave(&s->lock, flags);
@@ -1379,16 +1379,22 @@
             }
             if (signal_pending(current)) 
             {
-                ret = ret ? ret : -ERESTARTSYS;
+                if(!ret) ret = -ERESTARTSYS;
                 goto out;
             }
+	    down(&s->sem);
+    		if (s->dma_adc.mapped)
+		{
+        		ret = -ENXIO;
+			goto out;
+		}
             continue;
         }
     
         spin_unlock_irqrestore(&s->lock, flags);
         if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt)) {
-            ret = ret ? ret : -EFAULT;
-            return ret;
+            if(!ret) ret = -EFAULT;
+            goto out;
         }
         spin_lock_irqsave(&s->lock, flags);
 
@@ -1402,6 +1408,7 @@
     }
 
 out:
+    up(&s->sem);
     spin_unlock_irqrestore(&s->lock, flags);
     return ret;
 }
@@ -1419,10 +1426,11 @@
         return -ESPIPE;
     if (s->dma_dac.mapped)
         return -ENXIO;
-    if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
-        return ret;
     if (!access_ok(VERIFY_READ, buffer, count))
         return -EFAULT;
+    down(&s->sem);
+    if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+        goto out;
     ret = 0;
 
     spin_lock_irqsave(&s->lock, flags);
@@ -1451,6 +1459,7 @@
                 if(!ret) ret = -EAGAIN;
                 goto out;
             }
+	    up(&s->sem);
             spin_unlock_irqrestore(&s->lock, flags);
             timed_out = interruptible_sleep_on_timeout(&s->dma_dac.wait, HZ) == 0;
             spin_lock_irqsave(&s->lock, flags);
@@ -1466,12 +1475,18 @@
                 if (!ret) ret = -ERESTARTSYS;
                 goto out;
             }
+	down(&s->sem);		
+    	if (s->dma_dac.mapped)
+	{
+        	ret = -ENXIO;
+		goto out;
+	}
             continue;
         }
         spin_unlock_irqrestore(&s->lock, flags);
         if (copy_from_user(s->dma_dac.rawbuf + swptr, buffer, cnt)) {
             if (!ret) ret = -EFAULT;
-            return ret;
+            goto out;
         }
         spin_lock_irqsave(&s->lock, flags);
 
@@ -1489,6 +1504,7 @@
         start_dac(s);
     }
 out:
+    up(&s->sem);
     spin_unlock_irqrestore(&s->lock, flags);
     return ret;
 }
@@ -1534,17 +1550,20 @@
     int ret = -EINVAL;
 
     VALIDATE_STATE(s);
+    down(&s->sem);
     if (vma->vm_flags & VM_WRITE) {
         if ((ret = prog_dmabuf(s, 0)) != 0)
-            return ret;
+            goto out;
         db = &s->dma_dac;
     } else 
     if (vma->vm_flags & VM_READ) {
         if ((ret = prog_dmabuf(s, 1)) != 0)
-            return ret;
+            goto out;
         db = &s->dma_adc;
-    } else  
-        return -EINVAL;
+    } else { 
+        ret = -EINVAL;
+	goto out;
+	}
 
     max_size = db->dmasize;
 
@@ -1554,14 +1573,17 @@
 
     if(size > max_size)
         goto out;
+    
     if(offset > max_size - size)
+    {	
+    	ret = -EAGAIN;
         goto out;
+    }	
 
     /*
      * this will be ->nopage() once I can 
      * ask Jeff what the hell I'm doing wrong.
      */
-    ret = -EAGAIN;
     if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
         goto out;
 
@@ -1569,6 +1591,7 @@
     ret = 0;
 
 out:
+    up(&s->sem);
     return ret;
 }
 
@@ -2674,6 +2697,7 @@
         init_waitqueue_head(&s->open_wait);
         spin_lock_init(&s->lock);
         init_MUTEX(&(s->open_sem));
+	init_MUTEX(&s->sem);
         s->magic = M3_STATE_MAGIC;
 
         m3_assp_client_init(s);

--383733383.991847253860.JavaMail.root@web395-wra.mail.com
Content-Type: text/plain; name=ESSSOLO1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ESSSOLO1
Content-ID: ESSSOLO1

--- drivers/sound/esssolo1.c.old	Tue Jun  5 01:34:16 2001
+++ drivers/sound/esssolo1.c	Tue Jun  5 01:48:00 2001
@@ -226,6 +226,7 @@
 	} midi;
 
 	struct gameport gameport;
+	struct semaphore sem;
 };
 
 /* --------------------------------------------------------------------- */
@@ -1010,7 +1011,7 @@
 {
 	struct solo1_state *s = (struct solo1_state *)file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = 0;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
@@ -1020,11 +1021,13 @@
 		return -ESPIPE;
 	if (s->dma_adc.mapped)
 		return -ENXIO;
-	if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
-		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	ret = 0;
+
+	down(&s->sem);	
+	if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+		goto out;
+
 	add_wait_queue(&s->dma_adc.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&s->lock, flags);
@@ -1058,8 +1061,9 @@
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret)
 					ret = -EAGAIN;
-				break;
+				goto out;
 			}
+			up(&s->sem);
 			schedule();
 #ifdef DEBUGREC
 			printk(KERN_DEBUG "solo1_read: regs: A1: 0x%02x  A2: 0x%02x  A4: 0x%02x  A5: 0x%02x  A8: 0x%02x\n"
@@ -1073,14 +1077,20 @@
 			if (signal_pending(current)) {
 				if (!ret)
 					ret = -ERESTARTSYS;
-				break;
+				goto out;
+			}
+			down(&s->sem);
+			if (s->dma_adc.mapped)
+			{
+				ret = -ENXIO;	
+				goto out;
 			}
 			continue;
 		}
 		if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt)) {
 			if (!ret)
 				ret = -EFAULT;
-			break;
+			goto out;
 		}
 		swptr = (swptr + cnt) % s->dma_adc.dmasize;
 		spin_lock_irqsave(&s->lock, flags);
@@ -1097,6 +1107,8 @@
 		       read_ctrl(s, 0xb8), inb(s->ddmabase+8), inw(s->ddmabase+4), inb(s->sbbase+0xc));
 #endif
 	}
+out:
+	up(&s->sem);
 	remove_wait_queue(&s->dma_adc.wait, &wait);
 	set_current_state(TASK_RUNNING);
 	return ret;
@@ -1116,10 +1128,12 @@
 		return -ESPIPE;
 	if (s->dma_dac.mapped)
 		return -ENXIO;
-	if (!s->dma_dac.ready && (ret = prog_dmabuf_dac(s)))
-		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
+	down(&s->sem);
+	if (!s->dma_dac.ready && (ret = prog_dmabuf_dac(s)))
+		goto out;
+
 #if 0
 	printk(KERN_DEBUG "solo1_write: reg 70: 0x%02x  71: 0x%02x  72: 0x%02x  74: 0x%02x  76: 0x%02x  78: 0x%02x  7A: 0x%02x\n"
 	       KERN_DEBUG "solo1_write: DMA: addr: 0x%08x  cnt: 0x%04x  stat: 0x%02x  SBstat: 0x%02x\n", 
@@ -1151,20 +1165,27 @@
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret)
 					ret = -EAGAIN;
-				break;
+				goto out;
 			}
+			up(&s->sem);
 			schedule();
 			if (signal_pending(current)) {
 				if (!ret)
 					ret = -ERESTARTSYS;
-				break;
+				goto out;	
+			}
+			down(&s->sem);
+			if (s->dma_dac.mapped)
+			{
+				ret = -ENXIO;
+				goto out;
 			}
 			continue;
 		}
 		if (copy_from_user(s->dma_dac.rawbuf + swptr, buffer, cnt)) {
 			if (!ret)
 				ret = -EFAULT;
-			break;
+			goto out;
 		}
 		swptr = (swptr + cnt) % s->dma_dac.dmasize;
 		spin_lock_irqsave(&s->lock, flags);
@@ -1178,6 +1199,8 @@
 		if (s->dma_dac.enabled)
 			start_dac(s);
 	}
+out:
+	up(&s->sem);
 	remove_wait_queue(&s->dma_dac.wait, &wait);
 	set_current_state(TASK_RUNNING);
 	return ret;
@@ -1243,15 +1266,18 @@
 		if ((ret = prog_dmabuf_adc(s)) != 0)
 			goto out;
 		db = &s->dma_adc;
-	} else 
+	} else {
+		ret = -EINVAL;
 		goto out;
-	ret = -EINVAL;
+	}
 	if (vma->vm_pgoff != 0)
 		goto out;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
+	{
+		ret = -EAGAIN;
 		goto out;
-	ret = -EAGAIN;
+	}
 	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
@@ -2322,6 +2348,7 @@
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
 	init_MUTEX(&s->open_sem);
+	init_MUTEX(&s->sem);
 	spin_lock_init(&s->lock);
 	s->magic = SOLO1_MAGIC;
 	s->dev = pcidev;

--383733383.991847253860.JavaMail.root@web395-wra.mail.com--

