Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADBpB>; Wed, 3 Jan 2001 20:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRADBov>; Wed, 3 Jan 2001 20:44:51 -0500
Received: from ns1.megapath.net ([216.200.176.4]:13838 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129267AbRADBog>;
	Wed, 3 Jan 2001 20:44:36 -0500
Message-ID: <3A53D547.3070502@megapathdsl.net>
Date: Wed, 03 Jan 2001 17:43:35 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: David Brownell <david-b@pacbell.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when it
		 isinserted into a Cardbus slot.
In-Reply-To: <3A53187B.9030601@megapathdsl.net> <032e01c07595$7be8b8c0$6600000a@brownell.org> <3A53C8AA.8060103@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the pci.c patch from test12-pre6.  Does anything in this patch
look like it might cause the cardbus device detection and calling of
hotplug to break?

diff -u --recursive --new-file v2.4.0-test11/linux/drivers/pci/pci.c 
linux/drivers/pci/pci.c
--- v2.4.0-test11/linux/drivers/pci/pci.c       Sun Nov 19 18:44:12 2000
+++ linux/drivers/pci/pci.c     Tue Dec  5 11:04:39 2000
@@ -354,16 +354,16 @@
  run_sbin_hotplug(struct pci_dev *pdev, int insert)
  {
         int i;
-       char *argv[3], *envp[7];
-       char id[20], sub_id[24], bus_id[64], class_id[20];
+       char *argv[3], *envp[8];
+       char id[20], sub_id[24], bus_id[24], class_id[20];

         if (!hotplug_path[0])
                 return;

-       sprintf(class_id, "PCI_CLASS=%X", pdev->class >> 8);
+       sprintf(class_id, "PCI_CLASS=%X", pdev->class);
         sprintf(id, "PCI_ID=%X/%X", pdev->vendor, pdev->device);
         sprintf(sub_id, "PCI_SUBSYS_ID=%X/%X", pdev->subsystem_vendor, 
pdev->subsystem_device);
-       sprintf(bus_id, "PCI_BUS_ID=%s", pdev->slot_name);
+       sprintf(bus_id, "PCI_SLOT_NAME=%s", pdev->slot_name);

         i = 0;
         argv[i++] = hotplug_path;
@@ -376,6 +376,7 @@
         envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";

         /* other stuff we want to pass to /sbin/hotplug */
+       envp[i++] = class_id;
         envp[i++] = id;
         envp[i++] = sub_id;
         envp[i++] = bus_id;
@@ -539,15 +540,9 @@
  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, 
int rom)
  {
         unsigned int pos, reg, next;
-       u32 l, sz, tmp;
-       u16 cmd;
+       u32 l, sz;
         struct resource *res;

-       /* Disable IO and memory while we fiddle */
-       pci_read_config_word(dev, PCI_COMMAND, &cmd);
-       tmp = cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);

-       pci_write_config_word(dev, PCI_COMMAND, tmp);
-
         for(pos=0; pos<howmany; pos = next) {
                 next = pos+1;
                 res = &dev->resource[pos];
@@ -578,10 +573,10 @@
                         res->start |= ((unsigned long) l) << 32;
                         res->end = res->start + sz;
                         pci_write_config_dword(dev, reg+4, ~0);
-                       pci_read_config_dword(dev, reg+4, &tmp);
+                       pci_read_config_dword(dev, reg+4, &sz);
                         pci_write_config_dword(dev, reg+4, l);
-                       if (l)
-                               res->end = res->start + (((unsigned 
long) ~l) << 32);
+                       if (sz)
+                               res->end = res->start + (((unsigned 
long) ~sz) << 32);
  #else
                         if (l) {
                                 printk(KERN_ERR "PCI: Unable to handle 
64-bit address for device %s\n", dev->slot_name);                }
                 res->name = dev->name;
         }
-       pci_write_config_word(dev, PCI_COMMAND, cmd);
  }

  void __init pci_read_bridge_bases(struct pci_bus *child)
@@ -755,7 +749,7 @@

         pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
         DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n", 
dev->slot_name, buses & 0xffffff, pass);
-       if ((buses & 0xffffff) && !pcibios_assign_all_busses()) {
+       if ((buses & 0xffff00) && !pcibios_assign_all_busses()) {
                 /*
                  * Bus already configured by firmware, process it in 
the first
                  * pass and just note the configuration.
@@ -772,8 +766,10 @@
                         if (cmax > max) max = cmax;
                 } else {
                         int i;
+                       unsigned int cmax = child->subordinate;
                         for (i = 0; i < 4; i++) 
         child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+                       if (cmax > max) max = cmax;
                 }
         } else {
                 /*


Thanks,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
