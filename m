Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVLISUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVLISUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVLISUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:27352 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964858AbVLISUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:20:04 -0500
Message-Id: <20051209182053.991411000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:18 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Geoff Levand <geoff.levand@am.sony.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 4/8] spufs: clear dsisr on CLASS1[Mf] exception
Content-Disposition: inline; filename=spufs-clear-dsisr.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of always clearing DSISR at spu class 1 interrupt handler,
kernel may lose Class1[Mf] interrupt.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Geoff Levand <geoff.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -240,7 +240,8 @@ spu_irq_class_1(int irq, void *data, str
 	stat  = in_be64(&spu->priv1->int_stat_class1_RW) & mask;
 	dar   = in_be64(&spu->priv1->mfc_dar_RW);
 	dsisr = in_be64(&spu->priv1->mfc_dsisr_RW);
-	out_be64(&spu->priv1->mfc_dsisr_RW, 0UL);
+	if (stat & 2) /* mapping fault */
+		out_be64(&spu->priv1->mfc_dsisr_RW, 0UL);
 	out_be64(&spu->priv1->int_stat_class1_RW, stat);
 	spin_unlock(&spu->register_lock);
 

--

