Return-Path: <linux-kernel-owner+w=401wt.eu-S1030319AbWL3TqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWL3TqQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWL3TqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:46:15 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:49301 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030319AbWL3TqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:46:15 -0500
Date: Sat, 30 Dec 2006 20:46:07 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2.6.20-rc2-git1] start_kernel: Test if irq's got enabled early, barf, and disable them again
Message-ID: <20061230194607.GT912@telegraafnet.nl>
References: <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl> <20061229141058.GM912@telegraafnet.nl> <20061229150132.GN912@telegraafnet.nl> <20061229154251.GR912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229154251.GR912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The calls made by parse_parms to other initialization code might
enable interrupts again way too early.
Having interrupts on this early can make systems PANIC when they
initialize the IRQ controllers (which happens later in the code).
This patch detects that irq's are enabled again, barfs about it
and disables them again as a safety net.

Signed-off-by: Ard van Breemen <ard@telegraafnet.nl>

--- linux-2.6.20-rc2-git1/init/main.c.orig	2006-12-30 17:41:13.000000000 +0000
+++ linux-2.6.20-rc2-git1/init/main.c	2006-12-30 17:44:02.000000000 +0000
@@ -538,6 +538,10 @@ asmlinkage void __init start_kernel(void
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
+	if (!irqs_disabled()) {
+		printk(KERN_WARNING "start_kernel(): bug: interrupts were enabled *very* early, fixing it\n");
+		local_irq_disable();
+	}
 	sort_main_extable();
 	trap_init();
 	rcu_init();
