Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbSJZXrG>; Sat, 26 Oct 2002 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJZXrG>; Sat, 26 Oct 2002 19:47:06 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:45205 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261748AbSJZXrD>; Sat, 26 Oct 2002 19:47:03 -0400
Date: Sat, 26 Oct 2002 16:53:15 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021026165315.A15269@lucon.org>
References: <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DBB1E29.5020402@pobox.com>; from jgarzik@pobox.com on Sat, Oct 26, 2002 at 06:58:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 26, 2002 at 06:58:49PM -0400, Jeff Garzik wrote:
> H. J. Lu wrote:
> 
> >>The basic point is "let's proceed with caution, and test test test 
> >>before applying this patch."
> >>    
> >>
> >
> >Please state clearly what you have in mind. First you were
> >saying you didn't like pci_sort_by_bus_slot_func defined when
> >CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC wass not set. Now you were
> >saying my patch was dangerous. Please make up your mind.
> >  
> >
> 
> In my first reply, I clearly separated implementation issues from 
> commentary on the overall idea.  Aside from that, I don't see much value 
> in further repeating what I've already said.
> 

Here is an alternative patch, which won't define pci_sort_by_bus_slot_func
if CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC is not set.


H.J.

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-pci-order-2.patch"

--- linux/arch/i386/config.in.order	Thu Oct 24 21:09:20 2002
+++ linux/arch/i386/config.in	Fri Oct 25 16:34:13 2002
@@ -257,6 +257,7 @@ else
       if [ "$CONFIG_PCI_GODIRECT" = "y" -o "$CONFIG_PCI_GOANY" = "y" ]; then
          define_bool CONFIG_PCI_DIRECT y
       fi
+      bool '  Sort device by bus, slot, function' CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC
    fi
 fi
 
--- linux/arch/i386/kernel/pci-i386.h.order	Sun Nov 11 10:09:32 2001
+++ linux/arch/i386/kernel/pci-i386.h	Fri Oct 25 19:26:51 2002
@@ -21,6 +21,7 @@
 #define PCI_ASSIGN_ROMS		0x1000
 #define PCI_BIOS_IRQ_SCAN	0x2000
 #define PCI_ASSIGN_ALL_BUSSES	0x4000
+#define PCI_BUS_SORT		0x8000
 
 extern unsigned int pci_probe;
 
--- linux/arch/i386/kernel/pci-pc.c.order	Thu Oct 24 21:09:20 2002
+++ linux/arch/i386/kernel/pci-pc.c	Sat Oct 26 16:14:00 2002
@@ -19,7 +19,11 @@
 
 #include "pci-i386.h"
 
+#ifdef CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC
+unsigned int pci_probe = PCI_PROBE_BIOS | PCI_BUS_SORT | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+#else
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
+#endif
 
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
@@ -871,6 +875,55 @@ static struct pci_ops * __devinit pci_fi
 	return NULL;
 }
 
+#ifdef CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC
+static void __devinit pci_sort_by_bus_slot_func(void)
+{
+	LIST_HEAD(sorted_devices);
+	struct list_head *ln;
+	struct pci_dev *dev, *d;
+	int n;
+	int s, slot;
+	int f, func;
+
+	printk(KERN_INFO "PCI: Sorting device list by bus, slot, function...\n");
+
+	/* Starting from bus 0, ...  */
+	for (n=0; n <= pcibios_last_bus; n++) {
+		if (!pci_bus_exists(&pci_root_buses, n))
+			continue;
+
+		while (!list_empty(&pci_devices)) {
+			/* Find the lowest remaining PCI slot/function.  */
+			slot = INT_MAX;
+			func = INT_MAX;
+			dev = NULL;
+			for (ln=pci_devices.next; ln != &pci_devices; ln=ln->next) {
+				d = pci_dev_g(ln);
+				s = PCI_SLOT(d->devfn);
+				f = PCI_FUNC(d->devfn);
+				if (d->bus->number == n
+				    && (s < slot || (s == slot && f < func))) {
+					slot = s;
+					func = f;
+					dev = d;
+				}
+			}
+
+			if (dev) {
+				list_del(&dev->global_list);
+				list_add_tail(&dev->global_list, &sorted_devices);
+			}
+			else {
+				/* Stop if we don't find any devices on
+				   this bus.  */
+				break;
+			}
+		}
+	}
+	list_splice(&sorted_devices, &pci_devices);
+}
+#endif
+
 /*
  * Sort the device list according to PCI BIOS. Nasty hack, but since some
  * fool forgot to define the `correct' device order in the PCI BIOS specs
@@ -1392,6 +1445,11 @@ void __init pcibios_init(void)
 
 	pcibios_resource_survey();
 
+#ifdef CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC
+	if ((pci_probe & PCI_BUS_SORT) && !(pci_probe & PCI_NO_SORT))
+		pci_sort_by_bus_slot_func();
+	else
+#endif
 #ifdef CONFIG_PCI_BIOS
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
@@ -1404,6 +1462,12 @@ char * __devinit  pcibios_setup(char *st
 		pci_probe = 0;
 		return NULL;
 	}
+#ifdef CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC
+	else if (!strcmp(str, "nobussort")) {
+		pci_probe &= ~PCI_BUS_SORT;
+		return NULL;
+	}
+#endif
 #ifdef CONFIG_PCI_BIOS
 	else if (!strcmp(str, "bios")) {
 		pci_probe = PCI_PROBE_BIOS;

--AqsLC8rIMeq19msA--
