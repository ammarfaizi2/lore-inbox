Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267349AbUHPCje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267349AbUHPCje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUHPCje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:39:34 -0400
Received: from aun.it.uu.se ([130.238.12.36]:58111 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267349AbUHPCi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:38:27 -0400
Date: Mon, 16 Aug 2004 04:38:17 +0200 (MEST)
Message-Id: <200408160238.i7G2cHOX000582@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre1] gcc34 inline failure fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch fixes a number inlining failures with gcc-3.4.1
and the 2.4.28-pre1 kernel.

There are five kinds of changes:
- Trivial removals of unusable inlines.
  + get_buffer_flushtime(): defined in fs/buffer.c, only called
    from fs/jdb/journal.c
  + nmi_watchdog_tick(): defined in arch/{i386,x86_64}/kernel/nmi.c,
    only called from arch/{i386,x86_64}/kernel/traps.c
  + SELECT_INTERRUPT(): defined in drivers/ide/ide-iops.c,
    only called from drivers/ide/ide-io.c
  + QUIRK_LIST(): defined in drivers/ide/ide-iops.c, only
    called from drivers/ide/ide-probe.c
- Removals of pointless inlines:
  + rtl8139_start_thread(): semi-heavy operation called
    infrequently
  + SELECT_DRIVE(): defined in drivers/ide/ide-iops.c, called
    from ide-iops.c and several other files; the calls in
    ide-iops.c are all in non-performance critical sections
  + SELECT_MASK(): similar to SELECT_DRIVE()
  + __mmdrop(): defined in kernel/fork.c, used in fork.c and
    several other files; the calls in fork.c are not performance
    critial enough to require inlining
- Reordering to allow inlinining:
  + drivers/scsi/sg.c: move sg_jif_to_ms(), sg_alloc_kiovec(),
    and sg_free_kiovec() to before their first call sites
  + net/sunrpc/xprt.c: move do_xprt_reserve() to before its first
    and only call site
- Wrappers to allow partial inlining of critical functions:
  + blk_get_queue(): split to allow internal calls in ll_rw_block.c
    to call the inlinable version
  + blk_seg_merge_ok(): similar to blk_get_queue()
  + ip_finish_output(): similar to blk_get_queue()
- Replacing extern inline/normal functions duplication with
  only a single set of static inlines:
  + parport_pc defines a number of low-level functions both as
    extern inlines with bodies, and as normal functions in one
    file where those functions' addresses are exported. This
    causes errors from gcc-3.4.

Most of these changes are from the 2.6 kernels. In some cases
(the "wrappers to allow partial inlining" cases) the changes enable
2.4 to continue to (partially) inline a function even when 2.6 has
elected to drop the inline attribute from that function.

Compiled and booted on i386 SMP and UP, x86_64 SMP and UP, and
ppc32 UP.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.4.28-pre1/drivers/block/ll_rw_blk.c linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/block/ll_rw_blk.c
--- linux-2.4.28-pre1/drivers/block/ll_rw_blk.c	2004-04-14 20:22:20.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/block/ll_rw_blk.c	2004-08-16 04:28:55.000000000 +0200
@@ -132,7 +132,7 @@
 	return max_sectors[MAJOR(dev)][MINOR(dev)];
 }
 
-inline request_queue_t *blk_get_queue(kdev_t dev)
+static inline request_queue_t *__blk_get_queue(kdev_t dev)
 {
 	struct blk_dev_struct *bdev = blk_dev + MAJOR(dev);
 
@@ -142,6 +142,11 @@
 		return &blk_dev[MAJOR(dev)].request_queue;
 }
 
