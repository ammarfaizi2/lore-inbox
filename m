Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbULDDYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbULDDYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 22:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbULDDYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 22:24:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262434AbULDDXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 22:23:53 -0500
To: linux-kernel@vger.kernel.org
Subject: [kernel patch] fun with gcc mainline on ia64
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 04 Dec 2004 01:23:43 -0200
Message-ID: <oreki6n3uo.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For lack of better things to do, I ended up trying to build current
kernel mainline for ia64 using a recently-built toolchain.  It wasn't
as bad as I'd expected, it took just a few minor patches to get it to
build.  I've no idea whether it actually works, since I don't have
easy access to hardware on which to test it, but since the patches are
all trivial, I thought I'd post them such that (i) people are aware of
what sort of changes may be needed for GCC 4, and (ii) some of the
changes might even be correct.

I realize the changes are all independent, and might be better off
posted separately, but since they're so small, so easy to split up,
and there are a few common themes that I didn't feel like repeating
several times, I post it as a single patch below.

The changes to arch/ia64/sn/include/pci/pcidev.h, and the first change
to include/asm-ia64/pci.h, were needed because the cast-is-lvalue
extension that has been deprecated for a few releases will be gone for
good in GCC 4.  I realize the change as I wrote it is not
strict-aliasing-safe, but I didn't quite feel like dancing the
`GCC-supported extension of casting the pointer to a union of the two
pointer types, then selecting the other union member' dance.  I don't
know whether the kernel already has a macro to do all this in place;
if so, change withdrawn.

The change to drivers/media/video/saa7134/saa7134.h was needed because
the variable is defined as static elsewhere, and GCC 4 will reject
static definitions of previously-extern declarations.  Same goes for
drivers/serial/sn_console.c.

drivers/net/acenic.c needed the change because function-scoped static
function declarations are going to be rejected by GCC 4.  I don't
quite remember what the argument was to remove this extension, but I
remember I found it quite convincing when I read it.

The change to drivers/scsi/BusLogic.c should probably not be installed
as-is, but I didn't look into how to get DMA_MODE_CASCADE defined at
that point.

The changes to include/asm-ia64/io.h and
include/asm-ia64/mmu_context.h do not fix compile errors, just silence
warnings.  GCC 4 will warn if it finds a const or volatile qualifier
in the outermost return type of a function (e.g., void const * is ok,
but void *const isn't), even if the qualifier comes in as part of a
typedef (as is the case of mm_context_t).  Yeah, I don't like the way
I ``fixed=C2=B4=C2=B4 mmu_context.h either; whoever can think of a better w=
ay to
do it, please go for it.

The second change to include/asm-ia64/pci.h is needed because
asm-generic/pci.h isn't included, and one module references
pci_get_legacy_ide_irq() directly.  I thought I'd noted which module
it was in the function, but I didn't, !@@&#@!#%@^ :-(  Sorry.

Hope this helps.  Pick whatever pieces you like, and let those
responsible for the remaining bits know that they may have work to do
to get their code to build with GCC 4 :-)

Signed-off-by: Alexandre Oliva <aoliva@redhat.com>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=kernel-gcc4-ia64.patch

Index: arch/ia64/sn/include/pci/pcidev.h
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/arch/ia64/sn/include/pci/pcidev.h,v
retrieving revision 1.3
diff -u -p -r1.3 pcidev.h
--- arch/ia64/sn/include/pci/pcidev.h	21 Oct 2004 00:32:29 -0000	1.3
+++ arch/ia64/sn/include/pci/pcidev.h	3 Dec 2004 13:58:49 -0000
@@ -13,7 +13,7 @@
 extern struct sn_irq_info **sn_irq;
 
 #define SN_PCIDEV_INFO(pci_dev) \
-        ((struct pcidev_info *)(pci_dev)->sysdata)
+        (*(struct pcidev_info **) &((pci_dev)->sysdata))
 
 /*
  * Given a pci_bus, return the sn pcibus_bussoft struct.  Note that
@@ -21,7 +21,7 @@ extern struct sn_irq_info **sn_irq;
  */
 
 #define SN_PCIBUS_BUSSOFT(pci_bus) \
-        ((struct pcibus_bussoft *)(PCI_CONTROLLER((pci_bus))->platform_data))
+        (*(struct pcibus_bussoft **) &(PCI_CONTROLLER(pci_bus)->platform_data))
 
 /*
  * Given a struct pci_dev, return the sn pcibus_bussoft struct.  Note
Index: drivers/media/video/saa7134/saa7134.h
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/drivers/media/video/saa7134/saa7134.h,v
retrieving revision 1.17
diff -u -p -r1.17 saa7134.h
--- drivers/media/video/saa7134/saa7134.h	20 Nov 2004 22:15:44 -0000	1.17
+++ drivers/media/video/saa7134/saa7134.h	3 Dec 2004 03:32:39 -0000
@@ -476,7 +476,6 @@ struct saa7134_dev {
 /* saa7134-core.c                                              */
 
 extern struct list_head  saa7134_devlist;
-extern unsigned int      saa7134_devcount;
 
 void saa7134_print_ioctl(char *name, unsigned int cmd);
 void saa7134_track_gpio(struct saa7134_dev *dev, char *msg);
Index: drivers/net/acenic.c
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/drivers/net/acenic.c,v
retrieving revision 1.50
diff -u -p -r1.50 acenic.c
--- drivers/net/acenic.c	25 Oct 2004 07:30:48 -0000	1.50
+++ drivers/net/acenic.c	3 Dec 2004 13:20:34 -0000
@@ -457,6 +457,8 @@ static struct ethtool_ops ace_ethtool_op
 	.get_drvinfo = ace_get_drvinfo,
 };
 
+static void ace_watchdog(struct net_device *dev);
+
 static int __devinit acenic_probe_one(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
@@ -485,7 +487,6 @@ static int __devinit acenic_probe_one(st
 	dev->vlan_rx_kill_vid = ace_vlan_rx_kill_vid;
 #endif
 	if (1) {
-		static void ace_watchdog(struct net_device *dev);
 		dev->tx_timeout = &ace_watchdog;
 		dev->watchdog_timeo = 5*HZ;
 	}
Index: drivers/scsi/BusLogic.c
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/drivers/scsi/BusLogic.c,v
retrieving revision 1.32
diff -u -p -r1.32 BusLogic.c
--- drivers/scsi/BusLogic.c	11 Nov 2004 21:50:06 -0000	1.32
+++ drivers/scsi/BusLogic.c	3 Dec 2004 13:23:48 -0000
@@ -1856,7 +1856,9 @@ static boolean __init BusLogic_AcquireRe
 			BusLogic_Error("UNABLE TO ACQUIRE DMA CHANNEL %d - DETACHING\n", HostAdapter, HostAdapter->DMA_Channel);
 			return false;
 		}
+#ifdef DMA_MODE_CASCADE
 		set_dma_mode(HostAdapter->DMA_Channel, DMA_MODE_CASCADE);
+#endif
 		enable_dma(HostAdapter->DMA_Channel);
 		HostAdapter->DMA_ChannelAcquired = true;
 	}
Index: drivers/serial/sn_console.c
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/drivers/serial/sn_console.c,v
retrieving revision 1.11
diff -u -p -r1.11 sn_console.c
--- drivers/serial/sn_console.c	28 Oct 2004 19:11:00 -0000	1.11
+++ drivers/serial/sn_console.c	3 Dec 2004 13:27:18 -0000
@@ -785,7 +785,7 @@ static void __init sn_sal_switch_to_inte
 
 static void sn_sal_console_write(struct console *, const char *, unsigned);
 static int __init sn_sal_console_setup(struct console *, char *);
-extern struct uart_driver sal_console_uart;
+static struct uart_driver sal_console_uart;
 extern struct tty_driver *uart_console_device(struct console *, int *);
 
 static struct console sal_console = {
Index: include/asm-ia64/io.h
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/include/asm-ia64/io.h,v
retrieving revision 1.19
diff -u -p -r1.19 io.h
--- include/asm-ia64/io.h	28 Oct 2004 19:11:00 -0000	1.19
+++ include/asm-ia64/io.h	3 Dec 2004 03:35:21 -0000
@@ -120,7 +120,7 @@ static inline void ___ia64_mmiowb(void)
 	ia64_mfa();
 }
 
-static inline const unsigned long
+static inline unsigned long
 __ia64_get_io_port_base (void)
 {
 	extern unsigned long ia64_iobase;
Index: include/asm-ia64/mmu_context.h
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/include/asm-ia64/mmu_context.h,v
retrieving revision 1.18
diff -u -p -r1.18 mmu_context.h
--- include/asm-ia64/mmu_context.h	8 Oct 2004 02:57:28 -0000	1.18
+++ include/asm-ia64/mmu_context.h	3 Dec 2004 03:35:18 -0000
@@ -62,7 +62,7 @@ delayed_tlb_flush (void)
 	}
 }
 
-static inline mm_context_t
+static inline /* mm_context_t */ unsigned long
 get_mmu_context (struct mm_struct *mm)
 {
 	unsigned long flags;
Index: include/asm-ia64/pci.h
===================================================================
RCS file: /l/tmp/build/cvsfiles/kernel/linux-2.5/include/asm-ia64/pci.h,v
retrieving revision 1.26
diff -u -p -r1.26 pci.h
--- include/asm-ia64/pci.h	4 Nov 2004 00:44:28 -0000	1.26
+++ include/asm-ia64/pci.h	3 Dec 2004 14:26:52 -0000
@@ -102,7 +102,7 @@ struct pci_controller {
 	void *platform_data;
 };
 
-#define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
+#define PCI_CONTROLLER(busdev) (*(struct pci_controller **) &(busdev->sysdata))
 #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
 
 extern struct pci_ops pci_root_ops;
@@ -129,4 +129,9 @@ extern void pcibios_bus_to_resource(stru
 
 #define pcibios_scan_all_fns(a, b)	0
 
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	BUG();
+}
+
 #endif /* _ASM_IA64_PCI_H */

--=-=-=


-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
