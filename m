Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbRFBO6Y>; Sat, 2 Jun 2001 10:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbRFBO6E>; Sat, 2 Jun 2001 10:58:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:25496 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262593AbRFBO5m>;
	Sat, 2 Jun 2001 10:57:42 -0400
Date: Sat, 2 Jun 2001 16:56:59 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: alan@redhat.com, t.sailer@alumni.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] es1371 race fixes
Message-ID: <20010602165659.A12811@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, alan@redhat.com,
	t.sailer@alumni.ethz.ch, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this are the sound locking fixes for es1371.  While it is inspired by the
trident fixes it contains some changes over it:

  o es1371_mmap used to use lock_kernel to do some synchronistation,
    this is superceeded by s->sem.
  o remap_page_range (used in es1371_mmap) needs the mm semaphore as
    stated by a comment and the code.  I have found _NO_ driver in the
    tree so far that does this locking right...

Looks like we have another round of races...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

--- linux-2.4.5-ac6/drivers/sound/es1371.c	Sat Jun  2 14:35:08 2001
+++ linux/drivers/sound/es1371.c	Sat Jun  2 17:35:11 2001
@@ -417,8 +417,16 @@
 	unsigned sctrl;
 	unsigned dac1rate, dac2rate, adcrate;
 
+	/*
+	 * Lock order (high->low):
+	 *   - lock		hardware lock
+	 *   - open_sem		guards opens
+	 *   - sem		guard dmabuf, write re-entry etc
+	 */
 	spinlock_t lock;
 	struct semaphore open_sem;
+	struct semaphore sem;
+
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
 
@@ -1336,21 +1344,27 @@
 {
 	struct es1371_state *s = (struct es1371_state *)file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = 0;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
 
 	VALIDATE_STATE(s);
+
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 	if (s->dma_adc.mapped)
 		return -ENXIO;
-	if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
-		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	ret = 0;
+
+	/*
+	 * Guard against concurrent dmabuf programming.
+	 */
+	down(&s->sem);
+	if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+		goto up_and_out;
+	
 	add_wait_queue(&s->dma_adc.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&s->lock, flags);
@@ -1371,12 +1385,14 @@
 					ret = -EAGAIN;
 				break;
 			}
+			up(&s->sem);
 			schedule();
 			if (signal_pending(current)) {
 				if (!ret)
 					ret = -ERESTARTSYS;
-				break;
+				goto out;
 			}
+			down(&s->sem);
 			continue;
 		}
 		if (copy_to_user(buffer, s->dma_adc.rawbuf + swptr, cnt)) {
@@ -1395,29 +1411,45 @@
 		if (s->dma_adc.enabled)
 			start_adc(s);
 	}
+	up(&s->sem);
+
+out:
 	remove_wait_queue(&s->dma_adc.wait, &wait);
 	set_current_state(TASK_RUNNING);
 	return ret;
+up_and_out:
+	up(&s->sem);
+	return ret;
 }
 
 static ssize_t es1371_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
 	struct es1371_state *s = (struct es1371_state *)file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t ret;
+	ssize_t ret = -ENXIO;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
 
 	VALIDATE_STATE(s);
+
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
+
+	/*
+	 * Guard against an mmap or ioctl while writing
+	 */
+	down(&s->sem);
+	
 	if (s->dma_dac2.mapped)
-		return -ENXIO;
+		goto up_and_out;
 	if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
-		return ret;
-	if (!access_ok(VERIFY_READ, buffer, count))
-		return -EFAULT;
+		goto up_and_out;
+	if (!access_ok(VERIFY_READ, buffer, count)) {
+		ret = -EFAULT;
+		goto up_and_out;
+	}
+
 	ret = 0;
 	add_wait_queue(&s->dma_dac2.wait, &wait);
 	while (count > 0) {
@@ -1443,12 +1475,14 @@
 					ret = -EAGAIN;
 				break;
 			}
+			up(&s->sem);
 			schedule();
 			if (signal_pending(current)) {
 				if (!ret)
 					ret = -ERESTARTSYS;
-				break;
+				goto out;
 			}
+			down(&s->sem);
 			continue;
 		}
 		if (copy_from_user(s->dma_dac2.rawbuf + swptr, buffer, cnt)) {
@@ -1468,9 +1502,15 @@
 		if (s->dma_dac2.enabled)
 			start_dac2(s);
 	}
