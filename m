Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbUKXNKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUKXNKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUKXNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:09:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:44948 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262650AbUKXNBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:49 -0500
Subject: Suspend 2 merge: 17/51: Disable MCE checking during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101295216.5805.256.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a potential SMP deadlock here.

diff -ruN 506-disable-mce-checking-during-suspend-avoid-smp-deadlock-old/arch/i386/kernel/cpu/mcheck/non-fatal.c 506-disable-mce-checking-during-suspend-avoid-smp-deadlock-new/arch/i386/kernel/cpu/mcheck/non-fatal.c
--- 506-disable-mce-checking-during-suspend-avoid-smp-deadlock-old/arch/i386/kernel/cpu/mcheck/non-fatal.c	2004-11-03 21:51:31.000000000 +1100
+++ 506-disable-mce-checking-during-suspend-avoid-smp-deadlock-new/arch/i386/kernel/cpu/mcheck/non-fatal.c	2004-11-04 16:27:40.000000000 +1100
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -57,7 +58,8 @@
 
 static void mce_work_fn(void *data)
 { 
-	on_each_cpu(mce_checkregs, NULL, 1, 1);
+	if (!test_suspend_state(SUSPEND_RUNNING))
+		on_each_cpu(mce_checkregs, NULL, 1, 1);
 	schedule_delayed_work(&mce_work, MCE_RATE);
 } 
 


