Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTFWCit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbTFWCit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:38:49 -0400
Received: from granite.he.net ([216.218.226.66]:64005 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264981AbTFWCiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:38:46 -0400
Date: Sun, 22 Jun 2003 19:52:07 -0700
From: Greg KH <greg@kroah.com>
To: Alex Goddard <agoddard@purdue.edu>
Cc: Florin Iucha <florin@iucha.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
Message-ID: <20030623025206.GA5891@kroah.com>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622204607.GA16386@iucha.net> <Pine.LNX.4.56.0306221615230.11747@dust> <Pine.LNX.4.56.0306221651470.16614@dust.p68.rivermarket.wintek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0306221651470.16614@dust.p68.rivermarket.wintek.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 04:58:19PM -0500, Alex Goddard wrote:
> On Sun, 22 Jun 2003, Alex Goddard wrote:
> 
> > On Sun, 22 Jun 2003, Florin Iucha wrote:
> > 
> > > drivers/built-in.o(.text+0x3106): In function `pci_remove_bus_device':
> > > : undefined reference to `pci_destroy_dev'
> > > 
> > > pci_destroy_dev is defined under CONFIG_HOTPLUG and used outside.
> > > 
> > > florin
> > > 
> > > PS: I think changeset referenced in 10560659712069@kroah.com
> > > causes the problem.
> > 
> > An attempt at a fix.  It just moves pci_desroy_dev outside the #ifdef).  
> > I have no idea if this is the correct way to fix this.  It compiles okay.
> 
> Ack.  Dumb-assed mistake in that one.  This one shouldn't die during
> compile if CONFIG_HOTPLUG is turned on.  The other one defined 
> pci_destroy_dev() twice because I'm dumb.
> 
> It does compile (with and without hotplug) and boot.

Nah, the following patch from Ivan Kokshaysky is the better way to do
this.  I'll send it off to Linus on Monday.

thanks,

greg k-h


# [PATCH] PCI: fix non-hotplug build

Current BK won't build when CONFIG_HOTPLUG is not set due to
undefined references to pci_destroy_dev in hotplug.c.
I think it makes sense to not compile hotplug.c in this case at all.
Also, this allows to get rid of several function which are unused
in non-hotplug kernel.

Tested on Alpha.

diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Sun Jun 22 19:48:43 2003
+++ b/drivers/pci/Makefile	Sun Jun 22 19:48:43 2003
@@ -3,14 +3,15 @@
 #
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
-			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o
+			names.o pci-driver.o search.o pci-sysfs.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
 obj-$(CONFIG_PCI) += setup-res.o
 endif
+
+obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Sun Jun 22 19:48:43 2003
+++ b/drivers/pci/hotplug.c	Sun Jun 22 19:48:43 2003
@@ -12,7 +12,6 @@
 
 static void pci_free_resources(struct pci_dev *dev);
 
-#ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
@@ -209,16 +208,6 @@
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-#else /* CONFIG_HOTPLUG */
-
-int pci_hotplug (struct device *dev, char **envp, int num_envp,
-		 char *buffer, int buffer_size)
-{
-	return -ENODEV;
-}
-
-#endif /* CONFIG_HOTPLUG */
-
 static void
 pci_free_resources(struct pci_dev *dev)
 {
@@ -283,7 +272,5 @@
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_remove_bus_device);
 EXPORT_SYMBOL(pci_remove_behind_bridge);
-#endif
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Sun Jun 22 19:48:43 2003
+++ b/drivers/pci/pci-driver.c	Sun Jun 22 19:48:43 2003
@@ -486,6 +486,14 @@
 		put_device(&dev->dev);
 }
 
+#ifndef CONFIG_HOTPLUG
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
+#endif
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
