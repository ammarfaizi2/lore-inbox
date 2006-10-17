Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423027AbWJQE3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423027AbWJQE3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 00:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWJQE3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 00:29:34 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:11446 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1423027AbWJQE3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 00:29:33 -0400
Subject: [PATCH] arch/i386/kernel/cpu/cpufreq/sc520_freq.c: ioremap
	balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: davej@codemonkey.org.uk
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 10:02:55 +0530
Message-Id: <1161059575.20400.30.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/cpu/cpufreq/sc520_freq.c linux-2.6.19-rc1/arch/i386/kernel/cpu/cpufreq/sc520_freq.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/cpu/cpufreq/sc520_freq.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/cpu/cpufreq/sc520_freq.c	2006-10-05 18:25:00.000000000 +0530
@@ -153,6 +153,7 @@ static struct cpufreq_driver sc520_freq_
 static int __init sc520_freq_init(void)
 {
 	struct cpuinfo_x86 *c = cpu_data;
+	int err;
 
 	/* Test if we have the right hardware */
 	if(c->x86_vendor != X86_VENDOR_AMD ||
@@ -166,7 +167,11 @@ static int __init sc520_freq_init(void)
 		return -ENOMEM;
 	}
 
-	return cpufreq_register_driver(&sc520_freq_driver);
+	err = cpufreq_register_driver(&sc520_freq_driver);
+	if (err)
+		iounmap(cpuctl);
+
+	return err;
 }
 
 


