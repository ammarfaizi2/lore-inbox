Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWC3IRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWC3IRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWC3IRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:42 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:27219 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932098AbWC3IRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:41 -0500
Message-Id: <20060330081730.371346000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:09 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       "David S. Miller" <davem@davemloft.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 4/8] arch: use list_move()
Content-Disposition: inline; filename=list-move-arch.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B) under arch/.

CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 arch/i386/pci/pcbios.c    |    6 ++----
 arch/m68k/mm/memory.c     |    6 ++----
 arch/m68k/sun3/sun3dvma.c |    6 ++----
 arch/sparc64/kernel/pci.c |    6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

Index: 2.6-git/arch/i386/pci/pcbios.c
===================================================================
--- 2.6-git.orig/arch/i386/pci/pcbios.c
+++ 2.6-git/arch/i386/pci/pcbios.c
@@ -371,8 +371,7 @@ void __devinit pcibios_sort(void)
 			list_for_each(ln, &pci_devices) {
 				d = pci_dev_g(ln);
 				if (d->bus->number == bus && d->devfn == devfn) {
-					list_del(&d->global_list);
-					list_add_tail(&d->global_list, &sorted_devices);
+					list_move_tail(&d->global_list, &sorted_devices);
 					if (d == dev)
 						found = 1;
 					break;
@@ -390,8 +389,7 @@ void __devinit pcibios_sort(void)
 		if (!found) {
 			printk(KERN_WARNING "PCI: Device %s not found by BIOS\n",
 				pci_name(dev));
-			list_del(&dev->global_list);
-			list_add_tail(&dev->global_list, &sorted_devices);
+			list_move_tail(&dev->global_list, &sorted_devices);
 		}
 	}
 	list_splice(&sorted_devices, &pci_devices);
Index: 2.6-git/arch/m68k/mm/memory.c
===================================================================
--- 2.6-git.orig/arch/m68k/mm/memory.c
+++ 2.6-git/arch/m68k/mm/memory.c
@@ -94,8 +94,7 @@ pmd_t *get_pointer_table (void)
 	PD_MARKBITS(dp) = mask & ~tmp;
 	if (!PD_MARKBITS(dp)) {
 		/* move to end of list */
-		list_del(dp);
-		list_add_tail(dp, &ptable_list);
+		list_move_tail(dp, &ptable_list);
 	}
 	return (pmd_t *) (page_address(PD_PAGE(dp)) + off);
 }
@@ -123,8 +122,7 @@ int free_pointer_table (pmd_t *ptable)
 		 * move this descriptor to the front of the list, since
 		 * it has one or more free tables.
 		 */
-		list_del(dp);
-		list_add(dp, &ptable_list);
+		list_move(dp, &ptable_list);
 	}
 	return 0;
 }
Index: 2.6-git/arch/m68k/sun3/sun3dvma.c
===================================================================
--- 2.6-git.orig/arch/m68k/sun3/sun3dvma.c
+++ 2.6-git/arch/m68k/sun3/sun3dvma.c
@@ -119,8 +119,7 @@ static inline int refill(void)
 		if(hole->end == prev->start) {
 			hole->size += prev->size;
 			hole->end = prev->end;
-			list_del(&(prev->list));
-			list_add(&(prev->list), &hole_cache);
+			list_move(&(prev->list), &hole_cache);
 			ret++;
 		}
 
@@ -182,8 +181,7 @@ static inline unsigned long get_baddr(in
 #endif
 			return hole->end;
 		} else if(hole->size == newlen) {
-			list_del(&(hole->list));
-			list_add(&(hole->list), &hole_cache);
+			list_move(&(hole->list), &hole_cache);
 			dvma_entry_use(hole->start) = newlen;
 #ifdef DVMA_DEBUG
 			dvma_allocs++;
Index: 2.6-git/arch/sparc64/kernel/pci.c
===================================================================
--- 2.6-git.orig/arch/sparc64/kernel/pci.c
+++ 2.6-git/arch/sparc64/kernel/pci.c
@@ -328,10 +328,8 @@ static void __init pci_reorder_devs(void
 		struct pci_dev *pdev = pci_dev_g(walk);
 		struct list_head *walk_next = walk->next;
 
-		if (pdev->irq && (__irq_ino(pdev->irq) & 0x20)) {
-			list_del(walk);
-			list_add(walk, pci_onboard);
-		}
+		if (pdev->irq && (__irq_ino(pdev->irq) & 0x20))
+			list_move(walk, pci_onboard);
 
 		walk = walk_next;
 	}

--
