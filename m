Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVKHXfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVKHXfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVKHXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:35:37 -0500
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:26535 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S964955AbVKHXfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:35:37 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char: Conversions from kmalloc/memset to kzalloc.
Message-Id: <20051108233454.B95F020A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 00:34:54 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Conversions from kmalloc/memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/char/amiserial.c   |    3 +--
 drivers/char/consolemap.c  |    7 ++-----
 drivers/char/epca.c        |    5 ++---
 drivers/char/esp.c         |    6 ++----
 drivers/char/hvc_console.c |    4 +---
 drivers/char/hvcs.c        |    6 ++----
 drivers/char/keyboard.c    |    3 +--
 drivers/char/n_hdlc.c      |    4 +---
 drivers/char/qtronix.c     |    3 +--
 drivers/char/random.c      |    6 ++----
 drivers/char/rocket.c      |    3 +--
 drivers/char/snsc.c        |    6 ++----
 drivers/char/snsc_event.c  |    3 +--
 drivers/char/synclink.c    |    4 +---
 drivers/char/synclinkmp.c  |    4 +---
 drivers/char/tty_io.c      |   18 +++++-------------
 drivers/char/vt.c          |    3 +--
 17 files changed, 27 insertions(+), 61 deletions(-)

applies-to: 63f175a1886b9263462b1a8927c323a2c768d29c
11b705bc43d5ee99a4d083827c2bd0faeaebe597
diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
index a124f8c..f886620 100644
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -1756,12 +1756,11 @@ static int get_async_struct(int line, st
 		*ret_info = sstate->info;
 		return 0;
 	}
-	info = kmalloc(sizeof(struct async_struct), GFP_KERNEL);
+	info = kzalloc(sizeof(struct async_struct), GFP_KERNEL);
 	if (!info) {
 		sstate->count--;
 		return -ENOMEM;
 	}
-	memset(info, 0, sizeof(struct async_struct));
 #ifdef DECLARE_WAITQUEUE
 	init_waitqueue_head(&info->open_wait);
 	init_waitqueue_head(&info->close_wait);