+request_queue_t *blk_get_queue(kdev_t dev)
+{
+	return __blk_get_queue(dev);
+}
+
 static int __blk_cleanup_queue(struct request_list *list)
 {
 	struct list_head *head = &list->free;
@@ -303,7 +308,7 @@
 /*
  * can we merge the two segments, or do we need to start a new one?
  */
-inline int blk_seg_merge_ok(struct buffer_head *bh, struct buffer_head *nxt)
+static inline int __blk_seg_merge_ok(struct buffer_head *bh, struct buffer_head *nxt)
 {
 	/*
 	 * if bh and nxt are contigous and don't cross a 4g boundary, it's ok
@@ -314,6 +319,11 @@
 	return 0;
 }
 
+int blk_seg_merge_ok(struct buffer_head *bh, struct buffer_head *nxt)
+{
+	return __blk_seg_merge_ok(bh, nxt);
+}
+
 static inline int ll_new_segment(request_queue_t *q, struct request *req, int max_segments)
 {
 	if (req->nr_segments < max_segments) {
@@ -326,7 +336,7 @@
 static int ll_back_merge_fn(request_queue_t *q, struct request *req, 
 			    struct buffer_head *bh, int max_segments)
 {
-	if (blk_seg_merge_ok(req->bhtail, bh))
+	if (__blk_seg_merge_ok(req->bhtail, bh))
 		return 1;
 
 	return ll_new_segment(q, req, max_segments);
@@ -335,7 +345,7 @@
 static int ll_front_merge_fn(request_queue_t *q, struct request *req, 
 			     struct buffer_head *bh, int max_segments)
 {
-	if (blk_seg_merge_ok(bh, req->bh))
+	if (__blk_seg_merge_ok(bh, req->bh))
 		return 1;
 
 	return ll_new_segment(q, req, max_segments);
@@ -346,7 +356,7 @@
 {
 	int total_segments = req->nr_segments + next->nr_segments;
 
-	if (blk_seg_merge_ok(req->bhtail, next->bh))
+	if (__blk_seg_merge_ok(req->bhtail, next->bh))
 		total_segments--;
 
 	if (total_segments > max_segments)
@@ -1255,7 +1265,7 @@
 	 * Stacking drivers are expected to know what they are doing.
 	 */
 	do {
-		q = blk_get_queue(bh->b_rdev);
+		q = __blk_get_queue(bh->b_rdev);
 		if (!q) {
 			printk(KERN_ERR
 			       "generic_make_request: Trying to access "
diff -ruN linux-2.4.28-pre1/drivers/net/8139too.c linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/net/8139too.c
--- linux-2.4.28-pre1/drivers/net/8139too.c	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/net/8139too.c	2004-08-16 04:28:55.000000000 +0200
@@ -614,7 +614,7 @@
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int val);
-static inline void rtl8139_start_thread(struct net_device *dev);
+static void rtl8139_start_thread(struct net_device *dev);
 static void rtl8139_tx_timeout (struct net_device *dev);
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
@@ -1626,7 +1626,7 @@
 	complete_and_exit (&tp->thr_exited, 0);
 }
 
-static inline void rtl8139_start_thread(struct net_device *dev)
+static void rtl8139_start_thread(struct net_device *dev)
 {
 	struct rtl8139_private *tp = dev->priv;
 
diff -ruN linux-2.4.28-pre1/drivers/parport/parport_pc.c linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/parport/parport_pc.c
--- linux-2.4.28-pre1/drivers/parport/parport_pc.c	2004-08-16 02:23:32.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/parport/parport_pc.c	2004-08-16 04:28:55.000000000 +0200
@@ -266,95 +266,6 @@
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
 }
 
-void parport_pc_write_data(struct parport *p, unsigned char d)
-{
-	outb (d, DATA (p));
-}
-
-unsigned char parport_pc_read_data(struct parport *p)
-{
-	return inb (DATA (p));
-}
-
-void parport_pc_write_control(struct parport *p, unsigned char d)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (d & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_reverse for this!\n",
-			p->name, p->cad->name);
-		parport_pc_data_reverse (p);
-	}
-
-	__parport_pc_frob_control (p, wm, d & wm);
-}
-
-unsigned char parport_pc_read_control(struct parport *p)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-	const struct parport_pc_private *priv = p->physport->private_data;
-	return priv->ctr & wm; /* Use soft copy */
-}
-
-unsigned char parport_pc_frob_control (struct parport *p, unsigned char mask,
-				       unsigned char val)
-{
-	const unsigned char wm = (PARPORT_CONTROL_STROBE |
-				  PARPORT_CONTROL_AUTOFD |
-				  PARPORT_CONTROL_INIT |
-				  PARPORT_CONTROL_SELECT);
-
-	/* Take this out when drivers have adapted to the newer interface. */
-	if (mask & 0x20) {
-		printk (KERN_DEBUG "%s (%s): use data_%s for this!\n",
-			p->name, p->cad->name,
-			(val & 0x20) ? "reverse" : "forward");
-		if (val & 0x20)
-			parport_pc_data_reverse (p);
-		else
-			parport_pc_data_forward (p);
-	}
-
-	/* Restrict mask and val to control lines. */
-	mask &= wm;
-	val &= wm;
-
-	return __parport_pc_frob_control (p, mask, val);
-}
-
-unsigned char parport_pc_read_status(struct parport *p)
-{
-	return inb (STATUS (p));
-}
-
-void parport_pc_disable_irq(struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x10, 0);
-}
-
-void parport_pc_enable_irq(struct parport *p)
-{
-	if (p->irq != PARPORT_IRQ_NONE)
-		__parport_pc_frob_control (p, 0x10, 0x10);
-}
-
-void parport_pc_data_forward (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0);
-}
-
-void parport_pc_data_reverse (struct parport *p)
-{
-	__parport_pc_frob_control (p, 0x20, 0x20);
-}
-
 void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
 {
 	s->u.pc.ctr = 0xc;
diff -ruN linux-2.4.28-pre1/drivers/scsi/sg.c linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/scsi/sg.c
--- linux-2.4.28-pre1/drivers/scsi/sg.c	2003-11-29 00:28:13.000000000 +0100
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/drivers/scsi/sg.c	2004-08-16 04:28:55.000000000 +0200
@@ -742,6 +742,16 @@
     return 0;
 }
 
