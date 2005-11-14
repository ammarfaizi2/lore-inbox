Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVKNVdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVKNVdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVKNVcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:50 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38333 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932148AbVKNVcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:17 -0500
Message-Id: <20051114212524.694896000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 01/13] Change pid accesses: drivers
Content-Disposition: inline; filename=B0-change-pid-tgid-references-drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: drivers
From: Serge Hallyn <serue@us.ibm.com>

Instead of letting all parts of the kernel have direct access to
tsk->pid and tgid, make them use a accessor functions: task_{p,tg}id().
This will need to be done for a few other fields, but I decided to start
with those two.  Note that pid has been renamed __pid to make sure that
any uncaught users will error out.

Note that this is very similar to what the vserver vx_map_pid() does,
and doing something like this should shrink their patch.

Our next patchset can find all the places where a pid crosses the
user<->kernel boundary, and do the correct conversions.  Perhaps some
sparse annotations will allow us to do this more automatically, instead
of auditing everything.  We could have a concept of __user for pids, not
just pointers.

This first patch changes the pid accesses under drivers/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 drivers/acorn/block/fd1772.c                |    2 +-
 drivers/acpi/osl.c                          |    2 +-
 drivers/block/ataflop.c                     |    2 +-
 drivers/block/nbd.c                         |    2 +-
 drivers/cdrom/cdrom.c                       |    2 +-
 drivers/cdrom/mcdx.c                        |    2 +-
 drivers/cdrom/sbpcd.c                       |    4 ++--
 drivers/char/agp/frontend.c                 |    6 +++---
 drivers/char/cyclades.c                     |   10 +++++-----
 drivers/char/drm/drm_bufs.c                 |    2 +-
 drivers/char/drm/drm_drv.c                  |    2 +-
 drivers/char/drm/drm_fops.c                 |    8 ++++----
 drivers/char/drm/drm_lock.c                 |    6 +++---
 drivers/char/drm/drm_os_linux.h             |    2 +-
 drivers/char/drm/drm_vm.c                   |    2 +-
 drivers/char/drm/i810_dma.c                 |    2 +-
 drivers/char/drm/i830_dma.c                 |    2 +-
 drivers/char/n_r3964.c                      |   12 ++++++------
 drivers/char/random.c                       |    2 +-
 drivers/char/rio/linux_compat.h             |    2 +-
 drivers/char/snsc_event.c                   |    2 +-
 drivers/char/sx.c                           |    2 +-
 drivers/char/sysrq.c                        |    2 +-
 drivers/char/tty_io.c                       |    6 +++---
 drivers/char/vt_ioctl.c                     |    4 ++--
 drivers/input/joystick/iforce/iforce-main.c |    8 ++++----
 drivers/input/joystick/iforce/iforce.h      |    4 ++--
 drivers/macintosh/adb.c                     |    8 ++++----
 drivers/md/bitmap.c                         |    4 ++--
 drivers/md/md.c                             |    6 +++---
 drivers/media/video/zoran_driver.c          |    4 ++--
 drivers/net/slip.c                          |    6 +++---
 drivers/net/tun.c                           |    2 +-
 drivers/net/wireless/hostap/hostap_ioctl.c  |    2 +-
 drivers/oprofile/buffer_sync.c              |    4 ++--
 drivers/s390/char/fs3270.c                  |    2 +-
 drivers/s390/crypto/z90main.c               |    4 ++--
 drivers/s390/s390mach.c                     |    2 +-
 drivers/scsi/53c7xx.c                       |    2 +-
 drivers/scsi/dc395x.c                       |    4 ++--
 drivers/scsi/eata_pio.c                     |    2 +-
 drivers/serial/crisv10.c                    |    4 ++--
 drivers/usb/core/devio.c                    |    6 +++---
 drivers/usb/input/hid-lgff.c                |    8 ++++----
 drivers/usb/input/hid-tmff.c                |    8 ++++----
 drivers/usb/input/pid.c                     |    8 ++++----
 46 files changed, 94 insertions(+), 94 deletions(-)

