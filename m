Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUKSBO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUKSBO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUKSBNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:13:14 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:52230 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262864AbUKSBMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:12:09 -0500
Subject: [patch 4/4] Uml: fix __wrap_free comment.
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 19 Nov 2004 02:13:42 +0100
Message-Id: <20041119011343.937D97B9AA@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reworded the comment about __wrap_free detection of the allocator used to
allocate the pointer (it can free a pointer created by either the host
malloc(), kmalloc() or vmalloc()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/main.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/um/kernel/main.c~uml-wrap_free arch/um/kernel/main.c
--- linux-2.6.10-rc/arch/um/kernel/main.c~uml-wrap_free	2004-11-16 02:19:08.289619800 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/main.c	2004-11-16 02:19:08.292619344 +0100
@@ -222,13 +222,16 @@ void __wrap_free(void *ptr)
 	 * 	physical memory - kmalloc/kfree
 	 *	kernel virtual memory - vmalloc/vfree
 	 * 	anywhere else - malloc/free
-	 * If kmalloc is not yet possible, then the kernel memory regions
-	 * may not be set up yet, and the variables not initialized.  So,
-	 * free is called.
+	 * If kmalloc is not yet possible, then either high_physmem and/or
+	 * end_vm are still 0 (as at startup), in which case we call free, or
+	 * we have set them, but anyway addr has not been allocated from those
+	 * areas. So, in both cases __real_free is called.
 	 *
 	 * CAN_KMALLOC is checked because it would be bad to free a buffer
 	 * with kmalloc/vmalloc after they have been turned off during
 	 * shutdown.
+	 * XXX: However, we sometimes shutdown CAN_KMALLOC temporarily, so
+	 * there is a possibility for memory leaks.
 	 */
 
 	if((addr >= uml_physmem) && (addr < high_physmem)){
_
