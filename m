Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132795AbRDDLMn>; Wed, 4 Apr 2001 07:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbRDDLMj>; Wed, 4 Apr 2001 07:12:39 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:35844 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132795AbRDDLMU>; Wed, 4 Apr 2001 07:12:20 -0400
Date: Wed, 4 Apr 2001 15:10:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-ac2 alpha fixes
Message-ID: <20010404151052.A546@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Yet another pte/pmd update; interface has been changed again
  between 2.4.3-pre8 and 2.4.3-final...
- drivers/pci/setup-bus.c was not in sync with Linus' tree
  for a long time (since -test12, I believe). Thus -ac patches
  discard the fix for alpha noritake boot.

Ivan.

--- 2.4.3-ac2/include/asm-alpha/pgalloc.h	Wed Apr  4 13:37:42 2001
+++ linux/include/asm-alpha/pgalloc.h	Wed Apr  4 13:41:39 2001
@@ -241,8 +241,8 @@ extern struct pgtable_cache_struct {
 #define pte_quicklist (quicklists.pte_cache)
 #define pgtable_cache_size (quicklists.pgtable_cache_sz)
 
-#define pmd_populate(pmd, pte)	pmd_set(pmd, pte)
-#define pgd_populate(pgd, pmd)	pgd_set(pgd, pmd)
+#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
+#define pgd_populate(mm, pgd, pmd)	pgd_set(pgd, pmd)
 
 extern pgd_t *get_pgd_slow(void);
 
@@ -271,7 +271,7 @@ static inline void free_pgd_slow(pgd_t *
 	free_page((unsigned long)pgd);
 }
 
-static inline pmd_t *pmd_alloc_one(void)
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *ret = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (ret)
@@ -279,7 +279,7 @@ static inline pmd_t *pmd_alloc_one(void)
 	return ret;
 }
 
-static inline pmd_t *pmd_alloc_one_fast(void)
+static inline pmd_t *pmd_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *ret;
 
@@ -303,7 +303,7 @@ static inline void pmd_free_slow(pmd_t *
 	free_page((unsigned long)pmd);
 }
 
-static inline pte_t *pte_alloc_one(unsigned long address)
+static inline pte_t *pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
 	if (pte)
@@ -311,7 +311,7 @@ static inline pte_t *pte_alloc_one(unsig
 	return pte;
 }
 
-static inline pte_t *pte_alloc_one_fast(unsigned long address)
+static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned long address)
 {
 	unsigned long *ret;
 
--- 2.4.3-ac2/drivers/pci/setup-bus.c	Wed Apr  4 13:37:26 2001
+++ linux/drivers/pci/setup-bus.c	Tue Dec 12 00:46:26 2000
@@ -45,24 +45,28 @@ pbus_assign_resources_sorted(struct pci_
 	head_io.next = head_mem.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
+		u16 class = dev->class >> 8;
 		u16 cmd;
 
 		/* First, disable the device to avoid side
 		   effects of possibly overlapping I/O and
 		   memory ranges.
-		   Except the VGA - for obvious reason. :-)  */
-		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
+		   Leave VGA enabled - for obvious reason. :-)
+		   Same with all sorts of bridges - they may
+		   have VGA behind them.  */
+		if (class == PCI_CLASS_DISPLAY_VGA
+				|| class == PCI_CLASS_NOT_DEFINED_VGA)
 			found_vga = 1;
-		else {
+		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
 			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
 						| PCI_COMMAND_MASTER);
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
 		}
- 
+
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
-		if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
+		if (class == PCI_CLASS_BRIDGE_CARDBUS) {
 			io_reserved += 8*1024;
 			mem_reserved += 32*1024*1024;
 			continue;
--- 2.4.3-ac2/arch/alpha/mm/init.c	Wed Apr  4 13:37:06 2001
+++ linux/arch/alpha/mm/init.c	Wed Apr  4 13:46:42 2001
@@ -79,11 +79,11 @@ int do_check_pgt_cache(int low, int high
 				freed++;
 			}
 			if(pmd_quicklist) {
-				pmd_free_slow(pmd_alloc_one_fast());
+				pmd_free_slow(pmd_alloc_one_fast(NULL, 0));
 				freed++;
 			}
 			if(pte_quicklist) {
-				pte_free_slow(pte_alloc_one_fast(0));
+				pte_free_slow(pte_alloc_one_fast(NULL, 0));
 				freed++;
 			}
 		} while(pgtable_cache_size > low);