Index: linux-2.6.15-rc1/drivers/acorn/block/fd1772.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/acorn/block/fd1772.c
+++ linux-2.6.15-rc1/drivers/acorn/block/fd1772.c
@@ -1275,7 +1275,7 @@ static void do_fd_request(request_queue_
 {
 	unsigned long flags;
 
-	DPRINT(("do_fd_request for pid %d\n", current->pid));
+	DPRINT(("do_fd_request for pid %d\n", task_pid(current)));
 	if (fdc_busy) return;
 	save_flags(flags);
 	cli();
Index: linux-2.6.15-rc1/drivers/acpi/osl.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/acpi/osl.c
+++ linux-2.6.15-rc1/drivers/acpi/osl.c
@@ -931,7 +931,7 @@ u8 acpi_os_writable(void *ptr, acpi_size
 u32 acpi_os_get_thread_id(void)
 {
 	if (!in_atomic())
-		return current->pid;
+		return task_pid(current);
 
 	return 0;
 }
Index: linux-2.6.15-rc1/drivers/block/ataflop.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/block/ataflop.c
+++ linux-2.6.15-rc1/drivers/block/ataflop.c
@@ -1470,7 +1470,7 @@ void do_fd_request(request_queue_t * q)
 {
  	unsigned long flags;
 
-	DPRINT(("do_fd_request for pid %d\n",current->pid));
+	DPRINT(("do_fd_request for pid %d\n",task_pid(current)));
 	while( fdc_busy ) sleep_on( &fdc_wait );
 	fdc_busy = 1;
 	stdma_lock(floppy_irq, NULL);
Index: linux-2.6.15-rc1/drivers/block/nbd.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/block/nbd.c
+++ linux-2.6.15-rc1/drivers/block/nbd.c
@@ -182,7 +182,7 @@ static int sock_xmit(struct socket *sock
 			siginfo_t info;
 			spin_lock_irqsave(&current->sighand->siglock, flags);
 			printk(KERN_WARNING "nbd (pid %d: %s) got signal %d\n",
-				current->pid, current->comm, 
+				task_pid(current), current->comm,
 				dequeue_signal(current, &current->blocked, &info));
 			spin_unlock_irqrestore(&current->sighand->siglock, flags);
 			result = -EINTR;
Index: linux-2.6.15-rc1/drivers/cdrom/cdrom.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/cdrom/cdrom.c
+++ linux-2.6.15-rc1/drivers/cdrom/cdrom.c
@@ -1097,7 +1097,7 @@ int open_for_data(struct cdrom_device_in
 		       is the default case! */
 		    cdinfo(CD_OPEN, "bummer. wrong media type.\n"); 
 		    cdinfo(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
-					(unsigned int)current->pid); 
+					(unsigned int)task_pid(current));
 		    ret=-EMEDIUMTYPE;
 		    goto clean_up_and_return;
 		}
Index: linux-2.6.15-rc1/drivers/cdrom/mcdx.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/cdrom/mcdx.c
+++ linux-2.6.15-rc1/drivers/cdrom/mcdx.c
@@ -1351,7 +1351,7 @@ static int mcdx_xfer(struct s_drive_stuf
 						sector + nr_sectors)
 		    ? stuffp->high_border : border;
 
-		stuffp->lock = current->pid;
+		stuffp->lock = task_pid(current);
 
 		do {
 
Index: linux-2.6.15-rc1/drivers/cdrom/sbpcd.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/cdrom/sbpcd.c
+++ linux-2.6.15-rc1/drivers/cdrom/sbpcd.c
@@ -4854,14 +4854,14 @@ static void do_sbpcd_request(request_que
 	if (!req)
 	{
 		printk( "do_sbpcd_request[%di](NULL), Pid:%d, Time:%li\n",
-			xnr, current->pid, jiffies);
+			xnr, task_pid(current), jiffies);
 		printk( "do_sbpcd_request[%do](NULL) end 0 (null), Time:%li\n",
 			xnr, jiffies);
 		return;
 	}
 
 	printk(" do_sbpcd_request[%di](%p:%ld+%ld), Pid:%d, Time:%li\n",
-		xnr, req, req->sector, req->nr_sectors, current->pid, jiffies);
+		xnr, req, req->sector, req->nr_sectors, task_pid(current), jiffies);
 #endif
 
 	req = elv_next_request(q);	/* take out our request so no other */
Index: linux-2.6.15-rc1/drivers/char/agp/frontend.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/agp/frontend.c
+++ linux-2.6.15-rc1/drivers/char/agp/frontend.c
@@ -611,7 +611,7 @@ static int agp_mmap(struct file *file, s
 		if ((size + offset) > current_size)
 			goto out_inval;
 
-		client = agp_find_client_by_pid(current->pid);
+		client = agp_find_client_by_pid(task_pid(current));
 
 		if (client == NULL)
 			goto out_eperm;
@@ -708,13 +708,13 @@ static int agp_open(struct inode *inode,
 		goto err_out_nomem;
 
 	set_bit(AGP_FF_ALLOW_CLIENT, &priv->access_flags);
-	priv->my_pid = current->pid;
+	priv->my_pid = task_pid(current);
 
 	if ((current->uid == 0) || (current->suid == 0)) {
 		/* Root priv, can be controller */
 		set_bit(AGP_FF_ALLOW_CONTROLLER, &priv->access_flags);
 	}
-	client = agp_find_client_by_pid(current->pid);
+	client = agp_find_client_by_pid(task_pid(current));
 
 	if (client != NULL) {
 		set_bit(AGP_FF_IS_CLIENT, &priv->access_flags);
Index: linux-2.6.15-rc1/drivers/char/cyclades.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/cyclades.c
+++ linux-2.6.15-rc1/drivers/char/cyclades.c
@@ -2361,7 +2361,7 @@ block_til_ready(struct tty_struct *tty, 
     CY_UNLOCK(info, flags);
 #ifdef CY_DEBUG_COUNT
     printk("cyc block_til_ready: (%d): decrementing count to %d\n",
-        current->pid, info->count);
+        task_pid(current), info->count);
 #endif
     info->blocked_open++;
 
@@ -2478,7 +2478,7 @@ block_til_ready(struct tty_struct *tty, 
 	info->count++;
 #ifdef CY_DEBUG_COUNT
 	printk("cyc:block_til_ready (%d): incrementing count to %d\n",
-	    current->pid, info->count);
+	    task_pid(current), info->count);
 #endif
     }
     info->blocked_open--;
@@ -2579,7 +2579,7 @@ cy_open(struct tty_struct *tty, struct f
     info->count++;
 #ifdef CY_DEBUG_COUNT
     printk("cyc:cy_open (%d): incrementing count to %d\n",
-        current->pid, info->count);
+        task_pid(current), info->count);
 #endif
     if (!tmp_buf) {
 	page = get_zeroed_page(GFP_KERNEL);
@@ -2745,7 +2745,7 @@ cy_close(struct tty_struct *tty, struct 
     }
 #ifdef CY_DEBUG_COUNT
     printk("cyc:cy_close at (%d): decrementing count to %d\n",
-        current->pid, info->count - 1);
+        task_pid(current), info->count - 1);
 #endif
     if (--info->count < 0) {
 #ifdef CY_DEBUG_COUNT
@@ -4472,7 +4472,7 @@ cy_hangup(struct tty_struct *tty)
     info->event = 0;
     info->count = 0;
 #ifdef CY_DEBUG_COUNT
-    printk("cyc:cy_hangup (%d): setting count to 0\n", current->pid);
+    printk("cyc:cy_hangup (%d): setting count to 0\n", task_pid(current));
 #endif
     info->tty = NULL;
     info->flags &= ~ASYNC_NORMAL_ACTIVE;
Index: linux-2.6.15-rc1/drivers/char/drm/drm_bufs.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_bufs.c
+++ linux-2.6.15-rc1/drivers/char/drm/drm_bufs.c
@@ -1434,7 +1434,7 @@ int drm_freebufs(struct inode *inode, st
 		buf = dma->buflist[idx];
 		if (buf->filp != filp) {
 			DRM_ERROR("Process %d freeing buffer not owned\n",
-				  current->pid);
+				  task_pid(current));
 			return -EINVAL;
 		}
 		drm_free_buffer(dev, buf);
Index: linux-2.6.15-rc1/drivers/char/drm/drm_drv.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_drv.c
+++ linux-2.6.15-rc1/drivers/char/drm/drm_drv.c
@@ -473,7 +473,7 @@ int drm_ioctl(struct inode *inode, struc
 	++priv->ioctl_count;
 
 	DRM_DEBUG("pid=%d, cmd=0x%02x, nr=0x%02x, dev 0x%lx, auth=%d\n",
-		  current->pid, cmd, nr,
+		  task_pid(current), cmd, nr,
 		  (long)old_encode_dev(priv->head->device),
 		  priv->authenticated);
 
Index: linux-2.6.15-rc1/drivers/char/drm/drm_fops.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_fops.c
+++ linux-2.6.15-rc1/drivers/char/drm/drm_fops.c
@@ -188,7 +188,7 @@ int drm_release(struct inode *inode, str
 	 */
 
 	DRM_DEBUG("pid = %d, device = 0x%lx, open_count = %d\n",
-		  current->pid, (long)old_encode_dev(priv->head->device),
+		  task_pid(current), (long)old_encode_dev(priv->head->device),
 		  dev->open_count);
 
 	if (priv->lock_count && dev->lock.hw_lock &&
@@ -347,7 +347,7 @@ static int drm_open_helper(struct inode 
 	if (!drm_cpu_valid())
 		return -EINVAL;
 
-	DRM_DEBUG("pid = %d, minor = %d\n", current->pid, minor);
+	DRM_DEBUG("pid = %d, minor = %d\n", task_pid(current), minor);
 
 	priv = drm_alloc(sizeof(*priv), DRM_MEM_FILES);
 	if (!priv)
@@ -356,7 +356,7 @@ static int drm_open_helper(struct inode 
 	memset(priv, 0, sizeof(*priv));
 	filp->private_data = priv;
 	priv->uid = current->euid;
-	priv->pid = current->pid;
+	priv->pid = task_pid(current);
 	priv->minor = minor;
 	priv->head = drm_heads[minor];
 	priv->ioctl_count = 0;
@@ -416,7 +416,7 @@ int drm_flush(struct file *filp)
 	drm_device_t *dev = priv->head->dev;
 
 	DRM_DEBUG("pid = %d, device = 0x%lx, open_count = %d\n",
-		  current->pid, (long)old_encode_dev(priv->head->device),
+		  task_pid(current), (long)old_encode_dev(priv->head->device),
 		  dev->open_count);
 	return 0;
 }
Index: linux-2.6.15-rc1/drivers/char/drm/drm_lock.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_lock.c
+++ linux-2.6.15-rc1/drivers/char/drm/drm_lock.c
@@ -67,12 +67,12 @@ int drm_lock(struct inode *inode, struct
 
 	if (lock.context == DRM_KERNEL_CONTEXT) {
 		DRM_ERROR("Process %d using kernel context %d\n",
-			  current->pid, lock.context);
+			  task_pid(current), lock.context);
 		return -EINVAL;
 	}
 
 	DRM_DEBUG("%d (pid %d) requests lock (0x%08x), flags = 0x%08x\n",
-		  lock.context, current->pid,
+		  lock.context, task_pid(current),
 		  dev->lock.hw_lock->lock, lock.flags);
 
 	if (drm_core_check_feature(dev, DRIVER_DMA_QUEUE))
@@ -156,7 +156,7 @@ int drm_unlock(struct inode *inode, stru
 
 	if (lock.context == DRM_KERNEL_CONTEXT) {
 		DRM_ERROR("Process %d using kernel context %d\n",
-			  current->pid, lock.context);
+			  task_pid(current), lock.context);
 		return -EINVAL;
 	}
 
Index: linux-2.6.15-rc1/drivers/char/drm/drm_os_linux.h
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_os_linux.h
+++ linux-2.6.15-rc1/drivers/char/drm/drm_os_linux.h
@@ -12,7 +12,7 @@
 #define DRM_IOCTL_ARGS			struct inode *inode, struct file *filp, unsigned int cmd, unsigned long data
 #define DRM_ERR(d)			-(d)
 /** Current process ID */
-#define DRM_CURRENTPID			current->pid
+#define DRM_CURRENTPID			task_pid(current)
 #define DRM_UDELAY(d)			udelay(d)
 /** Read a byte from a MMIO region */
 #define DRM_READ8(map, offset)		readb(((void __iomem *)(map)->handle) + (offset))
Index: linux-2.6.15-rc1/drivers/char/drm/drm_vm.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/drm_vm.c
+++ linux-2.6.15-rc1/drivers/char/drm/drm_vm.c
@@ -407,7 +407,7 @@ static void drm_vm_open(struct vm_area_s
 		down(&dev->struct_sem);
 		vma_entry->vma = vma;
 		vma_entry->next = dev->vmalist;
-		vma_entry->pid = current->pid;
+		vma_entry->pid = task_pid(current);
 		dev->vmalist = vma_entry;
 		up(&dev->struct_sem);
 	}
Index: linux-2.6.15-rc1/drivers/char/drm/i810_dma.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/i810_dma.c
+++ linux-2.6.15-rc1/drivers/char/drm/i810_dma.c
@@ -1110,7 +1110,7 @@ static int i810_getbuf(struct inode *ino
 	retcode = i810_dma_get_buffer(dev, &d, filp);
 
 	DRM_DEBUG("i810_dma: %d returning %d, granted = %d\n",
-		  current->pid, retcode, d.granted);
+		  task_pid(current), retcode, d.granted);
 
 	if (copy_to_user((drm_dma_t __user *) arg, &d, sizeof(d)))
 		return -EFAULT;
Index: linux-2.6.15-rc1/drivers/char/drm/i830_dma.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/drm/i830_dma.c
+++ linux-2.6.15-rc1/drivers/char/drm/i830_dma.c
@@ -1433,7 +1433,7 @@ static int i830_getbuf(struct inode *ino
 	retcode = i830_dma_get_buffer(dev, &d, filp);
 
 	DRM_DEBUG("i830_dma: %d returning %d, granted = %d\n",
-		  current->pid, retcode, d.granted);
+		  task_pid(current), retcode, d.granted);
 
 	if (copy_to_user((drm_dma_t __user *) arg, &d, sizeof(d)))
 		return -EFAULT;
Index: linux-2.6.15-rc1/drivers/char/n_r3964.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/n_r3964.c
+++ linux-2.6.15-rc1/drivers/char/n_r3964.c
@@ -1068,7 +1068,7 @@ static int r3964_open(struct tty_struct 
    
    TRACE_L("open");
    TRACE_L("tty=%p, PID=%d, disc_data=%p", 
-          tty, current->pid, tty->disc_data);
+          tty, task_pid(current), tty->disc_data);
    
    pInfo=kmalloc(sizeof(struct r3964_info), GFP_KERNEL); 
    TRACE_M("r3964_open - info kmalloc %p",pInfo);
@@ -1193,7 +1193,7 @@ static ssize_t r3964_read(struct tty_str
    struct r3964_client_message theMsg;
    DECLARE_WAITQUEUE (wait, current);
    
-   int pid = current->pid;
+   int pid = task_pid(current);
    int count;
    
    TRACE_L("read()");
@@ -1295,7 +1295,7 @@ static ssize_t r3964_write(struct tty_st
    pHeader->locks = 0;
    pHeader->owner = NULL;
    
-   pid=current->pid;
+   pid=task_pid(current);
    
    pClient=findClient(pInfo, pid);
    if(pClient)
@@ -1328,7 +1328,7 @@ static int r3964_ioctl(struct tty_struct
    switch(cmd)
    {
       case R3964_ENABLE_SIGNALS:
-         return enable_signals(pInfo, current->pid, arg);
+         return enable_signals(pInfo, task_pid(current), arg);
       case R3964_SETPRIORITY:
          if(arg<R3964_MASTER || arg>R3964_SLAVE)
             return -EINVAL;
@@ -1341,7 +1341,7 @@ static int r3964_ioctl(struct tty_struct
             pInfo->flags &= ~R3964_BCC;
          return 0;
       case R3964_READ_TELEGRAM:
-         return read_telegram(pInfo, current->pid, (unsigned char __user *)arg);
+         return read_telegram(pInfo, task_pid(current), (unsigned char __user *)arg);
       default:
          return -ENOIOCTLCMD;
    }
@@ -1357,7 +1357,7 @@ static unsigned int r3964_poll(struct tt
 		      struct poll_table_struct *wait)
 {
    struct r3964_info *pInfo=(struct r3964_info*)tty->disc_data;
-   int pid=current->pid;
+   int pid=task_pid(current);
    struct r3964_client_info *pClient;
    struct r3964_message *pMsg=NULL;
    unsigned long flags;
Index: linux-2.6.15-rc1/drivers/char/random.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/random.c
+++ linux-2.6.15-rc1/drivers/char/random.c
@@ -1640,7 +1640,7 @@ unsigned int get_random_int(void)
 	 * drain on it), and uses halfMD4Transform within the second. We
 	 * also mix it with jiffies and the PID:
 	 */
-	return secure_ip_id(current->pid + jiffies);
+	return secure_ip_id(task_pid(current) + jiffies);
 }
 
 /*
Index: linux-2.6.15-rc1/drivers/char/rio/linux_compat.h
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/rio/linux_compat.h
+++ linux-2.6.15-rc1/drivers/char/rio/linux_compat.h
@@ -58,7 +58,7 @@ struct ttystatics {
 #endif
 
 
-#define getpid()    (current->pid)
+#define getpid()    (task_pid(current))
 
 #define QSIZE SERIAL_XMIT_SIZE
 
Index: linux-2.6.15-rc1/drivers/char/snsc_event.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/snsc_event.c
+++ linux-2.6.15-rc1/drivers/char/snsc_event.c
@@ -207,7 +207,7 @@ scdrv_dispatch_event(char *event, int le
 		/* first find init's task */
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			if (p->pid == 1)
+			if (task_pid(p) == 1)
 				break;
 		}
 		if (p) { /* we found init's task */
Index: linux-2.6.15-rc1/drivers/char/sx.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/sx.c
+++ linux-2.6.15-rc1/drivers/char/sx.c
@@ -1437,7 +1437,7 @@ static int sx_open  (struct tty_struct *
 
 	line = tty->index;
 	sx_dprintk (SX_DEBUG_OPEN, "%d: opening line %d. tty=%p ctty=%p, np=%d)\n", 
-	            current->pid, line, tty, current->signal->tty, sx_nports);
+	            task_pid(current), line, tty, current->signal->tty, sx_nports);
 
 	if ((line < 0) || (line >= SX_NPORTS) || (line >= sx_nports))
 		return -ENODEV;
Index: linux-2.6.15-rc1/drivers/char/sysrq.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/sysrq.c
+++ linux-2.6.15-rc1/drivers/char/sysrq.c
@@ -207,7 +207,7 @@ static void send_sig_all(int sig)
 	struct task_struct *p;
 
 	for_each_process(p) {
-		if (p->mm && p->pid != 1)
+		if (p->mm && task_pid(p) != 1)
 			/* Not swapper, init nor kernel thread */
 			force_sig(sig, p);
 	}
Index: linux-2.6.15-rc1/drivers/char/tty_io.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/tty_io.c
+++ linux-2.6.15-rc1/drivers/char/tty_io.c
@@ -2009,7 +2009,7 @@ static int tty_fasync(int fd, struct fil
 	if (on) {
 		if (!waitqueue_active(&tty->read_wait))
 			tty->minimum_to_wake = 1;
-		retval = f_setown(filp, (-tty->pgrp) ? : current->pid, 0);
+		retval = f_setown(filp, (-tty->pgrp) ? : task_pid(current), 0);
 		if (retval)
 			return retval;
 	} else {
@@ -2471,7 +2471,7 @@ static void __do_SAK(void *arg)
 		if (p->signal->tty == tty || session > 0) {
 			printk(KERN_NOTICE "SAK: killed process %d"
 			    " (%s): p->signal->session==tty->session\n",
-			    p->pid, p->comm);
+			    task_pid(p), p->comm);
 			send_sig(SIGKILL, p, 1);
 			continue;
 		}
@@ -2487,7 +2487,7 @@ static void __do_SAK(void *arg)
 				    filp->private_data == tty) {
 					printk(KERN_NOTICE "SAK: killed process %d"
 					    " (%s): fd#%d opened to the tty\n",
-					    p->pid, p->comm, i);
+					    task_pid(p), p->comm, i);
 					send_sig(SIGKILL, p, 1);
 					break;
 				}
Index: linux-2.6.15-rc1/drivers/char/vt_ioctl.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/char/vt_ioctl.c
+++ linux-2.6.15-rc1/drivers/char/vt_ioctl.c
@@ -651,7 +651,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		  return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
 		  return -EINVAL;
-		spawnpid = current->pid;
+		spawnpid = task_pid(current);
 		spawnsig = arg;
 		return 0;
 	}
@@ -670,7 +670,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		vc->vt_mode = tmp;
 		/* the frsig is ignored, so we set it to 0 */
 		vc->vt_mode.frsig = 0;
-		vc->vt_pid = current->pid;
+		vc->vt_pid = task_pid(current);
 		/* no switch is required -- saw@shade.msu.ru */
 		vc->vt_newvt = -1;
 		release_console_sem();
Index: linux-2.6.15-rc1/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/input/joystick/iforce/iforce-main.c
+++ linux-2.6.15-rc1/drivers/input/joystick/iforce/iforce-main.c
@@ -160,7 +160,7 @@ static int iforce_upload_effect(struct i
 			return -ENOMEM;
 
 		effect->id = id;
-		iforce->core_effects[id].owner = current->pid;
+		iforce->core_effects[id].owner = task_pid(current);
 		iforce->core_effects[id].flags[0] = (1 << FF_CORE_IS_USED);	/* Only IS_USED bit must be set */
 
 		is_update = FALSE;
@@ -223,8 +223,8 @@ static int iforce_erase_effect(struct in
 	struct iforce_core_effect* core_effect;
 
 	/* Check who is trying to erase this effect */
-	if (iforce->core_effects[effect_id].owner != current->pid) {
-		printk(KERN_WARNING "iforce-main.c: %d tried to erase an effect belonging to %d\n", current->pid, iforce->core_effects[effect_id].owner);
+	if (iforce->core_effects[effect_id].owner != task_pid(current)) {
+		printk(KERN_WARNING "iforce-main.c: %d tried to erase an effect belonging to %d\n", task_pid(current), iforce->core_effects[effect_id].owner);
 		return -EACCES;
 	}
 
@@ -274,7 +274,7 @@ static int iforce_flush(struct input_dev
 	for (i=0; i<dev->ff_effects_max; ++i) {
 
 		if (test_bit(FF_CORE_IS_USED, iforce->core_effects[i].flags) &&
-			current->pid == iforce->core_effects[i].owner) {
+			task_pid(current) == iforce->core_effects[i].owner) {
 
 			/* Stop effect */
 			input_report_ff(dev, i, 0);
Index: linux-2.6.15-rc1/drivers/input/joystick/iforce/iforce.h
===================================================================
--- linux-2.6.15-rc1.orig/drivers/input/joystick/iforce/iforce.h
+++ linux-2.6.15-rc1/drivers/input/joystick/iforce/iforce.h
@@ -70,8 +70,8 @@
 #define CHECK_OWNERSHIP(i, iforce)	\
 	((i) < FF_EFFECTS_MAX && i >= 0 && \
 	test_bit(FF_CORE_IS_USED, (iforce)->core_effects[(i)].flags) && \
-	(current->pid == 0 || \
-	(iforce)->core_effects[(i)].owner == current->pid))
+	(task_pid(current) == 0 || \
+	(iforce)->core_effects[(i)].owner == task_pid(current)))
 
 struct iforce_core_effect {
 	/* Information about where modifiers are stored in the device's memory */
Index: linux-2.6.15-rc1/drivers/macintosh/adb.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/macintosh/adb.c
+++ linux-2.6.15-rc1/drivers/macintosh/adb.c
@@ -138,8 +138,8 @@ static void printADBreply(struct adb_req
 
 static __inline__ void adb_wait_ms(unsigned int ms)
 {
-	if (current->pid && adb_probe_task_pid &&
-	  adb_probe_task_pid == current->pid)
+	if (task_pid(current) && adb_probe_task_pid &&
+	  adb_probe_task_pid == task_pid(current))
 		msleep(ms);
 	else
 		mdelay(ms);
@@ -492,8 +492,8 @@ adb_request(struct adb_request *req, voi
 	 * block. Beware that the "done" callback will be overriden !
 	 */
 	if ((flags & ADBREQ_SYNC) &&
-	    (current->pid && adb_probe_task_pid &&
-	    adb_probe_task_pid == current->pid)) {
+	    (task_pid(current) && adb_probe_task_pid &&
+	    adb_probe_task_pid == task_pid(current))) {
 		req->done = adb_probe_wakeup;
 		rc = adb_controller->send_request(req, 0);
 		if (rc || req->complete)
Index: linux-2.6.15-rc1/drivers/md/bitmap.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/md/bitmap.c
+++ linux-2.6.15-rc1/drivers/md/bitmap.c
@@ -1223,7 +1223,7 @@ static mdk_thread_t *bitmap_start_daemon
 	md_wakeup_thread(daemon); /* start it running */
 
 	PRINTK("%s: %s daemon (pid %d) started...\n",
-		bmname(bitmap), name, daemon->tsk->pid);
+		bmname(bitmap), name, daemon->task_pid(tsk));
 
 	return daemon;
 }
@@ -1232,7 +1232,7 @@ static void bitmap_stop_daemon(struct bi
 {
 	/* the daemon can't stop itself... it'll just exit instead... */
 	if (bitmap->writeback_daemon && ! IS_ERR(bitmap->writeback_daemon) &&
-	    current->pid != bitmap->writeback_daemon->tsk->pid) {
+	    task_pid(current) != task_pid(bitmap->writeback_daemon->tsk)) {
 		mdk_thread_t *daemon;
 		unsigned long flags;
 
Index: linux-2.6.15-rc1/drivers/md/md.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/md/md.c
+++ linux-2.6.15-rc1/drivers/md/md.c
@@ -3157,7 +3157,7 @@ static int md_ioctl(struct inode *inode,
 			printk(KERN_WARNING
 			       "md: %s(pid %d) used deprecated START_ARRAY ioctl. "
 			       "This will not be supported beyond 2.6\n",
-			       current->comm, current->pid);
+			       current->comm, task_pid(current));
 			cnt--;
 		}
 		err = autostart_array(new_decode_dev(arg));
@@ -3345,7 +3345,7 @@ static int md_ioctl(struct inode *inode,
 				printk(KERN_WARNING "md: %s(pid %d) used"
 					" obsolete MD ioctl, upgrade your"
 					" software to use new ictls.\n",
-					current->comm, current->pid);
+					current->comm, task_pid(current));
 			err = -EINVAL;
 			goto abort_unlock;
 	}
@@ -3485,7 +3485,7 @@ mdk_thread_t *md_register_thread(void (*
 
 void md_unregister_thread(mdk_thread_t *thread)
 {
-	dprintk("interrupting MD-thread pid %d\n", thread->tsk->pid);
+	dprintk("interrupting MD-thread pid %d\n", task_pid(thread->tsk));
 
 	kthread_stop(thread->tsk);
 	kfree(thread);
Index: linux-2.6.15-rc1/drivers/media/video/zoran_driver.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/media/video/zoran_driver.c
+++ linux-2.6.15-rc1/drivers/media/video/zoran_driver.c
@@ -1342,7 +1342,7 @@ zoran_open (struct inode *inode,
 	}
 
 	dprintk(1, KERN_INFO "%s: zoran_open(%s, pid=[%d]), users(-)=%d\n",
-		ZR_DEVNAME(zr), current->comm, current->pid, zr->user);
+		ZR_DEVNAME(zr), current->comm, task_pid(current), zr->user);
 
 	/* now, create the open()-specific file_ops struct */
 	fh = kmalloc(sizeof(struct zoran_fh), GFP_KERNEL);
@@ -1416,7 +1416,7 @@ zoran_close (struct inode *inode,
 	struct zoran *zr = fh->zr;
 
 	dprintk(1, KERN_INFO "%s: zoran_close(%s, pid=[%d]), users(+)=%d\n",
-		ZR_DEVNAME(zr), current->comm, current->pid, zr->user);
+		ZR_DEVNAME(zr), current->comm, task_pid(current), zr->user);
 
 	/* kernel locks (fs/device.c), so don't do that ourselves
 	 * (prevents deadlocks) */
Index: linux-2.6.15-rc1/drivers/net/slip.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/net/slip.c
+++ linux-2.6.15-rc1/drivers/net/slip.c
@@ -749,7 +749,7 @@ sl_alloc(dev_t line)
 		if (sl->tty)
 			continue;
 
-		if (current->pid == sl->pid) {
+		if (task_pid(current) == sl->pid) {
 			if (sl->line == line && score < 3) {
 				sel = i;
 				score = 3;
@@ -867,7 +867,7 @@ static int slip_open(struct tty_struct *
 	sl->tty = tty;
 	tty->disc_data = sl;
 	sl->line = tty_devnum(tty);
-	sl->pid = current->pid;
+	sl->pid = task_pid(current);
 	
 	/* FIXME: already done before we were called - seems this can go */
 	if (tty->driver->flush_buffer)
@@ -1303,7 +1303,7 @@ static int sl_ioctl(struct net_device *d
 		/* Resolve race condition, when ioctl'ing hanged up 
 		   and opened by another process device.
 		 */
-		if (sl->tty != current->signal->tty && sl->pid != current->pid) {
+		if (sl->tty != current->signal->tty && sl->pid != task_pid(current)) {
 			spin_unlock_bh(&sl->lock);
 			return -EPERM;
 		}
Index: linux-2.6.15-rc1/drivers/net/tun.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/net/tun.c
+++ linux-2.6.15-rc1/drivers/net/tun.c
@@ -709,7 +709,7 @@ static int tun_chr_fasync(int fd, struct
 		return ret; 
  
 	if (on) {
-		ret = f_setown(file, current->pid, 0);
+		ret = f_setown(file, task_pid(current), 0);
 		if (ret)
 			return ret;
 		tun->flags |= TUN_FASYNC;
Index: linux-2.6.15-rc1/drivers/net/wireless/hostap/hostap_ioctl.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/net/wireless/hostap/hostap_ioctl.c
+++ linux-2.6.15-rc1/drivers/net/wireless/hostap/hostap_ioctl.c
@@ -2923,7 +2923,7 @@ static int prism2_ioctl_priv_monitor(str
 
 	printk(KERN_DEBUG "%s: process %d (%s) used deprecated iwpriv monitor "
 	       "- update software to use iwconfig mode monitor\n",
-	       dev->name, current->pid, current->comm);
+	       dev->name, task_pid(current), current->comm);
 
 	/* Backward compatibility code - this can be removed at some point */
 
Index: linux-2.6.15-rc1/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6.15-rc1/drivers/oprofile/buffer_sync.c
@@ -286,12 +286,12 @@ add_user_ctx_switch(struct task_struct c
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_SWITCH_CODE); 
-	add_event_entry(task->pid);
+	add_event_entry(task_pid(task));
 	add_event_entry(cookie);
 	/* Another code for daemon back-compat */
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_TGID_CODE);
-	add_event_entry(task->tgid);
+	add_event_entry(task_tgid(task));
 }
 
  
Index: linux-2.6.15-rc1/drivers/s390/char/fs3270.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/s390/char/fs3270.c
+++ linux-2.6.15-rc1/drivers/s390/char/fs3270.c
@@ -444,7 +444,7 @@ fs3270_open(struct inode *inode, struct 
 		return PTR_ERR(fp);
 
 	init_waitqueue_head(&fp->wait);
-	fp->fs_pid = current->pid;
+	fp->fs_pid = task_pid(current);
 	rc = raw3270_add_view(&fp->view, &fs3270_fn, minor);
 	if (rc) {
 		fs3270_free_view(&fp->view);
Index: linux-2.6.15-rc1/drivers/s390/crypto/z90main.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/s390/crypto/z90main.c
+++ linux-2.6.15-rc1/drivers/s390/crypto/z90main.c
@@ -185,7 +185,7 @@ extern char z90hardware_version[];
 /**
  * PID() expands to the process ID of the current process
  */
-#define PID() (current->pid)
+#define PID() (task_pid(current))
 
 /**
  * Selected Constants.	The number of APs and the number of devices
@@ -942,7 +942,7 @@ init_work_element(struct work_element *w
 	step = atomic_inc_return(&z90crypt_step);
 	memcpy(we_p->caller_id+0, (void *) &pid, sizeof(pid));
 	memcpy(we_p->caller_id+4, (void *) &step, sizeof(step));
-	we_p->pid = pid;
+	we_task_pid(p) = pid;
 	we_p->priv_data = priv_data;
 	we_p->status[0] = STAT_DEFAULT;
 	we_p->audit[0] = 0x00;
Index: linux-2.6.15-rc1/drivers/s390/s390mach.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/s390/s390mach.c
+++ linux-2.6.15-rc1/drivers/s390/s390mach.c
@@ -183,7 +183,7 @@ s390_handle_mcck(void)
 		printk(KERN_EMERG "mcck: Terminating task because of machine "
 		       "malfunction (code 0x%016llx).\n", mcck.mcck_code);
 		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
-		       current->comm, current->pid);
+		       current->comm, task_pid(current));
 		do_exit(SIGSEGV);
 	}
 }
Index: linux-2.6.15-rc1/drivers/scsi/53c7xx.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/scsi/53c7xx.c
+++ linux-2.6.15-rc1/drivers/scsi/53c7xx.c
@@ -4208,7 +4208,7 @@ restart:
 
 	if (hostdata->options & OPTION_DEBUG_INTR) {
 	    printk ("scsi%d : command complete : pid %lu, id %d,lun %d result 0x%x ", 
-		  host->host_no, tmp->pid, tmp->device->id, tmp->device->lun, tmp->result);
+		  host->host_no, tmtask_pid(p), tmp->device->id, tmp->device->lun, tmp->result);
 	    __scsi_print_command (tmp->cmnd);
 	}
 
Index: linux-2.6.15-rc1/drivers/scsi/dc395x.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/scsi/dc395x.c
+++ linux-2.6.15-rc1/drivers/scsi/dc395x.c
@@ -3554,7 +3554,7 @@ static void doing_srb_done(struct Adapte
 			p = srb->cmd;
 			dir = p->sc_data_direction;
 			result = MK_RES(0, did_flag, 0, 0);
-			printk("G:%li(%02i-%i) ", p->pid,
+			printk("G:%li(%02i-%i) ", task_pid(p),
 			       p->device->id, p->device->lun);
 			srb_going_remove(dcb, srb);
 			free_tag(dcb, srb);
@@ -3584,7 +3584,7 @@ static void doing_srb_done(struct Adapte
 			p = srb->cmd;
 
 			result = MK_RES(0, did_flag, 0, 0);
-			printk("W:%li<%02i-%i>", p->pid, p->device->id,
+			printk("W:%li<%02i-%i>", task_pid(p), p->device->id,
 			       p->device->lun);
 			srb_waiting_remove(dcb, srb);
 			srb_free_insert(acb, srb);
Index: linux-2.6.15-rc1/drivers/scsi/eata_pio.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/scsi/eata_pio.c
+++ linux-2.6.15-rc1/drivers/scsi/eata_pio.c
@@ -512,7 +512,7 @@ static int eata_pio_host_reset(struct sc
 
 		sp = HD(cmd)->ccb[x].cmd;
 		HD(cmd)->ccb[x].status = RESET;
-		printk(KERN_WARNING "eata_pio_reset: slot %d in reset, pid %ld.\n", x, sp->pid);
+		printk(KERN_WARNING "eata_pio_reset: slot %d in reset, pid %ld.\n", x, stask_pid(p));
 
 		if (sp == NULL)
 			panic("eata_pio_reset: slot %d, sp==NULL.\n", x);
Index: linux-2.6.15-rc1/drivers/serial/crisv10.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/serial/crisv10.c
+++ linux-2.6.15-rc1/drivers/serial/crisv10.c
@@ -4346,7 +4346,7 @@ rs_close(struct tty_struct *tty, struct 
 	}
 
 #ifdef SERIAL_DEBUG_OPEN
-	printk("[%d] rs_close ttyS%d, count = %d\n", current->pid,
+	printk("[%d] rs_close ttyS%d, count = %d\n", task_pid(current),
 	       info->line, info->count);
 #endif
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -4639,7 +4639,7 @@ rs_open(struct tty_struct *tty, struct f
 		return -ENODEV;
 
 #ifdef SERIAL_DEBUG_OPEN
-        printk("[%d] rs_open %s, count = %d\n", current->pid, tty->name,
+        printk("[%d] rs_open %s, count = %d\n", task_pid(current), tty->name,
  	       info->count);
 #endif
 
Index: linux-2.6.15-rc1/drivers/usb/input/hid-lgff.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/usb/input/hid-lgff.c
+++ linux-2.6.15-rc1/drivers/usb/input/hid-lgff.c
@@ -55,8 +55,8 @@
 #define DEVICE_CLOSING 0     /* The driver is being unitialised */
 
 /* Check that the current process can access an effect */
-#define CHECK_OWNERSHIP(effect) (current->pid == 0 \
-        || effect.owner == current->pid)
+#define CHECK_OWNERSHIP(effect) (task_pid(current) == 0 \
+        || effect.owner == task_pid(current))
 
 #define LGFF_CHECK_OWNERSHIP(i, l) \
         (i>=0 && i<LGFF_EFFECTS \
@@ -340,7 +340,7 @@ static int hid_lgff_flush(struct input_d
 		  modified is when effects are uploaded or when an effect is
 		  erased. But a process cannot close its dev/input/eventX fd
 		  and perform ioctls on the same fd all at the same time */
-		if ( current->pid == lgff->effects[i].owner
+		if ( task_pid(current) == lgff->effects[i].owner
 		     && test_bit(EFFECT_USED, lgff->effects[i].flags)) {
 
 			if (hid_lgff_erase(dev, i))
@@ -392,7 +392,7 @@ static int hid_lgff_upload_effect(struct
 		}
 
 		effect->id = i;
-		lgff->effects[i].owner = current->pid;
+		lgff->effects[i].owner = task_pid(current);
 		lgff->effects[i].flags[0] = 0;
 		set_bit(EFFECT_USED, lgff->effects[i].flags);
 	}
Index: linux-2.6.15-rc1/drivers/usb/input/hid-tmff.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/usb/input/hid-tmff.c
+++ linux-2.6.15-rc1/drivers/usb/input/hid-tmff.c
@@ -51,8 +51,8 @@
 #define DEVICE_CLOSING 0	/* The driver is being unitialised */
 
 /* Check that the current process can access an effect */
-#define CHECK_OWNERSHIP(effect) (current->pid == 0 \
-        || effect.owner == current->pid)
+#define CHECK_OWNERSHIP(effect) (task_pid(current) == 0 \
+        || effect.owner == task_pid(current))
 
 #define TMFF_CHECK_ID(id)	((id) >= 0 && (id) < TMFF_EFFECTS)
 
@@ -255,7 +255,7 @@ static int hid_tmff_flush(struct input_d
 		erased. But a process cannot close its dev/input/eventX fd
 		and perform ioctls on the same fd all at the same time */
 
-		if (current->pid == tmff->effects[i].owner
+		if (task_pid(current) == tmff->effects[i].owner
 		     && test_bit(EFFECT_USED, tmff->effects[i].flags))
 			if (hid_tmff_erase(dev, i))
 				warn("erase effect %d failed", i);
@@ -310,7 +310,7 @@ static int hid_tmff_upload_effect(struct
 		}
 
 		effect->id = id;
-		tmff->effects[id].owner = current->pid;
+		tmff->effects[id].owner = task_pid(current);
 		tmff->effects[id].flags[0] = 0;
 		set_bit(EFFECT_USED, tmff->effects[id].flags);
 
Index: linux-2.6.15-rc1/drivers/usb/input/pid.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/usb/input/pid.c
+++ linux-2.6.15-rc1/drivers/usb/input/pid.c
@@ -42,8 +42,8 @@
 #define CHECK_OWNERSHIP(i, hid_pid)	\
 	((i) < FF_EFFECTS_MAX && i >= 0 && \
 	test_bit(FF_PID_FLAGS_USED, &hid_pid->effects[(i)].flags) && \
-	(current->pid == 0 || \
-	(hid_pid)->effects[(i)].owner == current->pid))
+	(task_pid(current) == 0 || \
+	(hid_pid)->effects[(i)].owner == task_pid(current)))
 
 /* Called when a transfer is completed */
 static void hid_pid_ctrl_out(struct urb *u, struct pt_regs *regs)
@@ -153,7 +153,7 @@ static int hid_pid_flush(struct input_de
 	   and perform ioctls on the same fd all at the same time */
 	/*FIXME: multiple threads, anyone? */
 	for (i = 0; i < dev->ff_effects_max; ++i)
-		if (current->pid == pid->effects[i].owner
+		if (task_pid(current) == pid->effects[i].owner
 		    && test_bit(FF_PID_FLAGS_USED, &pid->effects[i].flags))
 			if (hid_pid_erase(dev, i))
 				dev_warn(&hid->dev->dev, "erase effect %d failed", i);
@@ -199,7 +199,7 @@ static int hid_pid_upload_effect(struct 
 
 		effect->id = id;
 		dev_dbg(&pid_private->hid->dev->dev, "effect ID is %d.\n", id);
-		pid_private->effects[id].owner = current->pid;
+		pid_private->effects[id].owner = task_pid(current);
 		pid_private->effects[id].flags = (1 << FF_PID_FLAGS_USED);
 		spin_unlock_irqrestore(&pid_private->lock, flags);
 
Index: linux-2.6.15-rc1/drivers/usb/core/devio.c
===================================================================
--- linux-2.6.15-rc1.orig/drivers/usb/core/devio.c
+++ linux-2.6.15-rc1/drivers/usb/core/devio.c
@@ -466,7 +466,7 @@ static int checkintf(struct dev_state *p
 		return 0;
 	/* if not yet claimed, claim it for the driver */
 	dev_warn(&ps->dev->dev, "usbfs: process %d (%s) did not claim interface %u before use\n",
-	       current->pid, current->comm, ifnum);
+	       task_pid(current), current->comm, ifnum);
 	return claimintf(ps, ifnum);
 }
 
@@ -572,7 +572,7 @@ static int usbdev_open(struct inode *ino
 	INIT_LIST_HEAD(&ps->async_completed);
 	init_waitqueue_head(&ps->wait);
 	ps->discsignr = 0;
-	ps->disc_pid = current->pid;
+	ps->disc_pid = task_pid(current);
 	ps->disc_uid = current->uid;
 	ps->disc_euid = current->euid;
 	ps->disccontext = NULL;
@@ -1055,7 +1055,7 @@ static int proc_do_submiturb(struct dev_
 		as->userbuffer = NULL;
 	as->signr = uurb->signr;
 	as->ifnum = ifnum;
-	as->pid = current->pid;
+	as->pid = task_pid(current);
 	as->uid = current->uid;
 	as->euid = current->euid;
 	if (!(uurb->endpoint & USB_DIR_IN)) {

--

