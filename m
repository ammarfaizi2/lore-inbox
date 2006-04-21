Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWDUHDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWDUHDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWDUHDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:03:32 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:65114 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751154AbWDUHDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:03:31 -0400
Date: Fri, 21 Apr 2006 00:03:31 -0700
Message-Id: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: kfree(NULL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I included a patch , not like it's needed . Recently I've been
evaluating likely/unlikely branch prediction .. One thing that I found 
is that the kfree function is often called with a NULL "objp" . In fact
it's so frequent that the "unlikely" branch predictor should be inverted!
Or at least on my configuration. 

Here are some examples of the warnings that I observed ..

printk: 66 messages suppressed.
BUG: warning at mm/slab.c:3384/kfree()
 <c01043d3> show_trace+0x13/0x20   <c01043fe> dump_stack+0x1e/0x20
 <c015e334> kfree+0xa4/0xc0   <c032584b> make_request+0x36b/0x670
 <c0210305> generic_make_request+0x175/0x240   <c02107d7> submit_bio+0x57/0x100
 <c01648f6> submit_bh+0x106/0x160   <c0165a62> __block_write_full_page+0x222/0x3f0
 <c0165d28> block_write_full_page+0xf8/0x100   <c016a4b1> blkdev_writepage+0x21/0x30
 <c0188c1e> mpage_writepages+0x1ae/0x3d0   <c016a46e> generic_writepages+0x1e/0x20
 <c0148f9d> do_writepages+0x2d/0x50   <c0186b70> __writeback_single_inode+0xa0/0x400
 <c018716b> sync_sb_inodes+0x1bb/0x2a0   <c01877bf> writeback_inodes+0xaf/0xe5
 <c0148d53> wb_kupdate+0x83/0x100   <c0149ab2> pdflush+0x102/0x1c0
 <c0131fa4> kthread+0xc4/0xf0   <c0100ed5> kernel_thread_helper+0x5/0x10
printk: 157 messages suppressed.
BUG: warning at mm/slab.c:3384/kfree()
 <c01043d3> show_trace+0x13/0x20   <c01043fe> dump_stack+0x1e/0x20
 <c015e334> kfree+0xa4/0xc0   <c0140405> audit_syscall_exit+0x405/0x430
 <c0106a56> do_syscall_trace+0x1d6/0x245   <c010320a> syscall_exit_work+0x16/0x1c


Daniel

Index: linux-2.6.16/mm/slab.c
===================================================================
--- linux-2.6.16.orig/mm/slab.c
+++ linux-2.6.16/mm/slab.c
@@ -3380,8 +3380,10 @@ void kfree(const void *objp)
 	struct kmem_cache *c;
 	unsigned long flags;
 
-	if (unlikely(!objp))
+	if (unlikely(!objp)){
+		WARN_ON(printk_ratelimit());
 		return;
+	}
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
