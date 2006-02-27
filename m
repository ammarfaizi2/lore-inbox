Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWB0FEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWB0FEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 00:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWB0FEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 00:04:32 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:12195 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751183AbWB0FEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 00:04:32 -0500
Date: Mon, 27 Feb 2006 16:03:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: marcelo.tosatti@cyclades.com
Cc: paulus@samba.org, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Signal hadnling fix for 2.4
Message-Id: <20060227160337.65610906.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

While investigating a bug report about a 64bit application that crashed in
malloc, Paul Mackerras noticed that sys_rt_sigreturn's return value was
"int".  It needs to be "long" or else the return value of a syscall that
is interrupted by a signal will be truncated to 32 bits and then sign
extended.  This causes .e.g mmap's return value to be corrupted if it is
returning an address above 2^31 (which is what caused a SEGV in malloc).
This problem obviously only affects 64 bit processes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

Please apply for 2.4.33, this patch is against 2.4.33-pre2.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linux/arch/ppc64/kernel/signal.c linux-sfr/arch/ppc64/kernel/signal.c
--- linux/arch/ppc64/kernel/signal.c	2006-02-24 17:37:08.000000000 +1100
+++ linux-sfr/arch/ppc64/kernel/signal.c	2006-02-27 11:05:07.000000000 +1100
@@ -332,7 +332,7 @@
 }
 
 
-asmlinkage int
+asmlinkage long
 sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 		 unsigned long r6, unsigned long r7, unsigned long r8,
 		 struct pt_regs *regs)
