Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVINJXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVINJXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVINJXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:23:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965100AbVINJXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:23:48 -0400
Date: Wed, 14 Sep 2005 02:23:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2/2] New Omnikey Cardman 4000 driver
Message-Id: <20050914022314.35eab48d.akpm@osdl.org>
In-Reply-To: <20050913155333.GZ29695@sunbeam.de.gnumonks.org>
References: <20050913155333.GZ29695@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> wrote:
>
> Add new Omnikey Cardman 4000 smartcard reader driver

- All the open-coded mdelays() are wrong:

  #define	T_10MSEC	msecs_to_jiffies(10)
  ...
		mdelay(T_10MSEC);

  mdelay() already takes a jiffies argument.

- terminate_monitor() should use del_timer_sync().



Plus:

- Work around gcc-2.95.x macro expansion bug

- unneeded initialisation of static (yes, it's a bit sleazy, but it shrinks
  the on-disk kernel image)

- Use ARRAY_SIZE

- Unneeded void* typecasts

- Use kzalloc()


diff -puN drivers/char/pcmcia/cm4000_cs.c~new-omnikey-cardman-4000-driver-fixes drivers/char/pcmcia/cm4000_cs.c
--- devel/drivers/char/pcmcia/cm4000_cs.c~new-omnikey-cardman-4000-driver-fixes	2005-09-14 02:20:26.000000000 -0700
+++ devel-akpm/drivers/char/pcmcia/cm4000_cs.c	2005-09-14 02:20:26.000000000 -0700
@@ -51,7 +51,7 @@ module_param(pc_debug, int, 0600);
 #define DEBUGP(n, rdr, x, args...) do { 				\
 	if (pc_debug >= (n))						\
 		dev_printk(KERN_DEBUG, reader_to_dev(rdr), "%s:" x, 	\
-			   __FUNCTION__, ## args);			\
+			   __FUNCTION__ , ## args);			\
 	} while (0)
 #else
 #define DEBUGP(n, rdr, x, args...)
@@ -157,7 +157,7 @@ struct cm4000_dev {
 		/*queue*/ 4*sizeof(wait_queue_head_t))
 
 static dev_info_t dev_info = MODULE_NAME;
-static dev_link_t *dev_table[CM4000_MAX_DEV] = { NULL, };
+static dev_link_t *dev_table[CM4000_MAX_DEV];
 
 /* This table doesn't use spaces after the comma between fields and thus
  * violates CodingStyle.  However, I don't really think wrapping it around will
@@ -470,7 +470,7 @@ static void set_cardparameter(struct cm4
 	      ((dev->baudv - 1) & 0xFF));
 
 	/* set stopbits */
-	for (i = 0; i < sizeof(card_fixups)/sizeof(struct card_fixup); i++) {
+	for (i = 0; i < ARRAY_SIZE(card_fixups); i++) {
 		if (!memcmp(dev->atr, card_fixups[i].atr,
 			    card_fixups[i].atr_len))
 			stopbits = card_fixups[i].stopbits;
@@ -502,9 +502,8 @@ static int set_protocol(struct cm4000_de
 	dev->pts[0] = 0xff;
 	dev->pts[1] = 0x00;
 	tmp = ptsreq->protocol;
-	while ((tmp = (tmp >> 1)) > 0) {
+	while ((tmp = (tmp >> 1)) > 0)
 		dev->pts[1]++;
-	}
 	dev->proto = dev->pts[1];	/* Set new protocol */
 	dev->pts[1] = (0x01 << 4) | (dev->pts[1]);
 
@@ -962,7 +961,7 @@ return_with_timer:
 static ssize_t cmm_read(struct file *filp, __user char *buf, size_t count,
 			loff_t *ppos)
 {
-	struct cm4000_dev *dev = (struct cm4000_dev *) filp->private_data;
+	struct cm4000_dev *dev = filp->private_data;
 	ioaddr_t iobase = dev->link.io.BasePort1;
 	ssize_t rc;
 	int i, j, k;
@@ -1440,7 +1439,7 @@ static void stop_monitor(struct cm4000_d
 static int cmm_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
 		     unsigned long arg)
 {
-	struct cm4000_dev *dev = (struct cm4000_dev *) filp->private_data;
+	struct cm4000_dev *dev = filp->private_data;
 	ioaddr_t iobase = dev->link.io.BasePort1;
 	dev_link_t *link;
 	int size;
@@ -1673,7 +1672,7 @@ static int cmm_open(struct inode *inode,
 	if (link->open)
 		return -EBUSY;
 
-	dev = (struct cm4000_dev *) link->priv;
+	dev = link->priv;
 	filp->private_data = dev;
 
 	DEBUGP(2, dev, "-> cmm_open(device=%d.%d process=%s,%d)\n",
@@ -1719,7 +1718,7 @@ static int cmm_close(struct inode *inode
 	if (link == NULL)
 		return -ENODEV;
 
-	dev = (struct cm4000_dev *) link->priv;
+	dev = link->priv;
 
 	DEBUGP(2, dev, "-> cmm_close(maj/min=%d.%d)\n",
 	       imajor(inode), minor);
@@ -1737,7 +1736,7 @@ static int cmm_close(struct inode *inode
 
 static void cmm_cm4000_release(dev_link_t * link)
 {
-	struct cm4000_dev *dev = (struct cm4000_dev *) link->priv;
+	struct cm4000_dev *dev = link->priv;
 
 	/* dont terminate the monitor, rather rely on
 	 * close doing that for us.
@@ -1952,11 +1951,10 @@ static dev_link_t *cm4000_attach(void)
 	}
 
 	/* create a new cm4000_cs device */
-	dev = kmalloc(sizeof(struct cm4000_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct cm4000_dev), GFP_KERNEL);
 	if (dev == NULL)
 		return NULL;
 
-	memset(dev, 0, sizeof(struct cm4000_dev));
 	link = &dev->link;
 	link->priv = dev;
 	link->conf.IntType = INT_MEMORY_AND_IO;
_

