Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVIEUYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVIEUYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVIEUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:24:36 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:3685 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932485AbVIEUYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:24:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gL2e7Gh5WbebtlvVWYDZZtbqCUPEd/BAEwxVFXeA9siHqE6YmfawEdJuRPee598XU5MOMDvXEHl9wZqvPARwtdlmqG8wMNjNyMEPTKyMo61Os+IwNPwiQ9gHsVKDbeE3ffD0FfENU7OpOZ0Mq0GoQFlnoJGhXvt5YWt7GR51sxQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Omnikey Cardman 4040 driver
Date: Mon, 5 Sep 2005 22:25:44 +0200
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20050905195404.GA16056@rama.de.gnumonks.org> <200509052205.41468.jesper.juhl@gmail.com>
In-Reply-To: <200509052205.41468.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509052225.44964.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 22:05, Jesper Juhl wrote:
> On Monday 05 September 2005 21:54, Harald Welte wrote:
> > Hi!
> > 
> > I've now incorporated all the suggested changes (thanks once again on
> > the many comments received).  The resulting driver has been tested and
> > works fine.
> > 
> > Please consider applying the driver to the mainline tree, thanks.
> > 
> What did you diff this against?  When I applied it to the 2.6.13 source I got :
> 
> patching file MAINTAINERS
> Hunk #1 succeeded at 1730 (offset -7 lines).
> patching file drivers/char/pcmcia/Kconfig
> patching file drivers/char/pcmcia/Makefile
> patching file drivers/char/pcmcia/cm4040_cs.c
> patching file drivers/char/pcmcia/cm4040_cs.h
> 
> Anyway, I did a small cleanup.
>  Removed all instances of trailing whitespace ( sed -r s/"[ \t]+$"/""/ ).
>  Removed some excessive (IMHO) use of blank lines.
>  A few CodingStyle related whitespace fixes (spaces after "," etc).
>  Removed some pointless casts.
> 
> Hope this is useful to you (applies on top of the version you just posted).
> 

Actually, forget the previous patch, I forgot a few things. Improved patch can
be found below (a few extra cleanups of spacing and make the header look a 
little more pretty).

/Jesper Juhl