+static inline unsigned sg_jif_to_ms(int jifs)
+{
+    if (jifs <= 0)
+	return 0U;
+    else {
+	unsigned int j = (unsigned int)jifs;
+	return (j < (UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) * 1000);
+    }
+}
+
 static int sg_ioctl(struct inode * inode, struct file * filp,
                     unsigned int cmd_in, unsigned long arg)
 {
@@ -1640,6 +1650,24 @@
     return mx_sc_elems; /* number of scat_gath elements allocated */
 }
 
+static inline int sg_alloc_kiovec(int nr, struct kiobuf **bufp, int *szp)
+{
+#if SG_NEW_KIOVEC
+    return alloc_kiovec_sz(nr, bufp, szp);
+#else
+    return alloc_kiovec(nr, bufp);
+#endif
+}
+
+static inline void sg_free_kiovec(int nr, struct kiobuf **bufp, int *szp)
+{
+#if SG_NEW_KIOVEC
+    free_kiovec_sz(nr, bufp, szp);
+#else
+    free_kiovec(nr, bufp);
+#endif
+}
+
 static void sg_unmap_and(Sg_scatter_hold * schp, int free_also)
 {
 #ifdef SG_ALLOW_DIO_CODE
@@ -2568,15 +2596,6 @@
     return resp;
 }
 
-static inline int sg_alloc_kiovec(int nr, struct kiobuf **bufp, int *szp)
-{
-#if SG_NEW_KIOVEC
-    return alloc_kiovec_sz(nr, bufp, szp);
-#else
-    return alloc_kiovec(nr, bufp);
-#endif
-}
-
 static void sg_low_free(char * buff, int size, int mem_src)
 {
     if (! buff) return;
@@ -2620,15 +2639,6 @@
         sg_low_free(buff, size, mem_src);
 }
 
-static inline void sg_free_kiovec(int nr, struct kiobuf **bufp, int *szp)
-{
-#if SG_NEW_KIOVEC
-    free_kiovec_sz(nr, bufp, szp);
-#else
-    free_kiovec(nr, bufp);
-#endif
-}
-
 static int sg_ms_to_jif(unsigned int msecs)
 {
     if ((UINT_MAX / 2U) < msecs)
@@ -2638,16 +2648,6 @@
 					       : (((int)msecs / 1000) * HZ);
 }
 