+	up(&s->sem);
+
+out:
 	remove_wait_queue(&s->dma_dac2.wait, &wait);
 	set_current_state(TASK_RUNNING);
 	return ret;
+up_and_out:
+	up(&s->sem);
+	return ret;
 }
 
 /* No kernel lock - we have our own spinlock */
@@ -1481,21 +1521,29 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+
+	/*
+	 * Guard against a parallel poll and write causing multiple
+	 * prog_dmabuf events
+	 */
+	down(&s->sem);
 	if (file->f_mode & FMODE_WRITE) {
 		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
-			return 0;
+			goto up_and_out;
 		poll_wait(file, &s->dma_dac2.wait, wait);
 	}
 	if (file->f_mode & FMODE_READ) {
 		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
-			return 0;
+			goto up_and_out;
 		poll_wait(file, &s->dma_adc.wait, wait);
 	}
+	up(&s->sem);
+
 	spin_lock_irqsave(&s->lock, flags);
 	es1371_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
-			if (s->dma_adc.count >= (signed)s->dma_adc.fragsize)
-				mask |= POLLIN | POLLRDNORM;
+		if (s->dma_adc.count >= (signed)s->dma_adc.fragsize)
+			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE) {
 		if (s->dma_dac2.mapped) {
@@ -1506,51 +1554,58 @@
 				mask |= POLLOUT | POLLWRNORM;
 		}
 	}
+
 	spin_unlock_irqrestore(&s->lock, flags);
 	return mask;
+up_and_out:
+	up(&s->sem);
+	return 0;
 }
 
 static int es1371_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct es1371_state *s = (struct es1371_state *)file->private_data;
-	struct dmabuf *db;
+	struct dmabuf *db = NULL;
 	int ret;
 	unsigned long size;
 
 	VALIDATE_STATE(s);
-	lock_kernel();
+
+	/*
+	 * Lock against poll read write or mmap creating buffers. Also lock
+	 * a read or write against an mmap.
+	 */
+	down(&s->sem);
 	if (vma->vm_flags & VM_WRITE) {
-		if ((ret = prog_dmabuf_dac2(s)) != 0) {
-			unlock_kernel();
-			return ret;
-		}
+		if ((ret = prog_dmabuf_dac2(s)) != 0)
+			goto out;
 		db = &s->dma_dac2;
 	} else if (vma->vm_flags & VM_READ) {
-		if ((ret = prog_dmabuf_adc(s)) != 0) {
-			unlock_kernel();
-			return ret;
-		}
+		if ((ret = prog_dmabuf_adc(s)) != 0)
+			goto out;
 		db = &s->dma_adc;
-	} else {
-		unlock_kernel();
-		return -EINVAL;
-	}
-	if (vma->vm_pgoff != 0) {
-		unlock_kernel();
-		return -EINVAL;
 	}
+
+	ret = -EINVAL;
+	if (db == NULL)
+		goto out;
+	if (vma->vm_pgoff != 0)
+		goto out;
+
 	size = vma->vm_end - vma->vm_start;
-	if (size > (PAGE_SIZE << db->buforder)) {
-		unlock_kernel();
-		return -EINVAL;
-	}
-	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
-		unlock_kernel();
-		return -EAGAIN;
-	}
-	db->mapped = 1;
-	unlock_kernel();
-	return 0;
+	if (size > (PAGE_SIZE << db->buforder))
+		goto out;
+
+	down_write(&current->mm->mmap_sem);
+	ret = remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf),
+			size, vma->vm_page_prot);
+	up_write(&current->mm->mmap_sem);
+
+	if (ret == 0)
+		db->mapped = 1;
+out:
+	up(&s->sem);
+	return ret;
 }
 
 static int es1371_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -2787,8 +2842,9 @@
 	init_waitqueue_head(&s->open_wait);
 	init_waitqueue_head(&s->midi.iwait);
 	init_waitqueue_head(&s->midi.owait);
-	init_MUTEX(&s->open_sem);
 	spin_lock_init(&s->lock);
+	init_MUTEX(&s->open_sem);
+	init_MUTEX(&s->sem);
 	s->magic = ES1371_MAGIC;
 	s->dev = pcidev;
 	s->io = pci_resource_start(pcidev, 0);
