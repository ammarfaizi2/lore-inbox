Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265431AbRF0WJM>; Wed, 27 Jun 2001 18:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265428AbRF0WJB>; Wed, 27 Jun 2001 18:09:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5255 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265421AbRF0WIo>; Wed, 27 Jun 2001 18:08:44 -0400
Message-ID: <3B3A58FC.2728DAFF@vnet.ibm.com>
Date: Wed, 27 Jun 2001 22:06:52 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: Changes for PCI 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  I'm looking for commentary on the following. As you might recall I had posted
a note a few days back on the lkml about the kinds of systems ppc64 runs on and
the reality of having a boatload of PCI buses out there. 

  I sure appreciate all the comments and feedback.

  Today appended below are two patches that address more or less how we've
solved the problem for ppc64 from an architecture independant standpoint.
Hopefully you will find these patches reasonable or at a minimum a starting part
for more discussion to make this happen. (Our ppc64 work is at linuxppc64.org or
in my dir on kernel.org pub/linux/kernel/people/tgall if you're interested)

  Part one is the following changes to include/linux/pci.h

  The first part changes number, primary, and secondary to unsigned ints from
chars. What we do is encode the PCI "domain" aka PCI Primary Host Bridge, aka
pci controller in with the bus number. In our case we do it like this: 

pci_controller=dev->bus->number>>8) &0xFF0000 
bus_number= dev->bus->number&0x0000FF),

  Is this reasonable for everyone?

  subordinate probably doesn't need to go to an int really when I come to think
about it as it can fit in a char, but how about in the future? A switch to an
unsigned int as well seemed prudent.

  The following 3 functions are added. Their purpose is a little different than
to add support for more than 256 buses but they are important. Skip ahead and
I'll explain what they are for....

int (*pci_read_bases)(struct pci_dev *, int cnt,int rom);  /* These optional
hooks provide */
int (*pci_read_irq)(struct pci_dev *);                     /* the arch dependant
code a way*/
int (*pci_fixup_registers)(struct pci_dev *);              /* to manage the
registers.     */


--- linux-2.4.5-ac18/include/linux/pci.h    Tue Jun 26 21:59:23 2001
+++ linuxppc64_2_4/include/linux/pci.h  Wed Jun 27 13:36:26 2001
@@ -60,6 +60,8 @@
 #define PCI_CACHE_LINE_SIZE    0x0c    /* 8 bits */ 
 #define PCI_LATENCY_TIMER  0x0d    /* 8 bits */ 
 #define PCI_HEADER_TYPE        0x0e    /* 8 bits */ 
+
+#define  PCI_MULTIFUNCTION_CARD 0x80 /* Multi-function bit in header. */
 #define  PCI_HEADER_TYPE_NORMAL    0
 #define  PCI_HEADER_TYPE_BRIDGE 1
 #define  PCI_HEADER_TYPE_CARDBUS 2
@@ -294,6 +296,13 @@
 #define PCIIOC_MMAP_IS_MEM (PCIIOC_BASE | 0x02)    /* Set mmap state to MEM
space. */
 #define PCIIOC_WRITE_COMBINE   (PCIIOC_BASE | 0x03)    /* Enable/disable
write-combining. */
 
+/* Ioctls for /proc/bus/pci/X/Y nodes. */
+#define PCIIOC_BASE        ('P' << 24 | 'C' << 16 | 'I' << 8)
+#define PCIIOC_CONTROLLER  (PCIIOC_BASE | 0x00)    /* Get controller for PCI
device. */
+#define PCIIOC_MMAP_IS_IO  (PCIIOC_BASE | 0x01)    /* Set mmap state to I/O
space. */
+#define PCIIOC_MMAP_IS_MEM (PCIIOC_BASE | 0x02)    /* Set mmap state to MEM
space. */
+#define PCIIOC_WRITE_COMBINE   (PCIIOC_BASE | 0x03)    /* Enable/disable
write-combining. */
+
 #ifdef __KERNEL__
 
 #include <linux/types.h>
@@ -409,10 +418,10 @@
    void        *sysdata;   /* hook for sys-specific extension */
    struct proc_dir_entry *procdir; /* directory entry in /proc/bus/pci */
 
