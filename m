Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966313AbWKTSNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966313AbWKTSNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966334AbWKTSNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:13:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:28378 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934282AbWKTSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:03 -0500
Message-Id: <20061120180525.851134000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:09 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 15/22] spufs: Add runcntrl read accessors
Content-Disposition: inline; filename=spufs-add-runcntrl-read-accessors.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jeremy@au1.ibm.com>
This change adds a read accessor for the SPE problem-state run control
register.

This is required for for applying (userspace) changes made to the run
control register while the SPE is stopped - simply asserting the master
run control bit is not sufficient. My next patch for isolated-mode
setup requires this.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 ++++++
 arch/powerpc/platforms/cell/spufs/hw_ops.c      |    6 ++++++
 arch/powerpc/platforms/cell/spufs/spufs.h       |    1 +
 3 files changed, 13 insertions(+)
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -268,6 +268,11 @@ static char *spu_backing_get_ls(struct s
 	return ctx->csa.lscsa->ls;
 }
 
+static u32 spu_backing_runcntl_read(struct spu_context *ctx)
+{
+	return ctx->csa.prob.spu_runcntl_RW;
+}
+
 static void spu_backing_runcntl_write(struct spu_context *ctx, u32 val)
 {
 	spin_lock(&ctx->csa.register_lock);
@@ -363,6 +368,7 @@ struct spu_context_ops spu_backing_ops =
 	.npc_write = spu_backing_npc_write,
 	.status_read = spu_backing_status_read,
 	.get_ls = spu_backing_get_ls,
+	.runcntl_read = spu_backing_runcntl_read,
 	.runcntl_write = spu_backing_runcntl_write,
 	.master_start = spu_backing_master_start,
 	.master_stop = spu_backing_master_stop,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -207,6 +207,11 @@ static char *spu_hw_get_ls(struct spu_co
 	return ctx->spu->local_store;
 }
 
+static u32 spu_hw_runcntl_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->spu_runcntl_RW);
+}
+
 static void spu_hw_runcntl_write(struct spu_context *ctx, u32 val)
 {
 	spin_lock_irq(&ctx->spu->register_lock);
@@ -307,6 +312,7 @@ struct spu_context_ops spu_hw_ops = {
 	.npc_write = spu_hw_npc_write,
 	.status_read = spu_hw_status_read,
 	.get_ls = spu_hw_get_ls,
+	.runcntl_read = spu_hw_runcntl_read,
 	.runcntl_write = spu_hw_runcntl_write,
 	.master_start = spu_hw_master_start,
 	.master_stop = spu_hw_master_stop,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -115,6 +115,7 @@ struct spu_context_ops {
 	void (*npc_write) (struct spu_context * ctx, u32 data);
 	 u32(*status_read) (struct spu_context * ctx);
 	char*(*get_ls) (struct spu_context * ctx);
+	 u32 (*runcntl_read) (struct spu_context * ctx);
 	void (*runcntl_write) (struct spu_context * ctx, u32 data);
 	void (*master_start) (struct spu_context * ctx);
 	void (*master_stop) (struct spu_context * ctx);

--

