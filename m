Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbWFWTEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWFWTEG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWFWTEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:04:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:30207 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751946AbWFWTDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:03:53 -0400
Message-Id: <20060623185824.725989000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:48 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 2/5] spufs: fix MFC command queue purge
Content-Disposition: inline; filename=spufs-dma-status.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

In the context save/restore code, the SPU MFC command queue purge
code has a bug:

static inline void wait_purge_complete(struct spu_state *csa, struct
				       spu *spu)
{
    struct spu_priv2 __iomem *priv2 = spu->priv2;

    /* Save, Step 28:
     *     Poll MFC_CNTL[Ps] until value '11' is
     *     read
     *      (purge complete).
     */
    POLL_WHILE_FALSE(in_be64(&priv2->mfc_control_RW)
		     & MFC_CNTL_PURGE_DMA_COMPLETE);
}

This will exit as soon as _one_ of the 2 bits that compose
MFC_CNTL_PURGE_DMA_COMPLETE is set, and one of them happens to be
"purge in progress"...  which means that we'll happily continue
restoring the MFC while it's being purged at the same time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/switch.c
@@ -464,7 +464,8 @@ static inline void wait_purge_complete(s
 	 *     Poll MFC_CNTL[Ps] until value '11' is read
 	 *     (purge complete).
 	 */
-	POLL_WHILE_FALSE(in_be64(&priv2->mfc_control_RW) &
+	POLL_WHILE_FALSE((in_be64(&priv2->mfc_control_RW) &
+			 MFC_CNTL_PURGE_DMA_STATUS_MASK) ==
 			 MFC_CNTL_PURGE_DMA_COMPLETE);
 }
 
@@ -1028,7 +1029,8 @@ static inline void wait_suspend_mfc_comp
 	 * Restore, Step 47.
 	 *     Poll MFC_CNTL[Ss] until 11 is returned.
 	 */
-	POLL_WHILE_FALSE(in_be64(&priv2->mfc_control_RW) &
+	POLL_WHILE_FALSE((in_be64(&priv2->mfc_control_RW) &
+			 MFC_CNTL_SUSPEND_DMA_STATUS_MASK) ==
 			 MFC_CNTL_SUSPEND_COMPLETE);
 }
 

--