-static inline unsigned sg_jif_to_ms(int jifs)
-{
-    if (jifs <= 0)
-	return 0U;
-    else {
-	unsigned int j = (unsigned int)jifs;
-	return (j < (UINT_MAX / 1000)) ? ((j * 1000) / HZ) : ((j / HZ) * 1000);
-    }
-}
-
 static unsigned char allow_ops[] = {TEST_UNIT_READY, REQUEST_SENSE,
 INQUIRY, READ_CAPACITY, READ_BUFFER, READ_6, READ_10, READ_12,
 MODE_SENSE, MODE_SENSE_10, LOG_SENSE};
diff -ruN linux-2.4.28-pre1/fs/buffer.c linux-2.4.28-pre1.gcc34-inlining-fixes/fs/buffer.c
--- linux-2.4.28-pre1/fs/buffer.c	2004-08-16 02:23:32.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/fs/buffer.c	2004-08-16 04:28:55.000000000 +0200
@@ -1122,7 +1122,7 @@
 }
 EXPORT_SYMBOL(set_buffer_flushtime);
 
-inline int get_buffer_flushtime(void)
+int get_buffer_flushtime(void)
 {
 	return bdf_prm.b_un.interval;
 }
diff -ruN linux-2.4.28-pre1/include/asm-i386/apic.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/asm-i386/apic.h
--- linux-2.4.28-pre1/include/asm-i386/apic.h	2002-08-07 00:52:24.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/asm-i386/apic.h	2004-08-16 04:28:55.000000000 +0200
@@ -77,7 +77,7 @@
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_APIC_clocks (void);
 extern void setup_apic_nmi_watchdog (void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs);
+extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -ruN linux-2.4.28-pre1/include/asm-x86_64/apic.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/asm-x86_64/apic.h
--- linux-2.4.28-pre1/include/asm-x86_64/apic.h	2003-06-14 13:30:28.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/asm-x86_64/apic.h	2004-08-16 04:28:55.000000000 +0200
@@ -78,7 +78,7 @@
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_APIC_clocks (void);
 extern void setup_apic_nmi_watchdog (void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -ruN linux-2.4.28-pre1/include/linux/blkdev.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/blkdev.h
--- linux-2.4.28-pre1/include/linux/blkdev.h	2004-02-18 15:16:24.000000000 +0100
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/blkdev.h	2004-08-16 04:28:55.000000000 +0200
@@ -233,7 +233,7 @@
 extern void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size);
 extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void generic_make_request(int rw, struct buffer_head * bh);
