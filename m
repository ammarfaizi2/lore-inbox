Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVAJLUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVAJLUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVAJLUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:20:30 -0500
Received: from ozlabs.org ([203.10.76.45]:6040 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262206AbVAJLUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:20:23 -0500
Date: Mon, 10 Jan 2005 22:19:37 +1100
From: Anton Blanchard <anton@samba.org>
To: ananth@in.ibm.com, akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: kprobes breaks BUG() handling
Message-ID: <20050110111937.GN14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was running some tests and noticed BUG() handling wasnt working as
expected. The kprobes code has some code to check for breakpoint
removal races and only checks for one opcode. It turns out there are
many forms of the breakpoint instruction, comparing against one is not
good enough.

For the momemt remove the code in question so BUG()s work again and we
can discuss a better solution (I thought kprobes was emulating
instructions or running them out of line).

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/kprobes.c~fix_breakage arch/ppc64/kernel/kprobes.c
--- foobar2/arch/ppc64/kernel/kprobes.c~fix_breakage	2005-01-10 21:41:43.157624895 +1100
+++ foobar2-anton/arch/ppc64/kernel/kprobes.c	2005-01-10 21:42:04.560169990 +1100
@@ -99,6 +99,7 @@ static inline int kprobe_handler(struct 
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
+#if 0
 		if (*addr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * The breakpoint instruction was removed right
@@ -109,6 +110,7 @@ static inline int kprobe_handler(struct 
 			 */
 			ret = 1;
 		}
+#endif
 		/* Not one of ours: let kernel handle it */
 		goto no_kprobe;
 	}
_