diff --git a/drivers/char/consolemap.c b/drivers/char/consolemap.c
index c85a4fa..27e60e7 100644
--- a/drivers/char/consolemap.c
+++ b/drivers/char/consolemap.c
@@ -193,11 +193,9 @@ static void set_inverse_transl(struct vc
 	q = p->inverse_translations[i];
 
 	if (!q) {
-		q = p->inverse_translations[i] = (unsigned char *) 
-			kmalloc(MAX_GLYPH, GFP_KERNEL);
+		q = p->inverse_translations[i] = kzalloc(MAX_GLYPH, GFP_KERNEL);
 		if (!q) return;
 	}
-	memset(q, 0, MAX_GLYPH);
 
 	for (j = 0; j < E_TABSZ; j++) {
 		glyph = conv_uni_to_pc(conp, t[j]);
@@ -444,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
 	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
 	if (p && p->readonly) return -EIO;
 	if (!p || --p->refcount) {
-		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
+		q = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!q) {
 			if (p) p->refcount++;
 			return -ENOMEM;
 		}
-		memset(q, 0, sizeof(*q));
 		q->refcount=1;
 		*vc->vc_uni_pagedir_loc = (unsigned long)q;
 	} else {
diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index b7a0e4d..20471b8 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -1639,15 +1639,14 @@ static void post_fep_init(unsigned int c
 
 		spin_unlock_irqrestore(&epca_lock, flags);
 
-		ch->tmp_buf = kmalloc(ch->txbufsize,GFP_KERNEL);
+		ch->tmp_buf = kzalloc(ch->txbufsize,GFP_KERNEL);
 		if (!ch->tmp_buf) {
 			printk(KERN_ERR "POST FEP INIT : kmalloc failed for port 0x%x\n",i);
 			release_region((int)bd->port, 4);
 			while(i-- > 0)
 				kfree((ch--)->tmp_buf);
 			return;
-		} else
-			memset((void *)ch->tmp_buf,0,ch->txbufsize);
+		}
 	} /* End for each port */
 
 	printk(KERN_INFO 
diff --git a/drivers/char/esp.c b/drivers/char/esp.c
index 9f53d2f..cfdb944 100644
--- a/drivers/char/esp.c
+++ b/drivers/char/esp.c
@@ -2495,7 +2495,7 @@ static int __init espserial_init(void)
 		return 1;
 	}
 
-	info = kmalloc(sizeof(struct esp_struct), GFP_KERNEL);
+	info = kzalloc(sizeof(struct esp_struct), GFP_KERNEL);
 
 	if (!info)
 	{
@@ -2505,7 +2505,6 @@ static int __init espserial_init(void)
 		return 1;
 	}
 
-	memset((void *)info, 0, sizeof(struct esp_struct));
 	/* rx_trigger, tx_trigger are needed by autoconfig */
 	info->config.rx_trigger = rx_trigger;
 	info->config.tx_trigger = tx_trigger;
@@ -2563,7 +2562,7 @@ static int __init espserial_init(void)
 		if (!dma)
 			info->stat_flags |= ESP_STAT_NEVER_DMA;
 
-		info = kmalloc(sizeof(struct esp_struct), GFP_KERNEL);
+		info = kzalloc(sizeof(struct esp_struct), GFP_KERNEL);
 		if (!info)
 		{
 			printk(KERN_ERR "Couldn't allocate memory for esp serial device information\n"); 
@@ -2572,7 +2571,6 @@ static int __init espserial_init(void)
 			return 0;
 		}
 
-		memset((void *)info, 0, sizeof(struct esp_struct));
 		/* rx_trigger, tx_trigger are needed by autoconfig */
 		info->config.rx_trigger = rx_trigger;
 		info->config.tx_trigger = tx_trigger;
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index f921776..b8e846e 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -746,12 +746,10 @@ struct hvc_struct __devinit *hvc_alloc(u
 	struct hvc_struct *hp;
 	int i;
 
-	hp = kmalloc(sizeof(*hp), GFP_KERNEL);
+	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
 
-	memset(hp, 0x00, sizeof(*hp));
-
 	hp->vtermno = vtermno;
 	hp->irq = irq;
 	hp->ops = ops;
diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
index 53dc77c..f409b74 100644
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -624,13 +624,11 @@ static int __devinit hvcs_probe(
 		return -EFAULT;
 	}
 
-	hvcsd = kmalloc(sizeof(*hvcsd), GFP_KERNEL);
+	/* hvcsd->tty is zeroed out with the memset */
+	hvcsd = kzalloc(sizeof(*hvcsd), GFP_KERNEL);
 	if (!hvcsd)
 		return -ENODEV;
 
-	/* hvcsd->tty is zeroed out with the memset */
-	memset(hvcsd, 0x00, sizeof(*hvcsd));
-
 	spin_lock_init(&hvcsd->lock);
 	/* Automatically incs the refcount the first time */
 	kobject_init(&hvcsd->kobj);
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 449d029..d2fdedb 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1188,9 +1188,8 @@ static struct input_handle *kbd_connect(
 	if (i == BTN_MISC && !test_bit(EV_SND, dev->evbit))
 		return NULL;
 
-	if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
+	if (!(handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL)))
 		return NULL;
-	memset(handle, 0, sizeof(struct input_handle));
 
 	handle->dev = dev;
 	handle->handler = handler;
diff --git a/drivers/char/n_hdlc.c b/drivers/char/n_hdlc.c
index c3660d8..f82cc02 100644
--- a/drivers/char/n_hdlc.c
+++ b/drivers/char/n_hdlc.c
@@ -819,13 +819,11 @@ static struct n_hdlc *n_hdlc_alloc(void)
 {
 	struct n_hdlc_buf *buf;
 	int i;
-	struct n_hdlc *n_hdlc = kmalloc(sizeof(*n_hdlc), GFP_KERNEL);
+	struct n_hdlc *n_hdlc = kzalloc(sizeof(*n_hdlc), GFP_KERNEL);
 
 	if (!n_hdlc)
 		return NULL;
 
-	memset(n_hdlc, 0, sizeof(*n_hdlc));
-
 	n_hdlc_buf_list_init(&n_hdlc->rx_free_buf_list);
 	n_hdlc_buf_list_init(&n_hdlc->tx_free_buf_list);
 	n_hdlc_buf_list_init(&n_hdlc->rx_buf_list);
diff --git a/drivers/char/qtronix.c b/drivers/char/qtronix.c
index 601d09b..e85fec2 100644
--- a/drivers/char/qtronix.c
+++ b/drivers/char/qtronix.c
@@ -590,13 +590,12 @@ static int __init psaux_init(void)
 	if(retval < 0)
 		return retval;
 
-	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue) {
 		misc_deregister(&psaux_mouse);
 		return -ENOMEM;
 	}
 		
-	memset(queue, 0, sizeof(*queue));
 	queue->head = queue->tail = 0;
 	init_waitqueue_head(&queue->proc_list);
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7999da2..351e92c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -912,9 +912,8 @@ void rand_initialize_irq(int irq)
 	 * If kmalloc returns null, we just won't use that entropy
 	 * source.
 	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
 	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
 		irq_timer_state[irq] = state;
 	}
 }
