Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287997AbSAMJSy>; Sun, 13 Jan 2002 04:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288018AbSAMJSq>; Sun, 13 Jan 2002 04:18:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:26005 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S287997AbSAMJSb>; Sun, 13 Jan 2002 04:18:31 -0500
Date: Sun, 13 Jan 2002 11:17:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <t.sailer@alumni.ethz.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Power down board during suspend (ESS Solo1 2.4-OSS)
In-Reply-To: <3C40164C.A8D524EA@scs.ch>
Message-ID: <Pine.LNX.4.33.0201131117020.28980-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002, Thomas Sailer wrote:

> Zwane Mwaikambo wrote:
> >
> > Patch to suspend the board in addition to what the current code does
> > (reset sequencer & FIFO etc...).
>
> There is no patch attached 8-)
>
> Tom

Wow don't i feel smart :)

--- linux-2.4.18-pre2/drivers/sound/esssolo1.c.orig	Sun Sep 30 21:26:08 2001
+++ linux-2.4.18-pre2/drivers/sound/esssolo1.c	Sat Jan 12 11:05:26 2002
@@ -82,6 +82,8 @@
  *    22.05.2001   0.19  more cleanups, changed PM to PCI 2.4 style, got rid
  *                       of global list of devices, using pci device data.
  *                       Marcus Meissner <mm@caldera.de>
+ *    11.01.2002   0.20	 Added full power management support (power down board)
+ *			 Zwane Mwaikambo <zwane@commfireservices.com>
  */

 /*****************************************************************************/
@@ -188,6 +190,7 @@
 	struct semaphore open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
+	int in_suspend;

 	struct dmabuf {
 		void *rawbuf;
@@ -1698,6 +1701,10 @@
 	intsrc = inb(s->iobase+7); /* get interrupt source(s) */
 	if (!intsrc)
 		return;
+
+	if (unlikely(s->in_suspend))
+		return;
+
 	(void)inb(s->sbbase+0xe);  /* clear interrupt */
 	spin_lock(&s->lock);
 	/* clear audio interrupts first */
@@ -2261,24 +2268,35 @@
 static int
 solo1_suspend(struct pci_dev *pci_dev, u32 state) {
 	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+
 	if (!s)
 		return 1;
+
+	s->in_suspend = 1;
 	outb(0, s->iobase+6);
 	/* DMA master clear */
 	outb(0, s->ddmabase+0xd);
 	/* reset sequencer and FIFO */
-	outb(3, s->sbbase+6);
+	outb(3, s->sbbase+6);
+	/* Pulse to request a suspend, hold the FM synth as well */
+	outb(0xe0, s->sbbase+7);	/* high */
+	outb(0x30, s->sbbase+7);	/* low */
 	/* turn off DDMA controller address space */
-	pci_write_config_word(s->dev, 0x60, 0);
+	pci_write_config_word(s->dev, 0x60, 0);
+
 	return 0;
 }

 static int
 solo1_resume(struct pci_dev *pci_dev) {
 	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
+
 	if (!s)
 		return 1;
+
+	s->in_suspend = 0;
 	setup_solo1(s);
+
 	return 0;
 }

@@ -2318,6 +2336,7 @@
 	init_waitqueue_head(&s->midi.owait);
 	init_MUTEX(&s->open_sem);
 	spin_lock_init(&s->lock);
+	s->in_suspend = 0;
 	s->magic = SOLO1_MAGIC;
 	s->dev = pcidev;
 	s->iobase = pci_resource_start(pcidev, 0);
@@ -2456,7 +2475,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.19 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.20 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;