-extern inline request_queue_t *blk_get_queue(kdev_t dev);
+extern request_queue_t *blk_get_queue(kdev_t dev);
 extern void blkdev_release_request(struct request *);
 
 /*
@@ -246,7 +246,7 @@
 extern void blk_queue_throttle_sectors(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
-extern inline int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
+extern int blk_seg_merge_ok(struct buffer_head *, struct buffer_head *);
 
 extern int * blk_size[MAX_BLKDEV];
 
diff -ruN linux-2.4.28-pre1/include/linux/fs.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/fs.h
--- linux-2.4.28-pre1/include/linux/fs.h	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/fs.h	2004-08-16 04:28:55.000000000 +0200
@@ -1259,7 +1259,7 @@
 }
 
 extern void set_buffer_flushtime(struct buffer_head *);
-extern inline int get_buffer_flushtime(void);
+extern int get_buffer_flushtime(void);
 extern void balance_dirty(void);
 extern int check_disk_change(kdev_t);
 extern int invalidate_inodes(struct super_block *);
diff -ruN linux-2.4.28-pre1/include/linux/ide.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/ide.h
--- linux-2.4.28-pre1/include/linux/ide.h	2004-04-14 20:22:21.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/ide.h	2004-08-16 04:28:55.000000000 +0200
@@ -1445,10 +1445,10 @@
 	void			*special;
 } pkt_task_t;
 
-extern inline void SELECT_DRIVE(ide_drive_t *);
-extern inline void SELECT_INTERRUPT(ide_drive_t *);
-extern inline void SELECT_MASK(ide_drive_t *, int);
-extern inline void QUIRK_LIST(ide_drive_t *);
+extern void SELECT_DRIVE(ide_drive_t *);
+extern void SELECT_INTERRUPT(ide_drive_t *);
+extern void SELECT_MASK(ide_drive_t *, int);
+extern void QUIRK_LIST(ide_drive_t *);
 
 extern void ata_input_data(ide_drive_t *, void *, u32);
 extern void ata_output_data(ide_drive_t *, void *, u32);
diff -ruN linux-2.4.28-pre1/include/linux/parport_pc.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/parport_pc.h
--- linux-2.4.28-pre1/include/linux/parport_pc.h	2001-07-04 11:57:09.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/parport_pc.h	2004-08-16 04:28:55.000000000 +0200
@@ -41,7 +41,7 @@
 	struct pci_dev *dev;
 };
 
-extern __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
+static __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
 {
 #ifdef DEBUG_PARPORT
 	printk (KERN_DEBUG "parport_pc_write_data(%p,0x%02x)\n", p, d);
@@ -49,7 +49,7 @@
 	outb(d, DATA(p));
 }
 
-extern __inline__ unsigned char parport_pc_read_data(struct parport *p)
+static __inline__ unsigned char parport_pc_read_data(struct parport *p)
 {
 	unsigned char val = inb (DATA (p));
 #ifdef DEBUG_PARPORT
@@ -124,17 +124,17 @@
 	return ctr;
 }
 
-extern __inline__ void parport_pc_data_reverse (struct parport *p)
+static __inline__ void parport_pc_data_reverse (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x20);
 }
 
-extern __inline__ void parport_pc_data_forward (struct parport *p)
+static __inline__ void parport_pc_data_forward (struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x20, 0x00);
 }
 
-extern __inline__ void parport_pc_write_control (struct parport *p,
+static __inline__ void parport_pc_write_control (struct parport *p,
 						 unsigned char d)
 {
 	const unsigned char wm = (PARPORT_CONTROL_STROBE |
@@ -152,7 +152,7 @@
 	__parport_pc_frob_control (p, wm, d & wm);
 }
 
-extern __inline__ unsigned char parport_pc_read_control(struct parport *p)
+static __inline__ unsigned char parport_pc_read_control(struct parport *p)
 {
 	const unsigned char rm = (PARPORT_CONTROL_STROBE |
 				  PARPORT_CONTROL_AUTOFD |
@@ -162,7 +162,7 @@
 	return priv->ctr & rm; /* Use soft copy */
 }
 
-extern __inline__ unsigned char parport_pc_frob_control (struct parport *p,
+static __inline__ unsigned char parport_pc_frob_control (struct parport *p,
 							 unsigned char mask,
 							 unsigned char val)
 {
@@ -189,18 +189,18 @@
 	return __parport_pc_frob_control (p, mask, val);
 }
 
-extern __inline__ unsigned char parport_pc_read_status(struct parport *p)
+static __inline__ unsigned char parport_pc_read_status(struct parport *p)
 {
 	return inb(STATUS(p));
 }
 
 
-extern __inline__ void parport_pc_disable_irq(struct parport *p)
+static __inline__ void parport_pc_disable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x00);
 }
 
-extern __inline__ void parport_pc_enable_irq(struct parport *p)
+static __inline__ void parport_pc_enable_irq(struct parport *p)
 {
 	__parport_pc_frob_control (p, 0x10, 0x10);
 }
diff -ruN linux-2.4.28-pre1/include/linux/sched.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/sched.h
--- linux-2.4.28-pre1/include/linux/sched.h	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/linux/sched.h	2004-08-16 04:28:55.000000000 +0200
@@ -763,7 +763,7 @@
 extern void end_lazy_tlb(struct mm_struct *mm);
 
 /* mmdrop drops the mm and the page tables */
