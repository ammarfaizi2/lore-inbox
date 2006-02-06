Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWBFUCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWBFUCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBFUCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:02:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42119 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932350AbWBFUCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:02:09 -0500
Date: Mon, 6 Feb 2006 21:00:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] x86: print out early faults via early_printk()
Message-ID: <20060206200033.GA13154@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lost a few hours debugging an early-bootup fault within printk itself, 
which manifested itself as a hard to debug early hang.

This patch makes it much easier by printing out early faults via 
early_printk(), which function is alot simpler than a full printk, and 
hence more likely to succeed in emergencies. (We do not recover from 
early faults anyway, so there's no loss from not having these messages 
in the normal printk buffer.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----
 arch/i386/kernel/head.S |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux/arch/i386/kernel/head.S
===================================================================
--- linux.orig/arch/i386/kernel/head.S
+++ linux/arch/i386/kernel/head.S
@@ -398,7 +398,11 @@ ignore_int:
 	pushl 32(%esp)
 	pushl 40(%esp)
 	pushl $int_msg
+#ifdef CONFIG_EARLY_PRINTK
+	call early_printk
+#else
 	call printk
+#endif
 	addl $(5*4),%esp
 	popl %ds
 	popl %es