@@ -927,9 +926,8 @@ void rand_initialize_disk(struct gendisk
 	 * If kmalloc returns null, we just won't use that entropy
 	 * source.
 	 */
-	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
+	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
 	if (state) {
-		memset(state, 0, sizeof(struct timer_rand_state));
 		disk->random = state;
 	}
 }
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index d3bc731..e3ec2ec 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -653,12 +653,11 @@ static void init_r_port(int board, int a
 	ctlp = sCtlNumToCtlPtr(board);
 
 	/*  Get a r_port struct for the port, fill it in and save it globally, indexed by line number */
-	info = kmalloc(sizeof (struct r_port), GFP_KERNEL);
+	info = kzalloc(sizeof (struct r_port), GFP_KERNEL);
 	if (!info) {
 		printk(KERN_INFO "Couldn't allocate info struct for line #%d\n", line);
 		return;
 	}
-	memset(info, 0, sizeof (struct r_port));
 
 	info->magic = RPORT_MAGIC;
 	info->line = line;
diff --git a/drivers/char/snsc.c b/drivers/char/snsc.c
index 0e7d216..c6d268a 100644
--- a/drivers/char/snsc.c
+++ b/drivers/char/snsc.c
@@ -77,7 +77,7 @@ scdrv_open(struct inode *inode, struct f
 	scd = container_of(inode->i_cdev, struct sysctl_data_s, scd_cdev);
 
 	/* allocate memory for subchannel data */
-	sd = kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
+	sd = kzalloc(sizeof (struct subch_data_s), GFP_KERNEL);
 	if (sd == NULL) {
 		printk("%s: couldn't allocate subchannel data\n",
 		       __FUNCTION__);
@@ -85,7 +85,6 @@ scdrv_open(struct inode *inode, struct f
 	}
 
 	/* initialize subch_data_s fields */
-	memset(sd, 0, sizeof (struct subch_data_s));
 	sd->sd_nasid = scd->scd_nasid;
 	sd->sd_subch = ia64_sn_irtr_open(scd->scd_nasid);
 
@@ -394,7 +393,7 @@ scdrv_init(void)
 			sprintf(devnamep, "#%d", geo_slab(geoid));
 
 			/* allocate sysctl device data */
-			scd = kmalloc(sizeof (struct sysctl_data_s),
+			scd = kzalloc(sizeof (struct sysctl_data_s),
 				      GFP_KERNEL);
 			if (!scd) {
 				printk("%s: failed to allocate device info"
@@ -402,7 +401,6 @@ scdrv_init(void)
 				       SYSCTL_BASENAME, devname);
 				continue;
 			}
-			memset(scd, 0, sizeof (struct sysctl_data_s));
 
 			/* initialize sysctl device data fields */
 			scd->scd_nasid = cnodeid_to_nasid(cnode);
diff --git a/drivers/char/snsc_event.c b/drivers/char/snsc_event.c
index baaa365..4c35b15 100644
--- a/drivers/char/snsc_event.c
+++ b/drivers/char/snsc_event.c
@@ -271,7 +271,7 @@ scdrv_event_init(struct sysctl_data_s *s
 {
 	int rv;
 
-	event_sd = kmalloc(sizeof (struct subch_data_s), GFP_KERNEL);
+	event_sd = kzalloc(sizeof (struct subch_data_s), GFP_KERNEL);
 	if (event_sd == NULL) {
 		printk(KERN_WARNING "%s: couldn't allocate subchannel info"
 		       " for event monitoring\n", __FUNCTION__);
@@ -279,7 +279,6 @@ scdrv_event_init(struct sysctl_data_s *s
 	}
 
 	/* initialize subch_data_s fields */
-	memset(event_sd, 0, sizeof (struct subch_data_s));
 	event_sd->sd_nasid = scd->scd_nasid;
 	spin_lock_init(&event_sd->sd_rlock);
 
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index 5d1ffa3..3ccb929 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -4364,13 +4364,11 @@ static struct mgsl_struct* mgsl_allocate
 {
 	struct mgsl_struct *info;
 	
-	info = (struct mgsl_struct *)kmalloc(sizeof(struct mgsl_struct),
-		 GFP_KERNEL);
+	info = kzalloc(sizeof(struct mgsl_struct), GFP_KERNEL);
 		 
 	if (!info) {
 		printk("Error can't allocate device instance data\n");
 	} else {
-		memset(info, 0, sizeof(struct mgsl_struct));
 		info->magic = MGSL_MAGIC;
 		INIT_WORK(&info->task, mgsl_bh_handler, info);
 		info->max_frame_size = 4096;
diff --git a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
index 7c063c5..da12ca0 100644
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -3807,14 +3807,12 @@ static SLMP_INFO *alloc_dev(int adapter_
 {
 	SLMP_INFO *info;
 
-	info = (SLMP_INFO *)kmalloc(sizeof(SLMP_INFO),
-		 GFP_KERNEL);
+	info = kzalloc(sizeof(SLMP_INFO), GFP_KERNEL);
 
 	if (!info) {
 		printk("%s(%d) Error can't allocate device instance data for adapter %d, port %d\n",
 			__FILE__,__LINE__, adapter_num, port_num);
 	} else {
-		memset(info, 0, sizeof(SLMP_INFO));
 		info->magic = MGSL_MAGIC;
 		INIT_WORK(&info->task, bh_handler, info);
 		info->max_frame_size = 4096;
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 4b1eef5..46c045d 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -160,9 +160,7 @@ static struct tty_struct *alloc_tty_stru
 {
 	struct tty_struct *tty;
 
-	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
-	if (tty)
-		memset(tty, 0, sizeof(struct tty_struct));
+	tty = kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
 	return tty;
 }
 
@@ -1276,11 +1274,9 @@ static int init_dev(struct tty_driver *d
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct termios *) kmalloc(sizeof(struct termios),
-						 GFP_KERNEL);
+		ltp = kzalloc(sizeof(struct termios), GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
-		memset(ltp, 0, sizeof(struct termios));
 	}
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY) {
@@ -1309,11 +1305,9 @@ static int init_dev(struct tty_driver *d
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct termios *)
-				kmalloc(sizeof(struct termios), GFP_KERNEL);
+			o_ltp = kzalloc(sizeof(struct termios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
-			memset(o_ltp, 0, sizeof(struct termios));
 		}
 
 		/*
@@ -2749,9 +2743,8 @@ struct tty_driver *alloc_tty_driver(int 
 {
 	struct tty_driver *driver;
 
-	driver = kmalloc(sizeof(struct tty_driver), GFP_KERNEL);
+	driver = kzalloc(sizeof(struct tty_driver), GFP_KERNEL);
 	if (driver) {
-		memset(driver, 0, sizeof(struct tty_driver));
 		driver->magic = TTY_DRIVER_MAGIC;
 		driver->num = lines;
 		/* later we'll move allocation of tables here */
@@ -2810,10 +2803,9 @@ int tty_register_driver(struct tty_drive
 		return 0;
 
 	if (!(driver->flags & TTY_DRIVER_DEVPTS_MEM)) {
-		p = kmalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
+		p = kzalloc(driver->num * 3 * sizeof(void *), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
-		memset(p, 0, driver->num * 3 * sizeof(void *));
 	}
 
 	if (!driver->major) {
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index e91268e..38e4ca7 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -709,10 +709,9 @@ int vc_allocate(unsigned int currcons)	/
 	    /* although the numbers above are not valid since long ago, the
 	       point is still up-to-date and the comment still has its value
 	       even if only as a historical artifact.  --mj, July 1998 */
-	    vc = kmalloc(sizeof(struct vc_data), GFP_KERNEL);
+	    vc = kzalloc(sizeof(struct vc_data), GFP_KERNEL);
 	    if (!vc)
 		return -ENOMEM;
-	    memset(vc, 0, sizeof(*vc));
 	    vc_cons[currcons].d = vc;
 	    visual_init(vc, currcons, 1);
 	    if (!*vc->vc_uni_pagedir_loc)
---
0.99.9.GIT
