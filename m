Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTFQT2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTFQT2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:28:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36497 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264900AbTFQT2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:28:34 -0400
Date: Tue, 17 Jun 2003 20:42:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Anton Blanchard <anton@samba.org>, Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617194227.GG24357@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru> <20030617124950.GF8639@krispykreme> <20030617171100.B730@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617171100.B730@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 05:11:00PM +0400, Ivan Kokshaysky wrote:
> On Tue, Jun 17, 2003 at 10:49:50PM +1000, Anton Blanchard wrote:
> > A runtime test would be useful, at least for ppc64. That would allow our
> > older machines to work (multiple host bridges without overlapping
> > buses). What if we had pci_proc_max_domain and arch code could change its
> > value during pcibios_init?
> 
> Maybe. Or pci_proc_max_domain(), which can be a macro or a real function,
> depending on arch.

I don't think this is going to work out well; it's too complicated.

How about this (PPC & Sparc64 will have to decide what they want to do
for this case):

Index: drivers/pci/proc.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/pci/proc.c,v
retrieving revision 1.9
diff -u -p -r1.9 proc.c
--- drivers/pci/proc.c	14 Jun 2003 22:15:29 -0000	1.9
+++ drivers/pci/proc.c	17 Jun 2003 19:36:50 -0000
@@ -383,7 +383,8 @@ int pci_proc_attach_device(struct pci_de
 		return -EACCES;
 
 	if (!(de = bus->procdir)) {
-		sprintf(name, "%02x", bus->number);
+		if (!pci_name_bus(name, bus))
+			return -EEXIST;
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
 		if (!de)
 			return -ENOMEM;
Index: include/asm-alpha/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-alpha/pci.h,v
retrieving revision 1.10
diff -u -p -r1.10 pci.h
--- include/asm-alpha/pci.h	14 Jun 2003 22:15:52 -0000	1.10
+++ include/asm-alpha/pci.h	17 Jun 2003 19:37:28 -0000
@@ -194,6 +194,13 @@ pcibios_resource_to_bus(struct pci_dev *
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
+/* We never have overlapping bus numbers on Alpha */
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 
 /* Values for the `which' argument to sys_pciconfig_iobase.  */
Index: include/asm-ia64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-ia64/pci.h,v
retrieving revision 1.8
diff -u -p -r1.8 pci.h
--- include/asm-ia64/pci.h	14 Jun 2003 22:15:56 -0000	1.8
+++ include/asm-ia64/pci.h	17 Jun 2003 19:37:45 -0000
@@ -93,6 +93,16 @@ struct pci_controller {
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
 #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
+
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	if (pci_domain_nr(bus) == 0) {
+		sprintf(name, "%02x", bus->number);
+	} else {
+		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	}
+	return 0;
+}
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
retrieving revision 1.17
diff -u -p -r1.17 pci.h
--- include/linux/pci.h	14 Jun 2003 22:16:01 -0000	1.17
+++ include/linux/pci.h	17 Jun 2003 19:37:56 -0000
@@ -808,6 +808,11 @@ extern int pci_pci_problems;
 
 #ifndef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
 #endif
 
 #endif /* __KERNEL__ */

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
