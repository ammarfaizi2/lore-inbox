Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWE2ViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWE2ViV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWE2ViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:38:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63698 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751338AbWE2VZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:21 -0400
Date: Mon, 29 May 2006 23:25:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 31/61] lock validator: SMP alternatives workaround
Message-ID: <20060529212541.GE3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

disable SMP alternatives fixups (the patching in of NOPs on 1-CPU
systems) if the lock validator is enabled: there is a binutils
section handling bug that causes corrupted instructions when
UP instructions are patched in.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/i386/kernel/alternative.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux/arch/i386/kernel/alternative.c
===================================================================
--- linux.orig/arch/i386/kernel/alternative.c
+++ linux/arch/i386/kernel/alternative.c
@@ -301,6 +301,16 @@ void alternatives_smp_switch(int smp)
 	struct smp_alt_module *mod;
 	unsigned long flags;
 
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * A not yet fixed binutils section handling bug prevents
+	 * alternatives-replacement from working reliably, so turn
+	 * it off:
+	 */
+	printk("lockdep: not fixing up alternatives.\n");
+	return;
+#endif
+
 	if (no_replacement || smp_alt_once)
 		return;
 	BUG_ON(!smp && (num_online_cpus() > 1));
