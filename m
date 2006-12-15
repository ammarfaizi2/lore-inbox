Return-Path: <linux-kernel-owner+w=401wt.eu-S1751202AbWLOGxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWLOGxi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 01:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWLOGxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 01:53:03 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47552 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbWLOGwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 01:52:35 -0500
Date: Thu, 14 Dec 2006 22:52:09 -0800
Message-Id: <200612150652.kBF6q9e0025520@zach-dev.vmware.com>
Subject: [PATCH 3/6] IOPL handling for paravirt guests
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 15 Dec 2006 06:52:10.0265 (UTC) FILETIME=[8B0D3890:01C72015]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a clever way to make the extra IOPL switching invisible to
non-paravirt compiles - since kernel_rpl is statically defined to
be zero there, and only non-zero rpl kernel have a problem restoring IOPL,
as popf does not restore IOPL flags unless run at CPL-0.

Subject: IOPL handling for paravirt guests
Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 8110943fd7ad arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Thu Dec 14 16:15:20 2006 -0800
+++ b/arch/i386/kernel/process.c	Thu Dec 14 16:21:57 2006 -0800
@@ -665,6 +665,15 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
+	 * Restore IOPL if needed.  In normal use, the flags restore
+	 * in the switch assembly will handle this.  But if the kernel
+	 * is running virtualized at a non-zero CPL, the popf will
+	 * not restore flags, so it must be done in a separate step.
+	 */
+	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
+		set_iopl_mask(next->iopl);
+
+	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
