Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbTABRl1>; Thu, 2 Jan 2003 12:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTABRl1>; Thu, 2 Jan 2003 12:41:27 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:1540 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S266256AbTABRlZ>;
	Thu, 2 Jan 2003 12:41:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200301021334.41895@gandalf>
To: Paul Gortmaker <p_gortmaker@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
Date: Thu, 2 Jan 2003 18:49:55 +0100
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 January 2003 04:43, Linus Torvalds wrote:
> Happy new year to you all, hopefully most of you are back from the dead 
> and the hangovers are all long gone.  And if not, I'm told reading a large 
> kernel patch is _just_ the medication for whatever ails you.
> 
> The 2.5.54 patch is largely mainly a big collection of various small
> things, all over the place (diffstat shows a long list of small changes,
> with some noticeable activity in UML, the MPT fusion driver and some of
> the fbcon drivers).
> 
> Various module updates (deprecated functions, updated loaders etc), usb, 
> m68k, x86-64 updates, kbuild stuff etc etc. 
<snip>
> Jaroslav Kysela <perex@suse.cz>:
>   o PnP update
> 

this broke the ne driver:

  gcc -Wp,-MD,drivers/net/.ne.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i586 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ne 
-DKBUILD_MODNAME=ne   -c -o drivers/net/ne.o drivers/net/ne.c
drivers/net/ne.c: In function `ne_probe_isapnp':
drivers/net/ne.c:201: warning: implicit declaration of function 
`isapnp_find_dev'
drivers/net/ne.c:204: warning: assignment makes pointer from integer without 
a cast
drivers/net/ne.c:206: dereferencing pointer to incomplete type
drivers/net/ne.c:208: dereferencing pointer to incomplete type
drivers/net/ne.c:211: dereferencing pointer to incomplete type
drivers/net/ne.c:214: dereferencing pointer to incomplete type
drivers/net/ne.c:215: dereferencing pointer to incomplete type
make[2]: *** [drivers/net/ne.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

CONFIG_PNP is not set

with drivers/pcmcia/i82365.c as an example I could get this to build (see 
patch below), as noted in Documentation/pnp.txt this is not the correct fix, 
but it works for now.

with patch below, kernel builds, boots and it servives a simple stresstest 
(the bandwidth program in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=104151288832193&w=2)

	Rudmer

--- linux-2.5.54/drivers/net/ne.c.orig	2003-01-02 14:36:14.000000000 +0100
+++ linux-2.5.54/drivers/net/ne.c	2003-01-02 16:01:33.000000000 +0100
@@ -193,32 +193,29 @@
 
 static int __init ne_probe_isapnp(struct net_device *dev)
 {
-	int i;
-
-	for (i = 0; isapnp_clone_list[i].vendor != 0; i++) {
-		struct pci_dev *idev = NULL;
+	struct isapnp_device_id *devid;
+	struct pnp_dev *idev;
 
-		while ((idev = isapnp_find_dev(NULL,
-					       isapnp_clone_list[i].vendor,
-					       isapnp_clone_list[i].function,
-					       idev))) {
-			/* Avoid already found cards from previous calls */
-			if (idev->prepare(idev))
-				continue;
-			if (idev->activate(idev))
-				continue;
-			/* if no irq, search for next */
-			if (idev->irq_resource[0].start == 0)
+	for (devid = isapnp_clone_list; devid->vendor; devid++) {
+		while ((idev = pnp_find_dev(NULL, devid->vendor,
+					       devid->function, idev))) {
+		        if (pnp_activate_dev(idev, NULL) < 0) {
+			        printk("ne.c: PNP prepare failed\n");
+				break;
+			}
+		        /* if no irq, search for next */
+			if (pnp_irq(idev, 0) == 0)
 				continue;
 			/* found it */
-			dev->base_addr = idev->resource[0].start;
-			dev->irq = idev->irq_resource[0].start;
-			printk(KERN_INFO "ne.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
-				(char *) isapnp_clone_list[i].driver_data,
-
+			dev->base_addr = pnp_port_start(idev, 0);
+			dev->irq = pnp_irq(idev, 0);
+			printk(KERN_INFO "ne.c: PNP reports %s at i/o %#lx, irq %d.\n",
+				(char *) devid->driver_data,
 				dev->base_addr, dev->irq);
+			
 			if (ne_probe1(dev, dev->base_addr) != 0) {	/* Shouldn't happen. */
-				printk(KERN_ERR "ne.c: Probe of ISAPnP card at %#lx failed.\n", 
dev->base_addr);
+				printk(KERN_ERR "ne.c: Probe of ISAPnP card at %#lx failed.\n",
+				       dev->base_addr);
 				return -ENXIO;
 			}
 			ei_status.priv = (unsigned long)idev;
@@ -783,9 +780,9 @@
 		struct net_device *dev = &dev_ne[this_dev];
 		if (dev->priv != NULL) {
 			void *priv = dev->priv;
-			struct pci_dev *idev = (struct pci_dev *)ei_status.priv;
+			struct pnp_dev *idev = (struct pnp_dev *)ei_status.priv;
 			if (idev)
-				idev->deactivate(idev);
+			        pnp_disable_dev(idev);
 			free_irq(dev->irq, dev);
 			release_region(dev->base_addr, NE_IO_EXTENT);
 			unregister_netdev(dev);
