Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269398AbUJLAXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269398AbUJLAXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUJLAWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:22:51 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:25219
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269400AbUJLATI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:08 -0400
Subject: [patch 10/10] uml: use always a separate io thread for UBD
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:18:06 +0200
Message-Id: <20041012001806.72C46888B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, ubd=sync is different from replacing ubd#= with ubd#s=. This is
against Principle of Least Surprise, so remove this difference.

Also the current ubd=sync behaviour is completely useless: it is to make sure
that when the kernel has synched its I/O to the virtual disk, the host does
not invalidate this with his caching; this causes ReiserFS corruption.

But since actually we call end_request() only after the io_thread has done its
work, we never lie to the block layer. Using O_SYNC as we do when replacing
ubd#= with ubd#s= is enough.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-use-always-io-thread arch/um/drivers/ubd_kern.c
--- linux-2.6.9-current/arch/um/drivers/ubd_kern.c~uml-use-always-io-thread	2004-10-12 01:22:17.061952232 +0200
+++ linux-2.6.9-current-paolo/arch/um/drivers/ubd_kern.c	2004-10-12 01:22:17.064951776 +0200
@@ -773,9 +773,11 @@ int ubd_driver_init(void){
 	unsigned long stack;
 	int err;
 
+	/* Set by CONFIG_BLK_DEV_UBD_SYNC or ubd=sync.*/
 	if(global_openflags.s){
-		printk(KERN_INFO "ubd : Synchronous mode\n");
-		return(0);
+		printk(KERN_INFO "ubd: Synchronous mode\n");
+		/* Letting ubd=sync be like using ubd#s= instead of ubd#= is
+		 * enough. So use anyway the io thread. */
 	}
 	stack = alloc_stack(0, 0);
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *), 
_