-   unsigned char   number;     /* bus number */
-   unsigned char   primary;    /* number of primary bridge */
-   unsigned char   secondary;  /* number of secondary bridge */
-   unsigned char   subordinate;    /* max number of subordinate buses */
+   unsigned int  number;       /* pci_controller number + bus number */
+   unsigned int  primary;      /* number of primary bridge */
+   unsigned int  secondary;    /* number of secondary bridge */
+   unsigned int  subordinate;  /* max number of subordinate buses */
 
    char        name[48];
    unsigned short  vendor; 
@@ -449,6 +458,9 @@
    int (*write_byte)(struct pci_dev *, int where, u8 val);
    int (*write_word)(struct pci_dev *, int where, u16 val);
    int (*write_dword)(struct pci_dev *, int where, u32 val);
+   int (*pci_read_bases)(struct pci_dev *, int cnt,int rom);  /* These optional
hooks provide */
+   int (*pci_read_irq)(struct pci_dev *);                     /* the arch
dependant code a way*/
+   int (*)(struct pci_dev *);              /* to manage the registers.     */
 };
 
 struct pbus_set_ranges_data

The other file we changed is drivers/pci/pci.c

  The 3 additional functions are hooks so that an architecture has a chance to
make sure things are in order beforehand. pci_read_bases is for the management
and fixup of the BARs. pci_read_irq is the same but for IRQs.
pci_fixup_registers again same idea but for bridge resources.

  The essense of the design here is to allow you to get in and make sure
everything is ok with the card, bridge etc, beforehand so as to avoid multiple
bus walks. 

diff -u linux-2.4.5-ac18/drivers/pci/pci.c linuxppc64_2_4/drivers/pci/pci.c
--- linux-2.4.5-ac18/drivers/pci/pci.c  Tue Jun 26 21:55:54 2001
+++ linuxppc64_2_4/drivers/pci/pci.c    Tue Jun 26 08:09:31 2001
@@ -1,5 +1,5 @@
 /*
- * $Id: pci.c,v 1.91 1999/01/21 13:34:01 davem Exp $
+ *
  *
  * PCI Bus Services, see include/linux/pci.h for further explanation.
  *
@@ -745,6 +745,14 @@
    u32 l, sz;
    struct resource *res;

+   /************************************************************
+    * Check for architecture dependant call to read the BARs.
+    ************************************************************/
+   if(  dev->bus->ops->pci_read_bases != NULL) {
+       dev->bus->ops->pci_read_bases(dev, howmany, rom);
+       return;
+   }
+
    for(pos=0; pos<howmany; pos = next) {
        next = pos+1;
        res = &dev->resource[pos];
@@ -1026,6 +1034,14 @@
 static void pci_read_irq(struct pci_dev *dev)
 {
    unsigned char irq;
+
+   /************************************************************
+    * Check for architecture dependant call to read and set irg
+    ************************************************************/
+   if(dev->bus->ops->pci_read_irq != NULL) {
+       dev->bus->ops->pci_read_irq(dev);
+       return;
+   }

    pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
    if (irq)
@@ -1047,7 +1063,17 @@
 {
    u32 class;

-   sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number,
PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+   /* sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number,
PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn)); */
+
+
+        /********************************************************************
+         * Prefix the bus number with the phb number for large(>256 bus)
systems.
+         ********************************************************************/
+   sprintf(dev->slot_name, "%4x%02x:%02x.%1x",
+               ( (dev->bus->number>>8) &0xFF0000),
+               (  dev->bus->number&0x0000FF),
+               PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
    sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);

    pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
@@ -1091,6 +1117,14 @@
        printk(KERN_ERR "PCI: %s: class %x doesn't match header type %02x.
Ignoring class.\n",
               dev->slot_name, class, dev->hdr_type);
        dev->class = PCI_CLASS_NOT_DEFINED;
+   }
+
+
+   /*********************************************************************
+    * Give the architure code a chance to fix up/tweak the devices.
+    *********************************************************************/
+   if(dev->bus->ops->pci_fixup_registers != NULL) {
+       dev->bus->ops->pci_fixup_registers(dev);
    }

    /* We found a fine healthy device, go go go... */

So as Joel from MST3K used to say, "What do you think sirs?"

Regards,

Tom


-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
