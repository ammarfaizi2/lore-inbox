Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319098AbSHSXkt>; Mon, 19 Aug 2002 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319104AbSHSXkt>; Mon, 19 Aug 2002 19:40:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:896 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319098AbSHSXkr>;
	Mon, 19 Aug 2002 19:40:47 -0400
Message-ID: <3D61822D.3060409@us.ibm.com>
Date: Mon, 19 Aug 2002 16:41:33 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       jgarzik@mandrakesoft.com,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>, hannal@us.ibm.com
Subject: Re: [patch] PCI Cleanup
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com> <Pine.LNX.4.44.0208151014210.849-100000@chaos.physics.uiowa.edu> <20020815163645.GC35918@us.ibm.com> <20020816223451.GA6323@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070103070301080001050208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070103070301080001050208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg,
	Here is the numaq portion of the cleanup.  This is the part that I was 
originally intending to fix when this whole thing started.  This patch makes 
the PCI busses on the secondary quads for NUMA-Q working.

Please add this to the pile of PCI cleanups.

Thanks!

-Matt

Greg KH wrote:
> On Thu, Aug 15, 2002 at 09:36:45AM -0700, Greg KH wrote:
> 
>>If there are no complaints, I think I'll go implement this, and move the
>>functions into the main pci code so that other parts of the kernel (like
>>ACPI) can use them.
> 
> 
> Ok, here's the patch that goes on top of Matt's previous patch, moving
> the pci_ops functions to be pci_bus based instead of pci_dev, like they
> are today.  This enables us to get rid of all of the pci_*_nodev
> functions in the pci hotplug core (that's 245 lines removed :)  It's
> currently running on the machine I'm typing this from.
> 
> I used the devfn as a paramater instead of the function and slot, as
> some archs just take the devfn and move it around before using it.  If
> there were two paramaters, we would be splitting the values apart, and
> then putting them back together for every function.
> 
> This is only for i386, if there's no complaints I'll knock out the other
> archs before submitting it.
> 
> thanks,
> 
> greg k-h

--------------070103070301080001050208
Content-Type: text/plain;
 name="numaq_pci_fix-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numaq_pci_fix-2531.patch"

diff -Nur linux-2.5.31-patched/arch/i386/pci/numa.c linux-2.5.31-numaq/arch/i386/pci/numa.c
--- linux-2.5.31-patched/arch/i386/pci/numa.c	Wed Aug 14 11:07:13 2002
+++ linux-2.5.31-numaq/arch/i386/pci/numa.c	Wed Aug 14 11:11:58 2002
@@ -1,19 +1,19 @@
 /*
  * numa.c - Low-level PCI access for NUMA-Q machines
  */
+
 #include <linux/pci.h>
 #include <linux/init.h>
-
 #include "pci.h"
 
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
-#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
+#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -22,7 +22,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -41,7 +41,7 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int __pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -50,7 +50,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -69,6 +69,25 @@
 	return 0;
 }
 
+#undef PCI_CONF1_MQ_ADDRESS
+
+static int pci_conf1_mq_read(struct pci_dev *dev, int where, int size, u32 *value)
+{
+	return __pci_conf1_mq_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
+}
+
+static int pci_conf1_mq_write(struct pci_dev *dev, int where, int size, u32 value)
+{
+	return __pci_conf1_mq_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, size, value);
+}
+
+static struct pci_ops pci_direct_conf1_mq = {
+	read:	pci_conf1_mq_read,
+	write:	pci_conf1_mq_write
+};
+
 
 static void __devinit pci_fixup_i450nx(struct pci_dev *d)
 {
@@ -102,8 +121,7 @@
 {
 	int quad;
 
-	pci_config_read = pci_conf1_read;
-	pci_config_write = pci_conf1_write;
+	pci_root_ops = &pci_direct_conf1_mq;
 
 	if (pcibios_scanned++)
 		return 0;

--------------070103070301080001050208--

