Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVJUNL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVJUNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVJUNL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:11:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:38562 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964940AbVJUNL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:11:57 -0400
Subject: PATCH: EDAC - clean up atomic stuff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 14:40:50 +0100
Message-Id: <1129902050.26367.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various proposals were made about the problem of u32 in atomic.h. I've
followed Andi Kleen's comments here - that atomic.h is about atomic_t
not atomic operations in general. I've moved the header bits to edac.h

Avi Kivity also observed the x86_64 one was wrong and I've fixed that
too

Removed the #if 0 unused code

Fixed some typos and coding style


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/drivers/edac/edac_mc.c linux-2.6.14-rc4-mm1/drivers/edac/edac_mc.c
--- linux.vanilla-2.6.14-rc4-mm1/drivers/edac/edac_mc.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/edac/edac_mc.c	2005-10-21 11:41:39.000000000 +0100
@@ -31,6 +31,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
+#include <asm/edac.h>
 
 #include "edac_mc.h"
 
@@ -67,106 +68,6 @@
 
 #ifdef CONFIG_SYSCTL
 
-#if 0
-static struct mem_ctl_info *find_mc_by_idx(int idx)
-{
-	struct list_head *item;
-	struct mem_ctl_info *mci;
-
-	list_for_each(item, &mc_devices) {
-		mci = list_entry(item, struct mem_ctl_info, link);
-
-		if (mci->mc_idx >= idx) {
-			if (mci->mc_idx == idx)
-				return mci;
-
-			break;
-		}
-	}
-
-	return NULL;
-}
-
-static void dimm_labels(char *buf, void *data)
-{
-	int mcidx, ridx, chidx;
-	char *mcstr, *rstr, *chstr, *lstr, *p;
-	struct mem_ctl_info *mci;
-
-	lstr = buf;
-
-	mcstr = strsep(&lstr, ".");
-	if (!lstr)
-		return;
-	mcidx = simple_strtol(mcstr, &p, 0);
-	if (*p)
-		return;
-	if ((mci = find_mc_by_idx(mcidx)) == NULL)
-		return;
-	rstr = strsep(&lstr, ".");
-	if (!lstr)
-		return;
-	ridx = simple_strtol(rstr, &p, 0);
-	if (*p)
-		return;
-	if ((ridx >= mci->nr_csrows) || !mci->csrows)
-		return;
-
-	chstr = strsep(&lstr, ":");
-	if (!lstr)
-		return;
-	chidx = simple_strtol(chstr, &p, 0);
-	if (*p)
-		return;
-	if ((chidx >= mci->csrows[ridx].nr_channels) ||
-	    !mci->csrows[ridx].channels)
-		return;
-
-	debugf1("%d:%d.%d:%s\n", mcidx, ridx, chidx, lstr);
-
-	strncpy(mci->csrows[ridx].channels[chidx].label, lstr,
-		EDAC_MC_LABEL_LEN + 1);
-	/*
-	 * no need to NULL terminate label since
-	 * get_user_tok() NULL terminates.
-	 */
-}
-
-static void counter_reset(char *buf, void *data)
-{
-	char *p = buf;
-	int mcidx, row, chan;
-	struct mem_ctl_info *mci;
-
-	pci_parity_count = 0;
-
-	mcidx = simple_strtol(buf, &p, 0);
-	if (*p)
-		return;
-
-	down(&mem_ctls_mutex);
-	mci = find_mc_by_idx(mcidx);
-
-	if (mci == NULL)
-		goto out;
-
-	mci->ue_noinfo_count = 0;
-	mci->ce_noinfo_count = 0;
-	mci->ue_count = 0;
-	mci->ce_count = 0;
-	for (row = 0; row < mci->nr_csrows; row++) {
-		struct csrow_info *ri = &mci->csrows[row];
-
-		ri->ue_count = 0;
-		ri->ce_count = 0;
-		for (chan = 0; chan < ri->nr_channels; chan++)
-			ri->channels[chan].ce_count = 0;
-	}
-	mci->start_time = jiffies;
-out:
-	up(&mem_ctls_mutex);
-}
-#endif
 
 static ctl_table mc_table[] = {
 	{-1, "panic_on_ue", &panic_on_ue,
@@ -729,14 +630,13 @@
 }
 
 
-/* FIXME - this should go in an arch dependant file */
 EXPORT_SYMBOL(edac_mc_scrub_block);
 
 void edac_mc_scrub_block(unsigned long page, unsigned long offset,
 			      u32 size)
 {
 	struct page *pg;
-	unsigned long *virt_addr;
+	void *virt_addr;
 
 	debugf3("MC: " __FILE__ ": %s()\n", __func__);
 
@@ -897,7 +797,7 @@
 	debugf3("MC%d: " __FILE__ ": %s()\n", mci->mc_idx, __func__);
 
 	/* FIXME - maybe make panic on INTERNAL ERROR an option */
-	if ((row >= mci->nr_csrows) || (row < 0)) {
+	if (row >= mci->nr_csrows || row < 0) {
 		/* something is wrong */
 		printk(KERN_ERR
 		       "MC%d: INTERNAL ERROR: row out of range (%d >= %d)\n",
@@ -980,7 +880,7 @@
 		if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
 			printk(KERN_CRIT
 			   	"PCI- "
-				"Signaled System Error on %s %s\n",
+				"Signalled System Error on %s %s\n",
 				dev->dev.bus_id,
 				pci_name(dev));
 
@@ -1029,7 +929,7 @@
 			if (status & (PCI_STATUS_SIG_SYSTEM_ERROR))
 				printk(KERN_CRIT
 					"PCI-Bridge- "
-					"Signaled System Error on %s %s\n",
+					"Signalled System Error on %s %s\n",
 					dev->dev.bus_id,
 					pci_name(dev));
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/atomic.h linux-2.6.14-rc4-mm1/include/asm-i386/atomic.h
--- linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/atomic.h	2005-10-20 16:12:41.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/asm-i386/atomic.h	2005-10-21 11:36:54.000000000 +0100
@@ -237,15 +237,4 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
-/* ECC atomic, DMA, SMP and interrupt safe scrub function */
-
-static __inline__ void atomic_scrub(unsigned long *virt_addr, u32 size)
-{
-	u32 i;
-	for (i = 0; i < size / 4; i++, virt_addr++)
-		/* Very carefully read and write to memory atomically
-		 * so we are interrupt, DMA and SMP safe.
-		 */
-		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
-}
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/edac.h linux-2.6.14-rc4-mm1/include/asm-i386/edac.h
--- linux.vanilla-2.6.14-rc4-mm1/include/asm-i386/edac.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/asm-i386/edac.h	2005-10-21 11:37:54.000000000 +0100
@@ -0,0 +1,18 @@
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+
+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
+
+static __inline__ void atomic_scrub(void *va, u32 size)
+{
+	unsigned long *virt_addr = va;
+	u32 i;
+
+	for (i = 0; i < size / 4; i++, virt_addr++)
+		/* Very carefully read and write to memory atomically
+		 * so we are interrupt, DMA and SMP safe.
+		 */
+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
+}
+
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h
--- linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-20 16:12:41.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-21 11:38:18.127825024 +0100
@@ -378,16 +378,4 @@
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
-/* ECC atomic, DMA, SMP and interrupt safe scrub function */
-
-static __inline__ void atomic_scrub(u32 *virt_addr, u32 size)
-{
-	u32 i;
-	for (i = 0; i < size / 4; i++, virt_addr++)
-		/* Very carefully read and write to memory atomically
-		 * so we are interrupt, DMA and SMP safe.
-		 */
-		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
-}
-
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/edac.h linux-2.6.14-rc4-mm1/include/asm-x86_64/edac.h
--- linux.vanilla-2.6.14-rc4-mm1/include/asm-x86_64/edac.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc4-mm1/include/asm-x86_64/edac.h	2005-10-21 11:38:34.000000000 +0100
@@ -0,0 +1,18 @@
+#ifndef ASM_EDAC_H
+#define ASM_EDAC_H
+
+/* ECC atomic, DMA, SMP and interrupt safe scrub function */
+
+static __inline__ void atomic_scrub(void *va, u32 size)
+{
+	unsigned int *virt_addr = va;
+	u32 i;
+
+	for (i = 0; i < size / 4; i++, virt_addr++)
+		/* Very carefully read and write to memory atomically
+		 * so we are interrupt, DMA and SMP safe.
+		 */
+		__asm__ __volatile__("lock; addl $0, %0"::"m"(*virt_addr));
+}
+
+#endif

