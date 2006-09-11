Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWIKDHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWIKDHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 23:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWIKDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 23:07:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751102AbWIKDH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 23:07:29 -0400
Date: Sun, 10 Sep 2006 23:07:21 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: Split multi-line printk in oops output.
Message-ID: <20060911030721.GA4733@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, bug reports come in where we've had an oops, and the
only record we have is what the reporter saw on screen shortly
before the system locked up completely.  Unfortunatly, syslog
only prints lines beginning with KERN_EMERG to the console, so
some lines get lost.
An example of this can be seen at https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203723

Some of this information isn't vital to diagnosis, but some parts
are useful, such as the tainted flag.

Signed-off-by: Dave Jones <davej@redhat.com>

--- local-git/arch/i386/kernel/traps.c~	2006-09-10 23:01:18.000000000 -0400
+++ local-git/arch/i386/kernel/traps.c	2006-09-10 23:03:33.000000000 -0400
@@ -291,10 +291,11 @@ void show_registers(struct pt_regs *regs
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
-	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
-			"EFLAGS: %08lx   (%s %.*s) \n",
-		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-		print_tainted(), regs->eflags, system_utsname.release,
+	printk(KERN_EMERG "CPU:    %d\n", smp_processor_id());
+	printk(KERN_EMERG "EIP:    %04x:[<%08lx>]    %s VLI\n",
+		0xffff & regs->xcs, regs->eip, print_tainted());
+	printk(KERN_EMERG "EFLAGS: %08lx   (%s %.*s)\n",
+		regs->eflags, system_utsname.release,
 		(int)strcspn(system_utsname.version, " "),
 		system_utsname.version);
 	print_symbol(KERN_EMERG "EIP is at %s\n", regs->eip);

-- 
http://www.codemonkey.org.uk
