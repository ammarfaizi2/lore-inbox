Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWFSSqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWFSSqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWFSSnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:23012 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932546AbWFSSn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:26 -0400
Message-Id: <20060619183406.319507000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:31 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>
Subject: [patch 16/20] spufs: remove stop_code from struct spu
Content-Disposition: inline; filename=spufs-fix-remove-stop_code-member-of-struct-spu.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

This patch remove 'stop_code' -- discarded member of struct spu.
It is written at initialize and interrupt, but never read
in current implementation.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spu_base.c     |    2 --
 arch/powerpc/platforms/cell/spufs/switch.c |    1 -
 include/asm-powerpc/spu.h                  |    1 -
 3 files changed, 4 deletions(-)

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -160,7 +160,6 @@ static int __spu_trap_mailbox(struct spu
 static int __spu_trap_stop(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	spu->stop_code = in_be32(&spu->problem->spu_status_R);
 	if (spu->stop_callback)
 		spu->stop_callback(spu);
 	return 0;
@@ -169,7 +168,6 @@ static int __spu_trap_stop(struct spu *s
 static int __spu_trap_halt(struct spu *spu)
 {
 	pr_debug("%s\n", __FUNCTION__);
-	spu->stop_code = in_be32(&spu->problem->spu_status_R);
 	if (spu->stop_callback)
 		spu->stop_callback(spu);
 	return 0;
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2109,7 +2109,6 @@ int spu_restore(struct spu_state *new, s
 
 	acquire_spu_lock(spu);
 	harvest(NULL, spu);
-	spu->stop_code = 0;
 	spu->dar = 0;
 	spu->dsisr = 0;
 	spu->slb_replace = 0;
Index: powerpc.git/include/asm-powerpc/spu.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/spu.h
+++ powerpc.git/include/asm-powerpc/spu.h
@@ -134,7 +134,6 @@ struct spu {
 	int class_0_pending;
 	spinlock_t register_lock;
 
-	u32 stop_code;
 	void (* wbox_callback)(struct spu *spu);
 	void (* ibox_callback)(struct spu *spu);
 	void (* stop_callback)(struct spu *spu);

--

