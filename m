Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759976AbWLEMLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759976AbWLEMLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 07:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759995AbWLEMLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 07:11:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59918 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759976AbWLEMLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 07:11:02 -0500
Date: Tue, 5 Dec 2006 13:09:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] add ignore_loglevel boot option
Message-ID: <20061205120954.GA30154@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=AWL,LONGWORDS autolearn=no SpamAssassin version=3.0.3
	2.3 LONGWORDS              Long string of long words
	-1.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] add ignore_loglevel boot option
From: Ingo Molnar <mingo@elte.hu>

sometimes the kernel prints something interesting while userspace
bootup keeps messages turned off via loglevel. Enable the printing
of /all/ kernel messages via the "ignore_loglevel" boot option.
Off by default.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 Documentation/kernel-parameters.txt |    4 ++++
 kernel/printk.c                     |   14 +++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -657,6 +657,10 @@ and is between 256 and 4096 characters. 
 	idle=		[HW]
 			Format: idle=poll or idle=halt
 
+	ignore_loglevel	[KNL]
+			Ignore loglevel setting - this will print /all/
+			kernel messages to the console. Useful for debugging.
+
 	ihash_entries=	[KNL]
 			Set number of hash buckets for inode cache.
 
Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -352,13 +352,25 @@ static void __call_console_drivers(unsig
 	touch_critical_timing();
 }
 
+static int __read_mostly ignore_loglevel;
+
+int __init ignore_loglevel_setup(char *str)
+{
+	ignore_loglevel = 1;
+	printk(KERN_INFO "debug: ignoring loglevel setting.\n");
+
+	return 1;
+}
+
+__setup("ignore_loglevel", ignore_loglevel_setup);
+
 /*
  * Write out chars from start to end - 1 inclusive
  */
 static void _call_console_drivers(unsigned long start,
 				unsigned long end, int msg_log_level)
 {
-	if (msg_log_level < console_loglevel &&
+	if ((msg_log_level < console_loglevel || ignore_loglevel) &&
 			console_drivers && start != end) {
 		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
 			/* wrapped write */
