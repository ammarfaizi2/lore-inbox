Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWD0Rzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWD0Rzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWD0Rzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:55:54 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:8375 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965013AbWD0Rzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:55:53 -0400
Date: Thu, 27 Apr 2006 12:55:51 -0500
From: Corey Minyard <minyard@acm.org>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: add nmi_exit to die_nmi
Message-ID: <20060427175551.GA22941@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with NMI watchdog on x86_64, I discovered that it didn't
do what I expected.  It always panic-ed, even when it didn't
happen from interrupt context.  This patch solves that
problem for me.  Also, in this case, do_exit() will be called
with interrupts disabled, I believe.  Would it be wise to also
call local_irq_enable() after nmi_exit()?

Currently, on x86_64, any NMI watchdog timeout will cause a panic
because the irq count will always be set to be in an interrupt
when do_exit() is called from die_nmi().  If we add nmi_exit() to 
the die_nmi() call (since the nmi will never exit "normally")
it seems to solve this problem.  The following small program
can be used to trigger the NMI watchdog to reproduce this:
  main ()
  {
        iopl(3);
        for (;;) asm("cli");
  }

diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 0ebb281..872ddfc 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -472,6 +472,7 @@ void __kprobes die_nmi(char *str, struct
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
 	oops_end(flags);
+	nmi_exit();
 	do_exit(SIGSEGV);
 }
 
