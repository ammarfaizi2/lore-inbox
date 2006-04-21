Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWDUKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWDUKpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWDUKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:45:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:60890 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932223AbWDUKpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:45:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix spu_callbacks BUILD_BUG_ON
Date: Fri, 21 Apr 2006 12:45:27 +0200
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davem@davemloft.net,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
References: <20060421080239.GC4717@suse.de> <20060421022555.2d460805.akpm@osdl.org> <200604211241.36596.arnd@arndb.de>
In-Reply-To: <200604211241.36596.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211245.27744.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time a new syscall gets added, a BUILD_BUG_ON in
arch/powerpc/platforms/cell/spu_callbacks.c gets triggered.
Since the addition of a new syscall is rather harmless,
the error should just be removed.

While we're here, add sys_tee to the list and add a comment
to systbl.S to remind people that there is another list
on powerpc.

Signed-of-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_callbacks.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -317,17 +317,16 @@ void *spu_syscall_table[] = {
 	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
 	[__NR_unshare]			sys_unshare,
 	[__NR_splice]			sys_splice,
+	[__NR_tee]			sys_tee,
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
 {
 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
 
-	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
-
 	syscall = spu_syscall_table[s->nr_ret];
 
-	if (s->nr_ret >= __NR_syscalls) {
+	if (s->nr_ret >= ARRAY_SIZE(spu_syscall_table)) {
 		pr_debug("%s: invalid syscall #%ld", __FUNCTION__, s->nr_ret);
 		return -ENOSYS;
 	}
Index: linus-2.6/arch/powerpc/kernel/systbl.S
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/systbl.S
+++ linus-2.6/arch/powerpc/kernel/systbl.S
@@ -324,3 +324,8 @@ COMPAT_SYS(ppoll)
 SYSCALL(unshare)
 SYSCALL(splice)
 SYSCALL(tee)
+
+/*
+ * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
+ * as well when appropriate.
+ */