-extern inline void FASTCALL(__mmdrop(struct mm_struct *));
+extern void FASTCALL(__mmdrop(struct mm_struct *));
 static inline void mmdrop(struct mm_struct * mm)
 {
 	if (atomic_dec_and_test(&mm->mm_count))
diff -ruN linux-2.4.28-pre1/include/net/ip.h linux-2.4.28-pre1.gcc34-inlining-fixes/include/net/ip.h
--- linux-2.4.28-pre1/include/net/ip.h	2003-11-29 00:28:14.000000000 +0100
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/include/net/ip.h	2004-08-16 04:28:55.000000000 +0200
@@ -137,7 +137,7 @@
 void ip_send_reply(struct sock *sk, struct sk_buff *skb, struct ip_reply_arg *arg,
 		   unsigned int len); 
 
-extern __inline__ int ip_finish_output(struct sk_buff *skb);
+extern int ip_finish_output(struct sk_buff *skb);
 
 struct ipv4_config
 {
diff -ruN linux-2.4.28-pre1/kernel/fork.c linux-2.4.28-pre1.gcc34-inlining-fixes/kernel/fork.c
--- linux-2.4.28-pre1/kernel/fork.c	2004-08-16 02:23:32.000000000 +0200
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/kernel/fork.c	2004-08-16 04:28:55.000000000 +0200
@@ -264,7 +264,7 @@
  * is dropped: either by a lazy thread or by
  * mmput. Free the page directory and the mm.
  */
-inline void fastcall __mmdrop(struct mm_struct *mm)
+void fastcall __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	pgd_free(mm->pgd);
diff -ruN linux-2.4.28-pre1/net/ipv4/ip_output.c linux-2.4.28-pre1.gcc34-inlining-fixes/net/ipv4/ip_output.c
--- linux-2.4.28-pre1/net/ipv4/ip_output.c	2003-11-29 00:28:15.000000000 +0100
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/net/ipv4/ip_output.c	2004-08-16 04:28:55.000000000 +0200
@@ -184,7 +184,7 @@
 	return -EINVAL;
 }
 
-__inline__ int ip_finish_output(struct sk_buff *skb)
+static __inline__ int __ip_finish_output(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dst->dev;
 
@@ -195,6 +195,11 @@
 		       ip_finish_output2);
 }
 
+int ip_finish_output(struct sk_buff *skb)
+{
+	return __ip_finish_output(skb);
+}
+
 int ip_mc_output(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
@@ -253,7 +258,7 @@
 				newskb->dev, ip_dev_loopback_xmit);
 	}
 
-	return ip_finish_output(skb);
+	return __ip_finish_output(skb);
 }
 
 int ip_output(struct sk_buff *skb)
@@ -269,7 +274,7 @@
 		ip_do_nat(skb);
 #endif
 
-	return ip_finish_output(skb);
+	return __ip_finish_output(skb);
 }
 
 /* Queues a packet to be sent, and starts the transmitter if necessary.  
diff -ruN linux-2.4.28-pre1/net/sunrpc/xprt.c linux-2.4.28-pre1.gcc34-inlining-fixes/net/sunrpc/xprt.c
--- linux-2.4.28-pre1/net/sunrpc/xprt.c	2003-11-29 00:28:15.000000000 +0100
+++ linux-2.4.28-pre1.gcc34-inlining-fixes/net/sunrpc/xprt.c	2004-08-16 04:28:55.000000000 +0200
@@ -1244,19 +1244,6 @@
 /*
  * Reserve an RPC call slot.
  */
-void
-xprt_reserve(struct rpc_task *task)
-{
-	struct rpc_xprt	*xprt = task->tk_xprt;
-
-	task->tk_status = -EIO;
-	if (!xprt->shutdown) {
-		spin_lock(&xprt->xprt_lock);
-		do_xprt_reserve(task);
-		spin_unlock(&xprt->xprt_lock);
-	}
-}
-
 static inline void
 do_xprt_reserve(struct rpc_task *task)
 {
@@ -1279,6 +1266,19 @@
 	rpc_sleep_on(&xprt->backlog, task, NULL, NULL);
 }
 
+void
+xprt_reserve(struct rpc_task *task)
+{
+	struct rpc_xprt	*xprt = task->tk_xprt;
+
+	task->tk_status = -EIO;
+	if (!xprt->shutdown) {
+		spin_lock(&xprt->xprt_lock);
+		do_xprt_reserve(task);
+		spin_unlock(&xprt->xprt_lock);
+	}
+}
+
 /*
  * Allocate a 'unique' XID
  */
