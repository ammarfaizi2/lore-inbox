Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWESUNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWESUNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWESUNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:13:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964806AbWESUNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:13:51 -0400
Message-ID: <446E26CE.6050409@redhat.com>
Date: Fri, 19 May 2006 16:13:02 -0400
From: Satoshi Oshima <soshima@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <sugita@sdl.hitachi.co.jp>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Subject: [Patch] Kprobes: bugfix of kprobe-booster: reenable kprobe-booster
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I found a bug of kprobes in i386.

Kprobe-booster doesn't work if CONFIG_PREEMPT is not set.
Because pre_preempt_count is always 0.

Boostability have been disabled when removing '#ifdef 
CONFIG_PREEMPT' I think.

This bug doesn't cause a kernel panic.

Regards,

Satoshi Oshima

Signed-off-by: Satoshi Oshima <soshima@redhat.com>

diff -Narup linux-2.6.17-rc3-mm1.orig/arch/i386/kernel/kprobes.c kprobes-i386-bugfix/arch/i386/kernel/kprobes.c
--- linux-2.6.17-rc3-mm1.orig/arch/i386/kernel/kprobes.c	2006-05-04 12:34:46.000000000 -0400
+++ kprobes-i386-bugfix/arch/i386/kernel/kprobes.c	2006-05-12 15:41:23.000000000 -0400
@@ -257,7 +257,11 @@ static int __kprobes kprobe_handler(stru
 	int ret = 0;
 	kprobe_opcode_t *addr;
 	struct kprobe_ctlblk *kcb;
+#ifdef CONFIG_PREEMPT
 	unsigned pre_preempt_count = preempt_count();
+#else
+	unsigned pre_preempt_count = 1;
+#endif
 
 	addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
 