--- drivers/char/pcmcia/cm4040_cs.c.orig	2005-09-05 21:39:05.000000000 +0200
+++ drivers/char/pcmcia/cm4040_cs.c	2005-09-05 22:20:38.000000000 +0200
@@ -1,4 +1,4 @@
- /*
+/*
  * A driver for the Omnikey PCMCIA smartcard reader CardMan 4040
  *
  * (c) 2000-2004 Omnikey AG (http://www.omnikey.com/)
@@ -68,28 +68,25 @@ static char *version =
 static void reader_release(dev_link_t *link);
 static void reader_detach(dev_link_t *link);
 
-static int major;	
+static int major;
 
 #define		BS_READABLE	0x01
 #define		BS_WRITABLE	0x02
 
 struct reader_dev {
-	dev_link_t		link;		
-	dev_node_t		node;		
-	wait_queue_head_t	devq;	
-
+	dev_link_t		link;
+	dev_node_t		node;
+	wait_queue_head_t	devq;
 	wait_queue_head_t	poll_wait;
 	wait_queue_head_t	read_wait;
 	wait_queue_head_t	write_wait;
-
 	unsigned int 	  	buffer_status;
-
 	unsigned int      	timer_expired;
 	struct timer_list	timer;
 	unsigned long     	timeout;
 	unsigned char     	s_buf[READ_WRITE_BUFFER_SIZE];
 	unsigned char     	r_buf[READ_WRITE_BUFFER_SIZE];
-	struct task_struct 	*owner;	
+	struct task_struct 	*owner;
 };
 
 static dev_info_t dev_info = MODULE_NAME;
@@ -104,7 +101,7 @@ static struct timer_list cm4040_poll_tim
 static inline void xoutb(unsigned char val, unsigned short port)
 {
 	DEBUG(7, "outb(val=%.2x,port=%.4x)\n", val, port);
-	outb(val,port);
+	outb(val, port);
 }
 
 static inline unsigned char xinb(unsigned short port)
@@ -122,7 +119,7 @@ static inline unsigned char xinb(unsigne
 static void cm4040_do_poll(unsigned long dummy)
 {
 	unsigned int i;
-	/* walk through all devices */	
+	/* walk through all devices */
 	for (i = 0; dev_table[i]; i++) {
 		dev_link_t *dl = dev_table[i];
 		struct reader_dev *dev = dl->priv;
@@ -156,7 +153,7 @@ static int wait_for_bulk_out_ready(struc
 	int i, rc;
 	int iobase = dev->link.io.BasePort1;
 
-	for (i=0; i < POLL_LOOP_COUNT; i++) {
+	for (i = 0; i < POLL_LOOP_COUNT; i++) {
 		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
 		    & BSR_BULK_OUT_FULL) == 0) {
 			DEBUG(4, "BulkOut empty (i=%d)\n", i);
@@ -191,7 +188,7 @@ static int write_sync_reg(unsigned char 
 	if (rc <= 0)
 		return rc;
 
-	xoutb(val,iobase + REG_OFFSET_SYNC_CONTROL);
+	xoutb(val, iobase + REG_OFFSET_SYNC_CONTROL);
 	rc = wait_for_bulk_out_ready(dev);
 	if (rc <= 0)
 		return rc;
@@ -204,7 +201,7 @@ static int wait_for_bulk_in_ready(struct
 	int i, rc;
 	int iobase = dev->link.io.BasePort1;
 
-	for (i=0; i < POLL_LOOP_COUNT; i++) {
+	for (i = 0; i < POLL_LOOP_COUNT; i++) {
 		if ((xinb(iobase + REG_OFFSET_BUFFER_STATUS)
 		    & BSR_BULK_IN_FULL) == BSR_BULK_IN_FULL) {
 			DEBUG(3, "BulkIn full (i=%d)\n", i);
@@ -215,7 +212,7 @@ static int wait_for_bulk_in_ready(struct
 	DEBUG(4, "wait_event_interruptible_timeout(timeout=%ld\n",
 		dev->timeout);
 	rc = wait_event_interruptible_timeout(dev->read_wait,
-					      test_and_clear_bit(BS_READABLE, 
+					      test_and_clear_bit(BS_READABLE,
 						 	&dev->buffer_status),
 					      dev->timeout);
 	if (rc > 0)
@@ -231,7 +228,7 @@ static int wait_for_bulk_in_ready(struct
 static ssize_t cm4040_read(struct file *filp, char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	struct reader_dev *dev = (struct reader_dev *) filp->private_data;
+	struct reader_dev *dev = filp->private_data;
 	int iobase = dev->link.io.BasePort1;
 	unsigned long bytes_to_read;
 	unsigned long i;
@@ -239,7 +236,7 @@ static ssize_t cm4040_read(struct file *
 	int rc;
 	unsigned char uc;
 
-	DEBUG(2, "-> cm4040_read(%s,%d)\n", current->comm,current->pid);
+	DEBUG(2, "-> cm4040_read(%s,%d)\n", current->comm, current->pid);
 
 	if (count == 0)
 		return 0;
@@ -247,17 +244,17 @@ static ssize_t cm4040_read(struct file *
 	if (count < 10)
 		return -EFAULT;
 
-	if (filp->f_flags & O_NONBLOCK) { 
+	if (filp->f_flags & O_NONBLOCK) {
 		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
 		DEBUG(2, "<- cm4040_read (failure)\n");
 		return -EAGAIN;
 	}
 
-	if ((dev->link.state & DEV_PRESENT)==0)	
+	if ((dev->link.state & DEV_PRESENT) == 0)
 		return -ENODEV;
 
 	schedule_timeout(1*HZ);
-	for (i=0; i<5; i++) {
+	for (i = 0; i < 5; i++) {
 		rc = wait_for_bulk_in_ready(dev);
 		if (rc <= 0) {
 			DEBUG(5,"wait_for_bulk_in_ready rc=%.2x\n",rc);
@@ -284,7 +281,7 @@ static ssize_t cm4040_read(struct file *
 
 	DEBUG(6, "Min=%lu\n", min_bytes_to_read);
 
-	for (i=0; i < (min_bytes_to_read-5); i++) {
+	for (i = 0; i < (min_bytes_to_read-5); i++) {
 		rc = wait_for_bulk_in_ready(dev);
 		if (rc <= 0) {
 			DEBUG(5,"wait_for_bulk_in_ready rc=%.2x\n",rc);
@@ -302,7 +299,6 @@ static ssize_t cm4040_read(struct file *
 	if (copy_to_user(buf, dev->r_buf, min_bytes_to_read))
 		return -EFAULT;
 
-
 	rc = wait_for_bulk_in_ready(dev);
 	if (rc <= 0) {
 		DEBUG(5,"wait_for_bulk_in_ready rc=%.2x\n",rc);
@@ -331,11 +327,11 @@ static ssize_t cm4040_read(struct file *
 static ssize_t cm4040_write(struct file *filp, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct reader_dev *dev = (struct reader_dev *) filp->private_data;
+	struct reader_dev *dev = filp->private_data;
 	int iobase = dev->link.io.BasePort1;
 	ssize_t rc;
 	int i;
-	unsigned int bytes_to_write; 
+	unsigned int bytes_to_write;
 
 	DEBUG(2, "-> cm4040_write(%s,%d)\n", current->comm, current->pid);
 
@@ -349,13 +345,13 @@ static ssize_t cm4040_write(struct file 
 		return -EIO;
 	}
 
-	if (filp->f_flags & O_NONBLOCK) { 
+	if (filp->f_flags & O_NONBLOCK) {
 		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
 		DEBUG(4, "<- cm4040_write (failure)\n");
 		return -EAGAIN;
 	}
 
-	if ((dev->link.state & DEV_PRESENT) == 0)	
+	if ((dev->link.state & DEV_PRESENT) == 0)
 		return -ENODEV;
 
 	bytes_to_write = count;
@@ -377,7 +373,7 @@ static ssize_t cm4040_write(struct file 
 		case CMD_PC_TO_RDR_GETSLOTSTATUS:
 		case CMD_PC_TO_RDR_ICCPOWEROFF:
 		case CMD_PC_TO_RDR_GETPARAMETERS:
-		case CMD_PC_TO_RDR_RESETPARAMETERS:  
+		case CMD_PC_TO_RDR_RESETPARAMETERS:
 		case CMD_PC_TO_RDR_SETPARAMETERS:
 		case CMD_PC_TO_RDR_ESCAPE:
 		case CMD_PC_TO_RDR_ICCCLOCK:
@@ -396,10 +392,9 @@ static ssize_t cm4040_write(struct file 
 			return -EIO;
 	}
 
-
 	DEBUG(4, "start \n");
 
-	for (i=0; i < bytes_to_write; i++) {
+	for (i = 0; i < bytes_to_write; i++) {
 		rc = wait_for_bulk_out_ready(dev);
 		if (rc <= 0) {
 			DEBUG(5, "wait_for_bulk_out_ready rc=%.2Zx\n", rc);
@@ -409,7 +404,7 @@ static ssize_t cm4040_write(struct file 
 			else
 				return -EIO;
 		}
-	 
+
 		xoutb(dev->s_buf[i],iobase + REG_OFFSET_BULK_OUT);
 		DEBUG(4, "%.2x ", dev->s_buf[i]);
 	}
@@ -432,7 +427,7 @@ static ssize_t cm4040_write(struct file 
 
 static unsigned int cm4040_poll(struct file *filp, poll_table *wait)
 {
-	struct reader_dev *dev = (struct reader_dev *) filp->private_data;
+	struct reader_dev *dev = filp->private_data;
 	unsigned int mask = 0;
 
 	poll_wait(filp, &dev->poll_wait, wait);
@@ -465,7 +460,7 @@ static int cm4040_open(struct inode *ino
 	}
 	link = dev_table[MINOR(inode->i_rdev)];
 	if (link == NULL || !(DEV_OK(link))) {
-		DEBUG(4, "link== NULL || DEV_OK false\n");
+		DEBUG(4, "link == NULL || DEV_OK false\n");
 		DEBUG(4, "<- cm4040_open (failure)\n");
 		return -ENODEV;
 	}
@@ -478,14 +473,14 @@ static int cm4040_open(struct inode *ino
 	dev = (struct reader_dev *)link->priv;
 	filp->private_data = dev;
 
-	if (filp->f_flags & O_NONBLOCK) { 
+	if (filp->f_flags & O_NONBLOCK) {
 		DEBUG(4, "filep->f_flags O_NONBLOCK set\n");
 		DEBUG(4, "<- cm4040_open (failure)\n");
 		return -EAGAIN;
 	}
 
 	dev->owner = current;
-	link->open = 1;		
+	link->open = 1;
 
 	atomic_inc(&cm4040_num_devices_open);
 	mod_timer(&cm4040_poll_timer, jiffies + POLL_PERIOD);
@@ -494,7 +489,7 @@ static int cm4040_open(struct inode *ino
 	return nonseekable_open(inode, filp);
 }
 
-static int cm4040_close(struct inode *inode,struct file *filp)
+static int cm4040_close(struct inode *inode, struct file *filp)
 {
 	struct reader_dev *dev;
 	dev_link_t *link;
@@ -511,10 +506,10 @@ static int cm4040_close(struct inode *in
 	if (link == NULL)
 		return -ENODEV;
 
-	dev = (struct reader_dev *) link->priv;
+	dev = link->priv;
 
 	link->open = 0;
-	wake_up(&dev->devq);	
+	wake_up(&dev->devq);
 
 	atomic_dec(&cm4040_num_devices_open);
 
@@ -524,16 +519,16 @@ static int cm4040_close(struct inode *in
 
 static void cm4040_reader_release(dev_link_t *link)
 {
-	struct reader_dev *dev = (struct reader_dev *) link->priv;
+	struct reader_dev *dev = link->priv;
 
-	DEBUG(3, "-> cm4040_reader_release\n"); 
+	DEBUG(3, "-> cm4040_reader_release\n");
 	while (link->open) {
 		DEBUG(3, KERN_INFO MODULE_NAME ": delaying release until "
 		      "process '%s', pid %d has terminated\n",
-		      dev->owner->comm,dev->owner->pid);
+		      dev->owner->comm, dev->owner->pid);
  		wait_event(dev->devq, (link->open == 0));
 	}
-	DEBUG(3, "<- cm4040_reader_release\n"); 
+	DEBUG(3, "<- cm4040_reader_release\n");
 	return;
 }
 
@@ -600,7 +595,7 @@ static void reader_config(dev_link_t *li
 
 		DEBUG(2, "tupleIndex=%d\n", parse.cftable_entry.index);
 		link->conf.ConfigIndex = parse.cftable_entry.index;
-		
+
 		if (!parse.cftable_entry.io.nwin)
 			continue;
 
@@ -621,8 +616,8 @@ static void reader_config(dev_link_t *li
 		rc = pcmcia_request_io(handle, &link->io);
 		if (rc == CS_SUCCESS) {
 			DEBUG(2, "RequestIO OK\n");
-			break; 
-		} else 
+			break;
+		} else
 			DEBUG(2, "RequestIO failed\n");
 	}
 	if (rc != CS_SUCCESS) {
@@ -684,7 +679,7 @@ static int reader_event(event_t event, i
 		case CS_EVENT_CARD_INSERTION:
 			DEBUG(5, "CS_EVENT_CARD_INSERTION\n");
 			link->state |= DEV_PRESENT | DEV_CONFIG_PENDING;
-			reader_config(link,devno);
+			reader_config(link, devno);
 			break;
 		case CS_EVENT_CARD_REMOVAL:
 			DEBUG(5, "CS_EVENT_CARD_REMOVAL\n");
@@ -694,7 +689,7 @@ static int reader_event(event_t event, i
 			DEBUG(5, "CS_EVENT_PM_SUSPEND "
 			      "(fall-through to CS_EVENT_RESET_PHYSICAL)\n");
 			link->state |= DEV_SUSPEND;
-		
+
 		case CS_EVENT_RESET_PHYSICAL:
 			DEBUG(5, "CS_EVENT_RESET_PHYSICAL\n");
 			if (link->state & DEV_CONFIG) {
@@ -706,7 +701,7 @@ static int reader_event(event_t event, i
 			DEBUG(5, "CS_EVENT_PM_RESUME "
 			      "(fall-through to CS_EVENT_CARD_RESET)\n");
 			link->state &= ~DEV_SUSPEND;
-		
+
 		case CS_EVENT_CARD_RESET:
 			DEBUG(5, "CS_EVENT_CARD_RESET\n");
 			if ((link->state & DEV_CONFIG)) {
@@ -728,7 +723,7 @@ static void reader_release(dev_link_t *l
 	int rc;
 
 	DEBUG(3, "-> reader_release\n");
-	cm4040_reader_release(link->priv); 
+	cm4040_reader_release(link->priv);
 	rc = pcmcia_release_configuration(link->handle);
 	if (rc != CS_SUCCESS)
 		DEBUG(5, "couldn't ReleaseConfiguration "
@@ -748,7 +743,7 @@ static dev_link_t *reader_attach(void)
 	int i;
 
 	DEBUG(3, "reader_attach\n");
-	for (i=0; i < CM_MAX_DEV; i++) {
+	for (i = 0; i < CM_MAX_DEV; i++) {
 		if (dev_table[i] == NULL)
 			break;
 	}
@@ -757,7 +752,7 @@ static dev_link_t *reader_attach(void)
 		printk(KERN_NOTICE "all devices in use\n");
 		return NULL;
 	}
-	
+
 	DEBUG(5, "create reader device instance\n");
 	dev = kmalloc(sizeof(struct reader_dev), GFP_KERNEL);
 	if (dev == NULL)
@@ -774,7 +769,6 @@ static dev_link_t *reader_attach(void)
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	dev_table[i] = link;
 
-	
 	DEBUG(5, "Register with Card Services\n");
 	client_reg.dev_info = &dev_info;
 	client_reg.Attributes = INFO_IO_CLIENT | INFO_CARD_SHARE;
@@ -829,7 +823,7 @@ static void reader_detach(dev_link_t *li
 			break;
 	}
 	if (i == CM_MAX_DEV) {
-		printk(KERN_WARNING MODULE_NAME 
+		printk(KERN_WARNING MODULE_NAME
 			": detach for unkown device aborted\n");
 		return;
 	}
@@ -849,7 +843,7 @@ static struct file_operations reader_fop
 
 static struct pcmcia_device_id cm4040_ids[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x0223, 0x0200),
-	PCMCIA_DEVICE_PROD_ID12("OMNIKEY", "CardMan 4040", 
+	PCMCIA_DEVICE_PROD_ID12("OMNIKEY", "CardMan 4040",
 				0xE32CDD8C, 0x8F23318B),
 	PCMCIA_DEVICE_NULL,
 };
@@ -884,7 +878,7 @@ static void __exit cm4040_exit(void)
 	int i;
 
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
-	pcmcia_unregister_driver(&reader_driver);  
+	pcmcia_unregister_driver(&reader_driver);
 	for (i = 0; i < CM_MAX_DEV; i++) {
 		if (dev_table[i])
 			reader_detach_by_devno(i, dev_table[i]);
--- drivers/char/pcmcia/cm4040_cs.h.orig	2005-09-05 22:17:14.000000000 +0200
+++ drivers/char/pcmcia/cm4040_cs.h	2005-09-05 22:24:35.000000000 +0200
@@ -1,47 +1,45 @@
-#ifndef	_CM4040_H_
-#define	_CM4040_H_
+#ifndef _CM4040_H_
+#define _CM4040_H_
 
-#define	CM_MAX_DEV		4
+#define CM_MAX_DEV			4
 
-#define	DEVICE_NAME		"cmx"
-#define	MODULE_NAME		"cm4040_cs"
+#define DEVICE_NAME			"cmx"
+#define MODULE_NAME			"cm4040_cs"
 
-#define REG_OFFSET_BULK_OUT      0
-#define REG_OFFSET_BULK_IN       0
-#define REG_OFFSET_BUFFER_STATUS 1
-#define REG_OFFSET_SYNC_CONTROL  2
-
-#define BSR_BULK_IN_FULL  0x02
-#define BSR_BULK_OUT_FULL 0x01
-
-#define SCR_HOST_TO_READER_START 0x80
-#define SCR_ABORT                0x40
-#define SCR_EN_NOTIFY            0x20
-#define SCR_ACK_NOTIFY           0x10
-#define SCR_READER_TO_HOST_DONE  0x08
-#define SCR_HOST_TO_READER_DONE  0x04
-#define SCR_PULSE_INTERRUPT      0x02
-#define SCR_POWER_DOWN           0x01
-
-
-#define  CMD_PC_TO_RDR_ICCPOWERON       0x62
-#define  CMD_PC_TO_RDR_GETSLOTSTATUS    0x65
-#define  CMD_PC_TO_RDR_ICCPOWEROFF      0x63
-#define  CMD_PC_TO_RDR_SECURE           0x69
-#define  CMD_PC_TO_RDR_GETPARAMETERS    0x6C
-#define  CMD_PC_TO_RDR_RESETPARAMETERS  0x6D
-#define  CMD_PC_TO_RDR_SETPARAMETERS    0x61
-#define  CMD_PC_TO_RDR_XFRBLOCK         0x6F
-#define  CMD_PC_TO_RDR_ESCAPE           0x6B
-#define  CMD_PC_TO_RDR_ICCCLOCK         0x6E
-#define  CMD_PC_TO_RDR_TEST_SECURE      0x74
-#define  CMD_PC_TO_RDR_OK_SECURE        0x89
-
-
-#define  CMD_RDR_TO_PC_SLOTSTATUS         0x81
-#define  CMD_RDR_TO_PC_DATABLOCK          0x80
-#define  CMD_RDR_TO_PC_PARAMETERS         0x82
-#define  CMD_RDR_TO_PC_ESCAPE             0x83
-#define  CMD_RDR_TO_PC_OK_SECURE          0x89
+#define REG_OFFSET_BULK_OUT		0
+#define REG_OFFSET_BULK_IN		0
+#define REG_OFFSET_BUFFER_STATUS	1
+#define REG_OFFSET_SYNC_CONTROL		2
+
+#define BSR_BULK_IN_FULL		0x02
+#define BSR_BULK_OUT_FULL		0x01
+
+#define SCR_HOST_TO_READER_START	0x80
+#define SCR_ABORT			0x40
+#define SCR_EN_NOTIFY			0x20
+#define SCR_ACK_NOTIFY			0x10
+#define SCR_READER_TO_HOST_DONE		0x08
+#define SCR_HOST_TO_READER_DONE		0x04
+#define SCR_PULSE_INTERRUPT		0x02
+#define SCR_POWER_DOWN			0x01
+
+#define CMD_PC_TO_RDR_ICCPOWERON	0x62
+#define CMD_PC_TO_RDR_GETSLOTSTATUS	0x65
+#define CMD_PC_TO_RDR_ICCPOWEROFF	0x63
+#define CMD_PC_TO_RDR_SECURE		0x69
+#define CMD_PC_TO_RDR_GETPARAMETERS	0x6C
+#define CMD_PC_TO_RDR_RESETPARAMETERS	0x6D
+#define CMD_PC_TO_RDR_SETPARAMETERS	0x61
+#define CMD_PC_TO_RDR_XFRBLOCK		0x6F
+#define CMD_PC_TO_RDR_ESCAPE		0x6B
+#define CMD_PC_TO_RDR_ICCCLOCK		0x6E
+#define CMD_PC_TO_RDR_TEST_SECURE	0x74
+#define CMD_PC_TO_RDR_OK_SECURE		0x89
+
+#define CMD_RDR_TO_PC_SLOTSTATUS	0x81
+#define CMD_RDR_TO_PC_DATABLOCK		0x80
+#define CMD_RDR_TO_PC_PARAMETERS	0x82
+#define CMD_RDR_TO_PC_ESCAPE		0x83
+#define CMD_RDR_TO_PC_OK_SECURE		0x89
 
 #endif	/* _CM4040_H_ */




