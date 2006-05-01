Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWEATpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWEATpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWEATpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:45:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:53900 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWEATpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:45:01 -0400
Date: Mon, 1 May 2006 12:43:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.12
Message-ID: <20060501194325.GB17240@kroah.com>
References: <20060501194247.GA17240@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501194247.GA17240@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/dvb/get_dvb_firmware b/Documentation/dvb/get_dvb_firmware
index 75c28a1..948f502 100644
--- a/Documentation/dvb/get_dvb_firmware
+++ b/Documentation/dvb/get_dvb_firmware
@@ -240,9 +240,9 @@ sub dibusb {
 }
 
 sub nxt2002 {
-    my $sourcefile = "Broadband4PC_4_2_11.zip";
+    my $sourcefile = "Technisat_DVB-PC_4_4_COMPACT.zip";
     my $url = "http://www.bbti.us/download/windows/$sourcefile";
-    my $hash = "c6d2ea47a8f456d887ada0cfb718ff2a";
+    my $hash = "476befae8c7c1bb9648954060b1eec1f";
     my $outfile = "dvb-fe-nxt2002.fw";
     my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
 
@@ -250,8 +250,8 @@ sub nxt2002 {
 
     wgetfile($sourcefile, $url);
     unzip($sourcefile, $tmpdir);
-    verify("$tmpdir/SkyNETU.sys", $hash);
-    extract("$tmpdir/SkyNETU.sys", 375832, 5908, $outfile);
+    verify("$tmpdir/SkyNET.sys", $hash);
+    extract("$tmpdir/SkyNET.sys", 331624, 5908, $outfile);
 
     $outfile;
 }
diff --git a/Makefile b/Makefile
index e86b4ba..2f8e9d8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .11
+EXTRAVERSION = .12
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/alpha/lib/strncpy.S b/arch/alpha/lib/strncpy.S
index 338551c..bbdef1b 100644
--- a/arch/alpha/lib/strncpy.S
+++ b/arch/alpha/lib/strncpy.S
@@ -43,8 +43,8 @@ strncpy:
 
 	.align	4
 $multiword:
-	subq	$24, 1, $2	# clear the final bits in the prev word
-	or	$2, $24, $2
+	subq	$27, 1, $2	# clear the final bits in the prev word
+	or	$2, $27, $2
 	zapnot	$1, $2, $1
 	subq	$18, 1, $18
 
@@ -70,8 +70,8 @@ strncpy:
 	bne	$18, 0b
 
 1:	ldq_u	$1, 0($16)	# clear the leading bits in the final word
-	subq	$27, 1, $2
-	or	$2, $27, $2
+	subq	$24, 1, $2
+	or	$2, $24, $2
 
 	zap	$1, $2, $1
 	stq_u	$1, 0($16)
diff --git a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
index f51c894..aee14fa 100644
--- a/arch/i386/kernel/vm86.c
+++ b/arch/i386/kernel/vm86.c
@@ -43,6 +43,7 @@ #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
+#include <linux/audit.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -252,6 +253,7 @@ out:
 static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
 {
 	struct tss_struct *tss;
+	long eax;
 /*
  * make sure the vm86() system call doesn't try to do anything silly
  */
@@ -305,13 +307,19 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
+	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
+	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
+
+	/*call audit_syscall_exit since we do not exit via the normal paths */
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, AUDITSC_RESULT(eax), eax);
+
 	__asm__ __volatile__(
-		"xorl %%eax,%%eax; movl %%eax,%%fs; movl %%eax,%%gs\n\t"
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (task_thread_info(tsk)) : "ax");
+		:"r" (&info->regs), "r" (task_thread_info(tsk)));
 	/* we never return here */
 }
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 374de83..b6232d9 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -184,7 +184,7 @@ int __compute_return_epc(struct pt_regs 
 		bit = (insn.i_format.rt >> 2);
 		bit += (bit != 0);
 		bit += 23;
-		switch (insn.i_format.rt) {
+		switch (insn.i_format.rt & 3) {
 		case 0:	/* bc1f */
 		case 2:	/* bc1fl */
 			if (~fcr31 & (1 << bit))
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9572ed4..a761f99 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -154,7 +154,8 @@ static inline void blast_icache32_r4600_
 
 static inline void tx49_blast_icache32_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
+	unsigned long indexmask = current_cpu_data.icache.waysize - 1;
+	unsigned long start = INDEX_BASE + (page & indexmask);
 	unsigned long end = start + PAGE_SIZE;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
diff --git a/arch/x86_64/ia32/Makefile b/arch/x86_64/ia32/Makefile
index 929e6b0..e9263b4 100644
--- a/arch/x86_64/ia32/Makefile
+++ b/arch/x86_64/ia32/Makefile
@@ -27,5 +27,5 @@ quiet_cmd_syscall = SYSCALL $@
 $(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
 	$(call if_changed,syscall)
 
-AFLAGS_vsyscall-sysenter.o = -m32
-AFLAGS_vsyscall-syscall.o = -m32
+AFLAGS_vsyscall-sysenter.o = -m32 -Wa,-32
+AFLAGS_vsyscall-syscall.o = -m32 -Wa,-32
diff --git a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
index 0c3f052..b9dbe3c 100644
--- a/arch/x86_64/kernel/pci-gart.c
+++ b/arch/x86_64/kernel/pci-gart.c
@@ -114,10 +114,6 @@ static unsigned long alloc_iommu(int siz
 static void free_iommu(unsigned long offset, int size)
 { 
 	unsigned long flags;
-	if (size == 1) { 
-		clear_bit(offset, iommu_gart_bitmap); 
-		return;
-	}
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	__clear_bit_string(iommu_gart_bitmap, offset, size);
 	spin_unlock_irqrestore(&iommu_bitmap_lock, flags);
diff --git a/block/genhd.c b/block/genhd.c
index db57546..7f406f9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -16,8 +16,6 @@ #include <linux/kmod.h>
 #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
 
-#define MAX_PROBE_HASH 255	/* random */
-
 static struct subsystem block_subsys;
 
 static DECLARE_MUTEX(block_subsys_sem);
@@ -30,108 +28,29 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
-} *major_names[MAX_PROBE_HASH];
+} *major_names[BLKDEV_MAJOR_HASH_SIZE];
 
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(int major)
 {
-	return major % MAX_PROBE_HASH;
-}
-
-struct blkdev_info {
-        int index;
-        struct blk_major_name *bd;
-};
-
-/*
- * iterate over a list of blkdev_info structures.  allows
- * the major_names array to be iterated over from outside this file
- * must be called with the block_subsys_sem held
- */
-void *get_next_blkdev(void *dev)
-{
-        struct blkdev_info *info;
-
-        if (dev == NULL) {
-                info = kmalloc(sizeof(*info), GFP_KERNEL);
-                if (!info)
-                        goto out;
-                info->index=0;
-                info->bd = major_names[info->index];
-                if (info->bd)
-                        goto out;
-        } else {
-                info = dev;
-        }
-
-        while (info->index < ARRAY_SIZE(major_names)) {
-                if (info->bd)
-                        info->bd = info->bd->next;
-                if (info->bd)
-                        goto out;
-                /*
-                 * No devices on this chain, move to the next
-                 */
-                info->index++;
-                info->bd = (info->index < ARRAY_SIZE(major_names)) ?
-			major_names[info->index] : NULL;
-                if (info->bd)
-                        goto out;
-        }
-
-out:
-        return info;
-}
-
-void *acquire_blkdev_list(void)
-{
-        down(&block_subsys_sem);
-        return get_next_blkdev(NULL);
-}
-
-void release_blkdev_list(void *dev)
-{
-        up(&block_subsys_sem);
-        kfree(dev);
+	return major % BLKDEV_MAJOR_HASH_SIZE;
 }
 
+#ifdef CONFIG_PROC_FS
 
-/*
- * Count the number of records in the blkdev_list.
- * must be called with the block_subsys_sem held
- */
-int count_blkdev_list(void)
+void blkdev_show(struct seq_file *f, off_t offset)
 {
-	struct blk_major_name *n;
-	int i, count;
+	struct blk_major_name *dp;
 
-	count = 0;
-
-	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next)
-				count++;
+	if (offset < BLKDEV_MAJOR_HASH_SIZE) {
+		down(&block_subsys_sem);
+		for (dp = major_names[offset]; dp; dp = dp->next)
+			seq_printf(f, "%3d %s\n", dp->major, dp->name);
+		up(&block_subsys_sem);
 	}
-
-	return count;
-}
-
-/*
- * extract the major and name values from a blkdev_info struct
- * passed in as a void to *dev.  Must be called with
- * block_subsys_sem held
- */
-int get_blkdev_info(void *dev, int *major, char **name)
-{
-        struct blkdev_info *info = dev;
-
-        if (info->bd == NULL)
-                return 1;
-
-        *major = info->bd->major;
-        *name = info->bd->name;
-        return 0;
 }
 
+#endif /* CONFIG_PROC_FS */
 
 int register_blkdev(unsigned int major, const char *name)
 {
diff --git a/drivers/char/cs5535_gpio.c b/drivers/char/cs5535_gpio.c
index 5d72f50..46d6603 100644
--- a/drivers/char/cs5535_gpio.c
+++ b/drivers/char/cs5535_gpio.c
@@ -241,9 +241,10 @@ static int __init cs5535_gpio_init(void)
 static void __exit cs5535_gpio_cleanup(void)
 {
 	dev_t dev_id = MKDEV(major, 0);
+
+	cdev_del(&cs5535_gpio_cdev);
 	unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);
-	if (gpio_base != 0)
-		release_region(gpio_base, CS5535_GPIO_SIZE);
+	release_region(gpio_base, CS5535_GPIO_SIZE);
 }
 
 module_init(cs5535_gpio_init);
diff --git a/drivers/char/snsc.c b/drivers/char/snsc.c
index 0e7d216..d22da98 100644
--- a/drivers/char/snsc.c
+++ b/drivers/char/snsc.c
@@ -391,7 +391,8 @@ scdrv_init(void)
 			format_module_id(devnamep, geo_module(geoid),
 					 MODULE_FORMAT_BRIEF);
 			devnamep = devname + strlen(devname);
-			sprintf(devnamep, "#%d", geo_slab(geoid));
+			sprintf(devnamep, "^%d#%d", geo_slot(geoid),
+				geo_slab(geoid));
 
 			/* allocate sysctl device data */
 			scd = kmalloc(sizeof (struct sysctl_data_s),
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index f8dd852..a90f5d9 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1341,6 +1341,9 @@ static int __devinit sonypi_probe(struct
 	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
+	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+					  PCI_DEVICE_ID_INTEL_ICH7_1, NULL)))
+		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
 	else
 		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
 
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
index eb2eb3e..079db5a 100644
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -515,7 +515,7 @@ tipar_init_module(void)
 		err = PTR_ERR(tipar_class);
 		goto out_chrdev;
 	}
-	if (parport_register_driver(&tipar_driver) || tp_count == 0) {
+	if (parport_register_driver(&tipar_driver)) {
 		printk(KERN_ERR "tipar: unable to register with parport\n");
 		err = -EIO;
 		goto out_class;
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index f3759dd..1ed241d 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -542,8 +542,12 @@ static void snapshot_dtr(struct dm_targe
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
+	/* Prevent further origin writes from using this snapshot. */
+	/* After this returns there can be no new kcopyd jobs. */
 	unregister_snapshot(s);
 
+	kcopyd_client_destroy(s->kcopyd_client);
+
 	exit_exception_table(&s->pending, pending_cache);
 	exit_exception_table(&s->complete, exception_cache);
 
@@ -552,7 +556,7 @@ static void snapshot_dtr(struct dm_targe
 
 	dm_put_device(ti, s->origin);
 	dm_put_device(ti, s->cow);
-	kcopyd_client_destroy(s->kcopyd_client);
+
 	kfree(s);
 }
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d559569..f6c8e8e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1098,6 +1098,7 @@ int dm_suspend(struct mapped_device *md,
 {
 	struct dm_table *map = NULL;
 	DECLARE_WAITQUEUE(wait, current);
+	struct bio *def;
 	int r = -EINVAL;
 
 	down(&md->suspend_lock);
@@ -1157,9 +1158,11 @@ int dm_suspend(struct mapped_device *md,
 	/* were we interrupted ? */
 	r = -EINTR;
 	if (atomic_read(&md->pending)) {
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		def = bio_list_get(&md->deferred);
+		__flush_deferred_io(md, def);
 		up_write(&md->io_lock);
 		unlock_fs(md);
-		clear_bit(DMF_BLOCK_IO, &md->flags);
 		goto out;
 	}
 	up_write(&md->io_lock);
diff --git a/drivers/md/kcopyd.c b/drivers/md/kcopyd.c
index 8b3515f..fc009cb 100644
--- a/drivers/md/kcopyd.c
+++ b/drivers/md/kcopyd.c
@@ -44,6 +44,9 @@ struct kcopyd_client {
 	struct page_list *pages;
 	unsigned int nr_pages;
 	unsigned int nr_free_pages;
+
+	wait_queue_head_t destroyq;
+	atomic_t nr_jobs;
 };
 
 static struct page_list *alloc_pl(void)
@@ -293,10 +296,15 @@ static int run_complete_job(struct kcopy
 	int read_err = job->read_err;
 	unsigned int write_err = job->write_err;
 	kcopyd_notify_fn fn = job->fn;
+	struct kcopyd_client *kc = job->kc;
 
-	kcopyd_put_pages(job->kc, job->pages);
+	kcopyd_put_pages(kc, job->pages);
 	mempool_free(job, _job_pool);
 	fn(read_err, write_err, context);
+
+	if (atomic_dec_and_test(&kc->nr_jobs))
+		wake_up(&kc->destroyq);
+
 	return 0;
 }
 
@@ -431,6 +439,7 @@ static void do_work(void *ignored)
  */
 static void dispatch_job(struct kcopyd_job *job)
 {
+	atomic_inc(&job->kc->nr_jobs);
 	push(&_pages_jobs, job);
 	wake();
 }
@@ -670,6 +679,9 @@ int kcopyd_client_create(unsigned int nr
 		return r;
 	}
 
+	init_waitqueue_head(&kc->destroyq);
+	atomic_set(&kc->nr_jobs, 0);
+
 	client_add(kc);
 	*result = kc;
 	return 0;
@@ -677,6 +689,9 @@ int kcopyd_client_create(unsigned int nr
 
 void kcopyd_client_destroy(struct kcopyd_client *kc)
 {
+	/* Wait for completion of all jobs submitted by this client. */
+	wait_event(kc->destroyq, !atomic_read(&kc->nr_jobs));
+
 	dm_io_put(kc->nr_pages);
 	client_free_pages(kc);
 	client_del(kc);
diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index 162f979..356a09a 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -149,6 +149,15 @@ static int cxusb_power_ctrl(struct dvb_u
 		return cxusb_ctrl_msg(d, CMD_POWER_OFF, &b, 1, NULL, 0);
 }
 
+static int cxusb_bluebird_power_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	u8 b = 0;
+	if (onoff)
+		return cxusb_ctrl_msg(d, CMD_POWER_ON, &b, 1, NULL, 0);
+	else
+		return 0;
+}
+
 static int cxusb_streaming_ctrl(struct dvb_usb_device *d, int onoff)
 {
 	u8 buf[2] = { 0x03, 0x00 };
@@ -505,7 +514,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_lgdt3303_frontend_attach,
 	.tuner_attach     = cxusb_lgh064f_tuner_attach,
 
@@ -545,7 +554,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_dee1601_frontend_attach,
 	.tuner_attach     = cxusb_dee1601_tuner_attach,
 
@@ -594,7 +603,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_mt352_frontend_attach,
 	.tuner_attach     = cxusb_lgz201_tuner_attach,
 
@@ -634,7 +643,7 @@ static struct dvb_usb_properties cxusb_b
 	.size_of_priv     = sizeof(struct cxusb_state),
 
 	.streaming_ctrl   = cxusb_streaming_ctrl,
-	.power_ctrl       = cxusb_power_ctrl,
+	.power_ctrl       = cxusb_bluebird_power_ctrl,
 	.frontend_attach  = cxusb_mt352_frontend_attach,
 	.tuner_attach     = cxusb_dtt7579_tuner_attach,
 
diff --git a/drivers/media/video/saa7127.c b/drivers/media/video/saa7127.c
index 992c717..9e4c178 100644
--- a/drivers/media/video/saa7127.c
+++ b/drivers/media/video/saa7127.c
@@ -141,6 +141,7 @@ struct i2c_reg_value {
 static const struct i2c_reg_value saa7129_init_config_extra[] = {
 	{ SAA7127_REG_OUTPUT_PORT_CONTROL, 		0x38 },
 	{ SAA7127_REG_VTRIG, 				0xfa },
+	{ 0, 0 }
 };
 
 static const struct i2c_reg_value saa7127_init_config_common[] = {
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 84dcca3..fa29402 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3851,6 +3851,7 @@ #endif
 			skb_shinfo(skb)->nr_frags++;
 			skb->len += length;
 			skb->data_len += length;
+			skb->truesize += length;
 		}
 
 		e1000_rx_checksum(adapter, staterr,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 52bdf6f..fd8a50e 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -582,14 +582,14 @@ static void option_setup_urbs(struct usb
 	portdata = usb_get_serial_port_data(port);
 
 	/* Do indat endpoints first */
-	for (j = 0; j <= N_IN_URB; ++j) {
+	for (j = 0; j < N_IN_URB; ++j) {
 		portdata->in_urbs[j] = option_setup_urb (serial,
                   port->bulk_in_endpointAddress, USB_DIR_IN, port,
                   portdata->in_buffer[j], IN_BUFLEN, option_indat_callback);
 	}
 
 	/* outdat endpoints */
-	for (j = 0; j <= N_OUT_URB; ++j) {
+	for (j = 0; j < N_OUT_URB; ++j) {
 		portdata->out_urbs[j] = option_setup_urb (serial,
                   port->bulk_out_endpointAddress, USB_DIR_OUT, port,
                   portdata->out_buffer[j], OUT_BUFLEN, option_outdat_callback);
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 21195c4..4e163af 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -15,6 +15,7 @@ #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/seq_file.h>
 
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
@@ -26,8 +27,6 @@ #endif
 
 static struct kobj_map *cdev_map;
 
-#define MAX_PROBE_HASH 255	/* random */
-
 static DECLARE_MUTEX(chrdevs_lock);
 
 static struct char_device_struct {
@@ -38,93 +37,29 @@ static struct char_device_struct {
 	char name[64];
 	struct file_operations *fops;
 	struct cdev *cdev;		/* will die */
-} *chrdevs[MAX_PROBE_HASH];
+} *chrdevs[CHRDEV_MAJOR_HASH_SIZE];
 
 /* index in the above */
 static inline int major_to_index(int major)
 {
-	return major % MAX_PROBE_HASH;
-}
-
-struct chrdev_info {
-	int index;
-	struct char_device_struct *cd;
-};
-
-void *get_next_chrdev(void *dev)
-{
-	struct chrdev_info *info;
-
-	if (dev == NULL) {
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
-		if (!info)
-			goto out;
-		info->index=0;
-		info->cd = chrdevs[info->index];
-		if (info->cd)
-			goto out;
-	} else {
-		info = dev;
-	}
-
-	while (info->index < ARRAY_SIZE(chrdevs)) {
-		if (info->cd)
-			info->cd = info->cd->next;
-		if (info->cd)
-			goto out;
-		/*
-		 * No devices on this chain, move to the next
-		 */
-		info->index++;
-		info->cd = (info->index < ARRAY_SIZE(chrdevs)) ?
-			chrdevs[info->index] : NULL;
-		if (info->cd)
-			goto out;
-	}
-
-out:
-	return info;
-}
-
-void *acquire_chrdev_list(void)
-{
-	down(&chrdevs_lock);
-	return get_next_chrdev(NULL);
-}
-
-void release_chrdev_list(void *dev)
-{
-	up(&chrdevs_lock);
-	kfree(dev);
+	return major % CHRDEV_MAJOR_HASH_SIZE;
 }
 
+#ifdef CONFIG_PROC_FS
 
-int count_chrdev_list(void)
+void chrdev_show(struct seq_file *f, off_t offset)
 {
 	struct char_device_struct *cd;
-	int i, count;
-
-	count = 0;
 
-	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
-		for (cd = chrdevs[i]; cd; cd = cd->next)
-			count++;
+	if (offset < CHRDEV_MAJOR_HASH_SIZE) {
+		down(&chrdevs_lock);
+		for (cd = chrdevs[offset]; cd; cd = cd->next)
+			seq_printf(f, "%3d %s\n", cd->major, cd->name);
+		up(&chrdevs_lock);
 	}
-
-	return count;
 }
 
-int get_chrdev_info(void *dev, int *major, char **name)
-{
-	struct chrdev_info *info = dev;
-
-	if (info->cd == NULL)
-		return 1;
-
-	*major = info->cd->major;
-	*name = info->cd->name;
-	return 0;
-}
+#endif /* CONFIG_PROC_FS */
 
 /*
  * Register a single major with a specified minor range.
diff --git a/fs/compat.c b/fs/compat.c
index 5333c7d..04f6fb5 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1215,6 +1215,10 @@ static ssize_t compat_do_readv_writev(in
 	if (ret < 0)
 		goto out;
 
+	ret = security_file_permission(file, type == READ ? MAY_READ:MAY_WRITE);
+	if (ret)
+		goto out;
+
 	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 826c131..0c78312 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -249,144 +249,60 @@ static int cpuinfo_open(struct inode *in
 	return seq_open(file, &cpuinfo_op);
 }
 
-enum devinfo_states {
-	CHR_HDR,
-	CHR_LIST,
-	BLK_HDR,
-	BLK_LIST,
-	DEVINFO_DONE
-};
-
-struct devinfo_state {
-	void *chrdev;
-	void *blkdev;
-	unsigned int num_records;
-	unsigned int cur_record;
-	enum devinfo_states state;
+static struct file_operations proc_cpuinfo_operations = {
+	.open		= cpuinfo_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
-static void *devinfo_start(struct seq_file *f, loff_t *pos)
+static int devinfo_show(struct seq_file *f, void *v)
 {
-	struct devinfo_state *info = f->private;
+	int i = *(loff_t *) v;
 
-	if (*pos) {
-		if ((info) && (*pos <= info->num_records))
-			return info;
-		return NULL;
+	if (i < CHRDEV_MAJOR_HASH_SIZE) {
+		if (i == 0)
+			seq_printf(f, "Character devices:\n");
+		chrdev_show(f, i);
+	} else {
+		i -= CHRDEV_MAJOR_HASH_SIZE;
+		if (i == 0)
+			seq_printf(f, "\nBlock devices:\n");
+		blkdev_show(f, i);
 	}
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	f->private = info;
-	info->chrdev = acquire_chrdev_list();
-	info->blkdev = acquire_blkdev_list();
-	info->state = CHR_HDR;
-	info->num_records = count_chrdev_list();
-	info->num_records += count_blkdev_list();
-	info->num_records += 2; /* Character and Block headers */
-	*pos = 1;
-	info->cur_record = *pos;
-	return info;
+	return 0;
 }
 
-static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
+static void *devinfo_start(struct seq_file *f, loff_t *pos)
 {
-	int idummy;
-	char *ndummy;
-	struct devinfo_state *info = f->private;
-
-	switch (info->state) {
-		case CHR_HDR:
-			info->state = CHR_LIST;
-			(*pos)++;
-			/*fallthrough*/
-		case CHR_LIST:
-			if (get_chrdev_info(info->chrdev,&idummy,&ndummy)) {
-				/*
-				 * The character dev list is complete
-				 */
-				info->state = BLK_HDR;
-			} else {
-				info->chrdev = get_next_chrdev(info->chrdev);
-			}
-			(*pos)++;
-			break;
-		case BLK_HDR:
-			info->state = BLK_LIST;
-			(*pos)++;
-			/*fallthrough*/
-		case BLK_LIST:
-			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
-				/*
-				 * The block dev list is complete
-				 */
-				info->state = DEVINFO_DONE;
-			} else {
-				info->blkdev = get_next_blkdev(info->blkdev);
-			}
-			(*pos)++;
-			break;
-		case DEVINFO_DONE:
-			(*pos)++;
-			info->cur_record = *pos;
-			info = NULL;
-			break;
-		default:
-			break;
-	}
-	if (info)
-		info->cur_record = *pos;
-	return info;
+	if (*pos < (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_HASH_SIZE))
+		return pos;
+	return NULL;
 }
 
-static void devinfo_stop(struct seq_file *f, void *v)
+static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
 {
-	struct devinfo_state *info = f->private;
-
-	if (info) {
-		release_chrdev_list(info->chrdev);
-		release_blkdev_list(info->blkdev);
-		f->private = NULL;
-		kfree(info);
-	}
+	(*pos)++;
+	if (*pos >= (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_HASH_SIZE))
+		return NULL;
+	return pos;
 }
 
-static int devinfo_show(struct seq_file *f, void *arg)
-{
-	int major;
-	char *name;
-	struct devinfo_state *info = f->private;
-
-	switch(info->state) {
-		case CHR_HDR:
-			seq_printf(f,"Character devices:\n");
-			/* fallthrough */
-		case CHR_LIST:
-			if (!get_chrdev_info(info->chrdev,&major,&name))
-				seq_printf(f,"%3d %s\n",major,name);
-			break;
-		case BLK_HDR:
-			seq_printf(f,"\nBlock devices:\n");
-			/* fallthrough */
-		case BLK_LIST:
-			if (!get_blkdev_info(info->blkdev,&major,&name))
-				seq_printf(f,"%3d %s\n",major,name);
-			break;
-		default:
-			break;
-	}
-
-	return 0;
+static void devinfo_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
 }
 
-static  struct seq_operations devinfo_op = {
-	.start  = devinfo_start,
-	.next   = devinfo_next,
-	.stop   = devinfo_stop,
-	.show   = devinfo_show,
+static struct seq_operations devinfo_ops = {
+	.start = devinfo_start,
+	.next  = devinfo_next,
+	.stop  = devinfo_stop,
+	.show  = devinfo_show
 };
 
-static int devinfo_open(struct inode *inode, struct file *file)
+static int devinfo_open(struct inode *inode, struct file *filp)
 {
-	return seq_open(file, &devinfo_op);
+	return seq_open(filp, &devinfo_ops);
 }
 
 static struct file_operations proc_devinfo_operations = {
@@ -396,13 +312,6 @@ static struct file_operations proc_devin
 	.release	= seq_release,
 };
 
-static struct file_operations proc_cpuinfo_operations = {
-	.open		= cpuinfo_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 extern struct seq_operations vmstat_op;
 static int vmstat_open(struct inode *inode, struct file *file)
 {
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index ab8894c..9df778a 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -408,8 +408,9 @@ int reiserfs_cache_default_acl(struct in
 		acl = reiserfs_get_acl(inode, ACL_TYPE_DEFAULT);
 		reiserfs_read_unlock_xattrs(inode->i_sb);
 		reiserfs_read_unlock_xattr_i(inode);
-		ret = acl ? 1 : 0;
-		posix_acl_release(acl);
+		ret = (acl && !IS_ERR(acl));
+		if (ret)
+			posix_acl_release(acl);
 	}
 
 	return ret;
diff --git a/include/asm-i386/i387.h b/include/asm-i386/i387.h
index 7b1f011..bc1d6ed 100644
--- a/include/asm-i386/i387.h
+++ b/include/asm-i386/i387.h
@@ -58,13 +58,13 @@ static inline void __save_init_fpu( stru
 	alternative_input(
 		"fnsave %[fx] ;fwait;" GENERIC_NOP8 GENERIC_NOP4,
 		"fxsave %[fx]\n"
-		"bt $7,%[fsw] ; jc 1f ; fnclex\n1:",
+		"bt $7,%[fsw] ; jnc 1f ; fnclex\n1:",
 		X86_FEATURE_FXSR,
 		[fx] "m" (tsk->thread.i387.fxsave),
 		[fsw] "m" (tsk->thread.i387.fxsave.swd) : "memory");
 	/* AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception
 	   is pending.  Clear the x87 state here by setting it to fixed
-   	   values. __per_cpu_offset[0] is a random variable that should be in L1 */
+   	   values. safe_address is a random variable that should be in L1 */
 	alternative_input(
 		GENERIC_NOP8 GENERIC_NOP2,
 		"emms\n\t"	  	/* clear stack tags */
diff --git a/include/asm-i386/pgtable-2level.h b/include/asm-i386/pgtable-2level.h
index 74ef721..d76c61d 100644
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -18,6 +18,9 @@ #define set_pte_at(mm,addr,ptep,pteval) 
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
+
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/include/asm-i386/pgtable-3level.h b/include/asm-i386/pgtable-3level.h
index f1a8b45..3dda0f6 100644
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -85,6 +85,26 @@ ((unsigned long) __va(pud_val(pud) & PAG
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
+/*
+ * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
+ * entry, so clear the bottom half first and enforce ordering with a compiler
+ * barrier.
+ */
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	ptep->pte_low = 0;
+	smp_wmb();
+	ptep->pte_high = 0;
+}
+
+static inline void pmd_clear(pmd_t *pmd)
+{
+	u32 *tmp = (u32 *)pmd;
+	*tmp = 0;
+	smp_wmb();
+	*(tmp + 1) = 0;
+}
+
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t res;
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
index 088a945..6313403 100644
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -204,12 +204,10 @@ #undef TEST_ACCESS_OK
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 /* To avoid harmful races, pmd_none(x) should check only the lower when PAE */
 #define pmd_none(x)	(!(unsigned long)pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 
@@ -269,7 +267,7 @@ static inline pte_t ptep_get_and_clear_f
 	pte_t pte;
 	if (full) {
 		pte = *ptep;
-		*ptep = __pte(0);
+		pte_clear(mm, addr, ptep);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index 8e80205..849155a 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -654,7 +654,12 @@ static inline unsigned long fls(unsigned
 {
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_CPU_MIPS32
-	__asm__ ("clz %0, %1" : "=r" (word) : "r" (word));
+	__asm__ (
+	"	.set	mips32					\n"
+	"	clz	%0, %1					\n"
+	"	.set	mips0					\n"
+	: "=r" (word)
+	: "r" (word));
 
 	return 32 - word;
 #else
@@ -678,7 +683,12 @@ #endif /* CONFIG_32BIT */
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_CPU_MIPS64
 
-	__asm__ ("dclz %0, %1" : "=r" (word) : "r" (word));
+	__asm__ (
+	"	.set	mips64					\n"
+	"	dclz	%0, %1					\n"
+	"	.set	mips0					\n"
+	: "=r" (word)
+	: "r" (word));
 
 	return 64 - word;
 #else
diff --git a/include/asm-mips/byteorder.h b/include/asm-mips/byteorder.h
index 584f812..4ce5bc3 100644
--- a/include/asm-mips/byteorder.h
+++ b/include/asm-mips/byteorder.h
@@ -19,7 +19,9 @@ #ifdef CONFIG_CPU_MIPSR2
 static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 x)
 {
 	__asm__(
+	"	.set	mips32r2		\n"
 	"	wsbh	%0, %1			\n"
+	"	.set	mips0			\n"
 	: "=r" (x)
 	: "r" (x));
 
@@ -30,8 +32,10 @@ #define __arch__swab16(x)	___arch__swab1
 static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__(
+	"	.set	mips32r2		\n"
 	"	wsbh	%0, %1			\n"
 	"	rotr	%0, %0, 16		\n"
+	"	.set	mips0			\n"
 	: "=r" (x)
 	: "r" (x));
 
diff --git a/include/asm-mips/interrupt.h b/include/asm-mips/interrupt.h
index 7743487..50baf6b 100644
--- a/include/asm-mips/interrupt.h
+++ b/include/asm-mips/interrupt.h
@@ -20,7 +20,9 @@ __asm__ (
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	ei							\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	$1,$12						\n"
 	"	ori	$1,0x1f						\n"
@@ -63,7 +65,9 @@ __asm__ (
 	"	.set	push						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	di							\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	$1,$12						\n"
 	"	ori	$1,0x1f						\n"
@@ -103,8 +107,10 @@ __asm__ (
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_CPU_MIPSR2
+	"	.set	mips32r2					\n"
 	"	di	\\result					\n"
 	"	andi	\\result, 1					\n"
+	"	.set	mips0						\n"
 #else
 	"	mfc0	\\result, $12					\n"
 	"	ori	$1, \\result, 0x1f				\n"
@@ -133,9 +139,11 @@ #if defined(CONFIG_CPU_MIPSR2) && define
 	 * Slow, but doesn't suffer from a relativly unlikely race
 	 * condition we're having since days 1.
 	 */
+	"	.set	mips32r2					\n"
 	"	beqz	\\flags, 1f					\n"
 	"	 di							\n"
 	"	ei							\n"
+	"	.set	mips0						\n"
 	"1:								\n"
 #elif defined(CONFIG_CPU_MIPSR2)
 	/*
diff --git a/include/asm-mips/r4kcache.h b/include/asm-mips/r4kcache.h
index 0bcb79a..d9ee097 100644
--- a/include/asm-mips/r4kcache.h
+++ b/include/asm-mips/r4kcache.h
@@ -37,7 +37,7 @@ #define cache_op(op,addr)						\
 	"	cache	%0, %1					\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "i" (op), "m" (*(unsigned char *)(addr)))
+	: "i" (op), "R" (*(unsigned char *)(addr)))
 
 static inline void flush_icache_line_indexed(unsigned long addr)
 {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 60e56c6..a47ad70 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -408,6 +408,7 @@ ({						\
 })
 
 #define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
 #define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
 #define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 128d008..872042f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1383,6 +1383,7 @@ extern int bd_claim(struct block_device 
 extern void bd_release(struct block_device *);
 
 /* fs/char_dev.c */
+#define CHRDEV_MAJOR_HASH_SIZE	255
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
 extern int register_chrdev_region(dev_t, unsigned, const char *);
 extern int register_chrdev(unsigned int, const char *,
@@ -1390,25 +1391,17 @@ extern int register_chrdev(unsigned int,
 extern int unregister_chrdev(unsigned int, const char *);
 extern void unregister_chrdev_region(dev_t, unsigned);
 extern int chrdev_open(struct inode *, struct file *);
-extern int get_chrdev_list(char *);
-extern void *acquire_chrdev_list(void);
-extern int count_chrdev_list(void);
-extern void *get_next_chrdev(void *);
-extern int get_chrdev_info(void *, int *, char **);
-extern void release_chrdev_list(void *);
+extern void chrdev_show(struct seq_file *,off_t);
 
 /* fs/block_dev.c */
+#define BLKDEV_MAJOR_HASH_SIZE	255
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, void *);
 extern void close_bdev_excl(struct block_device *);
-extern void *acquire_blkdev_list(void);
-extern int count_blkdev_list(void);
-extern void *get_next_blkdev(void *);
-extern int get_blkdev_info(void *, int *, char **);
-extern void release_blkdev_list(void *);
+extern void blkdev_show(struct seq_file *,off_t);
 
 extern void init_special_inode(struct inode *, umode_t, dev_t);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d7e7e63..cfaa4a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -966,11 +966,6 @@ void audit_syscall_entry(struct task_str
 	if (context->in_syscall) {
 		struct audit_context *newctx;
 
-#if defined(__NR_vm86) && defined(__NR_vm86old)
-		/* vm86 mode should only be entered once */
-		if (major == __NR_vm86 || major == __NR_vm86old)
-			return;
-#endif
 #if AUDIT_DEBUG
 		printk(KERN_ERR
 		       "audit(:%d) pid=%d in syscall=%d;"
