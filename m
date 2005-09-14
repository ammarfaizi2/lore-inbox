Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbVINJUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbVINJUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVINJUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:20:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965102AbVINJUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:20:21 -0400
Date: Wed, 14 Sep 2005 02:19:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 1/2] New Omnikey Cardman 4040 driver
Message-Id: <20050914021943.681d8f05.akpm@osdl.org>
In-Reply-To: <20050913163951.GA29695@sunbeam.de.gnumonks.org>
References: <20050913155116.GY29695@sunbeam.de.gnumonks.org>
	<29495f1d050913090219cc44fa@mail.gmail.com>
	<20050913163951.GA29695@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> wrote:
>
> Add new Omnikey Cardman 4040 smartcard reader driver
>

I see a timer, but I see no del_timer_sync() anywhere.  Cannot the timer be
left pending after device shutdown or rmmod?

Plus:


- Work around gcc-2.95.x macro expansion bug

- unneded void* cast

- use kzalloc()


diff -puN drivers/char/pcmcia/cm4040_cs.c~new-omnikey-cardman-4040-driver-fixes drivers/char/pcmcia/cm4040_cs.c
--- devel/drivers/char/pcmcia/cm4040_cs.c~new-omnikey-cardman-4040-driver-fixes	2005-09-14 02:05:46.000000000 -0700
+++ devel-akpm/drivers/char/pcmcia/cm4040_cs.c	2005-09-14 02:05:46.000000000 -0700
@@ -46,7 +46,7 @@ module_param(pc_debug, int, 0600);
 #define DEBUGP(n, rdr, x, args...) do { 				\
 	if (pc_debug >= (n)) 						\
 		dev_printk(KERN_DEBUG, reader_to_dev(rdr), "%s:" x, 	\
-			   __FUNCTION__, ##args); 			\
+			   __FUNCTION__ , ##args); 			\
 	} while (0)
 #else
 #define DEBUGP(n, rdr, x, args...)
@@ -453,7 +453,7 @@ static int cm4040_open(struct inode *ino
 	if (link->open)
 		return -EBUSY;
 
-	dev = (struct reader_dev *)link->priv;
+	dev = link->priv;
 	filp->private_data = dev;
 
 	if (filp->f_flags & O_NONBLOCK) {
@@ -705,11 +705,10 @@ static dev_link_t *reader_attach(void)
 	if (i == CM_MAX_DEV)
 		return NULL;
 
-	dev = kmalloc(sizeof(struct reader_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct reader_dev), GFP_KERNEL);
 	if (dev == NULL)
 		return NULL;
 
-	memset(dev, 0, sizeof(struct reader_dev));
 	dev->timeout = CCID_DRIVER_MINIMUM_TIMEOUT;
 	dev->buffer_status = 0;
 
_

