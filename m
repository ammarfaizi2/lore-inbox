Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVAIE3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVAIE3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAIE3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:29:45 -0500
Received: from fsmlabs.com ([168.103.115.128]:10883 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262247AbVAIE3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:29:40 -0500
Date: Sat, 8 Jan 2005 21:29:41 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: Notify user of MCE events.
Message-ID: <Pine.LNX.4.61.0501082121380.13639@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 uses a userspace mce utility to decode MCEs, this patch will ensure 
that the user is notified of MCE events being logged too.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-mm1/arch/x86_64/kernel/mce.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm1/arch/x86_64/kernel/mce.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.c
--- linux-2.6.10-mm1/arch/x86_64/kernel/mce.c	4 Jan 2005 04:03:35 -0000	1.1.1.1
+++ linux-2.6.10-mm1/arch/x86_64/kernel/mce.c	9 Jan 2005 03:15:48 -0000
@@ -31,6 +32,8 @@ static int mce_dont_init;
 static int tolerant = 1;
 static int banks;
 static unsigned long bank[NR_BANKS] = { [0 ... NR_BANKS-1] = ~0UL };
+static unsigned long console_logged;
+static int notify_user;
 
 /*
  * Lockless MCE logging infrastructure.
@@ -68,6 +71,9 @@ void mce_log(struct mce *mce)
 	smp_wmb();
 	mcelog.entry[entry].finished = 1;
 	smp_wmb();
+
+	if (!test_and_set_bit(0, &console_logged))
+		notify_user = 1;
 }
 
 static void print_mce(struct mce *m)
@@ -252,6 +258,12 @@ static void mcheck_timer(void *data)
 {
 	on_each_cpu(mcheck_check_cpu, NULL, 1, 1);
 	schedule_delayed_work(&mcheck_work, check_interval * HZ);
+
+	if (notify_user && console_logged) {
+		notify_user = 0;
+		clear_bit(0, &console_logged);
+		printk(KERN_EMERG "Machine check exception logged, run mcelog\n");
+	}
 }
 
 
 
 
