Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUKCHWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUKCHWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 02:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKCHWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 02:22:35 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:1709 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261516AbUKCHVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 02:21:39 -0500
Date: Wed, 3 Nov 2004 18:21:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] PPC64 iSeries iommu cleanups
Message-Id: <20041103182128.6d1a7d3a.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__3_Nov_2004_18_21_28_+1100_zDe2ghdPGbocFeDm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__3_Nov_2004_18_21_28_+1100_zDe2ghdPGbocFeDm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just does some cleanups of iSeries_iommu.c
	remove lots of unneeded includes
	use list_for_each_entry
	white space
	formatting
No semantic changes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please apply and send to Linus.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/arch/ppc64/kernel/iSeries_iommu.c linus-bk-iommu.1/arch/ppc64/kernel/iSeries_iommu.c
--- linus-bk/arch/ppc64/kernel/iSeries_iommu.c	2004-04-13 09:25:09.000000000 +1000
+++ linus-bk-iommu.1/arch/ppc64/kernel/iSeries_iommu.c	2004-11-02 18:24:31.000000000 +1100
@@ -25,30 +25,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <linux/config.h>
-#include <linux/init.h>
 #include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/pci.h>
 #include <linux/dma-mapping.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/rtas.h>
-#include <asm/ppcdebug.h>
+#include <linux/list.h>
 
-#include <asm/iSeries/HvCallXm.h>
-#include <asm/iSeries/LparData.h>
 #include <asm/iommu.h>
-#include <asm/pci-bridge.h>
-#include <asm/iSeries/iSeries_pci.h>
-
 #include <asm/machdep.h>
-
-#include "pci.h"
-
+#include <asm/iSeries/HvCallXm.h>
+#include <asm/iSeries/iSeries_pci.h>
 
 extern struct list_head iSeries_Global_Device_List;
 
@@ -76,12 +60,11 @@
 				tce.te_bits.tb_pciwr = 1;
 		}
 
-		rc = HvCallXm_setTce((u64)tbl->it_index,
-				     (u64)index,
-				     tce.te_word);
+		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index,
+				tce.te_word);
 		if (rc)
-			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n", rc);
-
+			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n",
+					rc);
 		index++;
 		uaddr += PAGE_SIZE;
 	}
@@ -90,20 +73,14 @@
 static void tce_free_iSeries(struct iommu_table *tbl, long index, long npages)
 {
 	u64 rc;
-	union tce_entry tce;
 
 	while (npages--) {
-		tce.te_word = 0;
-		rc = HvCallXm_setTce((u64)tbl->it_index,
-				     (u64)index,
-				     tce.te_word);
-
+		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index, 0);
 		if (rc)
-			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n", rc);
-
+			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n",
+					rc);
 		index++;
 	}
-
 }
 
 
@@ -115,17 +92,14 @@
 {
 	struct iSeries_Device_Node *dp;
 
-	for (dp =  (struct iSeries_Device_Node *)iSeries_Global_Device_List.next;
-	     dp != (struct iSeries_Device_Node *)&iSeries_Global_Device_List;
-	     dp =  (struct iSeries_Device_Node *)dp->Device_List.next)
-		if (dp->iommu_table                 != NULL &&
-		    dp->iommu_table->it_type        == TCE_PCI &&
-		    dp->iommu_table->it_offset      == tbl->it_offset &&
-		    dp->iommu_table->it_index       == tbl->it_index &&
-		    dp->iommu_table->it_size        == tbl->it_size)
+	list_for_each_entry(dp, &iSeries_Global_Device_List, Device_List) {
+		if ((dp->iommu_table != NULL) &&
+		    (dp->iommu_table->it_type == TCE_PCI) &&
+		    (dp->iommu_table->it_offset == tbl->it_offset) &&
+		    (dp->iommu_table->it_index == tbl->it_index) &&
+		    (dp->iommu_table->it_size == tbl->it_size))
 			return dp->iommu_table;
-
-
+	}
 	return NULL;
 }
 
@@ -143,15 +117,14 @@
 {
 	struct iommu_table_cb *parms;
 
-	parms = (struct iommu_table_cb*)kmalloc(sizeof(*parms), GFP_KERNEL);
-
+	parms = kmalloc(sizeof(*parms), GFP_KERNEL);
 	if (parms == NULL)
 		panic("PCI_DMA: TCE Table Allocation failed.");
 
 	memset(parms, 0, sizeof(*parms));
 
-	parms->itc_busno   = ISERIES_BUS(dn);
-	parms->itc_slotno  = dn->LogicalSlot;
+	parms->itc_busno = ISERIES_BUS(dn);
+	parms->itc_slotno = dn->LogicalSlot;
 	parms->itc_virtbus = 0;
 
 	HvCallXm_getTceTableParms(ISERIES_HV_ADDR(parms));
@@ -159,34 +132,32 @@
 	if (parms->itc_size == 0)
 		panic("PCI_DMA: parms->size is zero, parms is 0x%p", parms);
 
-	tbl->it_size        = parms->itc_size;
-	tbl->it_busno       = parms->itc_busno;
-	tbl->it_offset      = parms->itc_offset;
-	tbl->it_index       = parms->itc_index;
-	tbl->it_entrysize   = sizeof(union tce_entry);
-	tbl->it_blocksize   = 1;
-	tbl->it_type        = TCE_PCI;
+	tbl->it_size = parms->itc_size;
+	tbl->it_busno = parms->itc_busno;
+	tbl->it_offset = parms->itc_offset;
+	tbl->it_index = parms->itc_index;
+	tbl->it_entrysize = sizeof(union tce_entry);
+	tbl->it_blocksize = 1;
+	tbl->it_type = TCE_PCI;
 
 	kfree(parms);
 }
 
 
-void iommu_devnode_init(struct iSeries_Device_Node *dn) {
+void iommu_devnode_init(struct iSeries_Device_Node *dn)
+{
 	struct iommu_table *tbl;
 
-	tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+	tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
 
 	iommu_table_getparms(dn, tbl);
 
 	/* Look for existing tce table */
 	dn->iommu_table = iommu_table_find(tbl);
-
 	if (dn->iommu_table == NULL)
 		dn->iommu_table = iommu_init_table(tbl);
 	else
 		kfree(tbl);
-
-	return;
 }
 
 

--Signature=_Wed__3_Nov_2004_18_21_28_+1100_zDe2ghdPGbocFeDm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiIb+4CJfqux9a+8RAvXuAJ9ng6b5CYPZ7MWssytZokAtM24vGgCdFFXW
wscLvafMB58hsa1Uze88bfk=
=jYSt
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Nov_2004_18_21_28_+1100_zDe2ghdPGbocFeDm--
