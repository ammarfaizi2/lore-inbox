Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUBROYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUBROYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:24:08 -0500
Received: from verein.lst.de ([212.34.189.10]:42693 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267406AbUBROX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:23:59 -0500
Date: Wed, 18 Feb 2004 15:23:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark ftape un-removable
Message-ID: <20040218142343.GA11147@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just grepped over the tree for reamining MOD_INC_USE_COUNT users,
and ftape is a really horrible one, it relies on MOD_{INC,DEV}_USE_COUNT
in the most horrible places + it's own bookkepping and the <= 2.4 may
unload hooks.  And although I don't have the hardware I can guarantee it
doesn't work as expected.

So let's just remove the module_exit handler and mark it unremovable,
if someone wants to fix up ftape later it's fine with me, but it's
a really scary driver..


--- 1.8/drivers/char/ftape/compressor/zftape-compress.c	Mon Feb  3 21:19:37 2003
+++ edited/drivers/char/ftape/compressor/zftape-compress.c	Sun Oct  5 16:13:32 2003
@@ -59,8 +59,6 @@
 
 /* local variables 
  */
-static int keep_module_locked = 1;
-
 static void *zftc_wrk_mem = NULL;
 static __u8 *zftc_buf     = NULL;
 static void *zftc_scratch_buf  = NULL;
@@ -267,10 +265,6 @@
 
 static void zftc_lock(void)
 {
-	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
-			    *  locking is done with can_unload()
-			    */
-	keep_module_locked = 1;
 }
 
 /*  this function is needed for zftape_reset_position in zftape-io.c 
@@ -281,7 +275,6 @@
 
 	memset((void *)&cseg, '\0', sizeof(cseg));
 	zftc_stats();
-	keep_module_locked = 0;
 	TRACE_EXIT;
 }
 
@@ -554,10 +547,6 @@
 	int buf_pos_write = pos->seg_byte_pos;
 	TRACE_FUN(ft_t_flow);
 	
-	keep_module_locked = 1;
-	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
-			    *  locking is done with can_unload()
-			    */
 	/* Note: we do not unlock the module because
 	 * there are some values cached in that `cseg' variable.  We
 	 * don't don't want to use this information when being
@@ -675,10 +664,6 @@
 	int remaining = to_do;
 	TRACE_FUN(ft_t_flow);
 
-	keep_module_locked = 1;
-	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
-			    *  locking is done with can_unload()
-			    */
 	TRACE_CATCH(zft_allocate_cmpr_mem(volume->blk_sz),);
 	if (pos->seg_byte_pos == 0) {
 		/* new segment just read
@@ -799,10 +784,6 @@
 	int fast_seek_trials = 0;
 	TRACE_FUN(ft_t_flow);
 
-	keep_module_locked = 1;
-	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
-			    *  locking is done with can_unload()
-			    */
 	if (new_block_pos == 0) {
 		pos->seg_pos      = volume->start_seg;
 		pos->seg_byte_pos = 0;
@@ -1221,31 +1202,7 @@
  */
 int init_module(void)
 {
-	int result;
-
-#if 0 /* FIXME --RR */
-	if (!mod_member_present(&__this_module, can_unload))
-		return -EBUSY;
-	__this_module.can_unload = can_unload;
-#endif
-	result = zft_compressor_init();
-	keep_module_locked = 0;
-	return result;
+	return zft_compressor_init();
 }
 
-/* Called by modules package when removing the driver 
- */
-void cleanup_module(void)
-{
-	TRACE_FUN(ft_t_flow);
-
-	if (zft_cmpr_unregister() != &cmpr_ops) {
-		TRACE(ft_t_info, "failed");
-	} else {
-		TRACE(ft_t_info, "successful");
-	}
-	zftc_cleanup();
-        printk(KERN_INFO "zft-compressor successfully unloaded.\n");
-	TRACE_EXIT;
-}
 #endif /* MODULE */
